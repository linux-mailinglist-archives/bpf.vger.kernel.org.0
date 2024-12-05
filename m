Return-Path: <bpf+bounces-46167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C909E5D46
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4565F1882FD5
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82169226EC9;
	Thu,  5 Dec 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="guoxc6ji"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1103224B0F;
	Thu,  5 Dec 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420142; cv=none; b=ozAyV6z+v97qpX0fugw+7/6mqbiTtGJRnqOM4xgrOhqlo98zo/LQyonMp8h7boXx6LXifo9oC58MveboIXZhK/26Nbl5+IeLvlEAPgWtSs5XF58jbjJfWv0U52yavtf1GMAKeSPRD2yrVhXwSQi6RfbsVV/1RiLAcEPG9pKQ+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420142; c=relaxed/simple;
	bh=cfuC4VjJZbJslwembV87HLGJheNWpA6IXa9jHRZu/TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOlaQ3xoIpu3ZfrrvDlcTILqRASfAIi4MYpJkk653GtBuMni+FJL6Mar7Shi0YMlV5enjHhIGfAR6YG6Dg4kQVIJ3qFRMcUCzpzfzkFWhuHlIEvBo9CF7UZY0+dtuE5wOV3KGCDFYJ1PuX7JAu1j4ReA/K5zz/b3seEMmCLfcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=guoxc6ji; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733420137;
	bh=cfuC4VjJZbJslwembV87HLGJheNWpA6IXa9jHRZu/TI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=guoxc6jiRIqYEGgM6BDygebSsXZ13mk0XDHwVPTvCXJki6yuOI+VMVHt/REiIuCp3
	 5PH3S7I1rR5ECLEBN+pPHNQKosnLzkuyeTaP0HRnoKS91a4VeTxCdX7qXj6M8oBX9J
	 pPlkZUr/1HRJkQYaW1Zp5F16MRkEAaHCkW1k8zbU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 18:35:16 +0100
Subject: [PATCH 4/4] btf: Switch module BTF attribute to
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysfs-const-bin_attr-simple-v1-4-4a4e4ced71e3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733420137; l=1356;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cfuC4VjJZbJslwembV87HLGJheNWpA6IXa9jHRZu/TI=;
 b=e241/DoQXymqExeN+SMwvZ808XE79ecCrN8XFKqhJnW3U8HuphVENS4R6ai//luSj/YPr30lo
 NqTPg+Nmf9/Dvw7MuaG3SlMfMc+h0AAu8h+lEG2k3oNOjl5IwrAmm5N
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The generic function from the sysfs core can replace the custom one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/bpf/btf.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9331d0acb17a88a4ebf641509c050..69caa86ae6085dce17e95107c4497d2d8cf81544 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7870,17 +7870,6 @@ struct btf_module {
 static LIST_HEAD(btf_modules);
 static DEFINE_MUTEX(btf_module_mutex);
 
-static ssize_t
-btf_module_read(struct file *file, struct kobject *kobj,
-		struct bin_attribute *bin_attr,
-		char *buf, loff_t off, size_t len)
-{
-	const struct btf *btf = bin_attr->private;
-
-	memcpy(buf, btf->data + off, len);
-	return len;
-}
-
 static void purge_cand_cache(struct btf *btf);
 
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
@@ -7941,8 +7930,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			attr->attr.name = btf->name;
 			attr->attr.mode = 0444;
 			attr->size = btf->data_size;
-			attr->private = btf;
-			attr->read = btf_module_read;
+			attr->private = btf->data;
+			attr->read_new = sysfs_bin_attr_simple_read;
 
 			err = sysfs_create_bin_file(btf_kobj, attr);
 			if (err) {

-- 
2.47.1


