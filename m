Return-Path: <bpf+bounces-45464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78259D5F5D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F41F1F21C6C
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26A1DE8AE;
	Fri, 22 Nov 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Yi4BsKYl"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03551D63FD;
	Fri, 22 Nov 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280226; cv=none; b=EcZVa21yp/52rK/U0rKeDq6ZgsvrDVAcQ99Z/6qHts5lTRh3GKgKCyjNEdcbwg69Nb700yZQyBq3qlpfUgJkRPszLL3nsxs4KjJERkFiMqvALrrYBHvX5qZ2w+Uf4Xec/7ACSvPltepkehLVWYHbu3gn6Zr6t57jBgrI31CzV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280226; c=relaxed/simple;
	bh=WOwxTUzv7fGVDTwEQ8PsFJI8EJnOd1qG8l4Al4/5Qto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uBKUvd5njh8vbPqPoULB97VU7GVjHjsbepaxUp7XgK3CbeVXSpeiAmZZdTX5LzaZRveYu2LMGZl9V8WVS9e3rthorW4IAj2ZduJzdqOnAW8hGxJmm1Mc/jWvEhN94aPYaVeWOIppV4kXa6Pfr1zmHdUde34Us57miRWI90qy7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Yi4BsKYl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732280221;
	bh=WOwxTUzv7fGVDTwEQ8PsFJI8EJnOd1qG8l4Al4/5Qto=;
	h=From:Date:Subject:To:Cc:From;
	b=Yi4BsKYlHkU+5fEgNEPwtJZcyc9p+e/aD71vgl9HTFnUZW8q2kZg1ZZvXoGNauWNB
	 F7jvCP1RvttkgB2LeMphJvfZ+vSbiZTMVxOE8M6iMS53ffq776xd0MvkljGMniPnRW
	 ByDfhID3MQ7b9E7n/vrJ2v6G1BdXwJ/zBYbNzc44=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Nov 2024 13:56:41 +0100
Subject: [PATCH] btf: Use BIN_ATTR_SIMPLE_RO() to define vmlinux attribute
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIh/QGcC/x3MQQqEMAxA0atI1gZsFDszVxERq6mTTZWmiCLe3
 eLyLf6/QDkKK/yKCyLvorKGDFMWMP3HsDDKnA1UUWMMEeqpXnFagyZ0EoYxpYhu82hrS5/Wua8
 nCznfIns53nXX3/cDyLzbRmoAAAA=
X-Change-ID: 20241122-sysfs-const-bin_attr-bpf-737286bb9f27
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732280219; l=2030;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WOwxTUzv7fGVDTwEQ8PsFJI8EJnOd1qG8l4Al4/5Qto=;
 b=Jus5BinQ7WoAKC1cbteEgMtzudciB3FctLBUhMRPHF91ns7gegnva4csW+mUdGx5+9Q8lDVFt
 bukULuMG0EVAi+wxsSLcC8KOCffE2PBHQRSeGeZUGg87oPelBLJO54N
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The usage of the macro allows to remove the custom handler function,
saving some memory. Additionally the code is easier to read.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Something similar can be done to btf_module_read() in kernel/bpf/btf.c.
But doing it here and now would lead to some conflicts with some other
sysfs refactorings I'm doing. It will be part of a future series.
---
 kernel/bpf/sysfs_btf.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index fedb54c94cdb830a4890d33677dcc5a6e236c13f..a24381f933d0b80b11116d05463c35e9fa66acb1 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -12,34 +12,23 @@
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
-static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
-	.attr = { .name = "vmlinux", .mode = 0444, },
-	.read = btf_vmlinux_read,
-};
+static __ro_after_init BIN_ATTR_SIMPLE_RO(vmlinux);
 
 struct kobject *btf_kobj;
 
 static int __init btf_vmlinux_init(void)
 {
-	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
+	bin_attr_vmlinux.private = __start_BTF;
+	bin_attr_vmlinux.size = __stop_BTF - __start_BTF;
 
-	if (bin_attr_btf_vmlinux.size == 0)
+	if (bin_attr_vmlinux.size == 0)
 		return 0;
 
 	btf_kobj = kobject_create_and_add("btf", kernel_kobj);
 	if (!btf_kobj)
 		return -ENOMEM;
 
-	return sysfs_create_bin_file(btf_kobj, &bin_attr_btf_vmlinux);
+	return sysfs_create_bin_file(btf_kobj, &bin_attr_vmlinux);
 }
 
 subsys_initcall(btf_vmlinux_init);

---
base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
change-id: 20241122-sysfs-const-bin_attr-bpf-737286bb9f27

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


