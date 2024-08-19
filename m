Return-Path: <bpf+bounces-37529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB195703D
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3A51F22491
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA534176AAE;
	Mon, 19 Aug 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyIf9SyF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049682D94;
	Mon, 19 Aug 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084924; cv=none; b=fDa7vhOUOxN0yPP5g+jNrBmdKV/gn/6XV2AbYpU+CTpcFRy19id1uKbaSmdEVyJ0crsk77yGr4JTNWDlyXWWM7/4s8rokCyAtQrdQYSrc4oBTaNRj01ZXCg+rQyPX9Go9L4YesdPI/zgV1c7i0FMWCj1d9QJXx74EzCgPX4itUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084924; c=relaxed/simple;
	bh=z8kWQOk0+SgPOW2ErE0TdIUZyPc6eFdb5/uFyMNQevU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmo0LJG6FaXee7AZAeL+qYExQb2zAuB74Sn5zMe5YCpZrwpw/H3tvbpEC1WVMUp7I1A/rwJWEisgEBdMXlxva+NxvUblXn60Y6VKRODeMMuVahWKdZlF27AWTNXSbZBxKZCPSE7HLBvw9c9i/X7Tw0eeIgnNP4fo/Du5NGxDQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyIf9SyF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37196786139so2223688f8f.2;
        Mon, 19 Aug 2024 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724084921; x=1724689721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgrYssnQV/ZXUz1RX8badJMMrwHcEJA9d3TIal8ZnX0=;
        b=VyIf9SyFUEufwI5et9nRJgkUAoYmuRjQokmWc79FumllrbvabaePahqNcXvPjUSykV
         1V1jP41yN/mmPcMRbaf1QnPfe2UYZ9ikXdQ3TkiCb4/VFXSGKyCUeVpq7f+V8LLyQ7BH
         lnSIwOozzIEKGpVih1TSDlyKo44NZyjTFdonCRHBD0Nk5NXrimCon1wZlOl659frxCBw
         GVSuDaR4IeZ0iNV9qnqhf9Qs3S6W3LvLu7F/FpBXnerK7KiQMmhpT3emjg0iJ5GV761P
         jbjl0+f5QQGoC3fm6agYRUKzgIistyk7+OtrjhX7wQnhlkfK1CnGnv1nvscZ21cfrzAq
         oZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084921; x=1724689721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgrYssnQV/ZXUz1RX8badJMMrwHcEJA9d3TIal8ZnX0=;
        b=LmOTPZxfqcTmX/uNX5BeA8V+omXM19PqICg7nUBRnjAOXmVjblw6FCHsA4+EyH/93A
         v+xGlbaPANAE/PlzBhmsRYELx1E++7RJkshqkII78eTjWHaXpmzxYLi2eAbUSdVxRQdM
         /U5aNy0/m12FkzBpMEkK97yNz7kEseEndvTVSF10cEQZZujj2AlX0Om5omZZ5tKrl/FP
         uAQcZ0sqRUnyq5FTWL2Fg9Y/KaRevI5+xbqm7sbCJJ4DSTl+APdnDEB1/m2W92IwBMTW
         Xe2TgMrXbggN/huM8QlHWCnKPyWGUpFUgzAB/RawHY4UgXxGD+9TtWwne1lUuzMBPIyF
         F4lA==
X-Forwarded-Encrypted: i=1; AJvYcCWDxX6x3tCp9yHjpb9toG+Gp3D6mkv3w++qBpFPz9EmBE6f8Z+fRHPPGZRx8FSpFmDuewlWiJFXzeQ0q6wA0BcSqn1dS/qmvqOZRs11LYq596eeTVUIC6C6PA2O9iB/vKUUcNVXp0/o
X-Gm-Message-State: AOJu0YzVL/xWB7f4Kt5CTWERBniyyUXiJPYxC/llvSYs6tO4c7zRw7gN
	g+YcbEfGXBF0tr0EI1AF6liPSSPTyhO3/vLDyj3079obONGSpGkAd7WAIw==
X-Google-Smtp-Source: AGHT+IEQGvoMGjBlsuR2gbvEH4RP0OUeH5hv1/ipdWdp7vSpXGjjw8baUTrpXJemmHHm2d+jxPd3jQ==
X-Received: by 2002:a5d:5a15:0:b0:366:f041:935d with SMTP id ffacd0b85a97d-371946bcb41mr10828246f8f.60.1724084920453;
        Mon, 19 Aug 2024 09:28:40 -0700 (PDT)
Received: from lenovo.fritz.box ([151.72.61.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897029sm10922134f8f.74.2024.08.19.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:28:40 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v6 2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
Date: Mon, 19 Aug 2024 18:28:05 +0200
Message-ID: <20240819162805.78235-3-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819162805.78235-1-technoboy85@gmail.com>
References: <20240819162805.78235-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

The helper bpf_current_task_under_cgroup() currently is only allowed for
tracing programs, allow its usage also in the BPF_CGROUP_* program types.

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
index b9425e410bcb..f0192c173ed8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3206,6 +3206,7 @@ extern const struct bpf_func_proto bpf_sock_hash_update_proto;
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
index 26b9649ab4ce..12e3aa40b180 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2458,6 +2458,29 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
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
index d557bb11e0ff..b69a39316c0c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -797,29 +797,6 @@ const struct bpf_func_proto bpf_task_pt_regs_proto = {
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
@@ -1480,8 +1457,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_numa_node_id_proto;
 	case BPF_FUNC_perf_event_read:
 		return &bpf_perf_event_read_proto;
-	case BPF_FUNC_current_task_under_cgroup:
-		return &bpf_current_task_under_cgroup_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
 	case BPF_FUNC_probe_write_user:
@@ -1510,6 +1485,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_cgrp_storage_get_proto;
 	case BPF_FUNC_cgrp_storage_delete:
 		return &bpf_cgrp_storage_delete_proto;
+	case BPF_FUNC_current_task_under_cgroup:
+		return &bpf_current_task_under_cgroup_proto;
 #endif
 	case BPF_FUNC_send_signal:
 		return &bpf_send_signal_proto;
-- 
2.46.0


