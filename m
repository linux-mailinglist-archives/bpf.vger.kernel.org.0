Return-Path: <bpf+bounces-45655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E49D9EBC
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92BE282F99
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B021DFD9B;
	Tue, 26 Nov 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gGOtBors"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F317C219;
	Tue, 26 Nov 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655849; cv=none; b=hWrHObsY0n2M7ngCT/8rKGH+X+GKJVybWqbL8Odwl0aNd4PVcnoIOiZFxAZkpdT9oN6/MITY/oyS6PMJp9/IwtJVFGzy0odVCY87M4i5MG1SNv82/mJ0WA8vmfUKrnCFbtTgJcRjjahs0MG7UPwt1vAM5hiu9aoS/231g/Ek3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655849; c=relaxed/simple;
	bh=4w3ZoWOoq2qPC4V6ahdTMR4F6CVcz2IXhDyepis41Lk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fp3I8dQjxxfLCQFNrk/K7eYX8cFTvWiKZ/yGLMoI1B1IpExMdX/IZnLmMtsUvY0+uEL1+DmXrJVX3VIXWXAH0IOq7PcMbggT+i+dIz3PIKzKtYBucGXpjLXeTafptyuTigtGg3IlGpNg/MTw/fnVXy0MstmxWUlm4ycBc0O4MH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gGOtBors; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732655836;
	bh=4w3ZoWOoq2qPC4V6ahdTMR4F6CVcz2IXhDyepis41Lk=;
	h=From:Subject:Date:To:Cc:From;
	b=gGOtBorszec7ocuZGQbq2DzEN4204yFqW8nweFgyuupJSJ/nH6ZGJIh7xOxoZEESZ
	 c2+qWR/1/s42+uzCsJmhVHeE7WIkANKFeNPjF3U5qmOrr4CIJY7O/XfxuZlslr28yh
	 K9NDXDO8j03KClamS0aBMRjP2JaitWr6E6tpmXok=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] kbuild: propagate CONFIG_WERROR to resolve_btfids
Date: Tue, 26 Nov 2024 22:17:08 +0100
Message-Id: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANQ6RmcC/3XMQQrCMBCF4auUWRvJxGqJK+8hRUwyNQPSSiZGp
 fTuxu5d/g/eN4NQYhI4NjMkKiw8jTXMpgEfr+ONFIfaYLRpEc1OJZLpXuji8sBBFDm799a1Jmg
 N9fRINPB7Bc997ciSp/RZ/YK/9S9VUGllTddp7Q4tBjy9iEXEx2fcjpShX5blC6Eb8SSxAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732655835; l=1117;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4w3ZoWOoq2qPC4V6ahdTMR4F6CVcz2IXhDyepis41Lk=;
 b=AYAzg2BryL/icXbRtWXY0on66j8yNYTvtpYyY01VRZ/znNi+mxO1GZFgHVBWOhmdX9wm3IJdo
 99TECfL2ZGZC0DM+fg8XaMlGn420X4L7gfSdY0HIcGH+8T4LVW5o+zo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
Allow the CI bots to prevent the introduction of new warnings.

This series currently depends on
"[PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs" [0]

[0] https://lore.kernel.org/lkml/20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Avoid uninitialized read of fatal_warnings
- Use OPT_BOOLEAN over OPT_INCR
- Drop dependency patch, which went in via the kbuild tree
- Link to v1: https://lore.kernel.org/r/20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net

---
Thomas Weißschuh (2):
      tools/resolve_btfids: Add --fatal-warnings option
      kbuild: propagate CONFIG_WERROR to resolve_btfids

 scripts/link-vmlinux.sh         |  6 +++++-
 tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)
---
base-commit: 1518b7a61299cf3737728d4fbf7e29cf2db497c7
change-id: 20241123-resolve_btfids-eb95c9b42d00

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


