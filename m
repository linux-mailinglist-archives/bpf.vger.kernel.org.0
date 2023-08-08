Return-Path: <bpf+bounces-7267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E0774D01
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF625281725
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80105171DB;
	Tue,  8 Aug 2023 21:25:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42B171C2
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 21:25:11 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E22594
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:25:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76c4890a220so486957785a.3
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691529907; x=1692134707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvp4iJKE7Z19HMvi7ePuhF1OInAtM666cdZAYnZR9qA=;
        b=y15g18XzsXzeIBvf2/YOvNq0F460/IbLkdKffpnysQn5hiav/TIKXJoYkDX6W5ITk/
         ESWYCaLUhpk4GlvXIrq7FsVm0/6U6LoN6GTKEe0+McdBS7uteo1t/2HO7dNbaYcXnb74
         SF+GI5uiB7sg781isQ6Q2AKyT/DNLCsTzvY8YQmZPZ2XHbj6FOgRYNLCySqPusP0LSPu
         R1oxi/oxfgOvs8CVoqT8Cupm8AJmxuwl6tQ9kNUDR1C3qbEUig9nOKn3t6aliC6hqDWB
         jx1ZicwjP/QUxwvLorebdzsYcMTwJwMQPOegpbE+DkQmW57MFWL6aLqkfyHDHb3/DfIn
         GODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529907; x=1692134707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xvp4iJKE7Z19HMvi7ePuhF1OInAtM666cdZAYnZR9qA=;
        b=jNNqYgGfKOQOY6XDQ35vpDSbxmmkoehKz3uDP6MTVwqSmBrwzMKb1LOzZBKZ3MKfgz
         XG5hAtSjJYpLzRN1kGXhQtLiT0RFNS6cp+KGFspy42ZncBffk/NID4v3BjCvnbLcFDSS
         0DNvHCfMPGSsDTYnnZ53E3Fi/Y8e8Ijbh2Sx7J17oUxJKX3Q96khJbQYLspDu8t56iHo
         fV1zonTj7rIy/zt99YsH9T0xBLkSwyI+fJUOd1bDhL6GFhm3dyiPIn2l4pRmYLZiOJQr
         QRMGxiXTXt4EwNt0mVTflWYQO9U+D6Jm0dHppeCwEOkfjIRvtsmn1OJT6kU21FbMEPxc
         FRCg==
X-Gm-Message-State: AOJu0Yx+ROso1P0/W8uLGOZV+mWtRVDbXLBfyQuCxPGcbYibz0D56c90
	TMgiiFAqcOEXhFm6vJ61xELv1It+b/vUk2bZ6iw=
X-Google-Smtp-Source: AGHT+IHjJfaJfqZFf9glga7wdJolaaerRIxQmoXjwBM/+ZzH4U/x+W+GZCLYugEIyYXDb512RkYatg==
X-Received: by 2002:ae9:e013:0:b0:76c:d04f:7426 with SMTP id m19-20020ae9e013000000b0076cd04f7426mr868737qkk.18.1691529907581;
        Tue, 08 Aug 2023 14:25:07 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id k3-20020a05620a142300b0075ca4cd03d4sm3556835qkj.64.2023.08.08.14.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:25:07 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>,
	David Vernet <void@manifault.com>
Subject: [PATCH v2] bpf, docs: Fix small typo and define semantics of sign extension
Date: Tue,  8 Aug 2023 17:25:01 -0400
Message-ID: <20230808212503.197834-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add additional precision on the semantics of the sign extension
operations in BPF. In addition, fix a very minor typo.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
Acked-by: David Vernet <void@manifault.com>

---
 .../bpf/standardization/instruction-set.rst   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

 Changelog:
   v0 -> v1:
     - Separated from an earlier patch -- fly free, patch!
   v1 -> v2:
     - Fix commit message -- s/eBPF/BPF/
     - Add David's ack.

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


