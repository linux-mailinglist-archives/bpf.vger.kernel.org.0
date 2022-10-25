Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E947960D716
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiJYW2q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiJYW2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414C8205FF
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy4so16540373ejc.5
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma0BF2cRyOQRhSe+pUioeCpF+s2k/1XYgu3BKKXbb8w=;
        b=FV2j8PwgRQFxEaOo6no+YWQ0AsCTtGAsxETnG/6KWF+pIc4xzIPWYs/04uxiETJqe8
         +TxDdTq1eV2mFEG1M4hGtOE3Wn15qizaG54MXOmPhGQukY2ygOvty2xRs2NXmKw0RGQp
         a1QSlX7WbNs3cCAQVDX6XCuyTkX/DEdFuOqXBWXceY0ioH607pjH4/BW5Hr1/A3rgdKv
         rqJI5MvRgPtdNR1UC4pOSzmzhZo/R9Q3ezycshQbmHRA/+Q7nGSZTw9wzUA9K+ghV19f
         OLhEm76vahjhWimFC1pPqUS2lfp90LDcK+UDvq0N29atBLPOkuN3hZiCgn1Xaoqy02NH
         5IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma0BF2cRyOQRhSe+pUioeCpF+s2k/1XYgu3BKKXbb8w=;
        b=jvKxLlCbzOwnceGpRMrkq+Qu0E3iYPsMz28vfs1u7F7JREAe9d7Y7UoPS0+pA2nK6l
         w3+/o9h3AJ5lYaAgIsFIPDWT9YI5eyuyPQm9TuH5UjEpbgwGMpZrfVd7/92Ni7SpHx/7
         3dnEJOdZhWEB2xV7obLg29qdtI8k0byWdVnixk2VpovbHj1uIajFGTZPhHes1Rzf408/
         B3U5VXsDESL/X+VgJ9fJ9M+NC6SVKEkCgrMUIhxkKkh9kSiCRBd4oJsONu/+xqWhAUTM
         qGNgI442WluBdDIFE7h4KraqBrR48xZnwdwvCPMJPJ0i2eBhDyWWyF1HEU0Rfsrs1OYP
         OcrQ==
X-Gm-Message-State: ACrzQf0hSkw6rgk9zAsx5YjZaWSnuYZAqGjSeMRJTi3ImfQlfylhhr/R
        SUA6JQxSOv6CIdIW+0tNgEHbqg8dT5ZK54W3
X-Google-Smtp-Source: AMsMyM5eFL0FWDPYZvGs+nIYzyixEzb33H2uGRNzpUjU/wHk+lc1jxR3bIHtJybMtLo1Nhmse5yYvg==
X-Received: by 2002:a17:906:fd84:b0:730:acee:d067 with SMTP id xa4-20020a170906fd8400b00730aceed067mr34763920ejb.206.1666736922530;
        Tue, 25 Oct 2022 15:28:42 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:42 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 04/12] selftests/bpf: Tests for BTF_DECL_TAG dump in C format
Date:   Wed, 26 Oct 2022 01:27:53 +0300
Message-Id: <20221025222802.2295103-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
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
  branch in `tools/lib/bpf/btf_dump.c:btf_dump_emit_attributes`.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       |  1 +
 .../bpf/progs/btf_dump_test_case_decl_tag.c   | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
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
index 000000000000..470bbbb530dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+/*
+ * BTF-to-C dumper test for __atribute__((btf_decl_tag("..."))).
+ */
+/* ----- START-EXPECTED-OUTPUT ----- */
+struct empty_with_tag {} __attribute__((btf_decl_tag("a")));
+
+struct one_tag {
+	int x;
+} __attribute__((btf_decl_tag("b")));
+
+struct same_tag {
+	int x;
+} __attribute__((btf_decl_tag("b")));
+
+struct two_tags {
+	int x;
+} __attribute__((btf_decl_tag("a"))) __attribute__((btf_decl_tag("b")));
+
+struct packed {
+	int x;
+	short y;
+} __attribute__((packed)) __attribute__((btf_decl_tag("another_name")));
+
+struct root_struct {
+	struct empty_with_tag a;
+	struct one_tag b;
+	struct same_tag c;
+	struct two_tags d;
+	struct packed e;
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

