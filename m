Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EEC59C05B
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiHVNTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiHVNTd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 09:19:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BC14095
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gi31so14645116ejc.5
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VzwxWm9tDJaXpC1Qsx09AEIrLAO9Jnlp3drwUyU5Rog=;
        b=XE15Z3SMfB3u4Q3q3Zt+oOV+hHLOf3djGMjjPka2rPjD9kIoyT96be3NjJuNrr6+uK
         MiRyJEgIN6X/dlfDJS1Ra/ccjy7xQqWvxTMfFjzUDum2bRLW+2mGbV5VJkCgyI9zPS91
         5ydyOK2TDIKfUbPe8ag67CE4tdxyiYupBGteBXQMg8/VWWTIjTXLY7fH3cW2HVOBUgfv
         mhSvmE+EbGr8awkQXaUc+wm9nLKldCgJ+kdpygmoBQONwmgs//kIJlnMiqmtD+dfJ2jf
         ZdHarUcEP8xI7DWLiOtWy2BNNGjqOwOMOFDgjsLES3DTGt3fld5iklvwwAn3VZfjtZHI
         LayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VzwxWm9tDJaXpC1Qsx09AEIrLAO9Jnlp3drwUyU5Rog=;
        b=0cUrzu9sDmOKjr+LUqEFKahUWPJEb07DMArKqpgZPYFfXgsISKNKWwYf1uJGtcPqrX
         6a+fX0lkvXy+DAehTdnMto8Sdn1EMzBteraD74+yDpW3PbGZHe+TZYT3UOVGvBSW4Nup
         7EhtKHo6kqIrG+xXRCEgJqFbeUIwlSoc9FUFXuAiuPhZiy2kASglaIApurCEXN0kucGS
         fSTw7k+E8iST06A3PRp1itXI+WTy36mztniJxV0OSMlAfDjDpft8bxi2C/e/iuQoj29V
         v8n3NJrUOx0NXHozJjSIOkXrcf98uq7yghVYoo1ED3CAQiJDziCaFZrGvAfbRbgWuYdU
         qKkQ==
X-Gm-Message-State: ACgBeo2dK5jTe6M3JNQ48/zOuS/6W3TRmGX9Kv6agBXJyn7Jo7FXb4Dr
        jWpFK+hU+cyxmqZWWfUDLTr+isT0dFE=
X-Google-Smtp-Source: AA6agR5bqCHmzkDCogd/ErKdl+BhVz/CT6HQlTTr6jbYle6KTayFJDjmISj4bhA/k7prtA9U51CkFA==
X-Received: by 2002:a17:907:970b:b0:73d:5a29:959 with SMTP id jg11-20020a170907970b00b0073d5a290959mr8818062ejc.183.1661174370788;
        Mon, 22 Aug 2022 06:19:30 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906300600b0073ae9ba9ba8sm6179676ejz.3.2022.08.22.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:19:30 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 3/3] selftests/bpf: Add tests for reference state fixes for callbacks
Date:   Mon, 22 Aug 2022 15:19:23 +0200
Message-Id: <20220822131923.21476-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822131923.21476-1-memxor@gmail.com>
References: <20220822131923.21476-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5389; i=memxor@gmail.com; h=from:subject; bh=+2pOhXjgbH3hNmnUIl7yh7p8ST/cZh8N7ACpW+eO6dA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjA4Gp4eyaXtUkoldl8B0PE8kpI4TG6crF2Hzua8QT HCpldQqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwOBqQAKCRBM4MiGSL8RynHXD/ 4y9joZUe4kM3iHvG1ov/uqP92sZNFc1i2R0alpH24RIPNDFtfMkX0jQIoZp1m3AFJ+gEAAqPa6aYnI bTxuomX43rIwcevVcNhyBnP5mlcygTAtxU2/o9pq4pACS86g3BDKTbHu5rUcSmc8lgsqkLEj/mH9si s+nRWsqEqc2C0VPOPAgw5u9zvabKx7yBPbLi/EWeqrGE+kioZj8a3VSBSw16djQ/2xr8OKpWKM7s+/ PdTLxLzUZ+JZ6b++AAferp2cgDxBTpqSb6Mozeb2FqXJONjk9kqrWHMDpfsk+wuF8P/T9UGROLRe2K tDskieSw1WvIFui3MyGwghZVFZa1hVAExwdlIpay2ybeiB8Jzxdmw7e9te3oNrwfAg4b5oVJoqKnXg m6bCE1KP7CguKuFrO6ManYpeEJ9aditFKWf2fVsDgHVaNV91LxSWBzNSbjsvZCEgcse87NauZBiSXW dNNqD4yoC0wEQRZugjI6qDKz1jJcGrVS+Mt5EsWzJCbL4L3FiC3ycpUXNKwrcggHd5xQRz+ucFi7Y9 rQJOoGQSS4m7touyea5A4uNWFT2wpDK1Uexil0H8B5bCSlAMn6gU69bLjf/BLQXbxPdsyuPZE1gV96 uy9pzmMQORJ5F2gFuKEWlYYDgURfciBNALyaINXAZ7Y1X7TXkmD6ELvgslBg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These are regression tests to ensure we don't end up in invalid runtime
state for helpers that execute callbacks multiple times. It exercises
the fixes to verifier callback handling for reference state in previous
patches.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/cb_refs.c        |  48 +++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   | 118 ++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
 create mode 100644 tools/testing/selftests/bpf/progs/cb_refs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
new file mode 100644
index 000000000000..5f43aa727f3e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf/libbpf.h"
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "cb_refs.skel.h"
+
+static char log_buf[1024 * 1024];
+
+struct {
+	const char *prog_name;
+	const char *err_msg;
+} cb_refs_tests[] = {
+	{ "underflow_prog", "reference has not been acquired before" },
+	{ "leak_prog", "Unreleased reference" },
+	{ "nested_cb", "Unreleased reference id=4 alloc_insn=25" },
+	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=12" },
+};
+
+void test_cb_refs(void)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
+						.kernel_log_size = sizeof(log_buf),
+						.kernel_log_level = 1);
+	struct bpf_program *prog;
+	struct cb_refs *skel;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cb_refs_tests); i++) {
+		LIBBPF_OPTS(bpf_test_run_opts, run_opts,
+			.data_in = &pkt_v4,
+			.data_size_in = sizeof(pkt_v4),
+			.repeat = 1,
+		);
+		skel = cb_refs__open_opts(&opts);
+		if (!ASSERT_OK_PTR(skel, "cb_refs__open_and_load"))
+			return;
+		prog = bpf_object__find_program_by_name(skel->obj, cb_refs_tests[i].prog_name);
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_ERR(cb_refs__load(skel), "cb_refs__load"))
+			bpf_prog_test_run_opts(bpf_program__fd(prog), &run_opts);
+		if (!ASSERT_OK_PTR(strstr(log_buf, cb_refs_tests[i].err_msg), "expected error message")) {
+			fprintf(stderr, "Expected: %s\n", cb_refs_tests[i].err_msg);
+			fprintf(stderr, "Verifier: %s\n", log_buf);
+		}
+		cb_refs__destroy(skel);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
new file mode 100644
index 000000000000..87e478204046
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct map_value {
+	unsigned long data;
+	unsigned long data2;
+	struct prog_test_ref_kfunc __kptr_ref *ptr;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 16);
+} array_map SEC(".maps");
+
+extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+
+static __noinline int cb1(void *map, void *key, void *value, void *ctx)
+{
+	void *p = *(void **)ctx;
+	bpf_kfunc_call_test_release(p);
+	/* Without the fix this would cause underflow */
+	return 0;
+}
+
+SEC("?tc")
+int underflow_prog(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long sl = 0;
+
+	p = bpf_kfunc_call_test_acquire(&sl);
+	if (!p)
+		return 0;
+	bpf_for_each_map_elem(&array_map, cb1, &p, 0);
+	return 0;
+}
+
+static __always_inline int cb2(void *map, void *key, void *value, void *ctx)
+{
+	unsigned long sl = 0;
+
+	*(void **)ctx = bpf_kfunc_call_test_acquire(&sl);
+	/* Without the fix this would leak memory */
+	return 0;
+}
+
+SEC("?tc")
+int leak_prog(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	struct map_value *v;
+	unsigned long sl;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 0;
+
+	p = NULL;
+	bpf_for_each_map_elem(&array_map, cb2, &p, 0);
+	p = bpf_kptr_xchg(&v->ptr, p);
+	if (p)
+		bpf_kfunc_call_test_release(p);
+	return 0;
+}
+
+static __always_inline int cb(void *map, void *key, void *value, void *ctx)
+{
+	return 0;
+}
+
+static __always_inline int cb3(void *map, void *key, void *value, void *ctx)
+{
+	unsigned long sl = 0;
+	void *p;
+
+	bpf_kfunc_call_test_acquire(&sl);
+	bpf_for_each_map_elem(&array_map, cb, &p, 0);
+	/* It should only complain here, not in cb. This is why we need
+	 * callback_ref to be set to frameno.
+	 */
+	return 0;
+}
+
+SEC("?tc")
+int nested_cb(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long sl = 0;
+	int sp = 0;
+
+	p = bpf_kfunc_call_test_acquire(&sl);
+	if (!p)
+		return 0;
+	bpf_for_each_map_elem(&array_map, cb3, &sp, 0);
+	bpf_kfunc_call_test_release(p);
+	return 0;
+}
+
+SEC("?tc")
+int non_cb_transfer_ref(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long sl = 0;
+
+	p = bpf_kfunc_call_test_acquire(&sl);
+	if (!p)
+		return 0;
+	cb1(NULL, NULL, NULL, &p);
+	bpf_kfunc_call_test_acquire(&sl);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

