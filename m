Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B34F4654DB
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhLASQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352266AbhLASPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:15:04 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB2DC0613F4
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r138so24405888pgr.13
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ML9wWSB0Ft27w87gN8NvrgcplB6DVV/ROQjg086ar6g=;
        b=AtvciDroGV4emO/EY1X+KovyVloLQ9oSLHRqcIAepRUf5uOt+mPz/pNnrepAsYu5oP
         6+BJNF8yOcVSR8ilAjV2b86SlLkHEn4USyQpZoOB0C80hzggoq+4pYLBgqQ3o62wVUKc
         4dvzqNKsSJ/q4yskmnHOdpMn+93Tfb/NZVJrs1Ra/y+NQLF2UtfexBYbTWsGVPosTKVu
         PS+CQzErDMgkoa0druYceOz5wO7kTBi46oz0AD7yPibkxMag79dXdFJ7WOZ7ANLBzOTY
         kRRRAhNatS/fJF8qAVNkKvlFyQmMIB3ztwiLSfcHU3z8bs7MqEclF/YtD1ggHikWMcGN
         gn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ML9wWSB0Ft27w87gN8NvrgcplB6DVV/ROQjg086ar6g=;
        b=n3D7C5yFBxR+kyLKzV8e9fPtkTMuKcKV0f8XTcZ/T2kcjnbH4m2HaQLz5Mgs3uE556
         jVFve9Q5QrKG2r36cW+wY0enReNNDTR6rGHZ8L2sy60tXM8fuUgoJPQMcOmp0pcQl05f
         ruAi54GJ9DvYqyiMfwB0NoCsOjUnzExsHeAbfS7vFdKgg9ftvww6gYixbBlX1tP/SnyZ
         xsBQMa1CUSbnPDF3rEubOLh++gDOOMwkAEKjmWfomXjALTgxXESpc0nByXb5qNGRXkCx
         9xa104w2ZsyRJy4JsrJySrYoZachtJ51B72au2N4bf4EanFuIWpYAx8DJRBGG83An4qa
         LDWQ==
X-Gm-Message-State: AOAM5328j4vYk6nPiT2PBV1QUVEQnwmXnK4g+XoY79cxtQ7+vWmYeElu
        TYwKH1svWqbqn1UsT1TqA3g=
X-Google-Smtp-Source: ABdhPJyk4Lw1488aNSol8NAzL81Nyk6Ha0WG18RlgUuU+a2giDjvFUrmODcSensQsciZC3kzHEqjYg==
X-Received: by 2002:a63:4664:: with SMTP id v36mr1963700pgk.147.1638382291105;
        Wed, 01 Dec 2021 10:11:31 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id q6sm499897pfk.144.2021.12.01.10.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:30 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 17/17] selftests/bpf: Add CO-RE relocations to verifier scale test.
Date:   Wed,  1 Dec 2021 10:10:40 -0800
Message-Id: <20211201181040.23337-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add 182 CO-RE relocations to verifier scale test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_verif_scale2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale2.c b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
index f024154c7be7..f90ffcafd1e8 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale2.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #define ATTR __always_inline
 #include "test_jhash.h"
 
-SEC("scale90_inline")
+SEC("tc")
 int balancer_ingress(struct __sk_buff *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
-- 
2.30.2

