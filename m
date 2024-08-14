Return-Path: <bpf+bounces-37131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64045951120
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 02:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854871C22651
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 00:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1D4A02;
	Wed, 14 Aug 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="bNOAk1OE"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDB631
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596359; cv=none; b=pUIrzyz06nPtT/OktafLkdPAy2fvBQheXT1hd15nMSsf8dWF79b62mmZ1X4+5k1t17BPBZU4A0EesuPQuZFbvUu3kDK1Yd3b/cH6P3Hvg7wzZXTm6e9DDpGiQaoPMEXxAbUThkfJFvfizl/xUv1wCksuBFugYNKRPCEridaH1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596359; c=relaxed/simple;
	bh=DDSlEywWNjZxfM/8hcd3kkDr4K7Qm3MyoaHu0bf4jGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3YZFU3rbNoBCgJosBlOHoRXuzOR1PEvUQfwiHc63IT4xUsv9BnQJJxsDGkgElvdjv1jaOLoeAmJGXLs4/a+olDg9I/wjhcFBRqDQywORo39bWTE2m2694ZYLPiAfLL4JxfVsfOJDJa4e5++tpUHnPnv5ThIB4ad8SHJ/hCx07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=bNOAk1OE; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723596340; x=1724201140; i=linux@jordanrome.com;
	bh=hb1lRMN+Yain5y/UmH5cePn98wlCqRpp0qPLlPOmbEg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bNOAk1OEc5zW1xmxraNFbeOl2lTLlQmf1FiZiBX+yHhu5orGc4i+2q8ke8d765+X
	 T3Mu2pt5tUXP3fmkIs4p2VRHIXJrqPXYKp+qNBYMoTphzQk5ar5kgAo+OVoUO8p/1
	 9Yr60ZZPksqjLMLaK94tK2+nagGtMol13z+MdlUGOMgHUTTsFeI+PoA96LhpM1oI2
	 TWDpGo9OUbwuCJ0bbjCVSv4aIFgB7ev98MyZOFx7eTr8MFJ9Dl9Q1nv21cbhTucuz
	 Kqe7ZpBOZcGgNytBTi7CqM2FZcnmqQKf0ihkWR63guT3k7yUmq5UNesoFFHIDpFjH
	 borTLH2NvFno/2XRng==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.115]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MekSf-1s5WL32fKP-00p3Ap; Wed, 14 Aug
 2024 02:45:40 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v4 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Tue, 13 Aug 2024 17:45:30 -0700
Message-ID: <20240814004531.352157-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n0IjDbsM5td8bF+vv4gdiWnyqK4V7Ww8qIG+kzNMn65XyzQah8Q
 Z/ipXC4PBsl01ydRmPB/MGNjfeDlObJEnAO7gYAGqYbUcvgORa3g7L5HY3NE2hdh9CEgsF2
 PQZ5TnZSJTO0JfVSUbv1DNqQPwSvPTF++8qshu4ENWS4GoJezhfMJlh4f6yFe7a4n70FetA
 kMilD2+qF67Ajt1KtekMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2LXFmK6De3M=;+fBYyyGDyHRSPxBhfo21ULEoNy+
 Z2Q/UFlSvu75A9jPjSGK+J7YHrOyKRBg6vEYP6GnTf7O/WiGgNBfK+VIvR/aXo8Xsr4lGW7B2
 hETPIvCOUGaQxzViApGgC4S3lCql68FrsjEJd27ePyK4TieI7AKmhZbhxtiUPGl+YwWqaaur6
 ISyiD5SKuBi3isxiRZIKurQn3ZDpKf+7vjDGzyRlauHFDNO0br2STBJkyRoOXswYn0GMMmfVk
 19SZGK3xzy2g2qyEcb6nqk3r+6TWq5oB3da8BiJ4O5CiveVaRKAQ2I+bdF9lkK7gMnau2fROA
 J0qvD0k/jJwt/IibJCdJXqRL/VsNh/p8bIOq08aoBottrW6iVwB/kNdU2MzyMTY7rFEfEr/QJ
 ME25lgH/lTaPLDYETSkVY/AtTWf7NWPiiZ8Kr1WBQbLftqgPJpHoogIiAQlkztc2gMEMtYsnG
 tu7Xya6zI4HaHEAamQxpWsw0+e0f1xzxppkdZQp5QtKYiTkpdFqdg+C9/SvB9bl0zFoR/22+W
 CLZGPevwBx924A13nfsDAuGnAI7oU2GMamBIwRUIM6GQCvBQH+ZjmYUlB6jaisEDf5plFNBzM
 HU2e7qtXCyZvY1hEzUPS+DFqhbY1emUshZj88jvVGRlGe6moidgGHccMQhlj8BSh2lfpbGxYd
 9dbWvDdEUfgW83UgudPRGRnAbCN9jsIJvCTNzR5pfQox2HIw3sFAQyK9A5o5Utbm3J2o7gU23
 DrMa8fMmdW2i5Bi+AohHgaJVOFuKUmcQg==

This adds a kfunc wrapper around strncpy_from_user,
which can be called from sleepable BPF programs.

This matches the non-sleepable 'bpf_probe_read_user_str'
helper except it includes an additional 'flags'
param, which allows consumers to clear the entire
destination buffer on success.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/uapi/linux/bpf.h       |  8 +++++++
 kernel/bpf/helpers.c           | 42 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 +++++++
 3 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e05b39e39c3f..e207175981be 100644
=2D-- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7513,4 +7513,12 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control bpf_copy_from_user_str() behaviour.
+ *     - BPF_ZERO_BUFFER: Memset 0 the tail of the destination buffer on =
success
+ */
+enum {
+	BPF_ZERO_BUFFER =3D (1ULL << 0)
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..34c4414f2257 100644
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
+ * @flags:           The only supported flag is BPF_ZERO_BUFFER
+ *
+ * Copies a NUL-terminated string from userspace to BPF space. If user st=
ring is
+ * too long this will still ensure zero termination in the dst buffer unl=
ess
+ * buffer size is 0.
+ *
+ * If BPF_ZERO_BUFFER flag is set, memset the tail of @dst to 0 on succes=
s.
+ */
+__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const voi=
d __user *unsafe_ptr__ign, u64 flags)
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
+		if (ret <=3D count)
+			if (flags & BPF_ZERO_BUFFER)
+				memset((char *)dst + ret, 0, dst__szk - ret);
+			else
+				((char *)dst)[ret] =3D '\0';
+		ret++;
+	}
+
+	return ret;
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
index e05b39e39c3f..15c2c3431e0f 100644
=2D-- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7513,4 +7513,12 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control bpf_copy_from_user_str() behaviour.
+ *     - BPF_ZERO_BUFFER: Memset 0 the entire destination buffer on succe=
ss
+ */
+enum {
+	BPF_ZERO_BUFFER =3D (1ULL << 0)
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
=2D-
2.43.5


