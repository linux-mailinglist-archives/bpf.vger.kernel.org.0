Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229A64E9ED4
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbiC1SSx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245152AbiC1SSk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 14:18:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CCB5D677
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:16:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e5db04460cso124082977b3.17
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/F5gfRvEdyS2sn1sTwI1ToLzIsHj+B5IxBw57Or4uew=;
        b=qKbS/lcm6IOmk2nmOLJcBt9knnggNfMBq/L8mhbLzfzGQCNfE6khn9pOn7ChUXR38b
         UZE0GpG/5FQ0blH7Ml3DxJky8ALTZIstpvsBEWVe7YeqhDRzRzWQhkmDpuqXeYL1xhzp
         oKxwbSBxYbi7mGvlqvAtjlCoWj/1EoNQBP2XU48ryqdJfobjXsJ1CdDLF1oLreizkZHe
         8ZyELzZ0+8pEEq+IJxon3PCWNYfr+RNG+Yt3C97QiDipH7hBglW+C2cXwspvqfCX6LQl
         /zPHGaIHpGUeMvjYyLn/G1ZKU6kth3A5MWhOHl88IB5dm+nShe5k8/Eq0gLX3enklaRR
         FONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/F5gfRvEdyS2sn1sTwI1ToLzIsHj+B5IxBw57Or4uew=;
        b=1tEjvA28Y6NAUKzV3lZTR/ChezjfJCvRlmKcGP/UF+X3+j00iry8eoss397kkpAbuu
         G2bPvAMbt2jySka8eXKsqYlD+4RI6n/OO5PdWmdj1EE9UFbKtJM3rPlrhVwlcv72x5YD
         Ho+ePvmMdhnf7S6Mw24PncJyzbFosQRZfG440V3MotTel4H/HiW4cA/aACJnq+Nv4Ay4
         qDfm3H264C2+gZDBRekSe/tsWErRJbz1awWxTNz2eGCf8xnfyyQX+wCXAjhyk5CQqga7
         sEhAR6ukwRCWe2//4cH//Rw+1+6MqCwH3rqLRFMKuSfUZAKkjdU4zTctzvQ78+aR2vJV
         9t4A==
X-Gm-Message-State: AOAM532qIVo9oFT9tXADgKFLR3l6QdlfhVlIJ1Nd0uS3SbX0FVEoQLGr
        8Cu/9HEbOEDfD+Wsd/3oVuXY4Fc=
X-Google-Smtp-Source: ABdhPJzqIMV6Ry+GWZxYcVy/sQGCdQZUUzo9NL/oGx/nnIZPmjndtsOBV2xU/iju6AeRrIkb9GVGO28=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:a900:e0f6:cf98:d8c8])
 (user=sdf job=sendgmr) by 2002:a25:9f0d:0:b0:634:37e:3b8c with SMTP id
 n13-20020a259f0d000000b00634037e3b8cmr25121216ybq.8.1648491416289; Mon, 28
 Mar 2022 11:16:56 -0700 (PDT)
Date:   Mon, 28 Mar 2022 11:16:41 -0700
In-Reply-To: <20220328181644.1748789-1-sdf@google.com>
Message-Id: <20220328181644.1748789-5-sdf@google.com>
Mime-Version: 1.0
References: <20220328181644.1748789-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH bpf-next 4/7] bpf: allow writing to a subset of sock fields
 from lsm progtype
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For now, allow only the obvious ones, like sk_priority and sk_mark.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/bpf_lsm.c  | 58 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  3 ++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 9cc2f0bf78f1..86e2ec2ce7fd 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -332,7 +332,65 @@ bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
+static int lsm_btf_struct_access(struct bpf_verifier_log *log,
+					const struct btf *btf,
+					const struct btf_type *t, int off,
+					int size, enum bpf_access_type atype,
+					u32 *next_btf_id,
+					enum bpf_type_flag *flag)
+{
+	const struct btf_type *sock_type;
+	struct btf *btf_vmlinux;
+	s32 type_id;
+	size_t end;
+
+	if (atype == BPF_READ)
+		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+					 flag);
+
+	btf_vmlinux = bpf_get_btf_vmlinux();
+	if (!btf_vmlinux) {
+		bpf_log(log, "no vmlinux btf\n");
+		return -EOPNOTSUPP;
+	}
+
+	type_id = btf_find_by_name_kind(btf_vmlinux, "sock", BTF_KIND_STRUCT);
+	if (type_id < 0) {
+		bpf_log(log, "'struct sock' not found in vmlinux btf\n");
+		return -EINVAL;
+	}
+
+	sock_type = btf_type_by_id(btf_vmlinux, type_id);
+
+	if (t != sock_type) {
+		bpf_log(log, "only 'struct sock' writes are supported\n");
+		return -EACCES;
+	}
+
+	switch (off) {
+	case bpf_ctx_range(struct sock, sk_priority):
+		end = offsetofend(struct sock, sk_priority);
+		break;
+	case bpf_ctx_range(struct sock, sk_mark):
+		end = offsetofend(struct sock, sk_mark);
+		break;
+	default:
+		bpf_log(log, "no write support to 'struct sock' at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log,
+			"write access at off %d with size %d beyond the member of 'struct sock' ended at %zu\n",
+			off, size, end);
+		return -EACCES;
+	}
+
+	return NOT_INIT;
+}
+
 const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
+	.btf_struct_access = lsm_btf_struct_access,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d2f2e7babb2..d42ee0033755 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12843,7 +12843,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
 				env->prog->aux->num_exentries++;
-			} else if (resolve_prog_type(env->prog) != BPF_PROG_TYPE_STRUCT_OPS) {
+			} else if (resolve_prog_type(env->prog) != BPF_PROG_TYPE_STRUCT_OPS &&
+				   resolve_prog_type(env->prog) != BPF_PROG_TYPE_LSM) {
 				verbose(env, "Writes through BTF pointers are not allowed\n");
 				return -EINVAL;
 			}
-- 
2.35.1.1021.g381101b075-goog

