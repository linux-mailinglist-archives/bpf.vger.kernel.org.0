Return-Path: <bpf+bounces-45501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94099D6950
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5F7281EDA
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E42746B;
	Sat, 23 Nov 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uFkttppJ"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B5D530;
	Sat, 23 Nov 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368827; cv=none; b=ZomkbxI0nUsEycqj3W81h8b5IZUugjaQO8RB9h55YJznVQG6GyOtZpW0nReaYUv6tSiKp65Uh0HzKZlYR1V7KcvWnjJn/UY8nhF5M2ugEEUqSALpynNvSN7fgWJemsehSzO5xD7njG55Z+dM5pzQtV7ZUEOA3ZzFCfPJfWcjZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368827; c=relaxed/simple;
	bh=/06I1MoPIpkLkreP+KQguVn1tqSQj5oeCpTznnOHjbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdTKUUWkB3DfTad2ZuylTrNedh+qQYt2MQTAf0+FCoamcleOsXa8Xe9AERiPVJDAzbpsAVAwtjdzl75t253iwLqUYiW+2RUqQ7dghJGcbxW0USOAYbCts1KzpSDw3+otGe+ilvgic1iFGIRu1O0M5nJtpgJfPpKLfblLbVIzkc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uFkttppJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732368822;
	bh=/06I1MoPIpkLkreP+KQguVn1tqSQj5oeCpTznnOHjbM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uFkttppJJwmvrOYW9H2Ach4pr6cGoGtG3/phWY/8ed+Yb1cUS3OIHYRhn4HDXS7FP
	 RJRNEj8hfr7FrlpdjkjHozQlaVTPTq1c/YXKwZ6uMVsGigBkgKvJdpECpepgYDmGx6
	 TWtPI/QgDafJLjzNqkDWdAuNu4oAq3gguhqgAj7I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 23 Nov 2024 14:33:39 +0100
Subject: [PATCH 3/3] kbuild: propagate CONFIG_WERROR to resolve_btfids
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241123-resolve_btfids-v1-3-927700b641d1@weissschuh.net>
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
In-Reply-To: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732368820; l=888;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/06I1MoPIpkLkreP+KQguVn1tqSQj5oeCpTznnOHjbM=;
 b=/jYbuVCPM0A6oIljCDR4iF1HCMJnWdK2l0duNbTV74jCkkW0qfY3GRz3j7bO9rBomPgYzsrxf
 DYnks9cVXG7D04vUD+AbSYLD2CYvd1lXm2TEyKfP/BfukoAUV4V97Lc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
Allow the CI bots to prevent the introduction of new warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/link-vmlinux.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a9b3f34a78d2cd4514e73a728f1a784eee891768..61f1f670291351a276221153146d66001eca556c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -274,7 +274,11 @@ vmlinux_link vmlinux
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
2.47.0


