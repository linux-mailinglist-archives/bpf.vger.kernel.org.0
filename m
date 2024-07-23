Return-Path: <bpf+bounces-35419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E855593A7FC
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A201C22509
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7981428E8;
	Tue, 23 Jul 2024 20:07:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478313C691
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721765254; cv=none; b=lmKK1B9tnEmaQTmpJHt67YYtal6CoqpHqSA2roELd7Gc3D22oYSifkUhPFH2J6fADOK/bMEY7shpo6E5ZImaFpXo545n9U7P4TkNYdoT40CfrdlGFQYj0u7ZpXPp89BF4Qt3jdeEJUUV90qkfKLjo8hjdMt4A7i9IRusCEQpVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721765254; c=relaxed/simple;
	bh=Zz9HxM78OKwe9Kus8+82Igv6ExRrHbanINUOO44Az5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bor+6310cEfMKo5OYFeDu998PwjIp7qr7LilJfyVe+Pu0gfJcRqjFN94yLP9ftbG20FhBiKF+cSKhiW9IiY8B8KWgZe+tpiep9gh5+/Bd7KZttBJn7mgwe3kWVZbb2y+lPanPKgvUXE6Kux5dqEZVd6UN07w7MpMSOTVKhIAReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d150e8153so157662b3a.0
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721765251; x=1722370051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzyY74PnhN7fBHjcRO7ihHWtVhUllN4kKoPz4iZ6Bbs=;
        b=cIqjxtdQW5xKS0vW/KFHO0vt7M728IoqRegflrGvKAIyGCjDQoPbGTE8gIA1F2nDZg
         V2pPCmQyTq+yjTG4KgxO2afc/UD0vWFu6qBuxG14u0Gm5a1q1OYLreFUAYuRlsVgqiGO
         3j5ZaIN6028FQpf1PmD0S/u/hrw/tv1ipL8CnpEyrifqPpagQcrFQahykBEKWDC3ANsi
         NyNbQ7O9Wf27cjjKlk36zYUNhtcq/KZ0mi42lZGOZikCMVVn5fQpKLY6btiL/SLx30Eg
         U2tR5S+UiCquiGHzneNEhsbBTrbUV3puBOn+ULhWiuHZ5uNsJCVSmlMzEWj15xTiqWif
         3Pfw==
X-Forwarded-Encrypted: i=1; AJvYcCVEq0Zwl/+k5Fvp7P5Ta4q7osB1jX4uMtSppDSQdR3e8HrovgulX1Gs5zREodK9/HtAy8ewOKh27cTOry1cUh7xc+cD
X-Gm-Message-State: AOJu0Ywa5GnndNcRgfpkc9NCj8oRWko3rdGXqu3KsJ+AKFflTtZKvktU
	97nvVCHs3ueLa+wlMUeEhL9EP64RoLhdf7Aaymeyig/rB/FL5AU=
X-Google-Smtp-Source: AGHT+IEYQDxeqKcvddCfW8xwQMer37QBegpXTU2pudlORRk3af/nHTWIhVWPDjFfevpOg+WFIw5vEw==
X-Received: by 2002:a05:6a20:728b:b0:1c2:8c0c:e60e with SMTP id adf61e73a8af0-1c45214e820mr5611858637.15.1721765250533;
        Tue, 23 Jul 2024 13:07:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a13339a554sm4938548a12.59.2024.07.23.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 13:07:30 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:07:29 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: sdf@mini-arch.smtp.subspace.kernel.org, bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.11
Message-ID: <ZqANgbFHX128IZYV@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Customary stats update.
See Jakub's netdev post for more details on the methodology:
https://lore.kernel.org/netdev/20240722142243.26b9457f@kernel.org/

BPF 6.10 stats: https://lore.kernel.org/bpf/Zkq9uifSQ9R3Xp9W@google.com/

Previous cycle:
12 Mar to 14 May: 5841 mailing list messages, 64 days, 91 messages per day
632 repo commits (10 commits/day)

Current cycle:
15 May to 16 Jul: 5213 mailing list messages, 63 days, 83 messages per day
552 repo commits (9 commits/day)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [5] Alexei Starovoitov       1 (   ) [15] Andrii Nakryiko     
   2 ( -1) [4] Andrii Nakryiko          2 (   ) [12] Alexei Starovoitov  
   3 ( +4) [3] Jiri Olsa                3 (   ) [11] Eduard Zingerman    
   4 ( +2) [3] Eduard Zingerman         4 ( +2) [ 6] Jiri Olsa           
   5 ( +9) [2] Masami Hiramatsu (Google)    5 ( +2) [ 6] Masami Hiramatsu (Google)
   6 ( -1) [2] Daniel Borkmann          6 ( +3) [ 5] Jakub Kicinski      
   7 ( +3) [2] Jakub Kicinski           7 ( -3) [ 5] Martin KaFai Lau    
   8 ( -4) [1] Martin KaFai Lau         8 (+44) [ 4] Paul Moore          
   9 ( -1) [1] John Fastabend           9 ( +1) [ 3] Daniel Borkmann     
  10 ( +3) [1] Quentin Monnet          10 (+12) [ 3] Jason Wang          
  11 ( +7) [1] Alan Maguire            11 (+27) [ 3] Peter Zijlstra      
  12 (+14) [1] Steven Rostedt          12 (+16) [ 3] Pavel Begunkov      
  13 ( +9) [1] Puranjay Mohan          13 (+13) [ 3] Oleg Nesterov       
  14 (+32) [1] Jakub Sitnicki          14 (+11) [ 3] Jakub Sitnicki      
  15 (+16) [1] Peter Zijlstra          15 ( -7) [ 3] John Fastabend      

Top authors (cs):                    Top authors (msg):                  
   1 ( +2) [2] Geliang Tang             1 ( +1) [31] Geliang Tang        
   2 ( -1) [2] Andrii Nakryiko          2 ( +1) [14] Andrii Nakryiko     
   3 ( +5) [1] Alan Maguire             3 (+13) [11] Mina Almasry        
   4 (+17) [1] Jiri Olsa                4 (+10) [11] Xuan Zhuo           
   5 ( +1) [1] Yonghong Song            5 (   ) [10] Benjamin Tissoires  
   6 ( +4) [1] Alexei Starovoitov       6 (***) [ 9] Steven Rostedt      
   7 ( -2) [1] Dave Thaler              7 ( -6) [ 8] Edward Liaw         
   8 (+43) [1] Matt Bobrowski           8 ( +4) [ 7] Jiri Olsa           
   9 ( -7) [1] Puranjay Mohan           9 ( -3) [ 7] Kui-Feng Lee        
  10 (***) [1] Daniel Borkmann         10 ( +3) [ 6] Alan Maguire        

Top scores (positive):               Top scores (negative):              
   1 (   ) [82] Alexei Starovoitov      1 ( +1) [122] Geliang Tang       
   2 ( +2) [49] Eduard Zingerman        2 ( +8) [ 45] Mina Almasry       
   3 ( +5) [33] Jakub Kicinski          3 ( +5) [ 45] Xuan Zhuo          
   4 ( -1) [33] Martin KaFai Lau        4 (   ) [ 36] Benjamin Tissoires 
   5 ( -3) [27] Andrii Nakryiko         5 ( -4) [ 31] Edward Liaw        
   6 ( +4) [25] Jiri Olsa               6 ( -1) [ 24] Kui-Feng Lee       
   7 ( +4) [17] Quentin Monnet          7 (+23) [ 20] Yafang Shao        
   8 ( -1) [16] John Fastabend          8 (***) [ 19] Steven Rostedt     
   9 (***) [15] Masami Hiramatsu (Google)    9 ( +6) [ 17] Tejun Heo          
  10 (+25) [14] Paul Moore             10 (***) [ 17] Ilya Leoshkevich   

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [11] Meta                    1 (   ) [42] Meta                
   2 (   ) [ 7] Isovalent               2 ( +2) [14] RedHat              
   3 (   ) [ 4] Google                  3 (   ) [14] Isovalent           
   4 (   ) [ 3] RedHat                  4 ( -2) [13] Google              
   5 (   ) [ 3] Intel                   5 (   ) [ 7] Intel               
   6 (   ) [ 2] Oracle                  6 ( +5) [ 4] Linux Foundation    
   7 ( +6) [ 1] Linux Foundation        7 (+15) [ 4] Microsoft           

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [6] Meta                     1 (   ) [44] Meta                
   2 (   ) [3] Intel                    2 (   ) [44] Google              
   3 ( +2) [3] Google                   3 ( +1) [31] Suse                
   4 ( +3) [2] Suse                     4 ( -1) [14] RedHat              
   5 ( +4) [2] Huawei                   5 ( +2) [12] Isovalent           
   6 ( +2) [2] Isovalent                6 ( +5) [11] Alibaba             
   7 ( -4) [2] Oracle                   7 ( +1) [11] Huawei              

Top scores (positive):               Top scores (negative):              
   1 (   ) [69] Meta                    1 ( +1) [122] Suse               
   2 (   ) [62] Isovalent               2 ( -1) [104] Google             
   3 ( +2) [26] Linux Foundation        3 ( +2) [ 43] Alibaba            
   4 ( +6) [24] Intel                   4 ( +4) [ 34] Huawei             
   5 (+14) [17] RedHat                  5 (+10) [ 20] Juniper Networks   
   6 (+20) [14] CloudFlare              6 ( +4) [ 16] NXP                
   7 ( +7) [14] Microsoft               7 (***) [ 14] Bytedance          

More raw stats
--------------

Prev: start: Mon, 11 Mar 2024 22:22:26 -0700
	end: Tue, 14 May 2024 18:44:33 -0700
Prev: messages: 5831 days: 64 (91 msg/day)
Prev: direct commits: 347 (5 commits/day)
Prev: test commits: 164 (47.26%)
Prev: people/aliases: 320  {'author': 101, 'commenter': 160, 'both': 59}
Prev: review pct: 18.16%  x-corp pct: 16.71%

Curr: start: Wed, 15 May 2024 04:15:15 +0800
	end: Tue, 16 Jul 2024 11:15:18 -0700
Curr: messages: 5213 days: 63 (83 msg/day)
Curr: direct commits: 552 (9 commits/day)
Curr: test commits: 262 (47.46%)
Curr: people/aliases: 320  {'author': 111, 'commenter': 151, 'both': 58}
Curr: review pct: 17.75%  x-corp pct: 14.49%

Diff: -9.2% msg/day
Diff: +61.6% commits/day
Diff: +1.6% people/day
Diff: review pct: -0.4%
      x-corp pct: -2.2%

