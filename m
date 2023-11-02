Return-Path: <bpf+bounces-14011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ECA7DFAB4
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F131C20DA9
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2A21356;
	Thu,  2 Nov 2023 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34gkRfHq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFA41CFB6
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 19:10:18 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD712D
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 12:10:17 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc252cbde2so9749635ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698952217; x=1699557017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZhfmN3A7/MnG8gTsiLp6royauPXjf5TQDGbZNLTiDZE=;
        b=34gkRfHqbz6G/HXsWvolj4ZCT0Q7otZtRF3cs+MUQLON2kZdHC0B3363ARuHMb6Ve8
         8SpFh4NlVBGGIWwh/vLQYMZvuGThA9QpM4dycdqauUFWTEGSHLebPwf+exj+64PBsqqq
         GP5mwJANiR0lU1Zeb1JZK4XZzpCMn2lqBBOgLEhpQC32w4tpsxdA+voIpaVLRFNebzW8
         HiU8VUjf31AWhCtTB7N5zv3ghNrKJVKohNZPkmvxsbxQoEE/7uRNxfqewEe1aIL1PR4r
         lxzQEoTbZvJKBaELakYd3V1gvhZZcli1qbeh0yjGCk3xfO3r0DV9SgMj19jXncxihkzx
         5MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952217; x=1699557017;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhfmN3A7/MnG8gTsiLp6royauPXjf5TQDGbZNLTiDZE=;
        b=wBo48kcrOAJHje5G3288VwLP1QOTpoipnzjrnGv2AuDxwnYEbhlq0PCO5IeabBE9JC
         MWWua9aAUMUlzWnC9ZGUy3g1qlWW+sXiKWkSbk6jUpRS04XVoq9QcCWg3sn1I8O+VX2p
         ubXIRui5UuJ50cyGDAO/JHj2lrvqK6K/KxyS5di/x2axnv7AErJOvHH/kRWcgkGaiGR6
         /HjFtbnHRVZfBIiF+wgJM+AKhIGjPPZhajNicKZfJSg2oV/YSMqHZeLPSmCDpUGRO9I4
         Pc0aAgJApckModoK2Ny8chicHgSfJeSiONeX/hEGxF+EftlXITgFub2BRCAz3w8RmZsX
         EIAQ==
X-Gm-Message-State: AOJu0YyW6MpQlu91vMlMZUoW70e60sU2O1uZYa5Vf1grWdhvjRD6cLOj
	T2ZwMmQPD6SzSMJC/xWn9Z6HPVYHqSt4/4aXZyJA0XfSZLLK/glNLaS4e52JPN6QLY+0mwDTw2K
	R3oHFZlxzl2PhA+AYgR118F5knEkcz51L12fDCjcqFc+Q45x54Q==
X-Google-Smtp-Source: AGHT+IGyr09ECHTTqdX/VvjMg3MI7Z330kZgzCDzCX91vHfgfQl6SdMbTwWUJ8T81fA6LnhQGLqXjdg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:6b08:b0:1c7:2bb4:54fb with SMTP id
 o8-20020a1709026b0800b001c72bb454fbmr346676plk.4.1698952216630; Thu, 02 Nov
 2023 12:10:16 -0700 (PDT)
Date: Thu, 2 Nov 2023 12:10:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <ZUP0FjaZVL4hBhyz@google.com>
Subject: [ANN] bpf development stats for 6.7
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Content-Type: text/plain; charset="utf-8"

See the netdev posting for more info and context:
https://lore.kernel.org/netdev/20231101162906.59631ffa@kernel.org/

As last time, I'm presenting raw stats without any evaluation. I'm
posting a link to the previous cycle below so people can do the
comparison if needed.

Previous cycle:
28 Jun to 29 Aug: 5240 mailing list messages, 62 days, 85 messages per day
384 repo commits (6 commits/day)

Current cycle:
29 Aug to 31 Oct: 4798 mailing list messages, 63 days, 76 messages per day
577 repo commits (9 commits/day)

6.6 stats: https://lore.kernel.org/bpf/ZO6O27Z9RvresmiV@google.com/

Rankings
--------

Top reviewers (thr):                 Top reviewers (msg):                
   1 ( +7) [6] Andrii Nakryiko          1 ( +3) [13] Andrii Nakryiko     
   2 ( -1) [6] Alexei Starovoitov       2 ( -1) [ 9] Alexei Starovoitov  
   3 ( +2) [4] Daniel Borkmann          3 ( +2) [ 8] Martin KaFai Lau    
   4 ( +3) [4] Jiri Olsa                4 ( +9) [ 7] Jiri Olsa           
   5 ( +7) [3] Eduard Zingerman         5 ( +5) [ 7] Eduard Zingerman    
   6 ( -3) [3] Martin KaFai Lau         6 ( +2) [ 5] Daniel Borkmann     
   7 ( -1) [2] Jakub Kicinski           7 (+31) [ 5] Song Liu            
   8 (+29) [2] Song Liu                 8 ( -1) [ 4] Jakub Kicinski      
   9 ( -5) [2] Stanislav Fomichev       9 (***) [ 3] Namhyung Kim        
  10 ( +4) [1] Simon Horman            10 ( +6) [ 3] Jason Wang          
  11 (+11) [1] Quentin Monnet          11 (***) [ 3] Kees Cook           
  12 (+16) [1] Maciej Fijalkowski      12 (+11) [ 3] Maciej Fijalkowski  
  13 ( -2) [1] John Fastabend          13 (***) [ 3] Shung-Hsi Yu        
  14 ( -1) [1] Alan Maguire            14 ( +5) [ 2] Willem de Bruijn    
  15 ( -6) [1] Hou Tao                 15 (-13) [ 2] Yonghong Song       

Top authors (thr):                   Top authors (msg):                  
   1 (+16) [2] Andrii Nakryiko          1 (+49) [18] Andrii Nakryiko     
   2 (***) [2] Song Liu                 2 (***) [11] Song Liu            
   3 ( +1) [2] Daniel Borkmann          3 (+25) [11] Ian Rogers          
   4 (+38) [2] Ian Rogers               4 (+14) [10] Kui-Feng Lee        
   5 ( +1) [2] Jiri Olsa                5 (+42) [ 9] Daan De Meyer       
   6 ( +1) [1] Kui-Feng Lee             6 (+24) [ 7] Chuyi Zhou          
   7 (***) [1] Hengqi Chen              7 ( +2) [ 6] Daniel Borkmann     
   8 ( +6) [1] Hou Tao                  8 ( -1) [ 6] Yafang Shao         
   9 (+31) [1] Chuyi Zhou               9 ( -6) [ 6] Larysa Zaremba      
  10 (***) [1] Daan De Meyer           10 (+35) [ 5] Puranjay Mohan      

Company rankings
----------------

Top reviewers (thr):                 Top reviewers (msg):                
   1 (   ) [16] Meta                    1 (   ) [41] Meta                
   2 (   ) [ 9] Isovalent               2 ( +2) [15] Isovalent           
   3 (   ) [ 6] Google                  3 (   ) [12] Google              
   4 ( +1) [ 6] Intel                   4 ( -2) [11] RedHat              
   5 ( -1) [ 3] RedHat                  5 (   ) [11] Intel               
   6 (   ) [ 2] Huawei                  6 ( +5) [ 4] SUSE                
   7 (   ) [ 2] Oracle                  7 (   ) [ 4] Oracle              
   8 (+13) [ 1] Amazon                  8 ( -2) [ 3] Huawei              
   9 ( +3) [ 1] Microsoft               9 ( +4) [ 3] Microsoft           
  10 ( -2) [ 1] Corigine               10 (+22) [ 2] Amazon              

Top authors (thr):                   Top authors (msg):                  
   1 (   ) [11] Meta                    1 (   ) [63] Meta                
   2 ( +3) [ 6] Intel                   2 ( +3) [25] Google              
   3 ( +1) [ 5] Google                  3 (   ) [16] Intel               
   4 ( -1) [ 5] Isovalent               4 ( -2) [14] Isovalent           
   5 ( -3) [ 3] Huawei                  5 ( -1) [13] Huawei              
   6 (   ) [ 2] RedHat                  6 ( +2) [ 7] Bytedance           
   7 ( +9) [ 2] Bytedance               7 (***) [ 7] Amazon              
   8 ( +1) [ 1] Oracle                  8 ( +7) [ 7] IBM                 
   9 (***) [ 1] Tencent                 9 (   ) [ 6] Juniper Networks    
  10 (***) [ 1] Amazon                 10 ( +1) [ 5] Alibaba             

Development vs reviewing scores
-------------------------------

(there were no changes to the ranking script, still not sure how precise
individual scores are; I see that Jakub didn't include them this time)

Top scores (positive):               Top scores (negative):              
   1 (   ) [75] Alexei Starovoitov      1 (+38) [37] Daan De Meyer       
   2 (   ) [44] Martin KaFai Lau        2 (+24) [37] Ian Rogers          
   3 ( +8) [33] Eduard Zingerman        3 (+19) [27] Chuyi Zhou          
   4 (***) [33] Jiri Olsa               4 (+27) [27] Kui-Feng Lee        
   5 (   ) [32] Jakub Kicinski          5 ( -3) [22] Larysa Zaremba      
   6 ( +4) [28] Daniel Borkmann         6 (+19) [20] Breno Leitao        
   7 (***) [17] Maciej Fijalkowski      7 ( +4) [19] Xuan Zhuo           

Top scores (positive):               Top scores (negative):              
   1 (***) [61] Isovalent               1 ( +2) [27] Bytedance           
   2 (   ) [40] RedHat                  2 (   ) [26] Huawei              
   3 ( +1) [17] Corigine                3 ( +4) [22] Alibaba             
   4 (***) [15] SUSE                    4 ( +7) [20] IBM                 
   5 ( +2) [14] Microsoft               5 (***) [18] Google              
   6 (***) [12] CloudFlare              6 (***) [17] Tencent             
   7 (***) [12] Intel                   7 (***) [16] Crowdstrike         

More raw stats
--------------

Prev: start: Wed, 28 Jun 2023 22:18:25 -0700
	end: Tue, 29 Aug 2023 15:24:18 -0700
Prev: messages: 5240 days: 62 (85 msg/day)
Prev: direct commits: 384 (6 commits/day)
Prev: people/aliases: 279  {'author': 112, 'commenter': 120, 'both': 47}
Prev: review pct: 24.22%  x-corp pct: 23.44%

Curr: start: Tue, 29 Aug 2023 20:53:22 +0200
	end: Tue, 31 Oct 2023 10:50:30 -0700
Curr: messages: 4798 days: 63 (76 msg/day)
Curr: direct commits: 577 (9 commits/day)
Curr: people/aliases: 253  {'author': 82, 'commenter': 113, 'both': 58}
Curr: review pct: 22.7%  x-corp pct: 20.45%

Diff: -9.9% msg/day
Diff: +47.9% commits/day
Diff: -10.8% people/day
Diff: review pct: -1.5%
      x-corp pct: -3.0%

