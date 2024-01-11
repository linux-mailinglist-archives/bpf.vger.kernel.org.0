Return-Path: <bpf+bounces-19375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCE82B4FE
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 20:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCB9B21169
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1553E2C;
	Thu, 11 Jan 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdKzl6oM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281F4CE01
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6d289e2b084so5967868b3a.2
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704999676; x=1705604476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OiThnLbA7grkrhL5TV+S8XslID9RiSHWpHQyh5tKkCA=;
        b=OdKzl6oM0G2byQBryItRaqy8JULuzNVDjCBmwiiP9XF3t5BMFRTk6WXMpdb4caXGM6
         qB5QzzQVYWx9baarIBqAB5zp+SW0LKbhEnpGm9qOkx2oCI+xPWHk8h5Yc+KKQKvHvUY+
         ZOlKmGZmOBryAO2yIfM0YAOlGWOBSLHA2isxgJmdtHc1AzdYwcIxlM1JqWEfM2BQ1/S6
         71HYyJiywjCNAuvPPIxDNwnUTcGIOVttWTqPIGsEGKV5vDEFvu4mW8Q/budrDRcGxBxZ
         SQGKlO7vOUat5YYJjBatW4QgYNfqHef2RMuZ0J3RHIovmedevTovp+YuHXj/HuCmG/iH
         Nb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704999676; x=1705604476;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiThnLbA7grkrhL5TV+S8XslID9RiSHWpHQyh5tKkCA=;
        b=oKUbEublROgx579odgXQhhjB1Xy9TeOMlzwvtUp/+mASv1WRQ8KIvKZrSamB8oeGGu
         eWzd6Dj+sxVIqXjh9VteKO7ximyrZjvwclqKeoE9NCL73OQRH/xlcUzfd/AXYtMj+B9+
         DAeVQP9Iy+EaTqteO0diyzB7YJjZoNzcPQR8hLZ1sm4XLI8mgWJ0PDPZBYiZbv2INtPz
         5Nt+O6oku2MSvs/xJKS5Tdzdq8skTTa5KudE+ry2QyRJVHg5TZnlf67N4DyIFwDNGSf4
         0mS+SaykIRIhVCThPxOrT9mzw/LTswzsuT/B/iEfRt9hgxM0sbrJWHrA/toD583Jv6WR
         dj6Q==
X-Gm-Message-State: AOJu0YylAAKx7gJBid+NAdRYXUHFc/F149hPmereKhXJD1ZSKde8FQjN
	zKEhHDOkJgEnobSHBvArWhyDGwBtTMFFB5Vny2z5v2L2O28cAJPnZ8mf2SpngN5z5yI+moB53lv
	Hcq6HibonFfRdIhON730eR9Hg43vL4pkaRRGyefVDJaev6nSWuoF3c7Im
X-Google-Smtp-Source: AGHT+IE1PdLzsmRusZJX6VEP1LmMDXUverC/ubdViOoA0Kdd46J1j7TxB0iVd6bXYm8nGU9mSz+sSWA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1255:b0:6d9:cb7b:e2a5 with SMTP id
 u21-20020a056a00125500b006d9cb7be2a5mr11161pfi.4.1704999676137; Thu, 11 Jan
 2024 11:01:16 -0800 (PST)
Date: Thu, 11 Jan 2024 11:01:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <ZaA6-k5pU5nZJZtI@google.com>
Subject: [ANN] bpf development stats for 6.8
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Content-Type: text/plain; charset="utf-8"

See the netdev posting for more info and context (there have been
some changes in the methodology):
https://lore.kernel.org/netdev/20240109134053.33d317dd@kernel.org/

As last time, I'm presenting raw stats without any evaluation. I'm
posting a link to the previous cycle below so people can do the
comparison if needed.

Previous cycle:
29 Aug to 31 Oct: 4798 mailing list messages, 63 days, 76 messages per day
577 repo commits (9 commits/day)

Current cycle:
27 Oct to 10 Jan: 5795 mailing list messages, 75 days, 77 messages per day
624 repo commits (8 commits/day)

6.7 stats: https://lore.kernel.org/bpf/ZUP0FjaZVL4hBhyz@google.com/

Rankings
--------

Top reviewers (thr):                 Top reviewers (msg):                
   1 ( +1) [10] Alexei Starovoitov      1 ( +1) [19] Alexei Starovoitov  
   2 ( -1) [ 8] Andrii Nakryiko         2 ( -1) [18] Andrii Nakryiko     
   3 (+13) [ 5] Yonghong Song           3 ( +2) [18] Eduard Zingerman    
   4 ( +1) [ 4] Eduard Zingerman        4 (+11) [10] Yonghong Song       
   5 ( -1) [ 4] Jiri Olsa               5 ( -1) [ 8] Jiri Olsa           
   6 (   ) [ 3] Martin KaFai Lau        6 ( -3) [ 7] Martin KaFai Lau    
   7 ( -4) [ 2] Daniel Borkmann         7 (+20) [ 5] Hou Tao             
   8 ( +5) [ 2] John Fastabend          8 (+16) [ 4] John Fastabend      
   9 ( +6) [ 2] Hou Tao                 9 ( -3) [ 4] Daniel Borkmann     
  10 ( -3) [ 2] Jakub Kicinski         10 ( -3) [ 3] Song Liu            
  11 ( -3) [ 2] Song Liu               11 (+39) [ 3] Christian Brauner   
  12 (+27) [ 1] Christian Brauner      12 ( +1) [ 3] Shung-Hsi Yu        
  13 ( -4) [ 1] Stanislav Fomichev     13 ( -5) [ 3] Jakub Kicinski      
  14 ( -4) [ 1] Simon Horman           14 ( +5) [ 2] Paul Moore          
  15 ( +9) [ 1] Paul Moore             15 (+26) [ 2] Steven Rostedt      

Top authors (thr):                   Top authors (msg):                  
   1 (   ) [5] Andrii Nakryiko          1 (   ) [39] Andrii Nakryiko     
   2 (***) [3] Yonghong Song            2 (+35) [16] Masami Hiramatsu (Google)
   3 ( +5) [2] Hou Tao                  3 ( +1) [12] Kui-Feng Lee        
   4 (***) [2] Andrei Matei             4 (+11) [10] Hou Tao             
   5 ( -2) [1] Daniel Borkmann          5 ( -3) [ 9] Song Liu            
   6 ( -1) [1] Jiri Olsa                6 (+44) [ 7] Daniel Xu           
   7 (***) [1] Daniel Xu                7 (***) [ 7] Yonghong Song       
   8 (***) [1] Dmitry Dolgov            8 (   ) [ 6] Yafang Shao         
   9 ( -7) [1] Song Liu                 9 (+16) [ 6] Eduard Zingerman    
  10 ( -4) [1] Kui-Feng Lee            10 (+32) [ 5] Kuniyuki Iwashima   

Top scores (positive):               Top scores (negative):              
   1 (   ) [120] Alexei Starovoitov     1 (+34) [59] Masami Hiramatsu (Google)
   2 ( +1) [ 53] Eduard Zingerman       2 ( +2) [50] Kui-Feng Lee        
   3 ( -1) [ 38] Martin KaFai Lau       3 (***) [46] Andrii Nakryiko     
   4 ( +8) [ 37] Yonghong Song          4 (+45) [26] Daniel Xu           
   5 ( -1) [ 37] Jiri Olsa              5 (***) [18] Dmitry Dolgov       
   6 (+19) [ 20] John Fastabend         6 ( +1) [17] Xuan Zhuo           
   7 ( -2) [ 20] Jakub Kicinski         7 (***) [16] Kuniyuki Iwashima   
   8 (+22) [ 19] Christian Brauner      8 ( +5) [15] Yafang Shao         
   9 ( -3) [ 17] Daniel Borkmann        9 ( -4) [14] Larysa Zaremba      
  10 ( +5) [ 13] Paul Moore            10 ( -2) [14] Song Liu            

Company rankings
----------------

Top reviewers (thr):                 Top reviewers (msg):                
   1 (   ) [16] Meta                    1 (   ) [48] Meta                
   2 (   ) [ 9] Isovalent               2 (   ) [18] Isovalent           
   3 (   ) [ 4] Google                  3 ( +2) [ 8] Intel               
   4 (   ) [ 4] Intel                   4 ( -1) [ 8] Google              
   5 (   ) [ 2] RedHat                  5 ( +4) [ 7] Microsoft           
   6 ( +3) [ 2] Microsoft               6 ( +2) [ 6] Huawei              
   7 ( -1) [ 2] Huawei                  7 ( -3) [ 6] RedHat              

Top authors (thr):                   Top authors (msg):                  
   1 (   ) [15] Meta                    1 (   ) [84] Meta                
   2 ( +1) [ 4] Google                  2 (   ) [29] Google              
   3 ( +1) [ 4] Isovalent               3 ( +2) [11] Huawei              
   4 ( +1) [ 3] Huawei                  4 (   ) [10] Isovalent           
   5 ( -3) [ 3] Intel                   5 ( -2) [ 9] Intel               
   6 (***) [ 2] Andrei Matei            6 ( +4) [ 8] Alibaba             
   7 (+13) [ 2] Alibaba                 7 (+19) [ 7] Aviatrix            

Top scores (positive):               Top scores (negative):              
   1 (   ) [74] Isovalent               1 ( +7) [93] Meta                
   2 ( +3) [34] Microsoft               2 ( +3) [59] Google              
   3 ( -1) [25] RedHat                  3 (   ) [30] Alibaba             
   4 ( +3) [16] Intel                   4 (+19) [26] Aviatrix            
   5 ( +3) [13] Linux Foundation        5 (***) [18] Dmitry Dolgov       
   6 ( -3) [13] Corigine                6 ( +7) [16] Amazon              
   7 ( -3) [12] SUSE                    7 ( +2) [15] Juniper Networks    

More raw stats
--------------

Prev: start: Tue, 29 Aug 2023 19:00:24 +0000
	end: Tue, 31 Oct 2023 11:44:39 -0700
Prev: messages: 4810 days: 63 (76 msg/day)
Prev: direct commits: 288 (5 commits/day)
Prev: people/aliases: 253  {'author': 82, 'commenter': 113, 'both': 58}
Prev: review pct: 12.85%  x-corp pct: 11.11%

Curr: start: Fri, 27 Oct 2023 13:33:09 -0700
	end: Wed, 10 Jan 2024 14:29:01 -0500
Curr: messages: 5795 days: 75 (77 msg/day)
Curr: direct commits: 624 (8 commits/day)
Curr: people/aliases: 246  {'author': 87, 'commenter': 105, 'both': 54}
Curr: review pct: 33.49%  x-corp pct: 29.97%

Diff: +1.2% msg/day
Diff: +82.0% commits/day
Diff: -18.3% people/day
Diff: review pct: +20.6%
      x-corp pct: +18.9%

