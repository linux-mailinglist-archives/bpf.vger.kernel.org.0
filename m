Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375A8522077
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbiEJQD0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347033AbiEJQBK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 12:01:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7023BD3
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j6so33826190ejc.13
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPVYQ3vtRrf3UWocisYsWC/3ScnFAVbz+QyvODpDbs8=;
        b=m1+1W6DxcHYn5qYrodbNGVoKA2GJjKh1blVVuestGV9rS4q40ZLW59YnEbRZbckKVe
         WPEBbBG98jkhExqPRMVXH8aeA2AJTb8/TuBgyXvqAgTPfZIyswYjqKdIEARo/uTnI9Yh
         LSf10WXslCP9YwmCIco1qILg7+mgCiXEIVlbOzUj6Zd8JAzijU+V3S7/YCB1H90/dP2m
         uTbFDv9tFmRidwiq6F9M1zylxRoLWie2Tbd9IdZPC12cTs6AtkE+8ZkmjTLBcQbcGDWx
         ZPPWxbGrxveIDyUzIIslT+kYd2edoAJFq0gE2yzTu92XJCh4DRSsxTbQFT7kwsLgIFtM
         6S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPVYQ3vtRrf3UWocisYsWC/3ScnFAVbz+QyvODpDbs8=;
        b=GxS5GD9oY+NKV+yP/Rk+H2ysUwDnjtyg48q39XEPLp07gFeJ1Q6DgZos8QffFqnqQO
         lxwvy0Wd2PMh0ckF2G9s3A571NWrZTVz3u99hdFml2V1K6nfZvy21TuqrEJ1lDVVDxin
         w2JriD+nY/bUALAkDKgfSzZuo5/1wfraoDFIVRaan2JpgWlmL9Sd/EHueO4S7G0CPpaY
         MVtU1B6ul95kLdKJTYv/hx5oy5ISepn2Vzx+Wt8epfNYTsniqTOzbGEu/JWTYjLPxvSw
         Q/WYgcOu5FKf75TekSNJGj6hhQHVDRlcrrH5djdKWEQEqdvINcxtT311lwBuTbC3hNDl
         M/ow==
X-Gm-Message-State: AOAM531T2aaGq4b9m64kcM/+draK1QA9SiLdOPU+CNpUeaBcsvjXlcAy
        sRDQQU+DaV2fzy7M1ICWeWQw0mT0/rZD6Q==
X-Google-Smtp-Source: ABdhPJxgGCF9MMPjIMRbFVs2408I2u2PD4cYR+0MDBPOY1y8bx09jLCw2BBsHzeUdPWZ8DyfAxwX4A==
X-Received: by 2002:a17:907:e92:b0:6fa:8125:c92a with SMTP id ho18-20020a1709070e9200b006fa8125c92amr8832285ejc.45.1652198030120;
        Tue, 10 May 2022 08:53:50 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-011-044.094.222.pools.vodafone-ip.de. [94.222.11.44])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b0042617ba63b0sm7806088eds.58.2022.05.10.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:53:49 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add bpf link iter test
Date:   Tue, 10 May 2022 17:52:33 +0200
Message-Id: <20220510155233.9815-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510155233.9815-1-9erthalion6@gmail.com>
References: <20220510155233.9815-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a simple test for bpf link iterator

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v2:
    - Properly include new test into the test runner
    - Fix test condition and transform it into the ASSERT
    - Handle bpf_iter__bpf_link and older vmlinux.h
    - Verify link pointer in the test prog
    - Correct copyright

 .../selftests/bpf/prog_tests/bpf_iter.c       | 16 ++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |  7 +++++++
 .../selftests/bpf/progs/bpf_iter_bpf_link.c   | 21 +++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 48289c886058..7ff5fa93d056 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -26,6 +26,7 @@
 #include "bpf_iter_bpf_sk_storage_map.skel.h"
 #include "bpf_iter_test_kern5.skel.h"
 #include "bpf_iter_test_kern6.skel.h"
+#include "bpf_iter_bpf_link.skel.h"
 
 static int duration;
 
@@ -1106,6 +1107,19 @@ static void test_buf_neg_offset(void)
 		bpf_iter_test_kern6__destroy(skel);
 }
 
+static void test_link_iter(void)
+{
+	struct bpf_iter_bpf_link *skel;
+
+	skel = bpf_iter_bpf_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_link__open_and_load"))
+		return;
+
+	do_dummy_read(skel->progs.dump_bpf_link);
+
+	bpf_iter_bpf_link__destroy(skel);
+}
+
 #define CMP_BUFFER_SIZE 1024
 static char task_vma_output[CMP_BUFFER_SIZE];
 static char proc_maps_output[CMP_BUFFER_SIZE];
@@ -1251,4 +1265,6 @@ void test_bpf_iter(void)
 		test_rdonly_buf_out_of_bound();
 	if (test__start_subtest("buf-neg-offset"))
 		test_buf_neg_offset();
+	if (test__start_subtest("link-iter"))
+		test_link_iter();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index 8cfaeba1ddbf..97ec8bc76ae6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -16,6 +16,7 @@
 #define bpf_iter__bpf_map_elem bpf_iter__bpf_map_elem___not_used
 #define bpf_iter__bpf_sk_storage_map bpf_iter__bpf_sk_storage_map___not_used
 #define bpf_iter__sockmap bpf_iter__sockmap___not_used
+#define bpf_iter__bpf_link bpf_iter__bpf_link___not_used
 #define btf_ptr btf_ptr___not_used
 #define BTF_F_COMPACT BTF_F_COMPACT___not_used
 #define BTF_F_NONAME BTF_F_NONAME___not_used
@@ -37,6 +38,7 @@
 #undef bpf_iter__bpf_map_elem
 #undef bpf_iter__bpf_sk_storage_map
 #undef bpf_iter__sockmap
+#undef bpf_iter__bpf_link
 #undef btf_ptr
 #undef BTF_F_COMPACT
 #undef BTF_F_NONAME
@@ -132,6 +134,11 @@ struct bpf_iter__sockmap {
 	struct sock *sk;
 };
 
+struct bpf_iter__bpf_link {
+	struct bpf_iter_meta *meta;
+	struct bpf_link *link;
+};
+
 struct btf_ptr {
 	void *ptr;
 	__u32 type_id;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
new file mode 100644
index 000000000000..e1af2f8f75a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red Hat, Inc. */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/bpf_link")
+int dump_bpf_link(struct bpf_iter__bpf_link *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct bpf_link *link = ctx->link;
+	int link_id;
+
+	if (!link)
+		return 0;
+
+	link_id = link->id;
+	bpf_seq_write(seq, &link_id, sizeof(link_id));
+	return 0;
+}
-- 
2.32.0

