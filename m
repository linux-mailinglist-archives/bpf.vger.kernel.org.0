Return-Path: <bpf+bounces-51418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD74A346E4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92CC3B5563
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E47E14AD2D;
	Thu, 13 Feb 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="CwR/Zc7z"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE91411DE
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460110; cv=none; b=PMHagqxVDeNj1OJertlUG2FviLPLPfTA5hP56F07sbiaD8L8l2jzEM66dL8pT0KnCSui/5sW6RBpYdG45K3D2JUJPK2hrzBesLb0liOXIaA7QZk7kpZeG+flEuA6Cgd7etYzky4sq/viabP0U5f5qFeLM2HLbMkISGc3p3ZEzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460110; c=relaxed/simple;
	bh=yfxROexsgY7ktRVyxOd10OXp2cS+inHpzuy9B75v+d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sm+6rx9p/Z63mepiEARccSEAh2cIndF/QK70u3TJYwV4vPyXUgi8PVKvniGTEvrsR1/h7qZO94c5OzJGHdGmucFewu4k+yUU8o084dvrt+0fvBXrajMEeE1K9WeuZ55/v8ZHdboIo21X8ICz7wYmWXbIuVaH/JA/aIwpipAAo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=CwR/Zc7z; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1739460097; x=1740064897; i=linux@jordanrome.com;
	bh=QaM92VVJ8sVRDEhsj6U41D+q2njMPqo34UDqJs8UQDM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CwR/Zc7zCuTY4OsXyO6Qmd74qGjuvjIS1OE0pRFormT09eJ4CxF+EiqJjfRs8OG/
	 nKA8n9gaIpXpndrne0Wk/vN3FGF3SK3SdjlTIbJq9umQYo8EwIKTEsRqVJlcYLZtL
	 MfYeiXJhNt7vGvz0HVneNUowxpvkY/GwI98IlhGcOCSAKEBXb/JGx16NSoCaggyOk
	 6oHck8x4w5A8Yb0FCt98qyqLfQG+E1inzXFsYj4COHsi/tZlo23eAVqjyoAwLslhB
	 QJDZ2MSQSlohfaanP/C+LpuWUg2H5354T5cUDc+9iXkoGfDNV4+7S29tuueqYcBTO
	 ccT15K6cD7soGrHstA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.115]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MH1qm-1tdhEB1qtO-00DXUA; Thu, 13 Feb
 2025 16:21:37 +0100
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
Subject: [bpf-next v8 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Thu, 13 Feb 2025 07:21:24 -0800
Message-ID: <20250213152125.1837400-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250213152125.1837400-1-linux@jordanrome.com>
References: <20250213152125.1837400-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M2HqTh52VzVoW28hZaqWA8+HYrSAYL9Nms0h4Rw5isAfIEJewQ1
 twyuDCDsOcjnxNjxwbS9qKv/fJhN7ZDKDK2BJjFIyaIk2tgWwJdDxaIpFxUVZa3FH9CcQjh
 DQQ3eS6f6v9yds5bNQ2yO2mUtp/zc9gpi8KpG/TOcd5EaXnvIUwcr4aXwi4SQYtZD45Kwpt
 /QVaH9FcwHfNLezznwm9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XFeo8jdd6/k=;jZRp5DXm0QPSSXAQxaDXmup3ZT0
 zR+/WroUAQFWUZCBDkVgG/V2UASfi8OoDYhzGkS89SVYOWfD0xltc0B5XkK9TXS/lRDRy6Azi
 d6/6O0yjD9XkWd/ZDJhVK0UuyM8MVolFgm/opRcqVBbCafACwiriTEvobZAYvxGMAgu2tvVHb
 iGOHV5cDB+1EINtc/Numz+kf4qFr9tSgL2ieceUJ2NeLZEFoDsV6panrVEsjcfXMI+maPd8Nk
 ohg4ygLEDE7MWuVpgQCrwxwXiCPc8TYJGzvjaDv0wVyb3bOTDFkZrxyTBL6Z1evwjUAcqB/EJ
 U0LvKowLd7lJ8YcOADqYf9lTmEszlnV6pBGboNZ0A55ElQpxjA5mPOu+vTZNVopspo3YLmRMa
 Wz8RlzOjlDXyTlRxglb3hNJaEHBPOAM+Q2j+ZQrGOZmEifmq5GnwAJ+6KYtrLeWPuhQJKI/ve
 fGgSVS50GyrpsTgQrZ5r9CzkUtDCK/J2pctHqRwdInw8Q5X0Tf5MVVgFV/2iCpzBxWms0UgNv
 yG+ybmgcV3pFRyRR4rbROm/VS5MQk78eqHzyDWlaB0H1+XxaLEAVCjht9ZK9mzGhwGEaV+JBr
 mlXO76Lroz3roGJf2TucOPu/ofHoCAldH4Yz7q8wRE7eN79t15h12Ox9AgqJ41MtYDZEIjIvD
 Bg1Xe/Mcqh8hDsYId7c9+sXTQ3kSRpLryCZ++8kdj1d4lldbTjZvpfU1apX6qhq0m3ycCdgZc
 NVNJj7qDXm0RwwAL0Wf/hZarWP8IyzAxrl0JMFoykAcnwjZhAiGEjv7FVcIph4KmmPnC//5AC
 k2IqMvXnTpREpcPu+rhu78eW1UAkv/fs3FmDuHDKJzYmbsvUcr26gPS+y01jf7F1GX37v7tPn
 41RgAHATAPKRQTXDAQmNGCL2dj0VGovS3l7q+ibKBFFRdQP5xy9vGbT9/jrw56um6XwyhBv9Z
 NnHjFml9xzg4HSaEOk9r5EftwPCSUHFTS8hH0gJvuUdBQxa+vIDBOjIZtvl+hMNQgfEXX50UX
 AHm+YY8LMZMf3p7cMQW4o8YS6UvxphNXNWLWDKT26+AcP27V64Kc87tJFjFFya9QacsQmwhmJ
 zAWE6sAHdtZ1+UCxigmvTsQgqmGee5Fmdn6C4dacWuDvheioCAmfp7urnGJVPtAaZTVMFCv/4
 fFKIq1RgGJZ7rLPUOJvXXqDpZ8ow0tt31xXuun+pYQcQBUv4aYJbF98uB+AaqBIVMFrIj5c1L
 HpNlzRy5ifc3FXnKRUarCsHsxMJnK/JQE7aYrl5j+oYjVHweOXbq4ZSUG4zd7M3/iR8Iknupx
 ylp1H4qd45vpxQqEvYXZnXGCUQSbdmY69DUwoul7ff13FjLV3Pcw+HFXC06mvh7wTMa

This new kfunc will be able to copy a string
from another process's/task's address space.
This is similar to `bpf_copy_from_user_str`
but accepts a `struct task_struct*` argument.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce162427a..a33f72a4c31f 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3082,6 +3082,53 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lon=
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
+ * Copies a NUL terminated string from a task's address space to @dst__sz
+ * buffer. If user string is too long this will still ensure zero termina=
tion
+ * in the @dst__sz buffer unless buffer size is 0.
+ *
+ * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst__sz to 0 on su=
ccess
+ * and memset all of @dst__sz on failure.
+ *
+ * Return: The number of copied bytes on success including the NUL termin=
ator.
+ * A negative error code on failure.
+ */
+__bpf_kfunc int bpf_copy_from_user_task_str(void *dst,
+					    u32 dst__sz,
+					    const void __user *unsafe_ptr__ign,
+					    struct task_struct *tsk,
+					    u64 flags)
+{
+	int ret;
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
+	if (ret < 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+		return ret;
+	}
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst + ret, 0, dst__sz - ret);
+
+	return ret + 1;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3174,6 +3221,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
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


