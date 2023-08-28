Return-Path: <bpf+bounces-8855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B527E78B508
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77311C20952
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F4C13AF5;
	Mon, 28 Aug 2023 16:00:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F619134DF
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:00:21 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47510B
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:20 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 967A0C169534
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238409; bh=hNDlIzFVzdMzhTM9Qvvgj9Q4fFPgTKNjDWv0Gcqzo0w=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=PKeLjBnNU8DQMMEm/3vPJ9wLpzfoz2UznJMsd2dM3TiAGNlXJ+JQ+0aMyPmm1kDz1
	 jv9nGbJvhZER4u8n2/k386gHUT/2bkglbHSIlnw7s3HhSJkYb3rQviewGGHPc0flwf
	 DuviMolDwQP1KdCUnYRjo9GEHRQ7f6Vezu/McWNA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug 28 09:00:09 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7D3EBC16951F;
	Mon, 28 Aug 2023 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238409; bh=hNDlIzFVzdMzhTM9Qvvgj9Q4fFPgTKNjDWv0Gcqzo0w=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=PKeLjBnNU8DQMMEm/3vPJ9wLpzfoz2UznJMsd2dM3TiAGNlXJ+JQ+0aMyPmm1kDz1
	 jv9nGbJvhZER4u8n2/k386gHUT/2bkglbHSIlnw7s3HhSJkYb3rQviewGGHPc0flwf
	 DuviMolDwQP1KdCUnYRjo9GEHRQ7f6Vezu/McWNA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9CD9EC14CE52
 for <bpf@ietfa.amsl.com>; Mon, 28 Aug 2023 09:00:08 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.41
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wpclsH1c6E12 for <bpf@ietfa.amsl.com>;
 Mon, 28 Aug 2023 09:00:04 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 54F96C15152E
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:04 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-58fae4a5285so40345007b3.0
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693238403; x=1693843203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Dq6hEvnyzheER3NLXV0bHMNRhjR+A8D02vzT+2FQtM=;
 b=beONKgqyifzOc6t7+KxcHE003S79KRcILaJcdPpP9yqj9nnIGyTW8gZuwVzDaBa0Up
 1pmpnxpz6F5QnWVKmQX0Lv7l0WWzqjXDkchrCeZaN5djcHpuwzP4FmimdH08L03TaQaf
 KfjuC+pFUITbj50+MnLS4T/PyMea61GQUdznXPp0/WnzBNkG9JtqWBZlAacH12jLDrfC
 kbcRgeUWLRtZ4W9mlhwfPmkjiVC0EIo5vUtXG6GmC6wgbgFutQ5cH31nEhgohQ18cVf/
 f1qHfcCyvDD87E8KGGQne9aw935TovlG5jQiHlacqOxAn7XHtE3zwlK5rhksbW1FPaPM
 +4xg==
X-Gm-Message-State: AOJu0Yzv6I+bkOj/DeqoBgZMrfJvabrS7C9dHfTOQ0oQiu+mxYK3T/FA
 d1GfKOEBGKCfQEeUJBT2pJU=
X-Google-Smtp-Source: AGHT+IGkPgIoZCO/1q2yZVVpwZp/R7ZnvvPjF/V5EdMHZGd5mSBTXSbbsuY9MBzaT+qbMgnHytKpPg==
X-Received: by 2002:a81:94c4:0:b0:56d:2f9d:42cc with SMTP id
 l187-20020a8194c4000000b0056d2f9d42ccmr25510012ywg.51.1693238403456; 
 Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
Received: from localhost ([24.1.27.177]) by smtp.gmail.com with ESMTPSA id
 v5-20020a81a545000000b00559f1cb8444sm2178088ywg.70.2023.08.28.09.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, hch@infradead.org, hawkinsw@obs.cr,
 dthaler@microsoft.com, bpf@ietf.org
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
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-BO0VqLqZMRZviTSPe8i5sXqRA8>
Subject: [Bpf] [PATCH bpf-next 3/3] bpf,
 docs: s/eBPF/BPF in standards documents
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

