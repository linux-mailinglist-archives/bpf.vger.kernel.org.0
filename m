Return-Path: <bpf+bounces-51058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13974A2FCF3
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FD33A3F8D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009BD2505CA;
	Mon, 10 Feb 2025 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="KQPbXFaJ"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FBF24FC04
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226187; cv=none; b=Xll5PJoEuz8QgLdPcNOJbNWjbdKi6s/Kjc7c8rX6lY/w1WDWRgOcuEQF3YLiE5uy/zEgLSQiTFYRFyGeKVdSF+bOyQ6Txi1fp8i/qk4TVoSifC/BSrcM0GSadn3lk9mu57VesOzRShUH61B6FvtidtX3zWM8ZvJD1FSghJ4GHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226187; c=relaxed/simple;
	bh=WT7HP68O1A9Zm2bD5YYyOvYtoFFKZZgls2mVbLJYVEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6I9fOkK8SCEgcdFRoT5ZPqhWOjonIxuPlDiyXb8CiNEPY9CrtLdsJv9AoZsMg9+lO/AUI8eXvl3PpC0kqnbR6wYgouJmDv7MiLvLBNSMqoWtFqMjQUxS3oVbKIIxTXEyk7K3rDP7Jdyu2Lb4v1Eg+wgmx6fg0oaTHd2jccHr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=KQPbXFaJ; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1739226182; x=1739830982; i=linux@jordanrome.com;
	bh=yJJHtP6Ybd5+FScfldyOtf8Z7tbm+0cUAU9G4HHYpKQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KQPbXFaJ2ImZ9tq6yf/Ydxeqb6UA/QNEXo+Ysj4zaGyANpxuZAEFyMtcDCjPbnb9
	 YC0mO2KV8X64l6wiAH2Ru7o/25/ILKKRMlmPa5CutRPIZEfEG8lV2Wlh3p3WCjXaz
	 W3DftzzK/p+Km/1EnsYsigtR5lSAxnQK8nH57ncja+iBHCX4qqndD+fM34FesJksW
	 oHeJxy6h19jFq2h9NSvHTivBYwFd9aksMuQF2YtdvBWhrouk/tvyiVC1kIVd+ugJK
	 dNMxOiHSVe0ixFrGTkunOjkfUc5lHLXI9Z6mD+PlUfbl42IIxEiNGcPURT4ACLWAT
	 pdyNR49xfmsrwUUVnA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.115]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MsZaJ-1tNb9Q017L-00vbnZ; Mon, 10 Feb
 2025 23:16:31 +0100
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
Subject: [bpf-next v7 1/3] mm: add copy_remote_vm_str
Date: Mon, 10 Feb 2025 14:16:24 -0800
Message-ID: <20250210221626.2098522-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QNjPbdBmC6RgFhoMhi+mCZ4fNXpSAQszghe/PMKyIZTi/DfAfXf
 w7He5TL2nFLQABaNZqxupI7lA055F6UPvNK4p0YMNMT/M+dH8hbX+86FBWrdqurL6a3EBNx
 UJD3iOy09SzWgKSVQc18fTop5DM/yC1/DU2v7xFECrjFgJBKjY9dWeWnrpBz6Hgx24UHGGz
 m6Yf1klZNJmcSdXy0tQlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CE02gEmrzPw=;P1hDF+hlgSCPtQGLWF0A7lEYrG8
 FSeoBhJMTES3Yc+jWJ2Kvq2TWby8fC7gL7a+r252q17DrCUaXM0LtwJMyT5+xSPc8rV2xhqxR
 d7a4xkcV1uE1CWIS5LoN9vH+P6GEr0fLxXvAPhQT2lZontmtIbgryKocls9vTnAIGuBWo27jM
 ++Qxwn/GWlVelrLJogMmWrIHnRNUZ+DGBfwKFrCQsM/sTU2pL/zjdTGyvoOuFp3046aYJbxM8
 YTXWIHJWXOXJsq4jLQ1TiKAjsLIkEwnRM+ORwytUU0ci13xk6Bp1skBBzO13PMrmLSlJmfZkS
 CZk53K9S+28dYPoN87oxyWRgyHrISnwPpN3fXjTrpmy5hubDQPEbniq79F2GURG3o7z2mL0hS
 TCdG2zVFtdhSNclCQxEZv9YVtI3qtbQX97zfzyU8TayfeZCvl7BpIgErlwH0v84WGiPXKY+TG
 0cy9fa3RrhCoi2/qzvmiHObXAy7ufKRmQVcdKDotcO3WoZ6loTshfEJIz6mp06bQZVQ5Tuvel
 BcDuBynzghqW02Tg+CmxWlFs23Gb2gm9/BX1v09kk5enNeMqA/Ml6vkHZTTIBHU4xE0AFqOCI
 qLtJB7ItDF9JVArGx/digvT6mGXeXcJe5YzOZBJ8Iao7ORbjHrMgPSqA//yJpVLAGjo4bl5h5
 bJrAm0MH1ZvI5aKA4n7IcjXg/b0bELt2k4SYIyCIwl3eN3iFDzh6KGH3JwdzM0g1nJTDBRLFM
 AByBwpIr/zUoGTgL8hZKGv5TTc6wsUXd2XpfGxG+Epz/V+up8729nGpyzSy1N3cwd5L0PJUA/
 qm/SOBr2Plf23Xv7yruBzV/gI8VMVLEhRjtv/NO5W6KPGfdfi8vc6Ry9EXIT03K/7g7lVv8lc
 jfOFpLfNW1euj8Xm81hxmwPK4Z5bQqRtP1JKas0dJ+CEgUqgbYA6gT9uDlS4EOokpvzBLznvf
 hADDjeuKx40AOGRSZrjr76tnrhzA97STduwf0aYcJzaKc2PLQuQ/gEzjA9HPaOqJSuCwagPfj
 /2AtFN2TY5q4nlyHTxXQSZQx3kMmiy6SVA29eITt9AeG4oq3S6IxGXv9zkOJDf58YMVs/iE5M
 CBIx2BeZgQLPm3myoiKss1lARZNosfk6ds2qITPd/YfcjdzaWEc9kZ7833RAQbG3amosHt4+5
 XcZ4IZTBhM7dtUL4KdB7x+bRrSFrHNJtPy86bdIHHGqaMnDTfxafKiKccCF0wabhmSk0n3HJa
 DtCxqM5VIeyJ7i5ZZ/8/yAW1UBvjjKv81S2oBQNDuYyQxFzDb8MlnFJ3LTCtxrmJg+of2Z8lB
 9Ib0PRbdw4rFeXDbdcMXs+EUvJ8EieZ+A1c/jiQtv4jLQI=

Similar to `access_process_vm` but specific to strings.
Also chunks reads by page and utilizes `strscpy`
for handling null termination.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/mm.h |   3 ++
 mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  73 +++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

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
index 539c0f7c6d54..e9d8584a7f56 100644
=2D-- a/mm/memory.c
+++ b/mm/memory.c
@@ -6803,6 +6803,125 @@ int access_process_vm(struct task_struct *tsk, uns=
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
index baa79abdaf03..ec3bfcb35215 100644
=2D-- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1708,6 +1708,79 @@ int access_process_vm(struct task_struct *tsk, unsi=
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


