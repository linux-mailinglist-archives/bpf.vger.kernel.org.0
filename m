Return-Path: <bpf+bounces-45653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7065F9D9EB8
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3FBB23B75
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD81DF96B;
	Tue, 26 Nov 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QHZIu4z6"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99511DE2B3;
	Tue, 26 Nov 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655848; cv=none; b=GbGdjRMpYLGqDOHQyCUenIUsZ8M0OUV4//TZMUg9E4eFLdTRsf9zP1J9K0QQBG+RcIoLCwr6alzzycsRKJceKfuciu9XSIBUoPKyRBdC8YBlHVWKv7EFFjnMoYHJY1C0s/bI1gNNkZmMY4PU6TZuYtG24qImRbuR+E/wamzm4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655848; c=relaxed/simple;
	bh=qUel6NrnvGwtQ1zz0ZBdXrr8Q3TIOXkey8rp6qUc4OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyLLVNSCR4EM9d3HtqE2GBxHWJdDD+8/w8Wm/wLNac4pRDknFO9rXLO+R4plhcXBO5iNuhWvXiFGIvWyLGh9a7JS4PPyan12Skmql9npa6tVtA08ptUD/PdAMyKPElj2x32Y4Ip/t1skiHnwAT9/NCzj5JOICIvdYKFp3U30pDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QHZIu4z6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732655836;
	bh=qUel6NrnvGwtQ1zz0ZBdXrr8Q3TIOXkey8rp6qUc4OQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QHZIu4z619/ko/QCySe/Cx8g6kNrefkJOlxIQ2tYOF5PMW4sMOmMppLOxVcLgTX0b
	 kQO8cSS6zprdxGuXDcIT/L/FGEDDZ7MmI8zcUkwW0fu4fasPL7hbLqLy3y/aV21gWy
	 Pv2G3SodHMH1c6BEWWN6Ok3kLk8Jf1xY6q0ZK6A0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 26 Nov 2024 22:17:10 +0100
Subject: [PATCH v2 2/2] kbuild: propagate CONFIG_WERROR to resolve_btfids
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241126-resolve_btfids-v2-2-288c37cb89ee@weissschuh.net>
References: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
In-Reply-To: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732655835; l=928;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qUel6NrnvGwtQ1zz0ZBdXrr8Q3TIOXkey8rp6qUc4OQ=;
 b=iZdeC9osjgnTQJeB05GcRBFuABstvQYxT1en54Otzg5IdShYnTxMrytV6i8py/pEsc7i7Yv3E
 gNCSMRTpGLzBTAfGjeW3ol7NpqQ+VnIstIBGtrf3ToH/rqFthLpV+7F
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
Allow the CI bots to prevent the introduction of new warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 scripts/link-vmlinux.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a3c634b2f348f9c976cff9693caf290db7f31666..7288fe501b57e29003d922441c8d5e2f48dee6ad 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -279,7 +279,11 @@ vmlinux_link vmlinux
 # fill in BTF IDs
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	info BTFIDS vmlinux
-	${RESOLVE_BTFIDS} vmlinux
+	RESOLVE_BTFIDS_ARGS=""
+	if is_enabled CONFIG_WERROR; then
+		RESOLVE_BTFIDS_ARGS=" --fatal-warnings "
+	fi
+	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} vmlinux
 fi
 
 mksysmap vmlinux System.map

-- 
2.47.1


