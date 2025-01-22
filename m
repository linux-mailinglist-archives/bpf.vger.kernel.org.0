Return-Path: <bpf+bounces-49500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB99A19772
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C195165E34
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29808215173;
	Wed, 22 Jan 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4vs3FCr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89516F8F5
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566556; cv=none; b=eJxuFxBP/+xr5tcYqJJ71Dz0AajwWUaK0vtbwmTBotacn9NRwg0+ybfzXJelvy78vFiEKT32yyugYMOMNN4rGCCej+Ay4/a2TbJLIoticsrmE/O6qEnq+zvs7Gjgu14uNBBZcrpDR7FRM7zv0wDSIwi4Osi5SzTjlycUwyYgTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566556; c=relaxed/simple;
	bh=BAsS7reSLnrvd0C28lS72NU7xSRfvrZMyQQVwbeP44I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DwsPa/za2Q5B/R3A7/jME1ZC+I0hF+USWQU+lgfV/nZ4geVFPtrQjflPVWsXSLwyND34cPGEBnHOAztl6/psPcNf6thmsIXV4VLQUlLe/fH7hQFkXZQZt81XHgqfRoGOuo9Z+3wHOXlW7QrUf4IcMKfCR6v4dIPMRbeIb8EYKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4vs3FCr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21628b3fe7dso127556435ad.3
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737566554; x=1738171354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK3bZMsDLQPi1hRLQ8IwlbhD0Y/Bt0GoQeFDwKTld/o=;
        b=J4vs3FCroyK0RqIXz626oChKwoAjS8DBG2vID9Spaq6DoTw0HTGjXD6Fk0IjJG8lgM
         o88zhJhvES4/ZuLs4y7ocdRiUtHF02FJeMWSrBGazvqdgaTwiKGykfIhIiFVjqTzqkfC
         DgSWNmq/m5lNlKzlG02eONwDWXj7fgOadmr34h+MQwGONevl+B2t8B8whixTzIb7UCBa
         GzmXosoq7/9HOWkmAdOrj0KI4o+V1UtDSm/pMpWWRSu6P/aqIsUDeHazNrWRh19S/Ba9
         K2RM8Fog4vwVwuYKmK/SP6lHDzr0CTVcfde34DLJnnNxjhB6jGuvIRNOo8gHHgx33jhD
         mjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737566554; x=1738171354;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK3bZMsDLQPi1hRLQ8IwlbhD0Y/Bt0GoQeFDwKTld/o=;
        b=eeToBDVq2kWd/PAfjLRzSoURTl64Ij4q/ktjF8oOa+zwREtiaZ6FxMhpcrMEULpdiQ
         +fu2xEqnlrqhFLA+FYrdFXAHO6aXzq8ol1DnoNXSHkS2copf9NuUN9o7DmG5ay0OuHlk
         8kf5OSFvomxKcn/E4kuHMO5l0HJZBN/hV+LYT2dByWSFT7guSiJJofc1iL8yicrf/QDg
         iCHQcHLkr0wjx7OUPVbbmVbj0/lE/g8StPhjAHhVxV741s/ImXTt33RAL1vGvpc7d4fi
         OpVFoXdH5K9XP3+1ujkG58zYsxfuEBNssWH9SpjIUWdle/HkC9RqZzJzDS7mhH4lwlA6
         Pa0Q==
X-Gm-Message-State: AOJu0YxGk5oPZuoLhAF4DHpgSKuxh7abCkTdqBw3uvQuaqREZnGS/aYV
	rc5LYGb+CJI2mHvzPxPLMHMU8ynHvY2lbZLTDdNYsNkDM1Se9eIJo2iv
X-Gm-Gg: ASbGncv9TGrFslG5ISfq+RWZcxqxMGwdOByBquOPx4wCByuBXMS381oMYxh8pD2bEu2
	J5jyQNVk2a/wtIBwFL16iSv145+nH36Dm8QByMkGtke76ERvSWwgRs8JH8lPbCj57EozjGi+POV
	ZB1FAa/ohefxtwYOM19OazBe/r+o+Ri25uW4gk0ZGAgezQJ7Jgs9XLkNScMjHPDWVfycITWwyA+
	wkxrGcWPf2JHJ5DWZPss5TzyKfB45uZ1iHFah1AadaTPHIFjlw+Q4aiiRDwvguNj8XNSw==
X-Google-Smtp-Source: AGHT+IGQJ2+y3tIrSzei8apOOR6x80jG9ucZnbcbGlvQSqpcCWUl93Uzd2nciz+ok5xWzuzLX7oOEA==
X-Received: by 2002:a17:903:11cd:b0:215:b5c6:9ee8 with SMTP id d9443c01a7336-21c351d3065mr292712635ad.7.1737566553959;
        Wed, 22 Jan 2025 09:22:33 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea2e29sm97667385ad.38.2025.01.22.09.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:22:33 -0800 (PST)
Date: Wed, 22 Jan 2025 09:22:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.14
Message-ID: <Z5EpWMev1CIAQjpT@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Regular development statistics update, similar Jakub's netdev post:
https://lore.kernel.org/netdev/20250121200710.19126f7d@kernel.org/

Previous cycle:
19 Sep to 19 Nov: 5097 mailing list messages, 61 days, 84 messages per day
260 repo commits (4 commits/day, 56.92% of these are selftests)
https://lore.kernel.org/bpf/Zz4FDv5bnghUlJQP@mini-arch/

Current cycle:
19 Nov to 21 Jan: 4189 mailing list messages, 63 days, 66 messages per day
378 repo commits (6 commits/day, 42.86% of these are selftests)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [6] Alexei Starovoitov       1 ( +1) [15] Andrii Nakryiko     
   2 ( -1) [5] Andrii Nakryiko          2 ( -1) [14] Alexei Starovoitov  
   3 ( +4) [3] Jiri Olsa                3 ( +1) [11] Eduard Zingerman    
   4 ( +2) [2] Eduard Zingerman         4 ( -1) [ 8] Martin KaFai Lau    
   5 (   ) [2] Daniel Borkmann          5 (   ) [ 7] Jiri Olsa           
   6 ( +2) [2] Jakub Kicinski           6 ( +8) [ 5] Peter Zijlstra      
   7 (+14) [1] Arnaldo Carvalho de Melo    7 (+14) [ 4] Arnaldo Carvalho de Melo
   8 ( +2) [1] Peter Zijlstra           8 (+20) [ 3] Quentin Monnet      
   9 ( +4) [1] Stanislav Fomichev       9 (+27) [ 3] Oleg Nesterov       
  10 ( +5) [1] Quentin Monnet          10 ( +6) [ 3] Jakub Kicinski      
  11 ( -8) [1] Martin KaFai Lau        11 ( -3) [ 3] Toke Høiland-Jørgensen
  12 ( -8) [1] Yonghong Song           12 ( -1) [ 3] Daniel Borkmann     
  13 ( +3) [1] Steven Rostedt          13 (+14) [ 3] Namhyung Kim        
  14 (+10) [1] Alan Maguire            14 ( -4) [ 3] Stanislav Fomichev  
  15 ( -6) [1] Toke Høiland-Jørgensen   15 ( -8) [ 3] Steven Rostedt      

Top authors (cs):                    Top authors (msg):                  
   1 (***) [1] Thomas Weißschuh         1 (+17) [15] Kumar Kartikeya Dwivedi
   2 (***) [1] "Song, Yoong Siang"      2 (+30) [ 9] Charlie Jenkins     
   3 (+28) [1] Ihor Solodrai            3 ( +2) [ 9] Hou Tao             
   4 ( +4) [1] Kumar Kartikeya Dwivedi    4 (   ) [ 7] Masami Hiramatsu (Google)
   5 ( +1) [1] Eduard Zingerman         5 (***) [ 7] Ihor Solodrai       
   6 (***) [1] Daniel Xu                6 ( +8) [ 6] Song Liu            
   7 ( -2) [1] Daniel Borkmann          7 (***) [ 6] Steven Rostedt      
   8 (***) [1] Steven Rostedt           8 ( -5) [ 6] Alexander Lobakin   
   9 ( -8) [1] Andrii Nakryiko          9 (***) [ 5] Daniel Xu           
  10 ( -7) [1] Jiri Olsa               10 (+31) [ 5] Xiao Liang          

Top scores (positive):               Top scores (negative):              
   1 (   ) [97] Alexei Starovoitov      1 (***) [53] Kumar Kartikeya Dwivedi
   2 (   ) [90] Andrii Nakryiko         2 (+19) [38] Charlie Jenkins     
   3 (***) [41] Jiri Olsa               3 ( +6) [30] Hou Tao             
   4 (   ) [40] Eduard Zingerman        4 (***) [27] Ihor Solodrai       
   5 ( -2) [34] Martin KaFai Lau        5 ( -4) [19] Alexander Lobakin   
   6 ( +2) [25] Peter Zijlstra          6 (+24) [19] Xiao Liang          
   7 ( -2) [24] Jakub Kicinski          7 (   ) [19] Jason Xing          
   8 ( +8) [24] Quentin Monnet          8 ( -4) [18] Masami Hiramatsu (Google)
   9 ( +4) [23] Arnaldo Carvalho de Melo    9 (***) [16] Bastien Curutchet   
  10 (   ) [20] Stanislav Fomichev     10 ( +7) [16] Jiayuan Chen        

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [11] Meta                    1 (   ) [40] Meta                
   2 ( +1) [ 5] Isovalent               2 ( +2) [15] RedHat              
   3 ( +1) [ 4] RedHat                  3 ( +2) [12] Isovalent           
   4 ( -2) [ 4] Intel                   4 ( -1) [10] Intel               
   5 (   ) [ 3] Google                  5 ( -3) [ 8] Google              
   6 ( +7) [ 1] Oracle                  6 ( +2) [ 5] SUSE                
   7 ( +5) [ 1] Hedgehog                7 ( +4) [ 4] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [7] Meta                     1 (   ) [47] Meta                
   2 ( +3) [3] Google                   2 ( +2) [20] Google              
   3 ( +5) [2] Intel                    3 ( -1) [11] Huawei              
   4 ( -1) [2] RedHat                   4 ( +1) [10] Intel               
   5 ( -1) [2] Isovalent                5 ( +1) [10] RedHat              
   6 ( -4) [1] Huawei                   6 (+13) [10] Rivos               
   7 (+12) [1] Linutronix               7 (+36) [ 9] Unknown             

Top scores (positive):               Top scores (negative):              
   1 ( +7) [57] Isovalent               1 (+13) [37] Rivos               
   2 ( +1) [35] RedHat                  2 ( -1) [34] Huawei              
   3 ( -2) [34] Meta                    3 (***) [32] Unknown             
   4 ( +5) [24] Hedgehog                4 (***) [31] Google              
   5 (+23) [22] Oracle                  5 ( +3) [21] Bootlin             
   6 ( -1) [20] SUSE                    6 ( +1) [19] Tencent             
   7 ( -5) [19] Intel                   7 ( -1) [14] Bytedance           

More raw stats
--------------

Prev: start: Thu, 19 Sep 2024 23:04:43 +0200
	end: Tue, 19 Nov 2024 16:34:56 +0100
Prev: messages: 5097 days: 61 (84 msg/day)
Prev: direct commits: 260 (4 commits/day)
Prev: test commits: 148 (56.92%)
Prev: people/aliases: 315  {'author': 124, 'commenter': 138, 'both': 53}
Prev: review pct: 30.38%  x-corp pct: 27.69%

Curr: start: Tue, 19 Nov 2024 17:53:58 +0000
	end: Tue, 21 Jan 2025 18:00:07 +0100
Curr: messages: 4189 days: 63 (66 msg/day)
Curr: direct commits: 378 (6 commits/day)
Curr: test commits: 162 (42.86%)
Curr: people/aliases: 260  {'author': 86, 'commenter': 118, 'both': 56}
Curr: review pct: 23.54%  x-corp pct: 19.31%

Diff: -20.4% msg/day
Diff: +40.8% commits/day
Diff: -20.1% people/day
Diff: review pct: -6.8%
      x-corp pct: -8.4%

Contributions to selftests:
   1 [ 25] Alexis Lothoré
   2 [ 18] Kumar Kartikeya Dwivedi
   3 [ 14] Eduard Zingerman
   4 [ 12] Jiri Olsa
   5 [  8] Zijian Zhang
   6 [  6] Ihor Solodrai
   7 [  6] Hou Tao
   8 [  5] Mykyta Yatsenko
   9 [  4] Andrii Nakryiko
  10 [  4] Martin KaFai Lau

