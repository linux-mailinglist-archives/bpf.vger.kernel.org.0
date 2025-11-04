Return-Path: <bpf+bounces-73517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC26C334E6
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275D24E2BF2
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4232B9BF;
	Tue,  4 Nov 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/3js477"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CF2FD69E
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296881; cv=none; b=IwlR67eeAeYlFsF6y4Le870GD8Uid8JuGBWBvgFOmpvxczIFEY9s35I893EPharFSX4xMHHtXYobFH/vFxA77LnTI9d0rcW7FLcpPmpzRCs3+1ZZPV/VPS5Ly9lNytLDygO+GSGzuUy0w4Yg0cNljwt1ztfXdrfD0g+w+RmsrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296881; c=relaxed/simple;
	bh=Mxvd16owBYrh6O5/cFQKskhSbpdhDYZ9pFDcke1eBqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CToWJJOikXWZSABPaI3iGJNzdU/+VmZPibYyloR04/JcbXqckF7o+c3pC3OEmmccxMbAdowVuQPl5VscT0h6USb2pLDMqTIKulPwdBpxMiblPRHauWdG6N84PmzQrwrITx/hfa9tzzN3jjeFDcShGL0HhyCVe9HiBXFrqBt7x2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/3js477; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so5244137f8f.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 14:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762296878; x=1762901678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmJ90uXCwR7WJl+O2ArBzbV0spCD0ae4C4QJe7TDlBA=;
        b=Q/3js4774mk/Mk26+dSmPjLGxIrCkTz+Nft8x5OBXnAERYWCJd7DCh4PhcNisg8up+
         qGgOyiRsQLHGWE3qLFffgP757quxQArwO+pmDPHkqvKghE9Y/pRI/tn3BaOP/OmfWcQ9
         ITzJowfyk+6ItvFoWkmpLPZbpwLByRCcweQeqn9ESi3ts/4XCX7Dy9lcrrPJEopHNe9z
         0nq1v4YZ0hCFI0b5XKnBBVt7pR5SZYS6tBLfo4XSsdrvZBOwm1e2zgmpsM9zcrEBm3X8
         uS+u7X2IR+t3b0et7Vx9BiOE+mF4MMxfP84Cc7PPL1llMJy0zgVdm8atzlkrWDGNoqpw
         Es/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296878; x=1762901678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmJ90uXCwR7WJl+O2ArBzbV0spCD0ae4C4QJe7TDlBA=;
        b=KBvHRMkPv4pFR80Dd2SRnOzCbq4kEKUkcX2ciET3wE3oW4ThmYVtop/5tkXLHvZXac
         Y8IraSFegEoyKdYMrddzu/ER6vlAPobc5db+OFK/ApNSgZf0qp1KxxYfH0ycEceH79Ai
         L/ns30VOZ7am83MioRI1J/rg7d6fmC92YCueWgPD458K3FBA3FaVD/71aA+Amk0aAmIh
         7Z/MzkmWQBnwuezQVbjEHo50mZpzYsDZM7bbgY/Tlkd/8iDnyum4GWMmYH8EtzsPSxp0
         R8CfbRLwc5fEAa6d16+zjz8lU2QiJLGeWhpVmgBLFA58xeo/oe135Y40TVdx3EQl5X/M
         0mXQ==
X-Gm-Message-State: AOJu0Yz35HNmjZY4vln96ygjKbTVi2vbKqTL3oywIkto8UOrvZFDv6vm
	jdGpJbz3ulOp9kxMuCW/lIYbfufmrLy7Jy90i2SJatuNbLmMbP6nMqeG
X-Gm-Gg: ASbGncvzKpeXezTbgLLvkUYQW5X7JeyS3BqZ7caboVYLE9opQpahRcppfyeyjzGGFgB
	1LdaGr0StoU3iFvXNEknmVQilNnRYzcD/ICsaXaLd9LJmLAhWtzC+JC2DDzsN/CJRHWDk6kuWdk
	aW41Qv7xPvdUBOxKxUuzxtvfVDrb19P28LXAFSmnb6grHhGK6opFoBnVRCZoxPYAwA4HXm43FAf
	RmzezQZsYs1I1lZb0dr7eZpinsCIrULQ1p/Fn2ml1lQkogwsau0PQFTIjauzzeH7ZJiEbxtekHv
	vZHH+fEoPuuGDksg0lm8+n7k0E/PbILLzKbP7paQKN6wJGCE3+Wc4GbgkZSlsIPFfSmC7v5OXHS
	IGbDApiFgbwzfjCpKgxq3C+LePu54B9i85BcPFXns0Abw8PRQM0VicCeN9ARNWTqPnEXE9872wq
	uFC5k=
X-Google-Smtp-Source: AGHT+IFB2YpOphg4yBrMpmaw73yYMYcXv/ChTvmKIi3wdnWGrSMaRgAs2keQIuDn9Ova8YW3dz8dLg==
X-Received: by 2002:adf:9c88:0:b0:429:d3e9:659 with SMTP id ffacd0b85a97d-429e35d2847mr473252f8f.1.1762296878027;
        Tue, 04 Nov 2025 14:54:38 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm6853230f8f.44.2025.11.04.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:54:35 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 04 Nov 2025 22:54:25 +0000
Subject: [PATCH bpf v3 1/2] bpf:add _impl suffix for
 bpf_task_work_schedule* kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-implv2-v3-1-4772b9ae0e06@meta.com>
References: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
In-Reply-To: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762296873; l=9018;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=+V4D65+FoxgZbhweLLXGP7bpEfoQoE2DWTDr6xpMuD0=;
 b=Wg88ZOAvo+LCAWjYC10BV9ajDujh8UwfOf6jT2BcrNPV0EUeSzPMsR8Xa+fJCxsTY81yj3spS
 B8z5PHnq/cwCKGbtdT8uJ1PdRt31Enw5IHsB7dmd9GCg9f/DoxzqNC8
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Rename:
bpf_task_work_schedule_resume()->bpf_task_work_schedule_resume_impl()
bpf_task_work_schedule_signal()->bpf_task_work_schedule_signal_impl()

This aligns task work scheduling kfuncs with the established naming
scheme for kfuncs with the bpf_prog_aux argument provided by the
verifier implicitly. This convention will be taken advantage of with the
upcoming KF_IMPLICIT_ARGS feature to preserve backwards compatibility to
BPF programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c                               | 24 +++++++++++++---------
 kernel/bpf/verifier.c                              | 12 +++++------
 tools/testing/selftests/bpf/progs/task_work.c      |  6 +++---
 tools/testing/selftests/bpf/progs/task_work_fail.c |  8 ++++----
 .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
 5 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb25e70e0bdc0332edd21cde66d9aaadb2090312..33173b027ccf8893ce18aad474b88f8544f7b344 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4169,7 +4169,8 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 }
 
 /**
- * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
+ * bpf_task_work_schedule_signal_impl - Schedule BPF callback using task_work_add with TWA_SIGNAL
+ * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
@@ -4178,15 +4179,17 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
-__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
-					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+__bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct *task,
+						   struct bpf_task_work *tw, void *map__map,
+						   bpf_task_work_callback_t callback,
+						   void *aux__prog)
 {
 	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
 }
 
 /**
- * bpf_task_work_schedule_resume - Schedule BPF callback using task_work_add with TWA_RESUME mode
+ * bpf_task_work_schedule_resume_impl - Schedule BPF callback using task_work_add with TWA_RESUME
+ * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
@@ -4195,9 +4198,10 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
-__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
-					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+__bpf_kfunc int bpf_task_work_schedule_resume_impl(struct task_struct *task,
+						   struct bpf_task_work *tw, void *map__map,
+						   bpf_task_work_callback_t callback,
+						   void *aux__prog)
 {
 	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
 }
@@ -4377,8 +4381,8 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c435862e9ecd3ed37139cc177a13ea1..8314518c8d93ae16235e6f2fe6c5c28c45cb81d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12259,8 +12259,8 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
 	KF___bpf_trap,
-	KF_bpf_task_work_schedule_signal,
-	KF_bpf_task_work_schedule_resume,
+	KF_bpf_task_work_schedule_signal_impl,
+	KF_bpf_task_work_schedule_resume_impl,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12331,13 +12331,13 @@ BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
-BTF_ID(func, bpf_task_work_schedule_signal)
-BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_task_work_schedule_signal_impl)
+BTF_ID(func, bpf_task_work_schedule_resume_impl)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
-	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
-	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
+	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal_impl] ||
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume_impl];
 }
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
diff --git a/tools/testing/selftests/bpf/progs/task_work.c b/tools/testing/selftests/bpf/progs/task_work.c
index 23217f06a3ece641089c1ea6a470eccc82e0d1fa..663a80990f8f8759f470d2f874d02485b072a5e1 100644
--- a/tools/testing/selftests/bpf/progs/task_work.c
+++ b/tools/testing/selftests/bpf/progs/task_work.c
@@ -66,7 +66,7 @@ int oncpu_hash_map(struct pt_regs *args)
 	if (!work)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -80,7 +80,7 @@ int oncpu_array_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_work, NULL);
+	bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, process_work, NULL);
 	return 0;
 }
 
@@ -102,6 +102,6 @@ int oncpu_lru_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&lrumap, &key);
 	if (!work || work->data[0])
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, &lrumap, process_work, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
index 77fe8f28facdb60cd69e77b72ea24db8f97004f7..1270953fd0926f83f9ad7112d78e1b86bd1e802c 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -53,7 +53,7 @@ int mismatch_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -65,7 +65,7 @@ int no_map_task_work(struct pt_regs *args)
 	struct bpf_task_work tw;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume(task, &tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &tw, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -76,7 +76,7 @@ int task_work_null(struct pt_regs *args)
 	struct task_struct *task;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume(task, NULL, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, NULL, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -91,6 +91,6 @@ int map_null(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, NULL, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, NULL, process_work, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
index 90fca06fff56ca9a03fee028ca1b69db145a227b..55e555f7f41be694f9b3d98f324b402f9355f77d 100644
--- a/tools/testing/selftests/bpf/progs/task_work_stress.c
+++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
@@ -51,8 +51,8 @@ int schedule_task_work(void *ctx)
 		if (!work)
 			return 0;
 	}
-	err = bpf_task_work_schedule_signal(bpf_get_current_task_btf(), &work->tw, &hmap,
-					    process_work, NULL);
+	err = bpf_task_work_schedule_signal_impl(bpf_get_current_task_btf(), &work->tw, &hmap,
+						 process_work, NULL);
 	if (err)
 		__sync_fetch_and_add(&schedule_error, 1);
 	else

-- 
2.51.1


