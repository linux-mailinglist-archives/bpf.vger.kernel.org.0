Return-Path: <bpf+bounces-37908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC295C214
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 02:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3128531F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEAD365;
	Fri, 23 Aug 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="Xc6WIUgy"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4D4A1B
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371943; cv=none; b=qEmMeraaV6ip7GM0IFr3p0r3MBR2FdN7U0tkpyHOWJNWFq20BQDEost/Fhwbw6YOw61sKqWMahHBAXXOFAtbS6QtQlPv0kTciScbTsCxbvrnGt3BbiTofyte6VG9x0MaOOmMmLcSD+YQtRqLeQKmsiXladSGMVub902sOj2IFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371943; c=relaxed/simple;
	bh=XhuyOPEHcTUEH0yYSqzU54t04qTH9P2uYdEaMUx4Or8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUbLUaOPPP1DNwHLY7AUms0VSXUOQ9d3gyuZyIa0fNnZnvscR1o/8T6dPyQojet4bwtLUOFH1tbacMpoyCGSKJRca+FrATWXDOxb8RVXH+17i+votIIVz7aKCQqQn8qUwN1H6zGcjbN3cmFnNKlkqgQp9oWCLKFQq3xD451HRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=Xc6WIUgy; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724371940; x=1724976740; i=linux@jordanrome.com;
	bh=bwPF1mfnOluGshF2c11rLLHf45wMS2tGmK3lqkwgFGM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Xc6WIUgyo01RjCZlpHTfTy4bBZL1VQ5+YZVeJZ53MiUQgCmveOEd6pMd/feaqo90
	 8lPm+1eVTo7MrcB9KlI0QpXbLTS4s7bqrOofiPmP7Pu8ogsaPZ08UAwVhbXr9CblX
	 unmGPb9SE7gCPED8lNegLbcKsQDxqrkZOtJ4iMVDMwrJo0YXa7IJ1tfv0bAOUt3ah
	 P80YCSLIo+2o0OVTxdzmCAHqQO+wP+D6r4gokzGhBEJqztcp20Yww08oPCTCy7IRs
	 Ls4hwcn/kqW9ddFMk2UbU7CBW10GJ7JGWy+G9sGaVZHcmJF4GXzCggaf7GLh2YwvQ
	 S8PHBfnFe6LyIf9MqA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.114]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1McYbJ-1s8n4z1avt-00ZKLP; Fri, 23 Aug
 2024 02:06:12 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v8 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Thu, 22 Aug 2024 17:05:51 -0700
Message-ID: <20240823000552.2771166-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rd+0hpNGVwnyz0Ttco6VMEa4GC6ZbydyhWUQsscApltQZCj+T+L
 Q/n7qPMoRfU+rvba7Kt/3bOFKVAii4MxTf9p2QIn6GEtshp/4Y2lhbtbSRzDHH6q4mzbtae
 bbjEMCBogI17mCBxjIoEehjsLhPCZnPbckQ9G+puRGM2yKdGgUAaNf08HMluU2PlUoMhczw
 2WQtYwjtQd6nMs29KRRww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9DVJ55pdO6I=;6m8Wk80/su1fMzNHVfUzhztakTZ
 4DZ06GFwL7ttm+AyAso7Ja5Ko3Wdd1ssQigpH37ejrjCb4Kezu75tsiaG+BrR4qZCxzVL7ppr
 MjWBCWyxjGXcosuNTZbE/aFpgoqXshxgUppn0wmKol036eOCYXxxYNQWFbJOTr12uDDASA7xT
 rSlfq6XeysX23xdo/Z5/XQcHlnrg3W1dIuSxRPGuT1Iv88E9W6ZIql7tVM/EKSFGgT/Z9uWLH
 4GZE7Bg5g1DlV1MloEOOq0LOzWMgeYAJEcQcaYzllw9dNZZd8yIERzTBRFoYebtmos8bbHhmB
 7gvOTjroX/GagufF+mq0o1sg41ZMN0ALbq85DDJnXwPg7wBtf8CgoKk2beD8eT4XCpcSFJksD
 pdmgkpJSKIESVYDscYz/wl9F8wnRoe2m+jiG8xSmcEE+NPX7yFr6Y3LYVjvG+mP/JzkfE0Or3
 a+UN2jqZljV56kGu5Wrg+oQzcclbLEI8ItHMhoI+xdmYtQdlUJ3YWbDXFTe0PxDjcLTMhoCQP
 7d41htHbaNE5YXntKHuJntCM9QTG5yVz1lq5uvRfK4Xb6mXkKJWIRvmxMq/1yxKTZ3r1ePu6L
 JNBxtjGQZtX+nOvWIpyBKHUkH/vmzzUf/FQHZxOSKvne5bwcfxtM9vTL6vC2vtjgFz/J2EwEe
 NnwSlq+TorUbxuWDsLI+9lRaaxK1Do1ORGnmBABMw+/wc7x/V5jBew6A8mwuNlVuyJ+4kB+y0
 taZDSDI8ZvlMXt1vI5DW5C5XRbBOzbgeg==

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
index e05b39e39c3f..8556f65da4f8 100644
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
+	BPF_F_PAD_ZEROS =3D (1ULL << 0),
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
index e05b39e39c3f..8556f65da4f8 100644
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
+	BPF_F_PAD_ZEROS =3D (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
=2D-
2.43.5


