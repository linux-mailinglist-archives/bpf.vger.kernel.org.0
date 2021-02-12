Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6721931A655
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 21:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhBLU5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 15:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBLU5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 15:57:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747BC0613D6
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:56:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v1so822468wrd.6
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcCmbp5yRvcemtdORz/BSWwbmC4kuvt8psBZg6yst2Q=;
        b=JtnnLMzVw0nn7lv5b0Q9K8asUdDtVmlnHSZqldiMRg3CTVh+gHSaT028gKBlIpF43c
         labwtEo7AqKZ7YHGLaNFWxwpSOdaJ4GGIjxqlVDMBn38NtAqW30cdzQ7yedfCLWP12ty
         MKvTEgUzAW+RxSn4fthYq8a8R8SxiARgq5K8Q5nul0Rd6+t0xBPEebJXrdggHRCm2I71
         ss2Nv/Uwt76q8V/KoJjTob+kci49JzyH5k4+aCEkYbW+lOL455HYDWdFUfHXwPfMeX2a
         cjYH2q2jijydHZWhavdOOsHg3JHmyFuJhFNNwhN8Vusl8ckjYSuyTk6/8jlcJO1CXGlG
         PSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcCmbp5yRvcemtdORz/BSWwbmC4kuvt8psBZg6yst2Q=;
        b=sFo/RAviJL8zTwWas/mR+uPnwtq+3JXTwnQNY8TXUfrSGULQcve7WHoK2r85ENZSRC
         rmOSwTFKqev543Z7sLpBRpOnlXTXECm2pvJLEdy/TBolutWvPyvT3S5rO32NO4ephTNc
         jItdrxDO0PFHRDoR+zuhTmshVA3dcMfS82SuYfX0RlZ2mblQ4xGuTrvmqtiuDCHYQXC3
         RGzFM8PXmXxEb5onqd/cdXBrxS5w0xhLrOB1emnSp4XTb4m6/8ZNJhZL24GLJY0xQqrY
         UxEjcjA1cVhGGz01Nge8B2GnPgJBjVkTBiDBCpWwVUYrKuvUEhfAufavIWNLk61PUSwR
         nrEw==
X-Gm-Message-State: AOAM533Vf1FdGMGyg88jv6ZEKJ5099BgavmQmvnKJve70foyLrlVVweG
        eKPLVCEyfbS1KcVY0imFk30Kl0zygAHa7mW8tYM=
X-Google-Smtp-Source: ABdhPJwdhU3Ds7q3osX2/AYt8U+ee72hn8ZpV4gwBU6HLWj4jqePxlX3Krmy559P+ZLJFux1iOQxzQ==
X-Received: by 2002:adf:a1c4:: with SMTP id v4mr5587723wrv.104.1613163417897;
        Fri, 12 Feb 2021 12:56:57 -0800 (PST)
Received: from localhost ([91.73.148.48])
        by smtp.gmail.com with ESMTPSA id c11sm11800963wrs.28.2021.02.12.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:56:57 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v3 bpf-next 1/4] bpf: Rename bpf_reg_state variables
Date:   Sat, 13 Feb 2021 00:56:39 +0400
Message-Id: <20210212205642.620788-2-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212205642.620788-1-me@ubique.spb.ru>
References: <20210212205642.620788-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using "reg" for an array of bpf_reg_state and "reg[i + 1]" for an
individual bpf_reg_state is error-prone and verbose. Use "regs" for the
former and "reg" for the latter as other code nearby does.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 kernel/bpf/btf.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 756a93f534b6..bd5d2c563693 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5291,7 +5291,7 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
  * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
  */
 int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
-			     struct bpf_reg_state *reg)
+			     struct bpf_reg_state *regs)
 {
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_prog *prog = env->prog;
@@ -5337,17 +5337,19 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	 * verifier sees.
 	 */
 	for (i = 0; i < nargs; i++) {
+		struct bpf_reg_state *reg = &regs[i + 1];
+
 		t = btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
 			t = btf_type_by_id(btf, t->type);
 		if (btf_type_is_int(t) || btf_type_is_enum(t)) {
-			if (reg[i + 1].type == SCALAR_VALUE)
+			if (reg->type == SCALAR_VALUE)
 				continue;
 			bpf_log(log, "R%d is not a scalar\n", i + 1);
 			goto out;
 		}
 		if (btf_type_is_ptr(t)) {
-			if (reg[i + 1].type == SCALAR_VALUE) {
+			if (reg->type == SCALAR_VALUE) {
 				bpf_log(log, "R%d is not a pointer\n", i + 1);
 				goto out;
 			}
@@ -5355,13 +5357,13 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			 * is passing PTR_TO_CTX.
 			 */
 			if (btf_get_prog_ctx_type(log, btf, t, prog->type, i)) {
-				if (reg[i + 1].type != PTR_TO_CTX) {
+				if (reg->type != PTR_TO_CTX) {
 					bpf_log(log,
 						"arg#%d expected pointer to ctx, but got %s\n",
 						i, btf_kind_str[BTF_INFO_KIND(t->info)]);
 					goto out;
 				}
-				if (check_ctx_reg(env, &reg[i + 1], i + 1))
+				if (check_ctx_reg(env, reg, i + 1))
 					goto out;
 				continue;
 			}
@@ -5388,7 +5390,7 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
  * (either PTR_TO_CTX or SCALAR_VALUE).
  */
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *reg)
+			  struct bpf_reg_state *regs)
 {
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_prog *prog = env->prog;
@@ -5459,16 +5461,18 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
 	for (i = 0; i < nargs; i++) {
+		struct bpf_reg_state *reg = &regs[i + 1];
+
 		t = btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
 			t = btf_type_by_id(btf, t->type);
 		if (btf_type_is_int(t) || btf_type_is_enum(t)) {
-			reg[i + 1].type = SCALAR_VALUE;
+			reg->type = SCALAR_VALUE;
 			continue;
 		}
 		if (btf_type_is_ptr(t) &&
 		    btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-			reg[i + 1].type = PTR_TO_CTX;
+			reg->type = PTR_TO_CTX;
 			continue;
 		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
-- 
2.25.1

