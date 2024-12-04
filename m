Return-Path: <bpf+bounces-46104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BF9E44DE
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C271669D9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D71206F38;
	Wed,  4 Dec 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tOeidKd2"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8DA1F03C5;
	Wed,  4 Dec 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341081; cv=none; b=PKD3UQ6L74U9PYNyX6CFNAoqfLz+Lj20Bk1Hav+vgFKqB+GjPVO58Xr5pC8rBwVB4hcCmoh2pDYwWpYaGGigkV6gXjqVcC0pXVOtJ6P0nxSOZGIC7iRSDIG3BmqS6D2JzgQmD/7nOmU1ZfLcvsuMMhiF5PsOugxKRbTLDcWetm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341081; c=relaxed/simple;
	bh=jFeJZEPDFXb0Fdzj3M7fCgu/RQZ/R/c/YJGWz+5Gtj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r4UkO1nrq7sBR+CBgMMbhvPVC8tnZJ0oMQu/tsUcsb8wFUVAzWIzlZWJbQ7rwhELmyykLZSR5qAK5YXFiu2SmMh80etNwCBrerfQ4dwenttRJKWieV4W/p+ahLmMO+1rG0gGEc5GagCFK98MNwdfw0iFbpBk7BsOX7mM1srpsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tOeidKd2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733341068;
	bh=jFeJZEPDFXb0Fdzj3M7fCgu/RQZ/R/c/YJGWz+5Gtj4=;
	h=From:Subject:Date:To:Cc:From;
	b=tOeidKd2tLfXx33+0bTqMS7SQWS6GYpFvqT8lK0rCyOWHKPV26LLA2CPS9VcqPOBq
	 O59fj/E0rUQRp1FYRRHGT6b+7HEwGm0dfq8NgZqpAn1wfeEHgTSLYMQMAR6bxJLB2b
	 R1G2vr32DuX8Xb8lScnGxQ1JzS5eW/w0I/kuPeSk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH bpf-next v3 0/2] kbuild: propagate CONFIG_WERROR to
 resolve_btfids
Date: Wed, 04 Dec 2024 20:37:43 +0100
Message-Id: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIevUGcC/3XNQQrCMBQE0KuUvzaSpLVtXHkPETHJrwlIWvJrr
 JTe3VA3QnE5DPNmBsLokeBYzBAxefJ9yKHcFWDcLdyReZszSC4rIWTJIlL/SHjVY+ctMdTqYJS
 upOUc8miI2PlpBc+gh44FnEa45MZ5Gvv4Xp+SWPt/aBKMMyWbhnNdV8KK0ws9ERn3dPuAXy/JX
 6PeGDIbsm1N2RjdKsSNsSzLB05ySvv/AAAA
X-Change-ID: 20241123-resolve_btfids-eb95c9b42d00
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733341067; l=1325;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jFeJZEPDFXb0Fdzj3M7fCgu/RQZ/R/c/YJGWz+5Gtj4=;
 b=opTi36LO29JR5ssDWGaMUzHEI5p6j8qrGISkjMhYd1AWZebEmlxOs+N+lFLFMsZB7rD0V7zJJ
 PoPZqO005L6A0nZmPHeqH/FQxoMnQlg93CL9d025mBGFSogHCz42WmI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
Allow the CI bots to prevent the introduction of new warnings.

This series currently depends on
"[PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs" [0]

[0] https://lore.kernel.org/lkml/20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Retarget to bpf-next tree
- Rename --fatal-warnings to --fatal_warnings for consistency
- Link to v2: https://lore.kernel.org/r/20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net

Changes in v2:
- Avoid uninitialized read of fatal_warnings
- Use OPT_BOOLEAN over OPT_INCR
- Drop dependency patch, which went in via the kbuild tree
- Link to v1: https://lore.kernel.org/r/20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net

---
Thomas Weißschuh (2):
      tools/resolve_btfids: Add --fatal_warnings option
      kbuild: propagate CONFIG_WERROR to resolve_btfids

 scripts/link-vmlinux.sh         |  6 +++++-
 tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)
---
base-commit: e2cf913314b9543f4479788443c7e9009c6c56d8
change-id: 20241123-resolve_btfids-eb95c9b42d00

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


