Return-Path: <bpf+bounces-64675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EEB1548F
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 23:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649293A6A52
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F753272E56;
	Tue, 29 Jul 2025 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xlq7xKD/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA31E3DF2
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823325; cv=none; b=kj/VTBC20j0GxrMRcH/1OIOaDwQtKurt49uj+VUnrIVzrUcO85g2MqKMOF1BOJbQ+HT+21ABNeq6A73sZ5hJQGVVAzpvMwNiGewJxA1zfgXtInrFBCZh94zH52pRy94hrDrKGkFBSbXOkQ9aGrGEmgmEslDEuUm+yv3r/fDRiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823325; c=relaxed/simple;
	bh=j22ojZMZw6/sf8iCjVpAeXmVgRivcjAd1OC1SMTklaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fF+q4w1zRCyyoMd8WGIxssD9exNdDJLrWJKyMkcxyCvkmIRnuZL/LaWFWEDl19Cv/OBjVfkIkhcaw60h2+XD1F+U6vXTwhDvoXqX1NTxLJdzBIKUxbMW+6SugYvcKPBJXI7YgFJV8Mso6EZ4T72OvoC0MNYtRuuSyaZDHVdsreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xlq7xKD/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b350704f506so273651a12.0
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753823323; x=1754428123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xasvD/XnDJ31fbbfXbYGhVlLeIdou/l4/m3/bTbmWyE=;
        b=Xlq7xKD/XohgBn0FgF8dK+pwZ1qBElY7ToiF10JVnN+2vpFOC8I+PwG1vLQNBGTnPp
         eDxQAdzcPJkH0GRwPHXVU1Xe8N7R8pAriBU74+MglbsxVg17ZTYZGL7Puof/BbNuFR5h
         bftMVTpdpQW9WVgH8gVbDFOI9wbBbRgFw1EQS+vDpvjAbl/nqasxk1M2m4rIJ5V/NsVE
         xaFipH+dPMevG2k7WoW3F+8zKJMwv05GsX5ykZRHbeWiTFGnYQ3uXwucxmzgyOeilJzG
         W9V27RwbtUTj/ZHjPn06lJZGquIQKMkRULPYfJ7KGEHs98dZ18Ftl8dwtxfrMYRuXJ0S
         AkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753823323; x=1754428123;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xasvD/XnDJ31fbbfXbYGhVlLeIdou/l4/m3/bTbmWyE=;
        b=BFpHX5auE8M+Hx30HzpVTHbv86Ibx11EUHiAvMMGWkwj5im4ZmahuEeon1n3abYqcC
         nhbJsSdLq+ikiy9s7/a8vkE8YLU4E+dSzIlt+j3/T5UGw6VeRh3rS6Kc/C1DVcs8s6Lp
         i4nier7lS7QnpgXkx/a67MBynotfHCVcKlE8LECG4uZS5mUibeqOrndRNI7QZNhkmGbB
         L3UBH4B7io7XAOnNg6qj8fc/8XQpotpWUI/I/3xPUWzalhj7oeYGeWDRdOaGaYxio4b5
         oLRJg4OxoWoNC4QdWZhuJRd6zCJZYNR8n/I1pA2ihk3xNk6UKB2am6MobSooB0Ic1aYd
         ZSTw==
X-Gm-Message-State: AOJu0YxpAaA8w/zgUvbcXQO1BJAOn3Mhwz6FkydfqaVmpceg6eyk6UMH
	2PTenTVMOsucS+iVH9/jLddV7uddQ2mESqRV8yyBcTZuRawHYXYrcMrvtEfJ
X-Gm-Gg: ASbGncuHnN0JCIjnOJ0aD/Mq6IOk3yP9HOh1qa6S91rrZSjnHE5J6EeAU44BichaJkH
	OA8vjj4uyFciWTDpQVvkaj965x6vSg1JQtKT0+5NbC4B+PoDjJiYQJpPUYLSOrhxbCY+6w0hDwu
	cLZf+1gZqNMdnxP2XfEl2FE8xtNqA53YajCYwpZjcl2XiYxnBoDNavry9Dn6sNrF5jDm+OP8tL/
	3fLMyrvkOHk5CNt2fljHIsFDO2B4yuu2ZhAMkS3gf9rQfuQNkoj7u0VGexSKPJvsx7Vy9Txevnb
	xfh0FLEcxPO81l/pPfGfIocJxk2ddWs1nJJNSqskznlzS9GOH1sI/5lBm4YRIc+YfiJoOQlDtvH
	DbXbuWt+rMvcvoIjfvM3Uwto8CQLjVLxEyqbISPL7l7TnMlUjM/1rAvRQfko=
X-Google-Smtp-Source: AGHT+IGbFmyHmXchjUeGh53nVNtLJwBX1XHZzQeJasS5S8I+hHm28w3MTvzgwhaS+WXUUxc9Tb0s/g==
X-Received: by 2002:a17:903:8cd:b0:240:3f43:260 with SMTP id d9443c01a7336-24063d89224mr71198645ad.17.1753823323232;
        Tue, 29 Jul 2025 14:08:43 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2404d3f6241sm39437835ad.122.2025.07.29.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 14:08:42 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:08:42 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.17
Message-ID: <aIk4WpUDiLoSsoUe@mini-arch>
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
https://lore.kernel.org/netdev/20250728160647.6d0bb258@kernel.org/

Previous cycle:
27 Mar to 28 May: 4436 mailing list messages, 63 days, 70 messages per day
424 repo commits (7 commits/day, 43.16% of these are selftests)
https://lore.kernel.org/bpf/aDm70S-SHD4_BPKG@mini-arch/

Current cycle:
28 May to 28 Jul: 5367 mailing list messages, 61 days, 88 messages per day
376 repo commits (6 commits/day, 40.69% of these are selftests)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [7] Alexei Starovoitov       1 ( +1) [19] Alexei Starovoitov  
   2 (   ) [4] Andrii Nakryiko          2 ( +1) [15] Eduard Zingerman    
   3 ( +2) [3] Eduard Zingerman         3 ( -2) [13] Andrii Nakryiko     
   4 (+36) [3] Yonghong Song            4 (   ) [ 8] Jakub Kicinski      
   5 ( -2) [3] Jakub Kicinski           5 (+43) [ 7] Yonghong Song       
   6 (   ) [2] Stanislav Fomichev       6 ( +2) [ 7] Stanislav Fomichev  
   7 ( +5) [2] Jiri Olsa                7 (+22) [ 5] Pavel Begunkov      
   8 ( +2) [2] Daniel Borkmann          8 (+48) [ 5] Peter Zijlstra      
   9 ( -2) [1] Paolo Abeni              9 ( +1) [ 5] Mina Almasry        
  10 ( +3) [1] Quentin Monnet          10 ( +9) [ 4] Jiri Olsa           
  11 ( -7) [1] Martin KaFai Lau        11 ( +5) [ 3] Toke Høiland-Jørgensen
  12 ( +6) [1] Tejun Heo               12 ( +8) [ 3] Quentin Monnet      
  13 (+24) [1] Namhyung Kim            13 ( -2) [ 3] Paolo Abeni         
  14 (+16) [1] Toke Høiland-Jørgensen   14 (***) [ 3] Christian Brauner   
  15 ( -7) [1] Simon Horman            15 ( -8) [ 3] Vlastimil Babka     

Top authors (cs):                    Top authors (msg):                  
   1 ( +6) [2] Yonghong Song            1 (***) [24] Steven Rostedt      
   2 (***) [1] Jason Xing               2 (+11) [14] Byungchul Park      
   3 (+38) [1] Eduard Zingerman         3 ( -2) [12] Chia-Yu Chang       
   4 (+14) [1] Tao Chen                 4 (   ) [10] Jiri Olsa           
   5 ( +7) [1] Paul Chaignon            5 (+42) [10] Tao Chen            
   6 (+28) [1] Song Liu                 6 (+26) [ 9] Eduard Zingerman    
   7 (***) [1] Steven Rostedt           7 ( -5) [ 9] Jordan Rife         
   8 (***) [1] Luis Gerhorst            8 ( +2) [ 8] Yonghong Song       
   9 ( -3) [1] Mykyta Yatsenko          9 (***) [ 7] Song Liu            
  10 (+50) [1] Puranjay Mohan          10 (+27) [ 6] Paul Chaignon       

Top scores (positive):               Top scores (negative):              
   1 ( +1) [118] Alexei Starovoitov     1 (***) [87] Steven Rostedt      
   2 ( -1) [ 84] Andrii Nakryiko        2 ( +4) [55] Byungchul Park      
   3 (   ) [ 52] Jakub Kicinski         3 ( -2) [49] Chia-Yu Chang       
   4 ( +1) [ 43] Stanislav Fomichev     4 (+30) [40] Tao Chen            
   5 ( -1) [ 41] Eduard Zingerman       5 ( -3) [35] Jordan Rife         
   6 ( +3) [ 24] Quentin Monnet         6 (***) [23] Song Liu            
   7 ( +1) [ 20] Paolo Abeni            7 (+20) [21] Paul Chaignon       
   8 ( +7) [ 19] Mina Almasry           8 (***) [18] Mark Bloch          
   9 ( +3) [ 18] Daniel Borkmann        9 (***) [17] Jason Xing          
  10 (+22) [ 17] Peter Zijlstra        10 (***) [16] Mohsin Bashir       

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [14] Meta                    1 (   ) [60] Meta                
   2 ( +2) [ 5] Intel                   2 ( +1) [15] Google              
   3 ( +3) [ 4] Isovalent               3 ( -1) [15] RedHat              
   4 ( -2) [ 4] RedHat                  4 (   ) [14] Intel               
   5 ( -2) [ 3] Google                  5 (+23) [ 8] Microsoft           
   6 ( -1) [ 1] Oracle                  6 ( +1) [ 8] Isovalent           
   7 ( +1) [ 1] Linux Foundation        7 ( -1) [ 5] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [9] Meta                     1 (   ) [48] Meta                
   2 (   ) [3] Google                   2 (   ) [45] Google              
   3 ( +1) [2] Isovalent                3 (   ) [20] Isovalent           
   4 (***) [1] Tencent                  4 ( +5) [14] SK Hynix            
   5 (***) [1] DiDi                     5 ( +2) [12] Nokia               
   6 (   ) [1] RedHat                   6 (***) [10] DiDi                
   7 ( +6) [1] Intel                    7 ( -2) [ 9] Intel               

Top scores (positive):               Top scores (negative):              
   1 (   ) [117] Meta                   1 (   ) [105] Google             
   2 (   ) [ 55] RedHat                 2 ( +2) [ 55] SK Hynix           
   3 ( +5) [ 50] Intel                  3 ( -1) [ 49] Nokia              
   4 (***) [ 25] Microsoft              4 (***) [ 40] DiDi               
   5 (   ) [ 24] Hedgehog               5 (***) [ 18] nVidia             
   6 ( -2) [ 24] Oracle                 6 ( +4) [ 18] Isovalent          
   7 ( -4) [ 22] SUSE                   7 ( -1) [ 16] Kylin Software     

More raw stats
--------------

Prev: start: Wed, 26 Mar 2025 18:37:38 -0700
	end: Wed, 28 May 2025 23:11:35 +0000
Prev: messages: 4439 days: 63 (70 msg/day)
Prev: direct commits: 424 (7 commits/day)
Prev: test commits: 183 (43.16%)
Prev: people: 272  {'author': 88, 'commenter': 129, 'both': 55, 'none': 21}
Prev: people pct: {'author': 0.3, 'commenter': 0.44, 'both': 0.188, 'none': 0.072}
Prev: review pct: 23.35%  x-corp pct: 21.93%
Prev: avg revisions: single patch: 1.46 patch set: 2.48

Curr: start: Wed, 28 May 2025 14:49:03 -0700
	end: Mon, 28 Jul 2025 20:27:01 +0000
Curr: messages: 5367 days: 61 (88 msg/day)
Curr: direct commits: 376 (6 commits/day)
Curr: test commits: 153 (40.69%)
Curr: people: 271  {'author': 93, 'commenter': 127, 'both': 51, 'none': 21}
Curr: people pct: {'author': 0.318, 'commenter': 0.435, 'both': 0.175, 'none': 0.072}
Curr: review pct: 31.91%  x-corp pct: 26.33%
Curr: avg revisions: single patch: 1.40 patch set: 2.41

Diff:  -5.8% linux-next size
Diff: +24.9% (+32.5%) msg/day
Diff:  -8.4% ( -2.8%) commits/day
Diff:  +2.9% ( +9.2%) people/day
Diff: review pct: +8.6%
      x-corp pct: +4.4%
Diff: avg revisions: single patch: -3.7% patch set: -2.5%

Contributions to selftests:
   1 [ 19] Yonghong Song
   2 [ 13] Eduard Zingerman
   3 [ 13] Mykyta Yatsenko
   4 [  8] Paul Chaignon
   5 [  8] Michal Luczaj
   6 [  6] Ihor Solodrai
   7 [  6] Amery Hung
   8 [  5] Ilya Leoshkevich
   9 [  5] Luis Gerhorst
  10 [  5] Song Liu

