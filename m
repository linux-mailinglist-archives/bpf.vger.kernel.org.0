Return-Path: <bpf+bounces-77352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD4CD8588
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BA3301E22D
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2601AAE13;
	Tue, 23 Dec 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lLyoI/Z9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sp/FPbPm"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3E309F02;
	Tue, 23 Dec 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473461; cv=none; b=jI+iK+vL56J8yvQZ08uM70uec6vT/G2DQwwYBLvJcq9l1J0dbV1ViXd+Nh2edMSPZE1MqG4zR12qpG9xd7/v0SioFxVR3e2iDu4Tu8rVaOdOxdSyTGwCszqb+fOztt6k0y8OyLE80La/ylUUk+aJEPqkU3IDZ4b/+SKiwU3eYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473461; c=relaxed/simple;
	bh=tuGHt3DLLTu5lXcwHSaMZsZn6szkZwAMb14MrkMu94c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JY17BSp9OoYbt2cAO5Di2kJYODq7LBOSDwvjraSOw8snLKHG+kmdsVu8+RQIDJ1Y6bkXipXGt0T2W7WtPl5sF+PDwJAXuRgqV0B1CngUAolypwRtPDwezmRv1AlJvf7/TbzWf4bhjHjkZGYW0bmR7Tu4zoTvhU1zMDQvEu9b9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lLyoI/Z9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sp/FPbPm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7SWYdn3Oi5rBRPPinrxOjmT14ISIjczlskQPXhJWD8=;
	b=lLyoI/Z9RvVQLGAKme1YBPSMhLACkSnowidwFR9AgVrroUaikbewrnuxsYHoog23T+p4i7
	cTFd0xno108AraJFj5/jyr/EEJhsZ5H9YUF5StaA2BgCV2tkNyCoqWtnB4fOTURbMashWI
	L3cpW/A/mAruI6kEMTzaA7H/506yV+xRjE2XEwYdOi8siRoHqR1ZWcqdsP2lTuwVYGhMSv
	QLWw72rBO8u2s0T5NlguaOiMnd9twLOP8L8ZdC/lEFHmeomDa3Xe1rFseNvlCVn3RZiLyX
	r52rtfQtZFEWLzpBcffELOSDAZIB7K/gbNiznnx2+PXdPitBKMK2ADQRaWLGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7SWYdn3Oi5rBRPPinrxOjmT14ISIjczlskQPXhJWD8=;
	b=sp/FPbPmopsd5WYL5E6M/biUSiwcihfaCZqGcNcMfrQfNPoJ9jseO3YcijZpARFVS1s3mD
	7Iy7s12Sk4QVYPBA==
Date: Tue, 23 Dec 2025 08:04:11 +0100
Subject: [PATCH 4/5] kbuild: uapi: split out command conditions into
 variables
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-uapi-nostdinc-v1-4-d91545d794f7@linutronix.de>
References: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
In-Reply-To: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473456; l=1180;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tuGHt3DLLTu5lXcwHSaMZsZn6szkZwAMb14MrkMu94c=;
 b=O3HX+r+GMW6Fr6wLVUcLDIW6UjAe+0+He/8kBbARi4B+D+q7d8OYAPW0RVuC69oHTvPIvdDb3
 oymDR+RP+LoDfvHlcc16fJF4pa9hqghoQbK7lRjNgAmdpIoPVxcwScJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The condition logic will become a bit more complicated.

Split them out into dedicated variables so they stay readable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 usr/include/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index fd29c11c35cb..fa01bcda21f5 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -150,12 +150,15 @@ endif
 
 always-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/dev/null))
 
+target-no-libc = $(filter-out $(uses-libc), $*.h)
+target-can-compile = $(filter-out $(no-header-test), $*.h)
+
 # Include the header twice to detect missing include guard.
 quiet_cmd_hdrtest = HDRTEST $<
       cmd_hdrtest = \
 		$(CC) $(c_flags) -fsyntax-only -Werror -x c /dev/null \
-			$(if $(filter-out $(uses-libc), $*.h), -nostdinc) \
-			$(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
+			$(if $(target-no-libc), -nostdinc) \
+			$(if $(target-can-compile), -include $< -include $<); \
 		$(PERL) $(src)/headers_check.pl $(obj) $<; \
 		touch $@
 

-- 
2.52.0


