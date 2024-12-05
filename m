Return-Path: <bpf+bounces-46170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD6B9E5D54
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD5281EF2
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA0B227BAA;
	Thu,  5 Dec 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KG9tk7D3"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B03221465;
	Thu,  5 Dec 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420143; cv=none; b=V4swDCduwTPsWtUzWAhxooEQnT4OWXVdlPwEpimbobP9cs0rtu1sq6R2vYals+JW1vWap5DqXx82YF9cu8DyvqF1QcqOHNZGkVMjDmV9Atd1uS7gNzSq2aC6MDCq2ckVmyv6Hi+po4q0/WhfpNauhV4z8Wp0PM1i5snOqD/0ypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420143; c=relaxed/simple;
	bh=yFTZIDT/d9HKSr1VCybVUXBQPCUX/YWCdCVUCfZE2/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIszNQcjXEd/jvqq5t20u9ghwUgriFXjw3lWXuedNJ8HjC/e1ikq2SJcwiLRdx2+MUjx3h4OZBBD+z1uYLWeTbwg3V8rNW+cPSgHSWm1j33bFpem0BUd53/ic60OmTN17j92BS91m3ZggZmXOMCBN1QoAA9HMxqeJTs/KlfhjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KG9tk7D3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733420137;
	bh=yFTZIDT/d9HKSr1VCybVUXBQPCUX/YWCdCVUCfZE2/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KG9tk7D3L7Uf0IUGoE1XT5UumEfJAlsFAfz8UVuSvsNm0D3SC3/fIgoGLxau2ZERH
	 mWMESJy6PDE+efZVb10E62JK6JebxXhDp9abmp90ylpbE6ROZkzRiglTfiN2Fx/5k+
	 W4pJX5dsjU6q3xn4Pjbdhsy3al2VGArAwS9ikGGY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 18:35:13 +0100
Subject: [PATCH 1/4] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysfs-const-bin_attr-simple-v1-1-4a4e4ced71e3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733420137; l=3142;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yFTZIDT/d9HKSr1VCybVUXBQPCUX/YWCdCVUCfZE2/M=;
 b=N6SLb2+eSyolUshM1oNp1SwAkyOJIwilUlfzAQ+W+1VNmN2Og70zO7PtWIR6lJLtiURIW0PKL
 lP9vrvVVQB8C6d3iPwEht3v7ttdLR6Ohcbgt+23W8yn/BbmOnet1+/p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Most users use this function through the BIN_ATTR_SIMPLE* macros,
they can handle the switch transparently.
Also adapt the two non-macro users in the same change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 fs/sysfs/file.c                       | 2 +-
 include/linux/sysfs.h                 | 4 ++--
 kernel/module/sysfs.c                 | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 5d0f35bb917ebced8c741cd3af2c511949a1d2ef..013637e2b2a8e6a4ec6b93a520f8d5d9d3245467 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -818,7 +818,7 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
 	sysfs_bin_attr_init(attr);
 	attr->attr.name = name;
 	attr->attr.mode = 0400;
-	attr->read = sysfs_bin_attr_simple_read;
+	attr->read_new = sysfs_bin_attr_simple_read;
 	attr->private = __va(vals[0]);
 	attr->size = vals[1];
 
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 785408861c01c89fc84c787848243a13c1338367..6931308876c4ac3b4c19878d5e1158ad8fe4f16f 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -817,7 +817,7 @@ EXPORT_SYMBOL_GPL(sysfs_emit_at);
  * Returns number of bytes written to @buf.
  */
 ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf,
+				   const struct bin_attribute *attr, char *buf,
 				   loff_t off, size_t count)
 {
 	memcpy(buf, attr->private + off, count);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 0f2fcd244523f050c5286f19d4fe1846506f9214..2205561159afdb57d0a250bb0439b28c01d9010e 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -511,7 +511,7 @@ __printf(3, 4)
 int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
 
 ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf,
+				   const struct bin_attribute *attr, char *buf,
 				   loff_t off, size_t count);
 
 #else /* CONFIG_SYSFS */
@@ -774,7 +774,7 @@ static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
 
 static inline ssize_t sysfs_bin_attr_simple_read(struct file *file,
 						 struct kobject *kobj,
-						 struct bin_attribute *attr,
+						 const struct bin_attribute *attr,
 						 char *buf, loff_t off,
 						 size_t count)
 {
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 456358e1fdc43e6b5b24f383bbefa37812971174..254017b58b645d4afcf6876d29bcc2e2113a8dc4 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -196,7 +196,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 			nattr->attr.mode = 0444;
 			nattr->size = info->sechdrs[i].sh_size;
 			nattr->private = (void *)info->sechdrs[i].sh_addr;
-			nattr->read = sysfs_bin_attr_simple_read;
+			nattr->read_new = sysfs_bin_attr_simple_read;
 			++nattr;
 		}
 		++loaded;

-- 
2.47.1


