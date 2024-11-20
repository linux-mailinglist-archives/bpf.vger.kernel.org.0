Return-Path: <bpf+bounces-45278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E29D4031
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23908B291C1
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060A13DDAA;
	Wed, 20 Nov 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esgsGix/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76213B58A
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117778; cv=none; b=MYhQ61rWa/iQfSYmapphLXpIBl42NVqBG83F99yw1T8WHJfX7V2dsb5QR23L7lbO2aA96R+Uy+OeyR8nkovB6tHFvjlpyNmlBQuzVq/WA093HuIl90qhwmEJtypRjVqQWA2gKXBLiYqHyfjd5YDfHHfTAs7UiBCqUm85N8Skvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117778; c=relaxed/simple;
	bh=tkQ7jddLci4eogI9ieY/1d8adYVcj6Lc9ahpScXVYbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e2WB9tIugW/F4yGQps4LbQbHM0UDVBLhXjH/b34IramHOcsemlc51ag3gdHHgqOArYsrSjiYuVWuIePafJMKoRMQlaJgw68QNbZUuiKq5XnyqiyzzIV03gbj2Fbg1jXDop5irlZsabksMh0/e1oxrneHGQFxQotf1ikdx+rbaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esgsGix/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso3481081a12.3
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 07:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732117776; x=1732722576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMt0xbR/oZEGUM7wcOtqvDP/wNyQi/EC4Rv+0q7iGEc=;
        b=esgsGix/TiXQYFybuJQKwGXMqYfFSPDCwZoekZz7nt8FBZwYxBcwQYjMEo5yJeU79I
         ggc847SThU7ppY24feFuqcOPTZoo8nd/86+Kh6mVYwYp3WEtyKvZ8NRl6F8tQspSaNUK
         zV6xTXvF88tIC0SiKGo9/2Wt/mTBNhS5At3KuwHE7UEhTpMyhzy2JtCQ09xfjRjC0D4Y
         OGLvtb1Ip0xFiWTPxHy/NfQtSV9fd633xjqXjPz/swUbgfBYhjZa8X9v99R0nyAcco19
         4hZF4CEISghM01/ML/iR51bDc2B0mu7ShsCnrTF/6MMxrhWoa/pVFaeDpPagMRMvIqqm
         5h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732117776; x=1732722576;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMt0xbR/oZEGUM7wcOtqvDP/wNyQi/EC4Rv+0q7iGEc=;
        b=gGKF/iJVchnFYVGt2E5LLmje33qbeu1yG1Vsg57fnw5nEBvRCi1BdLHkkGV1Zwfwh5
         9a3NB884UJTnZHrUIXNyENBRfyosCu/cJV/0ldVnG21CW1cH3NWNhNTlyrEt/s0hl38G
         f3Cg+wHBNSx6+keVKyNbCb0w+BjRD+WIApMMwm7Bz7d/qqW2frnheiaY/A58zFJprVXp
         ATP24A8ZFb6vUzHBO10KRwxyVDzlMroi8lLhKLpe/Ow6/NgcaX60NB7Sg2WoIo19wzEQ
         g0knQPmS0b21Jfjk7eNHYuNgC300Kb6W6XJYGeKGK9HARVmm8zbeFRPfn+0iww62Wecc
         tdng==
X-Gm-Message-State: AOJu0YxfGayqwZrI5u1O1+fMZW0dMahiT8sT+tSpbXw/o6Igyq+GyII4
	O4TikpoHI2CCohrBxczY9UmBOXYqGk9v5+fBCUOAiPJMnVeoEA+ILOLe
X-Google-Smtp-Source: AGHT+IE07HtaCOFxid5tEM1MMwr7dSn3zxxftiTZlQgHjJNmbsO2MNuLZzdNNh8A3TQNIwt1e3KX3A==
X-Received: by 2002:a05:6a21:e85:b0:1db:e3c7:9974 with SMTP id adf61e73a8af0-1ddae9bc8b6mr5014594637.12.1732117776076;
        Wed, 20 Nov 2024 07:49:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724c4118e79sm1270465b3a.59.2024.11.20.07.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:49:35 -0800 (PST)
Date: Wed, 20 Nov 2024 07:49:34 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 6.13
Message-ID: <Zz4FDv5bnghUlJQP@mini-arch>
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
https://lore.kernel.org/netdev/20241119191608.514ea226@kernel.org/T/#u

Previous cycle:
16 Jul to 16 Sep: 5077 mailing list messages, 62 days, 82 messages per day
247 repo commits (4 commits/day, 45.75% of these are selftests)
https://lore.kernel.org/bpf/ZvH8f643jvK_gkyJ@mini-arch/

Current cycle:
19 Sep to 19 Nov: 5097 mailing list messages, 61 days, 84 messages per day
260 repo commits (4 commits/day, 56.92% of these are selftests)

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [7] Andrii Nakryiko          1 ( +1) [21] Alexei Starovoitov  
   2 (   ) [7] Alexei Starovoitov       2 ( -1) [19] Andrii Nakryiko     
   3 ( +1) [3] Martin KaFai Lau         3 ( +1) [ 8] Martin KaFai Lau    
   4 ( +2) [2] Yonghong Song            4 ( -1) [ 7] Eduard Zingerman    
   5 (+11) [2] Daniel Borkmann          5 ( +2) [ 5] Jiri Olsa           
   6 ( -3) [2] Eduard Zingerman         6 (***) [ 5] Willem de Bruijn    
   7 ( -2) [2] Jiri Olsa                7 (+16) [ 5] Steven Rostedt      
   8 ( -1) [2] Jakub Kicinski           8 (+12) [ 5] Toke Høiland-Jørgensen
   9 ( +3) [1] Toke Høiland-Jørgensen    9 ( -3) [ 4] Yonghong Song       
  10 (+12) [1] Peter Zijlstra          10 ( +4) [ 4] Stanislav Fomichev  
  11 (+44) [1] Tejun Heo               11 (+18) [ 4] Daniel Borkmann     
  12 ( +1) [1] Simon Horman            12 (+12) [ 4] Song Liu            
  13 ( -3) [1] Stanislav Fomichev      13 ( -2) [ 3] Maciej Fijalkowski  
  14 (***) [1] Kumar Kartikeya Dwivedi   14 (+32) [ 3] Peter Zijlstra      
  15 ( -1) [1] Quentin Monnet          15 (***) [ 3] Kumar Kartikeya Dwivedi

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [2] Andrii Nakryiko          1 (+19) [11] Jiri Olsa           
   2 (***) [1] Hou Tao                  2 (+13) [11] Yonghong Song       
   3 ( +7) [1] Jiri Olsa                3 (+47) [11] Alexander Lobakin   
   4 (+14) [1] Namhyung Kim             4 ( +2) [ 8] Masami Hiramatsu (Google)
   5 (+30) [1] Daniel Borkmann          5 (***) [ 8] Hou Tao             
   6 ( -3) [1] Eduard Zingerman         6 (+21) [ 7] Mathieu Desnoyers   
   7 (***) [1] Zijian Zhang             7 (***) [ 7] Menglong Dong       
   8 (***) [1] Kumar Kartikeya Dwivedi    8 (+29) [ 6] Xuan Zhuo           
   9 (***) [1] Zhu Jun                  9 ( -8) [ 5] Andrii Nakryiko     
  10 (+24) [1] Alexei Starovoitov      10 (***) [ 5] Zijian Zhang        

Top scores (positive):               Top scores (negative):              
   1 (   ) [122] Alexei Starovoitov     1 (***) [38] Alexander Lobakin   
   2 (   ) [108] Andrii Nakryiko        2 (+16) [28] Mathieu Desnoyers   
   3 ( +2) [ 33] Martin KaFai Lau       3 (***) [26] Menglong Dong       
   4 ( +5) [ 31] Eduard Zingerman       4 ( +6) [25] Masami Hiramatsu (Google)
   5 ( -2) [ 25] Jakub Kicinski         5 (+29) [25] Xuan Zhuo           
   6 (+13) [ 22] Steven Rostedt         6 (+46) [20] Zijian Zhang        
   7 (***) [ 22] Daniel Borkmann        7 (***) [20] Jason Xing          
   8 (+15) [ 18] Peter Zijlstra         8 ( -1) [18] Alexis Lothoré      
   9 (***) [ 18] Tejun Heo              9 (***) [17] Hou Tao             
  10 (   ) [ 18] Stanislav Fomichev    10 ( +7) [16] Hari Bathini        

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [16] Meta                    1 (   ) [55] Meta                
   2 ( +3) [ 5] Intel                   2 ( +2) [17] Google              
   3 (   ) [ 4] Isovalent               3 ( +2) [16] Intel               
   4 ( -2) [ 4] RedHat                  4 ( -2) [14] RedHat              
   5 ( -1) [ 3] Google                  5 ( -2) [11] Isovalent           
   6 ( +1) [ 1] SUSE                    6 (+12) [ 4] Linaro              
   7 ( +7) [ 1] Linaro                  7 ( +1) [ 3] Huawei              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [7] Meta                     1 (   ) [38] Meta                
   2 ( +1) [4] Huawei                   2 ( +1) [17] Huawei              
   3 ( +1) [3] RedHat                   3 ( +3) [16] Isovalent           
   4 ( +2) [2] Isovalent                4 ( -2) [15] Google              
   5 ( -3) [2] Google                   5 ( +2) [13] Intel               
   6 (+18) [2] Alibaba                  6 ( -1) [10] RedHat              
   7 (***) [1] China Mobile             7 ( +7) [ 9] IBM                 

Top scores (positive):               Top scores (negative):              
   1 (   ) [156] Meta                   1 ( +2) [49] Huawei              
   2 ( +3) [ 46] Intel                  2 ( +8) [31] Alibaba             
   3 ( -1) [ 46] RedHat                 3 (***) [28] EfficiOS            
   4 (***) [ 26] Google                 4 (***) [26] ZTE                 
   5 ( +2) [ 20] SUSE                   5 ( +4) [23] IBM                 
   6 (+22) [ 19] Linaro                 6 ( +2) [21] Bytedance           
   7 ( -1) [ 18] Linux Foundation       7 (***) [20] Tencent             

More raw stats
--------------

Prev: start: Wed, 17 Jul 2024 00:36:44 +0000
	end: Tue, 17 Sep 2024 05:41:18 +0800
Prev: messages: 5073 days: 62 (82 msg/day)
Prev: direct commits: 225 (4 commits/day)
Prev: test commits: 101 (44.89%)
Prev: people/aliases: 312  {'author': 119, 'commenter': 136, 'both': 57}
Prev: review pct: 19.11%  x-corp pct: 14.67%

Curr: start: Thu, 19 Sep 2024 23:04:43 +0200
	end: Tue, 19 Nov 2024 16:34:56 +0100
Curr: messages: 5097 days: 61 (84 msg/day)
Curr: direct commits: 260 (4 commits/day)
Curr: test commits: 148 (56.92%)
Curr: people/aliases: 315  {'author': 124, 'commenter': 138, 'both': 53}
Curr: review pct: 30.38%  x-corp pct: 27.69%

Diff: +2.1% msg/day
Diff: +17.4% commits/day
Diff: +2.6% people/day
Diff: review pct: +11.3%
      x-corp pct: +13.0%

