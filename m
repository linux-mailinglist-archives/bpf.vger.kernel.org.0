Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F024654DC
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352234AbhLASQP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352263AbhLASPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:15:04 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39BC0613F3
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n8so18352973plf.4
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIi8s5XGIUokbgHYRYNlQaxnDLZTghamDXqG7hIZzX0=;
        b=Ihl3J40zSh5ZJbhk8eq4yzlJXcFNSLm3aeSRoso5IzKtvM8l24jGpP4mRy0zBgcSqO
         pgW3aFjQzOn5bXxW9hPSMG8fROschhju7HiVHZrBrAL8its80z01yCBKsxjfKEi9iLvR
         SzOChQFipshHesnhL31KfuRUBMUNG4+gveNFAWaV6tq1mjEjd5ROkQxNPaGg3sDO1cYY
         uohZd5PtW4V6AqgtGMgaccmVInpyipoA5MSUeFNpZVD66qfAaoX/bmrgyv2buHEfj8Us
         efeEi6rUa5R+kqjXbjqZ8he7GiWQOBjkaweAabtEwhEGGWOZKMTUVfVMRXCDLpXNjjvf
         GeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIi8s5XGIUokbgHYRYNlQaxnDLZTghamDXqG7hIZzX0=;
        b=a5NZWUtJAFyclgIZ+5sfPeaEOyTAhq6ukxfLU+rHaCiGta54ukHCcostQK4/ZS5t6F
         rkyLIMNW/O+rxa7ZOcsp64ekGfH/hT0uhqn9nSMLVwpYfmhrh8C0b/rOOrIcMp+4HUy2
         YhrLIsBmVzYHnO7uruQey8WyKYLRNi7GNnM8nuphSEkYhn9qHVpLQPit5K/WQRGUd6HP
         R1y+c5pkOMTbrHjRAgc1KSdD9kEfTj02ZWjj12uPMZaRiZFseds336wkiN4dHcCZTswn
         I7u4imAZmyPIiJbnOZqJoBk6f96F6z37j4epDpxrtH/gfEquIcPHSuHXlykGLbYUgNyy
         Qp9Q==
X-Gm-Message-State: AOAM530cRtJAgTjYpavn7Q+pspr04V7+WG/PetB8vqhV9jpbXrRERyOV
        uCsM8k8MDZD2rFkMq1jODIw=
X-Google-Smtp-Source: ABdhPJzsMkTe4D8W96kHw9eEnWzYTszH51WPZ3/MOhb2bIRwThA6qHSxcp5ceMPEey15MfdCE0wHBA==
X-Received: by 2002:a17:902:db01:b0:141:ea12:2176 with SMTP id m1-20020a170902db0100b00141ea122176mr9508770plx.44.1638382288154;
        Wed, 01 Dec 2021 10:11:28 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id ne22sm13889pjb.18.2021.12.01.10.11.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:27 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 16/17] selftests/bpf: Revert CO-RE removal in test_ksyms_weak.
Date:   Wed,  1 Dec 2021 10:10:39 -0800
Message-Id: <20211201181040.23337-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
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

