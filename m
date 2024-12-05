Return-Path: <bpf+bounces-46168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004B9E5D4A
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8739E282DB6
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF143226EE3;
	Thu,  5 Dec 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="osaoXBUG"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4F225768;
	Thu,  5 Dec 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420142; cv=none; b=ci2GCWyaYkgimgLXLfrR+Ysn7Da/L8j3RfUNyzjNHk4cqRZliGmYl+C6ZpAD8bI1wplHUFhJUt3/bvyMjr3rBpYHazPFPeU+LCEm8hBfHvyIfTe/C36DVkSy2YeNwQXmU1cyVhOoGsIKOad60505eTDbSkQN3TIvGDwf0JjIuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420142; c=relaxed/simple;
	bh=68WNMR27/Jh6Vy7PvAle7AaTWkBct2qgXVk12kHAaEY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uvRMqxu1HUONNWwKW4NyzS7TRNa+H0XEX5Npy4RYuLunN3PrL/DeRdd3UOrw3SXeen9rH4TFczpfiAW/9kbuvi2P97uC/6mfzobj9Gc03qtzp0729UUpG4sgr6p8WO8aSig8bTGIp580nF7VFg6MvNNORkaYT6+Rg7jzLPZauME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=osaoXBUG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733420137;
	bh=68WNMR27/Jh6Vy7PvAle7AaTWkBct2qgXVk12kHAaEY=;
	h=From:Subject:Date:To:Cc:From;
	b=osaoXBUGfRb46luXfjCGTPlnbK7q0cEYSDeeHPKe6F5/8fT1bXolzVbZEr743sp7n
	 OYCOlxC/xSo+G3OjW0YG7pLTN295Pga9v2NcIMjRFaP+ZC6R3UrV8BOWJePkDk1HGc
	 yOQXl/blyJageLhTjzhHwYNhUOVSru+iMXlM/kHE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Date: Thu, 05 Dec 2024 18:35:12 +0100
Message-Id: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFDkUWcC/x3MwQpAQBAA0F/RnE3ZSSm/IondWaZY2tlE8u82x
 3d5DyhHYYW2eCDyKSp7yDBlAXYZw8woLhuootoYItRbvaLdgyacJAxjShFVtmNlbGzl3ETeekO
 QhyOyl+vfu/59P/HJDYRtAAAA
X-Change-ID: 20241122-sysfs-const-bin_attr-simple-7c0ddb2fcf12
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733420137; l=1170;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=68WNMR27/Jh6Vy7PvAle7AaTWkBct2qgXVk12kHAaEY=;
 b=T+PbqYnqnoXWLbF5FULrGKTEWzZ8sXpbVXoqId9h5bVMynN1gxzdjACjy9czZW5+/hfIaiOMY
 927yDeHmNmiBbYl7QYj+NHuMWTZRXQl9ozjUUHoyQqHpqA28sdx295H
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Most users use this function through the BIN_ATTR_SIMPLE* macros,
they can handle the switch transparently.

This series is meant to be merged through the driver core tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      sysfs: constify bin_attribute argument of sysfs_bin_attr_simple_read()
      platform/x86: wmi-bmof: Switch to sysfs_bin_attr_simple_read()
      btf: Switch vmlinux BTF attribute to sysfs_bin_attr_simple_read()
      btf: Switch module BTF attribute to sysfs_bin_attr_simple_read()

 arch/powerpc/platforms/powernv/opal.c |  2 +-
 drivers/platform/x86/wmi-bmof.c       | 12 ++----------
 fs/sysfs/file.c                       |  2 +-
 include/linux/sysfs.h                 |  4 ++--
 kernel/bpf/btf.c                      | 15 ++-------------
 kernel/bpf/sysfs_btf.c                | 12 ++----------
 kernel/module/sysfs.c                 |  2 +-
 7 files changed, 11 insertions(+), 38 deletions(-)
---
base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
change-id: 20241122-sysfs-const-bin_attr-simple-7c0ddb2fcf12

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


