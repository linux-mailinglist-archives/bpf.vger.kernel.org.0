Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE54C61DFF0
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 02:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKFBwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 21:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKFBwF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 21:52:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75BFD28
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 18:52:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so11527883pjk.2
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 18:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPF64G9P9inhPgfq2PdP/ijQ410xGDxFKlwtcOY8Nb4=;
        b=hUVEH0/SncP2/5IL893Ll5GRDNFPmkj26CdjW0OhVKwtcT6sMEj5DeIQHyYBUr7D/c
         y9+LUYd1VmuvW1yDlqL2KbFTU1rF0O/kPWeIqlqhNvaUR/7pAznE0/8+UBN7L8guCnDh
         zweBatvAzejXZpUZ0wNwkJzPUGboyqdnBcQvnRHpzC0VKqvHLVX3ylQzU81ixPZOELmi
         koTmBPboo9cwBPY4Po4A5SjWnmd/0QW2kNqZkfTkfYssjxxKVF1/kbij+6Zji03ttNW4
         L6+hSiYSZuljbduHOpOgtTj1tstmJ/QGLYdqvMIWex5NpQL1ODbbHaSbEL7bpBOveYAA
         4LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPF64G9P9inhPgfq2PdP/ijQ410xGDxFKlwtcOY8Nb4=;
        b=h4fAkRFr4hTYiG8REdRaeLLWKUULILXO2X6ieGED5Ed3cb/D/OqBrKZLK8JpV9n0wp
         Tw1AuAtM1HihQYeothejKJxTHr96v6hhg/34o6bajZqYugwDLYAUa1ZdReAj03TYXjrs
         QpqJbvrvKhgrnkRNKipvLdbtRbkvUXTTs/g0VueHfypdVypuSVacSpCu9LYZmQKDh7Lm
         bH08T0I7hRcP9kS2Qbb06It7P3Pvp5J6XM2Lv9WWhq7yQRm7qSGHLF7AcaNEcwjXon3j
         4f3z5GDveKUbMxaztEk/MiRs8oj550WHWa9j+IPzMLfpo2enI4J1S2DmQmmgu+XCNem3
         Fh3g==
X-Gm-Message-State: ACrzQf0WgGjUKnlxazte2zMSA2h/0jVK9/MskUx+EAoc5aysAbUao8l2
        oSUqtg27eE7P0PBc6EvppXa0gO7xh4VStw==
X-Google-Smtp-Source: AMsMyM6kKkWvietN4puLPBPlOmV2dXthvJVOOD62z4/FVvyIYKV9krPwjAkJAeRcEkSKNW+Vbq1ElA==
X-Received: by 2002:a17:902:eccd:b0:187:143f:4c3c with SMTP id a13-20020a170902eccd00b00187143f4c3cmr37861659plh.143.1667699520134;
        Sat, 05 Nov 2022 18:52:00 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id a72-20020a621a4b000000b0056bbeaa82b9sm1836493pfa.113.2022.11.05.18.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 18:51:59 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH RFC bpf-next v1 2/2] [EXAMPLE] selftests/bpf: Add timer deadlock example
Date:   Sun,  6 Nov 2022 07:21:52 +0530
Message-Id: <20221106015152.2556188-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221106015152.2556188-1-memxor@gmail.com>
References: <20221106015152.2556188-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=memxor@gmail.com; h=from:subject; bh=M7e1i9XB0k5tCio9Zf7yMFl/z2d8JwPlCK/o/zF/dKU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZxJYBulOk6CCZ6fBY/Rz0LOn4ZiKZTIPsrjs3uZc vXpetX6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2cSWAAKCRBM4MiGSL8RyslkD/ 98ZA6tdrAB086vsaTvg7JU+MrP7zXLAGkgLGH9sQweNl6EC/LGS5sZV7HVUxOKDzBdQyWM0AP0MqHY 7iHvGHTBkR7+udMVj7I1qydcAml34VAidfoqfFiV7IwnQldk1qdUu1NVNfGm+9uL6BWQ5Hromy7ap9 yiB6pdnvngrelDp91UPHFntZyJmJWQEuZUeFAEQMV2+bMF0xxwnnEWjSB8DuUAg7C2b5HbjVdjxM51 o59gI1AplSEns4JTEGATNqEzyHbMKx25SRjbbl0e9MHvi9II47BRlrYKQuLpqOW09uFSuz64iCvmCg NCSwN9vyFPOKotjPICv96YR6/mzMEi+kqdvUGnv75Gclj5fOwCOylhM8sN4HY80wIHR57cyN793XfU ssxMxMVmCxJpMsNLbKOFQcu/tjR8HQSDqKExv6AqiGqJEKm7idmGiN6EdO77YJX7VWHKFqgOHQ6Kxw GqMdLkP7eJNCte0/OWXYqgR1EnoPVMTPQNUJ6NHOliocK9U0cXmCvC9QZl5wwIMi8Eem+FQ2cjIDD1 W+4Ee2WB6aAcMxLx6UTUtDNzwAF8ThrVQ9HqYIJ++3o38VF2iLPS/m43mXoTnWt9C/t1R3XRuH6Fox 56PgYkLoAaVu6qkUM5PqlYYoUKADYocyzBe/161k2d8x2VvNVx6jVJAtFQlA==
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

This is just an example to showcase that the deadlock can occur in
practice. Run this on an unfixed kernel by uncommenting the skipping
part in timer_deadlock.c

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/timer_deadlock.c | 29 +++++++++++
 .../selftests/bpf/progs/timer_deadlock.c      | 50 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_deadlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_deadlock.c b/tools/testing/selftests/bpf/prog_tests/timer_deadlock.c
new file mode 100644
index 000000000000..83657577d137
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_deadlock.c
@@ -0,0 +1,29 @@
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "timer_deadlock.skel.h"
+
+void test_timer_deadlock(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct timer_deadlock *skel;
+
+	/* Remove to observe deadlock */
+	test__skip();
+	return;
+
+	skel = timer_deadlock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "timer_deadlock__open_and_load"))
+		return;
+	if (!ASSERT_OK(timer_deadlock__attach(skel), "timer_deadlock__attach"))
+		goto end;
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.tc_prog), &topts), "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+end:
+	timer_deadlock__destroy(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/timer_deadlock.c b/tools/testing/selftests/bpf/progs/timer_deadlock.c
new file mode 100644
index 000000000000..ac05c7320144
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_deadlock.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+int tid = 0;
+
+struct map_value {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} array_map SEC(".maps");
+
+static int cb(struct bpf_map *map, int *key, struct map_value *val)
+{
+	return 0;
+}
+
+SEC("tc")
+int tc_prog(void *ctx)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+	struct map_value *v, val = {};
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 0;
+	bpf_timer_init(&v->timer, &array_map, 0);
+	bpf_timer_set_callback(&v->timer, &cb);
+
+	tid = current->pid;
+	return bpf_map_update_elem(&array_map, &(int){0}, &val, 0);
+}
+
+SEC("fentry/bpf_prog_put")
+int fentry_prog(void *ctx)
+{
+	struct map_value val = {};
+
+	if (tid == bpf_get_current_task_btf()->pid)
+		bpf_map_update_elem(&array_map, &(int){0}, &val, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.38.1

