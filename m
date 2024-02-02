Return-Path: <bpf+bounces-21099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986E847C1B
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508001C256F2
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017E83A07;
	Fri,  2 Feb 2024 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dlJ29xpa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88083A1F
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912003; cv=none; b=Xr7FjzUY4mrG0J6MJKuLUIW4Af4he7ADn/pAuQkDMyrYxnKgjvYTBHLPnVn50Xt4RIVH2g6CBUS8p8FP8tmMFK9nmDZJg7y43Q0992n6RKkyTBUW2jRklHFe0w2uAAcvBT3ph9rZ7ZpSXnX+C9BYMqUCEvSI3hhxHjxFbEYGBKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912003; c=relaxed/simple;
	bh=z6sZprimL/1PVwBfacg5aCNyRvmTJ79ErVLBtRz88+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NrGqxB/7yxZ4/vHIZA9ur6o9uuSmBDkWpDdRJDzb9E1FSvbRRjlnDTFSsIG6r6rG3wxu3poos8SvLCW0B2FtnrEUn74a6ADZ2ApDcN/l8gXh3rSaR18osRrjewfm5BvCwAe9R24Yo2niwUNxCjexLHlCMNXZBw44vW/aPwqA4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dlJ29xpa; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb9b28acb4so1850445b6e.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706911997; x=1707516797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yqLzcitn1rd/QWA+ElWJagpULJdj5ewOCcifs3GiBLA=;
        b=dlJ29xpayyQGMG7+ZTvXf0O3kYagLDc1XmO81zYQaq1zAqse+NjqP4CgRRi/8w5LBI
         O6HCbXz33V5sagCD/afwdx7UgW28L69N7av0w9e6W3lDY4DUurYDWr8O7faYI0RKddVT
         xEC445ohsgS6pGPEeSFC/NVU64icEsyHOmrHWePYhdbSUeBdaItg7okJHbH8bb5nWMjh
         f+JtOqQmpZ867nyPoacRtufzoGclyk2dtIPeQ9J/v0oKk9QmbqkWleTbJpvHo8/XZ/kq
         6ZXSONtNyHosrSf03e2y4AigFCoCNP0Xy9ekdr/HuHZCs33s8c9dj2LrNBTnG6lCCxnn
         46jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911997; x=1707516797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqLzcitn1rd/QWA+ElWJagpULJdj5ewOCcifs3GiBLA=;
        b=nIbEAipb18yRemn0HPCqW3wFi7p2Va4s0l/PZ8DwjKkSGFQaBKPN/h8yreLzgZEkO6
         bNJRO1WQUeLlC9qJiHDNKK8HxioB1ukm0B3uZcoKKimfYgZ039HbZ/90Rf/fh5sWDHlk
         ED9NZUru/7EY9RM00/AI4eQu1yoqjctMFf3Wb+mCF+ZIiZLmRnXPM54T3mJ5ZH1UMb9N
         uCHDw1Gak6aqCCsIu9WJh4XkuTUR/FOOJ/fdh9vtlx7ZDJurI71ZKa2z+GFyTcifdJ3i
         4FlTiZ5obr3K/kbuEo1rtfWZrdvvDftZ83bLWCZL1T1TqGv1+SDK/hSaMbQJI5w9WxR3
         JxBg==
X-Gm-Message-State: AOJu0YwI6CJrU+bp+9OTs06Um4TOjNggu/ZEz8/h844UeC82QY0qpuBM
	MXsVreOgzFJEVhf412AVG489NcmleABeKwe3DmFdReFmp0BK+unh/n0//g+xowQ=
X-Google-Smtp-Source: AGHT+IF0uE8dnHJqtpGePkzFTTVZIc+RhetHQBLSz/RPSVh5NLOL3BaY1BCzvBl+T7sKOX2IYdc+vw==
X-Received: by 2002:a05:6870:d1c1:b0:219:4243:bec9 with SMTP id b1-20020a056870d1c100b002194243bec9mr798627oac.5.1706911996782;
        Fri, 02 Feb 2024 14:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnFN7r83/kmEMgNtd/QTsDo4yj6hg6Tm+Y6bC0oOEzsR2Nbxmeq6CestJVPH3FEUPZVVVgKXlyoX6P2cDIJb2sroyGBmk=
Received: from ubuntu2310.. ([166.199.5.36])
        by smtp.gmail.com with ESMTPSA id cr10-20020a056870ebca00b002186b9cc12bsm673277oab.5.2024.02.02.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:13:16 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next v3] bpf, docs: Expand set of initial conformance groups
Date: Fri,  2 Feb 2024 14:11:10 -0800
Message-Id: <20240202221110.3872-1-dthaler1968@gmail.com>
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


