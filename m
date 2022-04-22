Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09E50BFB2
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiDVS1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 14:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiDVS1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 14:27:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B271467D2
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 11:24:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so17950140ejb.6
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkm7rvWa52+YVN6bFZeMXqvMFaUPszXZca0VrqU5Bo4=;
        b=iXpb3CuIoZM+duywtt+xU2ITAxHeveH9QBkOvUBaCbqIwdBW4YKS38abcCTgOJSd7A
         4EdP0jqgLHNzWbR97G5cCAQ5hI+ZpGu9OoxI+e1gQce+r6muIi7l1CNKAnXeiJsOZGQ4
         wz2Er5Iok174wlsB/hPh4NALa0BdJoBuVyg2PwLUEVdvlSY4TpBKJhR56Bca9+WkORQI
         UoegY8DGsb6F2PZiPY4nkoNeWnqYahfiEBOVPdWdXGFbryShCRbVJNXe9RnkCa9Gzpwl
         VJn0s3B+XgMbLyaHqxx4DVMtkg3m4FEIyT82Q+9Em5aBIT9fohtvd97NDs+FCqL7rqrR
         7Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkm7rvWa52+YVN6bFZeMXqvMFaUPszXZca0VrqU5Bo4=;
        b=Wwc9THAzcumwX+hoTkQA5wII19XvKelcHM/oIgzORO7Q4tnDVACXPYyEsU//aPfDy8
         rdbWEYzTsFH9Eyv2k0osTK4sG7UJ70beeMDm7klv3H1o4djCOBakq8/lc+PnLmMHEreL
         5lp/TKdAIlBmPfw6NMvd1R98htx3lTro1XJO1MzCo9YpqodEZEK1ngQ2+E7gNvcHVHsd
         7KVrV4ZI43gzv7xin0N+E+KWntYBxal4gYQzACymbOn7nNAkz1vUj/Ax/vE0B5hGl+X3
         QO9JuNtT7+DjXf6O39NA8+0FTSQHkyBMmzM3aNgEX0VBz3CSGz93K10ZJddxlvelF2d4
         BC3A==
X-Gm-Message-State: AOAM531y7sqDw9sZRWhtSw3/9ym8bgS/QixeSjGixsNs+7h1rg/D6Urq
        qsOF2ROEGhopnaThezNxxa1QUm8wZ7PzPw==
X-Google-Smtp-Source: ABdhPJwZ6wgJ84xg4LLFwjaAt/GG66BBka8H0wzoNACswPqVO21bBDFMmmxBa5kUYpIfPC26LhV7HQ==
X-Received: by 2002:a17:907:9482:b0:6da:8ad6:c8b5 with SMTP id dm2-20020a170907948200b006da8ad6c8b5mr5283901ejc.372.1650651825022;
        Fri, 22 Apr 2022 11:23:45 -0700 (PDT)
Received: from erthalion.local (dslb-178-005-225-126.178.005.pools.vodafone-ip.de. [178.5.225.126])
        by smtp.gmail.com with ESMTPSA id d11-20020a056402400b00b00423e5bdd6e3sm1152312eda.84.2022.04.22.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:23:44 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add bpf link iter test
Date:   Fri, 22 Apr 2022 20:22:54 +0200
Message-Id: <20220422182254.13693-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422182254.13693-1-9erthalion6@gmail.com>
References: <20220422182254.13693-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a simple test for bpf link iterator

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 15 +++++++++++++++
 .../selftests/bpf/progs/bpf_iter_bpf_link.c    | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 2c403ddc8076..e14a7a6d925c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -26,6 +26,7 @@
 #include "bpf_iter_bpf_sk_storage_map.skel.h"
 #include "bpf_iter_test_kern5.skel.h"
 #include "bpf_iter_test_kern6.skel.h"
+#include "bpf_iter_bpf_link.skel.h"
 
 static int duration;
 
@@ -1172,6 +1173,20 @@ static void test_buf_neg_offset(void)
 		bpf_iter_test_kern6__destroy(skel);
 }
 
+static void test_link_iter(void)
+{
+	struct bpf_iter_bpf_link *skel;
+
+	skel = bpf_iter_bpf_link__open_and_load();
+	if (CHECK(skel, "bpf_iter_bpf_link__open_and_load",
+		  "skeleton open_and_load unexpected success\n"))
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
new file mode 100644
index 000000000000..a5041fa1cda9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
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
+	link_id = link->id;
+	bpf_seq_write(seq, &link_id, sizeof(link_id));
+	return 0;
+}
-- 
2.32.0

