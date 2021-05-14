Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B738013D
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhENAiO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhENAiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E04C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:37:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c13so9754119pfv.4
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PR2b0a52BQqIy8iVMO7dMDyuf8baOb2zB8M3+Lt1dIg=;
        b=sKhFQ8HKJ+FyxvxM72vG2UNXfKoQz4pCef2eiC149wWOWDxE+d8BNRgQu60ol1xbUQ
         kUrutdZXYt5LmvLTvYEOXWVKwOtyWUdLsHP1JQrdcHasa0A8QSmOeNa020bw5YVer82X
         4JbdjmgRaZ4ulLFdH5FtJQP8eo4gxocUHnX8YMEUrQPRWM9CYoV6CMww+hml3PFdufBa
         f9UJa5ZupqfG3fGpsR4Li3PSZFWnJB1kfr8+dkjFXJYkmGsmYBzcqnNmlWtYlVri6TmY
         DwPEItvUgz86NQ3PTDvwwBmyWtjbCM48QZ2bAkZdywLl7NHzns9h1zZpqfRwCQfhwyhD
         ATPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PR2b0a52BQqIy8iVMO7dMDyuf8baOb2zB8M3+Lt1dIg=;
        b=JlrMkypwDv4KP4ToqlZ82TCmDWnEdu4PbXxcwDdBJkiei+l9xBMfCuTVCPduG4lEV3
         nWRxmnK13yOSmZH7gkarrl/tvhCpX8g1Pqd1tPTxM9/vngyrXYP5d1JUZW9du3rhtKha
         HhkLBwv9u/x1AlfTKWBMIaGp0i3kUL3MhDNziuZ9A+iP1LbmTDp01oJ5MPHt54O2Skw5
         rtIOJVqxjc8R27L//2/mFuJ1CpsP1LvD3+CCgBNlxbsgBaa3wPMsd5QqbCsC1nKNEL0H
         onSNvz5turQGkaHJrTzUbNi4+Y9cKeUQmdnBaZdK1my/5bZv56Q3mNJ7T+s0obU3HnHa
         Lm/g==
X-Gm-Message-State: AOAM532NfEGfUbW3wowJyYUjJtESu7DXpR0ui9IU/u0mPqbAarJnUdff
        Wf3/OJLbsiAVg/gWoYN7ekw=
X-Google-Smtp-Source: ABdhPJwHGXLiAtZC5mVOfGgwSUc4LYex5iAsitsLaICX+33PumwqGgr94tV2WOqQATx5IzSaCKG64w==
X-Received: by 2002:a65:644d:: with SMTP id s13mr42966539pgv.362.1620952622943;
        Thu, 13 May 2021 17:37:02 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.37.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:37:02 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 20/21] selftests/bpf: Convert test printk to use rodata.
Date:   Thu, 13 May 2021 17:36:22 -0700
Message-Id: <20210514003623.28033-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
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

