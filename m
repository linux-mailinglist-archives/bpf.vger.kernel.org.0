Return-Path: <bpf+bounces-49692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62BA1BC31
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A23C1883C16
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE220E004;
	Fri, 24 Jan 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="XAGxtQfm"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6F1CEE8E
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743593; cv=none; b=QI7OrIpVEQOSljitO/3IeG1QYUSNBlLZFU+x1fkgfJzwXhD1fHeL3M4kR469/3bmrHHE9keuMOuJROZltfEUQp0iHrtCoKQHzlJKq3AaIjLhuk0bXd6AoNDQsxm435ZpiwbU6HX0TnhvF3ZYDPibXwXCJM6J8OEPKz1o0TEgwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743593; c=relaxed/simple;
	bh=fEZYj59eSkdv8nLG6sXuX8A+LRPb1BRwGXlBkI5CXN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIVbllwf1hUyPA2W5jVfZ4GWJK3CYvxX/rdKsV5zUQ+Poer2ygABWeve0KuTra+IXtqmhB8hGwLzhL1YDYiLgjQ8pn+FZURb5kp2xxVHvdB7rJb/2ELAmkp7PYucMSlguNpOytyCsn2+SJ9Zm9dXhHV4/AIf6PAGcMkg/bymZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=XAGxtQfm; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737743589; x=1738348389; i=linux@jordanrome.com;
	bh=vN1sWSdQGaxq1WTOtCMw7Lms9Q+CJ/CADJP+cD3MASg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XAGxtQfmSln+YVeISGZBzIEf/+HTaoY+RXxwEv+T0WTPxCrM4j7gdsqKTw80oMwn
	 qEUv+vOHScb15awfwS8492y61q6eyAnjEDIxgmg1dbIBaQv1XkcFflLUwrIqP5Z2G
	 v4v2Vd34eW/iALnAWpfqXfIQ4L/smGPrK2+daO8zUBB6r0S9CpxfdoFG3sYxfMWVD
	 ucnFAFWKiK2nk2nCsQvEWTunH4UD78Tu6A1n37kYWGlELb+aniF/gZJDdYIabeEXj
	 vUeORyXG0iqgEkgJyZnf2UmLq486CViqi4mJmgBu+WIl+xWF8/rp4TJNDW3ZLrkoL
	 UMxH/orWLRW9BmYn9Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.25]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LcRm4-1tBRK70mvO-00l7eS; Fri, 24 Jan
 2025 19:33:09 +0100
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
Subject: [bpf-next v3 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Fri, 24 Jan 2025 10:33:02 -0800
Message-ID: <20250124183303.2019147-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A3DOnrZMBegsQsDQ07SD4gwqnYeAUC7z3LkazmDkP/9nz+99BU2
 s/Dlf9iMtEhxUl7aRpzeB9lsWzzmkX+ycQbIjG6WqMtX+SWrIhflmLH2/5d0DwbCiWuYaOQ
 WS1AluKlWid823HDt5BQHi+UpQ/EHqvdMBeeRhzHgQQmBkHpBOfrZiXfxtQiG8PGLWx8MHC
 JjPI+FgtxErW8SlLYmvbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x6k/9Ven3Rg=;ytk0ZHTMf+L6t5x4vPikYFk/88+
 D8Ov2R9KgEkjqKbscTL/ppcnHDR26YGsSiFts5SdHFiRRm0Fsolajg9yKfPCDRthKlFxraVBh
 bWi8X03MlWvIGil+rtUaIRv1y+/iC61/81TOi1KrglURmj46/120TCOqLz/h9uaYW3ALAkSOQ
 I5P7SYiu1WfII/pk0Uaaj1HOum3rCZB5+oTl0dcb9vIdqDlNOkENvOxdmI+bKvWMbyDsW4c8T
 x5OAMXgxOtKMwwDlxsqpsUuJOmkor8qA+/pyT5hC/+t8zrJHJTBZm+MAV1RyHMAr+5ZF3418/
 hYEkQRPK7Trbhcsy7uDiukcR/qA4H79+BGrzSqi1X3klx1e9aHjFlOIv53NuIlEFwLJnWVCz/
 F5fkcXMBLFF52t/j6/sNhdCb+rehRimeTgmOpUH0JdMlZoUg2W5U+INI+FlZ2jia0/cp8+JcV
 bmUIUrwCYoTk7t7bpd2sMfOqShL8OIDyCPAhXeY6K9Gdrxcln3YH9tVvmhrynnZ38rr1zqHXJ
 X6fiftbH5AU24t9mPhdRNEL2cxiuDuQzcEo1MFv5haZ4nvSmk1KjQQvS3FuK9HrT5nUbgowEc
 aY3fAe4q7XPSm9mbxIZcjLurp8cMEZPCHgXeS838kGGznQbZzpijrx/iDOr/V+9pv21lYW76K
 RfjZ3ikhHKoZBN79F1EESIJEKm6l9G3rJHG2eljFvg7bUjvODk7Jfz95PJllxiUkRvuv/bwEd
 XAtwpYHGWv+xy1RCG4/zI2Ofv7sjeM7sVHXmPUP4eZD/tLSq68Cjk8wWwY7rpZcx0swYryLtt
 crUG12kC63+gYw8iCQMCZbTX3bpKa+13pqdYCPcLqaWoNBDVgP6cdQNqkjMwlOJNg+fBmnfdb
 UApUpqhWRXVblwZ/X+M9NQLVCt53RGrheF8sCTkL0IMNuapBVtukXSxTta7rhw3q33AqSqa5J
 +KJgg+TOQJsjHCBBJ7USUgRcotUvtONXyhYFXTdmFbbyuv59Z4aXgdAbKxDW3uqaplTn/6Wai
 3M2drKTgHqzNoAuoHHpYa5a9q16jSNZrJOfWfOZ6XpDT/CxSwqduSysq+UnWzC/18UGDxwevm
 CjGOf9n5iVlbvodn5jd6do00SkKinNumR6YnxnakXnaSvtGwR3sFMD55czcGE20ctGZNDSM0j
 pexo5TnvynaxEINYSsIqhndk9jxYpT3CI0GWl3yDGXYarg7y27MuYScC19h3n2GtX1ztYgP1d
 zXuOsUpmufpEH1G6OwCcyBqdb8SKl9skjg==

This new kfunc will be able to copy a string
from another process's/task's address space.
This is similar to `bpf_copy_from_user_str`
but accepts a `struct task_struct*` argument.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 kernel/bpf/helpers.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce162427a..c26fabf97afd 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3082,6 +3082,56 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lon=
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
+ * Copies a NULL-terminated string from a task's address space to *dst* b=
uffer.
+ * If user string is too long this will still ensure zero termination in =
the
+ * dst buffer unless buffer size is 0.
+ *
+ * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on succes=
s and
+ * memset all of @dst on failure.
+ *
+ * Return: The number of copied bytes on success, including the NULL-term=
inator.
+ * A negative error code on failure.
+ */
+__bpf_kfunc int bpf_copy_from_user_task_str(void *dst,
+					    u32 dst__sz,
+					    const void __user *unsafe_ptr__ign,
+					    struct task_struct *tsk,
+					    u64 flags)
+{
+	int ret =3D 0;
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+	ret =3D copy_remote_vm_str(tsk, (unsigned long)unsafe_ptr__ign, dst, dst=
__sz, 0);
+
+	if (ret <=3D 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+		return ret ?: -EINVAL;
+	}
+
+	if (ret < dst__sz) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst + ret, 0, dst__sz - ret);
+		return ret + 1;
+	}
+
+	return ret;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3174,6 +3224,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL |=
 KF_SLEEPABLE)
=2D-
2.43.5


