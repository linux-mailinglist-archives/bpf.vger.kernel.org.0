Return-Path: <bpf+bounces-75983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF6CA07C7
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C94300BA3D
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43BD32ED30;
	Wed,  3 Dec 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8HJ4MVr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AB398F8E
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782525; cv=none; b=IiRTjaIVQ4HAAQtbfKk/kAtZ7sDhGzOqLZyYqQGyMluBNYg98BD6koNZnSngKqhw2oZ9wcnAtjy3RZdd71mdpYoSscDdFfyHYkIUeegd+YNdv8Rl/M+rfIb4fGLfio51Fx+Z/2Y5xaVvOlWZHBpbSYde+r98/Q+JA6AueGScWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782525; c=relaxed/simple;
	bh=vRzBU3FBcBlf42RvacwFcLRzgRpoWaHiikrPTzR6Gh4=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e/LoznR//aP8izwPBoMRJdcaw68KMb8+drjMYj7ZS9dZO8Dr8HzmZ9yVWB8lLTqxuSJyx00Zne+WmJ3/woAJrRUyBaA5WizHOumIw2UPAUMvMmavPq04BVN1tPekZSxx06+X0xco+u8G5Nq2yFMZb3GrxwxiS77lID/9BN1VhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8HJ4MVr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo8441906b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764782523; x=1765387323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQk6RHPvIptfwIOdr0Hiib9SwKZpu7aZuxPv9vHATdc=;
        b=F8HJ4MVrZUfuagrWCAvmXQqF7NRlo+dI4L4Ame2POE4cv20ApuyxTNLx4+MwxMn8oV
         lkpen8qwBjMH0KF+RjzM4FnKF7xrufqKt3gIxgIAe9GS2Bo/ndEQRtg9bj4BD/Yosfwy
         p5tn05betQSOqYtTrZ1TZ+ZnW03oiOYUoxbvr3mU+gLlQYuKRC1KjybtoQvOF71uG6EH
         OiGci8ERj54G44PYrYhttFKJVDpXbGqtqGD8eujd6d0U3MfYKMjIqWGJ4ckgSybuL+nJ
         z546G5UxvfozWKIicCvEeLGe+xYMdqODi+zILYuC20aVfVmU3R3bvMRFnwVxnBbSmibo
         HA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764782523; x=1765387323;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQk6RHPvIptfwIOdr0Hiib9SwKZpu7aZuxPv9vHATdc=;
        b=PLva5+yCfPCgMkm7y+9oAuClPlpvNkMrEaCSuTzNyM4mORkNE0HE8ZS8PDP43eTFQI
         +WvL1haBLCM5AVwrZ6MKQ6mcVhoPn1+U9MU1wnPSfLkfi7kafhPIFrU5GVWS1O72HQmu
         B6HwWjEZE6ep4r6kiszFsyTKO0bETxC89Rdb5S3OZ5Exadx41A5JUFbkl7ZC4pMxQkG8
         enBb+g9mpYtxN9ueL8HYsLgIY5Z5YMw8jSExzx0xl7BFZUvSTNHteM2dJLB8Jr5NLACN
         DzYkv/drOZLWMqxa1QZqXwrUr58GP7vz5geWtbZk3BaU42hbZLq9AqjXc2cDVGU9zg5K
         5EGw==
X-Gm-Message-State: AOJu0Yzt/2hssZz0/OrP82qtSkQ1KOVniiOYsp6ivy5XhQYDURH1GAyK
	SAFWNR/6wp2mTUWHi5teBWUe1cmrM6sz4+Ngsuh/CQuSRA6IGvs6JY9lmeSn
X-Gm-Gg: ASbGncskmfXdzhJuU+vyMKNGqfWgpvcNeTZ51JTSE82C0rEiDY/kJI2PZSqrifBpRj/
	6fL+UIWFt6iyPHpwpm+ZOUbTTm+81qP2Mt/MijUm9QvOdnLk/5hqP7etcZpiNSlBJW7yooQbvKi
	uqFDBDfXHZjwO+mvu9ywUE5I+paSA4CfmjAdfKnDwaigo4KKYz9q1zk6bMA5r6EoYKhPeRTWX82
	6efO0mfLpPdQiUfXMqMi7+SoDUKA2gdd/w4UEnEoltQN47ByCm7pZm24Atv+weKcfwmgiSqrezi
	L3ySqQ8NWfIat/R+aRwiTM8L3c+ZHPyF5hGMo8vcEi8BPvH8lS3hKOx5SXIiM16zfPty4tQcU5H
	1OEXLBUX2nY4tTR3UZsUVr9ck538+oWUl9GCxcOulCoD3XV37Uit/rACA/78nTZ9ISVm+tBOFem
	mZSKtw++Dfsb4s/hMFESvmLqYT5jd1klQ/ZOq3immT72Ex2A==
X-Google-Smtp-Source: AGHT+IETnq9skuH55K0zjYolzejI70oWyGegNG+DJoZJvPo8+UxKPjDBPtT4eeNK6XtdrKQGNMg5+g==
X-Received: by 2002:a05:6a20:7346:b0:35d:7f7:4aac with SMTP id adf61e73a8af0-363f5e7a28emr4331264637.47.1764782522591;
        Wed, 03 Dec 2025 09:22:02 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a1d85sm18289040a12.26.2025.12.03.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 09:22:02 -0800 (PST)
From: stfomichev@gmail.com
Date: Wed, 3 Dec 2025 09:22:01 -0800
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.19
Message-ID: <aTBxuQSvtATrr3mu@mini-arch>
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
https://lore.kernel.org/netdev/20251202175548.6b5eb80e@kernel.org/T/#u

Previous cycle:
28 Jul to 28 Sep: 5327 mailing list messages, 62 days, 86 messages per day
437 repo commits (7 commits/day, 38.9% of these are selftests)
https://lore.kernel.org/bpf/aOBHUT26KS86wx-n@mini-arch/

Current cycle:
29 Sep to 30 Nov: 5851 mailing list messages, 62 days, 94 messages per day
415 repo commits (7 commits/day, 42.41% of these are selftests)

Developer rankings
------------------

Contributions to selftests:
   1 [ 15] Bastien Curutchet
   2 [ 13] Mykyta Yatsenko
   3 [ 12] Alexis Lothoré
   4 [ 12] Amery Hung
   5 [ 10] Kumar Kartikeya Dwivedi
   6 [  9] Puranjay Mohan
   7 [  9] Jiri Olsa

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [9] Alexei Starovoitov       1 ( +2) [26] Eduard Zingerman    
   2 ( +1) [5] Eduard Zingerman         2 (   ) [24] Alexei Starovoitov  
   3 ( -1) [4] Andrii Nakryiko          3 ( -2) [15] Andrii Nakryiko     
   4 ( +2) [3] Jakub Kicinski           4 ( +2) [ 8] Jakub Kicinski      
   5 ( -1) [2] Yonghong Song            5 (   ) [ 6] Martin KaFai Lau    
   6 ( -1) [2] Martin KaFai Lau         6 (+30) [ 5] Paolo Abeni         
   7 ( +1) [2] Jiri Olsa                7 ( -3) [ 5] Yonghong Song       
   8 ( +5) [1] Song Liu                 8 ( +5) [ 4] Maciej Fijalkowski  
   9 (***) [1] Alan Maguire             9 (+15) [ 3] Steven Rostedt      
  10 (***) [1] Paolo Abeni             10 (***) [ 3] Alan Maguire        
  11 ( +8) [1] Maciej Fijalkowski      11 ( -2) [ 3] Jiri Olsa           
  12 (***) [1] Chris Mason             12 (***) [ 3] Toke Høiland-Jørgensen
  13 ( +1) [1] Peter Zijlstra          13 ( -2) [ 3] Peter Zijlstra      
  14 ( +3) [1] Steven Rostedt          14 ( +5) [ 3] Jason Xing          
  15 ( -3) [1] Masami Hiramatsu (Google)   15 ( +6) [ 3] Song Liu            

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [1] Menglong Dong            1 (***) [32] Christian Brauner   
   2 (+14) [1] Puranjay Mohan           2 (***) [18] Al Viro             
   3 ( +6) [1] Alexei Starovoitov       3 (+15) [13] Anton Protopopov    
   4 ( +1) [1] Jiri Olsa                4 ( +2) [10] Mykyta Yatsenko     
   5 (***) [1] Jianyun Gao              5 (+17) [ 8] Jakub Sitnicki      
   6 (***) [1] Jason Xing               6 ( -4) [ 8] Chia-Yu Chang       
   7 ( -1) [1] Kumar Kartikeya Dwivedi    7 ( -4) [ 8] Amery Hung          
   8 (+35) [1] Alan Maguire             8 ( -4) [ 8] Leon Hwang          
   9 ( -6) [1] Amery Hung               9 ( -4) [ 7] Menglong Dong       
  10 (***) [1] Donglin Peng            10 (***) [ 6] Donglin Peng        

Top scores (positive):               Top scores (negative):              
   1 (   ) [156] Alexei Starovoitov     1 (***) [123] Christian Brauner  
   2 ( +1) [112] Eduard Zingerman       2 (***) [ 71] Al Viro            
   3 ( -1) [ 74] Andrii Nakryiko        3 (+10) [ 48] Anton Protopopov   
   4 (   ) [ 40] Yonghong Song          4 ( +1) [ 34] Mykyta Yatsenko    
   5 ( +1) [ 39] Jakub Kicinski         5 ( -3) [ 33] Chia-Yu Chang      
   6 ( -1) [ 38] Martin KaFai Lau       6 ( -3) [ 30] Leon Hwang         
   7 (+25) [ 26] Paolo Abeni            7 (+24) [ 28] Jakub Sitnicki     
   8 (+12) [ 18] Maciej Fijalkowski     8 (***) [ 22] Donglin Peng       
   9 (***) [ 17] Steven Rostedt         9 ( -5) [ 22] Menglong Dong      
  10 ( +4) [ 17] Peter Zijlstra        10 ( +1) [ 22] Bastien Curutchet  

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [17] Meta                    1 (   ) [81] Meta                
   2 (   ) [ 5] Intel                   2 ( +1) [18] RedHat              
   3 ( +2) [ 4] RedHat                  3 ( -1) [14] Intel               
   4 (   ) [ 3] Google                  4 (   ) [ 8] Google              
   5 ( +3) [ 2] Oracle                  5 (   ) [ 6] Oracle              
   6 ( -3) [ 2] Isovalent               6 (   ) [ 4] Isovalent           
   7 ( +6) [ 1] Tencent                 7 ( +2) [ 3] Tencent             

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [6] Meta                     1 ( +1) [34] Meta                
   2 (   ) [3] Google                   2 (+31) [33] Microsoft           
   3 ( +1) [2] Tencent                  3 (   ) [28] Isovalent           
   4 ( -1) [2] Isovalent                4 (+13) [21] RedHat              
   5 ( +7) [1] Oracle                   5 ( -4) [20] Google              
   6 ( +3) [1] Amazon                   6 ( -2) [11] Tencent             
   7 ( +8) [1] SUSE                     7 ( +9) [10] CloudFlare          

Top scores (positive):               Top scores (negative):              
   1 (   ) [256] Meta                   1 (***) [117] Microsoft          
   2 (   ) [ 84] Intel                  2 ( +9) [ 80] Isovalent          
   3 ( +6) [ 11] Linux Foundation       3 ( +7) [ 35] Bootlin            
   4 (+43) [  8] NGI0 Core              4 ( -3) [ 33] Google             
   5 ( -1) [  8] Hedgehog               5 ( -3) [ 33] Nokia              
   6 (***) [  8] Linutronix             6 ( -1) [ 27] Shopee             
   7 (***) [  6] Hansen Partnership     7 (+27) [ 26] CloudFlare         

More raw stats
--------------

Prev: start: Mon, 28 Jul 2025 16:08:22 -0700
	end: Sun, 28 Sep 2025 16:46:06 +0100
Prev: messages: 5325 days: 62 (86 msg/day)
Prev: direct commits: 437 (7 commits/day)
Prev: test commits: 170 (38.9%)
Prev: people: 280  {'author': 93, 'commenter': 125, 'both': 62, 'none': 16}
Prev: people pct: {'author': 0.314, 'commenter': 0.422, 'both': 0.209, 'none': 0.054}
Prev: review pct: 30.66%  x-corp pct: 22.65%
Prev: avg revisions: single patch: 1.51 patch set: 2.45

Curr: start: Mon, 29 Sep 2025 10:22:06 +0800
	end: Sun, 30 Nov 2025 21:06:29 +0800
Curr: messages: 5851 days: 62 (94 msg/day)
Curr: direct commits: 415 (7 commits/day)
Curr: test commits: 176 (42.41%)
Curr: people: 293  {'author': 106, 'commenter': 123, 'both': 64, 'none': 19}
Curr: people pct: {'author': 0.34, 'commenter': 0.394, 'both': 0.205, 'none': 0.061}
Curr: review pct: 36.39%  x-corp pct: 26.51%
Curr: avg revisions: single patch: 1.41 patch set: 2.11

Diff:  -0.1% linux-next size
Diff:  +9.9% (+10.0%) msg/day
Diff:  -5.0% ( -5.0%) commits/day
Diff:  +4.6% ( +4.7%) people/day
Diff: review pct: +5.7%
      x-corp pct: +3.9%
Diff: avg revisions: single patch: -6.4% patch set: -13.8%

Contributions to selftests: total individuals: 46 (was 45, +2.22%)
Contributions to selftests:
   1 [ 15] Bastien Curutchet
   2 [ 13] Mykyta Yatsenko
   3 [ 12] Alexis Lothoré
   4 [ 12] Amery Hung
   5 [ 10] Kumar Kartikeya Dwivedi
   6 [  9] Puranjay Mohan
   7 [  9] Jiri Olsa
   8 [  7] Eduard Zingerman
   9 [  7] Jakub Sitnicki
  10 [  5] Hoyeon Lee
  11 [  5] Anton Protopopov
  12 [  5] Matt Bobrowski
  13 [  5] Leon Hwang
  14 [  5] Paul Chaignon
  15 [  5] Ilya Leoshkevich

