Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B171F58B348
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 03:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiHFBqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 21:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbiHFBqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 21:46:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BADA7D1D6
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 18:46:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q1-20020a05600c040100b003a52db97fffso10935wmb.4
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ECGSaTgdkaqWm0uNfIEIEUHX8PmoDnbtgkNMqIvQ82k=;
        b=YkRQKWi/cnYEvryIlcAtqdHYmX4ey3mxl55Eizv2KljdI0OvKDypqisLPNbR/+NDiX
         kfdW2X1kDta0IEvjafujZgjbo+87lu9Z0c9c77aUlRdxy8v2McTchyv15BZHNl+xsU/f
         vU26jIU2kap2YwPbfJbuvoI1zF2qkVodAB16LF9R9VY5pmsLyAOnCuCGggS8tNgl9oF7
         hEr2DROEf2aRdOLa0JBj2GGNnxOktwvT8l15vtrfw0K+sUnekKJ02XwU/TqWNvAQsV5V
         eTYa5u5kiOthXy94h604HW/2ZrVCFPQYtQU0pGCVcWANgLhf5mloacqE32upvy/azasC
         ixUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ECGSaTgdkaqWm0uNfIEIEUHX8PmoDnbtgkNMqIvQ82k=;
        b=vh89FX3KNTLfYdQS9fLDLufTS5Si/F7HAn8DF0AfJPVf4E33QOI7K0S+Sshlqs6LOj
         PUOS00KSGgR/y7HKM3LhjVu2+LcByZciqX+hOU9h18Z1JY6f3SXE+pwkJHwiZ3ej1Lu4
         KmXyxurMd0ztFGdZYlYqspKa+Fq98dF2DI+9qCFF5ht6LgadvWPWQz6KsLIPk07UnsJg
         S8T/NGMsr5XZRUGtXdqS2m7TbqH+Ou5OVE4f9YasBWQSjhYFeijfFdNfcJSVf98REUzG
         ZCjyIFcLSleqH4aRvYwb/5nmudf4j5PB2ycaYxxHPTklxKW2duZEjVeksv3Tya2nUOZ7
         qTUg==
X-Gm-Message-State: ACgBeo14I5npzEsHlyTz6aGovMsN0lmv45BJwPOMdWISIKreZgB5Xk/U
        x8LZ/i3ucI8yAX0E4AbWTCG8+uTUJjQ=
X-Google-Smtp-Source: AA6agR6Fp7kLhCnGoFfxe1HuGsgpWMq5KNtjjNS+j4CxrdnSj9kM233xIOziM8LCDhjEyZmdcJhj5A==
X-Received: by 2002:a05:600c:600b:b0:3a3:1176:222d with SMTP id az11-20020a05600c600b00b003a31176222dmr11163459wmb.42.1659750370489;
        Fri, 05 Aug 2022 18:46:10 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003a310fe1d75sm11415374wmb.38.2022.08.05.18.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 18:46:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 3/3] selftests/bpf: Add test for prealloc_lru_pop bug
Date:   Sat,  6 Aug 2022 03:46:03 +0200
Message-Id: <20220806014603.1771-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220806014603.1771-1-memxor@gmail.com>
References: <20220806014603.1771-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3825; i=memxor@gmail.com; h=from:subject; bh=zeGSwjWtHio40G3TFLoDUuQVwlnGocO8Eea83IKS9MQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi7cfJDwl0AI4eVRFWWpDCFGu3JTc0hJiLFjjp3jpn oohIfhWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYu3HyQAKCRBM4MiGSL8RyghBEA CU9WsTbRccnLMBcgTFSvhnEBTRQvMVfwK1zLverQMKPhipsfIqEEGQZLQ5xFooYEK3ebRluqsy6mXt 04QofJ5zLvWt9KXEQ7TE9OzkEFvPJ1+vS2yK4MxORAov8ijFYUd7rYl4oLhtEYUPQhYC2O8o5EDYFs ubM7sK98L7n0mhikQEX2OfXDVpD5hlb/C8tigN9Q0zAzLjLFe8Zyr2uMb+fJLHyPshEhadq/djr9J2 LlItuX7KtwiEM+wWaZxlWXrGonIVf6PfU79+BfHtNeP+VHTmyPnV5hNMZFX0bUuUGz2RXBZd4USQe0 SacrX2bTnydygecRjpP+Txbw1C2h5Xm9fHUd3Hnm4QCIgLHHXixgyROtzbiqGSPRkh2drjmFoZfkyk /mOqa6mmbTL7qo5z38S3q0fgmfSp91umL01qtME7en/aroPyoh2RFQ10P44CpDcO5ko86yUvlF5P2j GbMVoXp9CqEikV8j3GRA8m7zvvhyv+73k0H9AaFXvwbae+BVwcubZBpkEn17n+z9A98ppld2xnXDkE neGXPOh1m1OHsEWKz9A8sGyaq0joXLw69G+eq79suafthz1DePyr8YKDCzWG/Tc7Cnff15qQpiPKC1 wuLwL49m9/Mn8huZ/8IphlmbzUpPI+nm1M9RbuErNKbMHm7II4ntCGh4hsDg==
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

Add a regression test to check against invalid check_and_init_map_value
call inside prealloc_lru_pop.

To actually observe a kind of problem this can cause, set debug to 1
when running the test locally without the fix. Then, just observe the
refcount which keeps increasing on each run of the test. With timers or
spin locks, it would cause unpredictable results when racing.

...

bash-5.1# ./test_progs -t lru_bug
      test_progs-192     [000] d..21   354.838821: bpf_trace_printk: ref: 4
      test_progs-192     [000] d..21   354.842824: bpf_trace_printk: ref: 5
bash-5.1# ./test_pogs -t lru_bug
      test_progs-193     [000] d..21   356.722813: bpf_trace_printk: ref: 5
      test_progs-193     [000] d..21   356.727071: bpf_trace_printk: ref: 6

... and so on.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/lru_bug.c        | 19 ++++++
 tools/testing/selftests/bpf/progs/lru_bug.c   | 67 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
 create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lru_bug.c b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
new file mode 100644
index 000000000000..e77b2d9469cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "lru_bug.skel.h"
+
+void test_lru_bug(void)
+{
+	struct lru_bug *skel;
+	int ret;
+
+	skel = lru_bug__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "lru_bug__open_and_load"))
+		return;
+	ret = lru_bug__attach(skel);
+	if (!ASSERT_OK(ret, "lru_bug__attach"))
+		return;
+	usleep(1);
+	ASSERT_OK(skel->data->result, "prealloc_lru_pop doesn't call check_and_init_map_value");
+}
diff --git a/tools/testing/selftests/bpf/progs/lru_bug.c b/tools/testing/selftests/bpf/progs/lru_bug.c
new file mode 100644
index 000000000000..35cbbe7aba9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lru_bug.c
@@ -0,0 +1,67 @@
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
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct map_value);
+} lru_map SEC(".maps");
+
+extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *s) __ksym;
+
+int pid = 0;
+const volatile int debug = 0;
+int result = 1;
+
+SEC("fentry/bpf_ktime_get_ns")
+int printk(void *ctx)
+{
+	struct map_value v = {};
+
+	if (pid == bpf_get_current_task_btf()->pid)
+		bpf_map_update_elem(&lru_map, &(int){0}, &v, 0);
+	return 0;
+}
+
+SEC("fentry/do_nanosleep")
+int nanosleep(void *ctx)
+{
+	struct map_value val = {}, *v;
+	struct prog_test_ref_kfunc *s;
+	unsigned long l = 0;
+
+	bpf_map_update_elem(&lru_map, &(int){0}, &val, 0);
+	v = bpf_map_lookup_elem(&lru_map, &(int){0});
+	if (!v)
+		return 0;
+	bpf_map_delete_elem(&lru_map, &(int){0});
+	s = bpf_kfunc_call_test_acquire(&l);
+	if (!s)
+		return 0;
+	if (debug)
+		bpf_printk("ref: %d\n", s->cnt.refs.counter);
+	s = bpf_kptr_xchg(&v->ptr, s);
+	if (s)
+		bpf_kfunc_call_test_release(s);
+	pid = bpf_get_current_task_btf()->pid;
+	bpf_ktime_get_ns();
+	if (debug) {
+		s = bpf_kfunc_call_test_acquire(&l);
+		if (!s)
+			return 0;
+		bpf_printk("ref: %d\n", s->cnt.refs.counter);
+		bpf_kfunc_call_test_release(s);
+	}
+	result = !v->ptr;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

