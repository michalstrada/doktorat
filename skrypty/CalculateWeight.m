function w = CalculateWeight(M, sourceNode, sinkNode)

   Ad = ones(size(M, 1));
   E = CalculateGlobalInconsistencyMatrix(M);

   multiplicator = 1;
   minValue = min(min(E));

   while (minValue*multiplicator < 1)
      multiplicator = multiplicator*10;
   end

   E = multiplicator*E;
   Elog = log(E);

   [djikstraWeights, djikstraRoutes] = dijkstra(Ad, Elog);
   route = djikstraRoutes{sourceNode, sinkNode};
   
   w = 1;
   for r = 1:1:(length(route) - 1);
      w = w*M(route(r), route(r + 1));
   end
end

