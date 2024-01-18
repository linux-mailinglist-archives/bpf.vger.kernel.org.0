Return-Path: <bpf+bounces-19849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD246832242
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C23328871A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093641DFFA;
	Thu, 18 Jan 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="tcqtXrXC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="wO8Qy01S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X3Jy4MIb"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC041E88F
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620616; cv=none; b=NHwBT3IKRoBGD0UIqHqsXGiFCf0sjHceZZuifqV3JIa7ftW6C30EDjYxUxLAbpM5rR70879sAQDdLfpqjRVsWiGw8ELjBo8bRmjF8QsvAXUiod1H8+Xf7WQPRbuqS59VtDjyuuBZmMPHIfmUupQ+Tw2rjhTBLSFnXXsnMwmTpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620616; c=relaxed/simple;
	bh=YVL7Xe07fEOCCRX/xzbsXPlr0wt06224eqqTBudQdsI=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=PNiRmXy6yi7ZvfMFa4NQAj+G1CD4UIPOVrBG9axyuOuMFJcthrRpKT306QfZ8B11mRuPzW0h1K3OmySSepK+asTo2IEehTLf8VRdSlCWYDTabdJOyvZgpaC+pfFGq/tY07cKHBznEkMoe65t6vs3pUzgw0hxPmNAv3fp4pj7/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=tcqtXrXC; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=wO8Qy01S reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=X3Jy4MIb reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EFAFFC14CE51
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705620614; bh=YVL7Xe07fEOCCRX/xzbsXPlr0wt06224eqqTBudQdsI=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tcqtXrXCnm/l/noS+1c4M6iuASkl4p9+M9MM4fv0xsb7PXEHpZNslxhv0J6G6vbDT
	 8LxC+VIFKogCrQHU8YDrhzSNdaGvPvH5PJ4MGJjGl8yFccnvkeStZtjKfkYeZB9kPN
	 8CWgo0hSAyT2TiHGZHiSIp88Mhw/f14dTf6cxWVQ=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id B8CBFC14CEFA;
 Thu, 18 Jan 2024 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1705620613; bh=YVL7Xe07fEOCCRX/xzbsXPlr0wt06224eqqTBudQdsI=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=wO8Qy01SfFoG+AdcEpvNsgbVG1NIi8RBel2GI18sGXwxz2ELc47zG+lH1yfKFX5Xz
 m3Re4HWty4f/SCScJLpwy76q+ufy9q+TWqR4uZeVYp3J1OnTVG26y9BP+U8tC6JWTK
 4O5B1obKUiJa7g8ETTlgrA+zoHB4qJqRywxEjnvU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 42781C14CEFA
 for <bpf@ietfa.amsl.com>; Thu, 18 Jan 2024 15:30:13 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.854
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGlGlBPNw9Li for <bpf@ietfa.amsl.com>;
 Thu, 18 Jan 2024 15:30:09 -0800 (PST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9FB51C14F602
 for <bpf@ietf.org>; Thu, 18 Jan 2024 15:30:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6db79e11596so213446b3a.0
 for <bpf@ietf.org>; Thu, 18 Jan 2024 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1705620609; x=1706225409; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ioogeLx+74muZbeEkvEVMi/iHfl4LvcvtqKYeaQeBCA=;
 b=X3Jy4MIbUWVIs/E+TK7kjLIFffGRJ1pOl5YZ6dBnpLNARuhKDKOw7ndzzk2fObqf0p
 wh+B1nIYiGLRXOOnlms39d3rSHCKYpi+6p7G2hgdZG1sL2GiLAfnjNl9W+EbXvaoIM15
 RQr3y+rmN9Hf3aFB1mZn82llWXhIwZk2aCLFbsrc/omVmE8CIQCLmqN6xlqYaQPp3kV8
 0SgzyVPmi9d6T6Su2XHsachQb1mYpgqyGxD7QnB1JrGNoD4Sq7riww/N8SMBdcqa1/wn
 Q51p/186xRAPPRHF0kzgF/Y3dXLhAZhHw8oygpuqI06DlozUPNfAaUidfFPwjqXkrZFy
 lzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705620609; x=1706225409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ioogeLx+74muZbeEkvEVMi/iHfl4LvcvtqKYeaQeBCA=;
 b=RuHPHBUuctr20MCQLjG7bYvCRYulNLAD0UssmmU9CmZ9TywoCE+qX7398FQVLhsDEm
 k23cpndL8GV2192eWZYGtlrygDAR0nxhLaj5I95i6oZSo3QXRd2r1h7W6i4LMBX9RdKc
 CgnF+EBLJI0chrLPYzyp+YAllDiKePOvT0XaTOVZwcDx0o/NnMFq6f7XVjEsKN2Dxm9N
 2/yQsMSgPb3MEWtsh245YOr+dcPZz1JGqJ3EeoR+O2cGB6sV6mmvxiGOH2tqiD2HQOoL
 34TejR8uttm1FEdflofofbRI3gFMZnsOD9+dGjcCDJ20WLLtK4Ry6y2qE6S6/hHw1HaW
 sJZw==
X-Gm-Message-State: AOJu0Yx3e3YCWA99eqYWad0aA25Lze6HJulDk/DHAsXFv1iskBefVv2c
 7SAGinh9dR2nns6YAgjJOsvePpzFIAp+TQNiezQubq9beA/CXIRxvpSY10rWBmg=
X-Google-Smtp-Source: AGHT+IEyv9y6uis6khDQHvBrXdalw5Di3YAm1aMR/aQAxnmj7tK8SCcRHYpBxtanDRMsA0QboSFFHA==
X-Received: by 2002:a05:6a00:2441:b0:6d9:8ddc:37e0 with SMTP id
 d1-20020a056a00244100b006d98ddc37e0mr97148pfj.28.1705620608816; 
 Thu, 18 Jan 2024 15:30:08 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 s13-20020a056a00194d00b006db13a02921sm3809815pfk.183.2024.01.18.15.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 15:30:08 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Thu, 18 Jan 2024 15:29:54 -0800
Message-Id: <20240118232954.27206-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/WNFgh9ynOFnFGuakBkO4TCNrXDc>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify that MOVSX is only for BPF_X not BPF_K
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

Per discussion on the mailing list at
https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74/
the MOVSX operation is only defined to support register extension.

The document didn't previously state this and incorrectly implied
that one could use an immediate value.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index eb0f234a8..d17a96c62 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -317,7 +317,8 @@ The ``BPF_MOVSX`` instruction does a move operation with sign extension.
 ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
 bit operands, and zeroes the remaining upper 32 bits.
 ``BPF_ALU64 | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
-operands into 64 bit operands.
+operands into 64 bit operands.  Unlike other arithmetic instructions,
+``BPF_MOVSX`` is only defined for register source operands (``BPF_X``).
 
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
 for 32-bit operations.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

