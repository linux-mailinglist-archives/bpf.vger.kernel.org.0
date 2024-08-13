Return-Path: <bpf+bounces-36978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96994FB10
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 03:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554E71F22C4B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A5A524F;
	Tue, 13 Aug 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="fHaO4hk5"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA388B67E
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512370; cv=none; b=dxEHIS9aeqQcTPeAI/FsXAyDhXcEPqNEcO9FqyHfsMEBVheitmlMjJdCnwBxcM7yI361kGQ9YTNlTx2TXfvzHlhUTyPcWswMgceu7UDqGjWyB+etDeZ/wNopl70RkXjypjWsfSJngfGVrE4gglYHWuhOWzyie4LvOl3+21gB3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512370; c=relaxed/simple;
	bh=WTmgDLcDdYM7UKt0NQS2hIL8BXMCPkg7R7SsOKLRQH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6ebmUnJhhwkKL4yZ00SYxomGKIpvbvyZtcfVnoswvyeZYFuwIS+OM/0K+fSVZun9vXy+ko38BGqisrXWTdWoyqvYH8dJqA9GxAxzhfUluuHRKcuBdeRZdq40BicCZxfNkMy7nTyBCCZE0oDsmUzgw2H3SqaQCaPpKLDgPJN23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=fHaO4hk5; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723512338; x=1724117138; i=linux@jordanrome.com;
	bh=a/bDNfjyyKdZ6iujBVpENPk9ZxD562Q7a11IOMWgiik=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fHaO4hk5/KyCd/9W824nfsFpOG40aEfC/yVMR/VgzXxFF5zNnhfgpH6d0wxzLE1R
	 RWkducFPd5d05pJ7OrUPEIyhB2FThWtFO2QNpjlP5D4oc3EvRlXXyB+5+KkzMhfmT
	 ynlXHzLOl1t9Im29zUQ2jBi/QXgNJsh5COzW/fBlIN8Sis1D4WUINoXW84PogiSJR
	 TfNDsKYld+OgoW9VP5Msr0REFNs+5WyNXXuZLJ/5wj9pCQq2fjaO/WXdK880JL79B
	 iys+MEydZeoqZrAY2G5iaWtRQsCOgXz4/HwvDqMrteV/XfhGFedmvhWsM882+vgFl
	 vtD5ev3PU9aRQLEZ2w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.18]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LxQMu-1s61Jw2KNe-0112eK; Tue, 13 Aug
 2024 03:25:38 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Mon, 12 Aug 2024 18:25:27 -0700
Message-ID: <20240813012528.3566133-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wn7MylDoWmk72piC95Y/jdAL/KaPD1Hb05wVYSx/2sukGkAVMD7
 TypFA27uKxvJj8N5RaG2ZDYfS9O7063Fv0Xlrl5Ojg4jPWnK45HQS9C0gnQXFapI0DOkgr6
 YVh6zDykGcOvjzCdDpOVRcUYx8mttw3xdey00o5enR8A10RBT2pSAPAAaDqKt1Kzq6S2pZw
 Pf7dn8u6XjGML7cvzw/0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/2sf+E+eQEA=;abrsNR7LWaahTLDzWjhoBVBvmYP
 pyKxev7h5GKkkIYQLwXHxtTmqSHUqHb/zsIRdxYinkIO5k5qkfGVGv/Hz1dsDfhiGVRsaCnUS
 ObBI4YI17yZannb2/UjQ+Eccs7x5W6YX0NwK204sGUWhz4zHVC+3gaQGtYULG7OBe4q2/DahV
 ktmBNuEE35GgfD3OByedyuuUUjdQ1tiGeGc5maeAz92Ud2+SBeSNJo9pOM/1WrEejFuiMxCUb
 UchqvkrCaBB86EPCbB9+YFkJZAnjXRYkl4VXcDIXUaRqUyop64oi08Qcc+W9/qpZIzB3kyN6l
 CuhVuMw188BSu6QE06qL+KXh3tz/UMEmV0fSARVIDrVAiu9wfIwAE0STG31u9ewZkgdiOUV/b
 jdN6Y51qxZR949HLXIN3NsRGBRx0lqmvDVnbQugRu0FcxzLTF4myBLKt6G3/+6+AEpNXQrkA2
 MuWPS5QWzLmwpdbZz/250YUjF/R3+aa7FfF/j/ML8xmOdBB5fZWbLBB2CjY/nTTFm4treK7nv
 poh+c67DB6h2wqvego9dunpIJT2U8qRlNRS/nD+rd5wS8oPDRkqgVqRI1614dvZuIZ8we6mDw
 7qxQY3s33S6Rb3ufQwYYJpuZgzahWsBB0Kq/cK0NFjHnnbDzCukTqiZ7ixQ9+8pIWbDBWX0Xq
 Ht4kzpNna6kLS58vIe6MrzOix0ocJItKseMqfS/9C4bC1TiBsFSfKnLXY1a3m5v5AaOpASLaX
 5YGgRBLp/rLEp3SATOypSOhAfGQFGip5A==

This adds a kfunc wrapper around strncpy_from_user,
which can be called from sleepable BPF programs.

This matches the non-sleepable 'bpf_probe_read_user_str'
helper.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..e87d5df658cb 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
ter_bits *it)
 	bpf_mem_free(&bpf_global_ma, kit->bits);
 }

+/**
+ * bpf_copy_from_user_str() - Copy a string from an unsafe user address
+ * @dst:             Destination address, in kernel space.  This buffer m=
ust be at
+ *                   least @dst__szk bytes long.
+ * @dst__szk:        Maximum number of bytes to copy, including the trail=
ing NUL.
+ * @unsafe_ptr__ign: Source address, in user space.
+ *
+ * Copies a NUL-terminated string from userspace to BPF space. If user st=
ring is
+ * too long this will still ensure zero termination in the dst buffer unl=
ess
+ * buffer size is 0.
+ */
+__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const voi=
d __user *unsafe_ptr__ign)
+{
+	int ret;
+	int count;
+
+	if (unlikely(!dst__szk))
+		return 0;
+
+	count =3D dst__szk - 1;
+	if (unlikely(!count)) {
+		((char *)dst)[0] =3D '\0';
+		return 1;
+	}
+
+	ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
+	if (ret >=3D 0) {
+		if (ret =3D=3D count)
+			((char *)dst)[ret] =3D '\0';
+		ret++;
+	}
+
+	return ret;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3024,6 +3059,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)

 static const struct btf_kfunc_id_set common_kfunc_set =3D {
=2D-
2.43.5


