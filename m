Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34774457AD7
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhKTDgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhKTDgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AFDC061748
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:34 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f65so599079pgc.0
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7KzuwnCUhpcaHT5E71hexPtaPtrO1p65nBAcRe6VKg=;
        b=q1doZ4vI9VLxNLDrpXOSL1ANpPWBEg89CNjWRdzOkBLxq8+uu4pgqsrxNMkrFmPKT0
         s3Qk2K+BLaQ2dXVDbUFVeqmtdNu0Urg1EoQHruZoQOMb64eUgoD0AUM9OIpYVu+8AXBO
         TIqP0Bjy8hOKbGDO/qgDVd5CG2M8e53QFXsQcOtodYjDBmbkydSLB8mmgwv66Cmr6yvc
         1DGyXiU+n5ZqX+D0Cn84RIcQ0rUnIVr1S5/ai69MR9X/HSN6l5KPAD/VMfME+jUaJTlk
         F08AFoDh45PfvSEr+mb1DaC3oCK39k8NPNP05HMWOVyHyJ3w5XCLVchMIgWL3y0HTJ8N
         mpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7KzuwnCUhpcaHT5E71hexPtaPtrO1p65nBAcRe6VKg=;
        b=NBD3JrXczt8eKg+4MWOXZXC80ImDqOIYlZV49DAx+ijpWDWq1+Afg8xdkr24LckWLK
         41YLqY0xKVtn3pPYDlpWV65yaIXEBPLwLE1xu7izPUZp6ZGRxHb6lCAfxBI5vGlFBGCz
         //kvrUwUO5019PY+UjWBLir/J1TANEZ5hWvmg9ZxqX3Iq8phpsRVS9kTvu9OhWPPrSSw
         aGxbSBubxM4X2VCP/sOSxa2xEuKBCZQONtw4QWeHkq0fHku4V2Rx9hDx5y6DB/M+toTl
         zjYzpj5goRgGxZ1oi20RMawWAJW7pklYYdohXr5FOjtEJt1Bf3Z5ETVxMjHgIcCc4e7Z
         P6JQ==
X-Gm-Message-State: AOAM533KTKVkP8XXJGD/Bi4v6UBx/Yu7eZ/UE3MpKOF9NaZ0lT/nw84Y
        bbs3Cyey0twGeYpGoHVbq/8=
X-Google-Smtp-Source: ABdhPJwb/bUH4qnvJyJe6zL9GU9MhLMO78XAu48JVrEOrojVpkiLTbGMigBIUv8akjsjUaM/XvgkRw==
X-Received: by 2002:a65:670d:: with SMTP id u13mr20341241pgf.251.1637379214236;
        Fri, 19 Nov 2021 19:33:34 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id v1sm959829pfg.169.2021.11.19.19.33.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:33 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 13/13] selftest/bpf: Revert CO-RE removal in test_ksyms_weak.
Date:   Fri, 19 Nov 2021 19:32:55 -0800
Message-Id: <20211120033255.91214-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The commit 087cba799ced ("selftests/bpf: Add weak/typeless ksym test for light skeleton")
added test_ksyms_weak to light skeleton testing, but remove CO-RE access.
Revert that part of commit, since light skeleton can use CO-RE in the kernel.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/ksyms_btf.c  | 4 ++--
 tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index 79f6bd1e50d6..988f5db3e342 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -101,7 +101,7 @@ static void test_weak_syms(void)
 	usleep(1);
 
 	data = skel->data;
-	ASSERT_EQ(data->out__existing_typed, 0, "existing typed ksym");
+	ASSERT_GE(data->out__existing_typed, 0, "existing typed ksym");
 	ASSERT_NEQ(data->out__existing_typeless, -1, "existing typeless ksym");
 	ASSERT_EQ(data->out__non_existent_typeless, 0, "nonexistent typeless ksym");
 	ASSERT_EQ(data->out__non_existent_typed, 0, "nonexistent typed ksym");
@@ -128,7 +128,7 @@ static void test_weak_syms_lskel(void)
 	usleep(1);
 
 	data = skel->data;
-	ASSERT_EQ(data->out__existing_typed, 0, "existing typed ksym");
+	ASSERT_GE(data->out__existing_typed, 0, "existing typed ksym");
 	ASSERT_NEQ(data->out__existing_typeless, -1, "existing typeless ksym");
 	ASSERT_EQ(data->out__non_existent_typeless, 0, "nonexistent typeless ksym");
 	ASSERT_EQ(data->out__non_existent_typed, 0, "nonexistent typed ksym");
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
index 8eadbd4caf7a..5f8379aadb29 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
@@ -38,7 +38,7 @@ int pass_handler(const void *ctx)
 	/* tests existing symbols. */
 	rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, 0);
 	if (rq)
-		out__existing_typed = 0;
+		out__existing_typed = rq->cpu;
 	out__existing_typeless = (__u64)&bpf_prog_active;
 
 	/* tests non-existent symbols. */
-- 
2.30.2

