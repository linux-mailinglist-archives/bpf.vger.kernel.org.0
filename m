Return-Path: <bpf+bounces-36850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266694E3E7
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 01:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BA71F2133C
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 23:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416C15B0E2;
	Sun, 11 Aug 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="R1yKAktJ"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78928FC
	for <bpf@vger.kernel.org>; Sun, 11 Aug 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723420520; cv=none; b=m85N+WhCnL7sIjq86xJO5IVgZ7Ob4KCc/ITchBwA7Ecq118J9Tace3qpYVVTv+Ce0Cv9UzPwGcNVA1YabLd8Y5JK+CQrt5MhHQ24kKcnYwz9ypRY0KhLHg+2jdysw46GW5vaUkQaQ5+U+DV0wfdoRjk2P718D3AuY+yc1ZZhxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723420520; c=relaxed/simple;
	bh=x8E7p5JngwDCplc+KE3X4N+HweP7hFcTD89F0nDQjUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1PkIu0T0bUIsmnnHLryvx9yqkQkKeAupqg3IhXp8UcJodH3IV4qiACblDPL6YFWxwMA3Saei9GWffHhTOMIx8J68FRAfxO1iXSZmA2aDig548SBmfA7R6hsx1KrPRUFP8H7CFOXI13nL1CNy9XOWbGfXmZxP5woJ3FB/iwMb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=R1yKAktJ; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723420494; x=1724025294; i=linux@jordanrome.com;
	bh=Ff6ktVOqckV5nqh4tacjPnZQFaqla2tvY7n7gcen6rE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R1yKAktJn95yID+UmVmdVfz95e7s4WTCtl3AZ5C4IY8x/nXy6qwO84eUsv5a5XyV
	 hbqomR/1SWY0vsBOCP2QqHjchyOD8FD72TBuiSVmkHyGCGOj95LRYY+c5TIm0xfb7
	 itNRLPaGtYofZwukFj4bWBmt7gAoDkfebEBvCN8MaKZ8uYAkoGFWHJOVHMgP5m7Fw
	 Wh423sAPZJaFUBfDzGQi9LHFfL5HGKbCTEJlR8ARheccaDHOvH5CZqxnbSaLs3VHf
	 aLic0D+CXZmGybePW4+wKDyrQiB2c3uJk8K/OwBu0fwWIpRG778McxWi9N6qDXtX8
	 llVbevhpbn83kUB/sg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.1]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MuE0f-1sKNQx337d-014WX2; Mon, 12 Aug
 2024 01:54:54 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_str kfunc
Date: Sun, 11 Aug 2024 16:54:38 -0700
Message-ID: <20240811235439.1862495-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zStu9v21ajCsPy6iD5/qiuShcmYTJStVPkGnXlaIU1JaWE7UO/n
 74OAvhvCiseOUXGiy8gS2uHtD6DJR6zonREQwRvoulvCJSIFAdhT7AUyYQptpNegI6WKCiT
 0RYqkDhetgrBtLYrG03h/0QMVsIBItPjJl+OrbIaB2cX9SgmYx35jyqsIlhvOLHVE4oJKrX
 sOkSsp81r8yMWZOxCr7vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lSmbHtbUasg=;4P0U4osHVfHRkVeQZh82YTC39rw
 N5Ie0DP+GVrBRlGEthyWY8IkwiPC2Ymo+HHdt2XwrynLFxHRHcLOC+hOyAFbm/LVw+/tsbhE3
 xA94FhAwaqlwbNuBxPXUKCO7p/+MR7m70vcHrs/+4w55tpwZ6fbZLqjOeYu1XQjCT4txIH2oL
 zYG7vFGJXXd8L+9VixNTf4Fv2RnZiR1jhpyH97kszmxD2apMZqd6VWd8K7EQLRuyhVgJlK5cT
 bjIjgA2P+UtZ7LWCfPRqbFyRWoZi67vRX9gvp2Qq794XJzkjxwd957NTHslj6b0QG1L8XOk83
 ePxJv42DqRIBPN9pSaBBryHIzSv4Uy4oyociEtD+rfznXzIH8Yg3BO4z140B5mWqCqf5dbaVl
 BFw6Pl19DbKbcvt6AOc/WfRGxBggoqhmQbbNzSSNrPkOcpcXnljJPgu4/6d8dQfj0d2euHb/m
 kS4MxjLuv4BzeqFBUzlL07zPvg7OHDjfJU+p6o2xriUybbUM33KpeO5XlW2yQSwX7Svgl9fx9
 IBhHndPldPFH4BbkGK8uiK/Lh8VxxgjgpDRsMtXNHYxH7cakSRQmS7417Nq1y3pdNaEd0nPw4
 NdVIIs6nHplkr9NHgR5/XBWqOk/59WIH/yFZBcOQbLvDwDMOZIg8BQUDHYkE7mKjB2mIFzf+4
 1WM/l100iyxZmEJMAGF6l1dGUE3P26E9EESIko8MoakzozknJ3PNlY0aSmVGJ369iMcJWL3Wf
 6E5JzlM5NCLX3pV12EYenpMUaNOZ7OTrw==

This adds a kfunc wrapper around strncpy_from_user,
which can be called from sleepable BPF programs.

This matches the non-sleepable 'bpf_probe_read_user_str'
helper.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 kernel/bpf/helpers.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..5eeb7c2ca622 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,6 +2939,37 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
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
+
+	if (unlikely(!dst__szk))
+		return 0;
+
+	ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst__szk);
+	if (unlikely(ret < 0)) {
+		memset(dst, 0, dst__szk);
+	} else if (ret >=3D dst__szk) {
+		ret =3D dst__szk;
+		((char *)dst)[ret - 1] =3D '\0';
+	} else if (ret > 0) {
+		ret++;
+	}
+
+	return ret;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3024,6 +3055,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)

 static const struct btf_kfunc_id_set common_kfunc_set =3D {
=2D-
2.44.1


