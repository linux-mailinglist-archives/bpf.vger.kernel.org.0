Return-Path: <bpf+bounces-35322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EB9397EC
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5858B1C21A17
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8D13AD2A;
	Tue, 23 Jul 2024 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs6NL04t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CA1369AE;
	Tue, 23 Jul 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698137; cv=none; b=JmBXAfvsIdU9a5rn0NHAYJl84velw0Hb563SOogv+9q6qYStidPnN75k7fS+KLiVwkYn9kANOqIWoAAurySHeb8CwX/6bJ02t8nG7JF8Zd+BCev+yeyLPWHfdeEHpPJVLH7Dw01OB6BJGtMYtSNDIKh8H75+0cUHtJ/tniJR9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698137; c=relaxed/simple;
	bh=VLL35boxqFuOc40XPfXlJjwMZlRdjvQpA8ziQfPKO5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+tl2ZnbG5duaCrTNrwcqfZlmEtBm1JCLNROby6Nb7BJqERVuSinwcqYm8s1ftvOtM8DoVlv4ggcftLB7d8PSX77f4cGpgK/CwSaEIl9cEp39nqUnk26ZwRkAFrjCZze38cNLSrU+uyObTV8b8owcykkTmwPy+hfuhVTuWXuxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs6NL04t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso36931235e9.3;
        Mon, 22 Jul 2024 18:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721698134; x=1722302934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JpvM6gskhIkYk6iEhzrjUnhABg12qwE+NcmnGPaHaU=;
        b=cs6NL04tYGP+UTf9Cr7s+AD5tNfJOV0E5uH25r7MBtjanEzsdlsRAb9dma4n4sDoNF
         X08bKRV1r8E2oLRXBkAkxI+V4/CG9k7ufhFRO+HwGe3OYMzPftRJY6nWoBYDPTmVmNuQ
         Hj8o1omGXxB3+23N35plTdLMgA3LEfo5A3vUL/lp5jfihwfBGL3dcg6GAJYQSpDfPv4B
         7sQdfvyZ+LlgyqDdpLSA2HYbzGVHhJJLnuww58qaO+Js/1357RatCkiAf2t6E1dpNaPB
         7b1qmUf5Ddn1/oZ1CTVQBGI8DbtKzMfrs/ysAp7kpR02ufJKGzV0ru2X0w7ZgSSJNAEY
         ciOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698134; x=1722302934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JpvM6gskhIkYk6iEhzrjUnhABg12qwE+NcmnGPaHaU=;
        b=HiSnEN/COBdnPlf66Z/Qs76LVb7L8bAkr68hBZf62Opor3LVAnofTexvtc4/D2rcAn
         9H2RtoPuWc7POV2RqG/JcP468RHIOgfWZorYUTnX7qHFjPNYQ/1I5ZO4WxeM0VVGtbkN
         MXzJhDlCKG2s+8Em+HvcVUifqHlFbE81pgsEhDIl+iMCnUNQDVnSx4834xr54WDjku5z
         qF4s5PBoa7MYJuB+T4foyWP6QMAKKTBObnEUyrkMOJBu/G5fFajpTY94R7+gzCAVy/VL
         beUeRIZ24a09PDmnB77QfMqAdm7vQ7uqB5Fu88AYSYQruPLPf+iWF9Fh0BI7vOKizzPV
         vqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW1jiGvduMkyWslAg/R7ok+cTbSi1CybIs4mYn4FjJnCY8G3JBCUEESgEziY8BHt7p+9Jvd9pAF3hY8uIffOQSKYprbMx9cF05R0Xp8/0K5P+AWOXF7Dv4Rh6MrSJDom0YLyrAab8O
X-Gm-Message-State: AOJu0YyODHcqnp04InJHnEb+WvOnnqMqR7HQrxVlK0ccPI+CRB+6nDqO
	G7MTpp3YiCoBbOQ0GT39f0Apg3ZtO0Rzugiba1Ab9mrMSJPnn3UxzJ6Erg==
X-Google-Smtp-Source: AGHT+IFJhpYdZ1TYDVvD5UDDmF+Iy8jQVDWtEy8GHnJDXw4rkaRFQqKQebTYHV3pM0whCnYhXUi/IQ==
X-Received: by 2002:a05:6000:c49:b0:367:9522:5e6b with SMTP id ffacd0b85a97d-369dee4de69mr918088f8f.45.1721698133956;
        Mon, 22 Jul 2024 18:28:53 -0700 (PDT)
Received: from lenovo.teknoraver.net (net-93-66-31-10.cust.vodafonedsl.it. [93.66.31.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8f3a47d2sm31435366b.81.2024.07.22.18.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 18:28:53 -0700 (PDT)
From: technoboy85@gmail.com
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v2 2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
Date: Tue, 23 Jul 2024 03:28:27 +0200
Message-ID: <20240723012827.13280-3-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723012827.13280-1-technoboy85@gmail.com>
References: <20240723012827.13280-1-technoboy85@gmail.com>
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
Move the code from kernel/trace/bpf_trace.c to kernel/bpf/helpers.c,
so it compiles also without CONFIG_BPF_EVENTS.

This will be used in systemd-networkd to monitor the sysctl writes,
and filter it's own writes from others:
https://github.com/systemd/systemd/pull/32212

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 23 +++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 27 ++-------------------------
 4 files changed, 28 insertions(+), 25 deletions(-)

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
index 8ba73042a239..e7113d700b87 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2581,6 +2581,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
+	case BPF_FUNC_current_task_under_cgroup:
+		return &bpf_current_task_under_cgroup_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 23b782641077..eaa3ce14028a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2457,6 +2457,29 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 	return ret;
 }
 
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
 /**
  * bpf_task_get_cgroup1 - Acquires the associated cgroup of a task within a
  * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
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


