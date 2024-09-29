Return-Path: <bpf+bounces-40497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE359895AB
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37E61C21D64
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859AA13C9D4;
	Sun, 29 Sep 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKVLfPWM"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7E156F33
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727616508; cv=none; b=NsWRWYkGAaebOD7zsus5GohPh5rWgyC1MnP86DWpksbNyvKpV2gzTf+1R07PByiNUFxUKOuk5kqe5BiEz+sziobvxvco55j8qqU9GATwqTDgNZfZ7/x7FLHZcU0/LR83XSicMHnOXx7mC7UWIFIn8F2ZO/DOJLxIRRMOZGwiUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727616508; c=relaxed/simple;
	bh=hRQFFaV8d57Ztv9TnVs8lb5rHaI46f4OvAOVUSV7Uwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1x0JWPH+b9eUyXziV3g2pXLuBN/+bQnP8f7TqV435Tliu7LwPeNcLbHsvU0/uTNgzNyoSxswKzo5B8qwILjqVU9L5Cqdv4C2iI40ZFrAg/P2ZNh58YOLEdT7eC0U9MOBO+8iI4BLLaESqHL+u9JlhKTtkzLSj0Xlz49M0CDDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKVLfPWM; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727616504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7wQGVt6KowL7GOQWyOQgnp6gS6bSqQriau6C3j7yhk=;
	b=cKVLfPWMSREAnBwGz+Cz/OFQafcQnwIG1o9hDuisqXkfRiQmeV1ofzotjFFjbHre9e6BGR
	SDLqBi0GPQbjqEDD0YB9BOjz19jQGUhLhvy5J5LAq5onxnU99yWNRNEL7zO+djoeQZDZac
	690pXr7jfQ79/QdhOB5tz8KuyEOUKcI=
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
Subject: [PATCH bpf-next v4 2/4] bpf: Prevent extending tail callee prog with freplace prog
Date: Sun, 29 Sep 2024 21:27:55 +0800
Message-ID: <20240929132757.79826-3-leon.hwang@linux.dev>
In-Reply-To: <20240929132757.79826-1-leon.hwang@linux.dev>
References: <20240929132757.79826-1-leon.hwang@linux.dev>
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
prog_array map and then extends subprog of the prog with freplace prog.

This patch fixes the case by preventing extending a prog, which has been
updated to prog_array map, with freplace prog.

If a prog has been updated to prog_array map, it or its subprog can not
be extended by freplace prog.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/arraymap.c |  9 ++++++++-
 kernel/bpf/syscall.c  | 11 +++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aac6d2f42830c..dc19ad99e2857 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1484,7 +1484,8 @@ struct bpf_prog_aux {
 	bool exception_cb;
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
-	struct mutex ext_mutex; /* mutex for is_extended */
+	u32 prog_array_member_cnt; /* counts how many times as member of prog_array */
+	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 4a4de4f014be9..91b5bdf4dc72d 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -957,6 +957,8 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 
 	mutex_lock(&prog->aux->ext_mutex);
 	is_extended = prog->aux->is_extended;
+	if (!is_extended)
+		prog->aux->prog_array_member_cnt++;
 	mutex_unlock(&prog->aux->ext_mutex);
 	if (is_extended)
 		/* Extended prog can not be tail callee. It's to prevent a
@@ -974,8 +976,13 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 
 static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	struct bpf_prog *prog = ptr;
+
+	mutex_lock(&prog->aux->ext_mutex);
+	prog->aux->prog_array_member_cnt--;
+	mutex_unlock(&prog->aux->ext_mutex);
 	/* bpf_prog is freed after one RCU or tasks trace grace period */
-	bpf_prog_put(ptr);
+	bpf_prog_put(prog);
 }
 
 static u32 prog_fd_array_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index db17c52fa35db..4beec9729f742 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3287,6 +3287,17 @@ static int bpf_extend_prog(struct bpf_tracing_link *link,
 	int err = 0;
 
 	mutex_lock(&aux->ext_mutex);
+	if (aux->prog_array_member_cnt) {
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
 	err = bpf_trampoline_link_prog(&link->link, tr);
 	if (err)
 		goto out_unlock;
-- 
2.44.0


