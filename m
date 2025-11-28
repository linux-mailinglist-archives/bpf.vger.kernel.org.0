Return-Path: <bpf+bounces-75742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEEDC9348A
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0B924E11EB
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2962F0C66;
	Fri, 28 Nov 2025 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+ZAAdfL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184C2EF66E
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371754; cv=none; b=dWz0ewPDw5Wfh9O7JHdxE2sAnwOQmbfVMIUnbdK791aIiNjX3x1I5FZTpTc/lL6XQvUt50W0aA09dNOYtX8ciz+8LGc7cwj/Q/15lFSf+2jK3qfYTUVu9nA2/QzzjwOLmEYcnHuPa33a/0/E1KDfjEHGTpNohaP6X2cMoOssuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371754; c=relaxed/simple;
	bh=HPjDdIpWo56NwZWbvQfQf3IdnJztAo1v5v7+58EgrUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy+WrMql3cmsI4TYZgAw0cqEjXgIVb8wwMvqhEd2FaCkMSFhJ7jibMyDkaeV6ZZmsAiAIZUbrs9zjYBc5hig2G9wkIKUBX3uHREVJ57H5tdxr3pXajV8hmuh+xieG0fM2p/bcPiUdYIwqCxlQgeVmltGl+oZ6yp1+Zqyh6gtBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+ZAAdfL; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so15852065e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371751; x=1764976551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1gsSNwo7Om1TQ666ExcaUMG18e/bAB0Vd9BYydQNL0=;
        b=R+ZAAdfLqJQxQRb+4UMR/dDdP1hvz4VAY4bLiLjmfGqHio8UHVa2AUndjv4QZqpf/i
         6kpBPoXwDgPIODPwc/v5IZ2QLHImJJfWHMupm0GarXxizYic5YOU8BpcyVoKGKObdVqX
         zBISsasN2f4fARfrjpJ/d/W53QJtUqP07TxT+ph900Oun7vMzu4w5o89uFtpYhEgBAtS
         fMMh2cvXwtuTJnmPGj2OeV5qsiyQU4ju9yfRQwDYvrpk6rZde8KzPcTtQ8Zb9bETM3WV
         k4edvW8ZqxjBVp+NZsNu10Keqye7rgy/q+gMHOjV2kw4uMzuC5XaLLlgK4687vRzkYKs
         hzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371751; x=1764976551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1gsSNwo7Om1TQ666ExcaUMG18e/bAB0Vd9BYydQNL0=;
        b=NRd4KKNXTvsCrCjY4iKvPqVQ7DzviVyX17kGl0Jyh5ZvIYLcgGXI/97YGFAMuZ2SzF
         UcZF104PHlVugv7kCQZGOo0w8EKg8gHp/mlhT7G7ijbPVf82Ep8r4T26vwPmvi8qqzoA
         6TU91vLcJ/1mcwmQ0XJjIHYLw6/lrbN50/4xXLgSGHkoGtbj0DlZrnEEjRPd7TJajVnE
         SlbPlH4+KEd17W7LVNyoedwOKrRLZGmX8pbBNUUtYWdx10gqpRrZxq5LbBLx7eDHV7RP
         VM8yWd2zAItRv1cEx57AX+pN0AkbxywLz+rw7ZcV72iRskSO5lAbA+gfhu1gyfynESFt
         L3Kg==
X-Gm-Message-State: AOJu0Yz3NNhbthAROEtOxa5G0sGxQShIsNn9+5J8ooCNN7OhJYStV1OM
	fmWzYPnHwS3dJK4lFIy1YbHA+VN0hFAdq/L5xuQHjajXjTxBJRxRjxLruXzaockB
X-Gm-Gg: ASbGncsNF/mN83SeIgJpW7agNAdiz4k0DyQuqoZvbayNGaGBomDVP6Jj0HZGu4LkkAp
	CKcKJyewpdWugdbUdksZ4KlywLZDZ4nyGdUXjPzgsj82lRNFnMjk8DBvMmMIrXHMOgVlLdK/t5X
	nC8yKzDarnQz50RPLsOBHWTC9ztgiyRnRu1sBXy8ab/kcaazLVmmoWhPr+JB6F+2w6R/uuOyKE1
	bBZt02TSPLXHWRDyCrWlmgwnQ+Zq8d5xkTYszGbOgBsJL1JtJ4ev4L8tX6SK/Dp44nvl2geIDz0
	r7ops4tDewmTb8Jodoqu+L5npul/b0WEz8twi1CKujrCfYrO3MVSpZLrB2ZMsQQGzqyMvOSYQfB
	ELWgK0BRbyA+ejxORMmoU63t3Ccw8pzdMzWhVcWua8MXFgtcUPMbdgzK7OPsB8D9z249wS6Urth
	tVbMxYQgqXKV43RiSxheydeHuVruNE6+EOwXMhkbCCOd0W4IuA0QPqk69fJH7lBLT8
X-Google-Smtp-Source: AGHT+IFbsw79ErsZR+qZ4VhVdfN0377Cu+BeUftVAELFFw/Igp5+VJwjju1ogH9owg8Bv9nvDGo0Vw==
X-Received: by 2002:a05:600c:21cb:b0:477:acb7:7141 with SMTP id 5b1f17b1804b1-4790f03337dmr98672535e9.3.1764371750742;
        Fri, 28 Nov 2025 15:15:50 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479052ec685sm100652115e9.6.2025.11.28.15.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:15:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>,
	Jelle van der Beek <jelle@superluminal.eu>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/6] rqspinlock: Precede non-head waiter queueing with AA check
Date: Fri, 28 Nov 2025 23:15:42 +0000
Message-ID: <20251128231543.890923-6-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128231543.890923-1-memxor@gmail.com>
References: <20251128231543.890923-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3426; i=memxor@gmail.com; h=from:subject; bh=HPjDdIpWo56NwZWbvQfQf3IdnJztAo1v5v7+58EgrUo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKiyR044hFl5XABqbMyQp5OpsxqPKIBBPTDQK3 3KUnfUfJgaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSoskQAKCRBM4MiGSL8R yi9WEACWZvB6O382kH05WgxfBnSMM1l0KwAoAK1b/x7WibCKR6GKm7nfjN1kRV3yxB4AxWHW7ON tIHs9u0sjgICZLD6Jlvu2XiVsrTxkSVLmHqePao4QUF5gcYX/ug1O8g4EtlgL/Z1sAzw3fXuoBH QozD8ueRWMMYdpm+qeM8scsIEtCPQ1yE2QmsGHNSPM5p0fKkxnys/0qznODoBp0cIaAB8oVRUIq X8/3rofyfES2vRcIY+VyKTvv+BLsfZmDRKZxpenng34K1whTJEvlgPSg/QZ3hnh1YxGie4gA7jF 8UHlOF2MykUDwbrqy1ETORjdSWTA8mWm+pr4Rl0jljOiOVF+VvcMWgKNKjebcW3KBsfmN1Lm/yO 0yB5zWnnWTBoszTebcCpWUCBgYR3sIbvutrmwkI72Z4lyVheybpMU9oGm+oWv8QxjoNN1j3gxmO eBWLbQyA55SCtJKhXBVroiS6077u3g1bIlqOjNOFbTnqHXARd//fjIzBvGUub0bUQlXGUdovCv5 gtN8bmZtRwd4sjakw8veZgwUJWD9sLYsTM02fLyZshIav4chjMSrTKqwHpmPG5wjSjYw6iqgzJ9 f23qBpajWSsWm6GQER6gMaPQ9Y9Sg6clVkkuLxsOMR4HCT/wN86mNBLVuc0g0JzCJB3bDs9RUsZ HF408my+5Snvmkw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

While previous commits sufficiently address the deadlocks, there are
still scenarios where queueing of waiters in NMIs can exacerbate the
possibility of timeouts.

Consider the case below:

CPU 0
<NMI>
res_spin_lock(A) -> becomes non-head waiter
</NMI>
lock owner in CS or pending waiter spinning

CPU 1
res_spin_lock(A) -> head waiter spinning on owner/pending bits

In such a scenario, the non-head waiter in NMI on CPU 0 will not poll
for deadlocks or timeout since it will simply queue behind previous
waiter (head on CPU 1), and also not enter the trylock fallback since
no rqspinlock queue waiter is active on CPU 0. In such a scenario, the
transaction initiated by the head waiter on CPU 1 will timeout,
signalling the NMI and ending the cyclic dependency, but it will cost
250 ms of time.

Instead, the NMI on CPU 0 could simply check for the presence of an AA
deadlock and only proceed with queueing on success. Add such a check
right before any form of queueing is initiated.

The reason the AA deadlock check is not used in conjunction with
in_nmi() is that a similar case could occur due to a reentrant path
in the owner's critical section, and unconditionally checking for AA
before entering the queueing path avoids expensive timeouts. Non-NMI
reentrancy only happens at controlled points in the slow path (with
specific tracepoints which do not impede the forward progress of a
waiter loop), or in the owner CS, while NMIs can land anywhere.

While this check is only needed for non-head waiter queueing, checking
whether we are head or not is racy without xchg_tail, and after that
point, we are already queued, hence for simplicity we must invoke the
check unconditionally.

Note that a more contrived case could still be constructed by using two
locks, and interrupting the progress of the respective owners by
non-head waiters of the other lock, in an ABBA fashion, which would
still not be covered by the current set of checks and conditions. It
would still lead to a timeout though, and not a deadlock. An ABBA check
cannot happen optimistically before the queueing, since it can be racy,
and needs to be happen continuously during the waiting period, which
would then require an unlinking step for queued NMI/reentrant waiters.
This is beyond the scope of this patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e35b06fcf9ee..7d0a3fe96165 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -437,6 +437,17 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * queuing.
 	 */
 queue:
+	/*
+	 * Do not queue if we're a waiter and someone is attempting this lock on
+	 * the same CPU. In case of NMIs, this prevents long timeouts where we
+	 * interrupt the pending waiter, and the owner, that will eventually
+	 * signal the head of our queue, both of which are logically but not
+	 * physically part of the queue, hence outside the scope of the idx > 0
+	 * check above for the trylock fallback.
+	 */
+	if (check_deadlock_AA(lock))
+		return -EDEADLK;
+
 	lockevent_inc(lock_slowpath);
 	/* Deadlock detection entry already held after failing fast path. */
 	node = this_cpu_ptr(&rqnodes[0].mcs);
-- 
2.51.0


