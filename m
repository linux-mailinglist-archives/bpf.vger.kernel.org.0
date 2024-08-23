Return-Path: <bpf+bounces-37987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45F95D63F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA48D286091
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA1192B63;
	Fri, 23 Aug 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="oWX0IXwH"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783B13634A
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442691; cv=none; b=NvWHNfUgHXeCiqawggBnfwOFr+nkNmBksJNjWEOkxVqjT+BcTIE4s75X3uJaa15o6RiUYodwqgDxkFHBlDFQ1gEsmO+cBs3Ma4XE+QCYvxBboPb/6yrpCVwt5I/WXPav2D5KoimdLOHdY8O7q4yQ3zbrTdn7tJnOLLs7KoSfsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442691; c=relaxed/simple;
	bh=3H5iE4cy/YOpQ54kPQqoWJgABWEihCzOo/Ch50CV1/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZwYQlCs8N+maKkK7iStAxEN8APb/6AcQIdU85XwC8pIdcf9xvvWkBCgvPiBC1n7WLMPhUVpK05zATdlmls8A7pHdcjdcrifcwPK2PpUQcllltv+RB5aL1lkzLneV/0L2ptJTk2+cfUsaTAWVkFLx8vQxRFvpPDVp/JvUnygIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=oWX0IXwH; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724442666; x=1725047466; i=linux@jordanrome.com;
	bh=k1uBaYGJROm7a2iGc9YsdSDsuksf5IABxkJs2FlbGfA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oWX0IXwHLtnlOfYcLILWkfPH0xwKClSvi1kTnuZxRLL1G87XoAE8wiW9jg4nXlz8
	 v4X5B0SZYZ8ZnCw/5ahRXPMpegDIyyYiBcjjnr1siRfTWGUzQONtue3Wds/4E20xk
	 89o8NJ3YzF4qERR8KhZ7CNvtpskqlBRe0s3kgJcE5M7T0uS4EzBku53/3pqkxk+G1
	 YB3d4ijjj57zI57V+a8kbC+aKfnAG5Lfuhho5uC1im7VFmBZeZrrP7QOTZGQSGUY/
	 oa5HE/JiqE6Wc5y7Y/WipYtGk2Oi6AfqsRsoJPKlWoe9SLxS1BM9juhgNP4W5ZTYL
	 BEmPzXUWItc+uHFjUA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.113]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MS4IG-1sX1fM1Ow6-00LbSt; Fri, 23 Aug
 2024 21:51:06 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v10 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Fri, 23 Aug 2024 12:51:00 -0700
Message-ID: <20240823195101.3621028-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MFHgMTLG9dhQGL1die/0enUrqLu7klcxb2JM16BRkCwkK+v8cxW
 wRTF9GgDZAu3iXr8GhaXY2H6RWYpjOYQymIPvSIffMxnJHFMNVP2lNovJRPJ0ZYIWvWUkmC
 tGfowA+Wly3yVILj1/fPj2pIb7B+7or3Mt68+FmuRKf1ta+LhPGIeb6ZxDLYoD80Yp/B+wf
 pLDpn89s/ES9xxjVZ0bSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NxA6y5UHDv0=;upumBywZf+h1iXcyMgqT+UKM95E
 CTvPjSabIHoXve3FozQ/+hNEoOvq/YOYTbdc4rA3hnHwuRUFQCuk6o7eCOC4fllhWsbU98paI
 ZRQogBIvwdbAhMOuaArvm5uFLSPEAP7Of0k1hK4kz8smB5Gj3HCiwpmq1rzaOHhaLVNL20esQ
 ZyYe5nJFMe+xMoerer++O60xu2Q+zDdfczUw05twYl1Qesu4lumS41XtoK2yq8E2j3Cg7UaUT
 MF7OL9S19gNiGMOci35waqwsn58IKP0Z3ZQjCAtpEfpvXdp/6bU/VUyagjd6Hw1AmkQLcBYRW
 uOARpzUAhflU3vwAptr0xH+gH/ULlN54aBiz/b/DBd4dBqdvaMrhKjsCn32Fiop+mwgVkfkDI
 xAqIczlUo8DHhBiGQRHGBxa4lMb6FBInDyLFZjt5aiE3RrXMx5wb5b9Mu9z3eGrashTj9upoD
 Ujf7fb9NjMDnenOiXk62S3Vka2OxehthPiD5/MGiERKxT3GnYO8vWqqP+lUpyOI73DrxThzh+
 l1mPoZtee46JrQdnigEo8YqbdtBg2txGxeSf4f30jjHn1gVaifKPxbV3rVYGLzqnu+cYM9+RI
 lb9eBT07yQXgYNZRjSyoTehf4swccLT/Mlb7ou+mZjgFR2cEbHUPjgeFWXZdsezgXHEQhkBpj
 6jh9wRx9cyqX5794blkP4jQpVcXHV+ti+tlaiApcHlnMkMVya+1rQnnAM+CfAIIfC2XOutmHJ
 hdbp/7C0mAOTif3PtsTNk7FQY2sBXdnRA==

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
index e05b39e39c3f..1fb3cb2636e6 100644
=2D-- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7513,4 +7513,13 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control BPF kfunc behaviour.
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
index d02ae323996b..72cfc305d38a 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,6 +2939,47 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
ter_bits *it)
 	bpf_mem_free(&bpf_global_ma, kit->bits);
 }

+/**
+ * bpf_copy_from_user_str() - Copy a string from an unsafe user address
+ * @dst:             Destination address, in kernel space.  This buffer m=
ust be
+ *                   at least @dst__sz bytes long.
+ * @dst__sz:         Maximum number of bytes to copy, includes the traili=
ng NUL.
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
index e05b39e39c3f..1fb3cb2636e6 100644
=2D-- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7513,4 +7513,13 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control BPF kfunc behaviour.
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


