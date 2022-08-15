Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E459290A
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 07:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiHOFQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 01:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbiHOFPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 01:15:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A6115D
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z20so8280048edb.9
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WboJMcAwXm+hJMEu30UpiOPSq2qIq1XHhMmoik5uyRo=;
        b=NY+Y/Og+tYPCd3vAfR3axxYeW3D2bHFIjFkJjaY1BmYQL49Rp1k1Yv3OC+jC/0KSuZ
         EzSj8RgT5YP7wlk0ggv3M/Ad9Ub/P44DNopi7/3KeQVnAubT+uTexUHrLYmO5xRRnrNA
         o2midymefFJOdFaZvQ/O5UOVURlnvGjdpYi6V1bPLLaihb0t7IP2dWl0TnMchUESEnYc
         Mo1wMdEenCk15oxbqbrHdeYUwdDJXw8ygwbTH5sJOvU0opoxEvn/pu2ES3aNKon5pMxs
         wq+nBl4zjEwPWhd0I45mDYkEzdxcR2nPlEbncx4iKhFC+TitjqE+Adat0pPzxq98YM5r
         KQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WboJMcAwXm+hJMEu30UpiOPSq2qIq1XHhMmoik5uyRo=;
        b=JRXAJvwIwGZBusgVDZEDcWm2gXJIjuBu9UecN8lKLLH6nAdI1itAyY/CXtf6iIgV3a
         URnD+z5FtN0XcW66xbH2GXq5SWwDiKGeV7kSwpwor0iqB1dcVHiQgsdzrTktc7rBCKQx
         7vO0JXjtoDlJtDJh1VLZ7UGywvBfSVE2+MNs0EgJTNPZY9zkuluWcbPY/EI45j/oPHGp
         5i/79JS1aOx2MHep7lwFhYjwnGod2KFkNLnWxVKNSbithb/unOTjdkDfHNJkSgLQKvK1
         KJOZnam6LrXOvg7VhBWJ0AE48X1yHt7RyVG9siUwGZlN63wlePHHMANKH8bup56Xy0OD
         s/QQ==
X-Gm-Message-State: ACgBeo3/1XiVXcwKCwmyeDMZon/YQcwB5GCqueXuaBHOVtX2ltX3pOfn
        96KASETDTKK0JlXfHcuB6zDXsOxikug=
X-Google-Smtp-Source: AA6agR7guj41UCzoc0jRQLbApAsb5aoeUjwlOazPNhh5gzPvEyp5BjEW8AvfUY3ql73Iad/osvMCPA==
X-Received: by 2002:aa7:c78e:0:b0:441:c311:9dcd with SMTP id n14-20020aa7c78e000000b00441c3119dcdmr12766693eds.155.1660540545332;
        Sun, 14 Aug 2022 22:15:45 -0700 (PDT)
Received: from localhost (vpn-253-028.epfl.ch. [128.179.253.28])
        by smtp.gmail.com with ESMTPSA id op9-20020a170906bce900b0072b810897desm3634334ejb.105.2022.08.14.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 22:15:45 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC bpf v1 3/3] selftests/bpf: Add tests for callbacks fixes
Date:   Mon, 15 Aug 2022 07:15:40 +0200
Message-Id: <20220815051540.18791-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815051540.18791-1-memxor@gmail.com>
References: <20220815051540.18791-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6036; i=memxor@gmail.com; h=from:subject; bh=99EcuOKPJECuxwRzBUnopm3k2Xtp1EeIE/gex8PFlQw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi+dZI69t5Yd117iXA+pOzKTtYJiOlxY3ayEhbdNZt FDimeQ6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvnWSAAKCRBM4MiGSL8RyqRDD/ 0UGL84Y/MqNVIxkR9F4c4TxMGrGZQ55yOC9WgaKbS3mUc2HOJD4j5Ndvnve0cbAWtLYZN3qIdaceAw FIwtg6Vd1Ze3Gyy160o213sHRYzD9Ons1w538EDm53dcsR+ONr9VntC4ZkdpStxdbOww0l1pdxKg8i diVIxcJoNXEPOl00H2A2o2rI4GwlWQBNbKofAVmKDAaoymjHahoo2uk+yUFcH2Hb7wycd/dxWrFWuS Tq4gkS1N9HC+EoK3FsCj47FmArPwdyv+ADljy6j8wEaM3hOTcJ3y1HMkYpI+hcyGTur5Niu7SMxvrW dyMAjq8/AyjST5n+4fVgbWAxuEp9a7ZvayZs5acidIvrE9OW5/AamcFOr7arB50gq0Ry9NXGK2k6Lb bK1cl+MFZ1in1fU4CFkkRBYy320c1lsN+VKzFF7XW3GwCkSdb0AUZkVeqnMNAixUIBMga6sTEH7Lxb D/hcNNQcZH0cKfR5qIfn1FHL+5zvTmRKUaATK0ScWEoGoueLJeERzT3aIjgj0/D1+pL7e6dqe/2q9R CToMuD2EYflIIT1KbylOYD0G5WxDaW8OnTtNiixmtnLFKTkndFDxgg0wMzDDhJD12kFh/Eir2gr4jc lo4aV4W/qJAYKe/IYA/JbLToNDYW89dM9G5fLObyS2xKq3l/3KM7E7hanQxw==
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
the fixes to verifier callback handling in previous patches.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/cb_refs.c        |  49 ++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   | 152 ++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
 create mode 100644 tools/testing/selftests/bpf/progs/cb_refs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
new file mode 100644
index 000000000000..a74ac3ace5c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -0,0 +1,49 @@
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
+	{ "nested_cb", "Unreleased reference id=2 alloc_insn=16" },
+	{ "oob_access", "TBD..." },
+	{ "write", "TBD..." },
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
index 000000000000..1f3ce0b4f8b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -0,0 +1,152 @@
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
+static __always_inline int cb1(void *map, void *key, void *value, void *ctx)
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
+	int p = 0;
+
+	bpf_for_each_map_elem(&array_map, cb3, &p, 0);
+	return 0;
+}
+
+static __always_inline int lcb(void *map, unsigned long *idx)
+{
+	unsigned long i = *idx;
+	i++;
+	*idx = i;
+	return 0;
+}
+
+SEC("?tc")
+int oob_access(void *ctx)
+{
+	unsigned long idx = 0;
+	struct map_value *v;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 0;
+	bpf_loop(100, lcb, &idx, 0);
+	/* Verifier would think we are accessing using idx=1 without the fix */
+	return ((unsigned long *)&v->data)[idx];
+}
+
+static __always_inline int lcb1(void *map, int *idx)
+{
+	int i = *idx;
+	i--;
+	*idx = i;
+	return 0;
+}
+
+static __always_inline int lcb2(void *map, void **pp)
+{
+	int i = *(int *)(pp + 1);
+	pp[i + 2] = (void *)0xeB9F15D34D;
+	return 0;
+}
+
+SEC("?tc")
+int write(void *ctx)
+{
+	struct {
+		struct map_value *v;
+		int idx;
+	} x = {};
+	x.v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!x.v)
+		return 0;
+	bpf_loop(2, &lcb1, &x.idx, 0);
+	/* idx is -2, verifier thinks it is -1 */
+	bpf_loop(1, &lcb2, &x, 0);
+	/* x.v is no longer map value, but verifier thinks so */
+	return x.v->data;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

