Return-Path: <bpf+bounces-49690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01128A1BC0A
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784FD3A867D
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A080F1C8776;
	Fri, 24 Jan 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="wp7ZXXRE"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649F21ADB7
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742926; cv=none; b=czx3f2/hvUGG591Qz/tB+PYRE7G41f3X/5xGL5y5Y32s5RWWk+YZS1jWsZsBJWEVDGrN4+nwb4OxpD0ibID0Ee8wQ961Pxh74ip4NSPZmch/tdAT3ACAgIloRgbRRw1vgm0G8fOEfU48IUfcgJPKGZxnAaQl+sHzdq2tHy7ry8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742926; c=relaxed/simple;
	bh=vuE0cbF3cK2RIUe+INQdehE2MHyMu75D7nDjiwGryAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQOfCAAKIafcVFPcDHvN5JLvDx2bf1VOXBofzDCG5bfRdka0DmftSr4Qoxb8/ye/DtJMCTqGIA85YEGIV+zT79kpTWtuqHXdDxi/7L9IWlSPF2RuNWj6YalNGcBdXeoJmk4RBM/8M+gQbBQ4xENIqHPt4qsVRynaojZK3xoBIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=wp7ZXXRE; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737742919; x=1738347719; i=linux@jordanrome.com;
	bh=CTtBpXoCRGF8xp6ipvPviZzZSvtuH9Unpp03LtW5iJU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wp7ZXXRECo5jMCWFejrBX1W6qo6jywqevxGIlC/XakneUbfrpPh4T6ynEZ+srt3W
	 B8CEtEuyEBMPBuzzuJxC1rAo5Ep4/JpCiGZ8B2TxAe28Ky+zIR1AhDYNPkDqfF0q7
	 E1EgdJWDvuSq1XAkipMaZNqjoz0cVDsvdYbje+l4IYger6SxuALViRDri9sOzCTQ6
	 AfdEjeOyuZC0/ALqpHG4AfyN7KQ+nCMVYPaKgIEihQqj+28mCONjBIwIZbv2poWtB
	 f0vYd0rAhCT2GDKIf9TK35uH1iPR0ZiTC6+GbhQPBxsFRcwSjDRe3gxj5qXS8+kBU
	 4KFlXycENwmF3idmLA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.21]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MHVog-1tegXl2DWe-000X2F; Fri, 24 Jan
 2025 19:16:09 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Potapenko <glider@google.com>
Subject: [bpf-next v3 1/3] mm: add copy_remote_vm_str
Date: Fri, 24 Jan 2025 10:16:00 -0800
Message-ID: <20250124181602.1872142-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aN627SuLhjaIjqrJzCgctnzWbHzLjJyMe1aVh1V6WI5NYAcFzNw
 ldODKGOaIFpbthhCKD6LEgQ1JQZCFzWLyoXwdXYHyIL+0wv/9Vf7Ua82jXyqmCjhw7tArGS
 fhoxyagyJWERY7esMKb+EHdJATLH+W6q3LgznzoRb0fEm+29ueoB0DoEGBSsLfXdzEQ1Qbe
 u4u1n19/YDTuW+rZhKfrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HHPzqcsjC08=;G76sFteiqH8SCHuonPXk1b1lz8o
 0Rq8Umz0Pd4QrzArMg/vuZOhlj1YVhUDEL0sGkSiDoDMPo/d2Zs79Zw8RUmYLduIZ5kx+Tt5x
 0NAN9xDSaIesDzukiKgUQTQRHoPorz/eikgnpRqIdW2QF5dJxWDgm3VaR2RKuE1ILCDwz0XK/
 xGzAb5yTpCXWnL7m6loSfW6m7IVK6QLNgUuctL5WdAOaYseBBE6FVAxxbt6wwICukc2hSsIHD
 tKDe97T4lRJHkNKk4lz/Csv0PGBfoe4R+DR+se6GUwae3CGySgURk5T9/TOxb0kLI2y2G/BOc
 yD2uIWxbxo+hxHvyopz1WSge/VL+0I7HqFcC8VtrrIBurMcQS/Ym2KFZQNP4VWe8ldMsaz2RE
 2o0slD5ZLGYtC3PHwc69IP0XptGSmUxfB4OWKb+hioUgRk87jiXFq51DrXrsscjCk31J3SXOv
 3NfYGkdK/GdnEszMYTAHCTv1g9i66mH37H2XzVw/fKzdKkETixzAIC6qrGDkDXhWZ2/0uU9i5
 l7YKFZACxs26/KULkRRIXHtVINy4ahig9+H0c+UuqepFiP2rzMPPacqCd6yVNEiXJo4WY9LYa
 1+XP4kzCDZBQbyIHMyiO2Hm4fzFgYRAbHqYhAP5DW98wTO9AD8fU+NZfO43Jk1mB95DWK1zCP
 YylHNOhg6WqZAqlzKYEmenh3jURU7RDpqSn1ETA3+6B9XceS+djLpoO3TQwjB2vUJMp6iTOYI
 Jw3fOkIBkQuw/iE/rtBoaZmyp7+XE4MxwEt74pAONU3xy0951GpA+iBymc4YOkPsvXpNpExV5
 N0peGRvY5PlqtUMS1due/GD6jwuaG/MLhIyvvZuZbwb9UA4NpdQJIhYTnqfMSzRc9V//xhLxJ
 XlUPnfdOne1r/0YwulkBjsA9zWnlkrLcgqvi0HdVp+JxOdYjPn00YMSy86tahxfiTsiSgQy9p
 kozrZm4Vf49AgLvd/uNBzWhlcST7XI0HSljeUAGbWTjbWHb54bVgmo+dErgtkls7ClanThQHc
 0L5yT98U0cR59Lp3rzKOQbEsv0syETygQHN68jzyl+LEWYeVTKENTfUwGRubgSA4JzJJBoy6j
 1kT+YYzUhn9qvvOnYEOBPYVO+VT+xx67Nf/0y4bVASftj+mkQH/2rtznQ8M8ZUFzVCSQjRHx8
 igUQ6v26NomVO3XPLz/NS4Vs6U3lyQNdG/W3PUvMNemnTMkJDkRaDyPv06kzkKIlXYgxPvjCt
 59ZHU4xeBUKrBNCE5qQN7/CXRkXtACC0bw==

Similar to `access_process_vm` but specific to strings.
Also chunks reads by page and utilizes `strscpy`
for handling null termination.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/mm.h |   3 ++
 mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  68 ++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f02925447e59..f3a05b3eb2f2 100644
=2D-- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2485,6 +2485,9 @@ extern int access_process_vm(struct task_struct *tsk=
, unsigned long addr,
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);

+extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr=
,
+		void *buf, int len, unsigned int gup_flags);
+
 long get_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
diff --git a/mm/memory.c b/mm/memory.c
index 398c031be9ba..905e3f10fad0 100644
=2D-- a/mm/memory.c
+++ b/mm/memory.c
@@ -6714,6 +6714,125 @@ int access_process_vm(struct task_struct *tsk, uns=
igned long addr,
 }
 EXPORT_SYMBOL_GPL(access_process_vm);

+/*
+ * Copy a string from another process's address space as given in mm.
+ * If there is any error return -EFAULT.
+ */
+static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags)
+{
+	void *old_buf =3D buf;
+	int err =3D 0;
+
+	if (mmap_read_lock_killable(mm))
+		return -EFAULT;
+
+	/* Untag the address before looking up the VMA */
+	addr =3D untagged_addr_remote(mm, addr);
+
+	/* Avoid triggering the temporary warning in __get_user_pages */
+	if (!vma_lookup(mm, addr)) {
+		err =3D -EFAULT;
+		goto out;
+	}
+
+	while (len) {
+		int bytes, offset, retval, end;
+		void *maddr;
+		struct page *page;
+		struct vm_area_struct *vma =3D NULL;
+
+		page =3D get_user_page_vma_remote(mm, addr, gup_flags, &vma);
+
+		if (IS_ERR(page)) {
+			/*
+			 * Treat as a total failure for now until we decide how
+			 * to handle the CONFIG_HAVE_IOREMAP_PROT case and
+			 * stack expansion.
+			 */
+			err =3D -EFAULT;
+			goto out;
+		}
+
+		bytes =3D len;
+		offset =3D addr & (PAGE_SIZE - 1);
+		if (bytes > PAGE_SIZE - offset)
+			bytes =3D PAGE_SIZE - offset;
+
+		maddr =3D kmap_local_page(page);
+		retval =3D strscpy(buf, maddr + offset, bytes);
+		unmap_and_put_page(page, maddr);
+
+		if (retval > -1 && retval < bytes) {
+			/* found the end of the string */
+			buf +=3D retval;
+			goto out;
+		}
+
+		if (retval =3D=3D -E2BIG) {
+			retval =3D bytes;
+			/*
+			 * Because strscpy always null terminates we need to
+			 * copy the last byte in the page if we are going to
+			 * load more pages
+			 */
+			if (bytes < len) {
+				end =3D bytes - 1;
+				copy_from_user_page(vma,
+						page,
+						addr + end,
+						buf + end,
+						maddr + (PAGE_SIZE - 1),
+						1);
+			}
+		}
+
+		len -=3D retval;
+		buf +=3D retval;
+		addr +=3D retval;
+	}
+
+out:
+	mmap_read_unlock(mm);
+	if (err)
+		return err;
+
+	return buf - old_buf;
+}
+
+/**
+ * copy_remote_vm_str - copy a string from another process's address spac=
e.
+ * @tsk:	the task of the target address space
+ * @addr:	start address to read from
+ * @buf:	destination buffer
+ * @len:	number of bytes to transfer
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destinatio=
n).
+ * If the source string is shorter than @len then return the length of th=
e
+ * source string. If the source string is longer than @len, return @len.
+ * On any error, return -EFAULT.
+ */
+int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
+		void *buf, int len, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	mm =3D get_task_mm(tsk);
+	if (!mm)
+		return -EFAULT;
+
+	ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+
+	mmput(mm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(copy_remote_vm_str);
+
 /*
  * Print the name of a VMA.
  */
diff --git a/mm/nommu.c b/mm/nommu.c
index 9cb6e99215e2..23281751b1eb 100644
=2D-- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1701,6 +1701,74 @@ int access_process_vm(struct task_struct *tsk, unsi=
gned long addr, void *buf, in
 }
 EXPORT_SYMBOL_GPL(access_process_vm);

+/*
+ * Copy a string from another process's address space as given in mm.
+ * If there is any error return -EFAULT.
+ */
+static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len)
+{
+	int ret =3D 0;
+
+	if (mmap_read_lock_killable(mm))
+		return -EFAULT;
+
+	/* the access must start within one of the target process's mappings */
+	vma =3D find_vma(mm, addr);
+	if (vma) {
+		/* don't overrun this mapping */
+		if (addr + len >=3D vma->vm_end)
+			len =3D vma->vm_end - addr;
+
+		/* only read mappings where it is permitted */
+		if (vma->vm_flags & VM_MAYREAD) {
+			ret =3D strscpy(buf, addr, len);
+			if (ret =3D=3D -E2BIG)
+				ret =3D len;
+		} else {
+			ret =3D -EFAULT;
+		}
+	} else {
+		ret =3D -EFAULT;
+	}
+
+	mmap_read_unlock(mm);
+	return ret;
+}
+
+/**
+ * copy_remote_vm_str - copy a string from another process's address spac=
e.
+ * @tsk:	the task of the target address space
+ * @addr:	start address to read from
+ * @buf:	destination buffer
+ * @len:	number of bytes to transfer
+ * @gup_flags:	flags modifying lookup behaviour (unused)
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destinatio=
n).
+ * If the source string is shorter than @len then return the length of th=
e
+ * source string. If the source string is longer than @len, return @len.
+ * On any error, return -EFAULT.
+ */
+int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
+		void *buf, int len, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	mm =3D get_task_mm(tsk);
+	if (!mm)
+		return -EFAULT;
+
+	ret =3D __copy_remote_vm_str(mm, addr, buf, len);
+
+	mmput(mm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(copy_remote_vm_str);
+
 /**
  * nommu_shrink_inode_mappings - Shrink the shared mappings on an inode
  * @inode: The inode to check
=2D-
2.43.5


