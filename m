Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45C8620375
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiKGXLb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiKGXLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:30 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220521255
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:28 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so16245888pjc.3
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLVRV+t4+FZTDBLmAANvc6K1pqY5UOLPredtWxM9pUc=;
        b=WtjBh2ZkMYz0Y4crvDPekLsubj3rnxEKSu5nkzRsC9kZLEbSel0zJR8ADRrOioAP3m
         JFuEd9BFnwvy2Y8mHhNFK3AfcqD94/fsgn8zeJh0lmyp13QiVzciTkMnO/SZeOZjE6Tf
         eWtIuMkjx/jgti5T8uOdXzXiT6EFlO23epQpAULnSY29zjsLxBwukpN5Tx8CH1YsEbIC
         YjcWrLJ8gegyZQuobVVuiUmuZ/i1LzJfErJQOK8XO7E+S2JDEYq4LOLPDcgWFjw5EoRl
         HqSu+vLcz1p0Ap3sKmTdiHl3lAAyGkhDkxaS/kAU4+Xv7nbVzTmEgz4tweZH0zVKPyXs
         qjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLVRV+t4+FZTDBLmAANvc6K1pqY5UOLPredtWxM9pUc=;
        b=KmAirjMtyg7hFqY7kZDFRA4Xswrzk6rJH7Ey/tr+qOi6oG5HkGj0tYGA5tvenWCjy/
         izP5cBOehPV+Ad2HfrrkgdVIiEQTOeTuf9g3TmeXO6YUxAzNNAMVmSrsmvsnDg9POkyz
         31Kn1oQI0e1Wm/fxPOXoZPydH2H/hXZtt9qMqmM8um6HaDrzqYjPOgzdc5kP3lCLxLfw
         Uv+kJd6G1OgNVdTK+FJk+f64HJRuAcmnv9TL4pYuJ4Rzq8XIVloYW4nw41KAgPbSTwO2
         NThW3OcP8Ie3knpWh/dI1rIskUHGAnH/N75y78j69uzMafc57y6no/c44Y/ooGwXOSYc
         hkww==
X-Gm-Message-State: ACrzQf0ZAHX//yfu00R0F6+c0tVEiRNm1ZeE2qceWsy0tI8h4V5GcxCp
        saWx51lyzkWay+CtW6+XhJeVwLXm5ShU2g==
X-Google-Smtp-Source: AMsMyM5G/DTB58qSOzcXCsQSd3jucCqFyfkEqQKtEswCwvg2sRja2jpsG+9J5UHSoqJ0Q26VKqt/Uw==
X-Received: by 2002:a17:90a:ad08:b0:212:d5f1:e0c6 with SMTP id r8-20020a17090aad0800b00212d5f1e0c6mr69512916pjq.228.1667862687648;
        Mon, 07 Nov 2022 15:11:27 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001885041d7b8sm5471215pls.293.2022.11.07.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:27 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 25/25] selftests/bpf: Add BTF sanity tests
Date:   Tue,  8 Nov 2022 04:39:50 +0530
Message-Id: <20221107230950.7117-26-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10933; i=memxor@gmail.com; h=from:subject; bh=kzEurx3V6kdGvcxcROAKf2a3IYFN9EHUhuRar6z8164=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+4iLkGwa9CKLBhnNZ44dDjeB0SYikZnv4e52zl 4M+bJaOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPuAAKCRBM4MiGSL8RymQjD/ 9WnGsx9IKSHz+XfLYKGQWd2MYvCn1vnWlPyK8JJlaWJP7zDy2FICxjvLBc5sWOiuX1RoUlo8myclYv xClIi7uEhL5wRgaNx15th8J4S//CKoDE8ChINLzjzEt/i5EpFN9Olnhe8r3vxh1HUSXH7bp7iMgVkE XXcT8sLKu6Jd5eS/QLU0TFHo8jiasUZlqApo0rBaN1gUAFAC7etPjOTRUGeq/HE/UcHvq5g29bgnl8 sEp4YDcTE/NghKu9xr/uMWB6Ho+c0z03t3RvjX7xvO8lrkwiOLZ9tUWOpVCDLFDWQOZYEnzWlReqhU JuPrUGlwrVv2M1vjgU1eRhUX8gAYrwvQv6Nr73bT9i2/NH8EgW6kdlHNQ3bii28Zuk0pmadBIE+9v9 AIaApFoQ5ru+x9v5a3j0oDSVbUEEdwIP/7FKxchzw6EXtQQkktzNrrfp3RlSMl0cBrqWCK5m1L7Rlb 9YURLUrEfeV8vTB9N5cuPez2PUx3UJMmsDpH+1WehHkw5DEdC2NzdY/Mj/V2S2pppxWPr74iq6xEwL ljyr3pRyOFnfp9sya9GoxyohywlLwzFv5abyfyoEj76dMTzpfwFEkn/Zkc8OaR4IxzOsWxmTHbdok6 0M+thYaaV40Ln9P8v/eCoVYo1k+/ZMdnyki4fHEKdMulPfujUFLrjXDTdVBg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Preparing the metadata for bpf_list_head involves a complicated parsing
step and type resolution for the contained value. Ensure that corner
cases are tested against and invalid specifications in source are duly
rejected. Also include tests for incorrect ownership relationships in
the BTF.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    | 271 ++++++++++++++++++
 1 file changed, 271 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 669ef4bb9b87..40070e2d22f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <bpf/btf.h>
+#include <test_btf.h>
+#include <linux/btf.h>
 #include <test_progs.h>
 #include <network_helpers.h>
 
@@ -233,6 +236,273 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	linked_list__destroy(skel);
 }
 
+/* struct bpf_spin_lock {
+ *   int foo;
+ * };
+ * struct bpf_list_head {
+ *   __u64 :64;
+ *   __u64 :64;
+ * } __attribute__((aligned(8)));
+ * struct bpf_list_node {
+ *   __u64 :64;
+ *   __u64 :64;
+ * } __attribute__((aligned(8)));
+ */
+static const char btf_str_sec[] = "\0bpf_spin_lock\0bpf_list_head\0bpf_list_node\0foo\0bar\0baz"
+				  "\0contains:foo:foo\0contains:bar:bar\0contains:baz:baz\0bam"
+				  "\0contains:bam:bam";
+
+#define INIT_BTF_TILL_4							\
+	/* int */							\
+	BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */	\
+	/* struct bpf_spin_lock */                      /* [2] */	\
+	BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),	\
+	BTF_MEMBER_ENC(43, 1, 0),					\
+	/* struct bpf_list_head */                      /* [3] */	\
+	BTF_TYPE_ENC(15, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 0), 16),	\
+	/* struct bpf_list_node */                      /* [4] */	\
+	BTF_TYPE_ENC(29, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 0), 16),
+
+static void check_btf(u32 *types, u32 types_len, int error)
+{
+	LIBBPF_OPTS(bpf_btf_load_opts, opts,
+		    .log_buf = log_buf,
+		    .log_size = sizeof(log_buf),
+	);
+	struct btf_header hdr = {
+		.magic = BTF_MAGIC,
+		.version = BTF_VERSION,
+		.hdr_len = sizeof(struct btf_header),
+		.type_len = types_len,
+		.str_off = types_len,
+		.str_len = sizeof(btf_str_sec),
+	};
+	void *ptr, *raw_btf;
+	int fd, ret;
+
+	raw_btf = malloc(sizeof(hdr) + hdr.type_len + hdr.str_len);
+	if (!ASSERT_OK_PTR(raw_btf, "malloc(raw_btf)"))
+		return;
+
+	ptr = raw_btf;
+	memcpy(ptr, &hdr, sizeof(hdr));
+	ptr += sizeof(hdr);
+	memcpy(ptr, types, hdr.type_len);
+	ptr += hdr.type_len;
+	memcpy(ptr, btf_str_sec, hdr.str_len);
+	ptr += hdr.str_len;
+
+	fd = bpf_btf_load(raw_btf, ptr - raw_btf, &opts);
+	ret = fd < 0 ? -errno : 0;
+	if (fd >= 0)
+		close(fd);
+	if (error)
+		ASSERT_LT(fd, 0, "bpf_btf_load");
+	else
+		ASSERT_GE(fd, 0, "bpf_btf_load");
+	if (!ASSERT_EQ(ret, error, "-errno == error"))
+		printf("BTF Log:\n%s\n", log_buf);
+	free(raw_btf);
+	return;
+}
+
+#define SPIN_LOCK 2
+#define LIST_HEAD 3
+#define LIST_NODE 4
+#define FOO 43
+#define BAR 47
+#define BAZ 51
+#define BAM 106
+#define CONT_FOO_FOO 55
+#define CONT_BAR_BAR 72
+#define CONT_BAZ_BAZ 89
+#define CONT_BAM_BAM 110
+
+static void test_btf(void)
+{
+	if (test__start_subtest("btf: too many locks")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 24), /* [5] */
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 0),
+			BTF_MEMBER_ENC(FOO, SPIN_LOCK, 32),
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 64),
+		};
+		check_btf(types, sizeof(types), -E2BIG);
+	}
+	if (test__start_subtest("btf: missing lock")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 16), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_DECL_TAG_ENC(CONT_BAZ_BAZ, 5, 0),
+			BTF_TYPE_ENC(BAZ, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 16),
+			BTF_MEMBER_ENC(BAZ, LIST_NODE, 0),
+		};
+		check_btf(types, sizeof(types), -EINVAL);
+	}
+	if (test__start_subtest("btf: bad offset")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(FOO, LIST_NODE, 0),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 0),
+			BTF_DECL_TAG_ENC(CONT_FOO_FOO, 5, 0),
+		};
+		check_btf(types, sizeof(types), -EFAULT);
+	}
+	if (test__start_subtest("btf: missing contains:")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 24), /* [5] */
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 0),
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 64),
+		};
+		check_btf(types, sizeof(types), -EINVAL);
+	}
+	if (test__start_subtest("btf: missing struct")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 24), /* [5] */
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 0),
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 64),
+			BTF_DECL_TAG_ENC(CONT_BAR_BAR, 5, 1),
+		};
+		check_btf(types, sizeof(types), -ENOENT);
+	}
+	if (test__start_subtest("btf: missing node")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 24), /* [5] */
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 0),
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 64),
+			BTF_DECL_TAG_ENC(CONT_FOO_FOO, 5, 1),
+		};
+		check_btf(types, sizeof(types), -ENOENT);
+	}
+	if (test__start_subtest("btf: node incorrect type")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 20), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAR, SPIN_LOCK, 128),
+			BTF_DECL_TAG_ENC(CONT_BAZ_BAZ, 5, 0),
+			BTF_TYPE_ENC(BAZ, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 0),
+		};
+		check_btf(types, sizeof(types), -EINVAL);
+	}
+	if (test__start_subtest("btf: multiple bpf_list_node with name foo")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 52), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(FOO, LIST_NODE, 128),
+			BTF_MEMBER_ENC(FOO, LIST_NODE, 256),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 384),
+			BTF_DECL_TAG_ENC(CONT_FOO_FOO, 5, 0),
+		};
+		check_btf(types, sizeof(types), -EINVAL);
+	}
+	if (test__start_subtest("btf: owning | owned AA cycle")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(FOO, LIST_NODE, 128),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_FOO_FOO, 5, 0),
+		};
+		check_btf(types, sizeof(types), -ELOOP);
+	}
+	if (test__start_subtest("btf: owning | owned ABA cycle")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(FOO, LIST_NODE, 128),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_BAR_BAR, 5, 0),			    /* [6] */
+			BTF_TYPE_ENC(BAR, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [7] */
+			BTF_MEMBER_ENC(FOO, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAR, LIST_NODE, 128),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_FOO_FOO, 7, 0),
+		};
+		check_btf(types, sizeof(types), -ELOOP);
+	}
+	if (test__start_subtest("btf: owning -> owned")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 20), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAR, SPIN_LOCK, 128),
+			BTF_DECL_TAG_ENC(CONT_BAZ_BAZ, 5, 0),
+			BTF_TYPE_ENC(BAZ, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 16),
+			BTF_MEMBER_ENC(BAZ, LIST_NODE, 0),
+		};
+		check_btf(types, sizeof(types), 0);
+	}
+	if (test__start_subtest("btf: owning -> owning | owned -> owned")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 20), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 128),
+			BTF_DECL_TAG_ENC(CONT_BAR_BAR, 5, 0),			    /* [6] */
+			BTF_TYPE_ENC(BAR, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [7] */
+			BTF_MEMBER_ENC(FOO, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAR, LIST_NODE, 128),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_BAZ_BAZ, 7, 0),
+			BTF_TYPE_ENC(BAZ, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 16),
+			BTF_MEMBER_ENC(BAZ, LIST_NODE, 0),
+		};
+		check_btf(types, sizeof(types), 0);
+	}
+	if (test__start_subtest("btf: owning | owned -> owning | owned -> owned")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(FOO, LIST_NODE, 128),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_BAR_BAR, 5, 0),			    /* [6] */
+			BTF_TYPE_ENC(BAR, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [7] */
+			BTF_MEMBER_ENC(FOO, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAR, LIST_NODE, 128),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_BAZ_BAZ, 7, 0),
+			BTF_TYPE_ENC(BAZ, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 16),
+			BTF_MEMBER_ENC(BAZ, LIST_NODE, 0),
+		};
+		check_btf(types, sizeof(types), -ELOOP);
+	}
+	if (test__start_subtest("btf: owning -> owning | owned -> owning | owned -> owned")) {
+		u32 types[] = {
+			INIT_BTF_TILL_4
+			BTF_TYPE_ENC(FOO, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 20), /* [5] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 128),
+			BTF_DECL_TAG_ENC(CONT_BAR_BAR, 5, 0),			    /* [6] */
+			BTF_TYPE_ENC(BAR, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [7] */
+			BTF_MEMBER_ENC(FOO, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAR, LIST_NODE, 128),
+			BTF_MEMBER_ENC(BAZ, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_BAZ_BAZ, 7, 0),
+			BTF_TYPE_ENC(BAZ, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 3), 36), /* [9] */
+			BTF_MEMBER_ENC(BAR, LIST_HEAD, 0),
+			BTF_MEMBER_ENC(BAZ, LIST_NODE, 128),
+			BTF_MEMBER_ENC(FOO, SPIN_LOCK, 256),
+			BTF_DECL_TAG_ENC(CONT_BAM_BAM, 9, 0),
+			BTF_TYPE_ENC(BAM, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 16),
+			BTF_MEMBER_ENC(BAM, LIST_NODE, 0),
+		};
+		check_btf(types, sizeof(types), -ELOOP);
+	}
+}
+
 void test_linked_list(void)
 {
 	int i;
@@ -243,6 +513,7 @@ void test_linked_list(void)
 		test_linked_list_fail_prog(linked_list_fail_tests[i].prog_name,
 					   linked_list_fail_tests[i].err_msg);
 	}
+	test_btf();
 	test_linked_list_success(PUSH_POP, false);
 	test_linked_list_success(PUSH_POP, true);
 	test_linked_list_success(PUSH_POP_MULT, false);
-- 
2.38.1

