Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6174B4F8B44
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 02:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiDGWd3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 18:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiDGWd1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 18:33:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5A68322
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 15:31:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so60372587b3.12
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hu7sUD5zyrHl5uiPKZlxY1ld6/Ce7TFF/TdsyLVX5fA=;
        b=Z6BrmJufof+OAh4RHiyvCakRSlX6zl3BpcHdpFqTKVKvMBbnf2qF55Lkwt4wzKLgXV
         mMsfuVLwEYvq9w+JUA3GEAUhdfy9qdJn4zH4LWzlP3zmQ+0d7bW6XRsKRBQ4m5Iz+qYD
         43VGaMnr2dX+lyjaC6fj66+VJtf9ctV6HCD3ihd1emlRC88y/r06iA7l21tq50I5LLWU
         dtaACP2rtjIwI/OksasjTkN+iisSVDFzPtwRc+kl/zAfE4CkCb19yJh6OifyZ9vR1hnA
         VLf+zfnO1kGVtX9o4CILAkquciEm/s5QPxdczRO+hydoG37rqFpW4+giMjUm/4Vd2iRO
         VUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hu7sUD5zyrHl5uiPKZlxY1ld6/Ce7TFF/TdsyLVX5fA=;
        b=4axp5NETzG0cl3Llo76aFJKNf2DvLXZVO7BqzhSaK5uQukdKIYU3ffFuyKzCGE25eD
         V5u2VhgFZW4h99ec9q5ukRs4zGb1pTTTnRzKF7uInRyOsU06NfWtJCQnwOxYVZlF2iW/
         xbTNAO+3JHN4/cmaIR/AXdSgL//Bo1Sioq8nVbL/OKCCbuJ1mSQfPtlq9FbmhkfIov4U
         FgpZoCfmTjLX6qtcUI4Z+tChYpBD0OcTlIDQNMiduwPhZbm55PJfrgnJTF6lhqhJru6V
         gjbIeCwDJozWs5nwdxtQVBgCBSX1li76ABLTeJ0R3XUiyVFtBwUzNoFW0WpvMuM4g6DE
         +a1g==
X-Gm-Message-State: AOAM5324/1RunFbrEOQQQ+aswUwo5hWTiZXelfp82aiaeChp/AMSIBv8
        5g3uzm+Qa4fKBY1oUG/JF8Z+uYo=
X-Google-Smtp-Source: ABdhPJxYU1HvQcbPCFWfq7pj4Wl40jse127SVfUec3jZgK1vTd7ZTK2uEc+R1XDy+ZJVzjzvO1hFgR4=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:9e25:5910:c207:e29a])
 (user=sdf job=sendgmr) by 2002:a25:6f04:0:b0:63a:ee50:5afb with SMTP id
 k4-20020a256f04000000b0063aee505afbmr12076760ybc.443.1649370684423; Thu, 07
 Apr 2022 15:31:24 -0700 (PDT)
Date:   Thu,  7 Apr 2022 15:31:09 -0700
In-Reply-To: <20220407223112.1204582-1-sdf@google.com>
Message-Id: <20220407223112.1204582-5-sdf@google.com>
Mime-Version: 1.0
References: <20220407223112.1204582-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH bpf-next v3 4/7] bpf: allow writing to a subset of sock fields
 from lsm progtype
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index cc84954846d7..0d6d5be30a36 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12872,7 +12872,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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
2.35.1.1178.g4f1659d476-goog

