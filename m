Return-Path: <bpf+bounces-21774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC852851F45
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9E71C2223D
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8314C622;
	Mon, 12 Feb 2024 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XvDgZzSr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CpBGvYXN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b8LBwe6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D24C61B
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772408; cv=none; b=uY8awy2bg8M3Eo162uPJrNsYUaxctWI8xd4XpdUFIHoeUo25dUqmYMricafp3HRaJ39jrJendhKMU1ctsfBBajyTsezUp1lBjKrsyct37booUP6/gwd0imufIrml/7YHnB97i0wC6O30h1VTWP8u23eDvRw0WwHreFqF4EKEjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772408; c=relaxed/simple;
	bh=efLg9SNjT4tMbV2+3qaJCI9cHbmpVCz3FPx0rMwik2A=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=Gwvh4XOizoL0ZUEdfatjQCSJTWnYULsJWeyj81g1VNqluhGVj7HDCoFHBScYsp2qSWsXTmJEIZIiM21QES8/PMaAwRIYKAScPVbxen8cP2Inc3O9x0OE1FET3tOgoXJKQSP3SU0hTqHU2Z496yDcN99/GR42Hk6PesSUDIv/mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XvDgZzSr; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=CpBGvYXN reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=b8LBwe6I reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6E27DC15199B
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707772400; bh=efLg9SNjT4tMbV2+3qaJCI9cHbmpVCz3FPx0rMwik2A=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XvDgZzSrHgXbd6K2BUFOz2BYC76CnfKKhaVXKFUs7m3YzaaPzPnuFVlRuCm9E9IK1
	 w0It4QOW0eQ3xag3CQGpEcv3nSQ5cHiMravWiD9RjajhTpajHfaFn/0zSHI5rSTEWJ
	 t9dDmpYIJxs8gL/kUlUs8spK6/d0HYJQHCZVO4FQ=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 416EEC151553;
 Mon, 12 Feb 2024 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707772400; bh=efLg9SNjT4tMbV2+3qaJCI9cHbmpVCz3FPx0rMwik2A=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=CpBGvYXNKZuHsgp8VAnw8/5+wQ/ocqP6Qo1iBJGTjXXzoOL17p8F7O13gQFLhTzg1
 ViPYDXBX3jqR5Co9CGJLLkbYki7cPdXaP8IdppJmcqENtKOXlQeaMoZzmDkz2INt/Z
 8HNnapugj+05oq15Qh3akJhT1DauFyPrnxvGsWH8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6C908C151553
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 13:13:19 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZemP8uJ0neV3 for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 13:13:15 -0800 (PST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CDB5EC151552
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:13:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso25304425ad.1
 for <bpf@ietf.org>; Mon, 12 Feb 2024 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707772395; x=1708377195; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Y3qDIbEUDhtRMCmQ9gvyrPS3BRUQBD/sYtg6yEOvUg=;
 b=b8LBwe6IZPk3TuJRY/5jQqERIE4Gk4WVTfXg8vM3MGD2Xc9Z2vq/PMf6MQWvy3MA6c
 WskFwQyW/uPuoS8UjzgcE/dGVv2bYkK+DsMDD+Qtji8ZYwMBaqDShAZjVmzt2dJWOjdB
 U4T00MGlNTXOzQeZqlE9rtyhcydt91mxQ68TMqFCZBwWJ8dQGXKofBZKaL2Sh8C/JSl5
 O9myciMBWdwjsiONmB9atyOOnOsfPA98bwUJn2d8Pac2+jgE+NZit2qizfFR+zaJvoXJ
 hfuGddFvw9481C2OVvh6+MI0aTEPC9FPL2nIM32hT+mxqMo5QnhMfvMNXyG8P2FNYjXu
 gELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707772395; x=1708377195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Y3qDIbEUDhtRMCmQ9gvyrPS3BRUQBD/sYtg6yEOvUg=;
 b=mbAMVmzrI+iQa402ti5IQGd1pd4K45Vdg3eSAU39BFKErIYoRr1WfxR/3vO/W8d0ky
 6ZuxNWf0jlyH2wg3CQWsJJ+mDVcSdhOzGOCi64VlhsGBpwFPJnWr5f4iG/6S7dtkbE7d
 Aj4wB9cD98XhZz7MgGgDUfpkxOAQ/Tn/S/87sAjKGi8HLZn5veJk8M6bA5BU58Nxg4tb
 wy9MxpIE198SwdTvtZx67rxTeUL/vLcM0kcCTs38JXrYMsNJ9G2LdqCZpGTp3yr15s5o
 /u11IH+LTquw+xe5qgEthZ95oMOu8jQ0aPP73glYYwBqJLWJuV3lHCzzOTZSH0CSA0pl
 bDNA==
X-Gm-Message-State: AOJu0Yz/HfVPK49HdN2ROL15zNFhhd5abLkRHERdLtQdkYnqkSiCIGF8
 4/SOtri+GpMbZurFPJi7gS/fzGVAD8LJMrCmxW+XVpcaVCYPJRLjqVHYwsGmEvg=
X-Google-Smtp-Source: AGHT+IFkuMhe9/ysk/wBgeexWHFrd+8JKQQYLuk4aTPiZU9xEcahE2sKGM/C59bQThJqj6zGknKD2A==
X-Received: by 2002:a17:903:494:b0:1db:2d8f:8dc1 with SMTP id
 jj20-20020a170903049400b001db2d8f8dc1mr520720plb.13.1707772394338; 
 Mon, 12 Feb 2024 13:13:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVEgA4QKWEEdFo5nGbLz6bJbbVwoZgZEUeFWYfaBqi2RoM0jd2Do8QdSwKy+PFFl5kzGjxUgEhhEGTa0c1/VcOwDzEFnsk=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 l13-20020a170903244d00b001d9b092bcd9sm762721pls.148.2024.02.12.13.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 13:13:13 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Mon, 12 Feb 2024 13:13:10 -0800
Message-Id: <20240212211310.8282-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/9tdmvCE7BvQeLYyMmHTfw4RYS2w>
Subject: [Bpf] [PATCH bpf-next v2] bpf,
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
* Add callx rows to table
* Update helper function to section to be agnostic between BPF_K vs
  BPF_X
* Rename "legacy" conformance group to "packet"

Based on mailing list discussion at
https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/

v1->v2: Incorporated feedback from Will Hawkins

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..9861bac6b 100644
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
+* reg_val(imm) gets the value of the register specified by 'imm'
+* call_by_address(value) means to call a helper function by the address specified by 'value' (see `Helper functions`_ for details)
+* call_by_btfid(value) means to call a helper function by the BTF ID specified by 'value' (see `Helper functions`_ for details)
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

