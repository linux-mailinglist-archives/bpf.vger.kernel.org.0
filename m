Return-Path: <bpf+bounces-48040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B88A034F6
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 03:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4791642E5
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EE86358;
	Tue,  7 Jan 2025 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="2qOQiykY"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29657ECC
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215958; cv=none; b=VyUx9aCibEUOl/y38pNJDcIxlFBzO6Xivz/xcpP3vGCH1TtrWxLCTcvcbmaSxnXp+QR/MFHjoTxynQaixuHqdvOr0l9/aYwlMaWv+JB+4IwMcwkfO/t/ynFFFk8HQtEUDxJGZ6cjiDBwtO0a0kxQdRaOpGxGFm3kFMd9iUT808A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215958; c=relaxed/simple;
	bh=/J5L2tYmebI1qwyWCtAD5UhOp6Si8cKLLRLy/rh40So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGZYB8xJvCaTew3yKBi5PZvLKBPLlUJ/PnEIsn8rRjEIMG0/8ZC/sKTaXmjIZCEF8Y8322Q7vp2ShZnwHZZrEsO+lSDdcP4XmIl5a01nBnVCU6lPm6EtjvWaEzOyPiSeaISH9kEB1od3Pd3C1NR51z/ZUznCIzUsz6+9e7hAtjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=2qOQiykY; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1736215950; x=1736820750; i=linux@jordanrome.com;
	bh=3ePT0FPt9l0Qzkz0xRTw2LrsfjW4Z5KL+i91TUZCoiY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=2qOQiykYOK/Jmr6CODErS5q1lgZ2BGDH5qHzgsxjvbvZq7yp6tR8ZFqrwgIS9oQ9
	 GYpIiDmZRStodc6t5G56w4lbofX8nyIoYgn0ZFVUk9BylaDYuApLMVe8klMY75WtI
	 ZqqtHhsel8Ok/+HtnNba2UZkTCS/9VblUcSkGQCSETXC49atfShnDYRC00hKpMkUR
	 FJwDW9gMHgJN0R1LBAqfnbA0z7rYBPuG94L6yIljVOHDyunHW+MXWkwnHpdaU6pKu
	 a5RPlCYWsvHpTdsV//usq2k2Nl0Ks+orwiuBexLcIDW4W1zeklqekuPo8RCCsQBRY
	 brYJxR5WlquH6zWLHA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.13]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MHIlZ-1tIfAm04jz-008nC5; Tue, 07 Jan
 2025 03:06:43 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Mon,  6 Jan 2025 18:06:31 -0800
Message-ID: <20250107020632.170883-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:swEFtqhmW2Kwgld9kRCHV/0VrQFU6PZ5hV+JiC+7/AR7So7t/EL
 C/GGahB7cSR1JDBXJ1k2Sly455EiX0+T86stg8IH1wt13fcvppXhcq4p6tpO/wZJJXe7MkF
 R0q7AODVholSw2csXtbuLreZYLgF4miBagbv28HnOespwAyVXT4VqctkPEedZZDqRavoAxS
 WrZFxxHGQnYM3yAeOZDPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/v3exhYE17k=;B+un3PO91ndLDTqzVXAK/Iiv3Wa
 XZsP9AHT7ttsJnHGahqrXO/6eP6Y4pofhvFCWwgQYDuVe3cNA7Gi9KZw6MxLNMh1BAMs+g12c
 v3Xwp3AQvtGh8EMQcXbK/QQBIHHBlW5KhdVeWMyyZISAAjU8sU4jiPHbMm2guK2hLAL46S6NU
 OxfTCUBxabNGtS/dGuLsvOn+21uXS2Vm9ern6iFQcJevb5TjtyBT7e4mPpVKRVHGqHpSkcZuq
 mqI7mctB/13VcdWIUR+4ewyZU5q+FrBXtmS6EV2otjGXqs2dKd3cVWShJiBIvesyHlwoBnEJF
 iNdC1IllWyNvemzFGRV0KUykQUpA6AauRjQ3EWWFqHSkyMpwovKMCUPbwT6mVTOqcWwqasPYj
 MOYsV40XlJOE6+X97Rl+Te1QuXi+zuBWkWusy6ebJKNyUs76RLufaLjGX8D0jMs78OCX2OFeu
 Bwr+Awnd0U/21QLKV/QJrMJM1awDoRdZxxduEm7gEGXzxPQ72qhYqt7zy2WNh11RPMJE4Ep9o
 BsD4UutbJf6S50wHN/m7/fT6bYUsJh3+DqONNqHqL3H9jWlo2vX7yHJ68oem2MeB8yj7digVP
 QVcmCcISxPpmP2pwKnQltIHh/WoZ23XucSPj9Fr9YZfF6p4z388DQkPrH6fNn5erq2h4RnFvp
 kApsSh9+2t/91Aj6uTg1Grdk1NV5R6Ci7XYJyHG/n5vxDACgMw98eF9zJ1PVAknx7j4CVvJNV
 7DAjfusEXUDDuppcu0wyxbU4p28tynsew4spPa0w9sSAPAHHyv9Bq9b+a5IPPfe8TtLzBSI42
 XRjWpkZ/71FbN2miKwM3ZdG5Zhtz+3eeB1cb8hUhk4jPcVpc5KIQT2npAB5ggJeWuOVX+GNxF
 cTGg8ExWSHgviyPQoeuOg/eAY2nLCv6ymhFw3AD0xrrS1LMf5OLQfj+nULXOrrFIXhegUImnu
 M7QaHwGcy3Jr7WIvEl9vxXhwTSv+K+1+owmKgDoFj+ju+o19uDdkeVzswj58mlm0gTc9U2d6c
 LcG734Q9pA2l9I7zkeovE02BYHwnamo/W3PBAqm

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
index cd5f9884d85b..45d41b7a9906 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3072,6 +3072,51 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lon=
g *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
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
@@ -3164,6 +3209,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
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


