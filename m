Return-Path: <bpf+bounces-21556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85184EBB5
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBF71C23507
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3B5024F;
	Thu,  8 Feb 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ocs8farW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HYIAklhp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R2beU+08"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B94F8BE
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707431571; cv=none; b=iHEW5fYP8xrdN86DfTP2pb7yejMeyXuvzJZTfWbMRdnteVRyBm9ys+10jVBd/Nl1w3R9LEJL2zw0tsnnIQJsNyUYEjT8SPUgtkqUiTOOWlNTjgM6YPPJsjcTrpnXur67FDRaQgr+GqHYbQxStDfps0pNYQ4jFBinJ9a8T3fXirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707431571; c=relaxed/simple;
	bh=Q5W3f2gmgQRFQxhXeQ7SIndcV1Itr/1DCT+1juei9SU=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=sA0WKxPNCfz8GOBpng8VNOYfJl0D7hA9CE7NA66+afedzF+0erf6wlGQoQuAyYY77BfXHWVGghxZBBmxatu3JHrBJ+KBbMujW5hrqjiaPpQWifJqeucKJ+F4OO7ZiwzaOrPCi/grDmnDAWD9bmF5hvqfIM3nk5d8stjhLt/h1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ocs8farW; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HYIAklhp reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=R2beU+08 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9CD31C1C64BD
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 14:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707431568; bh=Q5W3f2gmgQRFQxhXeQ7SIndcV1Itr/1DCT+1juei9SU=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ocs8farWBca5Bms6bkZAIoVGi7PpI4uGu6vjF51kEAdTUhUxb78jK1g4bdOaZ854D
	 8ZChcTVn/pmfCWi9Wq5vm4Wbs2xyuMRcTx+OEboSL73tKRi9qo6YVYk7whtntowlYm
	 Fw4d1wqG/kHketqK00yNwbFJu6DfvpB45GTpUxKQ=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5BEE9C14F602;
 Thu,  8 Feb 2024 14:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707431568; bh=Q5W3f2gmgQRFQxhXeQ7SIndcV1Itr/1DCT+1juei9SU=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=HYIAklhp1WNHT3TzXfn5jftAaR53Th8VmtlmQbjN4INsSHuGOwPrny6SRuhEK6bN+
 gZCo3+f+4txwrhpMS3192VgimTHSEqiBBL72y6FBq2aqFFvhslI/mnPoJMXf06dF+k
 s5JhZus3bPCQ2PS6Er3g42GZzi5qzUOP43LcPwSU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CBFE6C14F602
 for <bpf@ietfa.amsl.com>; Thu,  8 Feb 2024 14:32:47 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C7UQmecJSVA6 for <bpf@ietfa.amsl.com>;
 Thu,  8 Feb 2024 14:32:43 -0800 (PST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B217EC14F5FC
 for <bpf@ietf.org>; Thu,  8 Feb 2024 14:32:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e053b272b0so233925b3a.1
 for <bpf@ietf.org>; Thu, 08 Feb 2024 14:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707431563; x=1708036363; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D9WmWWoqgQMUOKjDh/gXP7em1keHy9w0N/gQ7JlSOH8=;
 b=R2beU+08XrXi06r05yTjRvS4ay06dIEXcQSPuMcmcNMv6BUGK7GOEsdO2scCw+lfq8
 xessB9Z75tH2TNOOrHHuG3FwdR2+h01WviLy+DXr/z0cXAilq2njC06v72u4VWWgXcXT
 oEZ1ciGBoh0UX4sHOOycgUVtbYOiYCNly9npJ1K+/Ybe7YXHunUqk5i/ngcrSMZnss2k
 TviZjlYwD773KLLBegdUD1ardCtW9UDFRSs2qOeGxfbqupYVYnAzEwTiQ39YrtROtqhd
 V9ygHJlhRvdpk4xDa+Mme3ZsE2tL4OiLMYpg/ypVZwPeGq+ffps1DlTg46YaOdyG7a3B
 M62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707431563; x=1708036363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9WmWWoqgQMUOKjDh/gXP7em1keHy9w0N/gQ7JlSOH8=;
 b=Ft7y+3fx22/taG0ruTlvpyxazzSWTg0Nh9tunpWalNJoLUUfB+3R494pW8MbXE8UeA
 wtXmHpasho4GeWOm346rMCSge6eBHUnX+WHsR+8L6/HVHPdzYaYw2F8PS4awQqGtsZzY
 8DK29t2caSJkZ1nFN20aAGDRWXHWOeeJsNaIFNThBQQSkf5S94UmBMihWrir0pxz3mki
 IF2v1IZSXC07PuN31wm8uhStYKDjjvLBI3p513aYPeKaV6g+bi2I3HYYYtGj8b3hflhW
 rqXhI36ZApnOaW+GDvCIb4FGIeQ7DZzN12czGyvlX1+UVVma1oM/4QJ97kDzxjnk0I6x
 P2MA==
X-Gm-Message-State: AOJu0YyIvYaSDKKcvBi/pzi6NOD2uJ3p5pI82N3Puqzxogrgyz83ffu+
 zJJXcoVtPKmxD6L2r57iiIZaVcECtKHGFPJxv4MOPDnZ9+YBCrBRZDwpQwe6lAY=
X-Google-Smtp-Source: AGHT+IGy4W79ZFp+NVFu3h4Tybt2Vka4WAHaPp+t1LGDWLUpwJ+rqAb+7Sj95ao2MACyGq+NcQh/mw==
X-Received: by 2002:a05:6a20:431a:b0:19c:9a26:b958 with SMTP id
 h26-20020a056a20431a00b0019c9a26b958mr1290223pzk.35.1707431562754; 
 Thu, 08 Feb 2024 14:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXRy9PkXzF1LhgDG9WyE/ayniozsrgXwCjhm6X3NKlYjwXyVR8j61LiYGIYQWXF+MEL4ZtV06/8lchdTGzijfLfspdSWQc=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 z19-20020aa785d3000000b006ddcf5d5b0bsm271088pfn.153.2024.02.08.14.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:32:42 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Thu,  8 Feb 2024 14:32:37 -0800
Message-Id: <20240208223237.12528-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Wp4kYteVkk5h1vPxnckQZela8lQ>
Subject: [Bpf] [PATCH bpf-next] bpf,
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

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..8f0ada22e 100644
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
+* reg_val(imm) gets the value of the register with the specified number
+* call_by_address(value) means to call a helper function by address (see `Helper functions`_ for details)
+* call_by_btfid(value) means to call a helper function by BTF ID (see `Helper functions`_ for details)
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

