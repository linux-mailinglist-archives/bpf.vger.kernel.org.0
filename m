Return-Path: <bpf+bounces-43813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8219B9FEB
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 13:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E93A1C20F33
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EAA189909;
	Sat,  2 Nov 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b="TMMtt3p/"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E556AB8;
	Sat,  2 Nov 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730549636; cv=none; b=HAWITIe9hyyz5C+0tSBLxxY2FXUIf56eaVe8Td+DLPrJBcPasEZkcPuhJ+C5ZOUpHZ0AUozE3Ea6Qfy1VlN5ZRPVRcJGygf88N9zhxekk2qrUrCQ7AfmkLk49s5dDbWjkF99HVG770Tgz2352fBSVWLkIUdONaPvh1WhchCNPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730549636; c=relaxed/simple;
	bh=PQXUO/NpyyY6AE1OCBuJxE2fWo8+FydBP+Vw5SssCN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLvtPn6auIOPOj9UrzhG1qxcayz7Y5go9XuWlksdZCRFM0h2AWE1C8k/kB9kEeUCoGz6pa6547I488/2o/WNLHKnr1EovVEJLt0MP8Cu1MKUaxKa/zDJ6Li/GRzKYHaGk1tVeLgS9Y1WaolM83AxkZS+hXCINS5Zoo8OmYMzkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev; spf=pass smtp.mailfrom=ptr1337.dev; dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b=TMMtt3p/; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ptr1337.dev
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AF772805A2;
	Sat,  2 Nov 2024 13:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ptr1337.dev; s=dkim;
	t=1730549169; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=MOnX4Fhcv18gWqefNAbz/hAajKVv81QC+1X9br1/mV8=;
	b=TMMtt3p/z3+Eu5Um4KkXN4uM4jKuUMnipkVpe21xkvk03fa0bZs0w/ExyXVqnM3v+hv+4C
	mNarLtG3Z7V3ru7dpVgMLC/IPKIkJZIaj9wJg9I/XQnHpHx8QXeHwCCLo6VIQsikiOSe2I
	HPzeNyIrf4qDeeurcaJpUdkcku6rA1xUezrVTtFLoCzJVBRZOJ6+nI4HW8g7TDvLQt80MK
	un+kElAKlcXt5z3DX/dr5ZX2YfkUhxKmd8g0PqYQqLmk06lp3MKBotxHUXyMhAlAAZDMmb
	XKgbFcnPkN5Cnq8hJnTjGa1rR9KQjIlSaAytpGaPOrvo4AR3F+IVhl8HOlpGNw==
From: Peter Jung <admin@ptr1337.dev>
To: 
Cc: jose.fernandez@linux.dev,
	Peter Jung <admin@ptr1337.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christian Heusel <christian@heusel.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] kbuild: add resolve_btfids to pacman PKGBUILD
Date: Sat,  2 Nov 2024 13:05:26 +0100
Message-ID: <20241102120533.1592277-1-admin@ptr1337.dev>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

If the config is using DEBUG_INFO_BTF, it is required to,
package resolve_btfids with.
Compiling dkms modules will fail otherwise.

Add a check, if resolve_btfids is present and then package it, if required.

Signed-off-by: Peter Jung <admin@ptr1337.dev>
---
 scripts/package/PKGBUILD | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
index f83493838cf9..4010899652b8 100644
--- a/scripts/package/PKGBUILD
+++ b/scripts/package/PKGBUILD
@@ -91,6 +91,11 @@ _package-headers() {
 		"${srctree}/scripts/package/install-extmod-build" "${builddir}"
 	fi
 
+	# required when DEBUG_INFO_BTF_MODULES is enabled
+	if [ -f tools/bpf/resolve_btfids/resolve_btfids ]; then
+		install -Dt "$builddir/tools/bpf/resolve_btfids" tools/bpf/resolve_btfids/resolve_btfids
+	fi
+
 	echo "Installing System.map and config..."
 	mkdir -p "${builddir}"
 	cp System.map "${builddir}/System.map"
-- 
2.47.0


