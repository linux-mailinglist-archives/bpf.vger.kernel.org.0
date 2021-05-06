Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E083374E13
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhEFDqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhEFDqQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC9C06138A
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s20so2677092plr.13
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7aJAToK/NwcLONPHrtxlk3jkIiqRlSPfWOsB4QDB7vg=;
        b=jIZ6GoRtllx8L0jXXepVxgrUU/LSFCb9ZtVrRaa1WGPgRyHRcF568Rp6UEoTQgi+b0
         aHWgMrhXn+ODwgQrg8VmKDGDEUAOXRagxbfHM/eF4izZGkU5tbwCUDuS6/DfUyVxhXK4
         /6SZZd1QYsAFfhLQx7RJhWbCc89sT19/gvbdpDBpRyGpVP/RyV6mJkUysah4B3JxxHu4
         tm0v0VgS0a2iReLspbIjh+7dfM2z2tl4ZJHCSHuf9iLVTtz0VhwiQebdMwaA/SlNpukG
         KGV/p4nEfJSON4UKQNT7NOiVwjVTnIVUfYT5roaANwvWTkkKnSOwz12DXs3gRT1+6wtA
         ElGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7aJAToK/NwcLONPHrtxlk3jkIiqRlSPfWOsB4QDB7vg=;
        b=CbprFaFDmcvstEsbkzC9jTSALgcNdRu1QLpWJ2TW9fGeMmfmIIUe7JYLLsx9KaPD/c
         O9i4bOil0b5eb2YbKgXFmAW8QIDO7jMOPdEDvfE+yzrnHW95kffqiqMZCWuFUxyhhwmk
         vWBsk6kYQRRqpFbqbjukxl7TfVW+yvBTHRpe7Xnm3PpsS6K52GuI5rY/xxGtJ1ekzySu
         vG+2wmjTpvQXR88isCvEFWxv93JEfyRBONY3dde8GoCR4D48ICOCT3afx5cKbO7hK/Eo
         OTR5ik6ibCTN/h+woo6x298BsSmKQpfIEoClyx4JBoR4uC789C2uwBhEOZ3ABgv+JXwl
         GzHA==
X-Gm-Message-State: AOAM530U6+pIH72B2Ah8in5s8klCA5F4pDTbk27e3OjEXA7ownoBqjR/
        t1MGBH73jd3TwtNv7LGHub8=
X-Google-Smtp-Source: ABdhPJw5gy7dqWbE+LsvR8OZ6sKFzN9r3vpNOs98leoy1PBxsW4uo7PSTz9ZrEdwvFo6GzNOONkwNg==
X-Received: by 2002:a17:902:109:b029:ec:9f64:c53d with SMTP id 9-20020a1709020109b02900ec9f64c53dmr2351351plb.83.1620272717411;
        Wed, 05 May 2021 20:45:17 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:16 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 07/17] selftests/bpf: Test for btf_load command.
Date:   Wed,  5 May 2021 20:44:55 -0700
Message-Id: <20210506034505.25979-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
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

