Return-Path: <bpf+bounces-40202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F68797EC76
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0484B1F21A10
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA90199938;
	Mon, 23 Sep 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ALUdnk8R"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5C199949
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098866; cv=none; b=gSD1EfLLZ4TYAC2A31s4btRG3kTkKEd9fjhFVJPBw7DQQL1nC6iPC1Ga21wNgxiB8sLb30gWUz2aTPXDopeu2mlJqlDL6RKrExrcvRynvBVtSJgP8DJeKHfRTpioenSBdZ6wHvrIYii/QZV8bxYXL7kR5sIYHOs073tS4y/5So4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098866; c=relaxed/simple;
	bh=0UhzhZ6EtmiLq8qftmcapEasLWGltMlvb2H+rZclgGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCiHgVIwUAsRo9/BNMGZ5dCfnu+MV3XVjPC0f0F18UouiIVFdUeibESAFTsgIZ396NVc/WIXc1NPodL/ymDZhTPifhuL3MjSzZ07DKGM4/TOGR5siFP95+5B5IO3OfjUfGpnGNGLl9v1sZEHXa/heldAYMmljQ4LopNMspNJMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ALUdnk8R; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727098860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wHzj++XWgJMI86KGXHcpfcXUI1qvAQF3OWaS0UI3fM=;
	b=ALUdnk8R0okU2JgEuifNn5Gg1CDTsEBigpsp0LYEKM85P+rfylq6u4YK5aptcMFf7xYis/
	zW+AFgEkYAek7F/QJpjYGMzzK8PRuERqcg11EHuGy6MriXvK73Gc4fO8zeYaBefgeYDCGI
	pjbIWvs8jYmVLxQBpEcerOcYZDq8stc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 2/4] bpf: Prevent extending tail callee prog with freplace
Date: Mon, 23 Sep 2024 21:40:42 +0800
Message-ID: <20240923134044.22388-3-leon.hwang@linux.dev>
In-Reply-To: <20240923134044.22388-1-leon.hwang@linux.dev>
References: <20240923134044.22388-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Alongside previous patch, the infinite loop issue caused by combination of
tailcal and freplace can be prevented completely.

The previous patch can not prevent the use case that updates a prog to
prog_array map and then extends the prog with freplace prog.

This patch fixes the case by preventing extending a prog, which has been
updated to prog_array map, with freplace prog.

If a prog has been updated to prog_array map, it or its subprog can not
be extended by freplace prog.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/arraymap.c |  6 +++++-
 kernel/bpf/syscall.c  | 12 ++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 048aa2625cbef..b864b37e67c17 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1484,6 +1484,7 @@ struct bpf_prog_aux {
 	bool exception_cb;
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
+	atomic_t tail_callee_cnt;
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 8d97bae98fa70..c12e0e3bf6ad0 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -961,13 +961,17 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 		return ERR_PTR(-EINVAL);
 	}
 
+	atomic_inc(&prog->aux->tail_callee_cnt);
 	return prog;
 }
 
 static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	struct bpf_prog *prog = ptr;
+
 	/* bpf_prog is freed after one RCU or tasks trace grace period */
-	bpf_prog_put(ptr);
+	atomic_dec(&prog->aux->tail_callee_cnt);
+	bpf_prog_put(prog);
 }
 
 static u32 prog_fd_array_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 18b3f9216b050..be829016d8182 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3501,6 +3501,18 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		tgt_prog = prog->aux->dst_prog;
 	}
 
+	if (prog->type == BPF_PROG_TYPE_EXT &&
+	    atomic_read(&tgt_prog->aux->tail_callee_cnt)) {
+		/* Program extensions can not extend target prog when the target
+		 * prog has been updated to any prog_array map as tail callee.
+		 * It's to prevent a potential infinite loop like:
+		 * tgt prog entry -> tgt prog subprog -> freplace prog entry
+		 * --tailcall-> tgt prog entry.
+		 */
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
 		goto out_unlock;
-- 
2.44.0


