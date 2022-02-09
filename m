Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72CC4AE8F9
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiBIFOi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:14:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbiBIFLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:11:19 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780E3C03E929
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:11:23 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id i186so2429246pfe.0
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9pYzdqKxMBFjaKlNNJimqFBt4WhAe933I7W+F9ICkkM=;
        b=IDVPKcAhxzTD/QztrKhQKPcYZuYOa1CUVi5CmAuQuQD2pwFK1a1kEXzjlI11cmHDsY
         qlsdKz94fMp0kCJoIeeytWtUYjmgo/2tx/9IRutiBrNMpU66PK5v2VySRWVj2TSc3WEo
         v7CbDVL4MJEvPgwzgF1lYjHZzt30pA0fnSZxxWdPrF2ImDgz2tlRMGnUfd6Hg7kFqvz0
         5lihn0a6Gy0SGArXEwCSFKlUOc6HVBguWL6w6gEukTuoTlYiHdtQ7v1N92tKcWWS0sZI
         xkC2U3bxDll8CIs8o4zmnhSR7K5ZASb1pp5lqDONG6jYVPCA0MQXkp+b/Le5CGQ76W6A
         fHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pYzdqKxMBFjaKlNNJimqFBt4WhAe933I7W+F9ICkkM=;
        b=BXmAsjfcXRWUqUAFXzLmA8JH77OS/S9+5uKdGK0J1N8P9cLQVoPkDRkQcVQYm5rz3E
         ALOvHUnPk4+p7OQvTpkHIJMSnHcis+VH+5PJY8APJTgwgZ4RDKt0cyUv4oJCuyAD8Dww
         s+gaEnQQq3Q/bZB4rMkPx/On9W5hBlFbIC6H73old0mhXeunfMCD2vfWZEgjRkGJ7Oe8
         Nl7i1f6ztnnblWXeTjq65Vvi5hU6DalGFKG+fMAK57uABu5Pm3oiDYG1XFbppMDr9Wz8
         MambYlACuFSFwqwKzhPAUhw59SVl/G5kmzyxZ4JWzolTGXppr6BnBzMv9fs4r/9bKieC
         p3/A==
X-Gm-Message-State: AOAM531SnSYY5Ibucq+jDk0x9vbY9q8U5wuIO7JHYutoZehiNpnaH9Is
        7DWuxvRM+LQMteOgsthQyKYQWlToa9Q=
X-Google-Smtp-Source: ABdhPJxIIuGybq/jP1gkzzcBQc53lDbNPyVj8eXjF6XQ25CpivAeaSEsw6y3eN2Pn0jr7d/JLSxfbA==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr605693pgr.68.1644383482842;
        Tue, 08 Feb 2022 21:11:22 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id ls13sm4469382pjb.54.2022.02.08.21.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:11:22 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add test for bpf_timer overwriting crash
Date:   Wed,  9 Feb 2022 10:41:13 +0530
Message-Id: <20220209051113.870717-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209051113.870717-1-memxor@gmail.com>
References: <20220209051113.870717-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179; h=from:subject; bh=9Ga56XnyHi6s5lSnl1ftwn1HNMv8Ij6W/IUPo7yT6FQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiA0yOuzGM47JF4xZaon3cEIrE4J4qboaciIk2cvxE VjwT2XSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYgNMjgAKCRBM4MiGSL8Ryg7JEA CQfPL4/PiGfQxcpASkeG4Mzla8b+Tf4Qx8buMro9sJzikJDJ+vZhv8s9iFTD3MakwL0yMNHIJjaL4j Y9psrLnKMd4dxFKyGWHfqUfME0QyLYdV/6T6SKFgw/yCn/LnzpUGq4sMI2BrPsaTcz2q/JVqz1PQ1u m3jyL4bpxuRBbbOLMGdBcTahx5D5QIcdle7xWC1bUjFgRZ/soIKwaU0MHYU18le57i7PIqMqULngdv n7WsZmP40ObtIaLRnwZFMIfgdcCvWmGSvweO3RUoBrDuMiJ3hh4nZmj1COYxGWfWRDuGukoeewhICm 0BKY64ZkW3JwpPXvAsLLZe7SsRLgVW2AHmAN1zgbBAK/4i+Yi4FjvYYFgDW6GOaUpfSDusCgI67gjQ fMbbLJYOClCc6Yc2x5D72WBqqh1wPctJH8lqhtTQ4HyeYlnVNop0RzxyVNpQ87XRWW7OgrQ5eUQx9R leH0BfPEAptYOLnplM1PqCIIhaBn2NtDtRYP9d2Enuwz4ooThZKo8Ft+WCIwYaxNseoErEfnckSzVo 6TYsAvlx+QK27BPcWb5Yma17SUHqnaWa1wxkCtYqeqOxBkSOLBizgz81ItQrxFyuC5twUTVE5uwU+Q z8z29OJJ+p4CMjAErSE7BtRyY0DAoRN3vw+DEdOqC+Bs7ZJwHlkWyDADpXeQ==
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
 .../testing/selftests/bpf/progs/timer_crash.c | 55 +++++++++++++++++++
 2 files changed, 87 insertions(+)
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
index 000000000000..17da63692acc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_crash.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
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

