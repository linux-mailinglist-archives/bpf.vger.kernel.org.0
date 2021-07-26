Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F493D554A
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhGZHiJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 03:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhGZHiD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 03:38:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE9C061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f13so6715782edq.13
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtKc3LOV9+mn6It6FnP/k+spuBxJD+jTd/mBsRjGcHg=;
        b=0F1wClpsG8aUAI1z4x/lSIvFdBOrYkVgTcx0BDeoTl798mDou8WiP9J+yRXEcDcbfU
         pKYxJnnLK5i8w1bf2ogOD3bQaiCyYhIFwwiH+t5R5/y8X2Ibdqm0XuV3T6CIf48FYx2j
         oZ/FVIO3TKnwcAMaRh7NCLvKAmyoIwfDu48KHjkoybR6k+P6ChAqPULcHcRWXzSHiA75
         8jZNYJw84csAW3OiT3gjXD0l46BMB6mmISBpwg/0q8WV2Wktj44zBzI0PeYSeSMb/QEH
         UsHER4AmKktWqVn0ybKv+g5CgNyWzSCMPvZ3C2uK89GBWpQMZot4qkhit+kmhM4+FpVv
         +xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtKc3LOV9+mn6It6FnP/k+spuBxJD+jTd/mBsRjGcHg=;
        b=TlC3pQEQqTGij8zwluE8BsSp+jyAk3D1zPtx7Pr2EAuPXCOtxXxKrQvmRXssdKAMWY
         PgL6CcsMsILftNidbplchjIKQbQqOeOG2r7fIN3VsYuE8zOTE2JCWUTj/DfERyeehLcX
         WOkfptGsLmw46knQc5RS/3fZyoRpbWjgBrFmZ+/4SnPIWywaI6PIHOB3gMfnEpyere/K
         q9nTlgBwCdHUMnTdYichCRZ9KfhTFDrgBCekOaZmoW3Av4249cQQPk0Oe9YPC9P9lTPO
         U/NUU3MHCQZsVytDjDLsu+MgqGaYb9yk8ezRf1Q7Ba2hmFZ8iiIZ0gDNS2tkqsgai2Tj
         NFYA==
X-Gm-Message-State: AOAM531UydDR6LPU6NbCOtml+oKHLqeBiQIHflSbgVXbfiYytrU543io
        PPhltC9xd29eLdIbvuGC6Aqm0w==
X-Google-Smtp-Source: ABdhPJxJeM4SK13FWqnDefFN7saJQSc06QmhXAuEaw09sERz+363WlNsP3cyxWlUqPlp1kqJHbFacQ==
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr19870916edo.31.1627287511354;
        Mon, 26 Jul 2021 01:18:31 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id q9sm13937539ejf.70.2021.07.26.01.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:18:31 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [RFC PATCH 03/14] bpf/tests: fix typos in test case descriptions
Date:   Mon, 26 Jul 2021 10:17:27 +0200
Message-Id: <20210726081738.1833704-4-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
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

