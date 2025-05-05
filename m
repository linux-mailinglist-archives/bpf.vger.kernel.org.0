Return-Path: <bpf+bounces-57325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162FAAA8C5C
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 08:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1FF18909F8
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D71C6FF7;
	Mon,  5 May 2025 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gkluw95P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9B1A0711
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746427204; cv=none; b=kWunKxum5tlzKfVlC+kBm6zKW9AihL7JK0Eh/rJPOP7H+xy2wnwIi8HQTgXEU7bQc2GG4/j3As+80GjqoFkQ4i/jbfXltBNvA4g4wBy5zAVWExDPRy7AtMhKA/bUscM9xSUmlZsva5ABDBaehbWuIsNjPb16ujWyNhBdwhBm8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746427204; c=relaxed/simple;
	bh=BzXwhpUfNn6f4eLnDujcuZfj0ErF1elnNF0U29kQwfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uqdtb2cpaD1P9BOJq5ZY5MHot5p4QDZncinSCSuprYKBWQxsczeB3Gj8KyP8aL1OKf6+GCOTe3Er+kfT4mPS5bXcj6ywJx64hP0PY4ZalZtj6mvydzVcx7VjwzGKray6e2gTFEvhTszmaWyL2otedYLXyHOcUD4SU8PKK4yBBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gkluw95P; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223f4c06e9fso35570685ad.1
        for <bpf@vger.kernel.org>; Sun, 04 May 2025 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746427202; x=1747032002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZIihCIcuu5AMbDW8ah1E1Hif57SVfjWhRQz55gYlZM=;
        b=Gkluw95Pce3l7ZBHaBDkgDYnrTsg2f1I8SPDgqBo2GyM8ivomY3rNn7ZIgFxDiEw5Y
         KayuwYPEyEdf9Wc/RylbPlbPapN4cCcEWxLRpciyVuDeFcY9x4wInNiA5bZmG2I+kZmF
         okQlprtevfReNKtQoHSE8c+pjmnt9SP4zw6j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746427202; x=1747032002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZIihCIcuu5AMbDW8ah1E1Hif57SVfjWhRQz55gYlZM=;
        b=DZPYLoJ5SA1im2nUu1cYymdBq09NTzNf2GNijzQsrADosHQYcFuOMMvL7LHDo73bJx
         FkKbPHhPAeEX5x2lBXkn5rTlWk/NkFG/IuK8xIjKLi0rpHp1b1Ze0LJSA5C1Vhl4nkeE
         NOHSgp5GWRUuOxRRj3q6GCODn5D5J5f/nGaxWXD4BBxtGexXcyQucJrLTBaKnK83Gp/9
         pAb7cqhkwWWyY+qqf3eFmCP4NX+u+DMn/L11CsrofSYiaaXw0KtgyUJWq+syHKzlrnmv
         JGu8/7sPeti9jVgISn5X3mya2XdIR5zop/ABvOJj8+ZtcXdm8icQ0iVQ4DXDipSVJhXB
         bElA==
X-Forwarded-Encrypted: i=1; AJvYcCVTFlI5yv1Ww5pDjz/ceNTF4KCFG2dT8lRtvETHqLGUxW4vlD4ZUpVt1L4A43QAVestqCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/isMpuFdMcf1rU9M1tF1kQfmV2PFpapLZx9NX4VnQvgOcpClQ
	CrUXHoRFOBFHmiPfnYumjL+6u7yhF1PtEyRcHhg5iPBMC7WgaEAxFw0VNedQBg==
X-Gm-Gg: ASbGncvaAt4wCP6rTYCVuyaR/oAauA8Djyzg1HPyguFd92X99IPGmH1lLSjsVeeRh4M
	8OPkyCw8w4TA+l3JqP92SkfLu1v07zTjYWQgBVYSQbBRyoJn2BTi0bNVtnl3xJZEfc3my793kWa
	7omoZ0wnpvsIbSeZt2H1D2//c2mmYuE9DJkKEPFxdr1TQF69qTLu+q0iemu3cyDAn2Y4kvtbTIf
	UiUh/bOi07lij2Q0AWbHxRWzEWhzzDkIBp7uHcDV+Wfu1Z35QVZ99Sa5xdjuPT3r9ngoUXg6wRJ
	Ev1AS++61mTMFSQKSLeHdtF4IO7S4Nh4auZQ1VqftQuJmzsIW9lGlyqKE4P0EM2/Axg=
X-Google-Smtp-Source: AGHT+IEnEli/LI1stPovIbi7sLoVDFcDnxEOS2ugJJweFE5zvm4Vwi5t3dop2M1JHJiXs6/Cz9v1TQ==
X-Received: by 2002:a17:902:db06:b0:215:a56f:1e50 with SMTP id d9443c01a7336-22e100505d0mr173484605ad.8.1746427201577;
        Sun, 04 May 2025 23:40:01 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4dd5:88f9:86cd:18ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eb212sm47522725ad.38.2025.05.04.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 23:40:01 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] bpf: add bpf_msleep_interruptible()
Date: Mon,  5 May 2025 15:38:59 +0900
Message-ID: <20250505063918.3320164-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_msleep_interruptible() puts a calling context into an
interruptible sleep.  This function is expected to be used
for testing only (perhaps in conjunction with fault-injection)
to simulate various execution delays or timeouts.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/bpf/helpers.c           | 13 +++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 5 files changed, 34 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..85bd1daaa7df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3392,6 +3392,7 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_msleep_interruptible_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 71d5ac83cf5d..cbbb6d70a7a3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5814,6 +5814,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_msleep_interruptible(long timeout)
+ *	Description
+ *		Make the current task sleep until *timeout* milliseconds have
+ *		elapsed or until a signal is received.
+ *
+ *	Return
+ *		The remaining time of the sleep duration in milliseconds.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6028,6 +6036,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(msleep_interruptible, 212, ##ctx)		\
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..0a3449c282f2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1905,6 +1905,19 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
 	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
 
+BPF_CALL_1(bpf_msleep_interruptible, long, timeout)
+{
+	return msleep_interruptible(timeout);
+}
+
+const struct bpf_func_proto bpf_msleep_interruptible_proto = {
+	.func		= bpf_msleep_interruptible,
+	.gpl_only	= false,
+	.might_sleep	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 52c432a44aeb..8a0b96aed0c0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1475,6 +1475,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_branch_snapshot_proto;
 	case BPF_FUNC_find_vma:
 		return &bpf_find_vma_proto;
+	case BPF_FUNC_msleep_interruptible:
+		return &bpf_msleep_interruptible_proto;
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 71d5ac83cf5d..cbbb6d70a7a3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5814,6 +5814,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_msleep_interruptible(long timeout)
+ *	Description
+ *		Make the current task sleep until *timeout* milliseconds have
+ *		elapsed or until a signal is received.
+ *
+ *	Return
+ *		The remaining time of the sleep duration in milliseconds.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6028,6 +6036,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(msleep_interruptible, 212, ##ctx)		\
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
-- 
2.49.0.906.g1f30a19c02-goog


