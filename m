Return-Path: <bpf+bounces-70350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15433BB8404
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBDC24E42E1
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836E272E5A;
	Fri,  3 Oct 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHv3xiB0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549302727E3
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528788; cv=none; b=C0/tVpdFa0sd8Gy2bN0hVoc+pPGY6EMNP7Lzn+S+8cvynkLenRHT0Y+bOcsGgFf33CzCp3yjR27i5/GyMkmuRlMWUPDy9Tf1thhgSUluMoQX3t00QAH3X9rRsc75NNsfFyV/x3p39vTAPR4Wk6BjX6vwiZS5y43Darz7U1l0DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528788; c=relaxed/simple;
	bh=wfVBIMskKuPjHnD7Ylrwz3TDlUFKDyI9Zo4BVgGLpkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lsbie9qeEK37ho2s7rTs1lAK6p51RVuZvC8GBBb5OrZqpu9STUM22kwnSfe9TlHYMf79UAXQj6lFZl3qyJtZm/y+socK+qs07cbkMMiTcv1JK4asxhJiJFQPeX6XPkfPz1P2K5siSz0NG1HkixkdxU1QmXcU2nzRKBu/tTxZujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHv3xiB0; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b609a32a9b6so1885171a12.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759528786; x=1760133586; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCPAv1U/9CPAskshhVPk+/9hL/eglvl84TwikL/enIk=;
        b=SHv3xiB06bnTuI2EqqZGg732IEwPj8bkqNjEknRNdVE2WFscBEZ2G3HkwGs5ujxCT3
         +DQ6Z1iukXG2RxewuQDML1P0uMlrtBhdyqIhYBrwABzqGg3RiqWMbg5u9bEOMLi8sLFn
         HSZgVr0hq5fIhdRD4BKf0UQ1hB6ea+FscoUBPeYP3LHHHM0R2FGegfqGWU7W3tduz8RG
         kY18kqcNF9AZpRYUQLnlZJWQzBk4WHe+IhjRh38hhF5toD2FmYN5WnE6EUOuHC/CwiVY
         Jl+k1rapMPMVQk3tgLM7HDknj/UNjS7IbY0QHkeZWlPe+LTH+dNeZqo8w1LXV+hwZjop
         r86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759528786; x=1760133586;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCPAv1U/9CPAskshhVPk+/9hL/eglvl84TwikL/enIk=;
        b=AA3H/CAt/Fu3vMMUVMoHot7PtVzhGWk1RSdyV+gSSx+48xD5N8tcEPR7y56ZR5l8A+
         Tx/WWz7IR/ZiN7A3FBMjJlUznR5Pw/KzvYl8yDKsF9fvUrYDH0DvbgHng3VIspB8wM9l
         1yQrqqpcybZg6hM2U0RBs/CNzyRBdyuBmBTT/tRd36zWFOVqxZMB++15fe+trqRGabmV
         EL5CtCYZVZLk4UZ2gsEKRl1GGqNhuZ0jQS4hedBWrx9TjTVvQuU3iboMrzoFohk040Rj
         1nJ7gUDw1eWkMgdzZkkAfuiXGdITFYCdnQL411x4k0V1sVBbQ8/PE8Amt7O8DSFQY4dL
         78fA==
X-Gm-Message-State: AOJu0YznkIycWQsFmMbJ8mtVm8lrJL+l+rYxqnJQIHsF+dCffSMQzJVG
	kYoFm+t5fUuIiEzQLh2xIyWTD43m/HI3Gm6jPIsjIF4MgwXyrwW4rCgCJU2+
X-Gm-Gg: ASbGncs4dcJ35tUsQWeZSW9/tqTwX3tkjIYUF0C9+wYgpWeq8aTUmAF06CujI/7QGzw
	nEAU+qWJ0fbc3Z4zu6I+H/49yMfvhaH4COnL/XzCMeVnTkYErSJjWXPEDJ/vcDiuvPmfIdCVIvn
	JNyuuNUJjJwXfWXp6wGqMsNUey3jRpLZ24vYNoY6BAHUXPPxfX9mbTkaL7/z0LCyS/sUiHEMS14
	m9TdiEDRc6JmyG9RMF6g1habA6BrQqR4/lqPlY1RIzYxdVRUFFSgrhVYszbDOW4XNoSEud9s1+5
	MNiQqCGP9l5takiubFiIPipx+L2txjOR0WpcJjEmu33IrNFhhawKixM5/aELnUtjEE5180QdseU
	GVvkhs9oPe8jo0/JBim3TY/Rq5GqqETRvvfawW66MblcRgybRxiOJ+K024n2ylCdl+QYFDnu+x1
	n7I5gf5sMy5U982U27eC0Bj+c9ao+GWdHjAmx6FzTSasM/GldBCpdYC3ZyPVJ4WM7D1ogdaHflD
	Fp7jyTv3RATw0XIAuZH07dSuAnt
X-Google-Smtp-Source: AGHT+IHqFUbiIjM3kmpnA5ZiTvVYtX7jpjdINfd8Ii5s7eD+U228aQX0ghulRkoAZSBtEyFjtsN9Aw==
X-Received: by 2002:a17:903:1104:b0:267:c984:8d9f with SMTP id d9443c01a7336-28e9a5a11eemr57845865ad.24.1759528786119;
        Fri, 03 Oct 2025 14:59:46 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1ea92csm59548505ad.123.2025.10.03.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:59:45 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:59:45 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.18
Message-ID: <aOBHUT26KS86wx-n@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Regular development statistics update, similar Jakub's netdev post:
http://lore.kernel.org/netdev/20251002171032.75263b18@kernel.org

Previous cycle:
28 May to 28 Jul: 5367 mailing list messages, 61 days, 88 messages per day
376 repo commits (6 commits/day, 40.69% of these are selftests)
https://lore.kernel.org/bpf/aIk4WpUDiLoSsoUe@mini-arch/

Current cycle:
28 Jul to 28 Sep: 5327 mailing list messages, 62 days, 86 messages per day
437 repo commits (7 commits/day, 38.9% of these are selftests)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [9] Alexei Starovoitov       1 ( +2) [19] Andrii Nakryiko     
   2 (   ) [6] Andrii Nakryiko          2 ( -1) [19] Alexei Starovoitov  
   3 (   ) [4] Eduard Zingerman         3 ( -1) [16] Eduard Zingerman    
   4 (   ) [3] Yonghong Song            4 ( +1) [ 8] Yonghong Song       
   5 ( +6) [2] Martin KaFai Lau         5 (+12) [ 7] Martin KaFai Lau    
   6 ( -1) [2] Jakub Kicinski           6 ( -2) [ 6] Jakub Kicinski      
   7 ( +1) [2] Daniel Borkmann          7 ( +9) [ 5] Kumar Kartikeya Dwivedi
   8 ( -1) [2] Jiri Olsa                8 (***) [ 4] Lorenzo Stoakes     
   9 (+14) [1] Kumar Kartikeya Dwivedi  9 ( +1) [ 4] Jiri Olsa           
  10 ( -4) [1] Stanislav Fomichev      10 ( -4) [ 4] Stanislav Fomichev  
  11 ( -1) [1] Quentin Monnet          11 ( -3) [ 4] Peter Zijlstra      
  12 (+30) [1] Masami Hiramatsu        12 (***) [ 3] Shakeel Butt        
  13 (+33) [1] Song Liu                13 (+11) [ 3] Maciej Fijalkowski  
  14 (+14) [1] Peter Zijlstra          14 ( +6) [ 3] Daniel Borkmann     
  15 ( -3) [1] Tejun Heo               15 (+14) [ 3] Linus Torvalds      

Top authors (cs):                    Top authors (msg):                  
   1 (+40) [1] Leon Hwang               1 (+37) [14] Ian Rogers          
   2 (+13) [1] Menglong Dong            2 ( +1) [11] Chia-Yu Chang       
   3 (+27) [1] Amery Hung               3 (+34) [11] Amery Hung          
   4 ( +3) [1] Steven Rostedt           4 (+28) [10] Leon Hwang          
   5 (***) [1] Jiri Olsa                5 (+11) [ 9] Menglong Dong       
   6 (+49) [1] Kumar Kartikeya Dwivedi  6 (+21) [ 9] Mykyta Yatsenko     
   7 (***) [1] Hengqi Chen              7 (***) [ 8] Kuniyuki Iwashima   
   8 ( -4) [1] Tao Chen                 8 ( -4) [ 7] Jiri Olsa           
   9 ( +3) [1] Alexei Starovoitov       9 ( -8) [ 6] Steven Rostedt      
  10 ( -7) [1] Eduard Zingerman        10 ( +8) [ 6] Alexander Lobakin   

Top scores (positive):               Top scores (negative):              
   1 (   ) [145] Alexei Starovoitov     1 (***) [54] Ian Rogers          
   2 (   ) [120] Andrii Nakryiko        2 ( +1) [44] Chia-Yu Chang       
   3 ( +2) [ 62] Eduard Zingerman       3 (+20) [42] Leon Hwang          
   4 ( +7) [ 52] Yonghong Song          4 ( +8) [37] Menglong Dong       
   5 ( +9) [ 45] Martin KaFai Lau       5 (***) [34] Mykyta Yatsenko     
   6 ( -3) [ 36] Jakub Kicinski         6 (+34) [32] Amery Hung          
   7 ( -3) [ 26] Stanislav Fomichev     7 (***) [30] Kuniyuki Iwashima   
   8 ( -2) [ 20] Quentin Monnet         8 (***) [23] Jiawei Zhao         
   9 (***) [ 17] Kumar Kartikeya Dwived 9 (***) [22] Yafang Shao         
  10 (***) [ 15] Song Liu              10 ( +7) [22] KP Singh            

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [17] Meta                    1 (   ) [76] Meta                
   2 (   ) [ 5] Intel                   2 ( +2) [13] Intel               
   3 (   ) [ 4] Isovalent               3 (   ) [ 9] RedHat              
   4 ( +1) [ 3] Google                  4 ( -2) [ 9] Google              
   5 ( -1) [ 3] RedHat                  5 ( +2) [ 7] Oracle              
   6 ( +3) [ 1] Hedgehog                6 (   ) [ 7] Isovalent           
   7 ( +4) [ 1] SUSE                    7 (+11) [ 3] nVidia              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [5] Meta                     1 ( +1) [40] Google              
   2 (   ) [4] Google                   2 ( -1) [34] Meta                
   3 (   ) [3] Isovalent                3 (   ) [20] Isovalent           
   4 (   ) [2] Tencent                  4 ( +7) [14] Tencent             
   5 (+23) [1] Shopee                   5 (+16) [12] Amazon              
   6 ( +8) [1] Kylin Software           6 ( -1) [11] Nokia               
   7 (+10) [1] Bytedance                7 (+10) [11] Bytedance           

Top scores (positive):               Top scores (negative):              
   1 (   ) [265] Meta                   1 (   ) [106] Google             
   2 ( +1) [ 43] Intel                  2 ( +1) [ 44] Nokia              
   3 ( -1) [ 38] RedHat                 3 (+10) [ 40] Tencent            
   4 ( +1) [ 20] Hedgehog               4 (+13) [ 39] Amazon             
   5 ( +2) [ 12] SUSE                   5 ( +9) [ 38] Shopee             
   6 ( +6) [ 11] Linaro                 6 (+10) [ 32] Bytedance          
   7 ( +8) [ 10] Loongson               7 (***) [ 23] Jiawei Zhao        

More raw stats
--------------

Prev: start: Wed, 28 May 2025 14:49:03 -0700
	end: Mon, 28 Jul 2025 20:27:01 +0000
Prev: messages: 5367 days: 61 (88 msg/day)
Prev: direct commits: 376 (6 commits/day)
Prev: test commits: 153 (40.69%)
Prev: people: 271  {'author': 93, 'commenter': 127, 'both': 51, 'none': 21}
Prev: people pct: {'author': 0.318, 'commenter': 0.435, 'both': 0.175, 'none': 0.072}
Prev: review pct: 31.91%  x-corp pct: 26.33%
Prev: avg revisions: single patch: 1.40 patch set: 2.41

Curr: start: Mon, 28 Jul 2025 23:34:56 +0200
	end: Sun, 28 Sep 2025 16:46:06 +0100
Curr: messages: 5327 days: 62 (86 msg/day)
Curr: direct commits: 437 (7 commits/day)
Curr: test commits: 170 (38.9%)
Curr: people: 281  {'author': 93, 'commenter': 126, 'both': 62, 'none': 16}
Curr: people pct: {'author': 0.313, 'commenter': 0.424, 'both': 0.209, 'none': 0.054}
Curr: review pct: 30.66%  x-corp pct: 22.65%
Curr: avg revisions: single patch: 1.51 patch set: 2.45

Diff:  +2.3% linux-next size
Diff:  -2.3% ( -4.6%) msg/day
Diff: +14.3% (+11.7%) commits/day
Diff:  +2.0% ( -0.3%) people/day
Diff: review pct: -1.2%
      x-corp pct: -3.7%
Diff: avg revisions: single patch: +7.6% patch set: +1.4%

Contributions to selftests: total individuals: 45 (was 48, -6.25%)
Contributions to selftests:
   1 [ 17] Yonghong Song
   2 [ 17] Eduard Zingerman
   3 [ 12] Mykyta Yatsenko
   4 [ 12] Paul Chaignon
   5 [ 11] Amery Hung
   6 [  7] Puranjay Mohan
   7 [  7] Jakub Sitnicki
   8 [  7] Jordan Rife
   9 [  6] Ilya Leoshkevich
  10 [  5] Kumar Kartikeya Dwivedi
  11 [  5] Tao Chen
  12 [  5] Leon Hwang

