Return-Path: <bpf+bounces-46103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CFA9E44DB
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7371A282B2D
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76400206F2E;
	Wed,  4 Dec 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="T4FPTuzd"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D31F03C8;
	Wed,  4 Dec 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341081; cv=none; b=PW6ZPej+5LI5X+Qrdmu/WXVmtFRcck2Os+LtTmWDtO7n6HpYxjUjmWux1yEVJafC6tGVBWfme4jUmAwBSl9vRFMFUkbQpchFwpksc0vwhXGuBU1apxDad5Eaba4waFDrvmrIoB/8b+BBjihdo4WLvgarlgPgmjYB8Ofm2zwXJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341081; c=relaxed/simple;
	bh=j4sqUbGoK+7beKPluyYhWDONOZvAHpifoflwWglXinA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9dl35b8LKO13/Youfay3QluC9Bb/0bxEtgUwbECjq2xT5b8U/g+DqKeYucj5dUA6myzmAjXJllJifPYUkrNFTYDH5qF6NYcjtSjXNJgI9Q8EOBo8uTu9dW9A+Qda4bu4L5YYWcm5CrdlSNf4v6iRVDTW0a1pHcbCuyJV68jp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=T4FPTuzd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733341069;
	bh=j4sqUbGoK+7beKPluyYhWDONOZvAHpifoflwWglXinA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T4FPTuzd3zCvKuXeeoHzJ8IF18uvFPxonjM3k0d5eedOGVBjIj9qILRxftSdzFpL/
	 OWhCw6bSjlCgDqbyxsRbz7zQoQYrD3rDHQbDu8fmf23IScGtxjfnfHikOGhUuTPueU
	 Rs8byCQVRhBJZDkWp68s0vg7tv0lZft0aWOW4UZ8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Dec 2024 20:37:45 +0100
Subject: [PATCH bpf-next v3 2/2] kbuild: propagate CONFIG_WERROR to
 resolve_btfids
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-resolve_btfids-v3-2-e6a279a74cfd@weissschuh.net>
References: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net>
In-Reply-To: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733341067; l=928;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=j4sqUbGoK+7beKPluyYhWDONOZvAHpifoflwWglXinA=;
 b=sfU1PGfUVeGccb2dwsXPUlkNGKdHhTSeyPF98pmXqLJ6JAV7Ki2AIC7IwwSjWB3kA31Ey8rQR
 yA2vGNaOtwHCMVFF0OhnckjjII4euJxi14jFM0vV5FjZuuw82TWu5mk
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
index a3c634b2f348f9c976cff9693caf290db7f31666..991d08c0042c68fc452210a8423d67162891c585 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -279,7 +279,11 @@ vmlinux_link vmlinux
 # fill in BTF IDs
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	info BTFIDS vmlinux
-	${RESOLVE_BTFIDS} vmlinux
+	RESOLVE_BTFIDS_ARGS=""
+	if is_enabled CONFIG_WERROR; then
+		RESOLVE_BTFIDS_ARGS=" --fatal_warnings "
+	fi
+	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} vmlinux
 fi
 
 mksysmap vmlinux System.map

-- 
2.47.1


