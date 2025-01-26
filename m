Return-Path: <bpf+bounces-49824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D915A1C7BD
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 13:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCFC1887049
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3125A657;
	Sun, 26 Jan 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="B5Ki3O+V"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAF4430
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737895666; cv=none; b=A8WIppN0gv3t0HP94Dx3ILR4O3wc0BuIelQTPGLr/QQzCsetWH8atnsPVDVqaGULE6isk+0CuZSMD3IObXlXANj8+MPxISY6cj6e6xKkG2p4H3PCDVWKKnAM+nqSAEf0z6QnJsERp7Xq2Y2VY3iCfjxcqwbcmCCxebrZ5yEHaxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737895666; c=relaxed/simple;
	bh=PWIqNBUm6ZxRG1kV7MteQuiZsfSRIWxCEdRSIgPkN4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZv93fmOaMgLo0yubswIrzqspGoIsKY1nKEY4hvQ/I7/+snSdH6QedIEKiP9dDjoWgFZu7E6o/iVlfKSgKD6fTp3jfBEBE+5jIF0ySv0R/+mzdJkr7RCtma95KJQ0RVgXE++AUToEDG5xsEeUzGcMEivUntIUAk1+ktGV/V0Occ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=B5Ki3O+V; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737895663; x=1738500463; i=linux@jordanrome.com;
	bh=Adf0F9Bo5BhET/y5GTGKNoD7ZEXqa+Hj+iV/mgf4klE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B5Ki3O+VVtz9oeD4eVvapcDh0DMnPhhfavDrEjHMMCmZJAKhH4fLa1IvqdiX5kKV
	 7Vz4yHrP+FGHhWCQdlS2lmVurHyk1G57stOat15lx7mDBaHN9Yl6oHfLeOcmaVIKS
	 FNO65PAdRul6hQ0s+3FJZKZJzQOlusaC/l7gbEbEou3+TTtuCOXG+tBYp907YaUco
	 vrXZzqO9A/e/kN3WwQT+8lLloJ+qXhk90GVWk6I6Meqt37jWK9PQzU2/5us+kZwbw
	 aPJMi6s3rDd1+AHi3mq/h6Q3BI7MxmkpYxYeoH8Smz11ZEiPrr2PDolN+smDRgFmT
	 gP4zzP+B2icVCEgCFA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.10]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MN2Bq-1tZq6H00TI-009eP3; Sun, 26 Jan
 2025 13:41:57 +0100
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
Subject: [bpf-next v4 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Sun, 26 Jan 2025 04:41:46 -0800
Message-ID: <20250126124147.3154108-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250126124147.3154108-1-linux@jordanrome.com>
References: <20250126124147.3154108-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bjg3kl/SxsbzXz54Tq5IdMdSap5RqVJxqDCBn1QQsJVhmBA5fWt
 i3KvIk8h/8wJN6K33pHR+p3RJz8FlsKAYVvZX68rB3vegnqmMhe2zTbq8joxYRK7Iyb5Q2w
 i2mfbEmT7NMgu6RCfi0sBKmIIvklmsCW3XSp8gMZps2QY7WKJI1kU3j9rlRIEnuaTla+9jb
 WqGOz/w53TIzcAVVdt7Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f/te/EooV/M=;0OEjHM0ACfJU79+pV0mUP1QMJHm
 e98PzfhlPGPLIx8npitoHy60BI82bfP1g+QJNDMzjdBnQCxZ/Vif5/3hicC00XGu9AvCRaV6e
 VtR64ccsZ0sL2kww0DqQkzX8JUsqJ4Eq5w55SXUl4y22PYSWv1QrzE35RgnL+R/T+1p6py7py
 vcbcm5clWZVAlrnDfxYfp4Z608VPkB/YnBMezhRYi9n5QnQTPF1YgBTUcn6ooj2QRlV+UhkRy
 1uxGIrAhhvxkvNADLAyxtRskziqVY7Hyc1ZLDpBf3S/4FPo0lRz++GxTZ+YjmK9lSH/OL96tz
 rh0jdeYzuhUaNCEzgD3IudPYJWHeO99iHNaJk/ap5Bb4wLJ83hmPQV7SHeWLIUg6gntTrI0RE
 H+r3klWiAhNUSPgHjfT3sqe0nZ0nSB2PVbwHAYNVZlWwO8kgPWxSqwz47psVKMJirSn/LjSYg
 p6UY6WUqPSUQaAs1IRPYuyIlLFXEZacMbrPme8Y73/2ss2Kqt8t0rQxhZylIFVslu4V2oXQv1
 nbKjzXiLilbR/HwtynPj4MzS1FQyr2ToB0u4ckHBpnKBGEeIB+4N1XayQfDa4DquiMMEobTM2
 EP9UezlZUDkN63qLwwyOyMPF/bI7y/3nd2+zWlCY04swNa3MU7Gs7Ff3oHrLaC6QxxHSblmzW
 JeDLlJV8vkBH0NHwkfdyZ9cwIFcpyuKOUwdvvPRsnCcZzvBMDhs3SxSW/JDtiIpmKV/VIe0wf
 CndO6KS/cOmSLlPWLVKU2mqw2ncpRsVvJgH1H2HbD7mX5DlKLNXV7scvAuDx9WYVBJVM0S1Lw
 jMuCNeROlmbZa711J4Ho2IrY09YxDZskcRXxxSYCtHLlPv+PRi197mrnFgAxbomugWUbgLw2h
 LCxePMjgb/36Fer2VUu1wedAEWaWdhwUxIF18pVYfcD2RVosQKmgQQ2nTAlqlrInkhCe0W53O
 nqM9QkjWjlDqVNbHO8ZxV4M3q6vBQMGzl6j4fwNqmqETw2fQEmh8rB1+L4yf8AgADhIc4PbAw
 RopvBvgQgSuggf5AW9rW+MlSaiuCS6hfkH7oHovlNeFPfj2EcluuBBmJk9HZYMudbQ3+piPY/
 JfcO6aqSbEcQXkuQLwPBQUTLgb/UtKJXe6bx7iFAfSKOx2cxQwfg==

This new kfunc will be able to copy a string
from another process's/task's address space.
This is similar to `bpf_copy_from_user_str`
but accepts a `struct task_struct*` argument.

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


