Return-Path: <bpf+bounces-21865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEC8538FC
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198F51C24328
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70109604D5;
	Tue, 13 Feb 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JYQYZMLd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E722604C9
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846708; cv=none; b=RPtTcKHUqUpWH8jJ+l1K2zRwrQBJU891Wbx1Xup3DWpi/1BuSVkDZfxUYKktr57Zr8nsWL6ZXPJCVgqT3aMDDkWRx1kTtqMNVnUzEzEd6nN86N+TTQ3/pC+pM5kfQoeF+u/mD34gQl8uaqzkIBim64tyXRT1TCDslyTgoIu/hG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846708; c=relaxed/simple;
	bh=pbVkJXwRY8kzAcuzI13Kg8hJSO9LxuRTtBJpL4Soy0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nnRjWtVYvgZI/G5Njpep94PMith02/Y2fzNcUCpdm6X7hBGUhJD4h+RWOkAt/40sIDFtGmSz4oJEBWmcmArt1xwxWQpclqFJzzRGY3YizEUW1AqmWBPoTY6rgeDGpoBXcAV81NNG1XMvzpE0+wYXBSqqCoX5qlxQbUawkbBiook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JYQYZMLd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3452701a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707846705; x=1708451505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xP4JsOS2OzdsWVGPv2viY9EHxIt/q541G/godrI0sxc=;
        b=JYQYZMLdfDmXgMs32zjoP5HKlD3rsb3aNyEAtgHlX3N5tgqVi8+5ZFB4DVFHiFS7Uj
         n4PMvEWMlQCM/C3wUOiIu7h171gjcXSQWfYJUONXUOpxSVF2fHxlNtrkX/YK3/Nt8AgG
         SGF1TpPFiOD6MjlbY8q/T2/ExQu5ZZD31S1CUlZmxZbXuRg4pv36m7d/PueguJYlTjic
         4TnM86QQV0wOs73M49eW3/kPZNAWxatAC82nrhFIADTUtVcg6c/6Ov09VbkyyNsKsCjT
         UUpWCx+fMwzgp6N9eMb6ypaIbgjUwToWYKFcvTNwGDdmhuzuqe7QK21u5/KH2czoU3Ni
         ENng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846705; x=1708451505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xP4JsOS2OzdsWVGPv2viY9EHxIt/q541G/godrI0sxc=;
        b=QbMdepDSSn2fyNpPJwlTEH3IBPiQszRJ/skyOMewdD6pBm4IcrQIkqbEtspDIslnNo
         uWsYLisCaAbvmtxs12IQOAARr9KSl2jJ5D9/oIKC0TlPvMGwSZ4eZWpnPK6C/OFRXDBx
         tnH8oHuSjXRaAk8lbzrP73MqRMlPzD7hZpE03PG6jfLV/Uji30hLJJL5kypjZpvijaC+
         O228F9dYefVox1+leqYfCQLR1Ptmq04j/U+apaf9fxby3Xyk4SmEV6YYGvwcnEI78JRo
         eZNKn58bpri1VucT6SNJHDmWHxKMTbGPsEcDcWNL5aoKXnZhfqGz3U9eOo71KmrMx7zf
         Cw4Q==
X-Gm-Message-State: AOJu0Yyw1lvugymcJT9j3EWyFq/a7hqB4ozxB1+GUG+Jfy7eEuESz9I1
	tfA0ohQS433VhWez5rlRvtTQd5pOTxjJ10BCkAKw8mW3G0JRDxyfjUskhTQa4yo=
X-Google-Smtp-Source: AGHT+IGb9/b3CiFodftXfJfR1UvsvqZa1aD1kL4rcHsyjo2Km/tOC59Fo60EhN5tp/KiBhtXuHLqfA==
X-Received: by 2002:a05:6a21:3183:b0:19e:425e:ec56 with SMTP id za3-20020a056a21318300b0019e425eec56mr369548pzb.24.1707846705010;
        Tue, 13 Feb 2024 09:51:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIBuICiQmWto6Dmhmg3vyltLZZRerONcXcm6zhUGN0oj8XpGR63Ej42YYHvAITMHDgUGHg5IhTVQwBQeOvaFS3O0W1lRM=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00124500b006e03efbcb3esm7600905pfi.73.2024.02.13.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:51:44 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next v3] bpf, docs: Add callx instructions in new conformance group
Date: Tue, 13 Feb 2024 09:51:41 -0800
Message-Id: <20240213175141.10347-1-dthaler1968@gmail.com>
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

v1->v2: Incorporated feedback from Will Hawkins

v2->v3: Use "dst" not "imm" field

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..4bba656b6 100644
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
+BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X only
 BPF_CALL  0x8    0x1  call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
-BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x1  call PC += dst                   BPF_JMP | BPF_X only, see `Program-local functions`_
+BPF_CALL  0x8    0x2  call_by_btfid(imm)               BPF_JMP | BPF_K only
+BPF_CALL  0x8    0x2  call_by_btfid(dst)               BPF_JMP | BPF_X only
 BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K only
 BPF_JLT   0xa    any  PC += offset if dst < src        unsigned
 BPF_JLE   0xb    any  PC += offset if dst <= src       unsigned
@@ -414,6 +417,11 @@ BPF_JSLT  0xc    any  PC += offset if dst < src        signed
 BPF_JSLE  0xd    any  PC += offset if dst <= src       signed
 ========  =====  ===  ===============================  =============================================
 
+where
+
+* call_by_address(value) means to call a helper function by the address specified by 'value' (see `Helper functions`_ for details)
+* call_by_btfid(value) means to call a helper function by the BTF ID specified by 'value' (see `Helper functions`_ for details)
+
 The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
 
@@ -438,8 +446,9 @@ specified by the 'imm' field. A > 16-bit conditional jump may be
 converted to a < 16-bit conditional jump plus a 32-bit unconditional
 jump.
 
-All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
-base32 conformance group.
+All ``BPF_CALL | BPF_X`` instructions belong to the callx
+conformance group.  All other ``BPF_CALL`` instructions and all
+``BPF_JA`` instructions belong to the base32 conformance group.
 
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -447,13 +456,13 @@ Helper functions
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
@@ -660,4 +669,4 @@ carried over from classic BPF. These instructions used an instruction
 class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
 mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
-instructions belong to the "legacy" conformance group.
+instructions belong to the "packet" conformance group.
-- 
2.40.1


