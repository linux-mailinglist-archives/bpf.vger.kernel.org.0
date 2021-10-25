Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7343A805
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhJYXPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhJYXPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 19:15:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2BBC061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:07 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b6-20020a631b46000000b0029a054d00f3so6942261pgm.17
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r3ezkXqwfg4lQ3I8OPwkNyvqCHNsjE/QJmJWEIQdqaA=;
        b=obrw6ngjZLOY87g7X0uaSepQC+CnmU2ojBNlZ9BMSzWIzpTqXZdC8guYH5idPNjuOK
         Icf8ntqsncB414CHX/HQiKdPpVqr2I7NdfVlpbMeiQv+c/nr1uPCvjKok+nkiw3xJuyA
         cB/BpoVo239+yG1rjX5fsFaZFpNWZTAtGE1qmgqMSjalvt69vWFvBWQUuJjkH+SfkMx0
         BDbGi7M/h7QlB6VpGggh/9YhFtccBPs1Nm0gq0zlPi73T8yyInUhXReF5bgQBMMmGczp
         SI70EUPtbUCMDJSbOYXtWMtkOP+473xvWR1lSPdngzcuwM9DMPkNj+srGxq9K/YNuUjB
         deJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r3ezkXqwfg4lQ3I8OPwkNyvqCHNsjE/QJmJWEIQdqaA=;
        b=e2VWbCasVBvIGQLlg3e0EGDDUMkEzzqdc72QQjYvl4DEhG8jyb0z8oghaXUZXTL2ZZ
         7WTCeuffeOdU1FLrBBB5kMgU3CCGC/0fZGOdRsNxrwfCBKZAEIpLDPrRS9lQqylgRNgr
         yO8inAcoKUHbH9594NSw5QrQQq3kXaUHlNvinqNyfbc5s18kJnKQ37f9nuJ9/afWd6Me
         IOkJGUBkK+CwRd3SDz43RrgyeQNqp17fVuqlwB/IT49ag7lmV9c5FrbElp38bLgCokpw
         6ae8P7pHJ+OmXh725rnvX4kNyskDsYrjAsoZTlVEnAtJjfPHoI01SFfalnYILCBOngpJ
         Xs4A==
X-Gm-Message-State: AOAM532ajBhkWVAph7gib+gLFpliDuNn4prQBloBWLatJIxrqq2i/xlP
        39zicC5XcFh2c8Ov9a5frQ86Bcf+I2M=
X-Google-Smtp-Source: ABdhPJwUgcwCje+5A4YtyxI1l73zvMNJD+6C07kc5BgsrzKassry+rlAOJ2osgk6F8QKJYY2zXBgbVaJE0Q=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:b4ab:b78c:418f:ca5c])
 (user=haoluo job=sendgmr) by 2002:a17:90a:d510:: with SMTP id
 t16mr24649541pju.55.1635203587275; Mon, 25 Oct 2021 16:13:07 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:12:56 -0700
In-Reply-To: <20211025231256.4030142-1-haoluo@google.com>
Message-Id: <20211025231256.4030142-4-haoluo@google.com>
Mime-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next v2 3/3] bpf/selftests: Test PTR_TO_RDONLY_MEM
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test verifies that a ksym of non-struct can not be directly
updated.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 Changes since v1:
  - Replaced CHECK() with ASSERT_ERR_PTR()
  - Commented in the test for the reason of verification failure.

 .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 +++++++++
 .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index cf3acfa5a91d..69455fe90ac3 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -7,6 +7,7 @@
 #include "test_ksyms_btf.skel.h"
 #include "test_ksyms_btf_null_check.skel.h"
 #include "test_ksyms_weak.skel.h"
+#include "test_ksyms_btf_write_check.skel.h"
 
 static int duration;
 
@@ -109,6 +110,16 @@ static void test_weak_syms(void)
 	test_ksyms_weak__destroy(skel);
 }
 
+static void test_write_check(void)
+{
+	struct test_ksyms_btf_write_check *skel;
+
+	skel = test_ksyms_btf_write_check__open_and_load();
+	ASSERT_ERR_PTR(skel, "unexpected load of a prog writing to ksym memory\n");
+
+	test_ksyms_btf_write_check__destroy(skel);
+}
+
 void test_ksyms_btf(void)
 {
 	int percpu_datasec;
@@ -136,4 +147,7 @@ void test_ksyms_btf(void)
 
 	if (test__start_subtest("weak_ksyms"))
 		test_weak_syms();
+
+	if (test__start_subtest("write_check"))
+		test_write_check();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
new file mode 100644
index 000000000000..2180c41cd890
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+
+extern const int bpf_prog_active __ksym; /* int type global var. */
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	int *active;
+	__u32 cpu;
+
+	cpu = bpf_get_smp_processor_id();
+	active = (int *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
+	if (active) {
+		/* Kernel memory obtained from bpf_{per,this}_cpu_ptr
+		 * is read-only, should _not_ pass verification.
+		 */
+		/* WRITE_ONCE */
+		*(volatile int *)active = -1;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.33.0.1079.g6e70778dc9-goog

