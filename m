Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1591162F97C
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 16:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbiKRPks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 10:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiKRPkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 10:40:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA120742D8
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 07:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6630DB8244E
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 15:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441A7C433C1;
        Fri, 18 Nov 2022 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668786044;
        bh=wAiAa4IvDWNej1wH44xVVUqK0bgIQb7sCrmyxCphMg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0m2Pttwc7k5WylnSGsULqrAC4DIvgr1PxRffT4ZPfIKvoRPd8RAfb6Mu3ilxudgT
         I/zAEsJlECw4wym+8QTmE4eOuElX6o1pcn/X/ao4Ccrqokaw0zJsK8W2iAYIETLOpD
         b1eGy9Er0NmEnATzc3lxF3vaYVk+q2F3TIoU0BreKDM4IEF/lGZXxL+7+NNJcF1YXB
         tIPmVd7kyKvoLePFoavbLj2pWPnPKBHGJPj6TDmlqLmAVkbsSyCXet774lBzAjSt9T
         9aWjy7TaHMTF4NlFvuWvAKgm/uYqhbq8ayD45hboboGFfCpfHHMFjJz2fKK7K0zkKa
         zSlna9gMuTvAQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function and kfunc
Date:   Fri, 18 Nov 2022 16:40:27 +0100
Message-Id: <20221118154028.251399-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118154028.251399-1-jolsa@kernel.org>
References: <20221118154028.251399-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_vma_build_id_parse function to retrieve build id from
passed vma object and making it available as bpf kfunc.

We can't use build_id_parse directly as kfunc, because we would
not have control over the build id buffer size provided by user.

Instead we are adding new bpf_vma_build_id_parse function with
'build_id__sz' argument that instructs verifier to check for the
available space in build_id buffer.

This way  we check that there's  always available memory space
behind build_id pointer. We also check that the build_id__sz is
at least BUILD_ID_SIZE_MAX so we can place any buildid in.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      |  4 ++++
 kernel/bpf/verifier.c    | 26 ++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b32376ce746..7648188faa2c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2805,4 +2805,8 @@ static inline bool type_is_alloc(u32 type)
 	return type & MEM_ALLOC;
 }
 
+int bpf_vma_build_id_parse(struct vm_area_struct *vma,
+			   unsigned char *build_id,
+			   size_t build_id__sz);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 195d24316750..e20bad754a3a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8746,6 +8746,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
+BTF_ID_LIST_SINGLE(bpf_vma_build_id_parse_id, func, bpf_vma_build_id_parse)
+
+static int check_kfunc_caller(struct bpf_verifier_env *env, u32 func_id)
+{
+	struct bpf_func_state *cur;
+	struct bpf_insn *insn;
+
+	/* Allow bpf_vma_build_id_parse only from bpf_find_vma callback */
+	if (func_id == bpf_vma_build_id_parse_id[0]) {
+		cur = env->cur_state->frame[env->cur_state->curframe];
+		if (cur->callsite != BPF_MAIN_FUNC) {
+			insn = &env->prog->insnsi[cur->callsite];
+			if (insn->imm == BPF_FUNC_find_vma)
+				return 0;
+		}
+		verbose(env, "calling bpf_vma_build_id_parse outside bpf_find_vma "
+			"callback is not allowed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -8797,6 +8820,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	if (check_kfunc_caller(env, func_id))
+		return -EACCES;
+
 	/* Check the arguments */
 	err = check_kfunc_args(env, &meta);
 	if (err < 0)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2d8d070d024..7f08e6c3a080 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/key.h>
 #include <linux/verification.h>
+#include <linux/buildid.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1383,6 +1384,36 @@ static int __init bpf_key_sig_kfuncs_init(void)
 late_initcall(bpf_key_sig_kfuncs_init);
 #endif /* CONFIG_KEYS */
 
+int bpf_vma_build_id_parse(struct vm_area_struct *vma,
+			   unsigned char *build_id,
+			   size_t build_id__sz)
+{
+	__u32 size;
+	int err;
+
+	if (build_id__sz < BUILD_ID_SIZE_MAX)
+		return -EINVAL;
+
+	err = build_id_parse(vma, build_id, &size);
+	return err ?: (int) size;
+}
+
+BTF_SET8_START(tracing_btf_ids)
+BTF_ID_FLAGS(func, bpf_vma_build_id_parse)
+BTF_SET8_END(tracing_btf_ids)
+
+static const struct btf_kfunc_id_set tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &tracing_btf_ids,
+};
+
+static int __init kfunc_tracing_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
+}
+
+late_initcall(kfunc_tracing_init);
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.38.1

