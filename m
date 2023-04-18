Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BBB6E56A2
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDRBlc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDRBlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BFF6A76
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:41:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c64-20020a254e43000000b00b92530ded91so3262310ybb.17
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782064; x=1684374064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGQ9sB/Rwqr1E4RbtpywhCeCd351RoNViaB6XX6OAcM=;
        b=7a7FthehtIU1LDZHaPCjM+OU4rQTnwIJO65M0avbzwBgquVMpBou6qbE9n76s23acW
         0ZLBEZD6ViB5CGK7UFFeuO58ubsaYIEMTp4GXx/KH8KrYV2koGO24wTVipTnAT5jPPv2
         vDoFrFqHAHBzZbYHVKyk17HtLm24Tprum8PLjWK078LB0eS6ATINZq6HTShyS6UJyTbI
         Pz0+UzgNTfLj4UnUR7Pl9WJGy4IzEKBoqH51/+5DCpzyuozlPN46l34XGNt300XMi2vv
         0zHLgyVCJ6YKv4vRZGoF3hq5Tl/PhsQ2JO+iP5xq437JP1RbmlU4dS+oNmu6RXuBXKdD
         Wvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782064; x=1684374064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGQ9sB/Rwqr1E4RbtpywhCeCd351RoNViaB6XX6OAcM=;
        b=GRHnBtEUZZqpVET+RpXZZ90lgHXbh+PtIzLjMxISS5rmr7Pfxee+uKNsI2OLV/npt/
         MYHMDYfrHyr19lDhbR0BSWdnA/UCjV3E2pVh/7FvhtEF8ymlns4hzrW4YLsaI1GP3P3N
         xfkTLEhd0l8UyoBsVVIRZ1KkpzYzoz/jD+i2jdRh8Ah9JJEpHqRGaJ+S//+S50QlvACb
         Vm+0s2Fq4If/JXTBlBHAIjlBN5vC6DNDBDEy/eKUm3FdNIlvLJ3mh06W3SfgCQU3zCjA
         2SwM8NXE+1MzllL3lJcG3Dni4N9kOxSniWDXoQJ5Bd+jbl7pYp2vOxhTlfmmU7UtC46B
         JYXA==
X-Gm-Message-State: AAQBX9dsuTHqr7ZO3zHdV0WdTPctLkS7NZW3gdbKpEvv6BnYY91uErm+
        Xv/T0IfASf300y2xEWs5xn8Ym+7Qd0k=
X-Google-Smtp-Source: AKy350bEg5Yq5yN301eh/701p5EkdiweIgQB8V883Xlr2DXOiBdY6xkRbjC+SVvzsfu/0C5Gu4BhRNTqFN8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:d10e:0:b0:b8f:3881:1638 with SMTP id
 i14-20020a25d10e000000b00b8f38811638mr8759594ybg.7.1681782064219; Mon, 17 Apr
 2023 18:41:04 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:06 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-7-drosen@google.com>
Subject: [RFC PATCH v3 06/37] fuse-bpf: Add data structures for fuse-bpf
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
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

These structures will be used to interact between the fuse bpf calls and
normal userspace calls

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/linux/bpf_fuse.h | 84 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/linux/bpf_fuse.h

diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
new file mode 100644
index 000000000000..ce8b1b347496
--- /dev/null
+++ b/include/linux/bpf_fuse.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2022 Google LLC.
+ */
+
+#ifndef _BPF_FUSE_H
+#define _BPF_FUSE_H
+
+#include <linux/types.h>
+#include <linux/fuse.h>
+
+struct fuse_buffer {
+	void *data;
+	unsigned size;
+	unsigned alloc_size;
+	unsigned max_size;
+	int flags;
+};
+
+/* These flags are used internally to track information about the fuse buffers.
+ * Fuse sets some of the flags in init. The helper functions sets others, depending on what
+ * was requested by the bpf program.
+ */
+// Flags set by FUSE
+#define BPF_FUSE_IMMUTABLE	(1 << 0) // Buffer may not be written to
+#define BPF_FUSE_VARIABLE_SIZE	(1 << 1) // Buffer length may be changed (growth requires alloc)
+#define BPF_FUSE_MUST_ALLOCATE	(1 << 2) // Buffer must be re allocated before allowing writes
+
+// Flags set by helper function
+#define BPF_FUSE_MODIFIED	(1 << 3) // The helper function allowed writes to the buffer
+#define BPF_FUSE_ALLOCATED	(1 << 4) // The helper function allocated the buffer
+
+/*
+ * BPF Fuse Args
+ *
+ * Used to translate between bpf program parameters and their userspace equivalent calls.
+ * Variable sized arguments are held in fuse_buffers. To access these, bpf programs must
+ * use kfuncs to access them as dynptrs.
+ *
+ */
+
+#define FUSE_MAX_ARGS_IN 3
+#define FUSE_MAX_ARGS_OUT 2
+
+struct bpf_fuse_arg {
+	union {
+		void *value;
+		struct fuse_buffer *buffer;
+	};
+	unsigned size;
+	bool is_buffer;
+};
+
+struct bpf_fuse_meta_info {
+	uint64_t nodeid;
+	uint32_t opcode;
+	uint32_t error_in;
+};
+
+struct bpf_fuse_args {
+	struct bpf_fuse_meta_info info;
+	uint32_t in_numargs;
+	uint32_t out_numargs;
+	uint32_t flags;
+	struct bpf_fuse_arg in_args[FUSE_MAX_ARGS_IN];
+	struct bpf_fuse_arg out_args[FUSE_MAX_ARGS_OUT];
+};
+
+// Mirrors for struct fuse_args flags
+#define FUSE_BPF_FORCE (1 << 0)
+#define FUSE_BPF_OUT_ARGVAR (1 << 6)
+#define FUSE_BPF_IS_LOOKUP (1 << 11)
+
+static inline void *bpf_fuse_arg_value(const struct bpf_fuse_arg *arg)
+{
+	return arg->is_buffer ? arg->buffer : arg->value;
+}
+
+static inline unsigned bpf_fuse_arg_size(const struct bpf_fuse_arg *arg)
+{
+	return arg->is_buffer ? arg->buffer->size : arg->size;
+}
+
+#endif /* _BPF_FUSE_H */
-- 
2.40.0.634.g4ca3ef3211-goog

