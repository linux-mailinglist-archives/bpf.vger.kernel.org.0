Return-Path: <bpf+bounces-37972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD895D584
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA74E1C2263E
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D250139D13;
	Fri, 23 Aug 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="xo1afidi"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB271925BA
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438946; cv=none; b=ufsqv+XAxvWaB6wBzehjpAAW98qBUAEDJzmXeIFCeovDutrpBlR51PgW6VVZ2q1RHJ8JFVW1UkulAGTbFkZ6drUcTLOrE8G9fQO6z3b0GPbN0g2MGd1H3vClL4MmWzpsf6PopQWTZwy7vgDEiY+GT/TfKv7Zm0toq4yA8igQKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438946; c=relaxed/simple;
	bh=i1SXIuLLVRq0155vBfKjP72yltycjWLUUmrA3n0jb/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPsouAbdODDbNlVlyJEBIb4hGh8nvQrISx9PesIg5uD6RY8LnB7W+QWkhz6oPFDRWKyTd4pE7sE5CZB6xouThC5wmNdb25sVNuh82FWHdrogDrok1zS0yuLAJAIHs9Fj1HdpEWfKCGomFTLzaY2SlPuOtARAT8hBjLqRHK0KuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=xo1afidi; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724438923; x=1725043723; i=linux@jordanrome.com;
	bh=z4MopIk5l/P6pVByP+hVPhniotnTONT4ah0PkETy5iM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xo1afidiP+STegWw2yFJHaJ8IDJxluQWjGt2FCNRhd89KFtFHNpgQr3tosDKEaEG
	 42EYKEmgLFbDQYG5Zn+ZCp/2Xq6t3sv18tAe43iHF0npzxnErqx6HVj6Ma0QvxXnP
	 BAxv3vWITIV4zZ1zv9I1LQIF/KMtfARVn18l7LkbhHDvKmmtz+Iz74JcRnxh3sjIq
	 YboIk6vNYulpWj6pPoT2jZFgOynEFrVygx8aS4o5pVo3MszVbTXIFCiyxa+DDrrGt
	 sIQvIDzLF4k0rw2VhatPP3FuxDc2fmv2SKP8uHr2zmQ8Cranztra8RF0bhPGEV78a
	 o+91LwtzzYu/R1q6Ew==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.17]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MsIT8-1rouRs3QEM-00sm56; Fri, 23 Aug
 2024 20:48:42 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v9 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Fri, 23 Aug 2024 11:48:22 -0700
Message-ID: <20240823184823.3236004-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:heUjSv2JVH+t09sUy6OhG6X/w/ByHVdjuwzpbqG9dLGNPOkCiut
 oHh0Or8qEjqiuj2iuiEKtbaF1ZA2Lin0pSjCqgxm+eyJqD6chL/evcMyhTkoz5hiyU8OBn1
 KHlrzt+6BgqwBpCJfyL8ooHje4mi+i+jJuyrnLk7IE4FEX2bIUwkyuwPpTHkB4+L3dT4voy
 Nc/w40eJA1nYfWo9F562g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vI/b3hgagaE=;izrbWsvx/YQtvhM1Dq+P+351f1/
 bzNoWspy1wfBbiE98RHQALzsoU3HCuWVQPA2qjT1LPIVGSlEwFXg9Ifj1LweYYAzPoM5OIoIR
 4T5tQjJpIrdHfCieMNK0tFJJ97rz5toqNQ5V5cT5WaQ1rdxa+zF2GPhJGLb6kh6eiPmP5C4Pg
 iF4xLAYMbhQH8mQGquFh17/cSjhHjwwg0FHppPDpLGT1D4wZZotETF22Zp6SZCoPeHvF0IS+8
 ASdOMpJlhiKryEUuO3bq+TGuqJ5OaUgVx0WFQzsL7vuUIfBfl6eQBOef9VexyLQHX2+UaA1ml
 f1fjFIJiZNmItxl5vLV2P/ta2/nMYk8Sw+pIGBZiRNtO1rdC7xu2LJOQpl6P4BMT8BnGDQ5uT
 75fN1fZj1s5V1anJgT/W7ESBsUyVcCQwhTRHjFVDY8RErwytE81F6wHOeAdkl0waLe0uzIlHa
 +Rj4D8YeDofX5rrgDPbk8o1vVSkNV9e0AkAa1o9NZXcghDMDecV+G+JQKtQLNcxRRskwVR1Oa
 eNTjv+JWZ+pPN3buUxSSs5vVWtAOaxc2FnG1QZEBC8HqiSa3wf1F9HNu+uU9KzcRyb7NwD7DQ
 7eJZkScJfIrue3ya7K3yPw9HPzhnrF7tX44Xl6BtcSb+wmauhdADKZRO1tDFvcV/Yycw7Pn0o
 DaytS7kjVjHK4y0F3xs3DWhCmvFqBJWhGUGOEIHS6JVOtIfz6g/GBlu1IW4DCttHzEAIYIeV1
 kv/8+3/2GYScwA5TJtawL21pl4mpMPPgA==

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
index e05b39e39c3f..d015fdcdad3a 100644
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
+enum bpf_kfunc_flags {
+	BPF_F_PAD_ZEROS =3D (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..5f065804c096 100644
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
+ *                   least @dst__sz bytes long.
+ * @dst__sz:         Maximum number of bytes to copy, including the trail=
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
+__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void=
 __user *unsafe_ptr__ign, u64 flags)
+{
+	int ret;
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+	ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst__sz - 1);
+	if (ret < 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset((char *)dst, 0, dst__sz);
+
+		return ret;
+	}
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset((char *)dst + ret, 0, dst__sz - ret);
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
index e05b39e39c3f..d015fdcdad3a 100644
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
+enum bpf_kfunc_flags {
+	BPF_F_PAD_ZEROS =3D (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
=2D-
2.43.5


