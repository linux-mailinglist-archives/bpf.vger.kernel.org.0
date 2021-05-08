Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15303376F36
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhEHDtz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEHDty (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:49:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DDDC061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:48:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so6653270pjb.4
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7aJAToK/NwcLONPHrtxlk3jkIiqRlSPfWOsB4QDB7vg=;
        b=CqDFNJfqZPmPPNJMjjIVFvWjx/8cpqWHYM3qFeht7rq0gpPFHX7m4ac1goBeYhUndP
         i/8PFTmNrNkjlCbfpG8NKqOYwzN1HNQGhvdjLhew//EUrjmT8DSiXDY5uKYjxT3m8WI/
         XgzAOhxTSZX+Co7KUNSW7DF/U3uMljZmFPZHbzs/B6GRKX1F6ucbsI4SwXarWgnhDaJb
         CrxKqDSQeuactBg7w29Ji8f8xpXgVjA+Qttnge+Z4Hw+xdbEWsAbU8DYyL71vTXHAJ03
         6Y1hqC70sF7aUoZBwtYkTrMADg/5tloovrtZwfN+EYfhgpnZqpjfPOVu1kUXKJ+RGw8M
         0bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7aJAToK/NwcLONPHrtxlk3jkIiqRlSPfWOsB4QDB7vg=;
        b=IQzXeJTdvTpHndicRJnBXnIs3WO+9T1a6UWiv2fbNDlLoM5bw9YkOKvK6PH2VvE0xW
         RUtsaiFQKp/9Vd2pXVFUQpYYA2DpQ/Ey+tl32bG+2uoJQLC3GBRK8RNYsh3QOztd8msB
         WgJuSSWhOK9KYpll09//yz97YxFqvlSjnnGkyZ3IvZSferX983Tt4Rm+ndexyYV7S7EQ
         GkEIuyosSNh1IN2VjFVEZ5msD5aIel25vbhInsO9XyDClbeUVUwZ96g0ZUt+5kWljxvG
         G3PGSQpBq0H8p/E+WTFYRIXoNSfwV2fwfkoAawXq9RZ1ox0Wi0srDWQhLFHGTbfNuW6j
         WiFg==
X-Gm-Message-State: AOAM530EGPmER2CAh5/ONxd4iQ0p4a0ooMMr0NBhAmjjmoimZkEMZc5D
        6KEFwb3l5I9fp1KeRwDOneM=
X-Google-Smtp-Source: ABdhPJwFyPbooss4Dexevzf5Koq4AzWCZy+2/+//jTVLRnzMaztXmS0xEFuKscxR6rbKkEW5DMEqaA==
X-Received: by 2002:a17:903:2403:b029:ee:eaf1:848d with SMTP id e3-20020a1709032403b02900eeeaf1848dmr13206225plo.63.1620445733667;
        Fri, 07 May 2021 20:48:53 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.48.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:48:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 07/22] selftests/bpf: Test for btf_load command.
Date:   Fri,  7 May 2021 20:48:22 -0700
Message-Id: <20210508034837.64585-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Improve selftest to check that btf_load is working from bpf program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/syscall.c | 48 +++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 865b5269ecbb..4353b8d8fb7f 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <../../../tools/include/linux/filter.h>
+#include <linux/btf.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -16,6 +17,45 @@ struct args {
 	int prog_fd;
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
@@ -33,6 +73,8 @@ int bpf_prog(struct args *ctx)
 		.map_type = BPF_MAP_TYPE_HASH,
 		.key_size = 8,
 		.value_size = 8,
+		.btf_key_type_id = 1,
+		.btf_value_type_id = 2,
 	};
 	static union bpf_attr map_update_attr = { .map_fd = 1, };
 	static __u64 key = 12;
@@ -43,7 +85,13 @@ int bpf_prog(struct args *ctx)
 	};
 	int ret;
 
+	ret = btf_load();
+	if (ret < 0)
+		return ret;
+
 	map_create_attr.max_entries = ctx->max_entries;
+	map_create_attr.btf_fd = ret;
+
 	prog_load_attr.license = (long) license;
 	prog_load_attr.insns = (long) insns;
 	prog_load_attr.log_buf = ctx->log_buf;
-- 
2.30.2

