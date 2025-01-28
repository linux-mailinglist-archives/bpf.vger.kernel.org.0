Return-Path: <bpf+bounces-49989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5926A21493
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 23:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4861887F2A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD51E0DED;
	Tue, 28 Jan 2025 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="AGuQb1aq"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8171DFE3D
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104258; cv=none; b=P7yz+FhUiZUUFaeAWrnUQLtgI2vBotVkFVFzGKrcouHMZqVUwVHqnRIRL+sDnxAIIq4RHNMxwG/KbtSeTEWRgr529FSEY4EoXhmut669TTSOxKxTK2fKSBOe2G63qJyd661xtoZ+KlldprhNqclJS0Zb6iYJULJef6U9oBTSsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104258; c=relaxed/simple;
	bh=yfxROexsgY7ktRVyxOd10OXp2cS+inHpzuy9B75v+d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bysH4EFJc6l4GJNR7KezBrSHHr/yhBILvwjJtXTHIM9zlRY2s5LH27YvRcdn6iHrFJwKCOq7sPu/pcVPoggOl+WAM28bmTSmTZlVuIN0sT7aRLbsdltr5njBGSIKSdNosY1s5R0GpW8zMivj9Wi+P3Lz0e9sCnjgs4K/buLwBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=AGuQb1aq; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1738104252; x=1738709052; i=linux@jordanrome.com;
	bh=QaM92VVJ8sVRDEhsj6U41D+q2njMPqo34UDqJs8UQDM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AGuQb1aqIhkM+t4+H+aKV9x5h0pPsY81c0aAaxeguJlpZOirIYLpZfGQ46W7MO0+
	 z1sb28CiiDEFcQWUygQmz51ckV3HC/D8iCml46wSBYfMUftUAf0+IE6nfTrWJsUeP
	 lcMWh1UOJNhztcQmiTMpHHA/OS4KqZDTyprfEvqbfO/RukoP/ENVZJ1plolEt1II/
	 F+tIZAkNbwjmq0W9t8gMcgvEjNlTRT1vpocQmKZMwZPxXKboicW074XcGaowS5ccn
	 rNFR21spsnBOSN47SVqQRihYZ5X1cljtGzAEFBtYdEDLWZvApOr3GbfmKW8RjurKQ
	 3hytXralyJcjqUJG+Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.5]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MLvf0-1tXNSq09jI-004vGQ; Tue, 28 Jan
 2025 23:44:12 +0100
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
Subject: [bpf-next v6 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Tue, 28 Jan 2025 14:43:51 -0800
Message-ID: <20250128224352.3808460-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250128224352.3808460-1-linux@jordanrome.com>
References: <20250128224352.3808460-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4xRNZXuuNESdqb2Tos29jq2ltKwzIJIj/MAmdqpTx6w0jR8Lksm
 UjLxdEFq7BpU5ZSVRgbHpG4UDMg1WATsegYcoM0SZ1bE5JYeiQzO/oy7tGbTSloEh1Yq/Ug
 yUCQxc98CuwpQohOGSqe1alLhLnZ4D1qhH+b6wTS8OIrm4fPeww5udt4QDV4F2hOu9fSFyL
 DGnrJOZ8BP5xI3IepRMdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:29i+6/+81s8=;DL5HqVC7ikGGjloURnjlmdkEFAI
 BKIy8ftc/phvEFeIiW5aSLRhpQ6rxdAtIp9L9+MgKxlUwkxVsxiW+TZ/dCqHrWgPXV6SC9Lni
 8MLkTuacgufXQVRdAZT0KS34H9ayvE+fZ2jIfBWATok4spHxOowu1qGQ7Qn7CqR7v7foJC9WI
 AohZzFhugQXBxzs4m6ljkmYzQn1vPaleKzTWOXQuB5Hzeai201PkldD94zOobP5HCgdS609Ij
 cDNK2QeldpoGaNLZPxd/FHMtSjh4MjDVb2mN6CK67zOjVWKaBCWgM3WjBrVOEvRHNgSNFCcDd
 6vIh9idm4xSyfK+Z4qTHnai0hlxYdwNXnNl3NyAlZ2+HdyUpXAYwabaZeUrBkdhmn166hVxZb
 0RxY4sHRFUTrEKlJCN1j5hsvIFlC49FJtwCpTMgSuIZqhZYXPv1sJHLq15ibYGw4rG/WbAu0l
 6NS4WQkP6kY/G63H/7VTyRwQayvymlFRrNvuETtgHSGsMN7ujV2w4JpSJgh21vM8ulnKelUTv
 PC6Em+4XlxCvOr2PECM/ZuvV67zPrYDtCtH7mYFCC0QiE6dMy84EWBAWv1chIxkxyfbJjtUa9
 TMQrrg0Y20RENFBn5PI7WhilYFJdBcd8fxTKpMwDeWL0mVyzSxh2od0ZZkRgwjEnL44cWJ8l/
 49vBsC9pW5Y8AIzGkw5BZlpI5xojp3U7Hv8lPJWNGRRpjp7ibWA+rr9H6CMk8LLSDCGchuojF
 vfHCsAczueUsiZsDLsgdxGkrjumy/rMlWgaF+dhFEBzXTR+XFxrXTQiN3XK/1IXaKmH6TGvkX
 BwoHPMP4LQh3mOGzVb9SYeznAcsgknOy7UBm7Z+OL7p0mhnESjhvnEK3QSYX3s7ky5RhY5Fv4
 M5W+pQUnOn96k6jiDKpQaVJwr9ONy164M1nOGMqJc/vyxJb1FcLd6FUWGm/41G6Mjdr3FzeS/
 ZwgM0Yn1g1tJN3fUTeofAc51TmPf8KzQXeXTRQ2I6+NvyB87/YIHQ8zthdsYFMMowOSERYZOH
 CV/LGNwpfEMn48n752B0GwBjm1clkYmYN6rq3sbVWV4rV+yvPWpqLOU2GIeZkOtQEaDKLLNru
 UitHtuV2if+v2+GUu9drc25hHsevvR+W7yz2AZqTnrGwfUCEjuZ60aet57WrgabXIgji3Gj0X
 Ny/rOJ6Q7dPaPvmOoZ5CS+/bIoZWYd66ln12ZKZaNFF1AtKdN5epQFE7dcq7FNhanFAWcq7OW
 hg4J5qvWBZPsgv9f5lLvBeMESwO7CZvpyw==

This new kfunc will be able to copy a string
from another process's/task's address space.
This is similar to `bpf_copy_from_user_str`
but accepts a `struct task_struct*` argument.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


