Return-Path: <bpf+bounces-30514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874558CE8E1
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2091C2127C
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C550C12FB2A;
	Fri, 24 May 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X12bJIhr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF512F376
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569189; cv=none; b=GrFnD4WUW2JNXAQnuFDf3HNoZGz4kLbFrDw6yGoyjgv6GBNqKorVrpG5YsunWO+XJHKnFj1XBr8fqwV0Md6QOFdVo/rdKffD9bxPtAdgtMs620PypliKG6huY5Q6bvDZzgAovr9ugLYcYCAZBjvRk6DJX9hhQUDnFcltqfixheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569189; c=relaxed/simple;
	bh=J2EyzLCylWAArfjEkXLuQjQ6GKEOQqUnpcaUbkbUP+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4kX5HaGVpw1VSKBI7kNnnjVNgWlJ6jRnbKKg3PGelF8pUwC0bZbi4XxWXf3nUDe00y1JKPR8HMBDZibAilyX/z793uGtiBxipzj6hPLAP8VDEhOMm1kmmA3/GhGbrwqI0wVttcmfPmRewRa9dRFu1jodNpcgmSdpsqUendg3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=X12bJIhr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bdf3f4d5ffso1430964a91.3
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716569187; x=1717173987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bMgm1etftre/efThJLmDfD1BLPnIDNtKcvVWKdCOAU=;
        b=X12bJIhrwEYFBB9Lm4mC18agIRdkndyw2DYsAIqQKOKasX4z/l7JH1GJLjrImUe+iv
         qMjQcOwmubPffmHGIulQU+c8WgMlrJ1xD+cwDPotNjHLi4zGjrZ1XgIB9ARArlRTzdIw
         YyWxr1NAIYP/v89z8c4dEgEZgJAp/C2KCKjm8SfDOBLTQJ78rKytlmiNySf/IVe2BTR1
         Z8FZcLljhcLLdZshPu6YIzJ2zB0cxvegdoRiC6gLzWRvwEX0tOqSLJMCWVlfNibC4a4P
         0vbGzWtnjnFK+h3wE3ygohupzclny5HAlFzUPcMtLF/HH+HOv8FDblNt3MZXqypZuCHM
         +z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716569187; x=1717173987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bMgm1etftre/efThJLmDfD1BLPnIDNtKcvVWKdCOAU=;
        b=kVa6mZiEgemCIheSGLxW3nOxNXcAQitoX5yrr0557So57SbuOjlIKgt3buNeg5l04S
         gA05yBsqvmwyqeDJkvoNthgwaLd5DpWAyZ4BlUpovyIiIuL5BcYknbw1/io5/NiLtKBN
         tZy5J965kUznj39L8AKtlnt99SiTrVIZBJ9e57v7MnMjpqkOHgQ5eEhjIP1UBfe794Q2
         m8cPhD63ufoimFwtlaUUHr2JF6bCU1Nd0flSI7W6OimPPcbSHcfg8+xoOukXCoXs6pnl
         F64S0nYO666DJ6nCQ1lWViOZnC5fI+GTJNN0+gcF4seMq+Wx0lnHYrHwQbUd0lhWF77H
         IfPA==
X-Gm-Message-State: AOJu0Yw8Iinjs8X3qESGNPPicvRojCoe9UKCQ+dWgWqpz2aJkhH8esW2
	lGiUvNbsysU63rztW+otz03h0WhIYNdnoDJsfy0Ou8KrUoz5XLfs4zkzGYAU
X-Google-Smtp-Source: AGHT+IE1gYnNhwQay855uIeqaUcL9sAV53/Hga2FDwm0A8Q5qg15iW+hKFgur37l68aqLkRlAGIlBQ==
X-Received: by 2002:a17:90b:b11:b0:2bd:f690:67c8 with SMTP id 98e67ed59e1d1-2bf5f106605mr2576955a91.27.1716569186459;
        Fri, 24 May 2024 09:46:26 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdefa332a0sm2945120a91.33.2024.05.24.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:46:25 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Add table captions
Date: Fri, 24 May 2024 09:46:18 -0700
Message-Id: <20240524164618.18894-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Ines Robles in his IETF GENART review at
https://datatracker.ietf.org/doc/review-ietf-bpf-isa-02-genart-lc-robles-2024-05-16/

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 184 ++++++++++--------
 1 file changed, 102 insertions(+), 82 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 00c93eb42..eec3bfb4f 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -25,7 +25,7 @@ Types
 This document refers to integer types with the notation `SN` to specify
 a type's signedness (`S`) and bit width (`N`), respectively.
 
-.. table:: Meaning of signedness notation.
+.. table:: Meaning of signedness notation
 
   ==== =========
   S    Meaning
@@ -34,7 +34,7 @@ a type's signedness (`S`) and bit width (`N`), respectively.
   s    signed
   ==== =========
 
-.. table:: Meaning of bit-width notation.
+.. table:: Meaning of bit-width notation
 
   ===== =========
   N     Bit width
@@ -256,18 +256,20 @@ Instruction classes
 
 The three least significant bits of the 'opcode' field store the instruction class:
 
-=====  =====  ===============================  ===================================
-class  value  description                      reference
-=====  =====  ===============================  ===================================
-LD     0x0    non-standard load operations     `Load and store instructions`_
-LDX    0x1    load into register operations    `Load and store instructions`_
-ST     0x2    store from immediate operations  `Load and store instructions`_
-STX    0x3    store from register operations   `Load and store instructions`_
-ALU    0x4    32-bit arithmetic operations     `Arithmetic and jump instructions`_
-JMP    0x5    64-bit jump operations           `Arithmetic and jump instructions`_
-JMP32  0x6    32-bit jump operations           `Arithmetic and jump instructions`_
-ALU64  0x7    64-bit arithmetic operations     `Arithmetic and jump instructions`_
-=====  =====  ===============================  ===================================
+.. table:: Instruction class
+
+  =====  =====  ===============================  ===================================
+  class  value  description                      reference
+  =====  =====  ===============================  ===================================
+  LD     0x0    non-standard load operations     `Load and store instructions`_
+  LDX    0x1    load into register operations    `Load and store instructions`_
+  ST     0x2    store from immediate operations  `Load and store instructions`_
+  STX    0x3    store from register operations   `Load and store instructions`_
+  ALU    0x4    32-bit arithmetic operations     `Arithmetic and jump instructions`_
+  JMP    0x5    64-bit jump operations           `Arithmetic and jump instructions`_
+  JMP32  0x6    32-bit jump operations           `Arithmetic and jump instructions`_
+  ALU64  0x7    64-bit arithmetic operations     `Arithmetic and jump instructions`_
+  =====  =====  ===============================  ===================================
 
 Arithmetic and jump instructions
 ================================
@@ -285,6 +287,8 @@ For arithmetic and jump instructions (``ALU``, ``ALU64``, ``JMP`` and
 **s (source)**
   the source operand location, which unless otherwise specified is one of:
 
+  .. table:: Source operand location
+
   ======  =====  ==============================================
   source  value  description
   ======  =====  ==============================================
@@ -305,27 +309,29 @@ The 'code' field encodes the operation as below, where 'src' refers to the
 the source operand and 'dst' refers to the value of the destination
 register.
 
-=====  =====  =======  ==========================================================
-name   code   offset   description
-=====  =====  =======  ==========================================================
-ADD    0x0    0        dst += src
-SUB    0x1    0        dst -= src
-MUL    0x2    0        dst \*= src
-DIV    0x3    0        dst = (src != 0) ? (dst / src) : 0
-SDIV   0x3    1        dst = (src != 0) ? (dst s/ src) : 0
-OR     0x4    0        dst \|= src
-AND    0x5    0        dst &= src
-LSH    0x6    0        dst <<= (src & mask)
-RSH    0x7    0        dst >>= (src & mask)
-NEG    0x8    0        dst = -dst
-MOD    0x9    0        dst = (src != 0) ? (dst % src) : dst
-SMOD   0x9    1        dst = (src != 0) ? (dst s% src) : dst
-XOR    0xa    0        dst ^= src
-MOV    0xb    0        dst = src
-MOVSX  0xb    8/16/32  dst = (s8,s16,s32)src
-ARSH   0xc    0        :term:`sign extending<Sign Extend>` dst >>= (src & mask)
-END    0xd    0        byte swap operations (see `Byte swap instructions`_ below)
-=====  =====  =======  ==========================================================
+.. table:: Arithmetic instructions
+
+  =====  =====  =======  ==========================================================
+  name   code   offset   description
+  =====  =====  =======  ==========================================================
+  ADD    0x0    0        dst += src
+  SUB    0x1    0        dst -= src
+  MUL    0x2    0        dst \*= src
+  DIV    0x3    0        dst = (src != 0) ? (dst / src) : 0
+  SDIV   0x3    1        dst = (src != 0) ? (dst s/ src) : 0
+  OR     0x4    0        dst \|= src
+  AND    0x5    0        dst &= src
+  LSH    0x6    0        dst <<= (src & mask)
+  RSH    0x7    0        dst >>= (src & mask)
+  NEG    0x8    0        dst = -dst
+  MOD    0x9    0        dst = (src != 0) ? (dst % src) : dst
+  SMOD   0x9    1        dst = (src != 0) ? (dst s% src) : dst
+  XOR    0xa    0        dst ^= src
+  MOV    0xb    0        dst = src
+  MOVSX  0xb    8/16/32  dst = (s8,s16,s32)src
+  ARSH   0xc    0        :term:`sign extending<Sign Extend>` dst >>= (src & mask)
+  END    0xd    0        byte swap operations (see `Byte swap instructions`_ below)
+  =====  =====  =======  ==========================================================
 
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If BPF program execution would
@@ -406,13 +412,15 @@ select what byte order the operation converts from or to. For
 ``ALU64``, the 1-bit source operand field in the opcode is reserved
 and must be set to 0.
 
-=====  ========  =====  =================================================
-class  source    value  description
-=====  ========  =====  =================================================
-ALU    TO_LE     0      convert between host byte order and little endian
-ALU    TO_BE     1      convert between host byte order and big endian
-ALU64  Reserved  0      do byte swap unconditionally
-=====  ========  =====  =================================================
+.. table:: Byte swap instructions
+
+  =====  ========  =====  =================================================
+  class  source    value  description
+  =====  ========  =====  =================================================
+  ALU    TO_LE     0      convert between host byte order and little endian
+  ALU    TO_BE     1      convert between host byte order and big endian
+  ALU64  Reserved  0      do byte swap unconditionally
+  =====  ========  =====  =================================================
 
 The 'imm' field encodes the width of the swap operations.  The following widths
 are supported: 16, 32 and 64.  Width 64 operations belong to the base64
@@ -448,27 +456,29 @@ otherwise identical operations, and indicates the base64 conformance
 group unless otherwise specified.
 The 'code' field encodes the operation as below:
 
-========  =====  =======  =================================  ===================================================
-code      value  src_reg  description                        notes
-========  =====  =======  =================================  ===================================================
-JA        0x0    0x0      PC += offset                       {JA, K, JMP} only
-JA        0x0    0x0      PC += imm                          {JA, K, JMP32} only
-JEQ       0x1    any      PC += offset if dst == src
-JGT       0x2    any      PC += offset if dst > src          unsigned
-JGE       0x3    any      PC += offset if dst >= src         unsigned
-JSET      0x4    any      PC += offset if dst & src
-JNE       0x5    any      PC += offset if dst != src
-JSGT      0x6    any      PC += offset if dst > src          signed
-JSGE      0x7    any      PC += offset if dst >= src         signed
-CALL      0x8    0x0      call helper function by static ID  {CALL, K, JMP} only, see `Helper functions`_
-CALL      0x8    0x1      call PC += imm                     {CALL, K, JMP} only, see `Program-local functions`_
-CALL      0x8    0x2      call helper function by BTF ID     {CALL, K, JMP} only, see `Helper functions`_
-EXIT      0x9    0x0      return                             {CALL, K, JMP} only
-JLT       0xa    any      PC += offset if dst < src          unsigned
-JLE       0xb    any      PC += offset if dst <= src         unsigned
-JSLT      0xc    any      PC += offset if dst < src          signed
-JSLE      0xd    any      PC += offset if dst <= src         signed
-========  =====  =======  =================================  ===================================================
+.. table:: Jump instructions
+
+  ========  =====  =======  =================================  ===================================================
+  code      value  src_reg  description                        notes
+  ========  =====  =======  =================================  ===================================================
+  JA        0x0    0x0      PC += offset                       {JA, K, JMP} only
+  JA        0x0    0x0      PC += imm                          {JA, K, JMP32} only
+  JEQ       0x1    any      PC += offset if dst == src
+  JGT       0x2    any      PC += offset if dst > src          unsigned
+  JGE       0x3    any      PC += offset if dst >= src         unsigned
+  JSET      0x4    any      PC += offset if dst & src
+  JNE       0x5    any      PC += offset if dst != src
+  JSGT      0x6    any      PC += offset if dst > src          signed
+  JSGE      0x7    any      PC += offset if dst >= src         signed
+  CALL      0x8    0x0      call helper function by static ID  {CALL, K, JMP} only, see `Helper functions`_
+  CALL      0x8    0x1      call PC += imm                     {CALL, K, JMP} only, see `Program-local functions`_
+  CALL      0x8    0x2      call helper function by BTF ID     {CALL, K, JMP} only, see `Helper functions`_
+  EXIT      0x9    0x0      return                             {CALL, K, JMP} only
+  JLT       0xa    any      PC += offset if dst < src          unsigned
+  JLE       0xb    any      PC += offset if dst <= src         unsigned
+  JSLT      0xc    any      PC += offset if dst < src          signed
+  JSLE      0xd    any      PC += offset if dst <= src         signed
+  ========  =====  =======  =================================  ===================================================
 
 where 'PC' denotes the program counter, and the offset to increment by
 is in units of 64-bit instructions relative to the instruction following
@@ -537,6 +547,8 @@ For load and store instructions (``LD``, ``LDX``, ``ST``, and ``STX``), the
 **mode**
   The mode modifier is one of:
 
+  .. table:: Mode modifier
+
     =============  =====  ====================================  =============
     mode modifier  value  description                           reference
     =============  =====  ====================================  =============
@@ -551,6 +563,8 @@ For load and store instructions (``LD``, ``LDX``, ``ST``, and ``STX``), the
 **sz (size)**
   The size modifier is one of:
 
+  .. table:: Size modifier
+
     ====  =====  =====================
     size  value  description
     ====  =====  =====================
@@ -619,14 +633,16 @@ The 'imm' field is used to encode the actual atomic operation.
 Simple atomic operation use a subset of the values defined to encode
 arithmetic operations in the 'imm' field to encode the atomic operation:
 
-========  =====  ===========
-imm       value  description
-========  =====  ===========
-ADD       0x00   atomic add
-OR        0x40   atomic or
-AND       0x50   atomic and
-XOR       0xa0   atomic xor
-========  =====  ===========
+.. table:: Simple atomic operations
+
+  ========  =====  ===========
+  imm       value  description
+  ========  =====  ===========
+  ADD       0x00   atomic add
+  OR        0x40   atomic or
+  AND       0x50   atomic and
+  XOR       0xa0   atomic xor
+  ========  =====  ===========
 
 
 ``{ATOMIC, W, STX}`` with 'imm' = ADD means::
@@ -640,6 +656,8 @@ XOR       0xa0   atomic xor
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
 
+.. table:: Complex atomic operations
+
 ===========  ================  ===========================
 imm          value             description
 ===========  ================  ===========================
@@ -673,17 +691,19 @@ The following table defines a set of ``{IMM, DW, LD}`` instructions
 with opcode subtypes in the 'src_reg' field, using new terms such as "map"
 defined further below:
 
-=======  =========================================  ===========  ==============
-src_reg  pseudocode                                 imm type     dst type
-=======  =========================================  ===========  ==============
-0x0      dst = (next_imm << 32) | imm               integer      integer
-0x1      dst = map_by_fd(imm)                       map fd       map
-0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data address
-0x3      dst = var_addr(imm)                        variable id  data address
-0x4      dst = code_addr(imm)                       integer      code address
-0x5      dst = map_by_idx(imm)                      map index    map
-0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data address
-=======  =========================================  ===========  ==============
+.. table:: 64-bit immediate instructions
+
+  =======  =========================================  ===========  ==============
+  src_reg  pseudocode                                 imm type     dst type
+  =======  =========================================  ===========  ==============
+  0x0      dst = (next_imm << 32) | imm               integer      integer
+  0x1      dst = map_by_fd(imm)                       map fd       map
+  0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data address
+  0x3      dst = var_addr(imm)                        variable id  data address
+  0x4      dst = code_addr(imm)                       integer      code address
+  0x5      dst = map_by_idx(imm)                      map index    map
+  0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data address
+  =======  =========================================  ===========  ==============
 
 where
 
-- 
2.40.1


