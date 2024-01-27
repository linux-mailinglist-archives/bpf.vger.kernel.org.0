Return-Path: <bpf+bounces-20477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0683EEE4
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F879B22064
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3BA2C6B9;
	Sat, 27 Jan 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IBAlOI5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047028DCA
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706375001; cv=none; b=J58tWBr92+pulPMMMsKArRNrqrJVdAeQ6ZZyqaJTCEtFUV/4EXpNXl6y+7aW6/Z0TmwmgdVVODX9VwWvLI0vXGT6OaRJbcEI8GH6s08NOh2p8CaYKcVtUetJr0Yx8+HJKt38L8HQdsny3lsv/B5tqZsS7/lqr5DC49KD9gGsIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706375001; c=relaxed/simple;
	bh=A+MCqMoBW6PNPQQvLwdQur9D6SSrQbMwh+Q0QJ8xyvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDFzLPuc2RFQcdigKqQAbJb/6Ex9IyiSg2kAedhPy1XCtYz3zR2MprADVdVzb2pWAWI9oYn+OXn7QB28oEDp3S0CEzhL8uEW5iIxlQOOc45CQoBvZrNL/Y0EDcmm8fvRlIv6/Jb80aWJqIxt+q0LV3vITn0tkq4guqQSNlqItgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IBAlOI5K; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc1fad6ddso1477380b3a.0
        for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706374999; x=1706979799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWyaKyAFFUwbtL2A1v+B7Llf8kWXgM4xN4d+iBYkEj4=;
        b=IBAlOI5KP+oa0hNqFGCRt9+CmjPWCtwRJF9A/UiqHRC828K4K4TNXxY3rhLqTPAe3t
         f2FtX4a3WDnJBbp0u3c9njTDYhRIjVZMft0ItjUBP8jsLRXo36Lby2lwRaFTb9dFAbkG
         ANTjsf35061ZruU2mga9UU2Mp9jiuqxeS8s1tlJ+rof2OZH+OLZHrNsM31IR8LtctRs+
         3juxVzcCH4Jbyo0wi3Tob+T60NI1bZN/I3ZUspClBMP9eFcBv+G8BUCGGxdS6sw2/NdH
         bL0TFprY+zROBluILCvEfg3HzbiBFqVd7CyRSV8n2L8yZhpneifXzx8CG62rSuEmzVtC
         ElrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706374999; x=1706979799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWyaKyAFFUwbtL2A1v+B7Llf8kWXgM4xN4d+iBYkEj4=;
        b=vtX5SOxX/BV7mj6eWZX4gk8G4sqOL1scSsueLbZCnekAMbdBc+jfwdiorQ3y84TKwS
         09ijDHhV2QkAy9tLDBjbEzr4KbIefgTbc+G/nfXL7cckySkX9ln+jM8Gq/44tWCCz7vb
         qyNdsPhRU3URLhiHFxHT/YLSbCcvBubd6e7qzpNbKy2g6bfHw2zH/0ZLZS/2KlWG1gj4
         759Lfz9EEbCh+WhatczENstYyxpZL9oQ+ECdw7G4FuVRrdotpra2z8fJg+Cg+6HJHkSG
         iMS40PRQFb8UwkAaodp5elF4pkNap0QG5HLpvobp2OW5E7iSwpfubgBQBa7jjJcVLe1s
         AS/g==
X-Gm-Message-State: AOJu0YzuDHmxhy108gcDRP8FlDB4RQvo8IOQM+6UK4YOB37uD8E/9Akg
	I1hQ9njawH4eTT/5TQI+HAy66GpeAxn2elJlY7IEbYlc7LdfkdaKywOTGVzhMBA=
X-Google-Smtp-Source: AGHT+IHQgx0aZ2+a4dvli7BgvWwACxL9ztavysjekSne1RghwT+NK6Y1Q+Zhv2iaUvZoEhWenuqELw==
X-Received: by 2002:aa7:88d6:0:b0:6de:a18:70b with SMTP id k22-20020aa788d6000000b006de0a18070bmr1644882pff.45.1706374998836;
        Sat, 27 Jan 2024 09:03:18 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b006dde119396esm3086592pfd.174.2024.01.27.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:03:18 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Expand set of initial conformance groups
Date: Sat, 27 Jan 2024 09:03:14 -0800
Message-Id: <20240127170314.15881-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch attempts to update the ISA specification according
to the latest mailing list discussion about conformance groups,
in a way that is intended to be consistent with IANA registry
processes and IETF 118 WG meeting discussion.

It does the following:
* Split basic into base32 and base64 for 32-bit vs 64-bit base
  instructions
* Split division/modulo instructions out of base groups
* Split atomic instructions out of base groups

There may be additional changes as discussion continues,
but there seems to be consensus on the principles above.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 44 ++++++++++++++-----
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index af43227b6..a090b5131 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -102,7 +102,7 @@ Conformance groups
 
 An implementation does not need to support all instructions specified in this
 document (e.g., deprecated instructions).  Instead, a number of conformance
-groups are specified.  An implementation must support the "basic" conformance
+groups are specified.  An implementation must support the base32 conformance
 group and may support additional conformance groups, where supporting a
 conformance group means it must support all instructions in that conformance
 group.
@@ -112,12 +112,20 @@ that executes instructions, and tools as such compilers that generate
 instructions for the runtime.  Thus, capability discovery in terms of
 conformance groups might be done manually by users or automatically by tools.
 
-Each conformance group has a short ASCII label (e.g., "basic") that
+Each conformance group has a short ASCII label (e.g., "base32") that
 corresponds to a set of instructions that are mandatory.  That is, each
 instruction has one or more conformance groups of which it is a member.
 
-The "basic" conformance group includes all instructions defined in this
-specification unless otherwise noted.
+This document defines the following conformance groups:
+* base32: includes all instructions defined in this
+  specification unless otherwise noted.
+* base64: includes base32, plus instructions explicited noted
+  as being in the base64 conformance group.
+* atom32: includes 32-bit atomic operation instructions (see `Atomic operations`_).
+* atom64: includes atom32, plus 64-bit atomic operation instructions.
+* div32: includes 32-bit division and modulo instructions.
+* div64: includes div32, plus 64-bit division and modulo instructions.
+* legacy: deprecated packet access instructions.
 
 Instruction encoding
 ====================
@@ -239,7 +247,8 @@ Arithmetic instructions
 -----------------------
 
 ``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
-otherwise identical operations.
+otherwise identical operations. ``BPF_ALU64`` instructions belong to the
+base64 conformance group unless noted otherwise.
 The 'code' field encodes the operation as below, where 'src' and 'dst' refer
 to the values of the source and destination registers, respectively.
 
@@ -293,6 +302,9 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 Note that most instructions have instruction offset of 0. Only three instructions
 (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
 
+Division and modulo operations for ``BPF_ALU`` are part of the "div32"
+conformance group, and division and modulo operations for ``BPF_ALU64``
+are part of the "div64" conformance group.
 The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
@@ -349,7 +361,9 @@ BPF_ALU64  Reserved   0x00   do byte swap unconditionally
 =========  =========  =====  =================================================
 
 The 'imm' field encodes the width of the swap operations.  The following widths
-are supported: 16, 32 and 64.
+are supported: 16, 32 and 64.  Width 64 operations belong to the base64
+conformance group and other swap operations belong to the base32
+conformance group.
 
 Examples:
 
@@ -374,8 +388,8 @@ Examples:
 Jump instructions
 -----------------
 
-``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
-otherwise identical operations.
+``BPF_JMP32`` uses 32-bit wide operands and indicates the base32 conformance group, while ``BPF_JMP`` uses 64-bit wide operands for
+otherwise identical operations, and indicates the base64 conformance group unless otherwise specified.
 The 'code' field encodes the operation as below:
 
 ========  =====  ===  ===============================  =============================================
@@ -424,6 +438,9 @@ specified by the 'imm' field. A > 16-bit conditional jump may be
 converted to a < 16-bit conditional jump plus a 32-bit unconditional
 jump.
 
+All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
+base32 conformance group.
+
 Helper functions
 ~~~~~~~~~~~~~~~~
 
@@ -481,6 +498,8 @@ The size modifier is one of:
   BPF_DW         0x18   double word (8 bytes)
   =============  =====  =====================
 
+Instructions using ``BPF_DW`` belong to the base64 conformance group.
+
 Regular load and store operations
 ---------------------------------
 
@@ -525,8 +544,10 @@ by other BPF programs or means outside of this specification.
 All atomic operations supported by BPF are encoded as store operations
 that use the ``BPF_ATOMIC`` mode modifier as follows:
 
-* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
-* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
+* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations, which are
+  part of the "atom32" conformance group.
+* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations, which are
+  part of the "atom64" conformance group.
 * 8-bit and 16-bit wide atomic operations are not supported.
 
 The 'imm' field is used to encode the actual atomic operation.
@@ -637,5 +658,4 @@ Legacy BPF Packet access instructions
 BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
-instructions belong to the "legacy" conformance group instead of the "basic"
-conformance group.
+instructions belong to the "legacy" conformance group.
-- 
2.40.1


