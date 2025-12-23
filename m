Return-Path: <bpf+bounces-77351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26DCD85AD
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D25930492B4
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BBA30CDB5;
	Tue, 23 Dec 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwBVtD3t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pl5JU7N3"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832E3090EB;
	Tue, 23 Dec 2025 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473461; cv=none; b=aOjlDEEIz6mWTwaKqhbJHq+7dImbTRv7yyEfKPnAOPrztEs09yMGC5/IWgJxERyHamYzs8ZFMwRSY48QtcLXDQe/hzlnMyKTFpSJ3KnU5xIcn5b4FRpJhhH95cCnU5nEK7qtxWI/VMUoPVxGVwQ9+khDCfZMSyseWlgbxvxLiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473461; c=relaxed/simple;
	bh=Zm7fWvYFAWJNdv0m1Ct8W4h4ycRsgtbyuhmhof7tf4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxptkwzsYtcO/K0G3Qb61/N/2GiKYo58iKcOwiSdUH6oPKjp0wOMaGi6ysg0FHts7/WzidIfulXhN7KUwKRyzUBmw0uHsQy0TCMid3HEToN+4i1LT2N0NUg7dSCPHUilPLT9GB6S+whmropYi2YotrC2jnDslVsS4OJJ2u/XPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwBVtD3t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pl5JU7N3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHuvlCnwOf0FSCs0IK4C5Ex5NQu3u4/V//8wm3JYWt0=;
	b=VwBVtD3tTRMlm0/bdmrRxNtCOEqDC329gYeA4cAE5f7eM+DiCaK9juKzEUCf8GMTbwbihD
	qmYBghcgtmS8GBojY4DgfKd2yNNXo9upqwV1tVTjvrQfF9cFSK4YRs6Snz+fG9BlCWK1YH
	NJQql7xFoCiEwqAd76dhg5UX+gA6f+i2ZqF1pzaAIXe6zToYhb96xywQF7xfDA3JkwYERL
	PZcZGNwM/8/cqJWOmvG7dp57CRPo+X8O5aPvwhNRtspYEQ/cmhZPbRXJVXmjEkH3XdthMu
	zxCqlxYbJa9pIkQHLsACDX4yyoSXJCupTpi1U5O5ExKjyjdCnFyXlhP/BfHoGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHuvlCnwOf0FSCs0IK4C5Ex5NQu3u4/V//8wm3JYWt0=;
	b=pl5JU7N3/lDxDSBHpOoWOfBhQxBXOyLaGQHGA4E2Slx88mY9FuBoUrgHnX9dy2zWOfmgTN
	VJZfC8XXmYxTBTCQ==
Date: Tue, 23 Dec 2025 08:04:10 +0100
Subject: [PATCH 3/5] kbuild: uapi: don't compile test bpf_perf_event.h on
 xtensa
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-uapi-nostdinc-v1-3-d91545d794f7@linutronix.de>
References: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
In-Reply-To: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473456; l=816;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Zm7fWvYFAWJNdv0m1Ct8W4h4ycRsgtbyuhmhof7tf4I=;
 b=WvJaoCPxYrDbMS+Tcc92EHEbCf79n1IcIFVtU9DGJseimX2+aH0ut+DP0NKx7QkouIJRnr47E
 TiKcysN6z3lCAuYQzGYxztzce46ag2UJrwT49J5NUjSerhmY+w1pI7C
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The xtensa UAPI headers do not provide 'struct pt_regs',
triggering an error:

usr/include/linux/bpf_perf_event.h:14:28: error: field 'regs' has incomplete type

Disable the header tests for this file on xtensa.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 usr/include/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index a9a861ec8702..fd29c11c35cb 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -65,6 +65,10 @@ no-header-test += asm/uctx.h
 no-header-test += asm/fbio.h
 endif
 
+ifeq ($(SRCARCH),xtensa)
+no-header-test += linux/bpf_perf_event.h
+endif
+
 # asm-generic/*.h is used by asm/*.h, and should not be included directly
 no-header-test += asm-generic/%
 

-- 
2.52.0


