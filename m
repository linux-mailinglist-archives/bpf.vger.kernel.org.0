Return-Path: <bpf+bounces-33278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34B91AD87
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F098FB2998D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33319B3DC;
	Thu, 27 Jun 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pifzznZr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AB19A28C;
	Thu, 27 Jun 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508154; cv=none; b=taKGAgsmastrIG+glzntlAnYaQv0MutXvPEhCA3Izvl7rfiOUUQR77229sGzCjenJUQGjcvOUyQrBK0peJAFVgr1Ihu/P1RjQFcLjkvAWKzkIUztzrGawTsBpPYQ8Jy3RLmpa1nFVaS7GuhMDB2o0linhGKLyaxLDQ6IKla3uvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508154; c=relaxed/simple;
	bh=TfcaDQQTdRLothd0FRVJK6mCUHkge2r3AFoLq6I1TMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/BqX1PT/EE5MCLUG80j/kh/4IEFbmxu/9GRcOp8dp1gTRdQRFbFdMgyINlBPncSlzBElW7Y3PuvFeDZ6bOUR7zxCoqCD59X8qHyebma2s22oll4BT4Iq1i/uwi6V4lFQoRw/DM4/EzZKO+zVwxhZP9zX1VPE+xNx2w5RZ7zUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pifzznZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6313FC2BD10;
	Thu, 27 Jun 2024 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508153;
	bh=TfcaDQQTdRLothd0FRVJK6mCUHkge2r3AFoLq6I1TMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pifzznZrR7d2mHil0ZsDNUjdyAtDUfNT8iHlRgb5WpOzvxiiIN5gEWe/sLAsNeS9Q
	 3JlLJEEUQFeOiKu2UeHqkSwO228T5OvWAIdya2IbVVt6DqAAbr4cCrsfmC+5vUrMnt
	 /+pWc2mJx4YLQ1Y4jjiG7HuspbUxhOLX4yejWUtYCxWErZIjSTtRB5w/3y0bEcVoSh
	 ELHXf2qD+MSJSXRuu0dYiKJGjG9HgMXC991GBaClgKL8a4xT1yto/86DFAe0hSwtqt
	 3ldeJiQtjfRR+FOI4/3DebO392IATQ+yXMKEtaw7eJ+6I6f+QPT+HCEYuli2kLEwcS
	 fe5N7keYk1IUQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
Date: Thu, 27 Jun 2024 10:08:55 -0700
Message-ID: <20240627170900.1672542-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627170900.1672542-1-andrii@kernel.org>
References: <20240627170900.1672542-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The need to get ELF build ID reliably is an important aspect when
dealing with profiling and stack trace symbolization, and
/proc/<pid>/maps textual representation doesn't help with this.

To get backing file's ELF build ID, application has to first resolve
VMA, then use it's start/end address range to follow a special
/proc/<pid>/map_files/<start>-<end> symlink to open the ELF file (this
is necessary because backing file might have been removed from the disk
or was already replaced with another binary in the same file path.

Such approach, beyond just adding complexity of having to do a bunch of
extra work, has extra security implications. Because application opens
underlying ELF file and needs read access to its entire contents (as far
as kernel is concerned), kernel puts additional capable() checks on
following /proc/<pid>/map_files/<start>-<end> symlink. And that makes
sense in general.

But in the case of build ID, profiler/symbolizer doesn't need the
contents of ELF file, per se. It's only build ID that is of interest,
and ELF build ID itself doesn't provide any sensitive information.

So this patch adds a way to request backing file's ELF build ID along
the rest of VMA information in the same API. User has control over
whether this piece of information is requested or not by either setting
build_id_size field to zero or non-zero maximum buffer size they
provided through build_id_addr field (which encodes user pointer as
__u64 field). This is a completely optional piece of information, and so
has no performance implications for user cases that don't care about
build ID, while improving performance and simplifying the setup for
those application that do need it.

Kernel already implements build ID fetching, which is used from BPF
subsystem. We are reusing this code here, but plan a follow up changes
to make it work better under more relaxed assumption (compared to what
existing code assumes) of being called from user process context, in
which page faults are allowed. BPF-specific implementation currently
bails out if necessary part of ELF file is not paged in, all due to
extra BPF-specific restrictions (like the need to fetch build ID in
restrictive contexts such as NMI handler).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c      | 25 ++++++++++++++++++++++++-
 include/uapi/linux/fs.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 674405b99d0d..32bef3eeab7f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -22,6 +22,7 @@
 #include <linux/pkeys.h>
 #include <linux/minmax.h>
 #include <linux/overflow.h>
+#include <linux/buildid.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -445,6 +446,7 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
 	addr = vma->vm_end;
 	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
 		goto next_vma;
+
 no_vma:
 	return ERR_PTR(-ENOENT);
 }
@@ -455,7 +457,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	const char *name = NULL;
-	char *name_buf = NULL;
+	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
 	int err;
 
@@ -477,6 +479,8 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	/* either both buffer address and size are set, or both should be zero */
 	if (!!karg.vma_name_size != !!karg.vma_name_addr)
 		return -EINVAL;
+	if (!!karg.build_id_size != !!karg.build_id_addr)
+		return -EINVAL;
 
 	mm = priv->mm;
 	if (!mm || !mmget_not_zero(mm))
@@ -539,6 +543,21 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 		}
 	}
 
+	if (karg.build_id_size) {
+		__u32 build_id_sz;
+
+		err = build_id_parse(vma, build_id_buf, &build_id_sz);
+		if (err) {
+			karg.build_id_size = 0;
+		} else {
+			if (karg.build_id_size < build_id_sz) {
+				err = -ENAMETOOLONG;
+				goto out;
+			}
+			karg.build_id_size = build_id_sz;
+		}
+	}
+
 	if (karg.vma_name_size) {
 		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
 		const struct path *path;
@@ -583,6 +602,10 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 	kfree(name_buf);
 
+	if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
+					       build_id_buf, karg.build_id_size))
+		return -EFAULT;
+
 	if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
 		return -EFAULT;
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 5d440f9b5d92..2a4a5f50c98e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -511,6 +511,26 @@ struct procmap_query {
 	 * If set to zero, vma_name_addr should be set to zero as well
 	 */
 	__u32 vma_name_size;		/* in/out */
+	/*
+	 * If set to non-zero value, signals the request to extract and return
+	 * VMA's backing file's build ID, if the backing file is an ELF file
+	 * and it contains embedded build ID.
+	 *
+	 * Kernel will set this field to zero, if VMA has no backing file,
+	 * backing file is not an ELF file, or ELF file has no build ID
+	 * embedded.
+	 *
+	 * Build ID is a binary value (not a string). Kernel will set
+	 * build_id_size field to exact number of bytes used for build ID.
+	 * If build ID is requested and present, but needs more bytes than
+	 * user-supplied maximum buffer size (see build_id_addr field below),
+	 * -E2BIG error will be returned.
+	 *
+	 * If this field is set to non-zero value, build_id_addr should point
+	 * to valid user space memory buffer of at least build_id_size bytes.
+	 * If set to zero, build_id_addr should be set to zero as well
+	 */
+	__u32 build_id_size;		/* in/out */
 	/*
 	 * User-supplied address of a buffer of at least vma_name_size bytes
 	 * for kernel to fill with matched VMA's name (see vma_name_size field
@@ -519,6 +539,14 @@ struct procmap_query {
 	 * Should be set to zero if VMA name should not be returned.
 	 */
 	__u64 vma_name_addr;		/* in */
+	/*
+	 * User-supplied address of a buffer of at least build_id_size bytes
+	 * for kernel to fill with matched VMA's ELF build ID, if available
+	 * (see build_id_size field description above for details).
+	 *
+	 * Should be set to zero if build ID should not be returned.
+	 */
+	__u64 build_id_addr;		/* in */
 };
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.43.0


