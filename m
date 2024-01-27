Return-Path: <bpf+bounces-20478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F983EEE5
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817921F224CA
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC032C848;
	Sat, 27 Jan 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="fcYsh49C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="l33wZDGx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CfMIuqcr"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CE28DCA
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706375008; cv=none; b=ORCHhjRjVvq4Wr1ByGLdEbhE1HupZogS1VCHQikZubzhSD6TnYL/990CW0y7hECduyUS1l1HcffRQNTZm6m6mWDc9sKswTvV1zdjInb/ltopsMWFxlEYy7IvDTF8139kEkBRAlYpDKOt0Oa0Q33YWh1cjVnSnnNd1I+dM8bS69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706375008; c=relaxed/simple;
	bh=mPFamYaFciiSvPKVXowDV85IBhCFGKpizf0GCEGh2H4=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=BlHRjjRCQF+/5p89DUDuj6TyKg5RNt5qtUquAsVs11q0rgWELhhcmQxzOqNBCDuFzUEl1Ab2I9ZLv4UZvP4QohEfy+ZNl/QPGiOJND1NBnhp/uRd5zMQEhFT7XK5j6m+U7SQrWTP4oBY4N9zczMVMJ/CQRz1chvOZ1jgP2W9zZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=fcYsh49C; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=l33wZDGx reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CfMIuqcr reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6A9BBC1519A9
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 09:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706375005; bh=mPFamYaFciiSvPKVXowDV85IBhCFGKpizf0GCEGh2H4=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fcYsh49CT3YR/kSL39iOkLBWg8DI9r0GLkqzZb3tTf13s0bxQZ0dzmJ2SZ+nbMySv
	 AhDVw9j+FPlcZq2S8orllKr3UqwCjhX2MLT8F4zI1hY5DeM4oHVsiFwQNwNmoNv0bA
	 RR616/FOCgn2pE3GvMlWnfS2btc1ruRj3p9yiyF8=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 480A7C1516E0;
 Sat, 27 Jan 2024 09:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706375005; bh=mPFamYaFciiSvPKVXowDV85IBhCFGKpizf0GCEGh2H4=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=l33wZDGxdJB/tFqZs51qX1wAnJfCMprM375b9WkJ2Zsc0yjlscuf1pTRTMhRcRk9Q
 F6UyZHqCrbH0Oejelke0JLDMQEK+k8chHdKZ9jbTSHjRrQvREutNd3csrVOj2fDZcP
 8RAShfDNUIuPFvJTiwBLOYkECSWik1i+QE6EMOrA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E0703C1516E0
 for <bpf@ietfa.amsl.com>; Sat, 27 Jan 2024 09:03:23 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IcV568DIVzoU for <bpf@ietfa.amsl.com>;
 Sat, 27 Jan 2024 09:03:19 -0800 (PST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E5F28C151536
 for <bpf@ietf.org>; Sat, 27 Jan 2024 09:03:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6dc6f47302bso1309188b3a.1
 for <bpf@ietf.org>; Sat, 27 Jan 2024 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706374999; x=1706979799; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YWyaKyAFFUwbtL2A1v+B7Llf8kWXgM4xN4d+iBYkEj4=;
 b=CfMIuqcrjrEvBJHBAAuRPMIUqTJp/GcwnRaIn4j/B3VUi2amHvpgkX6CDvbiY2wB3P
 /ubCYa6EYC48mRIqu9JAHYGxeEkd4SnTETDSImIhhygz0bKH5B1UUR6gH1/Kj/s3QC1w
 VH92JoRmgEpo68hyMxltuZFrk8jNKHmnM1YTxqOQy73HWMzZYCrJRSZO0Rj2ht8lUGgS
 RMWzQl4N8gUQwcM5Sn734TE1uOZj9Rxyl8/AYlSuuvMiLLluq28PqleyEX53PbbHdG6X
 9+P55TLIsVHfHAnxsVRgyrtDovRcwhL2TAL81CNskxA52k40mVkxDA/E4c7EmyiAENBm
 chbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706374999; x=1706979799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWyaKyAFFUwbtL2A1v+B7Llf8kWXgM4xN4d+iBYkEj4=;
 b=tPaxV6gKH5Fibp+AoFuawODjO8prdJAQIIlEG/P3BRxcoo3Byvn47gM6P2kfnKhe1E
 QdSr49zrjOUlE7Uswxd+07wyXVcKWK2ZFsCiIkLwXR6my0safeGaT+htBUvy7IHDEaKO
 eI7msBMqz+hYP9C3eEVZC2v7UxX21DyamLTkQCGSKcFIs1BHHUYQUrma0JX1Y/5IjIXl
 tr3BnTVfMvo/cNDvfzLm56ML9sJ1auAxq/6iH1rFwkBIHbiAmnS3eY1M7BDzAkgCMWWG
 /a8jV3ZUFq9nHuijGIkNpEhgEjiZDfVo5umKlGmGveA7AuleKQVARQ3tZ7Unj0oVzX/L
 4e+g==
X-Gm-Message-State: AOJu0YwTG3WJLSyK2xBuq7y999fgJAvr4OkfeXPMZKlZjzn0NMqmitx9
 MZff+C/TPUOD0I2CBqMiFSCmq8SnFdKEQc8V+J4NncJJ1ZsUip/q
X-Google-Smtp-Source: AGHT+IHQgx0aZ2+a4dvli7BgvWwACxL9ztavysjekSne1RghwT+NK6Y1Q+Zhv2iaUvZoEhWenuqELw==
X-Received: by 2002:aa7:88d6:0:b0:6de:a18:70b with SMTP id
 k22-20020aa788d6000000b006de0a18070bmr1644882pff.45.1706374998836; 
 Sat, 27 Jan 2024 09:03:18 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 e5-20020aa78c45000000b006dde119396esm3086592pfd.174.2024.01.27.09.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 09:03:18 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Sat, 27 Jan 2024 09:03:14 -0800
Message-Id: <20240127170314.15881-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Il81aud2XcV2Dl39LQOy0bq7h3k>
Subject: [Bpf] [PATCH bpf-next] bpf,
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

