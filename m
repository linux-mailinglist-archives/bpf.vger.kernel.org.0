Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F304AEAB5
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 08:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiBIHDb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 02:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiBIHDa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 02:03:30 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E28C0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 23:03:34 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id z13so2754257pfa.3
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 23:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ziTgGvt2AQdEu6oqdTDzDr96IYfUqbOyG6ugebX3/rM=;
        b=J/W/yqov9FZ3Df1xqnbCmGnUYeJWF+vglcLGIS+u3iSKlXcpPmjJjuIetrOUWNa211
         iL16Af9h9QbN4r9XrVACoESljTM3sS1pCLCZX71HvDtDDiUf15JsX7cW1eoNnzcPZmfZ
         wI4qLp8yDhJzRbJ00dz9ijv0n0b7RbOCC53s1U71CHnULbLvqStfqJBilDOVDmkYZnpk
         FC9Ozd/+rd6AKmgAAJGvrcfB7XA9tXTK6MOs91VmzyxJT0UtH84NGh/J1ZDdHzg3kgno
         rtR0eT/uS94KMHREb1rbcn71PX5N1vkVA2CYk/hFeP0Use7wu6a1BUkZMnFIUxDsrKks
         B9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziTgGvt2AQdEu6oqdTDzDr96IYfUqbOyG6ugebX3/rM=;
        b=nQbL9d4wNsWQpQ3uZAz8ZlVI6IqMS8DHiD6Oy9/iTLXCdpWAmqf79kinV+zWwa34dw
         UGRpWhcnEYkp9GlgB92sRk93H+VpZ4EHqcXxHHl/u7oGigaLpLNhIFwJJT/ecSKce8Q9
         PHhKUwSKVH12lZ12DkhVLgg6XSCsFufudIyHL9k/rArN2/+91N6+CjdQKFqc5zapkKKc
         316lCvvdAZ06j56lIIPDgTRS5+BgxJuQIvgSyFBHz2pKnIt/hvGBJw9kxLLpJUwkRsc/
         ON/yIO9iTF6FXwMmW/Ehp0CeW4gCtaBGWKLlSJ/sra1PgQJ9m1ekVVNt0Qeb8JYP1paL
         7C0w==
X-Gm-Message-State: AOAM533+LpXzbDbzKlV0V/5FQyewhq/54dWwLPkVi9twrHJpfwRwXfRj
        sBPcw91TCFTHcxE4h0OIfrTwwbrLaGc=
X-Google-Smtp-Source: ABdhPJzHT03y6zSF3n2CG9eY4d2S26GjeY5DKB2sb7qfByt7maoNrn88ES5A+06hOcb2OsGRM2AbHw==
X-Received: by 2002:a62:bd0c:: with SMTP id a12mr828978pff.26.1644390213565;
        Tue, 08 Feb 2022 23:03:33 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id q8sm19657944pfl.143.2022.02.08.23.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:03:33 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add test for bpf_timer overwriting crash
Date:   Wed,  9 Feb 2022 12:33:24 +0530
Message-Id: <20220209070324.1093182-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209070324.1093182-1-memxor@gmail.com>
References: <20220209070324.1093182-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140; h=from:subject; bh=hqXfmLDxF0Uw4Yt5XYbQmoUpTAnSdez7PCI55CrXMP8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiA2cPJ/fCxMxuQ/GMlf4m2CoLn5l7eKO6/QOtTpi0 DlUwNb2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYgNnDwAKCRBM4MiGSL8RykdKD/ 9zKEJ3diVLILUaG5SYcsF6dnHZ41n8+CzumeUAfz3As25LwYGvQ/LsUMYdSWuZ1WjUzuwQXwBlLfW2 kXdyhtza7R9jBiVUmlzxdRCN7+okM6YjCnb5VcWD/l9bgIjEbtZXtundMdsEX3zgtQCpG2Eh6WNXqz 73t3Lgedd9C0v+wfDjk16guJJpaGu4Y8Z+PEwPRTlEUNl90mGDl7VDO+tN+arPP9xO9szAPUqhE5Fw pSPQU03G1o5x59qhn05tBrOoxbw/hs8lvbItKN/i/6FTgC0bpgQwj442jFpiNgR2YRan5Gpcs2Zqy+ nLREjBJY772BPY8GFXDuS3F4ivp/bL7JBd2iDn1WhBfUNfcRqVdFxrNKKWAw6GkqmNRgkZPDxbBPF7 c1z+/81Txi5KiRpfp+L6XDuEiiPxbpVJ8Uye2mk8Ysoo3y3E3S/zKydOLzI27U2qJS1p1UFGSoI+F6 2D5edoNLPp6wLOl78VEmtTO570IKGs7cfmXt9I0Nx4p+jwnTL7TAzv2/uQr/edEZDwq0Y+VkTIcpAV YJjpu8mHWQoivMTrdro5D+rHzG2lXCkF5X0ycvTzNh2MDKZ6OLQYia5RmjsrfwfJG4BfNmK+125rze tJwj7OW6dc+oqexbcazmL9R4k5/v+tY3HdO5Ydbq8sAqrS8RAt0/ndyJUQ2A==
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

Add a test that validates that timer value is not overwritten when doing
a copy_map_value call in the kernel. Without the prior fix, this test
triggers a crash.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/timer_crash.c    | 32 +++++++++++
 .../testing/selftests/bpf/progs/timer_crash.c | 54 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
new file mode 100644
index 000000000000..f74b82305da8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "timer_crash.skel.h"
+
+enum {
+	MODE_ARRAY,
+	MODE_HASH,
+};
+
+static void test_timer_crash_mode(int mode)
+{
+	struct timer_crash *skel;
+
+	skel = timer_crash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "timer_crash__open_and_load"))
+		return;
+	skel->bss->pid = getpid();
+	skel->bss->crash_map = mode;
+	if (!ASSERT_OK(timer_crash__attach(skel), "timer_crash__attach"))
+		goto end;
+	usleep(1);
+end:
+	timer_crash__destroy(skel);
+}
+
+void test_timer_crash(void)
+{
+	if (test__start_subtest("array"))
+		test_timer_crash_mode(MODE_ARRAY);
+	if (test__start_subtest("hash"))
+		test_timer_crash_mode(MODE_HASH);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_crash.c b/tools/testing/selftests/bpf/progs/timer_crash.c
new file mode 100644
index 000000000000..f8f7944e70da
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_crash.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct map_elem {
+	struct bpf_timer timer;
+	struct bpf_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct map_elem);
+} amap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct map_elem);
+} hmap SEC(".maps");
+
+int pid = 0;
+int crash_map = 0; /* 0 for amap, 1 for hmap */
+
+SEC("fentry/do_nanosleep")
+int sys_enter(void *ctx)
+{
+	struct map_elem *e, value = {};
+	void *map = crash_map ? (void *)&hmap : (void *)&amap;
+
+	if (bpf_get_current_task_btf()->tgid != pid)
+		return 0;
+
+	*(void **)&value = (void *)0xdeadcaf3;
+
+	bpf_map_update_elem(map, &(int){0}, &value, 0);
+	/* For array map, doing bpf_map_update_elem will do a
+	 * check_and_free_timer_in_array, which will trigger the crash if timer
+	 * pointer was overwritten, for hmap we need to use bpf_timer_cancel.
+	 */
+	if (crash_map == 1) {
+		e = bpf_map_lookup_elem(map, &(int){0});
+		if (!e)
+			return 0;
+		bpf_timer_cancel(&e->timer);
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.35.1

