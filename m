Return-Path: <bpf+bounces-40215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0801983A74
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 01:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7EB1C224EB
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794412CDBA;
	Mon, 23 Sep 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH6K6Sxc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBD12BF32
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727134851; cv=none; b=T2rcE0ikxt0QZU6RVCHbXcBry27d+x8pb9OEmIKSFWfy3XQF834qs46y4yscXSYJsXW18JBX02Ds/qFnnPH24pvI4BX3i5vSqJ05PmC19XPQ7FXWyzN/2oSuR4N59aqa/OeIGggf6biXc8rCR7f4bf6Q3CUdb7BnFSHXupQzXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727134851; c=relaxed/simple;
	bh=lih7Oq+kCRAy1ZCYZFVvfA2rCgmluuqdxt2UwRCCUUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=msl8WQV+gtfIT8Rs8l7J7QIg6rT1I9rgDNRB0k4DRtUPVGh1oGdytVwlwkKACSqYKYhVLlUwWlZ9FtnED3J9mxZXicjt0RTD44qTIvPKcGWs0v9ZwcFxsoADkBMREMUdTG7HTtLeTCmmuyJ7RqwE25Dndz8zqZdIwGOmmTW5dC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH6K6Sxc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20792913262so57877395ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 16:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727134849; x=1727739649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3x7kV0t0BwS+h8hmJz7CsPp0Gs9iGAzAhach2olk9Wg=;
        b=MH6K6Sxcr0IzQWgmwcXNqvHfZK2nQAmc1JPFGX3HKDg5KA8Id1k1OQEU+MMBb4X8eO
         yi3HzwC5J7UUNB6Aefb5FavjnN2zLxKeLqIAEh3ZDl9J/rV+JaG5dlfeOEnVf7RMOzCI
         KeVCuefQc96mnvYLhtPOFhMbbvp4StAFDK/cpe2OGtDQk5EKRjNXQTQG/OxnlSWW/H3B
         M4NfyNGJ8YSwxwEvgOCKLgxcnG2fFQQjzl8AugaXtaJA6lWPjP/vgKPuOYDx3qVOmPSo
         /nHTJR6dNeHXyMEWRbnm5wnxewAGIWkYjGal8ZVU6hxoWP/aCuYBuGcqecenVc5va/on
         tQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727134849; x=1727739649;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3x7kV0t0BwS+h8hmJz7CsPp0Gs9iGAzAhach2olk9Wg=;
        b=YDWgG557taKJhyNm/FCPV9iIfbPmF45ellmyQuSaxXldpQvZzT3RDddnzCAYcrTnIz
         jJ2reJDGs8haEUpbxQXB+ByGJAhKonqyEIthPafrblLhr8YSDZgA683/dK/qCXti4G3q
         1F5jvAxupsSQOzEWN/oqGIRR/C/fwLJZmHmkAhoDXSKDENzga3MzUJYwbnCyIvZ5Vp5Z
         pt7yLp3hmDIOH2YwGoIsMjNWCTFGRsS925ZGnAUVqx8181xP6Au1PYds+S57ZlsGocoN
         VboVfI7h18Coo6NMY892AYIPzJaBTqaZJikFa8th9P1zRJPP1U8tnL/JSbVpW6oSy3+J
         iMDw==
X-Gm-Message-State: AOJu0YyH+Jd/txA1dL4jTTqGhbua5NClagm/FfVLoGTsI1CQFCQD4FnL
	cVaNeZtdto0MeokikZp8HWVb+d9jClthdcra2DxJVNMRAmagM7Ef/c8F
X-Google-Smtp-Source: AGHT+IFQT4r4nPEB+muVUrJ9APjfA2wyKYm/wFE8zrGU+EF2MBMUe+pJuqPv2pR6IvicVmsOqxVzSw==
X-Received: by 2002:a17:902:da84:b0:1fc:6740:3ce6 with SMTP id d9443c01a7336-208d8384adamr197169335ad.20.1727134848623;
        Mon, 23 Sep 2024 16:40:48 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1831b1csm930675ad.226.2024.09.23.16.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 16:40:48 -0700 (PDT)
Date: Mon, 23 Sep 2024 16:40:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.12
Message-ID: <ZvH8f643jvK_gkyJ@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

As usual, sending out another update on the dev stats similar
to Jakub's netdev one:
https://lore.kernel.org/netdev/20240922190125.24697d06@kernel.org/

BPF 6.11 stats: https://lore.kernel.org/bpf/ZqANgbFHX128IZYV@mini-arch/

Previous cycle:
15 May to 16 Jul: 5213 mailing list messages, 63 days, 83 messages per day
552 repo commits (9 commits/day)

Current cycle:
16 Jul to 16 Sep: 5077 mailing list messages, 62 days, 82 messages per day
247 repo commits (4 commits/day 45.75% of these are selftests)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [8] Andrii Nakryiko          1 (   ) [25] Andrii Nakryiko     
   2 ( -1) [7] Alexei Starovoitov       2 (   ) [17] Alexei Starovoitov  
   3 ( +1) [3] Eduard Zingerman         3 (   ) [10] Eduard Zingerman    
   4 ( +4) [3] Martin KaFai Lau         4 ( +3) [ 8] Martin KaFai Lau    
   5 ( -2) [3] Jiri Olsa                5 ( +1) [ 8] Jakub Kicinski      
   6 (+11) [2] Yonghong Song            6 (+14) [ 6] Yonghong Song       
   7 (   ) [2] Jakub Kicinski           7 ( -3) [ 6] Jiri Olsa           
   8 (+25) [1] Arnaldo Carvalho de Melo    8 ( +5) [ 5] Oleg Nesterov       
   9 ( +2) [1] Alan Maguire             9 (***) [ 5] Christian Brauner   
  10 (+12) [1] Stanislav Fomichev      10 (***) [ 5] Guillaume Nault     
  11 (+10) [1] Oleg Nesterov           11 (+37) [ 4] Maciej Fijalkowski  
  12 (+26) [1] Toke Høiland-Jørgensen   12 ( +5) [ 3] Alan Maguire        
  13 ( +5) [1] Simon Horman            13 (+12) [ 3] Arnaldo Carvalho de Melo
  14 ( -4) [1] Quentin Monnet          14 (+12) [ 2] Stanislav Fomichev  
  15 (-10) [1] Masami Hiramatsu (Google)   15 (***) [ 2] Jitendra Vegiraju   

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [2] Andrii Nakryiko          1 ( +1) [16] Andrii Nakryiko     
   2 (***) [2] Mina Almasry             2 ( +1) [16] Mina Almasry        
   3 (+27) [1] Eduard Zingerman         3 (***) [12] Tony Ambardar       
   4 ( +1) [1] Yonghong Song            4 ( +5) [ 8] Kui-Feng Lee        
   5 (+31) [1] Tao Chen                 5 ( +7) [ 8] Eduard Zingerman    
   6 (***) [1] Dan Carpenter            6 ( +7) [ 7] Masami Hiramatsu (Google)
   7 (***) [1] Ihor Solodrai            7 (***) [ 6] Martin KaFai Lau    
   8 (+14) [1] Chen Ridong              8 (***) [ 6] Ido Schimmel        
   9 (***) [1] Tony Ambardar            9 ( +2) [ 6] Yafang Shao         
  10 ( -6) [1] Jiri Olsa               10 (***) [ 5] Uros Bizjak         

Top scores (positive):               Top scores (negative):              
   1 (   ) [121] Alexei Starovoitov     1 ( +1) [63] Mina Almasry        
   2 ( +3) [ 88] Andrii Nakryiko        2 (***) [46] Tony Ambardar       
   3 (   ) [ 39] Jakub Kicinski         3 ( +3) [28] Kui-Feng Lee        
   4 ( +2) [ 30] Jiri Olsa              4 (***) [23] Ido Schimmel        
   5 ( -1) [ 27] Martin KaFai Lau       5 ( +2) [21] Yafang Shao         
   6 (***) [ 24] Yonghong Song          6 (***) [20] Uros Bizjak         
   7 ( +6) [ 22] Oleg Nesterov          7 (+25) [18] Alexis Lothoré      
   8 (+19) [ 22] Arnaldo Carvalho de Melo    8 (***) [18] <viro@kernel.org>   
   9 ( -7) [ 21] Eduard Zingerman       9 (+16) [15] Pu Lehui            
  10 (+11) [ 18] Stanislav Fomichev    10 (***) [15] Masami Hiramatsu (Google)

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [14] Meta                    1 (   ) [57] Meta                
   2 ( +2) [ 5] RedHat                  2 (   ) [21] RedHat              
   3 ( -1) [ 5] Isovalent               3 (   ) [ 9] Isovalent           
   4 ( -1) [ 3] Google                  4 (   ) [ 9] Google              
   5 (   ) [ 3] Intel                   5 (   ) [ 6] Intel               
   6 (   ) [ 2] Oracle                  6 ( +1) [ 6] Microsoft           
   7 ( +4) [ 1] SUSE                    7 ( +1) [ 4] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [8] Meta                     1 (   ) [52] Meta                
   2 ( +1) [3] Google                   2 (   ) [27] Google              
   3 ( +2) [3] Huawei                   3 ( +4) [14] Huawei              
   4 ( +4) [2] RedHat                   4 (***) [12] Unknown             
   5 ( -3) [1] Intel                    5 ( -1) [11] RedHat              
   6 (   ) [1] Isovalent                6 ( -1) [ 7] Isovalent           
   7 ( +4) [1] Bytedance                7 ( +2) [ 7] Intel               

Top scores (positive):               Top scores (negative):              
   1 (   ) [100] Meta                   1 ( +1) [49] Google              
   2 ( +3) [ 67] RedHat                 2 (***) [45] Unknown             
   3 ( -1) [ 47] Isovalent              3 ( +1) [37] Huawei              
   4 ( +3) [ 19] Microsoft              4 ( +1) [21] Juniper Networks    
   5 ( -1) [ 16] Intel                  5 (***) [20] Unknown
   6 ( -3) [ 16] Linux Foundation       6 (***) [18] nVidia              
   7 (***) [ 11] SUSE                   7 ( +9) [17] Bootlin             

