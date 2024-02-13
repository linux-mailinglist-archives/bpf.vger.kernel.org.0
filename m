Return-Path: <bpf+bounces-21866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95D8538FD
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D595D1F2478C
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9E604C9;
	Tue, 13 Feb 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Cz8U0CN9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="agJJ3tDy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ELOYrGph"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572D60266
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846714; cv=none; b=bAOFKc4mfqNK02YTyEnbygC1MewFKmYtVN5F0PgcyTtgR3/bsQJWk47ekW2UDKiR19XZ906WD/wXFgso0sjFDTJ39Ma8Nd005ksNzwUNWCVRfIUJR9l6PHihY8H8uQa4QlL5G+tUYklXLKhQk0Ozpd16o60YnfpB47so7xCjrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846714; c=relaxed/simple;
	bh=8FzUQOE5Jot2BOmqHVlAcg8ZWShUOCnovDAh1nEwaNc=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=D6exxDKxjY/f+OG4NmhMAKIxbfiOihohz0kmLWcJu+KrJ7DF/FvIOnrahNcfnUPwFO8bCgo9D9zjq2TYPo0UKL7bSWzHsNXPhFMDaBfN2IW40vmMvedSlfwZSuSJ6bHRyq+fWvN8kvL8/EDOd7839WAngNUt5OPjfS1dzjt2rjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Cz8U0CN9; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=agJJ3tDy reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ELOYrGph reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BCC9CC18DB88
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 09:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707846711; bh=8FzUQOE5Jot2BOmqHVlAcg8ZWShUOCnovDAh1nEwaNc=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cz8U0CN9whT77XYuFmPoVDM94DtIUblrxUQJ+436lRjjOv0wOSFDeaBLc6C04tR1j
	 tEeKDy01dcGy2pURdN6FC0oasQx83+w9twdafGhxgi+AaCslrM37Afxqnf0wGhwHz1
	 OWnl9lb5uwFe1BKMJDNznkzmAB7sNXek6ekONOOo=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5CFEFC1519A5;
 Tue, 13 Feb 2024 09:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707846711; bh=8FzUQOE5Jot2BOmqHVlAcg8ZWShUOCnovDAh1nEwaNc=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=agJJ3tDywfQOPeCgwOBGdUG5qjrwFH7PNdG92SDAp2UmLqW+aaiLCLvMq45ieHSha
 JXoU8x9EvAOuU50xzDq8jSufLmRlZ/z49dKx3KDli+XSczMREk8DpVbC1O2YNgKc5M
 ZacV8+KlSdF+Um/P4diZIojR07OUDqKQWcA0GxYU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id EDE60C1519A5
 for <bpf@ietfa.amsl.com>; Tue, 13 Feb 2024 09:51:49 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QlCxO8msGNN6 for <bpf@ietfa.amsl.com>;
 Tue, 13 Feb 2024 09:51:45 -0800 (PST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DC47BC1519A2
 for <bpf@ietf.org>; Tue, 13 Feb 2024 09:51:45 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3452696a12.3
 for <bpf@ietf.org>; Tue, 13 Feb 2024 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707846705; x=1708451505; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xP4JsOS2OzdsWVGPv2viY9EHxIt/q541G/godrI0sxc=;
 b=ELOYrGphI75pqy/E0estbpJ3yIRQWquXD5mIjug/wlW+lbA+eKP+QuV4XBiYGlJWxl
 eakux53Pn01l8Ys/Fgw3POKcLsT8lyi31dYegDTagtc7b7Z9K6WGGVm1Tozs4E9XdyMz
 8Gu4RIoLtMQar0U9JhwsKz976qY+p7EAPzOzmQR2UsAaYGKN7yWvbsVrihwt8uROEhti
 9hrga8XbTLKCuFxBrI0HxVjPMi3MXdSTFvtDK+Fm7DGfBfPL8nLv+m9dZ1TuwC74gXhq
 JHLSQTL7xba+fCAM0RhUE8HcgCeC5o5GNrmxwkXRIuRgbThirv0ljyUQvmEv3nwlhs/J
 2TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707846705; x=1708451505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xP4JsOS2OzdsWVGPv2viY9EHxIt/q541G/godrI0sxc=;
 b=Te6h+pKb+O+UJiP2DpDvYJ8tnr+cb3pxZdYTUaEFZ3m5WYPuAT7thuDzV7WUNJOi2H
 vd8EjWtjdr4E+UOGEm7o6vG9hweBdoII2GoI8iWPoYcbovB3VxglWBTaNKp4zWJNTRfT
 d1LFFCPS8fJeD5lIfLa0BNJPJoqI6/eupGrfDcoA3m1B0O5YVeqItvGuMYWA/+8sw4Kt
 yKbc3/Nd+A/vPkIVT6wXtIFFw8kDbA+KALErPO/2jYGCGTYLE+sv5ULJk4K3FSPZ5n1V
 5q74YKlZujGr/WmaKdOuprLMKa88yrVWv0rPhrN8WEOhlCBg+s+RM6oGN4TYRTcIT23b
 LBKA==
X-Gm-Message-State: AOJu0YxvN2Xi83CgvmpaJ8cuXicTjN/jjw/1gvKqWYhOdiLKpALV2JZA
 b3vpB2teMQjZaIfYaiIXYSInKWQiz7gaTsyZCwR58aNSC8MghEIs
X-Google-Smtp-Source: AGHT+IGb9/b3CiFodftXfJfR1UvsvqZa1aD1kL4rcHsyjo2Km/tOC59Fo60EhN5tp/KiBhtXuHLqfA==
X-Received: by 2002:a05:6a21:3183:b0:19e:425e:ec56 with SMTP id
 za3-20020a056a21318300b0019e425eec56mr369548pzb.24.1707846705010; 
 Tue, 13 Feb 2024 09:51:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBuICiQmWto6Dmhmg3vyltLZZRerONcXcm6zhUGN0oj8XpGR63Ej42YYHvAITMHDgUGHg5IhTVQwBQeOvaFS3O0W1lRM=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 u5-20020a056a00124500b006e03efbcb3esm7600905pfi.73.2024.02.13.09.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 09:51:44 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Tue, 13 Feb 2024 09:51:41 -0800
Message-Id: <20240213175141.10347-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/JzJ06NTMAGIVL0ceP8LrfM_6mtk>
Subject: [Bpf] [PATCH bpf-next v3] bpf,
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

