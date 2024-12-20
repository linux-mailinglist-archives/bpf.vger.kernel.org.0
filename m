Return-Path: <bpf+bounces-47462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547D9F99FE
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1BD167ADD
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31A21E0A8;
	Fri, 20 Dec 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="FrmTCBmQ"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43D215717
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721898; cv=none; b=D9h1WZxkb1tbNKL8oDF8LjhNbUEn2lM0FJOVZRV7ljowj+ydUwFfv2mr9MsvTW8otrdhdD876AyF0auPkbMpjAu3s+G2R21D/k+ILVGbXljMeSZULydz8BLxVThvMOmlX7jBQWx0N08NXmoUnar8247Y8RVB19P6l1nbKXGeV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721898; c=relaxed/simple;
	bh=8xbiRdHBPO3jUfbkoLzQyxJEc5n28WhLyIkdJ/pSSBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMtujfqzQI7Rhgyvd+MoCeWkT/EMpeRQ+w+bYH+byZJV22QqJzVO0++u3i2Do75hSr3c55HI4r4ijtkcjc6QVmM7TxNKyQuEd/2DpzssX/xULN9D15nQjOJI4MznGyv9Nq5qX+SKdc/J/MiMs47q2omjztVivCMpb3yxOXYQfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=FrmTCBmQ; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1734721863; x=1735326663; i=linux@jordanrome.com;
	bh=uKIcLe53DhKAw/KOsMpnBW86/EMOplkL0jIHNB21QpA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FrmTCBmQ7gTAk0gl0+7IB8CVzfiEufEsCkHf7yKKG6iqw01Cl+x8IfUqrV2wPIhg
	 i9/PC7oj0oGjTP1V0/BNeyWAFhWJYQQUtvwV6ksy9YbEbLI5pY5hzCDvDjO1wAvey
	 QTivll9F86A7khfO242G1w8HZCYeH/A1lV8sQYnS0BWEVXq2955fvWdMmD2Y+Lv6K
	 fO49YczphF0OjqFD0wy1+qDONC6jDBh6Tq7WF1GU+fAKlWT61s58hyVjgLSjb18ZJ
	 Ov0svZeC9bejOMOsTHYnEyjd02eH9Vpn4355RAJFJNXksC3NF8Prlb+XfFBvbi1aQ
	 gOEbQejxFHlU7tAkIA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.10]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MC3TF-1tGmr40wgP-00Gt6E; Fri, 20 Dec
 2024 20:11:03 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [bpf-next v1 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Fri, 20 Dec 2024 11:10:51 -0800
Message-ID: <20241220191052.1066250-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ygL+D53aP6CjmjpYKb3lsGMRfJ7rpbvqBKBq2UMu7vza1RtNh+L
 ZoscTPfN1lT99zYSqx+l5HMceWHimnW2ZRhON1DMG17KLDyb31/VXx9igWFWvGg1XaGcbTk
 VgSnNzbNpwfNefJAFpOAU69wvWZRBXX3mNPXqJJxmxbcJuYVLCAbs19DIn1pHiBnRGlXKVU
 VPsVGh8W7le5jrJi7ZJaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mpnEO13JNJ8=;plfr7tEJ3gadeUzZwYVfSteOOkZ
 tSL7lKXAiyWdlsMBEEmssoBi3UUFSWkc+3Y+69hvb1olvNo1yu+D7riUXGFA7C8aczJ/zrKYo
 eXmtMFMXrqSJ8e2IW4xpsMvCWlAHGc9TvdckPA4FUgz2QogJQYVnYInF19fb14fNIEdqu38Vw
 UIyeHc+OennsJJtQq0YqiF6A/j7GIo/FV8aMR6Awi1WLUjkz2TDk8LO9Q96VjZ2ICUXOpucDJ
 W3ix1ryGQLiFOCW5U01QXWanIJRzsTwb8F/5ss8cZkd60ZsCFbSb4DLREz8/5XkjWnmUI0jzJ
 xJSLXiy3KB4pVVH+edn+N17PyKGeQXa2VZAVYXLHq1Naq3PVH3fRloyAj25tOJNYvS8Nmhpjh
 8Diq4x1g4b7b4za32+AoBbusrKY1OFbD2+d84t2t0EL0LNke5+5NCBQ9Q6BKRVhu7L1Txd7Tt
 Vv/AeCfqoN/+aPVrGpn/LO00/gdINEWB5Lt/YyxoBvUUUdsHZdDq6WrDzqIwR1TKsNtLt9vOa
 dWuUFvmUIFIAjd8xcwOcYdGqUzqCMc6ZuB/AHXX2fMpI0q5H0sJTzGCph0ZDUB+ql3/20zRhs
 AnUDw7Q9FnBNVqBWlY2tAE6i3LwDOqmqSXyP2KJm90TEgl0rv7+Os2T3CAeZ1j7TvaJBMR+eb
 Vgj96ja0yS6gPHPU72EFtluOARvYx9z9MiDFowk+QT2x2qMDyCI+TqWIgQLtJyNHm7QGI8Tvp
 3L9sCklbWmsSOgc7sQciMvnrXX2v+3kIkTuWyLr8P0MQ8IKENCqyc++y6lBrIGaDaszsvpWh+
 K1RoSuhFkXqPT8N+GTZV9Of1GVN2gJ+GFib559iJ1d2HxNBQ4ippnPmTFjVDFs/cB/mz2Tunl
 Cdn21oBaMBR9OqtME7ky1EnYTqWexQRch2OghUy6zfLtMpFZxHcao607a1YQVc203L1n+LEaM
 TNzDaaDCruTxL93eodLvw6+UPHILpLu7wTmr0meTPrDRIFiu4u5exarGOilY9mjz8mhlV18sB
 5cNQzxXSK88lNgXrBXUWd/BX1VJamdQzXFZr8vQ

This new kfunc will be able to copy a string
from another process's/task's address space.
This is similar to `bpf_copy_from_user_str`
but accepts a `struct task_struct*` argument.

This required adding an additional function
in memory.c, namely `copy_str_from_process_vm`,
which works similar to `access_process_vm`
but utilizes the `strncpy_from_user` helper
and only supports reading/copying and not writing.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/mm.h   |   3 ++
 kernel/bpf/helpers.c |  46 ++++++++++++++++++++
 mm/memory.c          | 101 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c39c4945946c..52b304b20630 100644
=2D-- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2484,6 +2484,9 @@ extern int access_process_vm(struct task_struct *tsk=
, unsigned long addr,
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);

+extern int copy_str_from_process_vm(struct task_struct *tsk, unsigned lon=
g addr,
+		void *buf, int len, unsigned int gup_flags);
+
 long get_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 751c150f9e1c..b282dd6aa95f 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3057,6 +3057,51 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u=
32 dst__sz, const void __user
 	return ret + 1;
 }

+/**
+ * bpf_copy_from_user_task_str() - Copy a string from an task's address s=
pace
+ * @dst:             Destination address, in kernel space.  This buffer m=
ust be
+ *                   at least @dst__sz bytes long.
+ * @dst__sz:         Maximum number of bytes to copy, includes the traili=
ng NUL.
+ * @unsafe_ptr__ign: Source address in the task's address space.
+ * @tsk:             The task whose address space will be used
+ * @flags:           The only supported flag is BPF_F_PAD_ZEROS
+ *
+ * Copies a NULL-terminated string from a task's address space to BPF spa=
ce.
+ * If user string is too long this will still ensure zero termination in =
the
+ * dst buffer unless buffer size is 0.
+ *
+ * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on succes=
s and
+ * memset all of @dst on failure.
+ */
+__bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz, const=
 void __user *unsafe_ptr__ign, struct task_struct *tsk, u64 flags)
+{
+	int count =3D dst__sz - 1;
+	int ret =3D 0;
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+	ret =3D copy_str_from_process_vm(tsk, (unsigned long)unsafe_ptr__ign, ds=
t, count, 0);
+
+	if (ret <=3D 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset((char *)dst, 0, dst__sz);
+		return ret;
+	}
+
+	if (ret < count) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset((char *)dst + ret, 0, dst__sz - ret);
+	} else {
+		((char *)dst)[count] =3D '\0';
+	}
+
+	return ret + 1;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3145,6 +3190,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL |=
 KF_SLEEPABLE)
diff --git a/mm/memory.c b/mm/memory.c
index 75c2dfd04f72..514490bd7d6d 100644
=2D-- a/mm/memory.c
+++ b/mm/memory.c
@@ -6673,6 +6673,75 @@ static int __access_remote_vm(struct mm_struct *mm,=
 unsigned long addr,
 	return buf - old_buf;
 }

+/*
+ * Copy a string from another process's address space as given in mm.
+ * Don't return partial results. If there is any error return -EFAULT.
+ */
+static int __copy_str_from_remote_vm(struct mm_struct *mm, unsigned long =
addr,
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
+		mmap_read_unlock(mm);
+		return -EFAULT;
+	}
+
+	while (len) {
+		int bytes, offset, retval;
+		void *maddr;
+		struct vm_area_struct *vma =3D NULL;
+		struct page *page =3D get_user_page_vma_remote(mm, addr,
+							     gup_flags, &vma);
+
+		if (IS_ERR(page)) {
+			/*
+			 * Treat as a total failure for now until we decide how
+			 * to handle the CONFIG_HAVE_IOREMAP_PROT case and
+			 * stack expansion.
+			 */
+			err =3D -EFAULT;
+			break;
+		}
+
+		bytes =3D len;
+		offset =3D addr & (PAGE_SIZE - 1);
+		if (bytes > PAGE_SIZE - offset)
+			bytes =3D PAGE_SIZE - offset;
+
+		maddr =3D kmap_local_page(page);
+		retval =3D strncpy_from_user(buf, (const char __user *)addr, bytes);
+		unmap_and_put_page(page, maddr);
+
+		if (retval < 0) {
+			err =3D retval;
+			break;
+		}
+
+		len -=3D retval;
+		buf +=3D retval;
+		addr +=3D retval;
+
+		/* Found the end of the string */
+		if (retval < bytes)
+			break;
+	}
+	mmap_read_unlock(mm);
+
+	if (err)
+		return err;
+
+	return buf - old_buf;
+}
+
 /**
  * access_remote_vm - access another process' address space
  * @mm:		the mm_struct of the target address space
@@ -6714,6 +6783,38 @@ int access_process_vm(struct task_struct *tsk, unsi=
gned long addr,
 }
 EXPORT_SYMBOL_GPL(access_process_vm);

+/**
+ * copy_str_from_process_vm - copy a string from another process's addres=
s space.
+ * @tsk:	the task of the target address space
+ * @addr:	start address to access
+ * @buf:	source or destination buffer
+ * @len:	number of bytes to transfer
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from source to destination. If the stri=
ng
+ * is shorter than @len then return the length of the string.
+ * On any error, return -EFAULT.
+ */
+int copy_str_from_process_vm(struct task_struct *tsk, unsigned long addr,
+		void *buf, int len, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	mm =3D get_task_mm(tsk);
+	if (!mm)
+		return -EFAULT;
+
+	ret =3D __copy_str_from_remote_vm(mm, addr, buf, len, gup_flags);
+
+	mmput(mm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(copy_str_from_process_vm);
+
 /*
  * Print the name of a VMA.
  */
=2D-
2.43.5


