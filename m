Return-Path: <bpf+bounces-37436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C6955A77
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 02:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63621F215E2
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 00:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E351223BB;
	Sun, 18 Aug 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="LXde8Cg1"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333992114
	for <bpf@vger.kernel.org>; Sun, 18 Aug 2024 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723940665; cv=none; b=ZIJw5DqVkekjI1ChH9DCPr/1p4ilt/oDwI9XJH7BxsK0o6EOLM6bMjdQWLO9Rr+sU+QnqgQS6MJvTgg+lDm7xBWBDsgblV2Y30t1T0WyvrOBuVgLMCPjVLQBwNmRNupqMpyXCuYtmdqSPlzu7ttVAoiz2bOtDFrBomCSQ4Ic8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723940665; c=relaxed/simple;
	bh=ShxksYbpLzfJt7S8euOlAPZ5q3IgwP/qHTlYGJr5M2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7WaaKA1T4/v2bhASs28oQoWaCc6FsElX/065OsuC67iUgd366nqgctyN5E996ih8aV2JNCnjMKKXPFSdHpE7acQPJpU22rLYjabXP3He/U6odfWAv9Zk8L9HZ+opRPnq6KMjQqe0RAGzpax97Apycu4s1m0cTOz3VMqL8HOyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=LXde8Cg1; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723940635; x=1724545435; i=linux@jordanrome.com;
	bh=jMcq+Ar+oIvdGv95hROfzm5z7JJXBUtmeqMH6/jZFc0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LXde8Cg1ZAlVkKXmmijFe9fPJ1//AMuj9xO9hlFd/pS2uAeo82sLM/p9uQMuCzxA
	 hBcCypKgkpf7/DsUtc/q3Y8BokOkJEECZpoM0b9DSbT839uxfNX3JkHSPIWmSQCZg
	 t630YPK13uzwO4XQDDGgRwgPqfJearCsbS1+NnYM1dMDur1us8R+UueRAX4kb8jgK
	 5DDn10hG03ZHSMiSaCotmQkkKyfRQ2EwwBmXYJCuLkPkHEV+pHaknV+e+MO6Y1FWd
	 uDK0ihFCZuctauKPM+lz1s2ZsmY+14NvY6SUsugqKl4MAdu+2W3oDdra1+sSukrcG
	 PAUkXZqGbR1+xeCAWQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.12]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LjYZq-1s8brf0DHs-00eLSn; Sun, 18 Aug
 2024 02:23:55 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v6 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Sat, 17 Aug 2024 17:23:49 -0700
Message-ID: <20240818002350.1401842-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6lQics20wU+u6qx79PlyzCjedjmD7yJoFaYmYSSqj2QwfG+BbHW
 cYcmUYhTQM8zOZj/gxwSg/0hraPvU+A3TEhqnHewh2zaK2HdlRsQVIGwo7Emaw0ywpdpHwq
 fG0hJbmH4DCMNi4i9pec4SWfVhtqa69DM//17uHEIFUuldI/CdamGGh+DPe9BT59VUM2G0C
 K4Y5+4PD691OWufQw6UTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2l139Fq+31w=;HbP8IcL7li0NK3HYtTWsZMZKt8H
 jifCrYz47a+mNoO34zc+0S92pSMlcUs3KD51oyFn9v/WPRNDsoyoqPiRR2F6k0pUOvJFCG+q7
 8/xiVQ2NQLDdaRdOGXoxedvHNt9rhhlsaJZA8hBFAbcDgSflS5WI0xE6yCm1lAJuRIK5M4kGr
 i9WnkaP+GDh9Z0asxiwACG2S1PuxDY5qEewOhYQgiEtUg6LJdvWUtHeckiaPdiqFg4btoTogd
 BZbkZaB9BXNsfHrj6ts0Lo2oP4EWv0xe2gHuEoUL3KXYR8CIUuFVaKY6y2p723zgbDcJuwovB
 LC1d5Pfc1lEABj+Epf44gSDNKm0WrXg6ctGYcFex4n5A3niJFD7V9xBHpugm1XLvYh+2Haeg2
 NyYliLADZD0R3EkI6CrzaHUSTEqmjjx4kcXFBO1MRLl7jDsaLg4nXvYRPhkS7YUDjMpJtNA9D
 1gYrp/lJsNtRioFEc9noJ42+SCBn5/C3Q0pqwGzXFVSpVT5XN3k49PlpXR/xjOkZ38+smJkP8
 nALEfurrj+M+mIaLO4nwdEsLUocLrI3iv0CMgFwzQdQt9xRguWuw8kBs5V9e3OzKtXSfnWmmb
 JRVAxrMnERrKlcbeeijW6ZDzzydctbfbvfSw9ZgoVJFJRy5tG/ohbzbfAYTr45ApXkfwqae/d
 X5nfOSxdw8FXLu2ccI6SqK3BNO+E7kSyM/tIacTeGiFRE43VAwthI2SGpm/n556ou3mgi2Lft
 RRNIclKkIKq+bdG0c5P0KcnKaDcE2dEQA==

This adds a kfunc wrapper around strncpy_from_user,
which can be called from sleepable BPF programs.

This matches the non-sleepable 'bpf_probe_read_user_str'
helper except it includes an additional 'flags'
param, which allows consumers to clear the entire
destination buffer on success.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/uapi/linux/bpf.h       |  8 +++++++
 kernel/bpf/helpers.c           | 44 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 +++++++
 3 files changed, 60 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e05b39e39c3f..5e6be3489e43 100644
=2D-- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7513,4 +7513,12 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control bpf_copy_from_user_str() behaviour.
+ *     - BPF_F_PAD_ZEROS: Memset 0 the tail of the destination buffer on =
success
+ */
+enum {
+	BPF_F_PAD_ZEROS =3D (1ULL << 0)
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..a0d2cc8f4f3f 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,6 +2939,49 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
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
+	if (unlikely(!dst__szk))
+		return 0;
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
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
+	ret++;
+
+	return ret;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3024,6 +3067,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)

 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf=
.h
index e05b39e39c3f..a8dcb99ed904 100644
=2D-- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7513,4 +7513,12 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));

+/*
+ * Flags to control bpf_copy_from_user_str() behaviour.
+ *     - BPF_F_PAD_ZEROS: Memset 0 the entire destination buffer on succe=
ss
+ */
+enum {
+	BPF_F_PAD_ZEROS =3D (1ULL << 0)
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
=2D-
2.43.5


