Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9452C6E3
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiERW5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiERW4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:56:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341ACE81
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 15:55:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so31164537b3.13
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 15:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rb7MpxVn2W+tG0fwq45pHzqTPq6ipYBqcZkIgmB3HVk=;
        b=kBece5rxz9bNzDhOAj78myi+bbB8c08mqKJH8sTTT9+clfVJhLljsWlKSmGtmwtyFc
         kGBeRB/O7ccvE9hblo/SCPy8yDFiagCk/09Ruwa23RzrSBylX4NVYe8f8BEr+xG6Y2fP
         gaThmJ1UxAPljbvmeBr9lWSCpqcpiDGppyzJGqEywb+ZLDJzNIFTV0MdgimHBsqKUZJy
         MKJ3jm9knpXBfAS97NabFFwgdERxXzwtBaTYKfMqDZovJsl2ARIwNkde36HFOmFtqpSa
         Y+jMn2wZVR0HfB1a3Zg2tM0LBWddjZW+qQuQcxPsC8cdrbsNzsnfDFM18SFc1HhbEW+I
         va5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rb7MpxVn2W+tG0fwq45pHzqTPq6ipYBqcZkIgmB3HVk=;
        b=xW+PXiIDaAxRxE/QWSJFJS3KDHVQky8nxV82Y5GUaV4Cc7orTS8zyPdp6C6PtwkK0V
         Mm46yv0Rt5Zi35QcPiiHmRgk3kEBWYrxY0N8V77krHNboLcC85q0ia9mxYpeK1Z802km
         300m3Akfqq38nctEx6I4V7+TdRINFg293nh0QAa7SCEGOjDxxyb3/4HREsh6VdsmZyYT
         9YWP+geh2AxitqWkZo6L1mUQKfV9a1aLB7ryJAVA9zEtVU9q2SqRJxKkry7GiEBiihIK
         rRaPz5K2kWicr6j1rLHaLo82V+jb+4XSJ14JIuQjPvdy2kXRv7YmMfUYuPTelUqtL0hD
         RRIQ==
X-Gm-Message-State: AOAM531tGJ4Lig7y3EcnoaINDa3SHoJ3xCZPCrsvehdS3bWSCu0cfpui
        3VY+Wx5w3xU5YKxX3PwNUqpv/5k=
X-Google-Smtp-Source: ABdhPJzYfjscLmcDq/Md0pmVuyIqhNq9Lz4Bhkl9rIKWsw5Lf4e5IgRPYyup9oe6ID7TVuUy08rZLWc=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f763:3448:2567:bf00])
 (user=sdf job=sendgmr) by 2002:a81:60b:0:b0:2fb:3029:adc6 with SMTP id
 11-20020a81060b000000b002fb3029adc6mr1805929ywg.109.1652914546224; Wed, 18
 May 2022 15:55:46 -0700 (PDT)
Date:   Wed, 18 May 2022 15:55:26 -0700
In-Reply-To: <20220518225531.558008-1-sdf@google.com>
Message-Id: <20220518225531.558008-7-sdf@google.com>
Mime-Version: 1.0
References: <20220518225531.558008-1-sdf@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH bpf-next v7 06/11] bpf: allow writing to a subset of sock
 fields from lsm progtype
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
index 96503c3e7a71..b7e9ed8325f5 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -305,7 +305,65 @@ bool bpf_lsm_is_sleepable_hook(u32 btf_id)
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
index ff43188e3040..af9b9ba8b796 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13151,7 +13151,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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
2.36.1.124.g0e6072fb45-goog

