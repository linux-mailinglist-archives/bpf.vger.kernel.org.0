Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F353D93D2
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhG1RFh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhG1RFg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04ABC061764
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e19so5703495ejs.9
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtKc3LOV9+mn6It6FnP/k+spuBxJD+jTd/mBsRjGcHg=;
        b=nAMTC7qAl1WQrdJDT+NL2db1AvnQp+DUhCdoyMhHnscqledVrGNPczBK+fMCByZQT6
         x4+5386erE8XuDryuVdrkjiXsOeEgS88aa+KWPv5WQryQaOg8vQQ8dh4d2gOK9P26LMM
         Zfv48f5WmvWE1RZQKJ2Fz/DIB7Gqu1hU8zir6Nyb6b0gx5W7pvYzsambio2wxi3GS4gO
         +tbmQGSp1N/btZaQSkoIBXbqter1ieOGWVbvQ/nmfeaTxXQ9PAUkq0iMXGyyE2WJk7YP
         Yfp9SwlhjB+D7AxeINERM4Trf2R9/e2BYSagaFljIoGWpdoJCf3rfMEpPUp3poLiCtP0
         deJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtKc3LOV9+mn6It6FnP/k+spuBxJD+jTd/mBsRjGcHg=;
        b=pUpvhmOGtEi3H9UXFgliagdh2bCvk2wVnrJjZ2jnAaFwtCkMsN0m6TyZfAinmWQIrk
         rWNd86jl6Ha/kwI9XbvXKvIj1fVfyQs9bEmpCZTel0k+q1akfRRwf0EeIKtAa/9tcinP
         qvgRzRn4SzblUFckYTesfRbyx4XJKScKr7ZHWzDLQTR2Zz7xZbenn2crt3T0FwVTDydu
         mdrmlFlVcSetrYSPnUegInh4YGnqlVpc9tI4Ht3gwpIXS2Be/pbO6wvmEgaNeUVPUUcR
         aU9Tn40M1LddBCynmga0MRDAuN8Lbh3pal6jYG4adm7AlXSWZKIbt3Yt2RGyNhoGuqPF
         vYVQ==
X-Gm-Message-State: AOAM5330NARBFfHr5AwSuJUC6lpAsDsyG7Sp5z1TQMdPkbvCNecZregB
        sRs5MM+yL80nX57Sj40YDM6zfA==
X-Google-Smtp-Source: ABdhPJxkeRV5eI0PUUTh1FY772fiUE1Jz4PtvhpAlRMtgxNDLIPKTm1WgAuXa2V1F4rViERFDu7zRQ==
X-Received: by 2002:a17:906:40d7:: with SMTP id a23mr495127ejk.24.1627491932571;
        Wed, 28 Jul 2021 10:05:32 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:32 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 03/14] bpf/tests: Fix typos in test case descriptions
Date:   Wed, 28 Jul 2021 19:04:51 +0200
Message-Id: <20210728170502.351010-4-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch corrects the test description in a number of cases where
the description differed from what was actually tested and expected.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 9e232acddce8..9695d13812df 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -3537,7 +3537,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 0xffffffff } },
 	},
 	{
-		"ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000ffff00000000",
+		"ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000000000000000",
 		.u.insns_int = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000000000000000LL),
@@ -3553,7 +3553,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 0x1 } },
 	},
 	{
-		"ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffffffff",
+		"ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffff0000",
 		.u.insns_int = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
@@ -3679,7 +3679,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 0xffffffff } },
 	},
 	{
-		"ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffff00000000",
+		"ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffffffff0000",
 		.u.insns_int = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
@@ -3810,7 +3810,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 3 } },
 	},
 	{
-		"ALU64_XOR_K: 1 & 0xffffffff = 0xfffffffe",
+		"ALU64_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, 1),
 			BPF_ALU64_IMM(BPF_XOR, R0, 0xffffffff),
-- 
2.25.1

