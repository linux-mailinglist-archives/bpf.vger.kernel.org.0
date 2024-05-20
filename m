Return-Path: <bpf+bounces-30018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C368C9823
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 05:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F00B2827C4
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6DDDDA;
	Mon, 20 May 2024 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJPZ+fs/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24639D52F
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716174270; cv=none; b=WGlCMb9uED7vfStvBeO1oN0VRwamVXY41MfUPim/rkuyJIlhVDRhUu/P2PZRYqIeYY6KJQwoghDIW8ZvmOBxxU2lllihW0IqdFpBQO2gpgHeahTsf7seprpWFBjmzf7Rre1mvqQkpv1389bSSRghlbf9pZJGiUKDrNoMl0oR9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716174270; c=relaxed/simple;
	bh=wjAv8+ohMqoJwri7GhA5EDNuaDlea2q73CThdVmfos4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sn+hBruUv2Ragt6e0prLWHSfoWaqmzP1mZ2KVHqDIWNS0P88b1ggETzQK53orAoh2z0YJrRkmKboedtu6MrMee4ML/lT4eLYMtMe9rcozraIC8gCfYDdH7gv9ciQ0SKUCXr8ADj+tpqyODK9wimXckxEB99SGfgBESPCxcoieyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJPZ+fs/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec896dae3cso114377835ad.0
        for <bpf@vger.kernel.org>; Sun, 19 May 2024 20:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716174268; x=1716779068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dtb8RJmBCS/dNtE4zbJQ+VjAWESsuE5pIfeTCax/Y+Y=;
        b=kJPZ+fs/UCOsut03jOwQ5fLeMMXNF8ThSTTGy1kJ6V6SPxWt3plQoR5xvS3c6f555S
         rbRpMpu/tIAIakua+Cz02Au0n3i6B6ygCTlpdnfyZ3CxIAngt8rO4oYVbqLaoj3viRl/
         q9f3bneHEu+lyzmsbsPHlkET4jog50xXhENKBpYYK/uYd6gjk6CA7UroxGjR2x6WBFcw
         Zrl3wePn/EPxInPgLDBBSzv2MAqrMvPVH/OU1RbfJHOdfGimq6ethko3c8JjwYeTligF
         GwaKDWPfk5vuoBAxUOlmKVVC/IfMmnDqyQ7RPrjXQ7z0zmc4VBaVrWesaCzdmuDPwcb2
         /89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716174268; x=1716779068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtb8RJmBCS/dNtE4zbJQ+VjAWESsuE5pIfeTCax/Y+Y=;
        b=Kfm9EVSpIclp/QGU1oDgTnIQtGMDu7EknCYMzmaIlmJdcjtGZCAyflgE707HKtlJOR
         bgTfd/bmWyzHZDmV+C64CsGJTzrfw7VFYgau0ZsdA7kliDd96dSkjMvqdq+GrfHlhn5z
         +XmQRY9zXo7Av7N1C2XKOPa+8ycLisEtHUGAWxJUoADXiHbhMPcUSA4qRUN3wIK7ot3c
         eJJkQMQGwt7EWmKq0GXrSTec/tX0BbTEspmLtPXFM5Ch5S83kOPiKc4FLTXg+A9xiFSx
         Q1GleDRN0EgZ5iLWJm2aX7CI9DcjA2Rqzfm9GfDNLD7+rIEUbwV5CNOYFcNtt/LkZnsG
         t3nQ==
X-Gm-Message-State: AOJu0Yy98Hf8YPAROCctRIAISaLeYtBpn7VE4JIzMNT/DFa1w+h4TC2B
	NODtUmUKMzdedAkCorpaK2lHJz7rkZB68rn/LM7dmqdRaiTIomom6r0I21Jy+7UaZTzUW8DAzYn
	Ss+oWitbmDXd97aSjnVoKyry9PDS3smdkeY/94wapcE+QL5PQa+Egrr3uVXpEPLF0q1AM/adReN
	ESBMVDjydDgbU3
X-Google-Smtp-Source: AGHT+IF/lCAVgQ9UaMEeuyaNr0DrYahEF50OG2vHnNzB9VYx9e9R05j8UrYzrDOkKklm/4ryQrioRo8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d50d:b0:1ec:2c80:8041 with SMTP id
 d9443c01a7336-1ef43f522c8mr9964455ad.13.1716174268185; Sun, 19 May 2024
 20:04:28 -0700 (PDT)
Date: Sun, 19 May 2024 20:04:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <Zkq9uifSQ9R3Xp9W@google.com>
Subject: [ANN] bpf development stats for 6.10
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Content-Type: text/plain; charset="utf-8"

Another kernel release, another opportunity to collect the stats :-)
See Jakub's netdev post for more details on the methodology:
https://lore.kernel.org/netdev/20240515122552.34af8692@kernel.org/T/#u

BPF 6.9 stats: https://lore.kernel.org/bpf/ZfIW5n6qBzPITavK@google.com/

Previous cycle:
9 Jan to 11 Mar: 4536 mailing list messages, 62 days, 73 messages per day
602 repo commits (10 commits/day)

Current cycle:
12 Mar to 14 May: 5841 mailing list messages, 64 days, 91 messages per day
632 repo commits (10 commits/day)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [8] Andrii Nakryiko          1 (   ) [27] Andrii Nakryiko     
   2 ( +1) [7] Alexei Starovoitov       2 ( +1) [21] Alexei Starovoitov  
   3 ( -2) [4] Yonghong Song            3 ( +1) [13] Eduard Zingerman    
   4 ( +1) [3] Martin KaFai Lau         4 ( +1) [11] Martin KaFai Lau    
   5 ( +2) [3] Daniel Borkmann          5 ( -3) [ 9] Yonghong Song       
   6 ( +2) [2] Eduard Zingerman         6 ( +1) [ 6] Jiri Olsa           
   7 ( -3) [2] Jiri Olsa                7 (+39) [ 5] Masami Hiramatsu (Google)
   8 ( +2) [2] John Fastabend           8 ( +4) [ 4] John Fastabend      
   9 ( +6) [2] Stanislav Fomichev       9 ( +2) [ 4] Jakub Kicinski      
  10 ( -1) [2] Jakub Kicinski          10 ( -2) [ 4] Daniel Borkmann     
  11 (+10) [1] Arnaldo Carvalho de Melo   11 (+26) [ 3] Arnaldo Carvalho de Melo
  12 ( -6) [1] David Vernet            12 ( -6) [ 3] David Vernet        
  13 (***) [1] Quentin Monnet          13 ( +7) [ 3] Stanislav Fomichev  
  14 (+29) [1] Masami Hiramatsu (Google)   14 (+45) [ 3] Willem de Bruijn    
  15 (+13) [1] Kumar Kartikeya Dwivedi   15 (***) [ 2] Quentin Monnet      

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [4] Andrii Nakryiko          1 (***) [16] Edward Liaw         
   2 (***) [3] Puranjay Mohan           2 (+23) [15] Geliang Tang        
   3 (+35) [2] Geliang Tang             3 ( +1) [15] Andrii Nakryiko     
   4 (   ) [2] "Jose E. Marchesi"       4 (***) [14] Mike Rapoport       
   5 (***) [1] Dave Thaler              5 ( +3) [10] Benjamin Tissoires  
   6 ( -3) [1] Yonghong Song            6 ( -5) [10] Kui-Feng Lee        
   7 (***) [1] Cupertino Miranda        7 (***) [ 9] Puranjay Mohan      
   8 (+45) [1] Alan Maguire             8 ( -5) [ 8] Masami Hiramatsu (Google)
   9 (+16) [1] Benjamin Tissoires       9 ( +4) [ 7] Yonghong Song       
  10 ( -4) [1] Alexei Starovoitov      10 ( -1) [ 7] Jamal Hadi Salim    

Top scores (positive):               Top scores (negative):              
   1 ( +4) [130] Alexei Starovoitov     1 (***) [64] Edward Liaw         
   2 (   ) [101] Andrii Nakryiko        2 (+15) [60] Geliang Tang        
   3 (   ) [ 64] Martin KaFai Lau       3 (***) [56] Mike Rapoport       
   4 (+11) [ 56] Eduard Zingerman       4 ( +1) [42] Benjamin Tissoires  
   5 ( -4) [ 43] Yonghong Song          5 ( -2) [35] Kui-Feng Lee        
   6 ( +1) [ 32] Daniel Borkmann        6 ( +2) [29] Jamal Hadi Salim    
   7 (+10) [ 28] John Fastabend         7 (***) [25] Puranjay Mohan      
   8 (   ) [ 25] Jakub Kicinski         8 ( -7) [23] Xuan Zhuo           
   9 ( +4) [ 22] Stanislav Fomichev     9 (***) [22] Breno Leitao        
  10 ( -4) [ 19] Jiri Olsa             10 ( +9) [20] Mina Almasry        

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [18] Meta                    1 (   ) [76] Meta                
   2 (   ) [ 7] Isovalent               2 ( +2) [15] Google              
   3 ( +1) [ 5] Google                  3 (   ) [15] Isovalent           
   4 ( -1) [ 3] RedHat                  4 ( -2) [11] RedHat              
   5 (   ) [ 2] Intel                   5 (   ) [ 8] Intel               
   6 ( +1) [ 1] Oracle                  6 (   ) [ 3] Oracle              
   7 ( -1) [ 1] Huawei                  7 (+11) [ 3] Linaro              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [9] Meta                     1 (   ) [54] Meta                
   2 ( +3) [4] Intel                    2 (   ) [51] Google              
   3 ( +1) [4] Oracle                   3 ( +2) [17] RedHat              
   4 ( +5) [3] Amazon                   4 (***) [15] Suse                
   5 ( -3) [3] Google                   5 (+29) [15] IBM                 
   6 (   ) [3] RedHat                   6 ( +7) [14] Oracle              
   7 (***) [2] Suse                     7 ( -1) [11] Isovalent           

Top scores (positive):               Top scores (negative):              
   1 ( +1) [189] Meta                   1 (   ) [109] Google             
   2 ( -1) [ 75] Isovalent              2 (***) [ 60] Suse               
   3 ( +3) [ 15] ARM                    3 (***) [ 49] IBM                
   4 ( +1) [ 14] Linux Foundation       4 (***) [ 33] Oracle             
   5 (***) [ 13] SUSE                   5 ( -3) [ 29] Alibaba            
   6 ( +5) [ 12] Linaro                 6 (   ) [ 29] Mojatatu           
   7 ( +1) [ 11] Rivos                  7 ( -3) [ 22] Amazon             

More raw stats
--------------

Prev: start: Tue, 09 Jan 2024 19:26:28 -0500
	end: Mon, 11 Mar 2024 17:03:11 -0700
Prev: messages: 4553 days: 62 (73 msg/day)
Prev: direct commits: 376 (6 commits/day)
Prev: people/aliases: 249  {'author': 79, 'commenter': 117, 'both': 53}
Prev: review pct: 43.88%  x-corp pct: 37.23%

Curr: start: Tue, 12 Mar 2024 11:13:50 +0800
	end: Tue, 14 May 2024 18:44:33 -0700
Curr: messages: 5833 days: 64 (91 msg/day)
Curr: direct commits: 632 (10 commits/day)
Curr: test commits: 263 (41.61%)
Curr: people/aliases: 320  {'author': 101, 'commenter': 160, 'both': 59}
Curr: review pct: 20.25%  x-corp pct: 18.51%

Diff: +24.1% msg/day
Diff: +62.8% commits/day
Diff: +24.5% people/day
Diff: review pct: -23.6%
      x-corp pct: -18.7%


