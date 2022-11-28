Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A1C63A981
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 14:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiK1NaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 08:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiK1N3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 08:29:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4351E3F2
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 05:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2239F61194
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE7FC433D7;
        Mon, 28 Nov 2022 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669642189;
        bh=hGgNL0rZQAe5vy3bzsX3ZJ2q0/dj+a0eeDIFxu6OULE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucgKgedaKZagWxuP8Q+CzY0pTAlOet8j54mpI4PN+tyVWuK9rir4XPnGbs1tqRbIR
         PdTwc0vD+TweKW6ZJeFoSD1VXqOo5dkOZ0Zk9UiPYVlAYkr45p6EddTmTkbfi10a9G
         Tmz5rwhi5G/ovJX693VNiX3YmBNkXV5V8z7yF7zuirKaZVjiXuOZiygBGBGIOJmJi9
         zYaRbdO2Ugb7al6U3xt2sbNAWS1KFENq08vit6sgYv62eUI4qPIDoX9MzgKvs13uQK
         lO34B9WVkpJiYDntvRHrztLcEI+/nPxZcxJvk22jlGE1HgQWvVCKz9+zCTtvh4iJRk
         nmdFBlnZ+H6gQ==
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
Subject: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function and kfunc
Date:   Mon, 28 Nov 2022 14:29:13 +0100
Message-Id: <20221128132915.141211-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128132915.141211-1-jolsa@kernel.org>
References: <20221128132915.141211-1-jolsa@kernel.org>
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

This way we check that there's always available memory space
behind build_id pointer. We also check that the build_id__sz is
at least BUILD_ID_SIZE_MAX so we can place any buildid in.

The bpf_vma_build_id_parse kfunc is marked as KF_TRUSTED_ARGS,
so it can be only called with trusted vma objects. These are
currently provided only by find_vma callback function and
task_vma iterator program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      |  4 ++++
 kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c6aa6912ea16..359c8fe11779 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2839,4 +2839,8 @@ static inline bool type_is_alloc(u32 type)
 	return type & MEM_ALLOC;
 }
 
+int bpf_vma_build_id_parse(struct vm_area_struct *vma,
+			   unsigned char *build_id,
+			   size_t build_id__sz);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..7340de74531a 100644
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
+BTF_ID_FLAGS(func, bpf_vma_build_id_parse, KF_TRUSTED_ARGS)
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

