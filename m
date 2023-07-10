Return-Path: <bpf+bounces-4628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9374DD72
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5832280C0D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57614293;
	Mon, 10 Jul 2023 18:37:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131F12B9E
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:37:18 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C110EB
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:36:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668711086f4so3078160b3a.1
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689014188; x=1691606188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVA1uSFinkIrDQM5y/4V1pT0CBrG8xSRD0wqPRcdPVg=;
        b=kcQjgxmgDSE4oExxyiKqAm8buGiio2rwdfWOmmV2Kp6gtJ6LNfG6mxw1qvSk/ZLnl1
         gGAkQi0P5B70BLznW10sIgs+IF3x54WlLh8abEcGhn29rF1dhvEiAmeTfbuGFQLYTeqc
         YI0UU/Oird3UgdOjKNR/XO8vOYmAzNyWnm7DUiJWDtfNdQsvks9KRqXa1zde6FPd/pIB
         Pz811fnNITFPhhKM6DzPvba6oKbaRZKHqxwl4JVm2DWFChNNM6R2FEIzfGNCXya2qrxX
         R0fq9k/mQAF31fc8lfMU8DSygoo+0taSTB4oBuq6w56IfVqce0ZLFSY5UOxQlM16EBS3
         K8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014188; x=1691606188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVA1uSFinkIrDQM5y/4V1pT0CBrG8xSRD0wqPRcdPVg=;
        b=QN8b9uZYA8IlmMxTOfWL6N006gZ95i0LCY8fLKsYKKdYsePAOYrAlJz7TmAFuv7FeR
         Sz3J80pIXwW7q1NWnRi1IxbNrfKVLAvlemCk5UtGmwH8RYXgAcff9Uep6IjtgPmsHOuS
         CGjbMI08W5hV7jjrooQZRmpx1HTmr19H2twhYUVrnuXfbdVXHCFAstOyojKy4meC83ax
         Vbumn/Y/mLNxDzkC3xxeFBmNEpiWWWNA7KN49Pg88kIObgMB8ONLsfspjfvr1SZhiQyY
         Qk0FpnFIbqVMKeXyXL17srLGWWDeCfaF8L3laZg/5cN3ClSsC5o9Ou/MRUxhgW6fUvwQ
         nuSA==
X-Gm-Message-State: ABy/qLaYO8NAWtort8rGEwDxv1ye0HSVEzq4MxnkloOm9Ee95pXCSyhr
	2Hs+fSADH5hE29YXZ3sUBF7RCKoL34k=
X-Google-Smtp-Source: APBJJlHb725uW0TZZ1aLxhAk4SH0vKO6bLp5ur7xXBm2kcNMXnBLQMbzKZ9TjfLIGJJqstEd7exy+Q==
X-Received: by 2002:a05:6a00:3a0a:b0:678:7744:31fd with SMTP id fj10-20020a056a003a0a00b00678774431fdmr26427913pfb.0.1689014188502;
        Mon, 10 Jul 2023 11:36:28 -0700 (PDT)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm101778pfm.138.2023.07.10.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:36:28 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v3] bpf, docs: Improve English readability
Date: Mon, 10 Jul 2023 18:36:22 +0000
Message-Id: <20230710183622.1401-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Thaler <dthaler@microsoft.com>

Minor changes to improve English readability. For example:

* Use "must be set to zero" phrasing as typical in IETF RFCs.
* Expand LSB on first use, per RFC editor requirements.
* Define htole and htobe
* Define PC

--
V1 -> V2: addressed comments from Alexei
V2 -> V3: removed changeds Alexei didn't like

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 37 +++++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 751e657973f..17edf268ed8 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -74,7 +74,7 @@ For example::
   07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
-Unused fields shall be cleared to zero.
+Unused fields must be set to zero.
 
 As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
 instruction uses a 64-bit immediate value that is constructed as follows.
@@ -103,7 +103,9 @@ instruction are reserved and shall be cleared to zero.
 Instruction classes
 -------------------
 
-The three LSB bits of the 'opcode' field store the instruction class:
+The encoding of the 'opcode' field varies and can be determined 
+from the three least significant bits (LSB) of the 'opcode' field 
+which holds the "instruction class", as follows:
 
 =========  =====  ===============================  ===================================
 class      value  description                      reference
@@ -216,8 +218,9 @@ The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-The 1-bit source operand field in the opcode is used to select what byte
-order the operation convert from or to:
+Byte swap instructions use the 1-bit 'source' field in the 'opcode' 
+field as follows.  Instead of indicating the source operator, it is 
+instead used to select what byte order the operation converts from or to:
 
 =========  =====  =================================================
 source     value  description
@@ -235,16 +238,21 @@ Examples:
 
   dst = htole16(dst)
 
+where 'htole16()' indicates converting a 16-bit value from host byte order to little-endian byte order.
+
 ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
   dst = htobe64(dst)
 
+where 'htobe64()' indicates converting a 64-bit value from host byte order to big-endian byte order.
+
 Jump instructions
 -----------------
 
-``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
+Instruction class ``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
 otherwise identical operations.
-The 'code' field encodes the operation as below:
+
+The 4-bit 'code' field encodes the operation as below, where PC is the program counter:
 
 ========  =====  ===  ===========================================  =========================================
 code      value  src  description                                  notes
@@ -311,7 +319,8 @@ For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_
 mode          size    instruction class
 ============  ======  =================
 
-The mode modifier is one of:
+mode
+  one of:
 
   =============  =====  ====================================  =============
   mode modifier  value  description                           reference
@@ -323,7 +332,8 @@ The mode modifier is one of:
   BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
   =============  =====  ====================================  =============
 
-The size modifier is one of:
+size
+  one of:
 
   =============  =====  =====================
   size modifier  value  description
@@ -334,6 +344,9 @@ The size modifier is one of:
   BPF_DW         0x18   double word (8 bytes)
   =============  =====  =====================
 
+instruction class
+  the instruction class (see `Instruction classes`_)
+
 Regular load and store operations
 ---------------------------------
 
@@ -352,7 +365,7 @@ instructions that transfer data between a register and memory.
 
   dst = *(size *) (src + offset)
 
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
+where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
 
 Atomic operations
 -----------------
@@ -366,7 +379,9 @@ that use the ``BPF_ATOMIC`` mode modifier as follows:
 
 * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
 * ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
-* 8-bit and 16-bit wide atomic operations are not supported.
+
+Note that 8-bit (``BPF_B``) and 16-bit (``BPF_H``) wide atomic 
+operations are not currently supported, nor is ``BPF_ATOMIC | <size> | BPF_ST``.
 
 The 'imm' field is used to encode the actual atomic operation.
 Simple atomic operation use a subset of the values defined to encode
@@ -390,7 +405,7 @@ BPF_XOR   0xa0   atomic xor
 
   *(u64 *)(dst + offset) += src
 
-In addition to the simple atomic operations, there also is a modifier and
+In addition to the simple atomic operations above, there also is a modifier and
 two complex atomic operations:
 
 ===========  ================  ===========================
-- 
2.33.4


