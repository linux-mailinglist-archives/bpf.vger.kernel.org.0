Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D0314910
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBIGpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBIGpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 01:45:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC84C061788
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 22:44:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g10so20320710wrx.1
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 22:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcCmbp5yRvcemtdORz/BSWwbmC4kuvt8psBZg6yst2Q=;
        b=PypcP2gCvzBEv4fz7Z6p5uEcpfpjfMZG/a8NitMy/OD32i5M13B8A8XOxctPe/zjsy
         rpwd51m7pkO8F+Jgcmv725xBM4OrzPJ6ODk2Nv+LOi25HhlqwP4nykIWB8HQqIL4PQ4S
         zfGj99deXfTImTbzj//tU7h5nf9ZPhZ1/B8uA+HzXLbYRifLV4enSyPG0yLrqHIjJg0U
         3lGHvrwLzQkuPl9dwHBGLCr7PmqFpVrYarDXtTFU8SgznkatkEHrGJp4BZ7IpzapWPXQ
         8BvfO8AjWVBs98XTjhc9DkPWphefFsoeCk6CYRXhxqjEn9j8A5I06N7eAbh8Xe5AZq2V
         8L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcCmbp5yRvcemtdORz/BSWwbmC4kuvt8psBZg6yst2Q=;
        b=E//ixLn1a5MXZS72KDALkYlS4y9OvoPB2W11XON7LBXSNZ4jmAnq5IlbWY+QCUMlv2
         JCFiE2lhbhXQ2zTb0WcvAzfkYFP7N8mSgmQlbJWeYVv7ePywr78j7ZZHdWE6ZrpXlWf+
         yQLVpg3gDS/VMIEQYfKCQ5y0HJxfT2FmDudEk8sdVJXqqk655yOe8ZESLf5lcKYjhB29
         UQAWxOgCWivVUiPIyFc+2eEsj+dqrSXGBZIU5Nt5gjWEhsr5XpA2JDPdNeaJNMx73MHG
         zubGtQoUhXLF+ApXu7Sm/Ga++UqG/jW0yPTPyhfsHilKxFc5XhowQLnM2no0K2WoHbzY
         KZmg==
X-Gm-Message-State: AOAM533v3r1kzDMMe1C357TkvcrRBLAgKEr4WqbUd7TnBFMZARz+PFe5
        PBNEGWsBzbXcFCAX3GnlXvqTd8TJc83nTb7AsFE=
X-Google-Smtp-Source: ABdhPJzEtwcsneU4B14UixvXKX/Ds/dRVvGj1blNRd9NWlSUWotnz5fMvwZ9BMN+0J7NNL+D4VWRew==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr23650544wru.64.1612853082454;
        Mon, 08 Feb 2021 22:44:42 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id j11sm33754938wrt.26.2021.02.08.22.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:44:42 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v2 bpf-next 1/4] bpf: Rename bpf_reg_state variables
Date:   Tue,  9 Feb 2021 10:44:18 +0400
Message-Id: <20210209064421.15222-2-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209064421.15222-1-me@ubique.spb.ru>
References: <20210209064421.15222-1-me@ubique.spb.ru>
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

