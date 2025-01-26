Return-Path: <bpf+bounces-49836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C62A1CCB1
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F7E7A260E
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960515748F;
	Sun, 26 Jan 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="SotmuTQp"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780A1553AA
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909558; cv=none; b=hwEMGJi4AF5EHuSN+cm7xxo8YSvhMGyE/Uyt3hVlGRkZnlpp0130WjIEl/ijxWGrfhhsQbszBx6A2gpLlLpLPBS5ppOm/QEUir6Ag87M1G+f/UoMOySbqNPW3pYG+V2vu2giDOF/mrXbUyELhFF4HL6eAz4prePbh6eZjE+gzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909558; c=relaxed/simple;
	bh=9D85DV3lgPWy3EeDetLGNFfsU8kVPL/Pw5F7M7d2Urk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmzR08So1qCUfCpRQ/X7sMG4uoCzZjeVsvmm1biYxpex6qOlOj6IY3N0+d9SINHgbCZ+sME7/2GXpKR09vJi9AECfuXv7M05BcMaJfYKnOnOcBpkq5GuHuXdMJs3WBVLCHWZI9q2s7GRdbSWgUXat08e+WCVMn1YVebjnVRHqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=SotmuTQp; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737909544; x=1738514344; i=linux@jordanrome.com;
	bh=WQqKKWz7ABhutvWGSnvN5g84wY9U59VZp9TK3/MXkQg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SotmuTQp6p9oe61i0QmsNyV44YyPzPm/r4fyWLx+1jgckxYbu2wW0wg/pz/YNLOI
	 9nUp8lXNsmJQoSYPmvlxPTWk593vl/G21YZg0Y7pi6VsH4Z9ku2vG85QZT0EhiR8m
	 4fpNJMtCo/0vvvIbe3us/lSo3sKnpRiVceZCRg5NpEQgC3uCVXxi7xoxfhcSbNlnn
	 uzjhGbufZzqDeZtTrzcj0R0s6UTJ5WCm0HHKzqssaDv+NwbDt0Ir2as6ihEQ9p+4o
	 v3KQKePRzdQH3bK3n+Gp15eUQQVjLw1SyvzK4PHo6yETWqSqyVTVQXl/d6oXqJg+F
	 wRgwXxiNllNXFysSdQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.6]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LoWNw-1t0JCv3K1a-00iRAw; Sun, 26 Jan
 2025 17:39:03 +0100
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
Subject: [bpf-next v5 1/3] mm: add copy_remote_vm_str
Date: Sun, 26 Jan 2025 08:38:55 -0800
Message-ID: <20250126163857.410463-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mw4ISjNDeWsksWR4vWQ24w3F7PImn8YBiiD09AIq01XKohTzUzi
 ct03kS7aIUuRvvD1HoClOAH8/fUprAlc1i/vt18QjPFRPGhcr/eHxSF3a78iRNgm7ifrGSw
 uga4l9dFfErE/HgjZ1p33CTxwfVUfHyPfxixsBG5WaP8z2EZVvUu461KPrpQ8j70hnocm/Y
 DAME1ZYSbcNRzUtM/VYvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1cTmql1GcGY=;9muYWIYUMt27NL+sb4Wf6AvVdYa
 fQzmY4srFsOgMGccHYmFmxbXE+UKd8LQ9kb4PUoLu6ubCRECrZeZmvpixjAM7FNW7Wxp7DiJT
 SUhpVkIKNekOO+8t6ze28S7HU5mLbh2bWCyK95uSLYfpSXCecRLpOcg5euk+nW1ZJrcMlNDS6
 wYWzXkf8wR7l0+1W3YNERMMaDrVDlNCEIVJ+V5ruJgs2LCdVFRsoanRCol1IXRrTd5kggUBDe
 nI8kxYavJbYiahv5km5G9SMztq0hLqYpBSglH3ZOce/wVc6JPCwslSmfSXNcewE680YT+o1Mk
 /sWLGzNDIFoQwXdgApGxPIZJroYQQdkRrV/uf7S5xaGL8LDGDE6Sb71KGINin/o/Z4XWk2pTu
 o56LxH+9N3OfdvhqdZf3m1uP7L4Ttzb3/wsxgFvKfLZWv3RpM02NvIUaMUrJy5v7vwnk/yjb4
 COkE28hPvbhurB8qNQT9w0Ensa9rc99WZPY5I8990GgEk4g0WAQD2x/rq7WJvyZsNFxThsMt3
 1pO3HlnhCDEyQzMoukkdTaXa6epiBgBKsyMoSSRD1VRDYWc5jkAPy8oKro9L+l/AjmEIJ2OmR
 3ngO4g1QoQgUXb8BrB1QVdVso9DIfj6Rozu0DD/PJHR5jSTGzESC8sq5S3ho4l4YGox/JU8os
 ftEJEz6A0RYH+9Jf/DCDNwu7QY29XvQ9YmMfBnCoWgorLRx/HpgaBGsFwLgdDio65xNNbhEmf
 7FkdbffekrS6twmX4ZI/eFE9xqsb+2F4JTK2J2PpITLmdSeBcanhXruGYoEBdPjBaUFZ3vBUG
 JKkLP8NskSrtI6Q8emOY5Y3o6GeddFdfU8U/nJHbBeN6zGTQp+FAAs5V/es/yXBDtXXdjmH5I
 DIiminQGIwlj90i1lYrk4QPdwhzsoxi+5KutvZJn1IvYUosEn1R4aYBIisA6WTXTusA5V6QH+
 7GiAWAJBwsOM1E9ylJM4V3vaZ1ut7v1Xu2IUyrrOgkxG+vAMUyS1tLZGUM7192uCRCnYLo2L8
 a352UZs9znlJRIbdDL4sr9pF1Dg52bj5l7sz2imRk0hU2e9hl1Sl/ljx6W5iT29+kg4bYHa3V
 XnQ0toJLc3nyRZmJgrSlm55vOKswUTn+WQcLJHSC+AbbEDxOZJyw==

Similar to `access_process_vm` but specific to strings.
Also chunks reads by page and utilizes `strscpy`
for handling null termination.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/mm.h |   3 ++
 mm/memory.c        | 118 +++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  67 +++++++++++++++++++++++++
 3 files changed, 188 insertions(+)

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
index 398c031be9ba..e1ed5095b258 100644
=2D-- a/mm/memory.c
+++ b/mm/memory.c
@@ -6714,6 +6714,124 @@ int access_process_vm(struct task_struct *tsk, uns=
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
+		int bytes, offset, retval;
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
+		if (retval > -1) {
+			/* Found the end of the string */
+			buf +=3D retval;
+			goto out;
+		}
+
+		retval =3D bytes - 1;
+		buf +=3D retval;
+
+		if (bytes =3D=3D len)
+			goto out;
+
+		/*
+		 * Because strscpy always NUL terminates we need to
+		 * copy the last byte in the page if we are going to
+		 * load more pages
+		 */
+		addr +=3D retval;
+		len -=3D retval;
+		copy_from_user_page(vma,
+				page,
+				addr,
+				buf,
+				maddr + (PAGE_SIZE - 1),
+				1);
+		len -=3D 1;
+		buf +=3D 1;
+		addr +=3D 1;
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
+ * @len:	number of bytes to copy
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destinatio=
n);
+ * not including the trailing NUL. On any error, return -EFAULT.
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
index 9cb6e99215e2..ce24ea829c73 100644
=2D-- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1701,6 +1701,73 @@ int access_process_vm(struct task_struct *tsk, unsi=
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
+	int ret;
+	struct vm_area_struct *vma;
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
+			ret =3D strscpy(buf, (char *)addr, len);
+			if (ret < 0)
+				ret =3D len - 1;
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
+ * @len:	number of bytes to copy
+ * @gup_flags:	flags modifying lookup behaviour (unused)
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destinatio=
n);
+ * not including the trailing NUL. On any error, return -EFAULT.
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


