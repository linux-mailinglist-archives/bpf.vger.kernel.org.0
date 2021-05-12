Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7D37EF22
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhELW7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344752AbhELVnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:43:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC93C08C5C8
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b15so7065873plh.10
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rl1VWBzXB+15Pp440B/cfDUrdLe/crrxrjcWGDKIlqY=;
        b=Q5d9+c68AlxxUlg5msDZ64vYZAqcLz2S7rRsArgAfCOKvnqwSXnkJ0x0YppwL25ehr
         px749DB2j/ulHgYrH+y6r8qvIAeo/ZuymEnWAd81OYMyFbSUL2OMqJVp92ZpJpI0QBl1
         J3D/WmzYpi3/86MkEqKkJyh7p6uTFHESMi6qPAQYCmjVZ7LjjGZJddwbyojz0FVXIifK
         UiuRUbbwI4cFgo++x7734YxFPiddbsMdkKnoLoTm2t0Bq48NqbELlQgguxoVunJfZPcW
         6+yrshYbU3seAhlfLc3iRRvd5rXVjvrCHwvxHgITw5++Gy4b1Rpdwx0bTmdfjeyAJ+25
         6+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rl1VWBzXB+15Pp440B/cfDUrdLe/crrxrjcWGDKIlqY=;
        b=R8Dg7aMlfYKFxfzuaGUdul/YVM42WoqYOk87Tjl8AeXFzQgIPlYTx4XDf7q+eWeAfr
         WFppNVWymsnseXDGJ7zeyCprq4J1FASITHfpE+6v84eQqbECgK7uiBulPwXB6WHsPWb/
         otbSct5uD1vuHwQCN3LQhEsBFLyhXAyjTvoY6ICiUzG6+U/VKGz/7D6p++8Vwc6MlR/f
         t6zg4BWzDSYVD7qIiRJjduyMBUX+1DyKYT6LlSNKEl0k2NrwFEmlyKKOYv0rACLBnmOY
         Nf8e3Z3SKlEOCPKdy/iNCKhUBmHEVKktCGRP0v06a9mtSUYJDkO0SDfiKsse6SJHHiMF
         Xg1g==
X-Gm-Message-State: AOAM533R8fU5Loii4fpQumjXBggXPiNL8vvt4AzU1tRszWBsZXBj4BKx
        7kLZK12Yf+eCVurFuSit4pg=
X-Google-Smtp-Source: ABdhPJzrzt3b06Yh1pnjB+2Fww2ABAJ3yrXpBGq8Pq5P4OsJxZ97J9VqgICJphDIbQDbykzr1CLpEw==
X-Received: by 2002:a17:902:cecb:b029:ee:afd7:e58d with SMTP id d11-20020a170902cecbb02900eeafd7e58dmr38084983plg.42.1620855193686;
        Wed, 12 May 2021 14:33:13 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:13 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 07/21] selftests/bpf: Test for btf_load command.
Date:   Wed, 12 May 2021 14:32:42 -0700
Message-Id: <20210512213256.31203-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
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

