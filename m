Return-Path: <bpf+bounces-49822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3482A1C7B8
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 13:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5320F1887537
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EB51547D2;
	Sun, 26 Jan 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="byehsN/6"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3F17E
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737895356; cv=none; b=GbQ17kUgCH820jyLGjyll+pDH27fBNwEPwxabYTjtjfi3+dYEDxYrEnr730mqbpzyDrr3OZ4Jg2evn+r1AxbIxs23sdCIlmLfY2XmsAydZlCp4oNsT7bb9dYWO4kWnA0hLhfiuLcCwmCSJ10tVTasnObtRBVINM5nLq9NyVsNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737895356; c=relaxed/simple;
	bh=XUOTX3CB2TIdtcBcOAOEc0OuccLBrnl1ceC7eTfADao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCPVD8yccQsVjkMIAX6rsA1P/s2VMpbrf9b2AZ7CYsFtyWwwnegi2y7hit1r28wKyRo7xzATQJBc3GQIJaERBX2z6xJPBDQFeqIDpUaEGQzIOcntlpvFS6iC6tKc1xZjHYNzjbJ+Nu/Si59G2Y67dZFuFge4p/nPm4xE61UGpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=byehsN/6; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737895312; x=1738500112; i=linux@jordanrome.com;
	bh=+Vlu2jdNpbATIazxCRDh42Sp6PcgYXmIQ/5U9nvK1ig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=byehsN/6FJ8TVKECgbxyykRUWNnqHPUcWxUXmwLS8mFW/0tF4VcvAfab4Uf8tWi5
	 0AWKziqWBRggny1+rQh1X2V7XYKoVoPgLyD5erBMBFt0kJxdrxdj+gayeQs+m02E4
	 bb6qVmfzQRuB2DwSxqnAlGteI1VpoEjIEOwGIj/h0Hga6caZODA7w/MukQDD640En
	 WXW/d3qxUZ8SwAm6aexUwbkgJoa2ElZq9VFxFC40NO4egxx2qQQMTGsNkBiJrPoXw
	 uyvk7v7Bowc9L58nIOvKdX4yU4q8gW73qioEziNxJNtx1H7yVicyFYY6hT00Ax/eT
	 oit8D9oKiwprZV6Rug==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.115]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MGycx-1tg8hP1Lj1-009kvf; Sun, 26 Jan
 2025 13:41:52 +0100
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
Subject: [bpf-next v4 1/3] mm: add copy_remote_vm_str
Date: Sun, 26 Jan 2025 04:41:45 -0800
Message-ID: <20250126124147.3154108-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JmcUMYCtNw/iPiwqR2nutfXGPdekms12sq6yY4Crs9jwIwO2HDl
 X6ZuPldqSdCmp7pVzFg6kOC5CSJonXjwQG5Av5Y1wDJS4Zax2gf+rNd0JZ8KtUpHRUSsVEa
 CGp8ORt36SKXYs3yo6pK7vS7kP6XTYM5kL96TRiZNNkNwrl+tKDHI+yazE1lRblmhxqvATi
 DpQ3e++ie306dMmgizc8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0oDabORroaU=;qGnI7yD+GxvMza7knm2o+Fqm31s
 RR5msbwyN3CsdI7Yq6ffaWIS3Q4wPSPqtravPo0PREzvr74cluZZl9RTPY5EA1hX7GoLTxgwN
 E98PvyzATlkq++uz520Lg4HpaB25OAg8PjYsSo9d15eK27Gj/1DcTyBllhAdI13r1ZBBaOQvC
 yMWq8ILmDEbb0JPB6DJtXxzD8+HdBjJjgnPxM5bgJMm2cZ1+DT2UcU/Zptf2jlKFOMudqAlYd
 j/iDSY6sTu41fcm0s9cCngZDnyoRB9HL9OHMDa7Wdgi6rkmctnH9lMnag4TJEWrLTYMSzjnWU
 4O1LsqwqucKkGxl2I03IrXLm4V2krqLAa0LmPiJbGY1iIG6IyHw+s2+fSKFBib3YKviEw4OxH
 jQFRADEhwSxI/aLXReT+jmo9uMqJhM+G0xxf0sMc99KS+SY1cs64pryWrfJHhH+pqpLxA9a3D
 /8FXP3gpDwUP5ZZCE6/FEEKS6oMDxV1GVXGKbuYB8kUl7TXxIJ9ySUBjbC0sq/DucyBRaoXVq
 ORfH8ghZZqVVWXnC9MIZVp1D96vcVry/TnH7GzIApsGvJtoBueasmaoDlYsBfjx02ejpsZ1rl
 K4qxSfwNE0bqfCthI2Lg5MPoDoZEWAJ+7L0/VqTyymMybXzuuGpuH6WllPKPMIRObXFL9CIQV
 jI7OK1gdRCTfk4OeHVZEK/X9buFKzSPdljMsim5HbMdltSmqFdLzirUGNuKV4iNAlI2CO7KTT
 o0ZqOARCZSOxiChQCG5BeRt7lxHekQ6fyhzzUHCEEJ1+U0CBI/7dyBDgnN+CCRrwRiJhMqdcW
 RUefUka5Ger8gjyQZ2vk0SMkqgL27eio/CPqOIMPIgaCnkQOrKeF/pXbCiKHR33g8ChitPD+l
 OB8BVAJQr/qjvXiZgtoUX6116DMWkrNiQObqYVhMMBgAOxaUtubjVGv52BMLGv+Ak8Mp7DJCY
 pg/BvCnL3Yhcfebz5utRDe91XLpfNtAHPdFtbpjcnrMgTJfcG/uH08Y2NsHgGSXFZGjjNveZ5
 lZ8gb+UKWFhzHzgJYY1BSK+3qTG69kvzz3wbkYIkIK6H1cj0Tlh8PjlWVNsu53NSIzhXreIjG
 Iw1dQo3N0Om/trPipIxCs8Wz3wazU1WfqyxP6vV0ijap7Z1f0OOwIgzmr7G2tY3RLMWImuiLt
 pBU52f2efgWhRIGWt3ebBaukcY48DB5meqtQ0Fe1TZKOcyu3yNeJUfRrwUUXsR0DNHbDtrkHe
 uRNDwiERwFq/NdK6ohtT8ykj5/OK2c+k8Q==

Similar to `access_process_vm` but specific to strings.
Also chunks reads by page and utilizes `strscpy`
for handling null termination.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/mm.h |   3 ++
 mm/memory.c        | 118 +++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  66 +++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

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
index 9cb6e99215e2..480ddf50dec1 100644
=2D-- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1701,6 +1701,72 @@ int access_process_vm(struct task_struct *tsk, unsi=
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


