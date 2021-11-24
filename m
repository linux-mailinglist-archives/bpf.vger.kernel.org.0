Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506E245B427
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhKXGGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhKXGGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:06:03 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB43C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b11so947441pld.12
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIi8s5XGIUokbgHYRYNlQaxnDLZTghamDXqG7hIZzX0=;
        b=Zm4Jnssoxkf8rqeqzjmN5RSedr8fZ9Q7TeIK1cBLl/coZfnCfjsV+0RLhSIh2HdkU1
         ZoVwfTozicZNBM/2xA3aPcfjJ5xhQC+4CWTm3G6XO+mA6Z/1ji5uDvyuSacKSYg8Er+/
         Jdr/jZOswYvZA2wBcAJ89hJLSORIipFbvuMV7iKtDaA4u+W4bfgbyQtyp0yITMUVKvAo
         1FxW0shTeVVJZ/VaZKuODbS8Z6xb/dH55lbTLfFy9AepJNtzYgF34x1teImxm+r+CNtl
         7eaNJWyTjITilYG/2O3t0IvPCvOxwyxuYUdymDNsaKkwto0bZcNIaCz0KwRnuxhq+IKS
         l//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIi8s5XGIUokbgHYRYNlQaxnDLZTghamDXqG7hIZzX0=;
        b=zCbInXCclANm8f30dOvaJDTx4Vx0BXbpWqPi5BUzrE4yZnFGLNp+4S5ru84rA0zb3/
         I67u6Ej0KZunW66iW0+wMoTt+6yvAewQP1elpDUFJiZJvw8BVjPnHLv3YgrXmzUgxyjM
         giNxhnSNleQlOGKGqgKck1tOjTgLVJpEOt/fMEpqwaaehfpeDyiakp3IAksEFwDn+x9Y
         KesZIlfrxKcehLCspN1vJxxi0rOEBIHJHgHt2wpCXYd3mX2AkF1M3ga2eloSFz/ubnss
         Kiu4wIgQENmeehLXKqPsN9YDuo3SHAWeAG0gk1MhhlY/9Dh3D0Jo4wLkMAJJznhpefea
         iiKg==
X-Gm-Message-State: AOAM530VwWDLhKWiLmK++3NY+AWDIx2kktxDAwL8ecx2KjX9kUz2B5KB
        EwbaNp7Va9Qv4kG6Drkw4f0=
X-Google-Smtp-Source: ABdhPJzK0ACbPupL/zivsFnTt0CmCsiOh26gU4MoJVbGij5Po3o+DJCvE2K7HErQfoXsVbMY1yBYYg==
X-Received: by 2002:a17:90b:1b4b:: with SMTP id nv11mr11833832pjb.131.1637733773606;
        Tue, 23 Nov 2021 22:02:53 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id u11sm15312481pfk.152.2021.11.23.22.02.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:53 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 15/16] selftests/bpf: Revert CO-RE removal in test_ksyms_weak.
Date:   Tue, 23 Nov 2021 22:02:08 -0800
Message-Id: <20211124060209.493-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The commit 087cba799ced ("selftests/bpf: Add weak/typeless ksym test for light skeleton")
added test_ksyms_weak to light skeleton testing, but remove CO-RE access.
Revert that part of commit, since light skeleton can use CO-RE in the kernel.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

