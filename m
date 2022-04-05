Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD74F4DA1
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453043AbiDEXrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577684AbiDEXMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 19:12:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72D8FCBC3
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 14:44:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb5d4fbd54so4829467b3.4
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6NblM4DdSDjYKjDgLxEintAgK2IySwji0MbdGVjQAJ0=;
        b=aH7t3UmNuSMetoAxnT29hxQBjyn++fuJ7enCmtqyWIsfGhMm81NfSU5Nsxn6Fj9iuA
         TD7F3D5JrZ9gjaADebR/1Y6cS6NJneMk4y3euudNGGK4sQfKW+8r/CwY7VbgYJDbgqLA
         Hn+nTh34dLgSC5vLlYbRCxxi0ln6Fw6i/Ba8vnN9S+9E8McgZTlcpLsmMVQz5ER5pNYW
         rQHwOYEx9T/ZvNJfJHXwlzP0ZGC6PMD8wlYPt11XffIgFhYO89O4en2PzT/qLTkyzX9p
         6Cfv7Spx/dXn5IbU95dJzaEYQHoj/3xpDXcOJt9GLg93KSMeaMqD5u+FaMYQeRL0Nzej
         JKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6NblM4DdSDjYKjDgLxEintAgK2IySwji0MbdGVjQAJ0=;
        b=tLxMPn7UaPUqYFysYBTf+Ilb0NCih+4+pzkmox0XrJxd7wKzblgcTcm9vgi44XuXe7
         TjSQvVCf8cSDM7ENojvPdcGWOfnkBklC4GKkaUcwvwPwbnzqc5XsFLZ+UFEFNXL5dWbp
         DPkzjQHmCNkC9IPlOXUCaLhqhhIHG2bA+MnxbgHzRzPzEIGpLou4Ug13A1bMTsYV0jih
         usVul8ELLBUzOqfaQ4KxuBHrrMa4yqrn7Pi9JBMf+FdFPnNDl+kYH3CMJdL3Db3/CayV
         0AogHLLKnilCDCfJLas0jyncfxXyypFrJ5x3W2lGa3CR2WrRsX7z9icAlEJ5MsgWBYy+
         B/kQ==
X-Gm-Message-State: AOAM533Z88vL+VMDFd/5XEWC9Y6WMle+ky4I50wLZIxy050wUBHgdph8
        vzZJ67yg9WKB313hizAsGjuiIT4=
X-Google-Smtp-Source: ABdhPJz3bIH4Nxzw2caA4SgqgSA/xVwcc5VpbPucgbV0dvxX8YFSZFFqtXVW0z6sHMfbuDac/SI7xW8=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:73b5:ffab:2024:2901])
 (user=sdf job=sendgmr) by 2002:a81:b288:0:b0:2d6:39d5:31a1 with SMTP id
 q130-20020a81b288000000b002d639d531a1mr4504807ywh.506.1649195035035; Tue, 05
 Apr 2022 14:43:55 -0700 (PDT)
Date:   Tue,  5 Apr 2022 14:43:39 -0700
In-Reply-To: <20220405214342.1968262-1-sdf@google.com>
Message-Id: <20220405214342.1968262-5-sdf@google.com>
Mime-Version: 1.0
References: <20220405214342.1968262-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH bpf-next v2 4/7] bpf: allow writing to a subset of sock fields
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
index 8b948ec9ab73..cc13da18d8b3 100644
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
2.35.1.1094.g7c7d902a7c-goog

