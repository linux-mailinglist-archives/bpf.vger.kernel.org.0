Return-Path: <bpf+bounces-49835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05153A1CCB0
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8271633AD
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B4155342;
	Sun, 26 Jan 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="Pv/VYctF"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42AA92E
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909555; cv=none; b=XNhdb5t7bkPdFEYoLtaxP9fBwp+hTkwxzw5FJusMTDrQph5AeOhp6PqJf/DM/wx9dRRf7hZau1G79w0yDRTtA34uAnwZodqIycNeER8UB466iZxwrfz9mZuElo/dErjZ1h22ifvBEjg2y/1p1uxXh2eTHvUm/LgM1t/jfYzDT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909555; c=relaxed/simple;
	bh=PWIqNBUm6ZxRG1kV7MteQuiZsfSRIWxCEdRSIgPkN4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9Cl0KnMyXuHcFYnlqhJGZaILv3hC1dyTYu8W4l+nC8TXLmVSWdPy+joZ6o/vGhpQhjKNfr9eOWxOcCqtn+zADaz3B/CXtBmTIDQ3ec53kM4uj77QfyNT6c2E9Z3ab5uYOxUzWuGyN+DlNQYf9VFtE/dZ9WIQKgmikdAKUQ1tmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=Pv/VYctF; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737909551; x=1738514351; i=linux@jordanrome.com;
	bh=Adf0F9Bo5BhET/y5GTGKNoD7ZEXqa+Hj+iV/mgf4klE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pv/VYctFnd9b5BJy2dlP9227zHpfELGGHdjgegCrHWq4mzIQ4KP3/5hX6/ma0eAC
	 4g4Mc9P15rH0FIxT5maFsbO3soWeNb3n+d+ADrIf9mBzIF8ibWMebHE/UnroVblYu
	 jWo9RC6eUs8Cklrw137V9FLw/qivGr+k5zsSMvJWFRuvAYOVOWpKQUDGsVSyJ8/W5
	 LWrwIB4c4gUAB88OUWARaammA9fdqhEGTmN8BqBN3wPJ0nhHN/MFLXvZlUxcHjHlq
	 YxOaGEllGA87uAHWb6PIs+yv+6r3kdniR6EPUl2hDvsNm4yTL0/c6uxYl6M/TshF5
	 2JDeQ2Cl2a5jNHTorQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.8]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MCKl5-1tl84U1fV3-00CKlw; Sun, 26 Jan
 2025 17:39:11 +0100
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
Subject: [bpf-next v5 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Sun, 26 Jan 2025 08:38:56 -0800
Message-ID: <20250126163857.410463-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250126163857.410463-1-linux@jordanrome.com>
References: <20250126163857.410463-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T65WP1XOpfRRM3DN/qlyZdpDVUitGyuAEHgXSpe7k9XMqsh66jj
 miamZ/RhLuf7SgJd0rDUz7DPbJiG6coIXuKyerhRXl2fQKO0/xnmGavlT77AvuhoUYFbxn6
 r3WmMhfHDY3DzyGNihChKsmdfa8ZZF6Ur1ZI7SNZCW5IMlhxZ6adgFTG4sn5mxyil3WBAUV
 ExwgtKLKvnT9KeDBRusPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3wxKDC7WeMQ=;c7VRqWP0aTLRkGyYiYpxWnB4r3e
 j3SI9FvuZ8GJEUmwN3+eJBLJZWBovUYkP6WlvgN4WMGgw7p9uyiuCIlTG/Fig3fInUArVtrsn
 EgeBmZMbquLfXRbkWBXb/PLIUHoN+Hba9AwD4vuA0vDTaoZ3wu/ucoDjW+pZuf7xeWYGIVaXH
 Mcl/xSY7HDwwvhqEX87DZCCDOxC+uAwfJHrHmOJO4fKChXbIkH3OzOZuwkWtPVntL7DjdRICF
 qn+1akSKs/7jzEK6tr3adua/1cQS+7jjTTWstaH+C/TbXuHlzqqXdPW+k2yPYon2eHqZPKKnu
 cFwNFFpPPY6yplyUZ5ksUy3oAiyo/lu/Z9jJqXoR1F1GClV7tm6cQuRaC5B9moehhhsN+CDQj
 Q2r/lTArk3dfFmVhFKDLWJ1AFZmDTSAtk4OuDR2/kXmbj8EilcUtrjuufc6tea3DPfohnVGiT
 sPqKaw2F4An37ritBWFIzP4SVEAekG0J5N2rc8R1KNp11mAVr+EstsYIiGdyYJGvVvi2DCuSu
 2d+gJXx/V4mX34CgNLsF2eJChoU/iKOHLfT76scabUPuk78plV2bhYB27NbVxkFy+lND3a3hC
 7bTLkqMpqiNeeclP3YHf12iqqBNOPLQZ050Eqg93Yti5Uev2jYpy3Xr51PYwdkDOHmKK/Z74t
 ToLr6kiZcpzeLfr91cM2PCd5jNiBqM6mmsDsBvhrhRr+98f2BdB1kYjAc4zYatVw/Q3fDJX2g
 jwRGRqc2sdMfQLGGtsTgM6v/zdVNSP2Ff6yAPdOOjI9DQgT3nZhBJsj77/vUYAky2L2Vovw6m
 Ag3sh0cwz3V2/+Kr9yxegujOz3bqZ5pDo5oWxfsxU6XGRor/PRZkPwk7KRE7E69OqCSrMFuzY
 0ahkMa7HzA9Q40wzzN6HES8/sFCE7c0FogGKF3NpA2R9yWqztwq2exWR6dfIMwfkE5w1dniWv
 jy66IA0bdp4dirfbwa77+NhhGU/MshvSNRPacBt9D7Ttf4WkQBDRsY4UQsHROB+0YtzfbyHz3
 5cIQwNtwrcJEOAyYxzl7RfMWycXR+fXDiYZbr3cFwOniu9y9ZRss8j87GY19+BCvdxHGQUFt8
 BaiwIr3wVzf2KaLcYT50LHohfkKmdhKmEltWpqhRWg0rBqPdYctA==

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


