Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CD617E4C
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 14:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiKCNp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKCNpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 09:45:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C826B2AD7
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 06:45:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v27so3108143eda.1
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T5GAMKU4wGhBoCXtRE+scTJEYa9QX5FD58UrAb6FqQ=;
        b=X6ouownMw6DUpq/tJZ0pORUJBN14zJyPthk/2HyijDlM//tUEMfOIiPEWZ9IL4xlYs
         DKiWzzY1ihfq0Oy3jUH6imoHCCQkbFVguvrkM01qHhgmYRjmoBIf6Y358VFDBh6eUVVf
         kihOxOLgTPqq2fByHl6HUGTr+wnUUmuMSCB7IRQ/kix0tE7yu8DbzGjq/zKCsf2AuDGC
         Jzxkwzxg/oiMvUBbKDGPHAchFwqvoqcAGz+kFDPxkNJbJTjoW2GsyQR0wguMkjYNBjA/
         bV9qEoP2by5CmWr35Iz8eoHc4G1PD9ztji69w6aJLo/6sIxk8ZgwW7LhbdhBbAl0YiNe
         2MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T5GAMKU4wGhBoCXtRE+scTJEYa9QX5FD58UrAb6FqQ=;
        b=uqCGLdYZA3HnZs+uIeVLX9gUANYQqd+sUmXNYi0sMm0ereF9meMxODtneFZBOkzBr9
         XH0ejj72/fSrTiJabj8BcPyqyMwcArgFBeV4bEI9fEWioArBRMlD1KaRBqNpg4Kx35i+
         Ss6h6rHbcDHbRV6c2Xe1/ZT6XB0jtNjlxoBHxUeteJdZukm/oHg/RZMv7KGg/0PW7SUh
         eo7aJH7lqXjLocWihBYZhLSIDHu55N7mOubvevWlvigmtOTxQ8iqOdyfovadPBAAXH/9
         vMAEHriWRI9yQHMwBUuoWlLwGlirsDIrQ+4nbjsI1kZAdI8i5oKNugWgxttcCb2y0Y+D
         GXBQ==
X-Gm-Message-State: ACrzQf1/D57O7Mq5nSUoo27wqjY0p4n3u+vLwygDZYbCuscpE8EwYSY1
        HdfMmqwe8/lNNDS/q0PotdU23OJqZVn6WzMH
X-Google-Smtp-Source: AMsMyM5UiPY196y7fjGvNeNA8zAlPFezvc/LahhSXBZicDPB0j34g4yDyYkAPYepcK6y3iOnWtl5PA==
X-Received: by 2002:a05:6402:5:b0:463:39ab:c1da with SMTP id d5-20020a056402000500b0046339abc1damr24210433edu.166.1667483145088;
        Thu, 03 Nov 2022 06:45:45 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id n20-20020a05640206d400b00443d657d8a4sm532766edy.61.2022.11.03.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:45:44 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Tests for BTF_KIND_DECL_TAG dump in C format
Date:   Thu,  3 Nov 2022 15:45:22 +0200
Message-Id: <20221103134522.2764601-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103134522.2764601-1-eddyz87@gmail.com>
References: <20221103134522.2764601-1-eddyz87@gmail.com>
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

Covers the following cases:
- `__atribute__((btf_decl_tag("...")))` could be applied to structs
  and unions;
- decl tag applied to an empty struct is printed on a single line;
- decl tags with the same name could be applied to several structs;
- several decl tags could be applied to the same struct;
- attribute `packed` works fine with decl tags (it is a separate
  branch in `tools/lib/bpf/btf_dump.c:btf_dump_emit_attributes`;
- decl tag could be attached to typedef;
- decl tag could be attached to a struct field;
- decl tag could be attached to a struct field and a struct itself
  simultaneously.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       |  1 +
 .../bpf/progs/btf_dump_test_case_decl_tag.c   | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 24da335482d4..5f6ce7f1a801 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -21,6 +21,7 @@ static struct btf_dump_test_case {
 	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", true},
 	{"btf_dump: multidim", "btf_dump_test_case_multidim", false},
 	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false},
+	{"btf_dump: decl_tag", "btf_dump_test_case_decl_tag", true},
 };
 
 static int btf_dump_all_types(const struct btf *btf, void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
new file mode 100644
index 000000000000..7a5af8b86065
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+/*
+ * BTF-to-C dumper test for __atribute__((btf_decl_tag("..."))).
+ */
+/* ----- START-EXPECTED-OUTPUT ----- */
+#if __has_attribute(btf_decl_tag)
+#  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
+#else
+#  define __btf_decl_tag(x)
+#endif
+
+struct empty_with_tag {} __btf_decl_tag("a");
+
+struct one_tag {
+	int x;
+} __btf_decl_tag("b");
+
+struct same_tag {
+	int x;
+} __btf_decl_tag("b");
+
+struct two_tags {
+	int x;
+} __btf_decl_tag("a") __btf_decl_tag("b");
+
+struct packed {
+	int x;
+	short y;
+} __attribute__((packed)) __btf_decl_tag("another_name");
+
+typedef int td_with_tag __btf_decl_tag("td");
+
+struct tags_on_fields {
+	int x __btf_decl_tag("t1");
+	int y;
+	int z __btf_decl_tag("t2") __btf_decl_tag("t3");
+};
+
+struct tag_on_field_and_struct {
+	int x __btf_decl_tag("t1");
+} __btf_decl_tag("t2");
+
+struct root_struct {
+	struct empty_with_tag a;
+	struct one_tag b;
+	struct same_tag c;
+	struct two_tags d;
+	struct packed e;
+	td_with_tag f;
+	struct tags_on_fields g;
+	struct tag_on_field_and_struct h;
+};
+
+/* ------ END-EXPECTED-OUTPUT ------ */
+
+int f(struct root_struct *s)
+{
+	return 0;
+}
-- 
2.34.1

