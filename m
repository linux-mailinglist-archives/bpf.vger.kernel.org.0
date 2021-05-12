Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73037EF47
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbhELXDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347113AbhELVpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:45:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F73C08C5E0
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x188so19693319pfd.7
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PR2b0a52BQqIy8iVMO7dMDyuf8baOb2zB8M3+Lt1dIg=;
        b=GXCaSsayzUb1G7q4jTGhCuJK6CpTSQ2WeBHK24a8Xp52OQZmy02cDL/NLYphkyMhGX
         JXPkBKbPaoP2DEdRLEjBh3yScm20aYp/QIGGGH+DLi5G+3S8b0AxsY4Ydqjju87TozGR
         YdxRv8fE0yca7ki+s9PTsN4gLZAIXddIyKT/leQKX/zrg1R1nY6f9OPWZfNdmGVWimzB
         wksrSfj9pxq/IS4ay7ACO9rHKcbGqn6aKj4ZtWMG4XMFR3jSak7mUnDhcDk33mRLPSw2
         /JCdSBugHW+L1yz2RpV+mjYn5fHryJpuLDV/HxtTWhy5/Fk4tzQLlHnWfrY+cm83yKYb
         5j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PR2b0a52BQqIy8iVMO7dMDyuf8baOb2zB8M3+Lt1dIg=;
        b=UYTUWXBBrN+ZWXqFIoZPxO8DCq1VMB/BHYWwkr8mTRb7ZyZ9M92Bx3NnAPEgdGjPJf
         I2U4L17TE8O1SnYXTrUWiMdVecXm+QvJIFJh/i24OlyYwwwDjyS4j7eMoxzwc91MBuPs
         PXLtUAzWGlN3ofD87et70H5sHE1GWYDcr58ni033ySqcDh3Kf9De3cA05h6bgNapf4SJ
         AffOlNVi6ODS8CXRmOWKV5P6mmJULes24TIGillmeW6x684lxEMnMwjmPLmakbSbfe1p
         sxu52XdOEztVr8PWs087+iy8Ka2rFsL32hsWoNNI5LkPzn7ZzTwapjyd39nJmJuk2OIq
         gB0Q==
X-Gm-Message-State: AOAM530XKaAH1qi31npz4yvipyezQz2SvGrToqYobMk0J0gAteW+uOTL
        vRmPlT3Mr73NGB1sNG7dH/LhXoE2cLc=
X-Google-Smtp-Source: ABdhPJyGT2OXBAR6j2F1c617cxCB4IFR7UaWqVmq212yvBOJMs3up/7L8tjBhE7nK+3m1pYM6o8N0Q==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr40304821pjo.45.1620855217405;
        Wed, 12 May 2021 14:33:37 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:36 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 20/21] selftests/bpf: Convert test printk to use rodata.
Date:   Wed, 12 May 2021 14:32:55 -0700
Message-Id: <20210512213256.31203-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert test trace_printk to more aggressively validate and use rodata.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/trace_printk.c | 3 +++
 tools/testing/selftests/bpf/progs/trace_printk.c      | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index 39b0decb1bb2..2c641bdf21ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -21,6 +21,9 @@ void test_trace_printk(void)
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
 		return;
 
+	ASSERT_EQ(skel->rodata->fmt[0], 'T', "invalid printk fmt string");
+	skel->rodata->fmt[0] = 't';
+
 	err = trace_printk__load(skel);
 	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
index 8ca7f399b670..119582aa105a 100644
--- a/tools/testing/selftests/bpf/progs/trace_printk.c
+++ b/tools/testing/selftests/bpf/progs/trace_printk.c
@@ -10,11 +10,11 @@ char _license[] SEC("license") = "GPL";
 int trace_printk_ret = 0;
 int trace_printk_ran = 0;
 
-SEC("tp/raw_syscalls/sys_enter")
+const char fmt[] = "Testing,testing %d\n";
+
+SEC("fentry/__x64_sys_nanosleep")
 int sys_enter(void *ctx)
 {
-	static const char fmt[] = "testing,testing %d\n";
-
 	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
 					    ++trace_printk_ran);
 	return 0;
-- 
2.30.2

