Return-Path: <bpf+bounces-35250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F6939389
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F291F21AF9
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445E16F903;
	Mon, 22 Jul 2024 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Gsc6Pv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E816E88D;
	Mon, 22 Jul 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672459; cv=none; b=kDJXFtJCx/jfchDO/a9/H9NIHXYUCZ8Mah13zSVd3e3ZNTyZAQEB/EZ865ppo11w03Oxf0bQINVDLI0/aJI46r2M2XqtTMk7TX1ByGhQbRum4W59GljlVuUZkMTRT87X4OgK2ojrRjKJtfe9TVcBp0oWZWe9r9uGNZrS7LmYTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672459; c=relaxed/simple;
	bh=9QITy/ysO04KAzIEcVMjSMaF5cda3E6OOdnV1y1KtRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwGbeUfNJaQnGVg1fjZs9GaVpPfjNrAJ/XQFJ+ufvacsdSK5Zfvc7sOSCseU42NocftSvmOwb2H27nI4MSXn5vfXl0E5F/QJiIvzBr8ZsMwK/zyuJN5c8SaHNyVPCKq5p135ebjDsH47Yh5A7/I8zObYWR07pZMQ1SbDZLotSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5Gsc6Pv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77b60cafecso496114266b.1;
        Mon, 22 Jul 2024 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672456; x=1722277256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KjI/l1S9Ni3Ev56WeA0r+6LXF5+0YFxGoPrT+v289Q=;
        b=M5Gsc6PvGShWLd3D8mcH1UQyl3XWcSKjX61J60Zi/nek6YLcRuvAO+AcGXNxRUO+d1
         Hg8OrHIOm+qfY26voyvnlnCjToHDjBgB/Y6tlwgNx/Q2FK3RrWxa+YwrqkPWuNy5FHfa
         uxRThzvZClH3wh6dBjmRGRBpljKZ2MVTA6x95W463gaNOs2Sk0AihoIKx9ElcsKZDJNE
         azrKG4lsLAgQN59R2OwS+RFW5f2Ep5azK5RbSUUGFShIsDDmdEN/35WnoBbVZKXGvuYy
         LTibYuUDs1+6Rz0SKVSnFBw3jQWTjqpR8/O09euG5Wb+Hs7TL2AU2/1hkQUocHI8H/9l
         zrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672456; x=1722277256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KjI/l1S9Ni3Ev56WeA0r+6LXF5+0YFxGoPrT+v289Q=;
        b=nvlgN6/yI/lkGHQ4pR1gnKkZu7lA/89rLS12ea/ytUuvFwO8mX7VvJLp4AdCvhSZaG
         fNsvLag32uMxE1sgGYcETwpwkFGwWOF4Z4JmWsAdABPrTwt3RRraY/Sx0gkgYK+45pvK
         faBXhCljGRTf/oFFa54OJeTQPdxGCPqFSR5rcewBFqbKNl99poowGHuGO+6kVXWthbGL
         2r74G4ce52tjtvMAaqDLDoMtpDYcyHYW0yESD0dvpKOWpcSS9i7jH3FAuhdVvJNWJHQI
         jmSOP3ocHvpntGwGVVWGIqexJxCASc6uEB08YnM3tVwU4OLnOzTH8YFGwxRd7XDwAYEt
         nZiw==
X-Forwarded-Encrypted: i=1; AJvYcCVURrY/0orhN1BxBBYWHss5PUoRWScycqr8UpAwfC20Zlq6SKrFZfGj8pEABdWqvOnufy/EXgckVwQIZYrEIkkxtIJ3vGcGDzB+T/56r3JODGwXVSDU6LC9sL+5du5K/LwjLq6iGu0+
X-Gm-Message-State: AOJu0Yw4cw/uvNW6oWhkFPIPBQvtWjGlFW8KSqM1krDQcoYVMzh94TJU
	+fwczXVtpEyik/c1ezT2RrhAnEzrhYVfO/eKKsDmPsiGnpwiEAog
X-Google-Smtp-Source: AGHT+IGvkfn3VV2EaivlCkf6YAO9NrgJWYsNRBM7RHoP7OChA9B5KqdHmk1biVhP6JLTEOKyudUCyA==
X-Received: by 2002:a17:907:9493:b0:a72:7e5f:a0c4 with SMTP id a640c23a62f3a-a7a4c225808mr521722166b.56.1721672455681;
        Mon, 22 Jul 2024 11:20:55 -0700 (PDT)
Received: from lenovo.teknoraver.net (net-93-66-31-10.cust.vodafonedsl.it. [93.66.31.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c922c8fsm457962666b.145.2024.07.22.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:20:54 -0700 (PDT)
From: technoboy85@gmail.com
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
Date: Mon, 22 Jul 2024 20:20:50 +0200
Message-ID: <20240722182050.38513-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

The helper bpf_current_task_under_cgroup() currently is only allowed for
tracing programs.
Allow its usage also in the BPF_CGROUP_* program types.
Move the code from kernel/trace/bpf_trace.c to kernel/bpf/cgroup.c,
so it compiles also without CONFIG_BPF_EVENTS.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/cgroup.c      | 25 +++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 27 ++-------------------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f1d4a97b9d1..4000fd161dda 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3188,6 +3188,7 @@ extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
 extern const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto;
 extern const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto;
+extern const struct bpf_func_proto bpf_current_task_under_cgroup_proto;
 extern const struct bpf_func_proto bpf_msg_redirect_hash_proto;
 extern const struct bpf_func_proto bpf_msg_redirect_map_proto;
 extern const struct bpf_func_proto bpf_sk_redirect_hash_proto;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..b99add9570e6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2308,6 +2308,29 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
 };
 #endif
 
+BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	struct cgroup *cgrp;
+
+	if (unlikely(idx >= array->map.max_entries))
+		return -E2BIG;
+
+	cgrp = READ_ONCE(array->ptrs[idx]);
+	if (unlikely(!cgrp))
+		return -EAGAIN;
+
+	return task_under_cgroup_hierarchy(current, cgrp);
+}
+
+const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
+	.func           = bpf_current_task_under_cgroup,
+	.gpl_only       = false,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_CONST_MAP_PTR,
+	.arg2_type      = ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -2581,6 +2604,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
+	case BPF_FUNC_current_task_under_cgroup:
+		return &bpf_current_task_under_cgroup_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..ea5cdd122024 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -798,29 +798,6 @@ const struct bpf_func_proto bpf_task_pt_regs_proto = {
 	.ret_btf_id	= &bpf_task_pt_regs_ids[0],
 };
 
-BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
-{
-	struct bpf_array *array = container_of(map, struct bpf_array, map);
-	struct cgroup *cgrp;
-
-	if (unlikely(idx >= array->map.max_entries))
-		return -E2BIG;
-
-	cgrp = READ_ONCE(array->ptrs[idx]);
-	if (unlikely(!cgrp))
-		return -EAGAIN;
-
-	return task_under_cgroup_hierarchy(current, cgrp);
-}
-
-static const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
-	.func           = bpf_current_task_under_cgroup,
-	.gpl_only       = false,
-	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_CONST_MAP_PTR,
-	.arg2_type      = ARG_ANYTHING,
-};
-
 struct send_signal_irq_work {
 	struct irq_work irq_work;
 	struct task_struct *task;
@@ -1548,8 +1525,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_numa_node_id_proto;
 	case BPF_FUNC_perf_event_read:
 		return &bpf_perf_event_read_proto;
-	case BPF_FUNC_current_task_under_cgroup:
-		return &bpf_current_task_under_cgroup_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
 	case BPF_FUNC_probe_write_user:
@@ -1578,6 +1553,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_cgrp_storage_get_proto;
 	case BPF_FUNC_cgrp_storage_delete:
 		return &bpf_cgrp_storage_delete_proto;
+	case BPF_FUNC_current_task_under_cgroup:
+		return &bpf_current_task_under_cgroup_proto;
 #endif
 	case BPF_FUNC_send_signal:
 		return &bpf_send_signal_proto;
-- 
2.45.2


