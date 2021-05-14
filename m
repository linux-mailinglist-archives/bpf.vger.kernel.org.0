Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC0380130
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhENAhv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhENAhv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E19C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h7so15266746plt.1
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rl1VWBzXB+15Pp440B/cfDUrdLe/crrxrjcWGDKIlqY=;
        b=YzVK5Vomw7iwq0y2EaXf/QZQY1A/Mg1OgX3eQAEQnB3NAylRIUBesCBjOOthRbAgL4
         NpMfIawghtuwqxRSI6bXi32fLIYmsbCH3kIfpdmEMEPMn9vJCChvTOudGiSorsTReCd+
         +VjJGAv2MICvBprR4EDAKcfjhF53XeSYgEoHEH8w2T7e8/k+q3mIcsbl6aRiYIL1fjIy
         Ww9nTUyVmiy+IVkakkJMC6BrlwkXy6mu/+o++YVWFNLZIKT1NdUAKeBJjsxuyAEBTZAj
         KeWO7SEaEWke5QOjUipzFg0PL3/9cf2aG+P3ygBZi8hK2a3GyQcl62dNNkhxYS1NoHWP
         Wvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rl1VWBzXB+15Pp440B/cfDUrdLe/crrxrjcWGDKIlqY=;
        b=YyT2tPwfzm2E8kwVKKNWjLRDLkgybJ+DBHUiCaddszoN11siQ/dnmlLJKowfgspbcX
         n+E6/KUv4qK+mAMxFOGJJM+7frxQ7Wk/b+BSn6pwjPx21fxPUgepW5V/PSARR/aQUvCq
         EMTj6pgBGxslEGZax1semTMZfQGz760NxhTqUHu072gD6AgdSuSayxttDwchlDfrbp30
         tWm8iGQUqcKKbswpImTkHwH92TV67JgyOqa14yHJnz0R/8M5EDfq284SZlQ0QnadMsIy
         7HIClAJONq6x8aK9lPNXclYwz090pX0kkemKnAIkv8s7j2IZkCjCPSpwR/IRps1touNv
         pVTg==
X-Gm-Message-State: AOAM533v77lX6/xIOK8Slwxm+d6tkAfiN1vJ+RjDeg075I5NPygKGMTs
        57LzXb6r53gWWJr8LKivHms=
X-Google-Smtp-Source: ABdhPJwKhr2m4RhNszl0pfz7AAlWc+/XaGRa7dIFQ/sLqr6vIFTwRocN3trWow2cNmWgLt2ZQSeawg==
X-Received: by 2002:a17:902:b683:b029:ee:f0e3:7a50 with SMTP id c3-20020a170902b683b02900eef0e37a50mr43019395pls.7.1620952600566;
        Thu, 13 May 2021 17:36:40 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:40 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 07/21] selftests/bpf: Test for btf_load command.
Date:   Thu, 13 May 2021 17:36:09 -0700
Message-Id: <20210514003623.28033-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Improve selftest to check that btf_load is working from bpf program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/syscall.c        |  3 ++
 tools/testing/selftests/bpf/progs/syscall.c   | 50 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/testing/selftests/bpf/prog_tests/syscall.c
index 1badd37148a1..81e997a69f7a 100644
--- a/tools/testing/selftests/bpf/prog_tests/syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
@@ -9,6 +9,7 @@ struct args {
 	int max_entries;
 	int map_fd;
 	int prog_fd;
+	int btf_fd;
 };
 
 void test_syscall(void)
@@ -49,4 +50,6 @@ void test_syscall(void)
 		close(ctx.prog_fd);
 	if (ctx.map_fd > 0)
 		close(ctx.map_fd);
+	if (ctx.btf_fd > 0)
+		close(ctx.btf_fd);
 }
diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 865b5269ecbb..e550f728962d 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <../../../tools/include/linux/filter.h>
+#include <linux/btf.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -14,8 +15,48 @@ struct args {
 	int max_entries;
 	int map_fd;
 	int prog_fd;
+	int btf_fd;
 };
 
+#define BTF_INFO_ENC(kind, kind_flag, vlen) \
+	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
+#define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
+#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
+	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
+#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
+	BTF_INT_ENC(encoding, bits_offset, bits)
+
+static int btf_load(void)
+{
+	struct btf_blob {
+		struct btf_header btf_hdr;
+		__u32 types[8];
+		__u32 str;
+	} raw_btf = {
+		.btf_hdr = {
+			.magic = BTF_MAGIC,
+			.version = BTF_VERSION,
+			.hdr_len = sizeof(struct btf_header),
+			.type_len = sizeof(__u32) * 8,
+			.str_off = sizeof(__u32) * 8,
+			.str_len = sizeof(__u32),
+		},
+		.types = {
+			/* long */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /* [1] */
+			/* unsigned long */
+			BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),  /* [2] */
+		},
+	};
+	static union bpf_attr btf_load_attr = {
+		.btf_size = sizeof(raw_btf),
+	};
+
+	btf_load_attr.btf = (long)&raw_btf;
+	return bpf_sys_bpf(BPF_BTF_LOAD, &btf_load_attr, sizeof(btf_load_attr));
+}
+
 SEC("syscall")
 int bpf_prog(struct args *ctx)
 {
@@ -33,6 +74,8 @@ int bpf_prog(struct args *ctx)
 		.map_type = BPF_MAP_TYPE_HASH,
 		.key_size = 8,
 		.value_size = 8,
+		.btf_key_type_id = 1,
+		.btf_value_type_id = 2,
 	};
 	static union bpf_attr map_update_attr = { .map_fd = 1, };
 	static __u64 key = 12;
@@ -43,7 +86,14 @@ int bpf_prog(struct args *ctx)
 	};
 	int ret;
 
+	ret = btf_load();
+	if (ret <= 0)
+		return ret;
+
+	ctx->btf_fd = ret;
 	map_create_attr.max_entries = ctx->max_entries;
+	map_create_attr.btf_fd = ret;
+
 	prog_load_attr.license = (long) license;
 	prog_load_attr.insns = (long) insns;
 	prog_load_attr.log_buf = ctx->log_buf;
-- 
2.30.2

