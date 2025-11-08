Return-Path: <bpf+bounces-74000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5A2C43515
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 23:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D8C18893CA
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67224DFF3;
	Sat,  8 Nov 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Z8IP5v0O";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="7tTrNyAO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F123B616;
	Sat,  8 Nov 2025 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762639611; cv=none; b=XDTOfLdoUmVxS0qx3LvGqgIXNv86R8dWNtUEg4ZnqZhS8Dhq2DCmiC54cImDAFyxm5nAShAqTmxXdvIgJcm6ryFiqWXFcFxnX5C4DbjosRs8AW0F6yD7rPwAT/uKGrUCVCAY1ANjtoULlaLPW38Hg76/0tnkI127OsOYSQOu/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762639611; c=relaxed/simple;
	bh=/ofQbxb+amF8hA0q0+/tC5F4n8m2nCJBW2xuireyQ5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MobUjCT83Nk0GGlKPW6ERh0p3keVY/pAqe13jsOJXwstwF+VjVn0H04UYvuNYaJrQqWZEi5nN/pWIFo8sz+EfBcEA56X3LbziyFR3+Nn3TkXpgiaPXrKrbXLRxYj6jP371bOKTFyDjK6BcJapsDMPkQl9+XuUAeDd9DzhQeVbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Z8IP5v0O; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=7tTrNyAO; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1762639583; bh=9eeMje1PTx/sNTR1MiULRj5
	s3httCogbc90TIndk8XI=; b=Z8IP5v0OLbDIO5qSHFWnFuhw06Pk5gMpKfF97x6BYbNbhhpmIw
	AVo4KeuM0GwNXemmtFxOlL+GN5yK3F15piVRkPC1TQwG9+L0UCaiwyCQseGob0dWp7NGgPo+9cP
	mwbzbvPdIWlIRyQiPs/AhMDdk/UxzkG3XwL035xcGOUEH0oswtWFPxkKqYYhWnw1aRhpD68/iHT
	wLTJ7KJkuBHeppp9FtXjJDRTRXqaliFbg+JFbFXdC3LIh8pTO7dfGxqwFvACIfqylhv6bB0iyz8
	3GdD0of7NJRtpMaIC/CNpYVZ2dM/adWz3dEDRz0cEJQbPz2smgpdv74fh+fitxMwKOw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1762639583; bh=9eeMje1PTx/sNTR1MiULRj5
	s3httCogbc90TIndk8XI=; b=7tTrNyAO9IPXExS0+0gqCXsdBWJpr2bAzHOrJp6fEUv68KABDP
	b5A/6XRcdayOEJrA6WhgvqszbxheoJf9F+AQ==;
From: Jens Reidel <adrian@mainlining.org>
Date: Sat, 08 Nov 2025 23:05:55 +0100
Subject: [PATCH] mips: Use generic endianness macros instead of
 MIPS-specific ones
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-mips-bpf-fix-v1-1-0467c3ee2613@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsG1Ausr0SFtrT1kohCB9Pek4
 wzMFMichDNMTYHEt2S5QgVqG3DHGnZG2SqDVnogUgZPiRlt9OjlQbORp966flQd1CQmrvrfzcv
 7fo4GTT1eAAAA
X-Change-ID: 20251108-mips-bpf-fix-8d1f14bc4903
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=adrian@mainlining.org;
 h=from:subject:message-id; bh=/ofQbxb+amF8hA0q0+/tC5F4n8m2nCJBW2xuireyQ5o=;
 b=owGbwMvMwCWmfPDpV6GDysyMp9WSGDL5993f/exSibjCZo4pS7N+3lRyP7iXI5Fhs6fWoaUPt
 pntjuZ16ihlYRDjYpAVU2Spv5FgctX626H5+TarYeawMoEMYeDiFICJhAUz/FO+nXA7smPlhn17
 5FynufSU/X8iNc2xff3RderBGZe2P5Fm+Kft3dvxSGf1g66L8gxltb4+RVknrB8dDrx+P8T6yCI
 xBW4A
X-Developer-Key: i=adrian@mainlining.org; a=openpgp;
 fpr=7FD86034D53BF6C29F6F3CAB23C1E5F512C12303

Compiling bpf_skel for mips currently fails because clang --target=bpf
is invoked and the source files include byteorder.h, which uses the
MIPS-specific macros to determine the endianness, rather than the generic
__LITTLE_ENDIAN__ / __BIG_ENDIAN__. Fix this by using the generic
macros, which are also defined when targeting bpf. This is already done
similarly for powerpc.

Signed-off-by: Jens Reidel <adrian@mainlining.org>
---
 arch/mips/include/uapi/asm/byteorder.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/uapi/asm/byteorder.h b/arch/mips/include/uapi/asm/byteorder.h
index b4edc85f9c30c09aafbc189ec820e6e2f7cbe0d8..5e3c3baa24994a9f3637bf2b63ea7c3577cae541 100644
--- a/arch/mips/include/uapi/asm/byteorder.h
+++ b/arch/mips/include/uapi/asm/byteorder.h
@@ -9,12 +9,10 @@
 #ifndef _ASM_BYTEORDER_H
 #define _ASM_BYTEORDER_H
 
-#if defined(__MIPSEB__)
-#include <linux/byteorder/big_endian.h>
-#elif defined(__MIPSEL__)
+#ifdef __LITTLE_ENDIAN__
 #include <linux/byteorder/little_endian.h>
 #else
-# error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
+#include <linux/byteorder/big_endian.h>
 #endif
 
 #endif /* _ASM_BYTEORDER_H */

---
base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
change-id: 20251108-mips-bpf-fix-8d1f14bc4903

Best regards,
-- 
Jens Reidel <adrian@mainlining.org>


