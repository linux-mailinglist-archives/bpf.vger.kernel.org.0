Return-Path: <bpf+bounces-29189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498798C11A3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A771F21E31
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26635157A41;
	Thu,  9 May 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7jem7BU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA012FF9B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267160; cv=none; b=QewVc4by5pok0XON6qVTgmaO6hXw9lmoPduAyR1y1VKqDHilTE6ZOp0RLxa3B97WsgZ1WwUGIGZNkdBmU2pfyOfMUifC3MMRc0MTduR4ccyE/3aC50cd7e7uu0HgEWNT30PhVCwxciMFnP0/Iu/AT1ilp1PFnzdevAg5btskZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267160; c=relaxed/simple;
	bh=bFblp9GPuxDDrw5lNonsHUOikNCZrRLj1M6yOnVJcfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdOINOBux75O00agT4Rw+gfFwipxB67RuBCzf1wwQaagxHA9UBkoOX+wYwn/PdmInStX61vIJj/6birWNgBTU3qguWS0ow8CXpD/u+qr2ql+2flxJskpAE92Vi/yjRYiwKCDbGHG+VgiKv1Cy8XwuxCHnH+w4nKsYKPFwyo9OWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7jem7BU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ee954e0aa6so6931205ad.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715267158; x=1715871958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duEtpGW/Box32ZySXEfoRhMS2YpqGZdZT5mTbByRDH0=;
        b=d7jem7BUNxhf6TKCaSIU036zMYaYBVTKQbT7HY2yIf4vR8zTDv0dfDW5UtY7K2s+wM
         mfbbfq1uFye192RR/WKyUQjT0t1iRheeZf9wru6QuoKEAJhH2MBgwESkNNjFMxbjpDjB
         AS9BXFyP2UX//tHRQdElMFhtvWR2kiB1O2xNPi6Ao0rGdHV2FGYPZmMR4rChrRssXU3S
         585ViwBiTJ3eLUr1pwXxK9uiivmgJw/EacDF2rtOXoLRyez2VcbNDffZYyTRcxKKbz+N
         hEng6w5bMxwEi9IDVmWPxIOA9JDjUoYY70EAzTJO+Pxz4xMbvM6PjU67iYdGgZDOLhsC
         moDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267158; x=1715871958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duEtpGW/Box32ZySXEfoRhMS2YpqGZdZT5mTbByRDH0=;
        b=azNE8w4z+AdFj2uFo8dZPdLgAx+gYBurfsW2JR2GT7vrZLdPWFwppuNuLgyVH1gD3F
         MJNvOOIPtMc6b1HTqU97vwuBnjKqnBGuGx3VK3bMUMELnEFNSGhIb5VFLxr4foUJOoWI
         G/u6a6fbzZCXFk5S2rN8OPNPCnpDXXNDIapUwH1EwTI+FBxGIRA5pH24UXgsqr+ysSHR
         QrUtdwAbLG3SsFqmJZhwkJ9Lg5plU65CMFa0jWpwZoqoo+Svs+GeQoUQ2qmQtp1mWdbq
         8JRsSuaEJxn/duTpBHPa+bl6vqlghmB8Dc3NmcpRoH8Aryr1b9RG/EF/m5vr/VlHq290
         3jMQ==
X-Gm-Message-State: AOJu0YzpcmJhL5iCsrRYpYuq36OoANjGednsiM43ztr3p+b7FVSHu0Lw
	K7p31s9lBpzQqjnvJxoUXTHh6l6gnYb6Fd3WUSgIqYbF0J9eN01eGbSB7w==
X-Google-Smtp-Source: AGHT+IHKZ5nHO2FLK7kqLF5yEI12xvq/KPrB+B3OAL4uXrAO/d9OxR7C7zmLQISNCgcBamA5fE2dMw==
X-Received: by 2002:a17:903:494:b0:1e0:b62a:c0a2 with SMTP id d9443c01a7336-1eeb0998a56mr53127775ad.51.1715267157678;
        Thu, 09 May 2024 08:05:57 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1642sm15376135ad.31.2024.05.09.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:05:57 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 1/5] bpf, verifier: Correct tail_call_reachable when no tailcall in subprog
Date: Thu,  9 May 2024 23:05:37 +0800
Message-ID: <20240509150541.81799-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509150541.81799-1-hffilwlqm@gmail.com>
References: <20240509150541.81799-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is tailcall in main prog but there is no tailcall in its
subprogs, prog->aux->tail_call_reachable is incorrect for this case.

In order to correct it, it has to check subprog[0].has_tail_call at the
time when to check subprog[0].tail_call_reachable in
check_max_stack_depth_subprog().

It's for fixing a tailcall issue whose patch relies on
prog->aux->tail_call_reachable.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e3aba08984e8..f874ee4b24486 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6000,7 +6000,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 			}
 			subprog[ret_prog[j]].tail_call_reachable = true;
 		}
-	if (subprog[0].tail_call_reachable)
+	if (subprog[0].tail_call_reachable || subprog[0].has_tail_call)
 		env->prog->aux->tail_call_reachable = true;
 
 	/* end of for() loop means the last insn of the 'subprog'
-- 
2.44.0


