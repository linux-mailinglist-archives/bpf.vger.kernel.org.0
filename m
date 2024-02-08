Return-Path: <bpf+bounces-21555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5384EBB4
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B21F27A76
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45341A91;
	Thu,  8 Feb 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BOLQetNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C444F8BA
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707431565; cv=none; b=Glzh4pRaePRt/WM70o/3As9FVbdlOcdgB0LNkUnOcZXZ+4roHlQFEy/Y7PdYKxcvnI7xHTC6UCR3tm3Zhrbfk1PKmI+LjYRxz5jPYy0Kj2g3ETyqZlvTJfcizbrJGAmO1HYIIgaAwrhc+jA2svKAuZVXN+4djmB/fmNNuvtmcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707431565; c=relaxed/simple;
	bh=vn+cEvighPjZKpyQdgEE+4zXjPaHdT6q9dDD472fPS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5DYLmOEUyVelIB5bOIhmJ+cq6+8ekpaJ1aUnqUbw5lEWw2bwFoP/6cnw7ljbnKatOc0XPT35GtHSxUec84Qi77a9oKU3aO2Fk0iPXuGXnDiUT4mz3/M4p8khgKIAHf6dXXEJ/7jEZHfXU7xEV44G1k1d/mc+IX+bRRiIMqXMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BOLQetNo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e05f6c7f50so255686b3a.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 14:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707431563; x=1708036363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9WmWWoqgQMUOKjDh/gXP7em1keHy9w0N/gQ7JlSOH8=;
        b=BOLQetNos7ofQ8xDToGOc3Dq5FmxKbjaKbQZiiJAL5xrf37fHrgmekYe+I0OL9DksW
         wrlpM06/jCyGN9uj1gUQ02yjoRbA9ip0Wx+4f+hSWPBTLB+NkE7+eEHl+cZf1Rmbt7Ge
         8idbxv/Vp2fgJo24vkIA1pjBAwrgxQCNflRaJJwsvkciduq8tND6cK3j7h06JazRLPQ6
         pbSQkP80gxPiPvjs0K9dplUtwXz/7Mk49HmStWJZhPJKwfkkRkKkXikMmQX2fGYbt4xf
         h6WJGeHTUnjYmZfQi07aKTZaatGsF5f/4cNgdbXwXoBvfLwNGgL7lOfyn8nvVtRnBRRk
         rzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707431563; x=1708036363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9WmWWoqgQMUOKjDh/gXP7em1keHy9w0N/gQ7JlSOH8=;
        b=FgVSZtxHTW8iBznIEilqZ5G3rWtc0cKL9O0H3A2BBObM08uRUabTBPrNOqPBFIv+LL
         VR+fsmWdXmq4ir9ckthIvZa+8US6e8QYs8ChaQ2WiDZp9Q2rxklJ3Vq8XeFp/H+zwi+4
         dYxFDLjF+fphFbCn0/7l7w3MZEJdD/SR9jDLyDPNmLumj1g0Ryf7H5mOnt8lZ6mekjDd
         HVgBHDWLuVsqMbsk3p6JlikoWqa3R0NDlNCnaVViM5EsvlaoYwpDs4Ljd24Wq+hx0Zh4
         tZp1JI1ZywiH0xiqqREZ1pqIcvKgIA7jXFbVdOVy0/0M5lK910KmUGUHws+7MwtB90u9
         fNlg==
X-Gm-Message-State: AOJu0Yx3iqD8EnHYzHqocRD0elSZEJMoqlezD5/s0EJT/kBDGdNdsHQQ
	u2/7KAylRxndmn7+yu515m/iOSs9F7dYKPG+e8//UNDmNKkgc56Q6sGNAZ8iucw=
X-Google-Smtp-Source: AGHT+IGy4W79ZFp+NVFu3h4Tybt2Vka4WAHaPp+t1LGDWLUpwJ+rqAb+7Sj95ao2MACyGq+NcQh/mw==
X-Received: by 2002:a05:6a20:431a:b0:19c:9a26:b958 with SMTP id h26-20020a056a20431a00b0019c9a26b958mr1290223pzk.35.1707431562754;
        Thu, 08 Feb 2024 14:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRy9PkXzF1LhgDG9WyE/ayniozsrgXwCjhm6X3NKlYjwXyVR8j61LiYGIYQWXF+MEL4ZtV06/8lchdTGzijfLfspdSWQc=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b006ddcf5d5b0bsm271088pfn.153.2024.02.08.14.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:32:42 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Add callx instructions in new conformance group
Date: Thu,  8 Feb 2024 14:32:37 -0800
Message-Id: <20240208223237.12528-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Add a "callx" conformance group
* Add callx rows to table
* Update helper function to section to be agnostic between BPF_K vs
  BPF_X
* Rename "legacy" conformance group to "packet"

Based on mailing list discussion at
https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..8f0ada22e 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -127,7 +127,7 @@ This document defines the following conformance groups:
 * divmul32: includes 32-bit division, multiplication, and modulo instructions.
 * divmul64: includes divmul32, plus 64-bit division, multiplication,
   and modulo instructions.
-* legacy: deprecated packet access instructions.
+* packet: deprecated packet access instructions.
 
 Instruction encoding
 ====================
@@ -404,9 +404,12 @@ BPF_JSET  0x4    any  PC += offset if dst & src
 BPF_JNE   0x5    any  PC += offset if dst != src
 BPF_JSGT  0x6    any  PC += offset if dst > src        signed
 BPF_JSGE  0x7    any  PC += offset if dst >= src       signed
-BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K only
+BPF_CALL  0x8    0x0  call_by_address(reg_val(imm))    BPF_JMP | BPF_X only
 BPF_CALL  0x8    0x1  call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
-BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X only, see `Program-local functions`_
+BPF_CALL  0x8    0x2  call_by_btfid(imm)               BPF_JMP | BPF_K only
+BPF_CALL  0x8    0x2  call_by_btfid(reg_val(imm))      BPF_JMP | BPF_X only
 BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K only
 BPF_JLT   0xa    any  PC += offset if dst < src        unsigned
 BPF_JLE   0xb    any  PC += offset if dst <= src       unsigned
@@ -414,6 +417,12 @@ BPF_JSLT  0xc    any  PC += offset if dst < src        signed
 BPF_JSLE  0xd    any  PC += offset if dst <= src       signed
 ========  =====  ===  ===============================  =============================================
 
+where
+
+* reg_val(imm) gets the value of the register with the specified number
+* call_by_address(value) means to call a helper function by address (see `Helper functions`_ for details)
+* call_by_btfid(value) means to call a helper function by BTF ID (see `Helper functions`_ for details)
+
 The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
 
@@ -438,8 +447,9 @@ specified by the 'imm' field. A > 16-bit conditional jump may be
 converted to a < 16-bit conditional jump plus a 32-bit unconditional
 jump.
 
-All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
-base32 conformance group.
+All ``BPF_CALL | BPF_X`` instructions belong to the callx
+conformance group.  All other ``BPF_CALL`` instructions and all
+``BPF_JA`` instructions belong to the base32 conformance group.
 
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -447,13 +457,13 @@ Helper functions
 Helper functions are a concept whereby BPF programs can call into a
 set of function calls exposed by the underlying platform.
 
-Historically, each helper function was identified by an address
-encoded in the imm field.  The available helper functions may differ
-for each program type, but address values are unique across all program types.
+Historically, each helper function was identified by an address.
+The available helper functions may differ for each program type,
+but address values are unique across all program types.
 
 Platforms that support the BPF Type Format (BTF) support identifying
-a helper function by a BTF ID encoded in the imm field, where the BTF ID
-identifies the helper name and type.
+a helper function by a BTF ID, where the BTF ID identifies the helper
+name and type.
 
 Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -660,4 +670,4 @@ carried over from classic BPF. These instructions used an instruction
 class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
 mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
-instructions belong to the "legacy" conformance group.
+instructions belong to the "packet" conformance group.
-- 
2.40.1


