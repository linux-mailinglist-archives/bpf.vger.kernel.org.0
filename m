Return-Path: <bpf+bounces-71222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F11BEACF2
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0491B6E791E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6F289811;
	Fri, 17 Oct 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="o+sp+Vf/"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6D1448E0;
	Fri, 17 Oct 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716525; cv=none; b=JiH6uxeSiw6PuC+lnGez0FHj1fYpio+8EeqqeHeYX33PtK0701yMlChl0PPNMUb3ZwOIxNxjoCsx5hJMcqSsXCo8ELy9KXCl9qGBRAKmrIoonWTKYrg50486es5QVW33IHe6Jzuqjk84hvL0/DcpyCq5ohIbCS6ZKBWQR/WODys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716525; c=relaxed/simple;
	bh=LiB/8SOQ6pHviq19ZsPlD52HcMRhPceRSzpy+JzRraA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzYEznpxAhzz57QA1v3T6ABQZjd5vWLoyPW23heYZk9o3tugHgqzjX6r1I7Xp7pbn8sA0XAfvSwHmYCNuW8BpnqEURquuFMQABihi620kx+CdavPN2ofr438E9eWj8ZoU3c+yxDdbDxKVLsyLv8gxBHZ+yDUawQu77s+PhFVPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=o+sp+Vf/; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cp8Y328NDz9t7F;
	Fri, 17 Oct 2025 17:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760716519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64C4ZVgpgDDBsS1KhiL9t0Rq8Ol9iYeLpNcDR1OLqqk=;
	b=o+sp+Vf/rVU9gD+manASlMMeM/8WMWYx3r5g/jIhAbxLsukGRafR1ogLgUn9a2Z9hl17TI
	o14IG8XJ+7CRQq+0nISdl7YgpNcDm8fnK5+rjfFEnn73oAckjwgF1cIQ4QHurRpk4lh0vz
	FBHWU2i27ztNe665NX9sCNu+gegBv11DgYBY/JYRQCIMdLe13VQEGhgMCwEyDNE/Lmst2C
	vwi5wkilMoUi8PTPZPuXFVr17pDVm3FLKeWsBB3X+A2tGLc6wVvNFtz3Zd00GBi1chXGYu
	CnL2NDfVwgLfL1pl6pfK6RL9hMguAzun8YeVrq/hSzECaC3BKdPAcbugT4iQhw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	eddyz87@gmail.com,
	linux-kernel@vger.kernel.org,
	yangtiezhu@loongson.cn
Subject: [PATCH] selftests/bpf: Fix redefinition of 'off' as different kind of symbol
Date: Fri, 17 Oct 2025 21:24:50 +0530
Message-ID: <20251017155450.4016595-1-listout@listout.xyz>
In-Reply-To: <40982e43-84c5-481b-9a9a-0b678ef7e6e7@linux.dev>
References: <40982e43-84c5-481b-9a9a-0b678ef7e6e7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cp8Y328NDz9t7F

This fixes the following build error

   CLNG-BPF [test_progs] verifier_global_ptr_args.bpf.o
progs/verifier_global_ptr_args.c:228:5: error: redefinition of 'off' as
different kind of symbol
   228 | u32 off;
       |     ^

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
Please refer: https://lore.kernel.org/bpf/5ca1d6a6-5e5a-3485-d3cd-f9439612d1f3@loongson.cn/
---
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 6630a92b1b47..1204fbc58178 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -225,7 +225,7 @@ int trusted_to_untrusted(void *ctx)
 }
 
 char mem[16];
-u32 off;
+u32 offset;
 
 SEC("tp_btf/sys_enter")
 __success
@@ -240,9 +240,9 @@ int anything_to_untrusted(void *ctx)
 	/* scalar to untrusted */
 	subprog_untrusted(0);
 	/* variable offset to untrusted (map) */
-	subprog_untrusted((void *)mem + off);
+	subprog_untrusted((void *)mem + offset);
 	/* variable offset to untrusted (trusted) */
-	subprog_untrusted((void *)bpf_get_current_task_btf() + off);
+	subprog_untrusted((void *)bpf_get_current_task_btf() + offset);
 	return 0;
 }
 
@@ -298,12 +298,12 @@ int anything_to_untrusted_mem(void *ctx)
 	/* scalar to untrusted mem */
 	subprog_void_untrusted(0);
 	/* variable offset to untrusted mem (map) */
-	subprog_void_untrusted((void *)mem + off);
+	subprog_void_untrusted((void *)mem + offset);
 	/* variable offset to untrusted mem (trusted) */
-	subprog_void_untrusted(bpf_get_current_task_btf() + off);
+	subprog_void_untrusted(bpf_get_current_task_btf() + offset);
 	/* variable offset to untrusted char/enum (map) */
-	subprog_char_untrusted(mem + off);
-	subprog_enum_untrusted((void *)mem + off);
+	subprog_char_untrusted(mem + offset);
+	subprog_enum_untrusted((void *)mem + offset);
 	return 0;
 }
 
-- 
2.51.0


