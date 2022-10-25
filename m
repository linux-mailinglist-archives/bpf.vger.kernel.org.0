Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EE960D717
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiJYW2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJYW2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D843638F
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so12984519ejc.4
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQBR3N4ypelebWkIW3P1nYGuZKygRIlddf/fNdCwan4=;
        b=OO25d2aY0ZgQIEcz5xnQJptHgbeG4bju0cpSYCe5VMHLYi5tDTMez0FYp6B3Vn7ZDr
         7KP09DIWlGKDjUpFM9w11jSEyEEppzy9zmFCwxi/Duj7N+bbdX/5RhMgjhkDsi2fNLza
         x9NYZWYPS7o5KA4MmrTIUvjNRnYV9ZzpCBjn2VJSoHoVWB56mwcCL/F33+zvYWODakIN
         zImZyG12rrQN3bWMkMv0IuwFvNHlgIinkkQSX8L5lPirXSnNILjgJkC637VfbqJCgo2y
         z/I8CR/7yhn85at+kDnRxBR0H4X2Mx8yyN5Ji11IilwAO91sZxJsTzA5xrDZDzkL1EYA
         ydiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQBR3N4ypelebWkIW3P1nYGuZKygRIlddf/fNdCwan4=;
        b=YVDvBCSUdsps9nW8Yb2uLZICT6SAazABGJLZNC4anKzVyrc+3Y3Z5fdoj2QJXek0sG
         j27DfVgSFYotCW8GFuTovD/eUQJIV6kTiIAxiYKJh/HOnIgO7PhFOwJzVLrUrO4UDp+Q
         39svrrHF8f1IvGQnkQH9U9bypwgx0+/BCpqxP8LLNB9baOOv1dcyg5fNlQ0c/rcISvQh
         /eBiq1dOcuIN4h1F9E0YVmD5M4lGV9i8R9rySif5BcKrkiiuxPeXJoV9WlM9o5v2haOD
         AqBFD4D7PjVMKkhY+9ygpXRt+3KhzBEJPgoBAC9CmDXRfzA08bC0oik+KKuuE0QWvgLt
         lHjQ==
X-Gm-Message-State: ACrzQf1nA+78B/eh83visLM2q97kkVODrOa5GHXLLMCwPB83qxWKcA5d
        Od9DitXE+sMIpkQsl+R04rJGYoo8KXKKsUXk
X-Google-Smtp-Source: AMsMyM48FYPlTjPyFlgIXjJzeou1KpQCMnB10z8IdeWvnp/CTid3Rqu5L3UFriJtOaRUbRk5m3GJVQ==
X-Received: by 2002:a17:907:97d5:b0:7ac:5f72:6c1a with SMTP id js21-20020a17090797d500b007ac5f726c1amr4753969ejc.126.1666736924611;
        Tue, 25 Oct 2022 15:28:44 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:44 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 06/12] selftests/bpf: Tests for header guards printing in BTF dump
Date:   Wed, 26 Oct 2022 01:27:55 +0300
Message-Id: <20221025222802.2295103-7-eddyz87@gmail.com>
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

Verify that `btf_dump__dump_type` emits header guard brackets for
various types when `btf_dump_opts.emit_header_guards` is set to true.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 10 +-
 .../progs/btf_dump_test_case_header_guards.c  | 94 +++++++++++++++++++
 2 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 5f6ce7f1a801..a3db352e61c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -13,6 +13,7 @@ static struct btf_dump_test_case {
 	const char *name;
 	const char *file;
 	bool known_ptr_sz;
+	bool emit_header_guards;
 } btf_dump_test_cases[] = {
 	{"btf_dump: syntax", "btf_dump_test_case_syntax", true},
 	{"btf_dump: ordering", "btf_dump_test_case_ordering", false},
@@ -22,15 +23,18 @@ static struct btf_dump_test_case {
 	{"btf_dump: multidim", "btf_dump_test_case_multidim", false},
 	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false},
 	{"btf_dump: decl_tag", "btf_dump_test_case_decl_tag", true},
+	{"btf_dump: header guards", "btf_dump_test_case_header_guards", true, true},
 };
 
-static int btf_dump_all_types(const struct btf *btf, void *ctx)
+static int btf_dump_all_types(const struct btf *btf, void *ctx, struct btf_dump_test_case *t)
 {
 	size_t type_cnt = btf__type_cnt(btf);
+	LIBBPF_OPTS(btf_dump_opts, opts);
 	struct btf_dump *d;
 	int err = 0, id;
 
-	d = btf_dump__new(btf, btf_dump_printf, ctx, NULL);
+	opts.emit_header_guards = t->emit_header_guards;
+	d = btf_dump__new(btf, btf_dump_printf, ctx, &opts);
 	err = libbpf_get_error(d);
 	if (err)
 		return err;
@@ -87,7 +91,7 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		goto done;
 	}
 
-	err = btf_dump_all_types(btf, f);
+	err = btf_dump_all_types(btf, f, t);
 	fclose(f);
 	close(fd);
 	if (CHECK(err, "btf_dump", "failure during C dumping: %d\n", err)) {
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
new file mode 100644
index 000000000000..3ee8aaba9e0a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+/*
+ * BTF-to-C dumper test for header guards.
+ */
+struct hg_struct {
+	int x;
+} __attribute__((btf_decl_tag("header_guard:S")));
+
+union hg_union {
+	int x;
+} __attribute__((btf_decl_tag("header_guard:U")));
+
+typedef int hg_typedef __attribute__((btf_decl_tag("header_guard:T")));
+
+struct hg_fwd_a;
+
+struct hg_fwd_b {
+	struct hg_fwd_a *loop;
+} __attribute__((btf_decl_tag("header_guard:FWD")));
+
+struct hg_fwd_a {
+	struct hg_fwd_b *loop;
+} __attribute__((btf_decl_tag("header_guard:FWD")));
+
+struct root_struct {
+	struct hg_struct a;
+	union hg_union b;
+	hg_typedef c;
+	struct hg_fwd_a d;
+	struct hg_fwd_b e;
+};
+
+/* ----- START-EXPECTED-OUTPUT ----- */
+/*
+ *#ifndef S
+ *
+ *struct hg_struct {
+ *	int x;
+ *};
+ *
+ *#endif
+ *
+ *#ifndef U
+ *
+ *union hg_union {
+ *	int x;
+ *};
+ *
+ *#endif
+ *
+ *#ifndef T
+ *
+ *typedef int hg_typedef;
+ *
+ *#endif
+ *
+ *#ifndef FWD
+ *
+ *struct hg_fwd_b;
+ *
+ *#endif
+ *
+ *#ifndef FWD
+ *
+ *struct hg_fwd_a {
+ *	struct hg_fwd_b *loop;
+ *};
+ *
+ *#endif
+ *
+ *#ifndef FWD
+ *
+ *struct hg_fwd_b {
+ *	struct hg_fwd_a *loop;
+ *};
+ *
+ *#endif
+ *
+ *struct root_struct {
+ *	struct hg_struct a;
+ *	union hg_union b;
+ *	hg_typedef c;
+ *	struct hg_fwd_a d;
+ *	struct hg_fwd_b e;
+ *};
+ *
+ */
+/* ------ END-EXPECTED-OUTPUT ------ */
+
+int f(struct root_struct *s)
+{
+	return 0;
+}
-- 
2.34.1

