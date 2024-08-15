Return-Path: <bpf+bounces-37262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5EE952D76
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FA1C24EC4
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDC7DA9D;
	Thu, 15 Aug 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="rjZeyFHi"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CB1AC891
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721292; cv=none; b=NaFvuA4tkiNCVpKNOKY/bHobI+JFYoqfX9ZANrWoJqLyBtH/V8FmEXVJsu3S1sUdugjl1S16T0gnvO7crOigapE/uf5lxEeQ+Wt1UHyK8Kr8V+52LlWs7xrK1WNGWD8DmTPhUuz7z0i/ETWWC33cuuuNMXPjqDyjoEGjjwJAlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721292; c=relaxed/simple;
	bh=zjgnN2errLI1vpUZ4x+fkxahWrnNe3pn90jlEAM3jJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhJRxq/bG0KA/8+PgYuHVUg126rrNCd8lDDJHPeM4SJdvfyUoLtUog2/V+Hd0wr4K71Fmiyyapr5zxsUJ+3R15o0/X3yjsYtbupH25ABLpWga+Twk4Qve4CCHWoVRVJM+FW7lIB4haDK5lN0l2NTfBrneoMOfkGoUSASjeKSXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=rjZeyFHi; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723721261; x=1724326061; i=linux@jordanrome.com;
	bh=dSSF/Tmv4Kp07ghiObaRUcWm1KrlaVPrNh4YjL/88nE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rjZeyFHigB481JjpVvMzYRljglVmFkx0B3IM8/airBm1Rvjr94p3ZRONCIoIdOeU
	 xIrLnIzlpr4uNjlX34JmOskR6FrRXF+pwb9ZyOMy1vPPPLPMmXD0b1LNrnwqBec8o
	 rg7bw75zDuNyODKzes4QWcfyn224XZ1VCVUdtJNTwFtt6sOdSfhOMyJrUHouRj3A6
	 nWH5T2NaKhn5ZLBHP7LEToyamQFcU99lRECl+ysWcSkNYnVElFaZIDpl9xqBZ+60J
	 kzukP6dqFU2pOzpKMxXJuSXzKspfdUhqoekJKzH15y/D6rWZjr3xvaCbCehhO/V4K
	 qPtR8IP2r122I6Nk7g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.1]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M9ZXN-1sShb006ff-00EbfH; Thu, 15 Aug
 2024 13:27:41 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v5 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Thu, 15 Aug 2024 04:27:32 -0700
Message-ID: <20240815112733.4100387-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z+ooyaFpDS7iq8jvAIp2XsmBXpZojhB2npjf/glX41tKBNig1Pj
 WL2TUjDUURAKeC9n3mXonCUtEAvBLRqYLjKPvHA6Ggxg27AhzNZHyBB3xzsND1yFHUiiQAn
 26kydky2bOLb0tvWeynYL6qH7ILMOxkhaZpm8H7zfS/zedCxTGOT2OYE7q+cyCLdHLuq7kh
 nFON9Ndcl+9AFQ+UvoVFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AoIn27O/2js=;sblvzKK6bZqB92HxS/cryvlzMAG
 flt8BRP5dqRXHomkSg29bYF73FgCtT3wPsGdp1jZBZgDy1KNt3Ck+q0ck3sJNQ557agvWLhkp
 M+2eXP+URRGF43GRu/KFs7+AtaTJhtx7rnIvu5sX9fab3LZnYbaPt2f0Va7OQTGsqqpRQL6kP
 OSY+BkEuGqcGUQbCrchn5a+Yu7rN4FPIUCYEPJgsiMOQgSJdC9/tHg/MM5OFV+Mxa2qv1mhkC
 b6ihREom8QFFgt4eqYJNkbHc1NkTk8sFLcS+R0Ws5alpT+SlVnhUdFVcB5JEzTEIg0lvcxwES
 5umEcbrLgoRwu2JHccxAjgXQCCvz8LyDiad/2qDPDOBhN2h3z8Wtvmi9XpmcBy5gF11dqMwke
 +Rbt4spjqRkvvo5yT+od5ByMba2aKWM3calGYOHmNOt1r1XXp2x9WhC07Ge011F+B75AVCM0g
 uayaIM39g0FiYlLnYHFKdFQ8APD4Potd8pXP2eOi3AI6x0I1hA52Wt5UgT+u7GPUtbwVCsZC7
 cnvI7NsUIrr+ja+ck6vD7PzWF/adfRhJX7kECcupRZSFr90rVHgO79Ku+HGplwcwgKFUG21wn
 8lkK0/tShVpX0KdBBKLaTZg699efBLcacAKLnCqzu/Xeq3IAEffpDiwyoogpeQtFRNEah4PP6
 zUWrSqUU05w1cl7mo3cihwgUtlkKYNwwXtoXrKrUQB1uc/hQU740qTdJ5kbwIhtrfHffbzluM
 Y96DdaREaCMgcU89GmXhrFXNSRSF8EQMQ==

This adds a kfunc wrapper around strncpy_from_user,
which can be called from sleepable BPF programs.

This matches the non-sleepable 'bpf_probe_read_user_str'
helper except it includes an additional 'flags'
param, which allows consumers to clear the entire
destination buffer on success.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/uapi/linux/bpf.h       |  8 +++++++
 kernel/bpf/helpers.c           | 41 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 +++++++
 3 files changed, 57 insertions(+)

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
index d02ae323996b..fe4348679d38 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,6 +2939,46 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
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
+		if (flags & BPF_ZERO_BUFFER)
+			memset((char *)dst + ret, 0, dst__szk - ret);
+		else
+			((char *)dst)[ret] =3D '\0';
+		ret++;
+	}
+
+	return ret;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3024,6 +3064,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
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


