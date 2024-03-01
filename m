Return-Path: <bpf+bounces-23181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE486E961
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD101F23771
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F73A8E3;
	Fri,  1 Mar 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kfpHotbQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC03A29E
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320832; cv=none; b=Vm3jfw436KLiRp0OyChxsQsFTtLDZybWUQtke9kUMItC+l5bWJ5Pe1ySr4dY9a3hVpGsCCPa0P3Z0PH/PsdSOafLRPoyddT+R+DQKW9gxGGwiTNnqIG6QF3FqBTvvdHN30PwsxZnURX+ytQ0VEP8P1codqQ+3g5tCUWzfpc06qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320832; c=relaxed/simple;
	bh=fNkAYdnnPlW69sBSM6dx9wUOAxZS3LCFFsvsk8FScRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WSmcVmlhL407cHylPLAcFoe0tHGQJtzNPW+PrM3nh6HawAVVPf45r1bAhWJSCGlXWQIuQ7xvsXdod0OWn3mUfI2EW5/3n+sr5lcxOOdPlxBkRkf3xyPMEPUQFpOlpXeCZjtVV9kdJ+DxxmuPdCouAdw7SdJuKmaPEKbARKWrwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kfpHotbQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1865965a12.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709320826; x=1709925626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXHHZONJxTYFo1bc0fwgZ5xMY9P9zTnbJ2cES3BZuIE=;
        b=kfpHotbQzzQNTnb3E/TKo+/t+v411uqNxzcBNlrKLLRmARKCCUfG/y9kOCz9GXjYCS
         1vTb9l1Q6eH5tf0N8T+XofEEFNzTI/Hcp38thjcIM2ZOviY0brFMYRXvqPLbPwaU9Fox
         6sCyn5T8wsBW8ACN+jlSaHuKsVsxOwEZMersfkR6gzWN6e5YnFgQsv89iVIY+j3z59u0
         T29gtqCSe2M01Q5SNHKlp8tB2rPri8G/mm8NPhXeCDPrx4cN88JiE6SjpDafmmotfjkX
         D5Its3Pa1cLQJxy27MwJqeZEuNjLFM90o8WVmX3NTWrZhkbDE5tGVD6O7h6yyRaRDnax
         zSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709320826; x=1709925626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXHHZONJxTYFo1bc0fwgZ5xMY9P9zTnbJ2cES3BZuIE=;
        b=GLOLW6t596NvXkdrqeEhIi6s/1mSeqD/6wSxQCjXD1jtVrjsAN6vn+UG5Z2nrpWNJr
         K20QaQC1d/mLspoRTC/o47iPYESVFPoAdinYczCNn5JTsniN6RUCqajwBsy+ninUEpfl
         va0DRHZEKq6B3Revub89WGkBVuoCI6OdTrlIS7jMqTcZKuj7KFyRG3k2V25oW6QF38Qa
         4etOYA2mUGN/su4owu8lpc+3/tg68G0MdCw1XLMN98j6l1rU7QXdd9rug+lOg4uGCeTW
         //6ekpNVZeYXrZw/34SktPIdbavy2r2u7pfLtA4fsQ35Poy85BXmrw0J2L/KPbirU2dw
         4H8w==
X-Gm-Message-State: AOJu0Yzx74IGaM+GreKgki93fMZ19BxaZGzRcQtE5Qr751c+PQJoMdjm
	9uJtQZBFkKfWJr/W6oHCC2315gD11ORa3eaoqa7rEcgNRnf5Gd6BzKgg/b0TKsc=
X-Google-Smtp-Source: AGHT+IGDCVeqKCqTsROi4xvFm5+1rPZ1SXYeMI6uNmlArW891FB2t79f/ILqwBa2Uva+JfjmyePUGg==
X-Received: by 2002:a17:90a:9b0b:b0:29a:2788:c9d1 with SMTP id f11-20020a17090a9b0b00b0029a2788c9d1mr2547676pjp.39.1709320825780;
        Fri, 01 Mar 2024 11:20:25 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id sx16-20020a17090b2cd000b00299b31de43esm5753725pjb.45.2024.03.01.11.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:20:25 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Use IETF format for field definitions in instruction-set.rst
Date: Fri,  1 Mar 2024 11:20:20 -0800
Message-Id: <20240301192020.15644-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for publication as an IETF RFC, the WG chairs asked me
to convert the document to use IETF packet format for field layout, so
this patch attempts to make it consistent with other IETF documents.

Some fields that are not byte aligned were previously inconsistent
in how values were defined.  Some were defined as the value of the
byte containing the field (like 0x20 for a field holding the high
four bits of the byte), and others were defined as the value of the
field itself (like 0x2).  This PR makes them be consistent in using
just the values of the field itself, which is IETF convention.

As a result, some of the defines that used BPF_* would no longer
match the value in the spec, and so this patch also drops the BPF_*
prefix to avoid confusion with the defines that are the full-byte
equivalent values.  For consistency, BPF_* is then dropped from
other fields too.  BPF_<foo> is thus the Linux implementation-specific
define for <foo> as it appears in the BPF ISA specification.

The syntax BPF_ADD | BPF_X | BPF_ALU only worked for full-byte
values so the convention {ADD, X, ALU} is proposed for referring
to field values instead.

Also replace the redundant "LSB bits" with "least significant bits".

A preview of what the resulting Internet Draft would look like can
be seen at:
https://htmlpreview.github.io/?https://raw.githubusercontent.com/dthaler/ebp
f-docs-1/format/draft-ietf-bpf-isa.html

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 531 ++++++++++--------
 1 file changed, 290 insertions(+), 241 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index f3269d6dd..a0c8fe2f2 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -24,22 +24,22 @@ a type's signedness (`S`) and bit width (`N`), respectively.
 .. table:: Meaning of signedness notation.
 
   ==== =========
-  `S`  Meaning
+  S    Meaning
   ==== =========
-  `u`  unsigned
-  `s`  signed
+  u    unsigned
+  s    signed
   ==== =========
 
 .. table:: Meaning of bit-width notation.
 
   ===== =========
-  `N`   Bit width
+  N     Bit width
   ===== =========
-  `8`   8 bits
-  `16`  16 bits
-  `32`  32 bits
-  `64`  64 bits
-  `128` 128 bits
+  8     8 bits
+  16    16 bits
+  32    32 bits
+  64    64 bits
+  128   128 bits
   ===== =========
 
 For example, `u32` is a type whose valid values are all the 32-bit unsigned
@@ -48,31 +48,31 @@ numbers.
 
 Functions
 ---------
-* `htobe16`: Takes an unsigned 16-bit number in host-endian format and
+* htobe16: Takes an unsigned 16-bit number in host-endian format and
   returns the equivalent number as an unsigned 16-bit number in big-endian
   format.
-* `htobe32`: Takes an unsigned 32-bit number in host-endian format and
+* htobe32: Takes an unsigned 32-bit number in host-endian format and
   returns the equivalent number as an unsigned 32-bit number in big-endian
   format.
-* `htobe64`: Takes an unsigned 64-bit number in host-endian format and
+* htobe64: Takes an unsigned 64-bit number in host-endian format and
   returns the equivalent number as an unsigned 64-bit number in big-endian
   format.
-* `htole16`: Takes an unsigned 16-bit number in host-endian format and
+* htole16: Takes an unsigned 16-bit number in host-endian format and
   returns the equivalent number as an unsigned 16-bit number in little-endian
   format.
-* `htole32`: Takes an unsigned 32-bit number in host-endian format and
+* htole32: Takes an unsigned 32-bit number in host-endian format and
   returns the equivalent number as an unsigned 32-bit number in little-endian
   format.
-* `htole64`: Takes an unsigned 64-bit number in host-endian format and
+* htole64: Takes an unsigned 64-bit number in host-endian format and
   returns the equivalent number as an unsigned 64-bit number in little-endian
   format.
-* `bswap16`: Takes an unsigned 16-bit number in either big- or little-endian
+* bswap16: Takes an unsigned 16-bit number in either big- or little-endian
   format and returns the equivalent number with the same bit width but
   opposite endianness.
-* `bswap32`: Takes an unsigned 32-bit number in either big- or little-endian
+* bswap32: Takes an unsigned 32-bit number in either big- or little-endian
   format and returns the equivalent number with the same bit width but
   opposite endianness.
-* `bswap64`: Takes an unsigned 64-bit number in either big- or little-endian
+* bswap64: Takes an unsigned 64-bit number in either big- or little-endian
   format and returns the equivalent number with the same bit width but
   opposite endianness.
 
@@ -135,34 +135,63 @@ Instruction encoding
 BPF has two instruction encodings:
 
 * the basic instruction encoding, which uses 64 bits to encode an instruction
-* the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
-  constant) value after the basic instruction for a total of 128 bits.
+* the wide instruction encoding, which appends a second 64 bits
+  after the basic instruction for a total of 128 bits.
 
-The fields conforming an encoded basic instruction are stored in the
-following order::
+Basic instruction encoding
+--------------------------
 
-  opcode:8 src_reg:4 dst_reg:4 offset:16 imm:32 // In little-endian BPF.
-  opcode:8 dst_reg:4 src_reg:4 offset:16 imm:32 // In big-endian BPF.
+A basic instruction is encoded as follows::
 
-**imm**
-  signed integer immediate value
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+  |    opcode     |     regs      |            offset             |
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+  |                              imm                              |
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 
-**offset**
-  signed integer offset used with pointer arithmetic
+**opcode**
+  operation to perform, encoded as follows::
 
-**src_reg**
-  the source register number (0-10), except where otherwise specified
-  (`64-bit immediate instructions`_ reuse this field for other purposes)
+    +-+-+-+-+-+-+-+-+
+    |specific |class|
+    +-+-+-+-+-+-+-+-+
 
-**dst_reg**
-  destination register number (0-10)
+  **specific**
+    The format of these bits varies by instruction class
 
-**opcode**
-  operation to perform
+  **class**
+    The instruction class (see `Instruction classes`_)
+
+**regs**
+  The source and destination register numbers, encoded as follows
+  on a little-endian host::
+
+    +-+-+-+-+-+-+-+-+
+    |src_reg|dst_reg|
+    +-+-+-+-+-+-+-+-+
+
+  and as follows on a big-endian host::
+
+    +-+-+-+-+-+-+-+-+
+    |dst_reg|src_reg|
+    +-+-+-+-+-+-+-+-+
+
+  **src_reg**
+    the source register number (0-10), except where otherwise specified
+    (`64-bit immediate instructions`_ reuse this field for other purposes)
+
+  **dst_reg**
+    destination register number (0-10)
+
+**offset**
+  signed integer offset used with pointer arithmetic
+
+**imm**
+  signed integer immediate value
 
-Note that the contents of multi-byte fields ('imm' and 'offset') are
-stored using big-endian byte ordering in big-endian BPF and
-little-endian byte ordering in little-endian BPF.
+Note that the contents of multi-byte fields ('offset' and 'imm') are
+stored using big-endian byte ordering on big-endian hosts and
+little-endian byte ordering on little-endian hosts.
 
 For example::
 
@@ -175,66 +204,83 @@ For example::
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
 
-As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
-instruction uses two 32-bit immediate values that are constructed as follows.
-The 64 bits following the basic instruction contain a pseudo instruction
-using the same format but with 'opcode', 'dst_reg', 'src_reg', and 'offset' all
-set to zero, and imm containing the high 32 bits of the immediate value.
+Wide instruction encoding
+--------------------------
+
+Some instructions are defined to use the wide instruction encoding,
+which uses two 32-bit immediate values.  The 64 bits following
+the basic instruction format contain a pseudo instruction
+with 'opcode', 'dst_reg', 'src_reg', and 'offset' all set to zero.
 
 This is depicted in the following figure::
 
-        basic_instruction
-  .------------------------------.
-  |                              |
-  opcode:8 regs:8 offset:16 imm:32 unused:32 imm:32
-                                   |              |
-                                   '--------------'
-                                  pseudo instruction
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+  |    opcode     |     regs      |            offset             |
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+  |                              imm                              |
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+  |                           reserved                            |
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+  |                           next_imm                            |
+  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+
+**opcode**
+  operation to perform, encoded as explained above
+
+**regs**
+  The source and destination register numbers, encoded as explained above
+
+**offset**
+  signed integer offset used with pointer arithmetic
+
+**imm**
+  signed integer immediate value
+
+**reserved**
+  unused, set to zero
 
-Here, the imm value of the pseudo instruction is called 'next_imm'. The unused
-bytes in the pseudo instruction are reserved and shall be cleared to zero.
+**next_imm**
+  second signed integer immediate value
 
 Instruction classes
 -------------------
 
-The three LSB bits of the 'opcode' field store the instruction class:
-
-=========  =====  ===============================  ===================================
-class      value  description                      reference
-=========  =====  ===============================  ===================================
-BPF_LD     0x00   non-standard load operations     `Load and store instructions`_
-BPF_LDX    0x01   load into register operations    `Load and store instructions`_
-BPF_ST     0x02   store from immediate operations  `Load and store instructions`_
-BPF_STX    0x03   store from register operations   `Load and store instructions`_
-BPF_ALU    0x04   32-bit arithmetic operations     `Arithmetic and jump instructions`_
-BPF_JMP    0x05   64-bit jump operations           `Arithmetic and jump instructions`_
-BPF_JMP32  0x06   32-bit jump operations           `Arithmetic and jump instructions`_
-BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and jump instructions`_
-=========  =====  ===============================  ===================================
+The three least significant bits of the 'opcode' field store the instruction class:
+
+=====  =====  ===============================  ===================================
+class  value  description                      reference
+=====  =====  ===============================  ===================================
+LD     0x0    non-standard load operations     `Load and store instructions`_
+LDX    0x1    load into register operations    `Load and store instructions`_
+ST     0x2    store from immediate operations  `Load and store instructions`_
+STX    0x3    store from register operations   `Load and store instructions`_
+ALU    0x4    32-bit arithmetic operations     `Arithmetic and jump instructions`_
+JMP    0x5    64-bit jump operations           `Arithmetic and jump instructions`_
+JMP32  0x6    32-bit jump operations           `Arithmetic and jump instructions`_
+ALU64  0x7    64-bit arithmetic operations     `Arithmetic and jump instructions`_
+=====  =====  ===============================  ===================================
 
 Arithmetic and jump instructions
 ================================
 
-For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` and
-``BPF_JMP32``), the 8-bit 'opcode' field is divided into three parts:
+For arithmetic and jump instructions (``ALU``, ``ALU64``, ``JMP`` and
+``JMP32``), the 8-bit 'opcode' field is divided into three parts::
 
-==============  ======  =================
-4 bits (MSB)    1 bit   3 bits (LSB)
-==============  ======  =================
-code            source  instruction class
-==============  ======  =================
+  +-+-+-+-+-+-+-+-+
+  |  code |s|class|
+  +-+-+-+-+-+-+-+-+
 
 **code**
   the operation code, whose meaning varies by instruction class
 
-**source**
+**s (source)**
   the source operand location, which unless otherwise specified is one of:
 
   ======  =====  ==============================================
   source  value  description
   ======  =====  ==============================================
-  BPF_K   0x00   use 32-bit 'imm' value as source operand
-  BPF_X   0x08   use 'src_reg' register value as source operand
+  K       0      use 32-bit 'imm' value as source operand
+  X       1      use 'src_reg' register value as source operand
   ======  =====  ==============================================
 
 **instruction class**
@@ -243,75 +289,75 @@ code            source  instruction class
 Arithmetic instructions
 -----------------------
 
-``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
-otherwise identical operations. ``BPF_ALU64`` instructions belong to the
+``ALU`` uses 32-bit wide operands while ``ALU64`` uses 64-bit wide operands for
+otherwise identical operations. ``ALU64`` instructions belong to the
 base64 conformance group unless noted otherwise.
 The 'code' field encodes the operation as below, where 'src' and 'dst' refer
 to the values of the source and destination registers, respectively.
 
-=========  =====  =======  ==========================================================
-code       value  offset   description
-=========  =====  =======  ==========================================================
-BPF_ADD    0x00   0        dst += src
-BPF_SUB    0x10   0        dst -= src
-BPF_MUL    0x20   0        dst \*= src
-BPF_DIV    0x30   0        dst = (src != 0) ? (dst / src) : 0
-BPF_SDIV   0x30   1        dst = (src != 0) ? (dst s/ src) : 0
-BPF_OR     0x40   0        dst \|= src
-BPF_AND    0x50   0        dst &= src
-BPF_LSH    0x60   0        dst <<= (src & mask)
-BPF_RSH    0x70   0        dst >>= (src & mask)
-BPF_NEG    0x80   0        dst = -dst
-BPF_MOD    0x90   0        dst = (src != 0) ? (dst % src) : dst
-BPF_SMOD   0x90   1        dst = (src != 0) ? (dst s% src) : dst
-BPF_XOR    0xa0   0        dst ^= src
-BPF_MOV    0xb0   0        dst = src
-BPF_MOVSX  0xb0   8/16/32  dst = (s8,s16,s32)src
-BPF_ARSH   0xc0   0        :term:`sign extending<Sign Extend>` dst >>= (src & mask)
-BPF_END    0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
-=========  =====  =======  ==========================================================
+=====  =====  =======  ==========================================================
+name   code   offset   description
+=====  =====  =======  ==========================================================
+ADD    0x0    0        dst += src
+SUB    0x1    0        dst -= src
+MUL    0x2    0        dst \*= src
+DIV    0x3    0        dst = (src != 0) ? (dst / src) : 0
+SDIV   0x3    1        dst = (src != 0) ? (dst s/ src) : 0
+OR     0x4    0        dst \|= src
+AND    0x5    0        dst &= src
+LSH    0x6    0        dst <<= (src & mask)
+RSH    0x7    0        dst >>= (src & mask)
+NEG    0x8    0        dst = -dst
+MOD    0x9    0        dst = (src != 0) ? (dst % src) : dst
+SMOD   0x9    1        dst = (src != 0) ? (dst s% src) : dst
+XOR    0xa    0        dst ^= src
+MOV    0xb    0        dst = src
+MOVSX  0xb    8/16/32  dst = (s8,s16,s32)src
+ARSH   0xc    0        :term:`sign extending<Sign Extend>` dst >>= (src & mask)
+END    0xd    0        byte swap operations (see `Byte swap instructions`_ below)
+=====  =====  =======  ==========================================================
 
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If BPF program execution would
 result in division by zero, the destination register is instead set to zero.
-If execution would result in modulo by zero, for ``BPF_ALU64`` the value of
-the destination register is unchanged whereas for ``BPF_ALU`` the upper
+If execution would result in modulo by zero, for ``ALU64`` the value of
+the destination register is unchanged whereas for ``ALU`` the upper
 32 bits of the destination register are zeroed.
 
-``BPF_ADD | BPF_X | BPF_ALU`` means::
+``{ADD, X, ALU}``, where 'code'=``ADD``, 'source'=``X``, and 'class'=``ALU``, means::
 
   dst = (u32) ((u32) dst + (u32) src)
 
 where '(u32)' indicates that the upper 32 bits are zeroed.
 
-``BPF_ADD | BPF_X | BPF_ALU64`` means::
+``{ADD, X, ALU64}`` means::
 
   dst = dst + src
 
-``BPF_XOR | BPF_K | BPF_ALU`` means::
+``{XOR, K, ALU}`` means::
 
   dst = (u32) dst ^ (u32) imm
 
-``BPF_XOR | BPF_K | BPF_ALU64`` means::
+``{XOR, K, ALU64}`` means::
 
   dst = dst ^ imm
 
 Note that most instructions have instruction offset of 0. Only three instructions
-(``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
+(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero offset.
 
-Division, multiplication, and modulo operations for ``BPF_ALU`` are part
+Division, multiplication, and modulo operations for ``ALU`` are part
 of the "divmul32" conformance group, and division, multiplication, and
-modulo operations for ``BPF_ALU64`` are part of the "divmul64" conformance
+modulo operations for ``ALU64`` are part of the "divmul64" conformance
 group.
 The division and modulo operations support both unsigned and signed flavors.
 
-For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
-'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
+For unsigned operations (``DIV`` and ``MOD``), for ``ALU``,
+'imm' is interpreted as a 32-bit unsigned value. For ``ALU64``,
 'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
 interpreted as a 64-bit unsigned value.
 
-For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
-'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
+For signed operations (``SDIV`` and ``SMOD``), for ``ALU``,
+'imm' is interpreted as a 32-bit signed value. For ``ALU64``, 'imm'
 is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
 interpreted as a 64-bit signed value.
 
@@ -323,15 +369,15 @@ etc. This specification requires that signed modulo use truncated division
 
    a % n = a - n * trunc(a / n)
 
-The ``BPF_MOVSX`` instruction does a move operation with sign extension.
-``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
+The ``MOVSX`` instruction does a move operation with sign extension.
+``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
 bit operands, and zeroes the remaining upper 32 bits.
-``BPF_ALU64 | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
+``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
 operands into 64 bit operands.  Unlike other arithmetic instructions,
-``BPF_MOVSX`` is only defined for register source operands (``BPF_X``).
+``MOVSX`` is only defined for register source operands (``X``).
 
-The ``BPF_NEG`` instruction is only defined when the source bit is clear
-(``BPF_K``).
+The ``NEG`` instruction is only defined when the source bit is clear
+(``K``).
 
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
 for 32-bit operations.
@@ -339,24 +385,24 @@ for 32-bit operations.
 Byte swap instructions
 ----------------------
 
-The byte swap instructions use instruction classes of ``BPF_ALU`` and ``BPF_ALU64``
-and a 4-bit 'code' field of ``BPF_END``.
+The byte swap instructions use instruction classes of ``ALU`` and ``ALU64``
+and a 4-bit 'code' field of ``END``.
 
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to
+For ``ALU``, the 1-bit source operand field in the opcode is used to
 select what byte order the operation converts from or to. For
-``BPF_ALU64``, the 1-bit source operand field in the opcode is reserved
+``ALU64``, the 1-bit source operand field in the opcode is reserved
 and must be set to 0.
 
-=========  =========  =====  =================================================
-class      source     value  description
-=========  =========  =====  =================================================
-BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little endian
-BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big endian
-BPF_ALU64  Reserved   0x00   do byte swap unconditionally
-=========  =========  =====  =================================================
+=====  ========  =====  =================================================
+class  source    value  description
+=====  ========  =====  =================================================
+ALU    TO_LE     0      convert between host byte order and little endian
+ALU    TO_BE     1      convert between host byte order and big endian
+ALU64  Reserved  0      do byte swap unconditionally
+=====  ========  =====  =================================================
 
 The 'imm' field encodes the width of the swap operations.  The following widths
 are supported: 16, 32 and 64.  Width 64 operations belong to the base64
@@ -365,19 +411,19 @@ conformance group.
 
 Examples:
 
-``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
+``{END, TO_LE, ALU}`` with imm = 16/32/64 means::
 
   dst = htole16(dst)
   dst = htole32(dst)
   dst = htole64(dst)
 
-``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 16/32/64 means::
+``{END, TO_BE, ALU}`` with imm = 16/32/64 means::
 
   dst = htobe16(dst)
   dst = htobe32(dst)
   dst = htobe64(dst)
 
-``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
+``{END, TO_LE, ALU64}`` with imm = 16/32/64 means::
 
   dst = bswap16(dst)
   dst = bswap32(dst)
@@ -386,59 +432,59 @@ Examples:
 Jump instructions
 -----------------
 
-``BPF_JMP32`` uses 32-bit wide operands and indicates the base32
-conformance group, while ``BPF_JMP`` uses 64-bit wide operands for
+``JMP32`` uses 32-bit wide operands and indicates the base32
+conformance group, while ``JMP`` uses 64-bit wide operands for
 otherwise identical operations, and indicates the base64 conformance
 group unless otherwise specified.
 The 'code' field encodes the operation as below:
 
-========  =====  =======  ===============================  =============================================
+========  =====  =======  ===============================  ===================================================
 code      value  src_reg  description                      notes
-========  =====  =======  ===============================  =============================================
-BPF_JA    0x0    0x0      PC += offset                     BPF_JMP | BPF_K only
-BPF_JA    0x0    0x0      PC += imm                        BPF_JMP32 | BPF_K only
-BPF_JEQ   0x1    any      PC += offset if dst == src
-BPF_JGT   0x2    any      PC += offset if dst > src        unsigned
-BPF_JGE   0x3    any      PC += offset if dst >= src       unsigned
-BPF_JSET  0x4    any      PC += offset if dst & src
-BPF_JNE   0x5    any      PC += offset if dst != src
-BPF_JSGT  0x6    any      PC += offset if dst > src        signed
-BPF_JSGE  0x7    any      PC += offset if dst >= src       signed
-BPF_CALL  0x8    0x0      call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
-BPF_CALL  0x8    0x1      call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
-BPF_CALL  0x8    0x2      call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
-BPF_EXIT  0x9    0x0      return                           BPF_JMP | BPF_K only
-BPF_JLT   0xa    any      PC += offset if dst < src        unsigned
-BPF_JLE   0xb    any      PC += offset if dst <= src       unsigned
-BPF_JSLT  0xc    any      PC += offset if dst < src        signed
-BPF_JSLE  0xd    any      PC += offset if dst <= src       signed
-========  =====  =======  ===============================  =============================================
-
-The BPF program needs to store the return value into register R0 before doing a
-``BPF_EXIT``.
+========  =====  =======  ===============================  ===================================================
+JA        0x0    0x0      PC += offset                     {JA, K, JMP} only
+JA        0x0    0x0      PC += imm                        {JA, K, JMP32} only
+JEQ       0x1    any      PC += offset if dst == src
+JGT       0x2    any      PC += offset if dst > src        unsigned
+JGE       0x3    any      PC += offset if dst >= src       unsigned
+JSET      0x4    any      PC += offset if dst & src
+JNE       0x5    any      PC += offset if dst != src
+JSGT      0x6    any      PC += offset if dst > src        signed
+JSGE      0x7    any      PC += offset if dst >= src       signed
+CALL      0x8    0x0      call helper function by address  {CALL, K, JMP} only, see `Helper functions`_
+CALL      0x8    0x1      call PC += imm                   {CALL, K, JMP} only, see `Program-local functions`_
+CALL      0x8    0x2      call helper function by BTF ID   {CALL, K, JMP} only, see `Helper functions`_
+EXIT      0x9    0x0      return                           {CALL, K, JMP} only
+JLT       0xa    any      PC += offset if dst < src        unsigned
+JLE       0xb    any      PC += offset if dst <= src       unsigned
+JSLT      0xc    any      PC += offset if dst < src        signed
+JSLE      0xd    any      PC += offset if dst <= src       signed
+========  =====  =======  ===============================  ===================================================
+
+The BPF program needs to store the return value into register R0 before doing an
+``EXIT``.
 
 Example:
 
-``BPF_JSGE | BPF_X | BPF_JMP32`` (0x7e) means::
+``{JSGE, X, JMP32}`` means::
 
   if (s32)dst s>= (s32)src goto +offset
 
 where 's>=' indicates a signed '>=' comparison.
 
-``BPF_JA | BPF_K | BPF_JMP32`` (0x06) means::
+``{JA, K, JMP32}`` means::
 
   gotol +imm
 
 where 'imm' means the branch offset comes from insn 'imm' field.
 
-Note that there are two flavors of ``BPF_JA`` instructions. The
-``BPF_JMP`` class permits a 16-bit jump offset specified by the 'offset'
-field, whereas the ``BPF_JMP32`` class permits a 32-bit jump offset
+Note that there are two flavors of ``JA`` instructions. The
+``JMP`` class permits a 16-bit jump offset specified by the 'offset'
+field, whereas the ``JMP32`` class permits a 32-bit jump offset
 specified by the 'imm' field. A > 16-bit conditional jump may be
 converted to a < 16-bit conditional jump plus a 32-bit unconditional
 jump.
 
-All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
+All ``CALL`` and ``JA`` instructions belong to the
 base32 conformance group.
 
 Helper functions
@@ -459,80 +505,83 @@ Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
 Program-local functions are functions exposed by the same BPF program as the
 caller, and are referenced by offset from the call instruction, similar to
-``BPF_JA``.  The offset is encoded in the imm field of the call instruction.
-A ``BPF_EXIT`` within the program-local function will return to the caller.
+``JA``.  The offset is encoded in the imm field of the call instruction.
+A ``EXIT`` within the program-local function will return to the caller.
 
 Load and store instructions
 ===========================
 
-For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_STX``), the
-8-bit 'opcode' field is divided as:
-
-============  ======  =================
-3 bits (MSB)  2 bits  3 bits (LSB)
-============  ======  =================
-mode          size    instruction class
-============  ======  =================
-
-The mode modifier is one of:
-
-  =============  =====  ====================================  =============
-  mode modifier  value  description                           reference
-  =============  =====  ====================================  =============
-  BPF_IMM        0x00   64-bit immediate instructions         `64-bit immediate instructions`_
-  BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
-  BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
-  BPF_MEM        0x60   regular load and store operations     `Regular load and store operations`_
-  BPF_MEMSX      0x80   sign-extension load operations        `Sign-extension load operations`_
-  BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
-  =============  =====  ====================================  =============
-
-The size modifier is one of:
-
-  =============  =====  =====================
-  size modifier  value  description
-  =============  =====  =====================
-  BPF_W          0x00   word        (4 bytes)
-  BPF_H          0x08   half word   (2 bytes)
-  BPF_B          0x10   byte
-  BPF_DW         0x18   double word (8 bytes)
-  =============  =====  =====================
-
-Instructions using ``BPF_DW`` belong to the base64 conformance group.
+For load and store instructions (``LD``, ``LDX``, ``ST``, and ``STX``), the
+8-bit 'opcode' field is divided as::
+
+  +-+-+-+-+-+-+-+-+
+  |mode |sz |class|
+  +-+-+-+-+-+-+-+-+
+
+**mode**
+  The mode modifier is one of:
+
+    =============  =====  ====================================  =============
+    mode modifier  value  description                           reference
+    =============  =====  ====================================  =============
+    IMM            0      64-bit immediate instructions         `64-bit immediate instructions`_
+    ABS            1      legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
+    IND            2      legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
+    MEM            3      regular load and store operations     `Regular load and store operations`_
+    MEMSX          4      sign-extension load operations        `Sign-extension load operations`_
+    ATOMIC         6      atomic operations                     `Atomic operations`_
+    =============  =====  ====================================  =============
+
+**sz (size)**
+  The size modifier is one of:
+
+    ====  =====  =====================
+    size  value  description
+    ====  =====  =====================
+    W     0      word        (4 bytes)
+    H     1      half word   (2 bytes)
+    B     2      byte
+    DW    3      double word (8 bytes)
+    ====  =====  =====================
+
+  Instructions using ``DW`` belong to the base64 conformance group.
+
+**class**
+  The instruction class (see `Instruction classes`_)
 
 Regular load and store operations
 ---------------------------------
 
-The ``BPF_MEM`` mode modifier is used to encode regular load and store
+The ``MEM`` mode modifier is used to encode regular load and store
 instructions that transfer data between a register and memory.
 
-``BPF_MEM | <size> | BPF_STX`` means::
+``{MEM, <size>, STX}`` means::
 
   *(size *) (dst + offset) = src
 
-``BPF_MEM | <size> | BPF_ST`` means::
+``{MEM, <size>, ST}`` means::
 
   *(size *) (dst + offset) = imm
 
-``BPF_MEM | <size> | BPF_LDX`` means::
+``{MEM, <size>, LDX}`` means::
 
   dst = *(unsigned size *) (src + offset)
 
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
-'unsigned size' is one of u8, u16, u32 or u64.
+Where '<size>' is one of: ``B``, ``H``, ``W``, or ``DW``, and
+'unsigned size' is one of: u8, u16, u32, or u64.
 
 Sign-extension load operations
 ------------------------------
 
-The ``BPF_MEMSX`` mode modifier is used to encode :term:`sign-extension<Sign Extend>` load
+The ``MEMSX`` mode modifier is used to encode :term:`sign-extension<Sign Extend>` load
 instructions that transfer data between a register and memory.
 
-``BPF_MEMSX | <size> | BPF_LDX`` means::
+``{MEMSX, <size>, LDX}`` means::
 
   dst = *(signed size *) (src + offset)
 
-Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
-'signed size' is one of s8, s16 or s32.
+Where size is one of: ``B``, ``H``, or ``W``, and
+'signed size' is one of: s8, s16, or s32.
 
 Atomic operations
 -----------------
@@ -542,11 +591,11 @@ interrupted or corrupted by other access to the same memory region
 by other BPF programs or means outside of this specification.
 
 All atomic operations supported by BPF are encoded as store operations
-that use the ``BPF_ATOMIC`` mode modifier as follows:
+that use the ``ATOMIC`` mode modifier as follows:
 
-* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations, which are
+* ``{ATOMIC, W, STX}`` for 32-bit operations, which are
   part of the "atomic32" conformance group.
-* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations, which are
+* ``{ATOMIC, DW, STX}`` for 64-bit operations, which are
   part of the "atomic64" conformance group.
 * 8-bit and 16-bit wide atomic operations are not supported.
 
@@ -557,18 +606,18 @@ arithmetic operations in the 'imm' field to encode the atomic operation:
 ========  =====  ===========
 imm       value  description
 ========  =====  ===========
-BPF_ADD   0x00   atomic add
-BPF_OR    0x40   atomic or
-BPF_AND   0x50   atomic and
-BPF_XOR   0xa0   atomic xor
+ADD       0x00   atomic add
+OR        0x40   atomic or
+AND       0x50   atomic and
+XOR       0xa0   atomic xor
 ========  =====  ===========
 
 
-``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
+``{ATOMIC, W, STX}`` with 'imm' = ADD means::
 
   *(u32 *)(dst + offset) += src
 
-``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF_ADD means::
+``{ATOMIC, DW, STX}`` with 'imm' = ADD means::
 
   *(u64 *)(dst + offset) += src
 
@@ -578,20 +627,20 @@ two complex atomic operations:
 ===========  ================  ===========================
 imm          value             description
 ===========  ================  ===========================
-BPF_FETCH    0x01              modifier: return old value
-BPF_XCHG     0xe0 | BPF_FETCH  atomic exchange
-BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
+FETCH        0x01              modifier: return old value
+XCHG         0xe0 | FETCH      atomic exchange
+CMPXCHG      0xf0 | FETCH      atomic compare and exchange
 ===========  ================  ===========================
 
-The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
-always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
+The ``FETCH`` modifier is optional for simple atomic operations, and
+always set for the complex atomic operations.  If the ``FETCH`` flag
 is set, then the operation also overwrites ``src`` with the value that
 was in memory before it was modified.
 
-The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
+The ``XCHG`` operation atomically exchanges ``src`` with the value
 addressed by ``dst + offset``.
 
-The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
+The ``CMPXCHG`` operation atomically compares the value addressed by
 ``dst + offset`` with ``R0``. If they match, the value addressed by
 ``dst + offset`` is replaced with ``src``. In either case, the
 value that was at ``dst + offset`` before the operation is zero-extended
@@ -600,25 +649,25 @@ and loaded back to ``R0``.
 64-bit immediate instructions
 -----------------------------
 
-Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
+Instructions with the ``IMM`` 'mode' modifier use the wide instruction
 encoding defined in `Instruction encoding`_, and use the 'src_reg' field of the
 basic instruction to hold an opcode subtype.
 
-The following table defines a set of ``BPF_IMM | BPF_DW | BPF_LD`` instructions
+The following table defines a set of ``{IMM, DW, LD}`` instructions
 with opcode subtypes in the 'src_reg' field, using new terms such as "map"
 defined further below:
 
-=========================  ======  =======  =========================================  ===========  ==============
-opcode construction        opcode  src_reg  pseudocode                                 imm type     dst type
-=========================  ======  =======  =========================================  ===========  ==============
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x0      dst = (next_imm << 32) | imm               integer      integer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x1      dst = map_by_fd(imm)                       map fd       map
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x3      dst = var_addr(imm)                        variable id  data pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x4      dst = code_addr(imm)                       integer      code pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x5      dst = map_by_idx(imm)                      map index    map
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
-=========================  ======  =======  =========================================  ===========  ==============
+=======  =========================================  ===========  ==============
+src_reg  pseudocode                                 imm type     dst type
+=======  =========================================  ===========  ==============
+0x0      dst = (next_imm << 32) | imm               integer      integer
+0x1      dst = map_by_fd(imm)                       map fd       map
+0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
+0x3      dst = var_addr(imm)                        variable id  data pointer
+0x4      dst = code_addr(imm)                       integer      code pointer
+0x5      dst = map_by_idx(imm)                      map index    map
+0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
+=======  =========================================  ===========  ==============
 
 where
 
@@ -657,8 +706,8 @@ Legacy BPF Packet access instructions
 
 BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. These instructions used an instruction
-class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
-mode modifier of BPF_ABS or BPF_IND.  The 'dst_reg' and 'offset' fields were
-set to zero, and 'src_reg' was set to zero for BPF_ABS.  However, these
+class of ``LD``, a size modifier of ``W``, ``H``, or ``B``, and a
+mode modifier of ``ABS`` or ``IND``.  The 'dst_reg' and 'offset' fields were
+set to zero, and 'src_reg' was set to zero for ``ABS``.  However, these
 instructions are deprecated and should no longer be used.  All legacy packet
 access instructions belong to the "legacy" conformance group.
-- 
2.40.1


