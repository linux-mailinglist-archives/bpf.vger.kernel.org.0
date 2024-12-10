Return-Path: <bpf+bounces-46580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBE9EBF3A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 00:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4691B165283
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 23:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BDA21126D;
	Tue, 10 Dec 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tAIKk3I+"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492186324;
	Tue, 10 Dec 2024 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873046; cv=none; b=ZDAbGJeqRLXhiZt5gt+pqHXamjwygjdPQcBgL6YwmHWdm2sNKtmVvOS1+oWbcniAyKP7kXGppZzju00Fvk2pjqomX4on+Oc7ESGD1SLx4HpKqESJo9rFevZdNJuOIdNWIezs/Nefc93bNbq6xeZRJp4iCxHAcy8V11yEhujBRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873046; c=relaxed/simple;
	bh=uRN07EVZGn1ySGZv5iCrZP2k3eDPDlir8l8cG+/nBNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=djVFawKNe3h8O09yj+dsQqCxJiZ3urOFUviHHFBHjjARJH1MtmhJO1nGwnrO/r62lAcQxPZ5MPCWkCZ3m7OUthgaAXSLx3uwdkNIAZ63JJltxMiQen45cxtKyxMoNzZS33UtJdNMj506X9MvVFYlKsZMM5k6dNxl3WBV5exPUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tAIKk3I+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733873039;
	bh=uRN07EVZGn1ySGZv5iCrZP2k3eDPDlir8l8cG+/nBNg=;
	h=From:Date:Subject:To:Cc:From;
	b=tAIKk3I+YW3bATNqVJ0HOahk0dHpNyEmUl/XAnNV2d1K9+Rnfqwbv9EkHB/9FS8Kf
	 iljXflny+OcKhx5xwZNC/GQAwsgo3zE+Royibl8Kg/hkXsAdoORvu3RkS825Fss4uj
	 Jrze6upuoWOVNRo4WrkCfZYNcEJrIchHlmdGD888=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 00:23:50 +0100
Subject: [PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIXNWGcC/x3MTQqAIBBA4avErBNSgn6uEi0cnWogVMaKILp70
 vJbvPdAJmHKMFYPCF2cOYYCXVfgNhtWUuyLwTSm1dq0Ktkt7qSEkkR/OsYCg303WNejtwilTEI
 L3/91AkyLCnQfML/vB8Sjn3FvAAAA
X-Change-ID: 20241124-pahole-reproducible-2b879ac8bdab
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Kui-Feng Lee <kuifeng@fb.com>, Alan Maguire <alan.maguire@oracle.com>, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>
Cc: bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733873038; l=1632;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uRN07EVZGn1ySGZv5iCrZP2k3eDPDlir8l8cG+/nBNg=;
 b=/K5by3KiAguNYUyBxdbON2ym8wXtDZA5r1rYnu1i+YNRs8mopxH+WoCM6tKFjMPPByj6lVsUw
 jkPJPbm5x6PBNY00W47hd982/eRvPPKNVhI11w3Y82iNHI0M3Mpptyl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Pahole v1.27 added a new BTF generation feature to support
reproducibility in the face of multithreading.
Enable it if supported and reproducible builds are requested.

As unknown --btf_features are ignored, avoid the test for the pahole
version to keep the line readable.

Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts/pahole-flags.sh")
Link: https://lore.kernel.org/lkml/4154d202-5c72-493e-bf3f-bce882a296c6@gentoo.org/
Link: https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.btf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index c3cbeb13de503555adcf00029a0b328e74381f13..da23265bc8b3cf43c0a1c89fbc4f53815a290e13 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -22,6 +22,7 @@ else
 
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
+pahole-flags-$(if $(KBUILD_BUILD_TIMESTAMP),y) += --btf_features=reproducible_build
 
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base

---
base-commit: 7cb1b466315004af98f6ba6c2546bb713ca3c237
change-id: 20241124-pahole-reproducible-2b879ac8bdab

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


