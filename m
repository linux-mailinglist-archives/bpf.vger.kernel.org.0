Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E572C321314
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 10:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBVJ1G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 04:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhBVJ0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 04:26:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E4FC061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 01:25:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n10so13663331wmq.0
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 01:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMs83nr9i6WOwzE7NTSoscgbJn/dHDabycUz9PgtrgI=;
        b=Sa6ObqDt5hYg7xZdsH0WYMoKDLXOixaA94GDY5u4HrV/uffpHNVXNGVDFtjJt0awwo
         6nUudm6WbOL3mW7xT6JfrBpJ/u3UY8+D39B7Q5r0c+y1A0mvbKOZaRrXjX06a0UHZEPX
         UgLRPNKYYYoZ8yysV+oQ84xt0xtR0j2JLO0+W+XIhWH2+cM/vUwn2RLddOwu96qCAfHn
         3qRuV03llXi5hrf6Qw9riYIfWLV0ujL5xkAEQJZVyeml5daE2osmFTNSwYW7P8rfFOMu
         t44lx+QnaYXFP7lFuu27rlvSJcjV0dJz44aoQRcxYqHNebIh/hGFxMd2Kc0BZ9xS/5Ot
         sJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMs83nr9i6WOwzE7NTSoscgbJn/dHDabycUz9PgtrgI=;
        b=P0Y7NDJqVx19t93M2mHwyBfPs7bdyzZQWanutYw49tiL2PV5gC8ANDB7yL0f/31gne
         LVSwtJg6+fpVPiQOE5TfTfRdtBtB7rm8uvJ/dnaaEDFiiCvTaQebVsnqFccA/Ok9jKDa
         yN58rZOLyy/g7Wwb9g7bHCz0TQb/Kw4WaQ2SrOLUnO7isyYCURvt94qKBqk6+Ai1Gitg
         1bEwEjoC8qym/msqsU+QCKViizFTULefGIvXO/H2gORNWPlcg65Zw7u66BVXCgmRykCn
         gsjHiTTLKKGuuCiB/TVLuxCFI9Ugygm84kY8cAd91oUu133VqD8RTsB7Scs756pZXTkz
         koFg==
X-Gm-Message-State: AOAM532HLgCTnSvnnsnFbMNqf6//hywSEig9lKFI2adFYcXWL2RS68Ew
        nZmAzS3q1QEbRj0ag/aXDMQjWRMW7SDnCcvOGf0=
X-Google-Smtp-Source: ABdhPJxciZlPWkrD51P1EA+Bu1Z2GqJ17Nor7ARB7fPuRXX1jPh0IB76xQjd8hgpgasVRAkqCI3paw==
X-Received: by 2002:a05:600c:2113:: with SMTP id u19mr4687777wml.30.1613985940312;
        Mon, 22 Feb 2021 01:25:40 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id 7sm16014110wmi.27.2021.02.22.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:25:40 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH bpf-next] bpf: use MAX_BPF_FUNC_REGISTER_ARGS macro
Date:   Mon, 22 Feb 2021 13:25:31 +0400
Message-Id: <20210222092531.162654-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of using integer literal here and there use macro name for
better context.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/btf.c      | 25 ++++++++++++++-----------
 kernel/bpf/verifier.c |  2 +-
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cccaef1088ea..6946e8e6640a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -505,6 +505,7 @@ enum bpf_cgroup_storage_type {
  * See include/trace/bpf_probe.h
  */
 #define MAX_BPF_FUNC_ARGS 12
+#define MAX_BPF_FUNC_REGISTER_ARGS 5
 
 struct btf_func_model {
 	u8 ret_size;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..c6474d5a9178 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4594,8 +4594,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 	arg = off / 8;
 	args = (const struct btf_param *)(t + 1);
-	/* if (t == NULL) Fall back to default BPF prog with 5 u64 arguments */
-	nr_args = t ? btf_type_vlen(t) : 5;
+	/* if (t == NULL) Fall back to default BPF prog with
+	 * MAX_BPF_FUNC_REGISTER_ARGS u64 arguments.
+	 */
+	nr_args = t ? btf_type_vlen(t) : MAX_BPF_FUNC_REGISTER_ARGS;
 	if (prog->aux->attach_btf_trace) {
 		/* skip first 'void *__data' argument in btf_trace_##name typedef */
 		args++;
@@ -4651,7 +4653,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	} else {
 		if (!t)
-			/* Default prog with 5 args */
+			/* Default prog with MAX_BPF_FUNC_REGISTER_ARGS args */
 			return true;
 		t = btf_type_by_id(btf, args[arg].type);
 	}
@@ -5102,12 +5104,12 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 
 	if (!func) {
 		/* BTF function prototype doesn't match the verifier types.
-		 * Fall back to 5 u64 args.
+		 * Fall back to MAX_BPF_FUNC_REGISTER_ARGS u64 args.
 		 */
-		for (i = 0; i < 5; i++)
+		for (i = 0; i < MAX_BPF_FUNC_REGISTER_ARGS; i++)
 			m->arg_size[i] = 8;
 		m->ret_size = 8;
-		m->nr_args = 5;
+		m->nr_args = MAX_BPF_FUNC_REGISTER_ARGS;
 		return 0;
 	}
 	args = (const struct btf_param *)(func + 1);
@@ -5330,8 +5332,9 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	}
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
-	if (nargs > 5) {
-		bpf_log(log, "Function %s has %d > 5 args\n", tname, nargs);
+	if (nargs > MAX_BPF_FUNC_REGISTER_ARGS) {
+		bpf_log(log, "Function %s has %d > %d args\n", tname, nargs,
+			MAX_BPF_FUNC_REGISTER_ARGS);
 		goto out;
 	}
 
@@ -5460,9 +5463,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 	}
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
-	if (nargs > 5) {
-		bpf_log(log, "Global function %s() with %d > 5 args. Buggy compiler.\n",
-			tname, nargs);
+	if (nargs > MAX_BPF_FUNC_REGISTER_ARGS) {
+		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\n",
+			tname, nargs, MAX_BPF_FUNC_REGISTER_ARGS);
 		return -EINVAL;
 	}
 	/* check that function returns int */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d34ba492d46..e3ad5d6f42bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5544,7 +5544,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 
 	meta.func_id = func_id;
 	/* check args */
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REGISTER_ARGS; i++) {
 		err = check_func_arg(env, i, &meta, fn);
 		if (err)
 			return err;
-- 
2.25.1

