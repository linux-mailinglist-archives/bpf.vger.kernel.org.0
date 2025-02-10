Return-Path: <bpf+bounces-51057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3DA2FCF2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005AC3A3EC3
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3972505B3;
	Mon, 10 Feb 2025 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="GC+9vp8I"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B32505A6
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226186; cv=none; b=c7oJhk/j6zzN7rEmyXpu0YPr7a36lPDKHNNhq+n/cJkLIe11bRbWA3ZAlWS7b6rNOudh5LFqgHdu7XaoDEn4B1eSbIbFLyzXtaQMvt12iTPLcl9LrWAptzQBCFMEIrpASnaN6nopiVxNQG4am3q8r8IZRyrF+Q7GJmAS2IeApj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226186; c=relaxed/simple;
	bh=yfxROexsgY7ktRVyxOd10OXp2cS+inHpzuy9B75v+d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSE/PuxdOAEB7Yfis1PrQKeyhKKkUHD7fr2jiC53gtvoNEanDCc7OO11pUSYoHl/98nQxv4hxdOhU6zWczQLSeOsU01opJ7m7TwFXEo+VgUR7d8SPWqBYpKS95FYVanPnQ3Y5+u6WLWH9PS04km5/LPhCbMLtDiSPTWJSsUEGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=GC+9vp8I; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1739226181; x=1739830981; i=linux@jordanrome.com;
	bh=QaM92VVJ8sVRDEhsj6U41D+q2njMPqo34UDqJs8UQDM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GC+9vp8IUczQmUoiI9JSvglBQXvmi+p+vFbJKzMrzAxlSqklJNRmIQMyed7aS2cz
	 BZosuQ8ve2qBtXzNL7s1SAiK905089jVR00RSrwy/XHVS59NoLc6LrdM52x0QdIQh
	 qxBo3ggpqXxZhK6idng9quZkPFc911KjS2wu2KKdfE3aMfwsrT4Fa8HYP+tXfxg51
	 gG661zQiOkZOF9+IX8acTFdhIh4PgWM+J7UA2Md++l/f5MMjj/3IG3emHmGldHVTz
	 lKjC+QKfgSyA2m69Ja+83S1wuwpzh/prBoHkaheJqNageERSVtQnBcMtCxcNQ4Nc4
	 mDd3/MEekvtTS41GFQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.14]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LiF41-1t3pED2EV9-00mb9D; Mon, 10 Feb
 2025 23:16:38 +0100
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
Subject: [bpf-next v7 2/3] bpf: Add bpf_copy_from_user_task_str kfunc
Date: Mon, 10 Feb 2025 14:16:25 -0800
Message-ID: <20250210221626.2098522-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250210221626.2098522-1-linux@jordanrome.com>
References: <20250210221626.2098522-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iLPVhn1+1T95Aqyp/JoIzbEjvhwnm9MHdVWbq76iWd1Re8CFMgw
 rw6VicYNKMeojX/XL2VmjLIFPKguyvuuU+J6EyYOAzGPQySiFSjF7ctjENRQvCrZj6Im6kz
 2J8ksGTtnLnS40qhd8iKGnWzhTDvXQJMdaFq68jYYtZMNFeG2sJTYO+nWDltRNpYuoEA7BA
 aYeT/Kun571gsnGj4oHzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sBOuamh2D84=;vwYTaac7P1o26bVVcySYC50LHzX
 0crt+wTbbixcc6HKKhcK49+YhLK5CtkHyrh5219Fb0hWVcoB63Q9JYrs5q0CBUrqYOrfEXfnF
 e2DthCICKt7XG9Dgz1caRsYa3+TcrBRItgPU1qfimVbJF+nC9M+r2RuzwrJtarJE0bWK5Hdvq
 M9vJLerlBNduN0qR5ScoC3lakXLoG1zpeK3geuh774kEmR4xZXZLXkR1jAgGC+pjG6qfqs8c1
 3qj1fePRtpxWSwNgwLOp2EH3HgqSoJo+/bo0LJBTfLvVyYo4m+8DM058pOZ/ApoFB/wm0BenD
 EEdQY8heFaje3tx0/n9GUsQG0fJaYgqx/8WsDJQQeAIdCyCn9BpontewhUT+CMAKvE+7T/uF6
 ngTONs21U3IkircMdQMF6JXq2ydDFt45rPBgp/t18KOw09dZ2SR+Yl2fQMWMw+kVPFsez0DDF
 t1BwbZjthKYRK6Asfac7e7loWh6iV61klonU0wxHyse8SOzRmemT2xq+Xc2vbQLQm2viKEhlL
 jQVaB2Y4r+9KdY3TXWAFzXGdWISzprQuH6GIzVG+o3O+zCPLrUlVbiet7qmd++Kgw9xfsxggb
 d7wlyznxRJ6xgQrZ2htarkzUU+FpchrvyM9V5h14mWqaFaYbO/PuTpA+F724OzdHsm5+x2UY3
 e9wrt2Sufqcsue9a6wAC6FgYOy+23mTwvcaVPobTMPKfs9ppqp3eyDIMiz5LRu2HRDusWc3b+
 ULDMz3fvyNepLkNHf3XgslGm1jXg2uvsikNF7bcdoTGXhYIXc0BS6OC3psc0Dfc3pRXAPlJl6
 UlBjDuulZPTQF6zZBmXAcTp/2AhHnMa0O/6FZohT+dDfiRHifaTLrL+gOewf8u0Fv1RfLGkuj
 atWDReAvrCQqDDHNpCe+GrQf4Nbw+dtm5lR+WGs1S5e9wZJNyLnrag8XBibCFR6RcX16uyMOr
 WJ5OLIn3egJXKfADw+hXoXN90JCz7OJpJ8DBgV4BWr6Zx6uwxRJFNjIjjZNDCd22MP7394SQB
 op1fbOJTCXTVMaYzPb71ynkOdpywovpNUSOuHkwuKunIcTVdrXfmBPgJGi0LOBa4FRIferFzF
 6B8qIl3irZXtVOAZmuah3uJlZ3vWeZhH5z/cIbhG/1tFhghf/Q1X5a47EaELvV745RGJTpXvQ
 a4RMq1sa/1r0Hr8s9vvHoDvVQPy3hjM0ZJNWDjPIpKqyGuuJLEuOaoWpbf6mweJ4w183GxVTX
 0Ryj8wAXSCtUYUJHMq05Wc+BN7VurmCpGh9C0+8Duv4b2lp+slVCZgcsnauImqhY1y2Mw9FRT
 cMNOQRK46MY1xuQpzGKOI/xSPzXJfRzpRapUI7Hljjzgno=

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


