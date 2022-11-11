Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073D0625D1E
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiKKOeF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 09:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiKKOd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 09:33:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93B205C1
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 06:33:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103E661FE9
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 14:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96C5C433D6;
        Fri, 11 Nov 2022 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668177237;
        bh=1ShwRnu7DFPhtABPiVoOVmotOay7x7v18MKxu/nkfYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEfgX9aeXdSS00aph4ITfzPTBNa8yOd8aNHaKgOifBAiSso/MuytMvWlqKLXuCntI
         5FpEoWVggNeDJC4p3Y8kyEguk08taEpUq9NX5KFU/XEb08dq8UaDfBMAFYZ/LJVYfY
         TGP4tJCnyosJ7JRNLzFyHKo15xiyLIYOICXkK3y/q5KAwB/qivkKTSuJ8qnVRQcG/8
         6J3wVGaQVlXbZcU6gbFVmBzgmb7RibSYsOBIZyGGVxMvGvImjuZpU5fSQloueTqoL3
         nBBj1d/8ZQ/KqdCWliSFQazvHt9s3bFa0r9Z/eVb2+1MMtICrRF/9Gzpe87xzsEqsG
         KN5ED34Q8bEHA==
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
Subject: [PATCHv2 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function and kfunc
Date:   Fri, 11 Nov 2022 15:33:40 +0100
Message-Id: <20221111143341.508022-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111143341.508022-1-jolsa@kernel.org>
References: <20221111143341.508022-1-jolsa@kernel.org>
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
 include/linux/bpf.h  |  5 +++++
 kernel/bpf/helpers.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..5e7c4c50da8e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2779,4 +2779,9 @@ struct bpf_key {
 	bool has_ref;
 };
 #endif /* CONFIG_KEYS */
+
+extern int bpf_vma_build_id_parse(struct vm_area_struct *vma,
+				  unsigned char *build_id,
+				  size_t build_id__sz);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 283f55bbeb70..af7a30dafff3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -19,6 +19,7 @@
 #include <linux/proc_ns.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
+#include <linux/buildid.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1706,10 +1707,25 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
 
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
 BTF_SET8_START(tracing_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
+BTF_ID_FLAGS(func, bpf_vma_build_id_parse)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
-- 
2.38.1

