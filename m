Return-Path: <bpf+bounces-47683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2079FD98C
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 09:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185C3163E20
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A56F13635C;
	Sat, 28 Dec 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Xl1pH8fM"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C262AE84;
	Sat, 28 Dec 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735375433; cv=none; b=cF554kor0tSrlsEt5PsyKfAWT2S0FCKv8F/ao9heSbf66IB7gmu6NN5jXyXW3YQMqiqLQ3dEXr20CHPkFDcm/XAGphEdxiqpSsmwX7hXvLODMZI5cz9uUyF+mw0wGSgKqYQrYh3GNBS/Qhwlq2NpbpuFyur74NPk5amqA/efwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735375433; c=relaxed/simple;
	bh=yFTZIDT/d9HKSr1VCybVUXBQPCUX/YWCdCVUCfZE2/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piA+naPcVUUOFNWKgqFqWly4WFFso+F8niTcB/h7qQ8/pFP7rxcgmn24P0zbkbC4s9JHZyzutaLTtWYV240jJ3DfOriEvSik6XpRttNnE9ookgSHftp/bedh/wKcPMtheKPGeF7oRqN8pEyxLzPMhFVLK6+b+Qb0x02tg0QgM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Xl1pH8fM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735375425;
	bh=yFTZIDT/d9HKSr1VCybVUXBQPCUX/YWCdCVUCfZE2/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xl1pH8fMwJkWtxghK0js1fvN2LWVyc5ULtS0ciesFEvCSGFDV3o6XNp5iqtG5kcDo
	 qOkgzq5oNnUA+HIIYCqMh854PKCnzsAG19g+HM68z3tN7UYrzLuSZ3uQQiM/mEiS9K
	 ihiUUYZ+Q0TdGEW82PgH5ELbsqoT2H+DIpC8LwgE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 28 Dec 2024 09:43:41 +0100
Subject: [PATCH v2 1/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241228-sysfs-const-bin_attr-simple-v2-1-7c6f3f1767a3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735375424; l=3142;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yFTZIDT/d9HKSr1VCybVUXBQPCUX/YWCdCVUCfZE2/M=;
 b=Ni8nIBAGjX6qgotF8fSZOwTJVXCzznB2lw/kHPdISFKxwDtDfbonQu5zAuNxSCK4uO/EeMAlU
 JPfsg2Ov3aUDl6ja2Pz8DczKxR2KsqWByNAwSr+CzMkm1Sc7LA+e/uQ
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


