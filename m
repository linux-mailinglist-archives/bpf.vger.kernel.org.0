Return-Path: <bpf+bounces-47680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C127E9FD980
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 09:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576323A2A32
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743A78F5E;
	Sat, 28 Dec 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WbIl0pma"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6F35958;
	Sat, 28 Dec 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735375431; cv=none; b=RiyMWjdGeTqGhsRGYaKU1nxTMbajrrrzVwqASnUByD/76y1zvtthOrnG0v78tIJzi2m59Xeq/mRdYJAaINnR66LCrckL+ljCDe2ECyhGKlnR/JVXfZgf1heqLWXPr5nHQDrjGuIkx/ZKyG6gJ54n73sjP04N3Rss0wJJFt7LoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735375431; c=relaxed/simple;
	bh=sZiTPlQI0gHuQF1THsJA4vQwmsj1H9KFzGpKq1nF9WY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CR8B/MToIRHGsoawRjxgp/MsCJyHUf+eyO8zSbqH7FwsVUWFZY5roMkmqGjwjgC3qT6gSUkcPFnhJtk+ZG8/N+rJRXAxl1JXWAexUs38vsVoAjC+naIxcLe7c0MFNQh8g8CivHtjDWzV84Q7AT87gp5OLy+RfH09hINUefOTqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WbIl0pma; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735375425;
	bh=sZiTPlQI0gHuQF1THsJA4vQwmsj1H9KFzGpKq1nF9WY=;
	h=From:Subject:Date:To:Cc:From;
	b=WbIl0pmaTig4WqXVNlApAm/gyb1WPNf8/CGCDRFQ2XLpxpT+PxPxg35UzP1JJZETh
	 Q3KoWLjcxjBFclgDc1ljqUCgtj4BCRz5KJBBOSXNf7cg+q81h/i93BCRmMjQtSEtaN
	 DbKS7/3vht381rnDmgZWnDgHmB2Ws47fM4EcHsIg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Date: Sat, 28 Dec 2024 09:43:40 +0100
Message-Id: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADy6b2cC/33NQQ6CMBCF4auQrh3TjjUkrryHIQbawU6ihXQqS
 gh3t+Le5f8W31uUUGISdaoWlWhi4SGWwF2lXGjjjYB9aYUarTGIILP0Am6IkqHjeG1zTiD8GO8
 EtdPed9i73qAqwpio5/emX5rSgSUPad7OJvNdfy7q4193MqDBtpasI18bOpxfxCLiwjPsI2XVr
 Ov6AWq7vmfLAAAA
X-Change-ID: 20241122-sysfs-const-bin_attr-simple-7c0ddb2fcf12
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735375424; l=1255;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sZiTPlQI0gHuQF1THsJA4vQwmsj1H9KFzGpKq1nF9WY=;
 b=bVK06F6W/XTwjZZrk9th4YWgZvI6fDp2ksynQwNyKsR4oUOGuKOfH8ZIpuVDiMoiNN90vtbQT
 fuheImUmzLGCCXSuRqocGwLuU0HITJO2We5q3ZL4M71LsJ3R3lMP4k4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Most users use this function through the BIN_ATTR_SIMPLE* macros,
they can handle the switch transparently.

This series is meant to be merged through the driver core tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase on torvalds/master
- Drop wmi-bmof patch
- Pick up Acks from Andrii
- Link to v1: https://lore.kernel.org/r/20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net

---
Thomas Weißschuh (3):
      sysfs: constify bin_attribute argument of sysfs_bin_attr_simple_read()
      btf: Switch vmlinux BTF attribute to sysfs_bin_attr_simple_read()
      btf: Switch module BTF attribute to sysfs_bin_attr_simple_read()

 arch/powerpc/platforms/powernv/opal.c |  2 +-
 fs/sysfs/file.c                       |  2 +-
 include/linux/sysfs.h                 |  4 ++--
 kernel/bpf/btf.c                      | 15 ++-------------
 kernel/bpf/sysfs_btf.c                | 12 ++----------
 kernel/module/sysfs.c                 |  2 +-
 6 files changed, 9 insertions(+), 28 deletions(-)
---
base-commit: d6ef8b40d075c425f548002d2f35ae3f06e9cf96
change-id: 20241122-sysfs-const-bin_attr-simple-7c0ddb2fcf12

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


