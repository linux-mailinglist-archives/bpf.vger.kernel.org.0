Return-Path: <bpf+bounces-59179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE1AC6DCA
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89DB3B036B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1728DEFE;
	Wed, 28 May 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ddr3eeqn"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8228DF01
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449048; cv=none; b=gUqdNS6bjdRQy0oXWoFeQ5IPqaOhgpAx5YjTEq4pV6mlZnOPqwjKQZrczeCp6rXFKgYJe7ncm0NJxGCcvLuGz2Mw3asg4dp8/9aocUKI5nNJdKM6rgidf0Cj0hwDOntBsGTBPzZgbNPywe0p6gm++p0yOVT7r0R4yI9q76BW1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449048; c=relaxed/simple;
	bh=ASJATDXHJ1cff1RjM4ZAA2vRF3PIUif1svRlmTRlIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8E2Qvhmwwr7BSt+KqeZFc184l1HQbw5my0l6eur4XGOhVMRnGuaCqcac5wA/rdEN4PFW86p50FqM22yh+yqkPA3HdISZraFZi0avUmQ+nC4LmNmIn4YUlHX9obkrap0TQW7r0Ddv+e5QTyYmaW3nE1T+qzuoFGRM/LLmcrQwTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ddr3eeqn; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748449034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BB0IE1lnbJy5zpZRdhFIn+OnRh+wjVB9ZlPmF9vEgZQ=;
	b=Ddr3eeqnknPlT2TUs4jc/5e5ZIqxAEn6zrlKujUIy2pi9ZkQ3bnuR8Gpaa8rQ243NNR1a1
	1J7dp/zUfXVVtosYzuXzUX2x1pS58ZTq5GXJ253UtPOQ1VrBLATa3aKI6fbVop73jET6oq
	Ix/dhQxh4i+ivAiumbzGVc8pF7KE978=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] bpf: Restrict usage scope of bpf_get_cgroup_classid
Date: Thu, 29 May 2025 00:16:25 +0800
Message-ID: <20250528161653.55162-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A previous commit expanded the usage scope of bpf_get_cgroup_classid() to
all contexts (see Fixes tag), but this was inappropriate.

First, syzkaller reported a bug [1].
Second, it uses skb as an argument, but its implementation varies across
different bpf prog types. For example, in sock_filter and sock_addr, it
retrieves the classid from the current context
(bpf_get_cgroup_classid_curr_proto) instead of from skb. In tc egress and
lwt, it fetches the classid from skb->sk, but in tc ingress, it returns 0.

In summary, the definition of bpf_get_cgroup_classid() is ambiguous and
its usage scenarios are limited. It should not be treated as a
general-purpose helper. This patch reverts part of the previous commit.

[1] https://syzkaller.appspot.com/bug?extid=9767c7ed68b95cfa69e6

Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
Reported-by: syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/bpf-cgroup.h |  8 ++++++++
 kernel/bpf/cgroup.c        | 25 +++++++++++++++++++++++++
 kernel/bpf/helpers.c       |  4 ----
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 4847dcade917..9de7adb68294 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -427,6 +427,8 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
 
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
+const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 #else
 
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
@@ -463,6 +465,12 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return NULL;
 }
 
+static inline const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return NULL;
+}
+
 static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
 					    struct bpf_map *map) { return 0; }
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 62a1d8deb3dc..a99b72e6f1c9 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1653,6 +1653,10 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
@@ -2200,6 +2204,10 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_sysctl_get_name:
 		return &bpf_sysctl_get_name_proto;
@@ -2343,6 +2351,10 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 #ifdef CONFIG_NET
 	case BPF_FUNC_get_netns_cookie:
@@ -2589,3 +2601,16 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return NULL;
 	}
 }
+
+const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_get_cgroup_classid:
+		return &bpf_get_cgroup_classid_curr_proto;
+#endif
+	default:
+		return NULL;
+	}
+}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..9d0d54f4f0de 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2024,10 +2024,6 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_ancestor_cgroup_id_proto;
 	case BPF_FUNC_current_task_under_cgroup:
 		return &bpf_current_task_under_cgroup_proto;
-#endif
-#ifdef CONFIG_CGROUP_NET_CLASSID
-	case BPF_FUNC_get_cgroup_classid:
-		return &bpf_get_cgroup_classid_curr_proto;
 #endif
 	case BPF_FUNC_task_storage_get:
 		if (bpf_prog_check_recur(prog))
-- 
2.47.1


