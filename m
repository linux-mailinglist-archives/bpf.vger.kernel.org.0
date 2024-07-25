Return-Path: <bpf+bounces-35591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D531E93B9C1
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E371F21C93
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC928EC;
	Thu, 25 Jul 2024 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A90o+xRS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D462187F;
	Thu, 25 Jul 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721866476; cv=none; b=NZ1CMJbxmLVrAvNzYD68Lz3z0dODT8dhvACFiuhP1jh68sDSIALelRk9tb0szsylS6CQCJ3c/pm1EI1C3KfH2hpOi9L6qXQhK6rqphUMHAQepIgy++/o2xhbSYHO8JL6e7Fu7VYZoFnNOdtrHRObWmv0xThPqIIdHhtad0CjYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721866476; c=relaxed/simple;
	bh=UOdItoIE5F1gGb1ybJBcqAUzHmgYuNmDlGm3IUv5vrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIcSAsSjtmHjjI78pODlqTM8Hf9JBGUfC5aVH+A5PyMLrgkETAkxECEo0TgTMGxKgERrmzTL6g36z/saEyeXBzavbrE4RnnMEAxZy/2bwoEGVCIxKskJE27nmSSWqEvqcveOweVillZO38les2QSwyLd5yZ9gbDYH9BnF+eyyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A90o+xRS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2ed592f6so4015591fa.0;
        Wed, 24 Jul 2024 17:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721866473; x=1722471273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJT2GE9iwU5GFa7ZaE2sOFwWPOWEUUQTQrMSdEP0K0E=;
        b=A90o+xRS9yE10JBkFO4QP0266QKZshOaSL9yv8PC35kwH+0y5egN4gm3pr3lZD5NGI
         mkVfOHxHIRn+KUagLdl0f8zStMuRBwqst8UTSFuaBlnsMjzs1ueLlRwEziBhKlTrsskh
         dirUz9VIbwPFZka0yJ+zuDAEs7yqbjDnLYwV5TMYd0RPtGUtdDciRpGUTK/xb3TWQ8uC
         A5XWw3XZ2tgIJbCFDJ14/dpBO/Rvkm0zTXfqlTpSKgdv+UOKu1UF4zs/lUd1VsPFuMoY
         YVsFIgv5Fo2ADJ99k7zt9E7ocv7dtHzrHhJ7gH3TPIcCySIQptj9p7aU7QKnbsBLRpaf
         3X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721866473; x=1722471273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJT2GE9iwU5GFa7ZaE2sOFwWPOWEUUQTQrMSdEP0K0E=;
        b=HQd1Bs/oIMmMWKcTOcOQJGs74jFbPiDTk1ZTMQjiwXy2hN9HBJtL503muCfLuHzmSS
         6W4owoLHHI1XA4IOO52XyqYAvihmiWBNpzk/c+0mhW16cLYn6pfFdKm/Pjjm4lzO/PC+
         7qreGy/Zb7dlHYtCGj9co9I+h7zFVfwt6VxxsqOFfGNR5SeAVXmxsFcNPNRVxt1/1bcc
         48siTR+qpZiufR/73Ma7kHZ5AczZcJbBLTb587bKZLcdpfTlrqLz84z7X4JMP1L9lxKq
         nS5Cmcucs+RGHY5Hymoag+dQAeuJW/e+2EKZaRNo/WBxuzOswkBGvxWofSYtAblUWCrj
         3FOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAVVT0/2wNakWwh51yONrq0dkO1b5lWxlB/5tJSAktQ0lklkIjw2vh2qKC1ZvttY0ueqfG7s3H7Hl1gs5zMwFv3rTH85LEAC9ODkCqqrJ1T3jW9UbemJO+Jnav05BEfFgqu0zSD4C2
X-Gm-Message-State: AOJu0Yy3WQO1in+MDonYdk8Id3oW6sUkOH2S/bk6SDup41SuuF5HAZ3S
	Xo+CyM2XUmxhUkfme638gCvWF4/+u1+rORuOwrnHqyWzs3R1X2SV
X-Google-Smtp-Source: AGHT+IE98euogaxLy09qa2oLk30qQbZkZEvJ4UtQHqkPO0oFkooAI40CvinmfGGYvNLbqVpU4byZuw==
X-Received: by 2002:a2e:2ac5:0:b0:2ef:307a:9988 with SMTP id 38308e7fff4ca-2f03dbe94b6mr1118081fa.35.1721866472483;
        Wed, 24 Jul 2024 17:14:32 -0700 (PDT)
Received: from teknoraver-mbp.homenet.telecomitalia.it (host-95-232-233-251.retail.telecomitalia.it. [95.232.233.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3a18sm164988a12.75.2024.07.24.17.14.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jul 2024 17:14:31 -0700 (PDT)
From: technoboy85@gmail.com
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
Date: Thu, 25 Jul 2024 02:14:11 +0200
Message-ID: <20240725001411.39614-3-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725001411.39614-1-technoboy85@gmail.com>
References: <20240725001411.39614-1-technoboy85@gmail.com>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 23 +++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 23 -----------------------
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7ad37cbdc815..3820fcf360b6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3202,6 +3202,7 @@ extern const struct bpf_func_proto bpf_sock_hash_update_proto;
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
index 0d1d97d968b0..8502cfed2926 100644
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
index cd098846e251..cc9301054f84 100644
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
-- 
2.45.2


