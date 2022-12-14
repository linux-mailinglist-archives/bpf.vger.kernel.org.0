Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D482F64C745
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 11:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiLNKjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 05:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNKjK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 05:39:10 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A823167
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:39:09 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n3so4124710pfq.10
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K76DX5yd8zONl0RgJwbWgYfbrXc3KM7LvVM3PASB6IM=;
        b=OWqg4eIZImiLxm7wT/VIZfM/o96H5WlPAlTqPn6uM9p3NqorJK6aiwIw6Cfu/0jqUT
         ivyjYGeaho2sNiT1zDgfQ3XcDnwFAmM5jkN6XCizGwymwVkT9QQ9Y8QA2KqYI2h5WSvp
         ikBdnW7IBqvoc1W2wfXw9CNI3bpH7uReD4Rd9Y+1H/VGeJzHi5dm9rk7cC+6hu+y7So2
         TT+dylmWE5xLG8547+47xq0Qkn9wm1mVcs1C0mmBq9xONKfi6ztOkm3/HsV4RjbQMyET
         surKsV7QVDmG6LCZoxYaSb5Sg70FbpnPee3f+DD7WO4BWPMi2OfYhpHScHMTBmRROoaU
         5RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K76DX5yd8zONl0RgJwbWgYfbrXc3KM7LvVM3PASB6IM=;
        b=FQjtsv2TIzU5VEl1+zKXjt2Y9oA7BN2gp5OVLTGAOpJotMF9nfqYSDF/gMkZQQEewp
         7T9Mhxx523vQk6w3s9cZqLxq3tdjOugP3v8R6gPTCfB4cJUnXFZgYrGXs+82aVtQEULT
         3OFf3SD6omuIsYHYIqWStSLVnfOPH50lDNKVXQufJF7yfPq83yLM7W6YPhQISbyVHwjU
         q+9E6827I+exEQtp79Toxhb1ElfMUsQsu3bcDqsQEWIiCTr92dk0h7wBywRqvswwNeom
         zcihdAQwgJLiwPcXhHnc8SjCs4Ya6dtQ3EakRq93N32Ovaf9j7eii4VnXexvihVcqFZV
         4ngA==
X-Gm-Message-State: ANoB5pm5cmZARmu+V46aPWBDw81EHppMmgk66R50wgI0Wip+8woebnT/
        Ha5DD6fz4UJkVUBSq+wsk0uSUqCrOJY9uQH/
X-Google-Smtp-Source: AA0mqf6ChMimmKNN262h/x9hVuRFnLA4dUcaGPHyg0KH6ST6ZA4npkpwUyc7BFABs+fr/pFJL728CQ==
X-Received: by 2002:a62:87cc:0:b0:576:dc40:6db9 with SMTP id i195-20020a6287cc000000b00576dc406db9mr24820340pfe.13.1671014348482;
        Wed, 14 Dec 2022 02:39:08 -0800 (PST)
Received: from localhost.localdomain ([111.201.145.40])
        by smtp.gmail.com with ESMTPSA id o76-20020a62cd4f000000b005751f455e0esm9177272pfg.120.2022.12.14.02.39.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 02:39:07 -0800 (PST)
From:   xiangxia.m.yue@gmail.com
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [bpf-next 2/2] selftests/bpf: add test cases for htab map
Date:   Wed, 14 Dec 2022 18:38:57 +0800
Message-Id: <20221214103857.69082-2-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
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

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

This testing show how to reproduce deadlock in special case.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/htab_deadlock.c  | 74 +++++++++++++++++++
 .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
new file mode 100644
index 000000000000..7dce4c2fe4f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 DiDi Global Inc. */
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <test_progs.h>
+
+#include "htab_deadlock.skel.h"
+
+static int perf_event_open(void)
+{
+	struct perf_event_attr attr = {0};
+	int pfd;
+
+	/* create perf event */
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_HARDWARE;
+	attr.config = PERF_COUNT_HW_CPU_CYCLES;
+	attr.freq = 1;
+	attr.sample_freq = 1000;
+	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+
+	return pfd >= 0 ? pfd : -errno;
+}
+
+void test_htab_deadlock(void)
+{
+	unsigned int val = 0, key = 20;
+	struct bpf_link *link = NULL;
+	struct htab_deadlock *skel;
+	cpu_set_t cpus;
+	int err;
+	int pfd;
+	int i;
+
+	skel = htab_deadlock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = htab_deadlock__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto clean_skel;
+
+	/* NMI events. */
+	pfd = perf_event_open();
+	if (pfd < 0) {
+		if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
+			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
+			test__skip();
+			goto clean_skel;
+		}
+		if (!ASSERT_GE(pfd, 0, "perf_event_open"))
+			goto clean_skel;
+	}
+
+	link = bpf_program__attach_perf_event(skel->progs.bpf_perf_event, pfd);
+	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
+		goto clean_pfd;
+
+	/* Pinned on CPU 0 */
+	CPU_ZERO(&cpus);
+	CPU_SET(0, &cpus);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
+
+	for (i = 0; i < 100000; i++)
+		bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
+				    &key, &val, BPF_ANY);
+
+	bpf_link__destroy(link);
+clean_pfd:
+	close(pfd);
+clean_skel:
+	htab_deadlock__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
new file mode 100644
index 000000000000..c4bd1567f882
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 DiDi Global Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 2);
+	__uint(map_flags, BPF_F_ZERO_SEED);
+	__uint(key_size, sizeof(unsigned int));
+	__uint(value_size, sizeof(unsigned int));
+} htab SEC(".maps");
+
+SEC("fentry/nmi_handle")
+int bpf_nmi_handle(struct pt_regs *regs)
+{
+	unsigned int val = 0, key = 4;
+
+	bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
+	return 0;
+}
+
+SEC("perf_event")
+int bpf_perf_event(struct pt_regs *regs)
+{
+	return 0;
+}
-- 
2.27.0

