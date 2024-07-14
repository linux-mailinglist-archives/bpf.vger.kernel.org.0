Return-Path: <bpf+bounces-34770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B9093094D
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7911F216FA
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF03D55D;
	Sun, 14 Jul 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxZSXosr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CCB3B79F;
	Sun, 14 Jul 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720946296; cv=none; b=tgudogf2FxS7sfbqKT+1Gx74OsQ7iDUg/3sK1o7WIAKJ0xgIewM6lVlRLij+yxFpUw7HSy1HKAkxK9/684sme4GyrQu6XGsWnaRLMX+9/J2hQw+qyL9JxaKZXaJ3byynBV6ZWtPeuruOEX98YIu82usSaqDYmxPgbD88EwxzKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720946296; c=relaxed/simple;
	bh=ugC4vwFu7JaQt1R2nRsfoFX5qwcKVpwZZbz8n+GBd9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXup6IqAnwD2pSQX/RaLKIij1nGeRsxlRQekVDNdDlchmiwhzcR0JJJHzSrH+6Z8iIPwBuRvlZU8Yo6GhodNmxMByDIC+iJQu3uTaj6yGjYFS8JCFrKwp7/8eCaWS3Uc3cn5IEAvWQjz0N3Uj2McJUIJ9xBzyCXo2xjJSp4BAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxZSXosr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87465C4AF0E;
	Sun, 14 Jul 2024 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720946296;
	bh=ugC4vwFu7JaQt1R2nRsfoFX5qwcKVpwZZbz8n+GBd9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxZSXosrHHlpL16bUcUgZDTuAeILEVlZOjAtoC92mNbUrTnmDNGt3BeNJrNxHFdaI
	 L/nFZRGNhonsOkXirfSOo4oXklswe+YGKJjmgVWZZ0zuDF2mLTVHpfgVYHQ/74sfGL
	 jJZhc3X+XBN3Tz0AcXoNgUMkC3ozduknjf1oI0KyNcmxr6lfo8m7GYja0ncoKSNDSW
	 MFyYcjZV8L+UuDMIWPg+xusUjmSODbZeVOqhjz2KcpnqcgtNo4+lOD5PZ2M2kT2zf1
	 //pETtZ8Y7VKpE0fOpThz5A4M0h8TExmzBmmGYPRq/ASi5PdiznKJrFJHXMsHAL3vh
	 4uTMelhlFuY1w==
From: Naveen N Rao <naveen@kernel.org>
To: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: Update powerpc BPF JIT maintainers
Date: Sun, 14 Jul 2024 14:04:24 +0530
Message-ID: <24fea21d9d4458973aadd6a02bb1bf558b8bd0b2.1720944897.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
References: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hari Bathini has been updating and maintaining the powerpc BPF JIT since
a while now. Christophe Leroy has been doing the same for 32-bit
powerpc. Add them as maintainers for the powerpc BPF JIT.

I am no longer actively looking into the powerpc BPF JIT. Change my role
to that of a reviewer so that I can help with the odd query.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05f14b67cd74..c7a931ee7a2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3878,8 +3878,10 @@ S:	Odd Fixes
 F:	drivers/net/ethernet/netronome/nfp/bpf/
 
 BPF JIT for POWERPC (32-BIT AND 64-BIT)
-M:	Naveen N Rao <naveen@kernel.org>
 M:	Michael Ellerman <mpe@ellerman.id.au>
+M:	Hari Bathini <hbathini@linux.ibm.com>
+M:	Christophe Leroy <christophe.leroy@csgroup.eu>
+R:	Naveen N Rao <naveen@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/powerpc/net/
-- 
2.45.2


