Return-Path: <bpf+bounces-54821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28512A733ED
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A6D7A7372
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E39217653;
	Thu, 27 Mar 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/aWbiNk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D1215F42
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084601; cv=none; b=liszNECZSPzYiEcntLRYlXQjVE6+XUsWXg4W5hrJyutTJ2mRXMzWFm2MXys23aXFi2Z9xaV+8AgZgD6JcGXo70K4pr72ojlUrFNY2V06/hOWPE0N//yljg1n2js61E/AarxNGYO+4y8uSuUTXLRT9D1MobYMrEbYvk3IRlOvUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084601; c=relaxed/simple;
	bh=bbUaNsdEt93gS4Y2DpMBAG4FcCkozVsJ2kxtMwjy6Po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oLXBoaEpTzFh4nV1Y30/P2J9nPY9so/mDi3x6BwJO3Yi22aF0ui7IpMofUydgK7FQ/Bm+qlicEbmZV5qSoIUPDMl+FVRIltiU2nPuXVIqlNMzB4tS12Xl7hccciqB1/SIzlBRt6xkiF+fcRevDf74MTU3IiNVq2deqF4EzwyTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/aWbiNk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso18977175ad.1
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743084599; x=1743689399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGyOHRhjHYbdEKZJffaB4qZN8Lkfuop6JDiDKcAIgps=;
        b=C/aWbiNkc8VqCtSjp0jMKsiW7esRvdLJ4qtj6KQZGtjz+xWKVC9M4bsoWMiPfMH81h
         4uwD7zFcZQul3YhMjmNflpSZysl7Ke0GbUCMhR9WmVtYmO0qOWZRiQ1s7kTkQsXFZl2P
         pgMOTXncGKSzfuqYQVJ8HiFWxUzN+clSbYGsqhgGOps6/dwkfqxlXPH+71e7tpKWBy29
         kh3Xieo3FIVogJNwvtS4XatsxohFMKIXsF2i4SHCYl48R8kIK92I0bUgA6pKOYaUq/vE
         nsegelUOrYwNAP67cSHI5eFbpkamRVhkS5PNH0r2/IJAt/1UCKrKUKpNLA462NMxGXYV
         pQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084599; x=1743689399;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGyOHRhjHYbdEKZJffaB4qZN8Lkfuop6JDiDKcAIgps=;
        b=lxusq3nXYsQmR2k++0vVUUB6k3LQpkGtE/jxtkL9dvdC21UIVOAzVNxbJNr/pEMhQB
         vp8d7e0tnQxQwojbtN4cRm/XMqTkx92+i99Qufdb3s6hJdK+yif4G9DFDVX1hEhzAu6a
         03zg+Zdf2XWtAWNt1NrbghwsZIg99fdeq7U/gApeT4kmDYVmT0l8mUUqcxGQCmrUuLeA
         BXje0jwrKNFO/b7K2QONHqBXAQ+QZOZl0jM5ySbdsOy3G5HV4xZyQMi46T7EDAGU0itK
         YgAM/xDUMTu8xIV3/TfkYBqdDs72rEA29wI/OSSIDQFNQdnrSnXRPzIhX6ltmF/8jwR0
         thFw==
X-Gm-Message-State: AOJu0YxUFenZVF2AyNAtsEMv7NWJndKlLl3QCnVn2V36XE0dxBzn7Li5
	CQ4XYi7pAeFEiVSp8cwmHXaBCxYqetJQAv8q/Ark3V3trAyYKKTdTkJjQlso6A==
X-Gm-Gg: ASbGncvFjy8PTlywnm/12IcTRgb+x/ns7XM7XUmjPvqNNk9SR6Zh+4QrUQkg59iC2Rp
	7Mo5/IxlSVDjfVZZ4YB8Y35RA4oRA0Im5fKaNcfrT6I7AsTARg8zSxXkG8GlZWQ1o+y2SUIxOi5
	C1eH//cXfF09cBIq+jtMwjBOXRve+6oG2+GnvpSp8NM38XxPFMpFT41O1cck4hGuYy0tfIfXddV
	N0zpk9HHdpwAovayL5ok/jfjM6ndtmw2MqFvasdaaSMjwHxK4H5KwYe99lU1Ec/sTqJrk9k+2Zr
	reCWE+L2WzBNocszyfQLwGCYrUwArkdtNxy034RsdSD8
X-Google-Smtp-Source: AGHT+IFXDr6OAA2t3HKjq2+xO1gd3aSvGJE9Wiie2RWV4vS6z7EBc1bS1TGjr3U21mMxYJJRuOewlA==
X-Received: by 2002:a17:902:ebc9:b0:21f:1348:10e6 with SMTP id d9443c01a7336-2291ddbbf82mr5164155ad.13.1743084597588;
        Thu, 27 Mar 2025 07:09:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227e452ec2bsm52232815ad.193.2025.03.27.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:09:57 -0700 (PDT)
Date: Thu, 27 Mar 2025 07:09:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.15
Message-ID: <Z-VcNKV8_pUqMTBw@mini-arch>
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
https://lore.kernel.org/netdev/20250326140948.18a7da36@kernel.org/T/#u

Previous cycle:
19 Nov to 21 Jan: 4189 mailing list messages, 63 days, 66 messages per day
378 repo commits (6 commits/day, 42.86% of these are selftests)
https://lore.kernel.org/bpf/Z5EpWMev1CIAQjpT@mini-arch/

Current cycle:
12 Jan to 27 Mar: 5314 mailing list messages, 64 days, 83 messages per day
337 repo commits (5 commits/day, 48.07% of these are selftests)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [7] Alexei Starovoitov       1 ( +1) [18] Alexei Starovoitov  
   2 (   ) [4] Andrii Nakryiko          2 ( -1) [13] Andrii Nakryiko     
   3 ( +3) [3] Jakub Kicinski           3 ( +1) [10] Martin KaFai Lau    
   4 ( +7) [3] Martin KaFai Lau         4 ( -1) [10] Eduard Zingerman    
   5 ( -1) [3] Eduard Zingerman         5 (***) [ 7] Willem de Bruijn    
   6 ( -3) [2] Jiri Olsa                6 ( +4) [ 5] Jakub Kicinski      
   7 ( +2) [2] Stanislav Fomichev       7 ( +7) [ 5] Stanislav Fomichev  
   8 (***) [1] Hou Tao                  8 (+41) [ 5] Hou Tao             
   9 (***) [1] Simon Horman             9 (+18) [ 5] Yury Norov          
  10 (   ) [1] Quentin Monnet          10 ( -5) [ 5] Jiri Olsa           
  11 ( +8) [1] Song Liu                11 (***) [ 4] Maciej Fijalkowski  
  12 (+10) [1] Paolo Abeni             12 (+21) [ 4] Vladimir Oltean     
  13 ( -1) [1] Yonghong Song           13 (+27) [ 4] Tejun Heo           
  14 ( -6) [1] Peter Zijlstra          14 ( -8) [ 3] Peter Zijlstra      
  15 ( -2) [1] Steven Rostedt          15 (***) [ 3] Simon Horman        

Top authors (cs):                    Top authors (msg):                  
   1 (+21) [1] Jiayuan Chen             1 (+10) [14] Jason Xing          
   2 (***) [1] Amery Hung               2 ( -1) [13] Kumar Kartikeya Dwivedi
   3 ( +1) [1] Kumar Kartikeya Dwivedi    3 (+15) [12] Amery Hung          
   4 (+16) [1] Bastien Curutchet        4 (+35) [11] Faizal Rahim        
   5 ( +4) [1] Andrii Nakryiko          5 ( +8) [10] Bastien Curutchet   
   6 ( -1) [1] Eduard Zingerman         6 (***) [ 7] Mykyta Yatsenko     
   7 (+14) [1] Mykyta Yatsenko          7 (+26) [ 7] Andrea Righi        
   8 (***) [1] Jason Xing               8 ( +6) [ 6] Jiayuan Chen        
   9 (***) [1] Blaise Boscaccy          9 (***) [ 6] Kuan-Wei Chiu       
  10 (+23) [1] Yonghong Song           10 (+28) [ 6] Peilin Ye           

Top scores (positive):               Top scores (negative):              
   1 (   ) [109] Alexei Starovoitov     1 ( +6) [55] Jason Xing          
   2 (   ) [ 82] Andrii Nakryiko        2 (+36) [44] Faizal Rahim        
   3 ( +2) [ 55] Martin KaFai Lau       3 (+15) [44] Amery Hung          
   4 ( +3) [ 42] Jakub Kicinski         4 ( -3) [43] Kumar Kartikeya Dwivedi
   5 ( -1) [ 40] Eduard Zingerman       5 ( +4) [39] Bastien Curutchet   
   6 ( +4) [ 33] Stanislav Fomichev     6 (***) [27] Mykyta Yatsenko     
   7 (+38) [ 25] Willem de Bruijn       7 ( +3) [25] Jiayuan Chen        
   8 (+12) [ 21] Tejun Heo              8 (***) [24] Kuan-Wei Chiu       
   9 (***) [ 20] Simon Horman           9 (+19) [24] Peilin Ye           
  10 ( -2) [ 20] Quentin Monnet        10 (+26) [22] Andrea Righi        

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [15] Meta                    1 (   ) [54] Meta                
   2 ( +1) [ 5] RedHat                  2 (   ) [14] RedHat              
   3 ( +1) [ 4] Intel                   3 ( +1) [13] Intel               
   4 ( -2) [ 3] Isovalent               4 ( +1) [13] Google              
   5 (   ) [ 3] Google                  5 ( -2) [ 6] Isovalent           
   6 ( +9) [ 2] Huawei                  6 (+10) [ 6] Huawei              
   7 (   ) [ 1] Hedgehog                7 ( +5) [ 5] Samsung             

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [7] Meta                     1 (   ) [49] Meta                
   2 (   ) [2] Google                   2 ( +2) [23] Intel               
   3 ( +3) [2] Huawei                   3 ( -1) [22] Google              
   4 ( +5) [1] Unknown                  4 ( +7) [14] Tencent             
   5 ( +5) [1] Bytedance                5 ( +5) [13] Bytedance           
   6 ( +5) [1] Bootlin                  6 ( +7) [10] Alibaba             
   7 (+50) [1] Tencent                  7 ( +2) [10] Bootlin             

Top scores (positive):               Top scores (negative):              
   1 ( +2) [119] Meta                   1 ( +5) [56] Tencent             
   2 (   ) [ 74] RedHat                 2 ( +7) [41] Alibaba             
   3 ( -2) [ 24] Isovalent              3 ( +2) [40] Bootlin             
   4 (   ) [ 20] Hedgehog               4 ( +3) [38] Bytedance           
   5 (+11) [ 17] Samsung                5 ( -2) [37] Unknown             
   6 ( +2) [ 14] Linux Foundation       6 (+13) [32] nVidia              
   7 (***) [ 14] NXP                    7 (***) [25] Intel               

More raw stats
--------------

Prev: start: Tue, 19 Nov 2024 17:53:58 +0000
	end: Tue, 21 Jan 2025 18:00:07 +0100
Prev: messages: 4189 days: 63 (66 msg/day)
Prev: direct commits: 378 (6 commits/day)
Prev: test commits: 162 (42.86%)
Prev: people/aliases: 260  {'author': 86, 'commenter': 118, 'both': 56}
Prev: review pct: 23.54%  x-corp pct: 19.31%

Curr: start: Tue, 21 Jan 2025 22:23:15 -0800
	end: Thu, 27 Mar 2025 11:53:44 +0800
Curr: messages: 5314 days: 64 (83 msg/day)
Curr: direct commits: 337 (5 commits/day)
Curr: test commits: 162 (48.07%)
Curr: people/aliases: 286  {'author': 93, 'commenter': 132, 'both': 61}
Curr: review pct: 25.52%  x-corp pct: 22.55%

Diff: +24.9% msg/day
Diff: -12.2% commits/day
Diff: +8.3% people/day
Diff: review pct: +2.0%
      x-corp pct: +3.2%

Contributions to selftests:
   1 [ 41] Bastien Curutchet
   2 [ 17] Alexis Lothoré
   3 [ 10] Kumar Kartikeya Dwivedi
   4 [ 10] Eduard Zingerman
   5 [  8] Mykyta Yatsenko
   6 [  8] Amery Hung
   7 [  8] Jiayuan Chen
   8 [  6] Ihor Solodrai
   9 [  6] Daniel Xu
  10 [  5] Saket Kumar Bhaskar

