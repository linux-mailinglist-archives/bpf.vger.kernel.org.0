Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E355058DA11
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiHIOGZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiHIOGY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 10:06:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689AF12AA0
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 07:06:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gb36so22370463ejc.10
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hozDVgPy8QWYlTQ7UZ/7+H0dh30QoGjEpAJquPO+JZ4=;
        b=e3j0ZQ+ag+AMltKNNrQ/CQRZWCDTEQOjuaDa2tmPZ79yXm/vqhzjZu+pfI5LNxApDN
         kBvDDLeAu3NrtO45HiggS5T6wJsnWAZ+DyaAiYmTuAsU3vO3h3a6rFfZWWntKfaf+nA/
         eoVkfZ9KWxRUNW9bEQRTpiN0uE0hFB26wZ8GV2ckesHsKGVCS6N9nuO24c8slhu/0DgW
         Mh4E3KdvsnNXzaEVEjquRd4U67e+oMqdi6U0CGB0DHPFv5Azz7XyiGV4UWEl7eh5r5H1
         s2eP/RxpcIqzJ3+iMGD+RfEbd6dVzcudzOA5DfXLonN746EGjwJydHG8jwF4Q86xmNo6
         GDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hozDVgPy8QWYlTQ7UZ/7+H0dh30QoGjEpAJquPO+JZ4=;
        b=K9LeehvwqzrUBj8WatJCWIZDeidKzYbEq/oGQ62pYkI92Um0rabzq/9pxtBruQJuVW
         8CULsPjZr1kHhuBRraAuoM7u7e9D6R8dX0K4FaAzeB4rquDLdc3UECLRUhd0KQAfGGpC
         gyG/sa3ZTk/0iB3eqLK5dfSTz2h0c7XDfS/Coh29hRrRrc+UuhmNtlsTq9jEWElog5vz
         k8FQ3MM6EZhnSp1K9ErkFoq+letxIFrzjYuMDUAuvhVVMgBP9GmamWEcMyYelseXu0u0
         iNrfapds0BsmRASFeDyUFyNSppp6fMbymwgKu+MiLH/bL2/HIfEt2uYCZWLBRn5pjwNB
         2OMg==
X-Gm-Message-State: ACgBeo1nFVv4eQxiLCeZPkC1zcs0//wEbeZsPjR+nPtAvqYwvtqAr8NC
        XwZdlPIARxH4Ggpc9lF5I9cpTCuF0Cw=
X-Google-Smtp-Source: AA6agR5XSL/ZBCpPa/yrYsIgtXw5bSmv+eiTjnEjBKYdAcy2szLGHHvwi3SHvYVstkfQ2G6HFew2iw==
X-Received: by 2002:a17:907:7da0:b0:730:fe97:f899 with SMTP id oz32-20020a1709077da000b00730fe97f899mr13452356ejc.369.1660053981659;
        Tue, 09 Aug 2022 07:06:21 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b007306d3c338dsm1142063eju.164.2022.08.09.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:06:21 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add test for prealloc_lru_pop bug
Date:   Tue,  9 Aug 2022 16:06:15 +0200
Message-Id: <20220809140615.21231-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809140615.21231-1-memxor@gmail.com>
References: <20220809140615.21231-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833; i=memxor@gmail.com; h=from:subject; bh=71elzRDUndAzlbRAtCfV0ECuaJIfFlmh3einmVZskBw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8mm89pTepD2nlFZJOliggVjwSKPZ6RJxzpViobXv +sFBWCKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvJpvAAKCRBM4MiGSL8RyqCuD/ 4gX46laHKOIEX5nuoGQylQcD/Sd7ObPgCQr/QOeyrzz8DP3LTpwhPJj5Fnpkzb21Ttpmtcy+Zvu7s0 9gXq3GeofJdn7YBU0T9fo8xq6Q8bqNgyqoXZ9LY4qAfcROWxujRK1lJPFNeFvt1oL+AhMjEUHfvEsi QI/oAViHnlf6a7hDJp50zT3MHEnghXYSMC8GNacWUOMP9+myHSK1ZH0McuNV70E6nkLQJHVFlGNkJi hmq4GgyeIYjosfCv9MTrRsLDtLbUEhVcLc/Q7SaQ0HUUt69KKRY1bn0wOOnVOUJ+EWGqDAhznflMb8 /oj/8Q9RhxO82g780ML5ljIbl78EBjJBcpx6E0aktXmxpUQi13oC3O9Qbybj6/zxewlzpDz3z8DwBU nGsZpfOS25K+mWhDScl+VPtvfJGKdbF/hkoYiCT+rt9Cm1sku9lcZNoZkfX+Qu9ar9B89o5001D2wz eqrhMrGjT2jqSLvoZNONa4T/MytrlwCDADQpCETVtGjCsWqocEWpTOCumVYYnvqotwPCyihp1J9eA7 ayIiPdNNORgwjN6xhxFm8Gx6wpa5aM+7VUos3WH4Uuve2vxkwhxR3G4/mmtP3dt7G4oDpTuCqaxRsj wO1SH6qZEFKexHh5p8F0S9MBkntIJnKUlcXLi06OgUvnMLq5md3RO9A3G7DA==
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
bash-5.1# ./test_progs -t lru_bug
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
index 000000000000..3bcb5bc62d5a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "lru_bug.skel.h"
+
+void serial_test_lru_bug(void)
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

