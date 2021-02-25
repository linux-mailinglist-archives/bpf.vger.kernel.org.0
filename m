Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7012832579B
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBYU1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 15:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhBYU1a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 15:27:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6CC061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 12:26:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b3so6516423wrj.5
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5VK8xryObtr9m4Ka1rMfg1RkUM659RsWN0h8LmMthU=;
        b=Mwbmz51qe6UT2mrc54XOzfEbyPeXeh64UjKUoRBCRFZ8RuF4mNs4Ferq8IUElZsAiz
         OCOxdYu+Dzg34s1NrJk91MRGOEAIUeZ00p+rykJGYdMjodRCWaOhGHT2bn5XSXJj2t4D
         ApWJtWCXLSADZlhk/DguSTmC6aJON9qmNiHbOL4yS2sB26Bzp/R8bKOVKBz5pI657sWu
         SwuFdjLlUiehuwXXGpGfBDOhdlX/8/c4hmVIX0MfvIK2DJcQU9H+qIx5hxwN0be3Eaft
         gRS23Uda+9x5x85veAWRyzfo5QlmemnzUO7AjEgaLqQr25B/EZ6NQPVEV1aR07PdbkiX
         FYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5VK8xryObtr9m4Ka1rMfg1RkUM659RsWN0h8LmMthU=;
        b=olR8A3T9Yl+OAlidUn09n1skALv32J+HNajRj6GzbgOEzo/at9XxJSDDfXesTWGkBn
         je8QSknBzDNAcqRk3Rfjited7bzOxI01ALsO2RxlfASTSlLQkCYIJbEgUeRif+poEUK2
         awn3G2nBIv6fFVdGTCjvylP6R07FtEtgjp7+zweMXcBEmlSSJ0VjH8FbwLPGFg4YiAVH
         8j0JVbeh27sr6kschfSdwd37ENA6PwzyK6RVIPTQ9rTIxSPEeX8SjqPJEEPNqqrQQMeh
         0rp1JF9Kgs3KryIiAe45QTBtXynkMrrdoQZAW+g9dwJMHxJcR8y0Tz0DhbaH43c7GJCj
         QBMA==
X-Gm-Message-State: AOAM532mzrnGRdxeoot4prY9vYniysb15N6QxwTcczEt05Lk8s02GYip
        0vNXN/k9fa2pLEVg7bflMC9wQnaswIGp5nmH
X-Google-Smtp-Source: ABdhPJzSO25Fa/pVVBij1kRxy/tsXwycC0iOHDXgZ2KRUs3elqEm1m8JO0qy6u+R3hOd3FMkhfjxdw==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr5089526wrx.226.1614284807840;
        Thu, 25 Feb 2021 12:26:47 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id e12sm10230812wrv.59.2021.02.25.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:26:47 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v2 bpf-next] bpf: use MAX_BPF_FUNC_REG_ARGS macro
Date:   Fri, 26 Feb 2021 00:26:29 +0400
Message-Id: <20210225202629.585485-1-me@ubique.spb.ru>
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
 v1 -> v2:
  * Rename MAX_BPF_FUNC_REGISTER_ARGS to
    MAX_BPF_FUNC_REG_ARGS
  * Clarify the macro purpose in comments

 include/linux/bpf.h   |  5 +++++
 kernel/bpf/btf.c      | 25 ++++++++++++++-----------
 kernel/bpf/verifier.c |  2 +-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cccaef1088ea..7088dcc3f6a0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -506,6 +506,11 @@ enum bpf_cgroup_storage_type {
  */
 #define MAX_BPF_FUNC_ARGS 12
 
+/* The maximum number of arguments passed through registers
+ * a single function may have.
+ */
+#define MAX_BPF_FUNC_REG_ARGS 5
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 nr_args;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..16e8148a28e2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4594,8 +4594,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 	arg = off / 8;
 	args = (const struct btf_param *)(t + 1);
-	/* if (t == NULL) Fall back to default BPF prog with 5 u64 arguments */
-	nr_args = t ? btf_type_vlen(t) : 5;
+	/* if (t == NULL) Fall back to default BPF prog with
+	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
+	 */
+	nr_args = t ? btf_type_vlen(t) : MAX_BPF_FUNC_REG_ARGS;
 	if (prog->aux->attach_btf_trace) {
 		/* skip first 'void *__data' argument in btf_trace_##name typedef */
 		args++;
@@ -4651,7 +4653,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	} else {
 		if (!t)
-			/* Default prog with 5 args */
+			/* Default prog with MAX_BPF_FUNC_REG_ARGS args */
 			return true;
 		t = btf_type_by_id(btf, args[arg].type);
 	}
@@ -5102,12 +5104,12 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 
 	if (!func) {
 		/* BTF function prototype doesn't match the verifier types.
-		 * Fall back to 5 u64 args.
+		 * Fall back to MAX_BPF_FUNC_REG_ARGS u64 args.
 		 */
-		for (i = 0; i < 5; i++)
+		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
 			m->arg_size[i] = 8;
 		m->ret_size = 8;
-		m->nr_args = 5;
+		m->nr_args = MAX_BPF_FUNC_REG_ARGS;
 		return 0;
 	}
 	args = (const struct btf_param *)(func + 1);
@@ -5330,8 +5332,9 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	}
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
-	if (nargs > 5) {
-		bpf_log(log, "Function %s has %d > 5 args\n", tname, nargs);
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		bpf_log(log, "Function %s has %d > %d args\n", tname, nargs,
+			MAX_BPF_FUNC_REG_ARGS);
 		goto out;
 	}
 
@@ -5460,9 +5463,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 	}
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
-	if (nargs > 5) {
-		bpf_log(log, "Global function %s() with %d > 5 args. Buggy compiler.\n",
-			tname, nargs);
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\n",
+			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
 	/* check that function returns int */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dda9d81f12c..9f7e35590fc6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5544,7 +5544,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 
 	meta.func_id = func_id;
 	/* check args */
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		err = check_func_arg(env, i, &meta, fn);
 		if (err)
 			return err;
-- 
2.25.1

