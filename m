Return-Path: <bpf+bounces-37614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142D9583F8
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CCD2840B9
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2418C90E;
	Tue, 20 Aug 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="Ba/GczE0"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CF189B99
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149091; cv=none; b=mLEdC8Uy++88CSnoVvZZoahiO1w7m8FxSwcGx+mc/Bm7WJXJ2DLQqHC/JvAWGt+79haQx+c46OzEkRb7wbPmu2EI2X62xfi6+SWcyGULj0ojXvD+oHpPoGJsZk7Iy7ZtOLlmcL41deLD47uOqfe7cVVLuoPlG78J5xSA3dzTQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149091; c=relaxed/simple;
	bh=StpzmIy6MTbgeUPsovd3tBDsxc2RZ1DeyJXtAbv11Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/NoGJsLXu+/XwQPweV7z/oOEI5gVWe+22Z7wj3OKlAcpRJAw6KiD5gtiFNCfwfLDakwv2DLO9o6UPhoEuShCYngDBnkvbbmgJP+o3rvmv7XILLntGqIz6+lelt1WQkZhx69NpdGq+wXYelaNCJ1NVVQhR0VB84IzZe3H0OjOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=Ba/GczE0; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724149062; x=1724753862; i=linux@jordanrome.com;
	bh=AJMRgGeeMzRnSr8q7dbhe7hdqvLeBI9dUaUJORKMGRM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ba/GczE0a31vg9J4LZE/GybUQJrfk0S46xVlNacirMxdM84Ef9YzrKS9YF3XVnqg
	 0TwQ44xmjiicny5yHnSRjx8Mf2u/YRTGJrjfVBtxxjggVfSyDuggEk22JC784Rkag
	 TWW/wGCAmgWfkiLUgcYXt1H8da/TRtWvtPNGuIH3JHdQLQ0y1pVUf28YcT+vfvGM0
	 ZcQ1hCkmJAtLqS+fhqB9rRmVmVzqW6K+XyZhRmT21AJgrGbz73RWQ2m7PeUNVn7fx
	 euXzMcRwShkhiOdnSe1IMaoplfEHkB+B5h5KrDWEnbWaFEPH1z5xdWtrr4NhBuPpN
	 wIkvRJF683kuwCqJ1w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.112]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LxhU5-1s5pBm3wwV-0106F8; Tue, 20 Aug
 2024 12:17:42 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v7 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Tue, 20 Aug 2024 03:17:24 -0700
Message-ID: <20240820101725.1629353-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eb2sZk3hGKhq3SoXHrMuLkbpsORyCWv873eyIfthe5iWHI2zMkR
 cmkE6BGxrfn3zb52EJvSvIkhZ1sEoEyUA7vU3462Qsmr2JTHExiHe42FGoolAtyK/KjoELU
 4DBZViVrNyy/R4mHbu/fyHQnpeJiXYHQ05cGn5bS/OC9VaGAQEuSiva2z5YMbfwj36BFGpH
 x4KFQSqKA9Dg/OIp+XbWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X6Kv4aGorUo=;fELzMtlFdPHnl8FtbR4E8cISqAv
 6iodcwkZjKZaE9EK9jcuMez24LNjiifKQDK5IZFc4mjsBq29MLR1AO4zohU+sIY2Of2kkR5nH
 Lq76c53UrpUYCXNlZSY1NKMxEV3RLwhocv61BBAb8MXBFbdPUZ2TslpNN48DWeGvbhBBEXE99
 dd8dn+7uEHX6qgHXubc93yKVfsG+3beNF2FW2ekMM25I5k3jS5Plj2trbJRmjdz5AdDLXQgpn
 2TDTS5LO5i9TPsSpf5+ObgtgF/I0WuqtAgDxt0ipMJ8TzO+gfydG0DBXOZJ6WP1vIduUrPK7o
 NBRWwOXNohDX6iDI5fkP4rSfNp+j899rV+ZpChd3mmTkEWSb6vOFxYPD6ak0nO8amIG0pq2uG
 GR9l7bwIjs9MDm7F0VvpmLFMG+kdlRDlzGL4HbOAnOsnR3Ikcpwgj7WjgOwIc5uFcdpKhcMTn
 0McfmGxgpUKGpGDBvFwCe00Sx0264vN/jlkkt1pReboG+1x52Humlybs8ccBIFJsVYXFmfeQj
 8Qa2h3+VxGc9+u4D417FaPAYdDr0XJfXW7ogDVSkbNxGc/yxp7UHecCYAgav3jfNJTOKFJxLr
 /Bj3+3KKJ4ZgFOsqj+LMUrtdAPqoZToQu8pUwplvBmkDZYGikiHigTcphytFx1ZfIwf+gmCNp
 3g4deRFqWYiEQ9oY/8XbUeiePvKOUxiW9F2/8Lr9slTnoJh91yIXKxzgch93EE3RPUmY27VpN
 fsj5RhGCFRZz2RkQIxzVHrT+ul164HKwQ==

This adds a kfunc wrapper around strncpy_from_user,
which can be called from sleepable BPF programs.

This matches the non-sleepable 'bpf_probe_read_user_str'
helper except it includes an additional 'flags'
param, which allows consumers to clear the entire
destination buffer on success or failure.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/uapi/linux/bpf.h       |  9 ++++++++
 kernel/bpf/helpers.c           | 42 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  9 ++++++++
 3 files changed, 60 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e05b39e39c3f..d3b69cb055c0 100644
=2D-- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7513,4 +7513,13 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control bpf_copy_from_user_str() behaviour.
+ *     - BPF_F_PAD_ZEROS: Pad destination buffer with zeros. (See the res=
pective
+ *       helper documentation for details.)
+ */
+enum {
+	BPF_F_PAD_ZEROS =3D (1ULL << 0)
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..e5614a980d59 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,6 +2939,47 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
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
+ * @flags:           The only supported flag is BPF_F_PAD_ZEROS
+ *
+ * Copies a NUL-terminated string from userspace to BPF space. If user st=
ring is
+ * too long this will still ensure zero termination in the dst buffer unl=
ess
+ * buffer size is 0.
+ *
+ * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on succes=
s and
+ * memset all of @dst on failure.
+ */
+__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const voi=
d __user *unsafe_ptr__ign, u64 flags)
+{
+	int ret;
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(!dst__szk))
+		return 0;
+
+	ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst__szk - 1);
+	if (ret < 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset((char *)dst, 0, dst__szk);
+
+		return ret;
+	}
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset((char *)dst + ret, 0, dst__szk - ret);
+	else
+		((char *)dst)[ret] =3D '\0';
+
+	return ret + 1;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3024,6 +3065,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)

 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf=
.h
index e05b39e39c3f..d3b69cb055c0 100644
=2D-- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7513,4 +7513,13 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control bpf_copy_from_user_str() behaviour.
+ *     - BPF_F_PAD_ZEROS: Pad destination buffer with zeros. (See the res=
pective
+ *       helper documentation for details.)
+ */
+enum {
+	BPF_F_PAD_ZEROS =3D (1ULL << 0)
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
=2D-
2.43.5


