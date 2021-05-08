Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD45376F46
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhEHDuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhEHDuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14308C061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t21so6242279plo.2
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sTXESP1aSicDhTl1UsNmdxVoNAuNzTa1c5MFyG0wCi8=;
        b=Lwxu5lPsGhldyHfYS0BbETtP8YJNhBlg21PeqEzJ02IzFlDNKneCHVhFDewE06bpzf
         brPGYh+CDzuv+uarAwZqzyPtL87GO/cEEafaU1PRLR1wLQWzU6HBTuKHH6HcTpYdtV1C
         YHUeKrrGbBNY8lgOwFGaaasx28091cPpMalqoGPclvXqZ+WcrNNgEQR14Ao7IXbuUTpR
         tNxCkjFLSV7Rf2xZk8My9wkeogb993js7XF9A4Ozg1e7HMI2Gj1/QisISLEf0aeT920j
         ydTwGoVNtqRI7igWOUnsJeFPrHJ9FsgJSVrYthwfv4STzRJ1CxMKx0LkAPbv6PwtxEwl
         ux8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sTXESP1aSicDhTl1UsNmdxVoNAuNzTa1c5MFyG0wCi8=;
        b=lKcPOhiSVjkWO/uWXYGthWxOW9du78j2ZC4Wy18rYxstPye+YQ9MN+PrCcn6BVV7y3
         gDNFdhJyZHB78lRFZpVqovbr4Qb55v+J1vf4sOziThFxYpt+f+64K7Ap1xbz9dk2SOEG
         YYjHLdRkBTbOi8BLgi+TLPrJc9/1BED+6nZyLP9R+SbJSKCX8lqz3H1asqDGNheUXd9z
         wdz2CoGi/cnXvQet8U9tzB/fKmydypqFs3h4INKPtNeUM76yQ47AM16pJnwRP/zRlusZ
         W4N1l4g0mjEfnW4W6AjHOmY++y9/vlaujwevcEM58o0cH9o5Upy8iHS04lELMM1r+EJK
         Excg==
X-Gm-Message-State: AOAM531h0IlisoLczSVh+43hXOEK9KDdK1XO4gkpV2QvAdBm2iLdOpB8
        XGJSgnEa+P4RlqsBOvRW2BY=
X-Google-Smtp-Source: ABdhPJzueRBUuCiNJOTWU315bBhasntU/ifUfEXiDrso2x36ibZm9jKPU44Cr8voaByYuO/wDW52Sw==
X-Received: by 2002:a17:902:b104:b029:ee:beb3:ef0a with SMTP id q4-20020a170902b104b02900eebeb3ef0amr13430572plr.80.1620445759604;
        Fri, 07 May 2021 20:49:19 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:19 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 21/22] selftests/bpf: Convert test printk to use rodata.
Date:   Fri,  7 May 2021 20:48:36 -0700
Message-Id: <20210508034837.64585-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert test trace_printk to more aggressively validate and use rodata.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/trace_printk.c | 3 +++
 tools/testing/selftests/bpf/progs/trace_printk.c      | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index 39b0decb1bb2..60c2347a3181 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -21,6 +21,9 @@ void test_trace_printk(void)
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
 		return;
 
+	ASSERT_EQ(skel->rodata->sys_enter_fmt[0], 'T', "invalid printk fmt string");
+	skel->rodata->sys_enter_fmt[0] = 't';
+
 	err = trace_printk__load(skel);
 	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
index 8ca7f399b670..18c8baaf1143 100644
--- a/tools/testing/selftests/bpf/progs/trace_printk.c
+++ b/tools/testing/selftests/bpf/progs/trace_printk.c
@@ -10,10 +10,10 @@ char _license[] SEC("license") = "GPL";
 int trace_printk_ret = 0;
 int trace_printk_ran = 0;
 
-SEC("tp/raw_syscalls/sys_enter")
+SEC("fentry/__x64_sys_nanosleep")
 int sys_enter(void *ctx)
 {
-	static const char fmt[] = "testing,testing %d\n";
+	static const char fmt[] = "Testing,testing %d\n";
 
 	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
 					    ++trace_printk_ran);
-- 
2.30.2

