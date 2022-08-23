Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE459CDF2
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbiHWBce (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 21:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 21:32:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27AE5A3C9
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:32:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w20so399184edd.10
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6UemqxAvDWGnv1O00KBmS/fszoO1TMCLlwZ9yVK5Rp0=;
        b=pf5+7a+ZXBDbbt6J05y09rcMIFipSGh55B+xWXNkMWOAz6cy9As509E+VWyeP/jlVJ
         EteXWLLDTjkwugGnDmQbmvz9occezsHVY646RhVvM2CnHcQ7Uk5hlVypL5jWyzMElRsu
         eOfnBSGQJeGReZ0OgJ4xzTuuKW8QRbSn9Cwer81eqCLS4CZvWCqfSvIQr+jpUoGbr1ch
         k+SNHWh1nev/t54rcOkvk8A54H+t6pBrXsZsOAxY+WOKZb6qSGfNUJRZ0tS+ot18Jnsm
         3+nmQJZ/0QYtJl83uYUUBNCJfB+T6yZGTRHoPknL7OFjujIiKgCiUdAewhtQgKRlO/uZ
         LwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6UemqxAvDWGnv1O00KBmS/fszoO1TMCLlwZ9yVK5Rp0=;
        b=uoDVyYc1tGvWb4TWz8DVB9WE3Na/3U/w+XxAOS6UvRePGR6xI0ztLHTmn+4qdwnc8Q
         Q3I0jEogcBCOLjIUxeabot3wFFQXnrJMVLw/hhMhFKVNlmFR24U61HY/t5FRQ3z1RGQb
         xhuDV1bEB/tKkfgMmezrwjMtgP1/tKNsVJAogMCLJTESbLLaxBgv38jdkzOX6Hr+uBjp
         7CF+hrGarsAW+VcJZsRLqhwgN6ohSwjNSdQtjkunZBKwyufgyhRebooIxa/FHmsOxrfx
         QPdxMEI1AziG4m2npz3iUQBRd8wfJ92UhkSuD3uVqqEimK30zeYiGHLphYJpxxGG0PHo
         K/6g==
X-Gm-Message-State: ACgBeo0Hs/4DcacpNh0eF2w/9IQ1d65598rvKqJ6V3dylVeKzHMqus6I
        qIyskCZYUbN1kxn6Cbni97QcWzDl5rA=
X-Google-Smtp-Source: AA6agR5mQjrJ95v9wqrsiekBxv6wfIf4d9yj79O4yNPSGscY6wNeGyuvnUtSZSPHKo09vrnaHnesbw==
X-Received: by 2002:a05:6402:241e:b0:443:be9:83c0 with SMTP id t30-20020a056402241e00b004430be983c0mr1572525eda.24.1661218350914;
        Mon, 22 Aug 2022 18:32:30 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906704b00b007315c723ac8sm6733320ejj.224.2022.08.22.18.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:32:30 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add tests for reference state fixes for callbacks
Date:   Tue, 23 Aug 2022 03:32:26 +0200
Message-Id: <20220823013226.24988-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823012759.24844-1-memxor@gmail.com>
References: <20220823012759.24844-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5389; i=memxor@gmail.com; h=from:subject; bh=5yqjz6tOaH7Usu551D32J6i7WCZXwkv5x5gHsOuamAg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjBCba+pSc0GF9t8iEuWLwgAhdyI1rgMHT+i2Tmh8k 9Mh/T7CJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwQm2gAKCRBM4MiGSL8Ryuq8D/ 98CfKV2nMm5gcw5hxxyBdijzQ+SAnFt6n6JhyHVFv+CVqIgQoysRnrvPByYCt3ufJtcdxtDRlmU9xF Y/YpRxUKc2/56Ly1kTM7/3v/jP8rRtgWiuWG/aHFHUD5zfuDTj9vc8bYVx8+4mZRFxl7i690mZk6Oy GiuCpc/S+v1vlwRSptfMa+LGhu9Jw9qI6wMz7xaChncq5axmELo2cXgI00UBIz4l1x33OnwOGZS+aD EpeeXIVUiRBSIflvXk1cRf3ugmtZg2Wmoah4xGeglxsTuCbzN1Am5rVEUYNLkPAaVc/bqm29X3QOVl UQkfXeF7GfrzYUFtk1oFR1C4FiksAIRUkn3/vTX62wIUlDuG88ESrTlIbu9hx2WSKfhxKUB/IlMiK0 vu4/JPmoI43WZ8fWDthfOzThAYpg+m00KL6T5ExDNgyIHUyrm/ucG9iz1wtBRB86b88g0XXcY5IlBe XiRnqJKZQe9hkmt4w/Xb4pLHpME3TLnH9QFBDIS1rdQ1unhcYMHHP3CKcFSMuSbzD5gTdMmOvkog5f OdRG5PS2CN1IQWkeqwvAMfT5rDCrc0lRoJF8bU8+yj7krBA0oFcKHE/S2Z56z91aIIo6s/fc374PFF 76L3JHVXbexDKIi/aegGUs5F2XJRjacSiwBfQ1PMEVrn/yr3dPh/h1A5qFcg==
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
 .../selftests/bpf/prog_tests/cb_refs.c        |  48 ++++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   | 116 ++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
 create mode 100644 tools/testing/selftests/bpf/progs/cb_refs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
new file mode 100644
index 000000000000..3bff680de16c
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
+	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
+	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
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
index 000000000000..7653df1bc787
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct map_value {
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

