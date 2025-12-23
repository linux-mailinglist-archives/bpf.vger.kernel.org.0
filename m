Return-Path: <bpf+bounces-77350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F8CD8573
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 011F53002507
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651EB30BF74;
	Tue, 23 Dec 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfGumtgB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UGsKy55S"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC52C11C4;
	Tue, 23 Dec 2025 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473460; cv=none; b=V6mdup4ihh9mKykt/F+R8/6zR29ZrpvvhxzrpSD2o6HhgixWef4XoqH85KQguN3TChqokj/IN3Mhbdz3K7DSMt+T0xOQyMgMFYvBxPPN01YUxQ5nwCoR1h3XuQPJikg/MOnRaQ0AQykc/XPTcdIgrgahZJQAqUZsUTflscsxVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473460; c=relaxed/simple;
	bh=K/unO6+pepLfO2osiSqrw9BSyrlWWQpEI/4E70KxQeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDaXRKHWJYFDe32ZeglTFr10yf0SPG3PT3xCoKburbPoDc2NuL48a5F346FsXVX8+m8Hfa2iqyL5XvHjHNXrt4lboBWDJNMWz+QyQExoSB9vbAhoFTJa27uxP8mkNhsWC8ogxsDT5r5vx6xppbIrP1fIX1uiFBHMMMzla83mShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hfGumtgB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UGsKy55S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBI5m5fOsqa8GvlEA5EmwGOkzB7rIX+/Or7sr4YAcC0=;
	b=hfGumtgBCoi1WLF9yTF1C+e+C8Gv4tvggmOKFWDX2YspILxifRcCPR563zJbqjdl4kIHb/
	/ZP4w5OjsvAYuruEcqDHWS4mg9quC3A383nyvUr5q6SwoGgiMgyBjS5Cdf3Hwh1AAL/SKC
	+kHk6MzHu1atgqXHOzTdtaclxIlatxiLxsb2Cy1qPXc2LGp8WLZMtBd7uBa3Dt5bJO9DMb
	EqmHQPRLMof26/R7VG5nEC6AumcIywo9yXT6fowfhXD2I12H1cGKbpcM2egoxQbuymJG0j
	PAfxxzYRRF+fupsWhGYG7YbmfFfwsqrJc02pgeJtr94kPXvrsAtsXNc9QFyO3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBI5m5fOsqa8GvlEA5EmwGOkzB7rIX+/Or7sr4YAcC0=;
	b=UGsKy55ScshsbVsf9lCtZvkLLreMQ4X0HQtrg5TeGne7VhOZdpAuQ8SLXO2xqnjuhrZ6fv
	ZZuaBL2aMOhDh2DQ==
Date: Tue, 23 Dec 2025 08:04:09 +0100
Subject: [PATCH 2/5] hexagon: Drop invalid UAPI header asm/signal.h
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-uapi-nostdinc-v1-2-d91545d794f7@linutronix.de>
References: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
In-Reply-To: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473456; l=824;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=K/unO6+pepLfO2osiSqrw9BSyrlWWQpEI/4E70KxQeQ=;
 b=3hkGqlC6iUOHLTANsMQf68quxWyCeyKm+HposaWJEO5Rz0fsn5FTMf6MMTuovcMaqtTHNPRu3
 ONBwytC248vD0LHhlf8MOZQks6gk9TbzFzZYHUDQW04mCZzGr8I+Yl3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This UAPI header contains declarations of internal kernel symbols.
Such declarations are invalid. Normally headers_check.pl would report
an error, but apparently its dependency on CC_CAN_LINK prevent its
execution on hexagon so far.

As the header does not expose any additional UAPI, just make it a
regular internal kernel header. asm-generic/signal.h will be used
for the UAPI automatically, the same as before.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/hexagon/include/{uapi => }/asm/signal.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/signal.h b/arch/hexagon/include/asm/signal.h
similarity index 100%
rename from arch/hexagon/include/uapi/asm/signal.h
rename to arch/hexagon/include/asm/signal.h

-- 
2.52.0


