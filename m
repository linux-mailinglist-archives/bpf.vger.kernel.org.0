Return-Path: <bpf+bounces-7261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7A7743ED
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361F81C20F4C
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AD1FB54;
	Tue,  8 Aug 2023 18:02:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CC15AD2
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FF16A5F
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 10:43:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc65360648so26143685ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691516617; x=1692121417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EGKCZDiJ4NloB/y09AGL84/WyHzdyCqQmvg2p6jph0=;
        b=zpTFgE2fHPa+4E7FR5rcHzxNaBukxXTxdRHe1EKBoBIBern9vYPW3tzPXTbLlux/C2
         BHxSP0y3BmFNGotv2KRtJsQ/m82dvWVrnRUY6VweDuYAHgpiGNjbP6KE9ijKBLt83xrg
         oSZNwc/4wHbXhUBrE/3xPc7Z7dwB5gq56ZY5PofdnVDyHQC8aVctLYD45VeSLVfj0hre
         bJewKdo77YgBD0i6PuleB13SSxqIRYSHUSNR07Y6SPpHPDm9zNAYFDaASr75B1SzvuXM
         khCvWoJuS8ouo8KkDRiQN2bB2UEc57RZ5jqJrHWDrIErOANowQT2B0KfpSEzZ0Ggo5en
         Tmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516617; x=1692121417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EGKCZDiJ4NloB/y09AGL84/WyHzdyCqQmvg2p6jph0=;
        b=YOu7LzW/V+lZXKSzktc7K++/9HBwVKOHhKypaM7e7WROg7vl5rmPxHTXRLWbQXFDDm
         5foOKB9z2Y4Oe/q/L8/hD1B3mPba34z5hsS/SQ+yzbXR5PqeP9AvC3crDF18adTtr8Zv
         A8xK2eyLCiPJCpjfI+wcVR1KXu7STAP6VfbCFZTdD69jgQ0fFLKB2+8hRzdcGAoCCu/e
         QvbpaqsvSjRa4vdYTbchdOT6WmZVwlVrjotEG0Do74DmS3sRyGWZm2f/HFpVEeiVRdDC
         G+6sb8kJHu1VtMz/zBARwERP0vWeiTcWK1D1CuXw7d8SCVTafm88gQSsHuAoEA1JLRUg
         WVTA==
X-Gm-Message-State: AOJu0Yxbtrr+pA6TkRBugYFBdNsvhTmFEBl+Trl2HqraAR02yCcXLDun
	PyX1YyoL3KntUj0acZR884aTSrsnF8Du/292juM=
X-Google-Smtp-Source: AGHT+IEkjCajoCyK/YJSybiGl+0sajLbVjFQGBIgAkqqZ34FP2KU31RJr/WUCkU3reXpydGUSyAhng==
X-Received: by 2002:ac8:5f08:0:b0:405:50b8:dc1d with SMTP id x8-20020ac85f08000000b0040550b8dc1dmr14718265qta.48.1691472463721;
        Mon, 07 Aug 2023 22:27:43 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id x4-20020ac81204000000b003f9efa2ddb4sm3102304qti.66.2023.08.07.22.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:27:43 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH] bpf, docs: Fix small typo and define semantics of sign extension
Date: Tue,  8 Aug 2023 01:27:32 -0400
Message-ID: <20230808052736.182587-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add additional precision on the semantics of the sign extension
operations in eBPF. In addition, fix a very minor typo.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

 Changelog:
   v0 -> v1:
     - Separated from an earlier patch -- fly free, patch!

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 25be958130dc..4f73e9dc8d9e 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -76,6 +76,27 @@ Functions
   format and returns the equivalent number with the same bit width but
   opposite endianness.
 
+
+Definitions
+-----------
+
+.. glossary::
+
+  Sign Extend
+    To `sign extend an` ``X`` `-bit number, A, to a` ``Y`` `-bit number, B  ,` means to
+
+    #. Copy all ``X`` bits from `A` to the lower ``X`` bits of `B`.
+    #. Set the value of the remaining ``Y`` - ``X`` bits of `B` to the value of
+       the  most-significant bit of `A`.
+
+.. admonition:: Example
+
+  Sign extend an 8-bit number ``A`` to a 16-bit number ``B`` on a big-endian platform:
+  ::
+
+    A:          10000110
+    B: 11111111 10000110
+
 Registers and calling convention
 ================================
 
@@ -234,7 +255,7 @@ BPF_SMOD   0x90   1        dst = (src != 0) ? (dst s% src) : dst
 BPF_XOR    0xa0   0        dst ^= src
 BPF_MOV    0xb0   0        dst = src
 BPF_MOVSX  0xb0   8/16/32  dst = (s8,s16,s32)src
-BPF_ARSH   0xc0   0        sign extending dst >>= (src & mask)
+BPF_ARSH   0xc0   0        :term:`sign extending<Sign Extend>` dst >>= (src & mask)
 BPF_END    0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
 =========  =====  =======  ==========================================================
 
@@ -266,22 +287,22 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 Note that most instructions have instruction offset of 0. Only three instructions
 (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
 
-The devision and modulo operations support both unsigned and signed flavors.
+The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
-'imm' is first sign extended from 32 to 64 bits, and then interpreted as
-a 64-bit unsigned value.
+'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit unsigned value.
 
 For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
-is first sign extended from 32 to 64 bits, and then interpreted as a
-64-bit signed value.
+is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit signed value.
 
 The ``BPF_MOVSX`` instruction does a move operation with sign extension.
-``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
+``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
 bit operands, and zeroes the remaining upper 32 bits.
-``BPF_ALU64 | BPF_MOVSX`` sign extends 8-bit, 16-bit, and 32-bit
+``BPF_ALU64 | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
 operands into 64 bit operands.
 
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
@@ -466,7 +487,7 @@ Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
 Sign-extension load operations
 ------------------------------
 
-The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
+The ``BPF_MEMSX`` mode modifier is used to encode :term:`sign-extension<Sign Extend>` load
 instructions that transfer data between a register and memory.
 
 ``BPF_MEMSX | <size> | BPF_LDX`` means::
-- 
2.41.0


