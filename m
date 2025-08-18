Return-Path: <bpf+bounces-65845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C529CB29752
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B93C189AC2F
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 03:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62F25A2C8;
	Mon, 18 Aug 2025 03:24:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786025D53B;
	Mon, 18 Aug 2025 03:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755487499; cv=none; b=fn19LXhN0tMPGfgJOTPea0W+CfXE4Pw4Wq67plii1sYFVTZYYcs+CBlGgR26xnwmLUoTfULiZSakY5MWivAotryBopXxKAFkuHHouYgTNgkYrooIVmbjirxXH0AqqZgDevxejwyO35lmnhwKj5862JKdFAU8W17VtlF/Grlimxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755487499; c=relaxed/simple;
	bh=wi2kRpnTO2A/WrOgjNo/vYLtqr3YGX7eHBKRlFB0eeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sasFlsPdMTWx756b8MyYax/V+lJIPovICILewmSAEJ27DIk0mI/pckaBsVSnT6CgCL9yw9+A/PP1azxv+rHeyyED3Qg89ILrgi0hMY2M5lZm9AhhaFUtA6A/4CZbQdOsEfVsoLam8NV8+2kC6FfsLMG7gbbrE8vHE617hwgf9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>
CC: <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH bpf-next v2] bpf: Replace get_next_cpu() with cpumask_next_wrap()
Date: Mon, 18 Aug 2025 11:23:44 +0800
Message-ID: <20250818032344.23229-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

The get_next_cpu() function was only used in one place to find
the next possible CPU, which can be replaced by cpumask_next_wrap().

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 kernel/bpf/bpf_lru_list.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 2d6e1c98d8ad..e7a2fc60523f 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -19,14 +19,6 @@
 #define LOCAL_PENDING_LIST_IDX	LOCAL_LIST_IDX(BPF_LRU_LOCAL_LIST_T_PENDING)
 #define IS_LOCAL_LIST_TYPE(t)	((t) >= BPF_LOCAL_LIST_T_OFFSET)
 
-static int get_next_cpu(int cpu)
-{
-	cpu = cpumask_next(cpu, cpu_possible_mask);
-	if (cpu >= nr_cpu_ids)
-		cpu = cpumask_first(cpu_possible_mask);
-	return cpu;
-}
-
 /* Local list helpers */
 static struct list_head *local_free_list(struct bpf_lru_locallist *loc_l)
 {
@@ -482,7 +474,7 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 
 		raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
 
-		steal = get_next_cpu(steal);
+		steal = cpumask_next_wrap(steal, cpu_possible_mask);
 	} while (!node && steal != first_steal);
 
 	loc_l->next_steal = steal;
-- 
2.36.1


