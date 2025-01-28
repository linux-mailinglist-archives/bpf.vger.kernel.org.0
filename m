Return-Path: <bpf+bounces-49988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F97A21492
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 23:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AAB3A35C9
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BA1DF997;
	Tue, 28 Jan 2025 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="mveKIqSA"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C872219CC28
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104256; cv=none; b=R84Ufclc111jQd4i6bKS1sX5hAWbVb/MWZenxm4PwNcKxVIjfTtwRIQkJUim/WmvAqsg1ZhUYTir2XHAVhjXO6J9jhYVy1dnhhGn55kIOBXCXYNrmEKgwsHeUal0O0xs9KdhYouhL+M1LYWqzcVBcN3lnjWkYukalIiKBCPom3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104256; c=relaxed/simple;
	bh=syk4TdWsVE1D54ZUzruiXiqzzC9iCHOq3m/a75ITobc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfJTRFY0e/GDqo26TQHuAasuZaXJHLUUk7wl66s0EZc31iQuOeTsfZZZ+col+SsAi5z0wrHBJF2rJItVN1NA8MsMaNS8IdsXCk+h9Tx45ZLk2RGe/Y0TG42/zI8XJ/G9fmy/2gQRPc39jxnTK46Ef9t3IX1tAGS4u66yUJQqHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=mveKIqSA; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1738104249; x=1738709049; i=linux@jordanrome.com;
	bh=QRGkvncHhT4bF8p4emcNzTedGy4hijyVy88NPlXMXDw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mveKIqSAeXGSCvj82ClEFiCXgtX/+9Ofg8MPt5WQYjrE90Emhh1llJY7Qja+YzMi
	 GldWW/Kwt7v47bUgKXYgDL+TMdFJdfWHwlGKqJd3clf9zKVDVKBpNgEQ1/ICUiOVE
	 MY6Q6kzdgAFjS7YiYoBNSY/G3NQkBgvT/FzJtDoYoMNx1F1Np1Bhq3q7oUGz8JGm3
	 N+UDHheumeE8Nzkr7SJzJUA5cOoFfMzmFCK7xbKhZmnAZy94c8ZR1nM3x3nRLumea
	 7D6l1tc2JlG3nTVugNBaP7+syuYkrt8edAbxa29FLz9DucWxzRubPrL7UtOIbXLDM
	 S3mQ9YXzF4W7N1V4HQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.9]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M2349-1tJRcR2j8t-014KM1; Tue, 28 Jan
 2025 23:44:08 +0100
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
Subject: [bpf-next v6 1/3] mm: add copy_remote_vm_str
Date: Tue, 28 Jan 2025 14:43:50 -0800
Message-ID: <20250128224352.3808460-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ubzDyLLWS+xG74qCEuoWDefp+b9Z5apMh2VD+lUkxRhjhueh/zZ
 iPJyTViXfuRr3rNVDDyu/kllF8hZ3jXLWQiFYVJ2MVqtciXl0/T+07EiNt8EryJgJj+C9V8
 +DIvoQb1C/5Ma0kW7R4lhpNWvJxJZOZv2/cYMTGWUxO17gDfjdvYVtStEEmWw/kHV0A6MIE
 wrplXUr8SvxVodW+/DT5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l5Al3IdDLUg=;+WvLmoKlwkVs0B6hB0P5cYDkcIg
 O4AzhMBo0WZWeFVL+hmkBYMIyMBjyxyltQ3pQ4ZQ7qnMEJ9LG0mowLNWJTva2WDKmlrX6ISFi
 BYUv+ZZQTSLu26SspQsqkS3G0kFmGbDRY0eGTxayZsUQ2gF7E0JR+VjradxsLbObeHRZKKYnv
 UY5IMC24vpj/RAGx5n+vW4vbnJ2iskIo7KUJWFR7z/5e1zyMBjk3MdTL2tDNzumuiAjrhEtMk
 nPrhVpiUJofEbaVMs1aDe9SOcIj0o+udzFlo4rjK8swiuBOUP3ZTYZbpQFhD+WYpqQrrxmU77
 kn+CRZ8y3x6vIpNIMFetxDvxazxRp9cXOO34dg8mbydJPMluylpt/jyumEHRxYxW4OfeNpJF+
 Xyk/lG3jdIxqKRVRPgNUGvukHDG0fHoVlyHeg12ro6UNB1FknsRkmyOlE7xQWEwtpkBnKLOvB
 gYA53T2J0SQQQeai9WzHoAP3zVd+49MSdQWyP57nLNgQIuo+ncENTDLdsNptTv/T3vsZkecA2
 XkR+NBHQVPZgSQ2Xl6PW4YHQIvcxomtX56TF+xX1HzDgA8ex3Io71kgkqq1gB4EY3Ea7IjB70
 EWbCc+W2NHIeH6V5yeQSL6Kp2UcOlFM8hf24ylSltc1SnGaSU203BnAroCjhD/5j4sax5Vht3
 FwKgswMFJhcX+pV5bVZoMKFJzfCWsyi2Mj5zsb0hcl91aa/i9mJZFKoVYOQoMiGCz2i/GXZdH
 CzfhkHvlR71O1tGsdt3uRCzRUVjien9W2B08N+IODp9yJvUPAKkd0KAQGFmjIChASGyPwltOZ
 tGRTjHbM2gvwwCj6bPdEbUMV300f4JbolsHMWh/4BtzH/hXHajI7mRlBS6jFV/mWu2n44wYUX
 g6wbhkRTGLCtOzpolgKw8cKs+AVHyULF94raEOs63ytLXQvhCkirLTDb6aIHNRMKsEKtCl5Cp
 ywS16hHPSKwp3kPTWg84oDOKawldrfwTBoTiwRWFlSNFsczOquEKC+Z+scgrXnvmPW3rC7hgR
 uLeZBYvlH57a6Veysw/oj45aBoiWeO2SJsqx17Iynavx46OZxKmFcTcu20/wJx8adAo6ubKKq
 2q9ZkCl4LXedBkNcYK2FOxH1xifEV2C5QAIrYBRSH7jYCLeq4L4KqSlyTbFD+KACH5Zq+6PeU
 Iq87eMNbzEK/SXGbXZmz5Iq6aPHQXTNFCikfI//u6RvYLDEc1a8/1/4QKRqJ0nR9ewYeMtL+H
 eDe+0/ANEFTF1zYa3rIPGmXOygb33YNyPA==

Similar to `access_process_vm` but specific to strings.
Also chunks reads by page and utilizes `strscpy`
for handling null termination.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/mm.h |   3 ++
 mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  74 ++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

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
index 398c031be9ba..7f6e74a99984 100644
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
+	((char *)buf)[0] =3D '\0';
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
+			((char *)buf)[0] =3D '\0';
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
+		if (retval < 0) {
+			buf +=3D (bytes - 1);
+			/*
+			 * Because strscpy always NUL terminates we need to
+			 * copy the last byte in the page if we are going to
+			 * load more pages
+			 */
+			if (bytes !=3D len) {
+				addr +=3D (bytes - 1);
+				copy_from_user_page(vma, page, addr, buf,
+						maddr + (PAGE_SIZE - 1), 1);
+
+				buf +=3D 1;
+				addr +=3D 1;
+			}
+			len -=3D bytes;
+		}
+
+		unmap_and_put_page(page, maddr);
+
+		if (retval >=3D 0) {
+			/* Found the end of the string */
+			buf +=3D retval;
+			goto out;
+		}
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
+		((char *)buf)[0] =3D '\0';
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
index 9cb6e99215e2..4d83d0813eb8 100644
=2D-- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1701,6 +1701,80 @@ int access_process_vm(struct task_struct *tsk, unsi=
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
+	uint64_t tmp;
+	struct vm_area_struct *vma;
+
+	int ret =3D -EFAULT;
+
+	((char *)buf)[0] =3D '\0';
+
+	if (mmap_read_lock_killable(mm))
+		return ret;
+
+	/* the access must start within one of the target process's mappings */
+	vma =3D find_vma(mm, addr);
+	if (!vma)
+		goto out;
+
+	if (check_add_overflow(addr, len, &tmp))
+		goto out;
+	/* don't overrun this mapping */
+	if (tmp >=3D vma->vm_end)
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
+		((char *)buf)[0] =3D '\0';
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


