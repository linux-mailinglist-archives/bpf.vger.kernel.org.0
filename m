Return-Path: <bpf+bounces-29961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8E8C8A6B
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138232815F3
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE313D8AC;
	Fri, 17 May 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Tw4xtwEo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33612F5A3
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965141; cv=none; b=aB1MWvK3qpRxYqgVBmUDpSCvha+DBktPBCHymZWb9Q7KfEu6avGH7QFL6FEefUlhNy/eP/db+fMk0ZAE3sLK3tUQ6bO8ymFVuTrLCSjZsCx+VmDyI+1kX5En95PZNcCujKhITqgadHEEtGlf5WcyI04A9UKgA3r8EPjzOm4jEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965141; c=relaxed/simple;
	bh=IumngFxk5J4dhDdV0jUtnqUrAdcHAc+uHBNfCKoVFuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rt+YLZ6mp1wQoamA2CbfkeqQ5J/Cf7A2JzdGEinXY98ws9Rt09x4SUie1jKcoiLOKG1f/4NrCJTdPRQoJ0aCWbIKnyD1lzupTOEly51mwlcWm1ObLMsxPnprnlFePGnopQd8QzoWi5UY0rAHslSXV2WpTwjBBoon5Yk+D5eijWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Tw4xtwEo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee7963db64so15158125ad.1
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1715965139; x=1716569939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+pYUkfOgnCOs3dkE4Q29vvT0TtpAPJIkLifqxKN6Jk=;
        b=Tw4xtwEoIOlXrPPO9eidj0Y8WmQz3cB4TqN7NrxFTgEU+lFqhQkJXhcPvKUEbKuMQj
         OEh7c6R5lCOuoFdt+jaWNThiOz5J1QojknEzbThEeC/4C28G2vr9EK9hXn+mDCHlYNMh
         IpHxEXdmvWuL29bzhzpnZLPjcA/NYQr+8WOdZQ7NVgcnh7xw04055gNhjP53cxgSqM8I
         cBulLhTVMO5XN3Pgi7ly1CK11o1uGrDgbRI3oA/U+x982PAwBxgoLk0wQ4tHxSipZHMw
         LHoHN3k9eCKmTWbKjhXPgPXZqsgGbd3X+f1wsUvdZv0d8N+CFTZYVRpymVSN/+6SkxW3
         5fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965139; x=1716569939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+pYUkfOgnCOs3dkE4Q29vvT0TtpAPJIkLifqxKN6Jk=;
        b=WUJvWcRfnKewPQ3++8iRXY4u7MS8Hi8FdgnA8rL7L+Vvl4PB5aOpC2Hs99/MzzZJBv
         3a/uvEVhdMNehnVfD7Mujswt5lGA7XUcDaA2pCcRocsSxR6dVeWyHx34v5eSVccRTvnl
         pXoQFx49IBVmtDsP/e+wlpumPvtus/b4OoRKTY4UkD0fu30sc6r5Z6Qn9Vt2MlKskK8y
         AHtxLXqkOotieBfUvBqaf/8lQAywMU1MRiurmrOSrS5H5VeAbeQKmw2H2YW8zbwaKux6
         rNglx1G1YhC1A314kFnb68TNt1qNPT6/13hIrt+Jb3Hq6KecqdcG1vMW+L52gOpu5Y7f
         3XTw==
X-Gm-Message-State: AOJu0YzR8f8mGK1DFO9NL+04tEhEnAK7uQ2sGexF7Yx08yJ820qiCNKY
	FhJGatvac5Lkc9JyZDTcwTJawwdfe0K6twWTwQ/QyzrCt7MezM2Tvixtlw==
X-Google-Smtp-Source: AGHT+IH4c20X1DopewNmBfkhe/1R8IYE3BdsjQmrmONldtpcy67DwXaVCWSA7XCCGoZILHuI0t56hg==
X-Received: by 2002:a05:6a21:789f:b0:1af:cdd4:9bf3 with SMTP id adf61e73a8af0-1afde10f1b3mr26423599637.32.1715965139222;
        Fri, 17 May 2024 09:58:59 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f6603bb3e9sm8438608b3a.74.2024.05.17.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 09:58:58 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next] bpf, docs: Use RFC 2119 language for ISA requirements
Date: Fri, 17 May 2024 09:58:55 -0700
Message-Id: <20240517165855.4688-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per IETF convention and discussion at LSF/MM/BPF, use MUST etc.
keywords as requested by IETF Area Director review.  Also as
requested, indicate that documenting BTF is out of scope of this
document and will be covered by a separate IETF specification.

Added paragraph about the terminology that is required IETF boilerplate
and must be worded exactly as such.

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 .../bpf/standardization/instruction-set.rst   | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 997560aba..eb796ebde 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -14,6 +14,13 @@ set architecture (ISA).
 Documentation conventions
 =========================
 
+The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
+"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
+"OPTIONAL" in this document are to be interpreted as described in
+BCP 14 `<https://www.rfc-editor.org/info/rfc2119>`_
+`RFC8174 <https://www.rfc-editor.org/info/rfc8174>`_
+when, and only when, they appear in all capitals, as shown here.
+
 For brevity and consistency, this document refers to families
 of types using a shorthand syntax and refers to several expository,
 mnemonic functions when describing the semantics of instructions.
@@ -106,9 +113,9 @@ Conformance groups
 
 An implementation does not need to support all instructions specified in this
 document (e.g., deprecated instructions).  Instead, a number of conformance
-groups are specified.  An implementation must support the base32 conformance
-group and may support additional conformance groups, where supporting a
-conformance group means it must support all instructions in that conformance
+groups are specified.  An implementation MUST support the base32 conformance
+group and MAY support additional conformance groups, where supporting a
+conformance group means it MUST support all instructions in that conformance
 group.
 
 The use of named conformance groups enables interoperability between a runtime
@@ -209,7 +216,7 @@ For example::
   07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
-Unused fields shall be cleared to zero.
+Unused fields SHALL be cleared to zero.
 
 Wide instruction encoding
 --------------------------
@@ -373,7 +380,7 @@ interpreted as a 64-bit signed value.
 Note that there are varying definitions of the signed modulo operation
 when the dividend or divisor are negative, where implementations often
 vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
-etc. This specification requires that signed modulo use truncated division
+etc. This specification requires that signed modulo MUST use truncated division
 (where -13 % 3 == -1) as implemented in C, Go, etc.::
 
    a % n = a - n * trunc(a / n)
@@ -403,7 +410,7 @@ only and do not use a separate source register or immediate value.
 For ``ALU``, the 1-bit source operand field in the opcode is used to
 select what byte order the operation converts from or to. For
 ``ALU64``, the 1-bit source operand field in the opcode is reserved
-and must be set to 0.
+and MUST be set to 0.
 
 =====  ========  =====  =================================================
 class  source    value  description
@@ -514,7 +521,8 @@ for each program type, but static IDs are unique across all program types.
 
 Platforms that support the BPF Type Format (BTF) support identifying
 a helper function by a BTF ID encoded in the 'imm' field, where the BTF ID
-identifies the helper name and type.
+identifies the helper name and type.  Further documentation of BTF
+is outside the scope of this document and is left for future work.
 
 Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -724,5 +732,5 @@ carried over from classic BPF. These instructions used an instruction
 class of ``LD``, a size modifier of ``W``, ``H``, or ``B``, and a
 mode modifier of ``ABS`` or ``IND``.  The 'dst_reg' and 'offset' fields were
 set to zero, and 'src_reg' was set to zero for ``ABS``.  However, these
-instructions are deprecated and should no longer be used.  All legacy packet
+instructions are deprecated and SHOULD no longer be used.  All legacy packet
 access instructions belong to the "packet" conformance group.
-- 
2.40.1


