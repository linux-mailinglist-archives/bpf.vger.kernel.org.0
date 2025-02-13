Return-Path: <bpf+bounces-51419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD70A346EB
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA88A188DF46
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88214A605;
	Thu, 13 Feb 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="k2r47qhw"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68435961
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460124; cv=none; b=du7agjCwuinUH3xkKM9ixBO5HM5Q0Uk6EAaaQ0RLrlguvW/MVviuvQ9qj1jSi/HwKxEHkkLv9hZ9Rw9r2mgs5/AoZcPY2GQMieWG2HnFpJDMAv5zuB5qn8hkDDglc/T7BaLK5dw0yuiMutt7GvqWpTp7QvQL/2zO8jPH+bzxtrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460124; c=relaxed/simple;
	bh=ILhoN2kcUSoYU+qOsF13vruXxnCInfjQZZF83/lMUQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDUNzbos1NRGb6B4jdSjWGMUJwdn5Jv93ivD9ZM8SNKtDD7dOfslpcDcw9OzuYqcEO4vLFKNHF/s94zwDUevcXPxBCQmTl4IoToMJXi7iAGbuxXt4u3VWM03oCq/ej470QSptm6iOV2/AicIx863cqLYDH4i3H+kSgOYz9MBhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=k2r47qhw; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1739460094; x=1740064894; i=linux@jordanrome.com;
	bh=X3iGHmUioV23gVtaGze20y7Mei3yFn3BxL7pJl4WLaA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k2r47qhwsUB2AsSjeGfNPddps1WP5onEH0tpEiBLqPK/flmsr3GfhquLAz0pdxf6
	 HxpDiYGB4w3sP7ylMaszAI3viMj6axJuoFhZRXieYrXaHXPyajYw8jNN8SAPozgyn
	 JTZXlCOIVZ0Qz8UGoe5nDU1TLh2eodRi/35WcsJNoucA/O6dZYYYMStghWUMSz6B7
	 OQ3qDaCS5B7FFM7K45covETNQY3yAVj1J+x0BwNc6RRZa1vMQoG9hEfwucUHAg0hB
	 ORpxiIZU+EyFvQo/y4cxC5R4exRJUO4EESGrddzdXRI3YiFslSEUoVbnRZ91+slHm
	 8EhFJ4+5WpeyAlW8bA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.11]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MCauF-1tZYbe40cF-00FmSb; Thu, 13 Feb
 2025 16:21:34 +0100
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
Subject: [bpf-next v8 1/3] mm: add copy_remote_vm_str
Date: Thu, 13 Feb 2025 07:21:23 -0800
Message-ID: <20250213152125.1837400-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXmO420NAFvU9HAMP9B608FaxDpJVtP9EE9EoTcKYfcwiR5cBdh
 XszBwE98aD1Zr1wCxNib1iPNA9NcjpWQeDHhJX38cnD8KKmZfKlClTXgHmLGd2rgnxOR4k9
 qa9X+LIT7MUOzfJi/EdEOm5YczWXZO5TA/LMd57x/mRJ09JZaZJn08SvZF2miYjTsTP7z54
 xisVqD/gZ2mNmGPUBooJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kEWmGGWuR6o=;TKYm8YujZN9sSEkyW0MTmoSBxbH
 1ZZ2kNkmqWS53IhMP9qmgj2eilDB+SZQJeTa9FQRIw4RHyj7xbHBLVqdk4stq0t8bD9Ri2VS3
 kjBQ48vx7giUiXwNXWjenKLapRxPlclNB2koVc55de7gtU6v5phm/t0gLgB+D+WvT1AVkcUmE
 AvzgasCNk+XIvj2k2W2u29lhRf3TssTg8ebcYOMhV/muboZRFfV1doQs60amfDxCnF7Hqr09L
 ZPT6It4bFNdR3yOQDMC5tPBjNtjUe6yKk1HVt4zp43dPkGzv/VNjyhM5ys4QQBGEFRsIdEBSz
 LYRZYza6pZv1fWcI5aebRV4IVs3nzERepj5P1VnKG14ioujOxssJuI7Lk/iUG4TyLSYTqfA4v
 NyePS4fN2N6Bc9pja8BU0iejTs9/FRQMpoVaCSZa5WkUSwHRAwh3QydUhuxeNTpEEh5eJfKtw
 +Dxncvlvuqw0Ig6eHtlEWfZzeu9l4Dpw2Syxr4bBPUa0/+21Qd0A63vzGO9PxP29oKZKhAuH4
 3cVEvo8W6YXKINOm3fZGZwEaiq4/jwWmMJBIXSGGVp41aGfQi5qwZglg4eivXTVvH4gI+CO5O
 grO4Qc/3/77ZALz5CjPDkgfM15vEokeWomvBqNx+vJG5h8+V5fxjqoQSohAbvW2ZRogwG0wPg
 WbDGOC6EH6KemMH8Zbue+BzusAJm17xtX6WS3gnqhUVeIx8uTE6VMUOiFi6JP137Zuu9A67D+
 6m1t/Sp6Rxwh0cq+JrOKU9CoI97i9fhtFFJDMjWAJ/DX1hSt689eX34/shGwbmwuQsgBDdZJ3
 6c+l0HBW57GGTKjysN0zAFwuGX4VWWOG+9q7N3C26hVGfAS1RccSK4Rqewh7aQdWxOaqM076H
 /yOi16QTlAtPuegSCMMSan5QHmIsy1vmtcDAONdoiIqQ8pJRbgtIlcVd+CA4iRhX2J/u96zhW
 RlF6p8gWj5MOh+cFiqyJE7/whqex06fG8su944fS97GpNTXa+w3qgDE3gSNZaw51+b2kMSh/g
 fJ/oSjWVgynM5we8+barv7i2P9GqB6uiwSk7Xtgq5ZLmj9f8QW3M/Td6oxVUIwAYXf/cVbsT2
 nq5lTK8DtO3AzGdj5AZSpcHPSL0nXiMmMrt/Y1MiHxTW2r5nkJSrZnoRZn4OqTvZXA9kY75YK
 +ol3RyAQsRzXenm2Te2JxEr4AwWylLdXW5DCqVKB+5n0kc/x+4Sp1E87o/zdI6OhD42b8gWZ1
 /5HA+yg7ht4NhCJGHm1U83lsojAD0DCd8b3iO31uJA4FL+7X/zjcC4/ov9NN1JPXR2d4Rd7Rm
 sT4IUtSXYESLJM/gQx6ZqSUuLEewN40BDGuwSYQhL98a3Ca2vY7MUgcE7hWZh6oz6M4

Similar to `access_process_vm` but specific to strings.
Also chunks reads by page and utilizes `strscpy`
for handling null termination.

The primary motivation for this change is to copy
strings from a non-current task/process in BPF.
There is already a helper `bpf_copy_from_user_task`,
which uses `access_process_vm` but one to handle
strings would be very helpful.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/mm.h |   3 ++
 mm/memory.c        | 122 +++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  76 ++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..aee23d84ce01 100644
=2D-- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2486,6 +2486,9 @@ extern int access_process_vm(struct task_struct *tsk=
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
index 539c0f7c6d54..014fe35af071 100644
=2D-- a/mm/memory.c
+++ b/mm/memory.c
@@ -6803,6 +6803,128 @@ int access_process_vm(struct task_struct *tsk, uns=
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
+	*(char *)buf =3D '\0';
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
+			*(char *)buf =3D '\0';
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
+
+		if (retval >=3D 0) {
+			/* Found the end of the string */
+			buf +=3D retval;
+			unmap_and_put_page(page, maddr);
+			break;
+		}
+
+		buf +=3D bytes - 1;
+		/*
+		 * Because strscpy always NUL terminates we need to
+		 * copy the last byte in the page if we are going to
+		 * load more pages
+		 */
+		if (bytes !=3D len) {
+			addr +=3D bytes - 1;
+			copy_from_user_page(vma, page, addr, buf,
+					maddr + (PAGE_SIZE - 1), 1);
+
+			buf +=3D 1;
+			addr +=3D 1;
+		}
+		len -=3D bytes;
+
+		unmap_and_put_page(page, maddr);
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
+ * not including the trailing NUL. Always guaranteed to leave NUL-termina=
ted
+ * buffer. On any error, return -EFAULT.
+ */
+int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
+		void *buf, int len, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	if (unlikely(len < 1))
+		return 0;
+
+	mm =3D get_task_mm(tsk);
+	if (!mm) {
+		*(char *)buf =3D '\0';
+		return -EFAULT;
+	}
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
index baa79abdaf03..11d2341c634e 100644
=2D-- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1708,6 +1708,82 @@ int access_process_vm(struct task_struct *tsk, unsi=
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
+	unsigned long addr_end;
+	struct vm_area_struct *vma;
+	int ret =3D -EFAULT;
+
+	*(char *)buf =3D '\0';
+
+	if (mmap_read_lock_killable(mm))
+		return ret;
+
+	/* the access must start within one of the target process's mappings */
+	vma =3D find_vma(mm, addr);
+	if (!vma)
+		goto out;
+
+	if (check_add_overflow(addr, len, &addr_end))
+		goto out;
+	/* don't overrun this mapping */
+	if (addr_end > vma->vm_end)
+		len =3D vma->vm_end - addr;
+
+	/* only read mappings where it is permitted */
+	if (vma->vm_flags & VM_MAYREAD) {
+		ret =3D strscpy(buf, (char *)addr, len);
+		if (ret < 0)
+			ret =3D len - 1;
+	}
+
+out:
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
+ * not including the trailing NUL. Always guaranteed to leave NUL-termina=
ted
+ * buffer. On any error, return -EFAULT.
+ */
+int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
+		void *buf, int len, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	if (unlikely(len < 1))
+		return 0;
+
+	mm =3D get_task_mm(tsk);
+	if (!mm) {
+		*(char *)buf =3D '\0';
+		return -EFAULT;
+	}
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


