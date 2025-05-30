Return-Path: <bpf+bounces-59351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A1AC9136
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76E1A46834
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9222DA0C;
	Fri, 30 May 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYnumono"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D82288C0
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614102; cv=none; b=JPJSRR6omwQtCyq7M/0B5R/41vgObVW/2t0Dv2QacDJGgZZcRudnfYTY/+cgtVWwYus2E/8tgXpqGSYRLCTBXv1VN7RuaqitZ9DflE/wxBR0f1nt+ntuEUEKAgGH2pWQlSqCHsQrUBQxvzqNbT/rEx3DCFHIXrhE921lcUzT+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614102; c=relaxed/simple;
	bh=PqprV9Tr0fgxrIzTBuQUVwmWiC9CxXfOWGDVtivpclE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DPh5LYwkjeFsFdGbCHdp8k2EdiObDhrjnfsGPpZ/95x0EDCRT4KoOIbfqDuXE0g+IFZvGayoPJDxi62pei9ArTyeLMQbUMhBTqA1eZvuJd9ROVSahsAKT0ciXwqGzj67TNJaqd8qxOmS9G57rnT8kZmmQNsXfjjQKL/fzVwkqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYnumono; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af523f4511fso1660689a12.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748614099; x=1749218899; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eE1C0QYHa/xckGiWQr9QcwqZ9I6KCxrFc5cadLAkRcg=;
        b=IYnumonorqi002Sgudp2tF5xmDQFUbcGnbnnhMvy/H3OZFswqvDBUCg2PgEmWUt5kv
         k/wkWBySIwS62tfa+T2tn1BktiqzwuznfH8D/5ckhYukRXPCt9n634EfLwUqCMMqAVkw
         dwe3eHQx9kbjE+Q6WrcvmUZ8zrPYU6EMyI7l5fNcHAhDkm1wV2z/v5okjZGWsV6JvDkU
         5tPEFfChnHKw6VnGr7iptaIxYwyjnjr0qYp1SIdndx/bZ1ZafhFk4zb1tSLKucemx/69
         6sXwAF34V3E1H60uT3h/IAjhZ6p05lnK8P8FhO7q48Tl8z3WVdpmyItYUmCbl5ihFVxl
         XWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748614099; x=1749218899;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE1C0QYHa/xckGiWQr9QcwqZ9I6KCxrFc5cadLAkRcg=;
        b=K6wYG46uO4N0SkHVxJ/Qvi7DujHPTIjLMTh3TWZn6Qy/2Mm97gETVBECGkl0ja9LDC
         n7Gn5grGM6R+WzYp7YLnqwr/kefHSFOTy67l2IS+tOusxbhTafuPdVd8jTknohOpyqKJ
         7oM3YMDH/gSkGdOgZ6ph5UFvgxpeLvZzlCWBMilZJgHGkR7fDQcoYMmGzXvo6sUU+Z1i
         61YjJC4SMjsWOulw83dd+sQ/OUM2MZfLEFqTNZsf5yLFzBfiWWyJLmmhLjnR5MzibfEp
         qUJ9EkktAP4GDaf2AjCDQ1mpZ1MxW0fOxX8shl53IX5KWcMBQfdYbULH5raEw9fckpxH
         ExNw==
X-Gm-Message-State: AOJu0Yxp0x/PXdVhn3UZOLXg4yePjGNWGEvwmXlAfGdzV6958s1UvuN3
	JrD12mUfCJhtZjy+nkKdXcV/sg+0PAOV3J9IkoaumO8+JuPCGiO3fvB5p1Ra
X-Gm-Gg: ASbGncvIIGGbBENECE2haKft8vYeqm0KOCTYOgRiSA45yuW1heYNJzuGBVxfqE14eRr
	UWRpwPGrbC+JJaPzW0vdeGAG3rBKUrZS0s2fJLT68ZhBMBz4p4T8fCho/6pqSpp00dsyfuFwyIc
	vBtR7SB3STK+O7SA0n6svWIhWXzB4GFypD91CPhPK2AsepCypb2VxewSkHYxyUY9aTEXb9ktmpx
	CddVQNwsKHHatxJ6F+OvwMMlScyuQrkvmQBmF5oGJEDGyYTBnX0jW0FbVt+43wRAfidtaJ7QnhZ
	9xo/dM1nQ7rOsLihQHLUimt6GGi4mR1/TLzxBBgREwCCZAG7d0l5ugAMPQSi/nnZPR7O8Rl32aM
	dX2SsLvJbqHHW
X-Google-Smtp-Source: AGHT+IEEXbsKHazCl7xG7eD1k4msUgkNpq3JYauqTXN9u3rcVSzZjxmewhcCbtza6jEx+j+QYk1SdQ==
X-Received: by 2002:a05:6a20:431c:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-21ad94ef13amr6340830637.7.1748614099399;
        Fri, 30 May 2025 07:08:19 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afff749esm3157207b3a.176.2025.05.30.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 07:08:18 -0700 (PDT)
Date: Fri, 30 May 2025 07:08:17 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.16
Message-ID: <aDm70S-SHD4_BPKG@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Regular development statistics update, similar Jakub's netdev post:
https://lore.kernel.org/netdev/20250326140948.18a7da36@kernel.org/T/#u

Previous cycle:
12 Jan to 27 Mar: 5314 mailing list messages, 64 days, 83 messages per day
337 repo commits (5 commits/day, 48.07% of these are selftests)
https://lore.kernel.org/bpf/Z-VcNKV8_pUqMTBw@mini-arch/

Current cycle:
27 Mar to 28 May: 4436 mailing list messages, 63 days, 70 messages per day
183 repo commits (7 commits/day, 43.16% of these are selftests)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [8] Alexei Starovoitov       1 ( +1) [21] Andrii Nakryiko     
   2 (   ) [7] Andrii Nakryiko          2 ( -1) [18] Alexei Starovoitov  
   3 (   ) [2] Jakub Kicinski           3 ( +1) [ 8] Eduard Zingerman    
   4 (   ) [2] Martin KaFai Lau         4 ( +2) [ 6] Jakub Kicinski      
   5 (   ) [2] Eduard Zingerman         5 ( -2) [ 5] Martin KaFai Lau    
   6 ( +1) [1] Stanislav Fomichev       6 (+37) [ 5] Kumar Kartikeya Dwivedi
   7 ( +5) [1] Paolo Abeni              7 (+18) [ 4] Vlastimil Babka     
   8 ( +1) [1] Simon Horman             8 ( -1) [ 4] Stanislav Fomichev  
   9 (+13) [1] Kumar Kartikeya Dwivedi    9 (+15) [ 4] Oleg Nesterov       
  10 (+36) [1] Daniel Borkmann         10 (+38) [ 4] Mina Almasry        
  11 ( +4) [1] Steven Rostedt          11 (+31) [ 3] Paolo Abeni         
  12 ( -6) [1] Jiri Olsa               12 (+10) [ 3] Alan Maguire        
  13 ( -3) [1] Quentin Monnet          13 (***) [ 3] Song Liu            
  14 (+13) [1] John Fastabend          14 (+19) [ 3] Paul Moore          
  15 ( +8) [1] Jesper Dangaard Brouer   15 (   ) [ 2] Simon Horman        

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [2] Jiayuan Chen             1 (+27) [7] Chia-Yu Chang        
   2 (+19) [2] Alexei Starovoitov       2 (***) [7] Jordan Rife          
   3 (***) [1] Ihor Solodrai            3 (***) [7] Shakeel Butt         
   4 (+22) [1] Feng Yang                4 ( +7) [7] Jiri Olsa            
   5 ( -2) [1] Kumar Kartikeya Dwivedi    5 ( -3) [5] Kumar Kartikeya Dwivedi
   6 ( +1) [1] Mykyta Yatsenko          6 (+12) [5] Ian Rogers           
   7 ( +3) [1] Yonghong Song            7 ( -1) [5] Mykyta Yatsenko      
   8 ( -6) [1] Amery Hung               8 (   ) [5] Jiayuan Chen         
   9 (+49) [1] Alan Maguire             9 (***) [5] T.J. Mercier         
  10 (***) [1] Jon Kohler              10 (+47) [5] Yonghong Song        

Top scores (positive):               Top scores (negative):              
   1 ( +1) [134] Andrii Nakryiko        1 (+22) [29] Chia-Yu Chang       
   2 ( -1) [122] Alexei Starovoitov     2 (***) [29] Jordan Rife         
   3 ( +1) [ 48] Jakub Kicinski         3 (***) [19] T.J. Mercier        
   4 ( +1) [ 28] Eduard Zingerman       4 (***) [19] Shakeel Butt        
   5 ( +1) [ 26] Stanislav Fomichev     5 (+14) [18] Ian Rogers          
   6 ( -3) [ 24] Martin KaFai Lau       6 (***) [16] Byungchul Park      
   7 (+27) [ 23] Vlastimil Babka        7 (***) [16] Bui Quang Minh      
   8 (+12) [ 22] Paolo Abeni            8 (***) [14] Tony Nguyen         
   9 ( +1) [ 20] Quentin Monnet         9 ( -6) [14] Amery Hung          
  10 ( -1) [ 19] Simon Horman          10 ( -3) [14] Jiayuan Chen        

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [14] Meta                    1 (   ) [55] Meta                
   2 (   ) [ 4] RedHat                  2 (   ) [16] RedHat              
   3 ( +2) [ 3] Google                  3 ( +1) [13] Google              
   4 ( -1) [ 3] Intel                   4 ( -1) [ 7] Intel               
   5 ( +3) [ 3] Oracle                  5 ( +5) [ 7] SUSE                
   6 ( -2) [ 3] Isovalent               6 ( +5) [ 6] Oracle              
   7 ( +7) [ 2] SUSE                    7 ( -2) [ 4] Isovalent           

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [8] Meta                     1 (   ) [36] Meta                
   2 (   ) [4] Google                   2 ( +1) [29] Google              
   3 ( +1) [2] Unknown                  3 ( +8) [12] Isovalent           
   4 ( +9) [2] Isovalent                4 ( +5) [ 9] Unknown             
   5 ( +3) [2] IBM                      5 ( -3) [ 9] Intel               
   6 ( +5) [2] RedHat                   6 ( +8) [ 8] RedHat              
   7 (***) [1] Kylin Software           7 (+14) [ 7] Nokia               

Top scores (positive):               Top scores (negative):              
   1 (   ) [163] Meta                   1 ( +9) [48] Google              
   2 (   ) [ 58] RedHat                 2 (+12) [29] Nokia               
   3 ( +5) [ 35] SUSE                   3 ( +2) [24] Unknown             
   4 ( +5) [ 28] Oracle                 4 (***) [16] SK Hynix            
   5 ( -1) [ 20] Hedgehog               5 (+23) [13] ZTE                 
   6 (   ) [ 20] Linux Foundation       6 (***) [13] Kylin Software      
   7 (+10) [ 11] Linutronix             7 ( +8) [11] FAU                 

More raw stats
--------------

Prev: start: Tue, 21 Jan 2025 22:23:15 -0800
	end: Thu, 27 Mar 2025 11:53:44 +0800
Prev: messages: 5314 days: 64 (83 msg/day)
Prev: direct commits: 337 (5 commits/day)
Prev: test commits: 162 (48.07%)
Prev: people: 286  {'author': 93, 'commenter': 132, 'both': 61, 'none': 24}
Prev: people pct: {'author': 0.3, 'commenter': 0.426, 'both': 0.197, 'none': 0.077}
Prev: review pct: 25.52%  x-corp pct: 22.55%
Prev: avg revisions: single patch: 1.72 patch set: 2.42

Curr: start: Wed, 26 Mar 2025 18:37:38 -0700
	end: Wed, 28 May 2025 15:59:55 -0700
Curr: messages: 4436 days: 63 (70 msg/day)
Curr: direct commits: 424 (7 commits/day)
Curr: test commits: 183 (43.16%)
Curr: people: 272  {'author': 88, 'commenter': 129, 'both': 55, 'none': 22}
Curr: people pct: {'author': 0.299, 'commenter': 0.439, 'both': 0.187, 'none': 0.075}
Curr: review pct: 23.35%  x-corp pct: 21.93%
Curr: avg revisions: single patch: 1.46 patch set: 2.48

Diff:  +1.6% linux-next size
Diff: -15.2% (-16.5%) msg/day
Diff: +27.8% (+25.8%) commits/day
Diff:  -3.4% ( -4.9%) people/day
Diff: review pct: -2.2%
      x-corp pct: -0.6%

Contributions to selftests:
   1 [ 36] Bastien Curutchet
   2 [ 14] Amery Hung
   3 [ 11] Mykyta Yatsenko
   4 [ 10] Kumar Kartikeya Dwivedi
   5 [  8] Michal Luczaj
   6 [  8] Jiayuan Chen
   7 [  8] Eduard Zingerman
   8 [  6] Peilin Ye
   9 [  6] Ihor Solodrai
  10 [  4] Yonghong Song

