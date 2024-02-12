Return-Path: <bpf+bounces-21773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20628851F44
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C341284E6E
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24444C622;
	Mon, 12 Feb 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EoGBjjFK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51BB4C61B
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772397; cv=none; b=TqWlpETUnCSgxoCy1IKriKjxeeVpn8H+wXFwIz1e5V2IilaG1rmPGXhoOJVDXNg7OebjWu3Lr9EVVppTN1zajdUulVD7tcgz+f6LSpYQHdQV25ywXsE3lAL3hac2EpHNfDcpsqmeBg8j5vunQkJ9DgaaXfHJwqWfgHNgKzqJFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772397; c=relaxed/simple;
	bh=XwzKBJdknRJ9mcMmeJJyDRUelJMTY7wcrykrkR4WaEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYVEFcqMxs+t2txbW0Tyl9XwhkagQ8D61Ak4zhnKSQAmbUivtyBiTfuY4V5KCmsCvVhsoGrdnN/iF6E46EYF35Y0rIj+b5m9Hu1Nz2zVYSZooP3Oxyv88Ge2BdlFOmI8tjn/fEWIPqSVQEejqgQCWUzP1J79kZ4EoHNEE6aelYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EoGBjjFK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d958e0d73dso25304475ad.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707772395; x=1708377195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y3qDIbEUDhtRMCmQ9gvyrPS3BRUQBD/sYtg6yEOvUg=;
        b=EoGBjjFKanEEf8yAKYyLNrzuV3bGGpMGUP4uJIzhEOtpta2tV8vNYTBFuM9SqCMjRm
         YotujUpMm4xLlBHjOcu9z0fcpjy0u8oMd+lKprex3lzF69USe8uf5PBgeruVXLN8/5ON
         JR5MV2z60BLrmsQaOQPTlyfNVlZVVTVuCi/ujoWvJ5rRzW58FyoGWcND4b4o7MTTk5L7
         9T1OJFMuLvbB4OXbXLw1UtyWawLiLa4RaMe67VoieoNmw0JP1LKU9rolCC7SMiN5nPlI
         9bY+47cxcs9sJ9KUM4PRcHQfWVSwitpVzi+2fdYBC9f/CiVf5d/46hPbAh4GxYSKTRC8
         EqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772395; x=1708377195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y3qDIbEUDhtRMCmQ9gvyrPS3BRUQBD/sYtg6yEOvUg=;
        b=uaxY0U5c5vs/MwSbaJebKXKOZXJJxQJMMBGwJCVumWQYeTvy/EcNHi5l0l+M8SBgKn
         feMNevXt1ocD41ozAGwuY12pp+thkNM729hx3RRIC8VgLM8GY/OLMnhdNTZDExiCf1WF
         As8qG/Pn54axTl+fxdT22hEsX4/VEMGL2/kefs9sy/5jhyEFr4mxnsSaE2DNVdnxNzZN
         NDIc49jUASaLbH4CG4rkXsVGQc3OUUNYe2G3czs6wDtbAMwPEcTeTGuIQJJO9h5h60sx
         pLgjPq9sNG3LBO+ukrTZXUz0vFL7oopnaHee/yLk8IGV0Tp5fuY14yUjJA8dzqA+Fl3K
         P5gw==
X-Gm-Message-State: AOJu0Yw/hF0CQfB+6qJWRnOuAKO4/h2W8m8N0sN8yMS5FkJrekvqQ4F8
	2XurOsMm7c3WcoiexKzNf6x0QgjPz5QoZhXs/98/8RyI7+hL1T/V0uL4s6TwBNI=
X-Google-Smtp-Source: AGHT+IFkuMhe9/ysk/wBgeexWHFrd+8JKQQYLuk4aTPiZU9xEcahE2sKGM/C59bQThJqj6zGknKD2A==
X-Received: by 2002:a17:903:494:b0:1db:2d8f:8dc1 with SMTP id jj20-20020a170903049400b001db2d8f8dc1mr520720plb.13.1707772394338;
        Mon, 12 Feb 2024 13:13:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEgA4QKWEEdFo5nGbLz6bJbbVwoZgZEUeFWYfaBqi2RoM0jd2Do8QdSwKy+PFFl5kzGjxUgEhhEGTa0c1/VcOwDzEFnsk=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001d9b092bcd9sm762721pls.148.2024.02.12.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:13:13 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next v2] bpf, docs: Add callx instructions in new conformance group
Date: Mon, 12 Feb 2024 13:13:10 -0800
Message-Id: <20240212211310.8282-1-dthaler1968@gmail.com>
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


