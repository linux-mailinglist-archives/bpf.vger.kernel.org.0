Return-Path: <bpf+bounces-22442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D585E4A8
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F63B237DA
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBF83CCA;
	Wed, 21 Feb 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KCPPjU5l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFC1C20
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536941; cv=none; b=RSK32isIDgpPcSG2dPQ5o3mZfmK7bOCovuUXB+Y8UIXcvFL9s7DYWUc37ILymwYYTN2aIM8b3UqG1eFPQhhMX1lZmb/tJD+PvsyOSM9EipXbngtozkk9n3T2muJex98mrEewwhKSSOnQ2nRcv+PviltKQGr5csBseV66EAhLlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536941; c=relaxed/simple;
	bh=aUhT0quApuIm3PO4kFgyAAxM9KL9DzcAopSqegYFazE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q0pYftYts9T0xTfLxXLy75AbVaAuZ8CiDd4uj6cJT5nrD7MQ2P+9OR/FzcffrP/vzRf8IN3QUKsSpMkDu+vYUURywImw+nLAJto+0r0uXSFg6miN0vSlgOoyPD393TltHtMSibLDc7ebDkzaPge8ekZ0NBmSDt9gfSlFT+fEt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KCPPjU5l; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso5713172a12.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 09:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708536939; x=1709141739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpj+dPbs6Bu1AaIzKNJqZxlV6H6VhuRxK9TUVjicr9s=;
        b=KCPPjU5lxOB8O6S7ZmSm6kQGP4e52CCViy9dsD8IluggsUtVQTdxlHvibuiL63VN1E
         PrJs1gnuzlUDIanKL7qVq4PI9NTcyeixH6TtStM0QkxDCWuQoYbRrHCJL71oBzyDwifd
         NFKI2onxd2s1ASUCrm0W1ievwhLkznyAVYEbjX7xzxFINX0Zh5SFFgeJrUBD5FKT5x0M
         gYwSqh+I1zQIlmvZ8/q109G2mEgTp1NQDlqXrifkfSk9gdrwYbTf6cWC1EHwizmOSch2
         uC37WlXyiuA/+vTXfuKr4zeJ+/kjGqDzZqg0ZTtnD2GZuv9HGcxXG0P25IdUBrQq9dhN
         UhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536939; x=1709141739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wpj+dPbs6Bu1AaIzKNJqZxlV6H6VhuRxK9TUVjicr9s=;
        b=td878E5uj9W19wZTX+kDSShoyUkOyMhjueyMJIY+hvJ0xGDoqkgWrL107fwW/axgjy
         fXeb4YTNP++mqR28x1K5FiW7WqPKkgTeqvka06Je51iI7e7vtaaziv1vVq3c2vS73gGc
         2+k4zzzhr8i0+gvcjjQAEOutTHThbvENN/+i/EiZMCPAvdfr8PHireMWFPmqcWeIMUxu
         Av9Td1S02Sq1YEoehx6nbDttmw1jOSOKIYGpdBzdTskQaOC2udP44H79cLnZUQ7Q0X7a
         6bBKjWT6FY3MJ5uxmgJxUtsyFecbcSysX/0r7ajn8aeB2+BgzY43+6uNUetU4x8UzzSI
         iI9w==
X-Gm-Message-State: AOJu0YwG905k5q9KP93esORmL37rrmymdCDIohzQi47lb/auOkI2HRqx
	5XEpPJyNwCT6rmJ73xZaNtq/05Yeh31mcYPH3mRg4tDqKMASCQ93a9Ar15m9zMQ=
X-Google-Smtp-Source: AGHT+IEhw3qZ/ySFNjXs7jxgsLM6rU4BeheA9SRanQkzz8/Fs4zHlksf1nSq+sce6lrLdARGxAhu0Q==
X-Received: by 2002:a05:6a21:1394:b0:1a0:9e45:1537 with SMTP id oa20-20020a056a21139400b001a09e451537mr10368905pzb.30.1708536939122;
        Wed, 21 Feb 2024 09:35:39 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id h24-20020aa786d8000000b006e04553a4c5sm7343197pfo.52.2024.02.21.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:35:38 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Fix typos in instruction-set.rst
Date: Wed, 21 Feb 2024 09:35:35 -0800
Message-Id: <20240221173535.16601-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* "BPF ADD" should be "BPF_ADD".
* "src" should be "src_reg" in several places.  The latter is the field name
  in the instruction.  The former refers to the value of the register, or the
  immediate.
* Add '' around field names in one sentence, for consistency with the rest
  of the document.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 868d9f617..56b5e7dad 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -178,7 +178,7 @@ Unused fields shall be cleared to zero.
 As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
 instruction uses two 32-bit immediate values that are constructed as follows.
 The 64 bits following the basic instruction contain a pseudo instruction
-using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
+using the same format but with 'opcode', 'dst_reg', 'src_reg', and 'offset' all set to zero,
 and imm containing the high 32 bits of the immediate value.
 
 This is depicted in the following figure::
@@ -392,27 +392,27 @@ otherwise identical operations, and indicates the base64 conformance
 group unless otherwise specified.
 The 'code' field encodes the operation as below:
 
-========  =====  ===  ===============================  =============================================
-code      value  src  description                      notes
-========  =====  ===  ===============================  =============================================
-BPF_JA    0x0    0x0  PC += offset                     BPF_JMP | BPF_K only
-BPF_JA    0x0    0x0  PC += imm                        BPF_JMP32 | BPF_K only
-BPF_JEQ   0x1    any  PC += offset if dst == src
-BPF_JGT   0x2    any  PC += offset if dst > src        unsigned
-BPF_JGE   0x3    any  PC += offset if dst >= src       unsigned
-BPF_JSET  0x4    any  PC += offset if dst & src
-BPF_JNE   0x5    any  PC += offset if dst != src
-BPF_JSGT  0x6    any  PC += offset if dst > src        signed
-BPF_JSGE  0x7    any  PC += offset if dst >= src       signed
-BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
-BPF_CALL  0x8    0x1  call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
-BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
-BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K only
-BPF_JLT   0xa    any  PC += offset if dst < src        unsigned
-BPF_JLE   0xb    any  PC += offset if dst <= src       unsigned
-BPF_JSLT  0xc    any  PC += offset if dst < src        signed
-BPF_JSLE  0xd    any  PC += offset if dst <= src       signed
-========  =====  ===  ===============================  =============================================
+========  =====  =======  ===============================  =============================================
+code      value  src_reg  description                      notes
+========  =====  =======  ===============================  =============================================
+BPF_JA    0x0    0x0      PC += offset                     BPF_JMP | BPF_K only
+BPF_JA    0x0    0x0      PC += imm                        BPF_JMP32 | BPF_K only
+BPF_JEQ   0x1    any      PC += offset if dst == src
+BPF_JGT   0x2    any      PC += offset if dst > src        unsigned
+BPF_JGE   0x3    any      PC += offset if dst >= src       unsigned
+BPF_JSET  0x4    any      PC += offset if dst & src
+BPF_JNE   0x5    any      PC += offset if dst != src
+BPF_JSGT  0x6    any      PC += offset if dst > src        signed
+BPF_JSGE  0x7    any      PC += offset if dst >= src       signed
+BPF_CALL  0x8    0x0      call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x1      call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
+BPF_CALL  0x8    0x2      call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_EXIT  0x9    0x0      return                           BPF_JMP | BPF_K only
+BPF_JLT   0xa    any      PC += offset if dst < src        unsigned
+BPF_JLE   0xb    any      PC += offset if dst <= src       unsigned
+BPF_JSLT  0xc    any      PC += offset if dst < src        signed
+BPF_JSLE  0xd    any      PC += offset if dst <= src       signed
+========  =====  =======  ===============================  =============================================
 
 The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
@@ -568,7 +568,7 @@ BPF_XOR   0xa0   atomic xor
 
   *(u32 *)(dst + offset) += src
 
-``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
+``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF_ADD means::
 
   *(u64 *)(dst + offset) += src
 
@@ -601,24 +601,24 @@ and loaded back to ``R0``.
 -----------------------------
 
 Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
-encoding defined in `Instruction encoding`_, and use the 'src' field of the
+encoding defined in `Instruction encoding`_, and use the 'src_reg' field of the
 basic instruction to hold an opcode subtype.
 
 The following table defines a set of ``BPF_IMM | BPF_DW | BPF_LD`` instructions
-with opcode subtypes in the 'src' field, using new terms such as "map"
+with opcode subtypes in the 'src_reg' field, using new terms such as "map"
 defined further below:
 
-=========================  ======  ===  =========================================  ===========  ==============
-opcode construction        opcode  src  pseudocode                                 imm type     dst type
-=========================  ======  ===  =========================================  ===========  ==============
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = (next_imm << 32) | imm               integer      integer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
-=========================  ======  ===  =========================================  ===========  ==============
+=========================  ======  =======  =========================================  ===========  ==============
+opcode construction        opcode  src_reg  pseudocode                                 imm type     dst type
+=========================  ======  =======  =========================================  ===========  ==============
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x0      dst = (next_imm << 32) | imm               integer      integer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x1      dst = map_by_fd(imm)                       map fd       map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x3      dst = var_addr(imm)                        variable id  data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x4      dst = code_addr(imm)                       integer      code pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x5      dst = map_by_idx(imm)                      map index    map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
+=========================  ======  =======  =========================================  ===========  ==============
 
 where
 
-- 
2.40.1


