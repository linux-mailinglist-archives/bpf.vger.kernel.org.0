Return-Path: <bpf+bounces-22457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779885E718
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 20:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA428A4B9
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4C85C51;
	Wed, 21 Feb 2024 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="J65vDEqq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="uu/0l9M6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JVyKFSg5"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21068592D
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543057; cv=none; b=j23lXSDh6tzEl+Hd6FURh7MQratU9aavjFv2Gi3aLMb0MiYPynqOjelT03DyLuCookUMmR6q0YTW6BCdvsc1dW6CfOcwL7BlLhImGVmaKhwQzQ86b8mcS/w9kjaVp0nGi7uGeoEA6ZMK4eGutvr2ZPr4YjOpbm1BhksWFJKfTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543057; c=relaxed/simple;
	bh=K3rKCjiBOXotqm9J/WUhgsaV9DP2FxPu+sJSJ3/vu0Y=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=fk+HunvZTv/5r+0+RmEmt2x1haq2nPO1/Jjs2F9E6/dO7HKoL0mLUeeE5zeNBc9z3YrFDKu8IeHMTpmGOwupD63yfOTnUdbFUIZg9YTJO/zNFQpcbMJ8ifLnAahuevb61hrSHqCU6cltcK1+ijjLdITf+0WyEPATYQ4HO8GJ4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=J65vDEqq; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=uu/0l9M6 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JVyKFSg5 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 576E4C1519A8
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 11:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708543055; bh=K3rKCjiBOXotqm9J/WUhgsaV9DP2FxPu+sJSJ3/vu0Y=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J65vDEqqdPiwjf9TxIGCHsWvobwRRwkae6t6U8WqYZ1lkhL88Y6GXexAT7LiKrppc
	 cBqLP5/BJ9M5Q/Fnt7Y/s4PHMObwGRzOGIngblQ9dflPM/3oNFha7RnC+vapB2WKYW
	 9CFG6gshW2EvrsbhM4k/O0w/TpKZrcb4E2XzyYXA=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 34F07C14F702;
 Wed, 21 Feb 2024 11:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1708543055; bh=K3rKCjiBOXotqm9J/WUhgsaV9DP2FxPu+sJSJ3/vu0Y=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=uu/0l9M6K2KVG+vxTKUCBmr8/ho5EVIO/EuFpuoHveRlPua+ctxpbhqVdV07MsjQj
 BF6VSYB9klPcKeEz6M5LFIZ3IZaLetLQDf7vuWGwDDnvsm1OpcOb7E6K8nseIAAkU0
 XosAu84I2EfDL+DNKWuq9DbGXN6tIw6wrtECMiA4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E72AAC14F702
 for <bpf@ietfa.amsl.com>; Wed, 21 Feb 2024 11:17:33 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_pneo8SpKMf for <bpf@ietfa.amsl.com>;
 Wed, 21 Feb 2024 11:17:29 -0800 (PST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D2541C14F616
 for <bpf@ietf.org>; Wed, 21 Feb 2024 11:17:29 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e4560664b5so911811b3a.1
 for <bpf@ietf.org>; Wed, 21 Feb 2024 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1708543049; x=1709147849; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+GfbLVCDf+8jb3m/1Q4Xr36f6hEaNOVT6MYMat+StDw=;
 b=JVyKFSg5tIZt1rXdlxYyez2nWd1SjF6/h1+/13wUWalaeXpv9Byt0KokKSyhht26Fz
 ENDBXEpFTpcQzRDd3HMxMscDjMXMEg+0TQ3jvXfpnkQZL0nZVnaQKOMfzVvz2o3noGzC
 VkTiXiooApZP7mStckEXQOTqA2BEFLLZQl8yUl2hwlK/LNEqXyFv66Kr+tpCxFu2Lt7G
 kpp1/H1QOdMIaYVoC0IdTh0TDHJp1wDnk09ODKyHLMxjnjY0CdYy9mPWmEi1+54LFpwJ
 OUZAwczqrru8zq8xZyLno5L4avSNIZZAlnKDJplNA96RoJWOj2vGd4KowuRWMDvWXWit
 cX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708543049; x=1709147849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+GfbLVCDf+8jb3m/1Q4Xr36f6hEaNOVT6MYMat+StDw=;
 b=HNlVXeYAFsGtKd/Dmy/kEhOJHb15Rlm3nTpteju45Bo5tpXdkzs3YSE/LogWhpoBV5
 kUfofRP5Za+9ZUZXs5MGSFUQVwFvkYJEiFi9hL4vlpB0uyfDvZSNRzgMVv+UR5vCnd4X
 fF5jtOeW1Kw4H/nbde9hyO8PszO1QDqmxOmvTEBu7LSACM/nMhcHU7CBwDdsCb1h4zC3
 BYIOxo9hksi52LBBvdCms82NiJ+XOvxcsnhHpzeGOlw6/bCkQeY3JxEJK4NAVLzgWwH7
 pOUWXKCp5iub4l1zssO/qv8D6a7m7SfH6arWkk1CikOPti3kxnS9J3nMlQyz9LsXhLMD
 mY/g==
X-Gm-Message-State: AOJu0YyDG1RNCw8ixHwZnGpwELfhjtP7GViu1+1MoC5MCvpjuihZzXV1
 cWSwB/Uo2dlCnjZy/aLWBObJfyCq66ODInmLcioSKb5FqcEco4NqxmkNdRnxVvg=
X-Google-Smtp-Source: AGHT+IHkMqJq6GrwZYmU2lgyGwFR0/T6ORBe9qWNwPqAcJbcZp4TanCNfKu6NAVS6lh5yXbBSDES4w==
X-Received: by 2002:a05:6a21:1693:b0:19e:98b3:a1e with SMTP id
 np19-20020a056a21169300b0019e98b30a1emr21509305pzb.55.1708543049164; 
 Wed, 21 Feb 2024 11:17:29 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 z11-20020a62d10b000000b006e4432027d1sm7856656pfg.142.2024.02.21.11.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 11:17:28 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Wed, 21 Feb 2024 11:17:25 -0800
Message-Id: <20240221191725.17586-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/JNrxzJiBd09zaqU_pVeQ4s8mqKg>
Subject: [Bpf] [PATCH bpf-next v4] bpf,
 docs: Add callx instructions in new conformance group
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

* Add a "callx" conformance group
* Add callx row to table
* Update helper function to section to be agnostic between BPF_K vs
  BPF_X
* Rename "legacy" conformance group to "packet"

Based on mailing list discussion at
https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/

Only src=0 is currently listed for callx. Neither clang nor gcc
use src=1 or src=2, and both use exactly the same semantics for
src=0 which was agreed between them (Yonghong and Jose). Since src=0
semantics are agreed upon by both and is already implemented, src=0
is documented as implemented.

v1->v2: Incorporated feedback from Will Hawkins

v2->v3: Use "dst" not "imm" field

v3->v4: Only use src=0

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..a68445899 100644
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
@@ -404,9 +404,10 @@ BPF_JSET  0x4    any  PC += offset if dst & src
 BPF_JNE   0x5    any  PC += offset if dst != src
 BPF_JSGT  0x6    any  PC += offset if dst > src        signed
 BPF_JSGE  0x7    any  PC += offset if dst >= src       signed
-BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K only
+BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X only
 BPF_CALL  0x8    0x1  call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
-BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x2  call_by_btfid(imm)               BPF_JMP | BPF_K only
 BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K only
 BPF_JLT   0xa    any  PC += offset if dst < src        unsigned
 BPF_JLE   0xb    any  PC += offset if dst <= src       unsigned
@@ -414,6 +415,11 @@ BPF_JSLT  0xc    any  PC += offset if dst < src        signed
 BPF_JSLE  0xd    any  PC += offset if dst <= src       signed
 ========  =====  ===  ===============================  =============================================
 
+where
+
+* call_by_address(value) means to call a helper function by the address specified by 'value' (see `Helper functions`_ for details)
+* call_by_btfid(value) means to call a helper function by the BTF ID specified by 'value' (see `Helper functions`_ for details)
+
 The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
 
@@ -438,8 +444,9 @@ specified by the 'imm' field. A > 16-bit conditional jump may be
 converted to a < 16-bit conditional jump plus a 32-bit unconditional
 jump.
 
-All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
-base32 conformance group.
+The ``BPF_CALL | BPF_X`` instruction belongs to the callx
+conformance group.  All other ``BPF_CALL`` instructions and all
+``BPF_JA`` instructions belong to the base32 conformance group.
 
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -447,13 +454,13 @@ Helper functions
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
@@ -660,4 +667,4 @@ carried over from classic BPF. These instructions used an instruction
 class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
 mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
-instructions belong to the "legacy" conformance group.
+instructions belong to the "packet" conformance group.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

