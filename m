Return-Path: <bpf+bounces-70474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324DBBFF07
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 03:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED193C4A15
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C51E5710;
	Tue,  7 Oct 2025 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZsduBCru"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49E196C7C
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800209; cv=none; b=EYkp+9T9TITloBqKA+jp530SilhBVibY4i2PEZJXyKOlERsiAv1BhgepKj8GuLy8XgBRbtWT3AyYFHPuonTTM8KRgBBTzPpXI0jSmP6xxc4ygtvgXyTS+B4otj8LtAzP4m/U8WLgV2SmMyltioiu7zq2xEWDiO3YSnTkR/AWArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800209; c=relaxed/simple;
	bh=o7/UHuxurP12islo46WPIV7Js05Pg3uCRb86T0t3gfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAy5wijIfiiVJHVXx+iCRdPr7G1zioB12rJd7lBoyGB3a8FqO+x4yJZUQWqqDMdXP1Hn1DfRSL1f42cIUp3S7QFTSglk39BNp7AHHSOBYB3iWYz28tX6BwoM4Hb3CJ9NpqFlYjf0HCXmGNzGQpX7BjEjuMdtoknl2Fpc86msF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZsduBCru; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759800205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcoZIh074dnysWiuf/6geNRTmp79x+1jXXy5Hj0soP0=;
	b=ZsduBCrummHRKDRpMZYuxvb8v7dZrsakqJ0nw8bEJkvk/3A7R+pE5GDKIMPMO/cR+EFV2f
	MK5YxxGzVUTAemMqL+GG5z2hp8NKZdQMUHD5CJLgRvXx0TKmchOPCK6Uk3RuRXano7AsE8
	qjMuZBJAhgpIWS9Puohu26k6ZEJvW5o=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	toke@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Le Chen <tom2cat@sjtu.edu.cn>
Subject: [PATCH bpf v2 1/2] bpf: Avoid RCU context warning when unpinning htab with internal structs
Date: Tue,  7 Oct 2025 09:22:33 +0800
Message-ID: <20251007012235.755853-2-kafai.wan@linux.dev>
In-Reply-To: <20251007012235.755853-1-kafai.wan@linux.dev>
References: <20251007012235.755853-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When unpinning a BPF hash table (htab or htab_lru) that contains internal
structures (timer, workqueue, or task_work) in its values, a BUG warning
is triggered:
 BUG: sleeping function called from invalid context at kernel/bpf/hashtab.c:244
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14, name: ksoftirqd/0
 ...

The issue arises from the interaction between BPF object unpinning and
RCU callback mechanisms:
1. BPF object unpinning uses ->free_inode() which schedules cleanup via
   call_rcu(), deferring the actual freeing to an RCU callback that
   executes within the RCU_SOFTIRQ context.
2. During cleanup of hash tables containing internal structures,
   htab_map_free_internal_structs() is invoked, which includes
   cond_resched() or cond_resched_rcu() calls to yield the CPU during
   potentially long operations.

However, cond_resched() or cond_resched_rcu() cannot be safely called from
atomic RCU softirq context, leading to the BUG warning when attempting
to reschedule.

Fix this by changing from ->free_inode() to ->destroy_inode() and rename
bpf_free_inode() to bpf_destroy_inode() for BPF objects (prog, map, link).
This allows direct inode freeing without RCU callback scheduling,
avoiding the invalid context warning.

Reported-by: Le Chen <tom2cat@sjtu.edu.cn>
Closes: https://lore.kernel.org/all/1444123482.1827743.1750996347470.JavaMail.zimbra@sjtu.edu.cn/
Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index f90bdcc0a047..81780bcf8d25 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -775,7 +775,7 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void bpf_free_inode(struct inode *inode)
+static void bpf_destroy_inode(struct inode *inode)
 {
 	enum bpf_type type;
 
@@ -790,7 +790,7 @@ const struct super_operations bpf_super_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= inode_just_drop,
 	.show_options	= bpf_show_options,
-	.free_inode	= bpf_free_inode,
+	.destroy_inode	= bpf_destroy_inode,
 };
 
 enum {
-- 
2.43.0


