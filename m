Return-Path: <bpf+bounces-8851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB378B4FF
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8845280E56
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E313ADB;
	Mon, 28 Aug 2023 16:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F9134A6
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:00:05 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9180C10B;
	Mon, 28 Aug 2023 09:00:04 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d71c3a32e1aso3228074276.3;
        Mon, 28 Aug 2023 09:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693238403; x=1693843203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Dq6hEvnyzheER3NLXV0bHMNRhjR+A8D02vzT+2FQtM=;
        b=bAfK68KhONLlEX9AJ+ZbIpjbl1aRlFqGds+F0kBOj2hT7Qvu1pYahw5kZJ37jm4YD3
         C5ZJJAmvFIT108VQHLH3+pBtioIx8EeGWEuTosnzYOExh2G2fybOH4cYAlxM5f6hZX3a
         C48jhjZJZt5IwV3D087obifx+ZuJ1qN6WwthQPPy86/8MWVlZ0MSFNGzvIanA0iVJ+hr
         USIa80KPg1XsZiO+rDEDR1C3xZ6Zf2NWDqqGUps8GdggkV1tD+2a4q5zAyEVi9Y26Unl
         YAPA5miMHb9aslv0rgQBiDhun57CaGHz0qtgixgi/ktp87Uo+wLcleJ7KMyb/N1ObJx0
         3mqQ==
X-Gm-Message-State: AOJu0YxrTAdIyQeV50yqXNjlvq0BhBWb0aAIcfyEinKPHS4Df53nTE67
	jcFgg9qXCOmhsq7W9wKTNY5oG1812HBcjg==
X-Google-Smtp-Source: AGHT+IGkPgIoZCO/1q2yZVVpwZp/R7ZnvvPjF/V5EdMHZGd5mSBTXSbbsuY9MBzaT+qbMgnHytKpPg==
X-Received: by 2002:a81:94c4:0:b0:56d:2f9d:42cc with SMTP id l187-20020a8194c4000000b0056d2f9d42ccmr25510012ywg.51.1693238403456;
        Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id v5-20020a81a545000000b00559f1cb8444sm2178088ywg.70.2023.08.28.09.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	hch@infradead.org,
	hawkinsw@obs.cr,
	dthaler@microsoft.com,
	bpf@ietf.org
Subject: [PATCH bpf-next 3/3] bpf,docs: s/eBPF/BPF in standards documents
Date: Mon, 28 Aug 2023 10:59:48 -0500
Message-ID: <20230828155948.123405-4-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828155948.123405-1-void@manifault.com>
References: <20230828155948.123405-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There isn't really anything other than just "BPF" at this point, so
referring to it as "eBPF" in our standards document just causes
unnecessary confusion. Let's just be consistent and use "BPF".

Suggested-by: Will Hawkins <hawkinsw@obs.cr>
Signed-off-by: David Vernet <void@manifault.com>
---
 .../bpf/standardization/instruction-set.rst   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index cfe85129a303..8afe6567209e 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -1,11 +1,11 @@
 .. contents::
 .. sectnum::
 
-========================================
-eBPF Instruction Set Specification, v1.0
-========================================
+=======================================
+BPF Instruction Set Specification, v1.0
+=======================================
 
-This document specifies version 1.0 of the eBPF instruction set.
+This document specifies version 1.0 of the BPF instruction set.
 
 Documentation conventions
 =========================
@@ -100,7 +100,7 @@ Definitions
 Instruction encoding
 ====================
 
-eBPF has two instruction encodings:
+BPF has two instruction encodings:
 
 * the basic instruction encoding, which uses 64 bits to encode an instruction
 * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
@@ -244,7 +244,7 @@ BPF_END    0xd0   0        byte swap operations (see `Byte swap instructions`_ b
 =========  =====  =======  ==========================================================
 
 Underflow and overflow are allowed during arithmetic operations, meaning
-the 64-bit or 32-bit value will wrap. If eBPF program execution would
+the 64-bit or 32-bit value will wrap. If BPF program execution would
 result in division by zero, the destination register is instead set to zero.
 If execution would result in modulo by zero, for ``BPF_ALU64`` the value of
 the destination register is unchanged whereas for ``BPF_ALU`` the upper
@@ -366,7 +366,7 @@ BPF_JSLT  0xc    any  PC += offset if dst < src                    signed
 BPF_JSLE  0xd    any  PC += offset if dst <= src                   signed
 ========  =====  ===  ===========================================  =========================================
 
-The eBPF program needs to store the return value into register R0 before doing a
+The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
 
 Example:
@@ -486,9 +486,9 @@ Atomic operations
 
 Atomic operations are operations that operate on memory and can not be
 interrupted or corrupted by other access to the same memory region
-by other eBPF programs or means outside of this specification.
+by other BPF programs or means outside of this specification.
 
-All atomic operations supported by eBPF are encoded as store operations
+All atomic operations supported by BPF are encoded as store operations
 that use the ``BPF_ATOMIC`` mode modifier as follows:
 
 * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
@@ -578,7 +578,7 @@ where
 Maps
 ~~~~
 
-Maps are shared memory regions accessible by eBPF programs on some platforms.
+Maps are shared memory regions accessible by BPF programs on some platforms.
 A map can have various semantics as defined in a separate document, and may or
 may not have a single contiguous memory region, but the 'map_val(map)' is
 currently only defined for maps that do have a single contiguous memory region.
@@ -600,6 +600,6 @@ identified by the given id.
 Legacy BPF Packet access instructions
 -------------------------------------
 
-eBPF previously introduced special instructions for access to packet data that were
+BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. However, these instructions are
 deprecated and should no longer be used.
-- 
2.41.0


