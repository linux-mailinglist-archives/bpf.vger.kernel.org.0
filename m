Return-Path: <bpf+bounces-46171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60AC9E5D5A
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612BA283981
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54683229B19;
	Thu,  5 Dec 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="K6bno3Pi"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69422579D;
	Thu,  5 Dec 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420143; cv=none; b=D3cLQcllqElOvPy1YIaKAo4CCeSd808+5o3qt6qwV3H/8W5LehiOrn+8D2m64QFKkd8WRvL8WwkU/BQZRnZ6ncUpijcd4OU719nEJak3OUjn54UcaHwTjSYOJzNM9hXCAw8C+aBZLMsjoa7caRtPyPCLdR2c+ZNflxjpnrXbIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420143; c=relaxed/simple;
	bh=v54jOXPBj86EmdoK8VRH/WJTe91je7IjzNhdTGxTAGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nai668EQ8mjtKJUKHobZ3eU72HFIs3XrfZipAm2iAjXxSDHDRGIBYm4KqySA+ZFTPlMNyDUH5QLxIL4GQqkrjeobEk5PBUTQVwAkCfztwLRhwiPP7MJfk3Tq/aFVQymzPSxSwjZA+zoKJOQ6BbBbOS3NsPvHbixpzrdlqPUZUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=K6bno3Pi; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733420137;
	bh=v54jOXPBj86EmdoK8VRH/WJTe91je7IjzNhdTGxTAGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K6bno3Pid1wQl8du0lNePJ95Kvvh7/8n5drvB2nGu7OHw9DcP/cBbyuGWw1foEg5Y
	 zAU2a1oj/zgo72VtMRKRrCdb4KgzJ0Umw1lBEe2d076qaJC9xwZRrqMPO9OuBNxt/z
	 Trex6yqGmkJCtKeeefG+X9DMpIdzov2ei2fbATzM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 18:35:15 +0100
Subject: [PATCH 3/4] btf: Switch vmlinux BTF attribute to
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysfs-const-bin_attr-simple-v1-3-4a4e4ced71e3@weissschuh.net>
References: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
In-Reply-To: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733420137; l=1383;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=v54jOXPBj86EmdoK8VRH/WJTe91je7IjzNhdTGxTAGM=;
 b=z5q+mLaILrDgqDYwtsD48fkDkxpZ62jcajO3UKpxPz32mD8JI/2JI972ZU1lQwyNF3vSJQo0s
 6sYjAwPi+IUDoUGqDySD1CsWmyWtBNVzTIiDOk4iNPc9R3Rd/cj/9nF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The generic function from the sysfs core can replace the custom one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
This is a replacement for [0], as Alexei was not happy about BIN_ATTR_SIMPLE_RO()

[0] https://lore.kernel.org/lkml/20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net/
---
 kernel/bpf/sysfs_btf.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index fedb54c94cdb830a4890d33677dcc5a6e236c13f..81d6cf90584a7157929c50f62a5c6862e7a3d081 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -12,24 +12,16 @@
 extern char __start_BTF[];
 extern char __stop_BTF[];
 
-static ssize_t
-btf_vmlinux_read(struct file *file, struct kobject *kobj,
-		 struct bin_attribute *bin_attr,
-		 char *buf, loff_t off, size_t len)
-{
-	memcpy(buf, __start_BTF + off, len);
-	return len;
-}
-
 static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.attr = { .name = "vmlinux", .mode = 0444, },
-	.read = btf_vmlinux_read,
+	.read_new = sysfs_bin_attr_simple_read,
 };
 
 struct kobject *btf_kobj;
 
 static int __init btf_vmlinux_init(void)
 {
+	bin_attr_btf_vmlinux.private = __start_BTF;
 	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
 
 	if (bin_attr_btf_vmlinux.size == 0)

-- 
2.47.1


