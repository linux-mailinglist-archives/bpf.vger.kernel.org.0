Return-Path: <bpf+bounces-21102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75629847C24
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A770B23A9D
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFAA85925;
	Fri,  2 Feb 2024 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="V8eseMKr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HQOyVtTV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TsazqIzh"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276983CDF
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912354; cv=none; b=cESItk/d1EpVUDASjcZpBxqyCmObunnE50ZoIG/cxkO19h6kdgbvpcx2qW6i22Csuo3nL/5uQwrnNMxq5QbjkfTAnF8WaI8g56l16MSUHUjrAkKt9rzyJ4vxhgTUAsrf0M+hVDKN6xk7P5OLwbr92M0fRgEFZm5CrtHf3RqfUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912354; c=relaxed/simple;
	bh=Js5dLs7dJdercSuf84jZdmSDiKGhM8h7m/0KPEuyEg8=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=Hc2KrsesQDF/YP9yZb87zVKqopHCVuDfKsMabtzVdtXAmvX4nIywGsn7AIONXnA6RVbc6KAgHVrn3Y9UT7pHn8lC1ARBwea3QuJslWAtaFuD9WrjQdcf9IjjGCptkc8CGwZmP6ECRyfNM5z7rGIdkbtVQ9WTbb9wJJXdKb3J9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=V8eseMKr; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HQOyVtTV reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TsazqIzh reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8A7E2C14F708
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706912003; bh=Js5dLs7dJdercSuf84jZdmSDiKGhM8h7m/0KPEuyEg8=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V8eseMKrrC5/GwKIewmzi0ClvydEiCcRiIEdFdNheFvX9DJ1UUGaBjGcQo1DCatWu
	 iVFrpTss4e7sokeKyFzoWc/cri4CmRU9rScyfhSMQ3qxnbS70wb4+fk9z92dwLnW/R
	 ZWSd2m5n1TwqWcGMFYZj/5yikfm1dSoq/kOe0gqs=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5C131C14F610;
 Fri,  2 Feb 2024 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706912003; bh=Js5dLs7dJdercSuf84jZdmSDiKGhM8h7m/0KPEuyEg8=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=HQOyVtTVKBlN8kHZPQllpvkL6izSQwaOf+htHa+RGgAiORqH6Krdaao6Sr9zZprH5
 NmctBM1wpamQu960lEIZ5zvceUntx4lBHZxe6PHlceGoCV8WJ8jH/e7xPfnD98dDFF
 6rD/1BJ5ARVW2esEwlWPOjNadl2MzKdIGLoodT5k=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 16A3CC14F61C
 for <bpf@ietfa.amsl.com>; Fri,  2 Feb 2024 14:13:22 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ldEwCa6VLd8T for <bpf@ietfa.amsl.com>;
 Fri,  2 Feb 2024 14:13:18 -0800 (PST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 365E0C14F610
 for <bpf@ietf.org>; Fri,  2 Feb 2024 14:13:18 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2191b085639so627435fac.0
 for <bpf@ietf.org>; Fri, 02 Feb 2024 14:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706911997; x=1707516797; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yqLzcitn1rd/QWA+ElWJagpULJdj5ewOCcifs3GiBLA=;
 b=TsazqIzhkyJgW28baa7TTY0Bx5Q5tOogo58XEjzEB313mI9vZ80/ySllUX5AEUi5gx
 Cox3Xy7J5cQmLasgor+YLHS5AXmsiuuhmdhsatv1ur9FbRYTk4hXCg7BQkM9qDG6nRIk
 JcvUPOLnFJidDegOa4FWQ2yoKjWn+eS4pCg1+HrFF/XFV8GKqMqwkFY4DY8sSdjKrXEa
 VAmrigTH+Q12RtBf1xA7r6ZJqdNDcfURAaNP3gAFiPC6mubNu1MvYfp/dVat46rjosSN
 q1UMBMl2NaXBMgLjY2hVQ+auwY5NPYVoQLMZd7Ddr9uXsq9RqyD45JeAtO/TIazrgzwi
 lKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706911997; x=1707516797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yqLzcitn1rd/QWA+ElWJagpULJdj5ewOCcifs3GiBLA=;
 b=NSvd3WgbmjUMRVPniKZCueLQu8O3AyeyQXhPTiB0oNNXOv2IeCFIzsq4gcJT1XWZ17
 3DOoJ1M1QPy9y/+FjSh90HRMVgxOX69fB5ZLJefUUPhx3WWcvgwxWmSwsN3E7UAkRqjJ
 JA6LLk+6pMMtYCG1dPF75DgPUdTRilg+nezj21CmMQG5xLhgSa2L2nNwy7+DW0z2gNgz
 RehavhYRw634c/Y7EfN6KOA1X4Kb9TdT1RhUK3y+H9Jafr+rq8XqErAqESVpFcyofO1M
 FE6zmF8mNT2Eo9kVKGDfXM0pw7OupEfus6oe2RGiPHgcKqJdecKo97D2aVESQ8sngbe6
 fbRA==
X-Gm-Message-State: AOJu0Yw4nCZ2viRkJl2hZzT89ZQTwZ2ynWj3qB8+Dgb9SvPsHBxylyWy
 r9rmS2h+z18NBxb76KSzv509jqwxyZGIYWFEtO2vTC7OCyea6j+7
X-Google-Smtp-Source: AGHT+IF0uE8dnHJqtpGePkzFTTVZIc+RhetHQBLSz/RPSVh5NLOL3BaY1BCzvBl+T7sKOX2IYdc+vw==
X-Received: by 2002:a05:6870:d1c1:b0:219:4243:bec9 with SMTP id
 b1-20020a056870d1c100b002194243bec9mr798627oac.5.1706911996782; 
 Fri, 02 Feb 2024 14:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVnFN7r83/kmEMgNtd/QTsDo4yj6hg6Tm+Y6bC0oOEzsR2Nbxmeq6CestJVPH3FEUPZVVVgKXlyoX6P2cDIJb2sroyGBmk=
Received: from ubuntu2310.. ([166.199.5.36]) by smtp.gmail.com with ESMTPSA id
 cr10-20020a056870ebca00b002186b9cc12bsm673277oab.5.2024.02.02.14.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 14:13:16 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Fri,  2 Feb 2024 14:11:10 -0800
Message-Id: <20240202221110.3872-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/oH2tJmsrAXuRmEer6zSh9JHsosw>
Subject: [Bpf] [PATCH bpf-next v3] bpf,
 docs: Expand set of initial conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

This patch attempts to update the ISA specification according
to the latest mailing list discussion about conformance groups,
in a way that is intended to be consistent with IANA registry
processes and IETF 118 WG meeting discussion.

It does the following:
* Split basic into base32 and base64 for 32-bit vs 64-bit base
  instructions
* Split division/multiplication/modulo instructions out of base groups
* Split atomic instructions out of base groups

There may be additional changes as discussion continues,
but there seems to be consensus on the principles above.

v1->v2: fixed typo pointed out by David Vernet

v2->v3: Moved multiplication to same groups as division/modulo

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 48 ++++++++++++++-----
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index af43227b6..fa27e9e3e 100644
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
@@ -112,12 +112,21 @@ that executes instructions, and tools as such compilers that generate
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
+* base64: includes base32, plus instructions explicitly noted
+  as being in the base64 conformance group.
+* atomic32: includes 32-bit atomic operation instructions (see `Atomic operations`_).
+* atomic64: includes atomic32, plus 64-bit atomic operation instructions.
+* divmul32: includes 32-bit division, multiplication, and modulo instructions.
+* divmul64: includes divmul32, plus 64-bit division, multiplication,
+  and modulo instructions.
+* legacy: deprecated packet access instructions.
 
 Instruction encoding
 ====================
@@ -239,7 +248,8 @@ Arithmetic instructions
 -----------------------
 
 ``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
-otherwise identical operations.
+otherwise identical operations. ``BPF_ALU64`` instructions belong to the
+base64 conformance group unless noted otherwise.
 The 'code' field encodes the operation as below, where 'src' and 'dst' refer
 to the values of the source and destination registers, respectively.
 
@@ -293,6 +303,10 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 Note that most instructions have instruction offset of 0. Only three instructions
 (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
 
+Division, multiplication, and modulo operations for ``BPF_ALU`` are part
+of the "divmul32" conformance group, and division, multiplication, and
+modulo operations for ``BPF_ALU64`` are part of the "divmul64" conformance
+group.
 The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
@@ -349,7 +363,9 @@ BPF_ALU64  Reserved   0x00   do byte swap unconditionally
 =========  =========  =====  =================================================
 
 The 'imm' field encodes the width of the swap operations.  The following widths
-are supported: 16, 32 and 64.
+are supported: 16, 32 and 64.  Width 64 operations belong to the base64
+conformance group and other swap operations belong to the base32
+conformance group.
 
 Examples:
 
@@ -374,8 +390,10 @@ Examples:
 Jump instructions
 -----------------
 
-``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
-otherwise identical operations.
+``BPF_JMP32`` uses 32-bit wide operands and indicates the base32
+conformance group, while ``BPF_JMP`` uses 64-bit wide operands for
+otherwise identical operations, and indicates the base64 conformance
+group unless otherwise specified.
 The 'code' field encodes the operation as below:
 
 ========  =====  ===  ===============================  =============================================
@@ -424,6 +442,9 @@ specified by the 'imm' field. A > 16-bit conditional jump may be
 converted to a < 16-bit conditional jump plus a 32-bit unconditional
 jump.
 
+All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
+base32 conformance group.
+
 Helper functions
 ~~~~~~~~~~~~~~~~
 
@@ -481,6 +502,8 @@ The size modifier is one of:
   BPF_DW         0x18   double word (8 bytes)
   =============  =====  =====================
 
+Instructions using ``BPF_DW`` belong to the base64 conformance group.
+
 Regular load and store operations
 ---------------------------------
 
@@ -525,8 +548,10 @@ by other BPF programs or means outside of this specification.
 All atomic operations supported by BPF are encoded as store operations
 that use the ``BPF_ATOMIC`` mode modifier as follows:
 
-* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
-* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
+* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations, which are
+  part of the "atomic32" conformance group.
+* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations, which are
+  part of the "atomic64" conformance group.
 * 8-bit and 16-bit wide atomic operations are not supported.
 
 The 'imm' field is used to encode the actual atomic operation.
@@ -637,5 +662,4 @@ Legacy BPF Packet access instructions
 BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
-instructions belong to the "legacy" conformance group instead of the "basic"
-conformance group.
+instructions belong to the "legacy" conformance group.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

