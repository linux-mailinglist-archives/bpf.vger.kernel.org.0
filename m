Return-Path: <bpf+bounces-47681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C999FD986
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 09:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3679D163DC0
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA786343;
	Sat, 28 Dec 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sK2qcuK+"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6D7083E;
	Sat, 28 Dec 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735375432; cv=none; b=T868dIBk0RD4JbKZ5Uv+8jl2UO/f/8gA4CTDYRzLdC9ant5WFA9pfj5F5Ax3HXfoaiqrYsuA86rHHf7SISuEVxs8BDBsmfoXlrO7xBWW6MB2zSffZc+mfghE/uXFuPoTiG6LEw7rxbtkWsNjT6r/KqLOnlBN2o4R+TnRTkPnAFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735375432; c=relaxed/simple;
	bh=wz1z8EiyfVhVbt4qr9tEdssHSlJmEHuAhD1PCW7Z+GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6ot6w0iryaCQ/VFD95EX3UZe07h5pkqfvs9qXTiBlK1YfE3Xa2AlolGOKY6tEgKl2K4As/Dv+axi0gqWPNsblzWAQoau5GaDQXrlE2fMQrWPh2Rp5YFDE1N18RbFNW+pNmhkxtJas2h6uFI83OzPRqerSWuwsPY5sfe9mzbCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sK2qcuK+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735375425;
	bh=wz1z8EiyfVhVbt4qr9tEdssHSlJmEHuAhD1PCW7Z+GY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sK2qcuK+yGlFRTv0drQ/tSHIXIlyiafpZODXd1Cm4O5wUM0gOva8V1J2ZyHzGqyoy
	 iZy7SI3bFvLtDdk878Dx750SrTZxWuL5i0r/kYrR2rRf8qG/y/DS699t4lbpoWqu0V
	 aGKj4YfwnkO+Jem/l+omRqCywWTpARWzAldhQV4Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 28 Dec 2024 09:43:43 +0100
Subject: [PATCH v2 3/3] btf: Switch module BTF attribute to
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241228-sysfs-const-bin_attr-simple-v2-3-7c6f3f1767a3@weissschuh.net>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
In-Reply-To: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735375424; l=1403;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wz1z8EiyfVhVbt4qr9tEdssHSlJmEHuAhD1PCW7Z+GY=;
 b=H/wGBJzQrmCrKy2Y3Rb0Y68++ySdjfE7idPzg55qBSVH2MHWx1FPtKo8MlnyUx47kvNeGXYlQ
 vMM+NGIIRAUCUYj71p4EXyyMjvF47hbQPHq4QtNrPMIHcjM6PPWHOee
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The generic function from the sysfs core can replace the custom one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e5a5f023cedd5c288c2774218862c69db469917f..76de36d2552002d1e25c826d701340d9cde07ba1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8011,17 +8011,6 @@ struct btf_module {
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
@@ -8082,8 +8071,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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


