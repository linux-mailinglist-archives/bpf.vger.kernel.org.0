Return-Path: <bpf+bounces-75754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6AC934BF
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5015C4E26AE
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C942F5306;
	Fri, 28 Nov 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ6InP3d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAA2F2903
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372492; cv=none; b=AvFspUK7t+rxfWeiow5AWSS3QeLluo7dGlJ/jnIJIoPZlmefEtBIlvJ9imddQxXLJeIO8KWl2j2HdZ6JKmtkzYZ0CegSFELIVqWuzp5ogf49f12svb4oZeofRoK6acjbnO+6R9+wf4GMdcREHFTjMbchHhCZU2pUsamqxfYyuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372492; c=relaxed/simple;
	bh=0Pk2gc3Rro++XtfmSxYhhbNPKJOh+/pyoSVu60A1n4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkT5VfhEBINfBepw6AhjlvEUuBDqZdI0uUnp0isFdIETB1WSl2NwkOZ+C+DQo/bqHJawVxfYUfO3fovQE10XWtZ+pTa7Ew1LKBbUvNf9SvlYqcvjz7QSvboJ61I7QWHEnBwkRP1i5dcqP1dwYea0zn9YH16TOPf46dMqIf0LhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ6InP3d; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1041010f8f.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372489; x=1764977289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUKZtp816Yi0TtnBHsGkmW2OwUTqMUqiDuhoK3fRm/8=;
        b=KZ6InP3dNmmgbPdQmbPJwZotHzdPqu6kHbVWfPSKcu18UuuEUqZmapJgS41GunJR1O
         wDPvm4j7ZrLATk/TtKnum5sjUVavRrOa498zWqe978shHq6bDZq0VQvMirkq4Sx6MLyY
         PkBc3iRICdtDTK5yWMlsEcL8fmcnMBvja9w6S77uhNQRtxIs7/BuSTvJbtzS6y3HZNu4
         1pjwpEVJUglUy9ls667XxNgkaO78qQBRdJQOg1CrELgMQkTBnsaY9a7S+uGdattY+jZE
         5odvPArw0hwn6kK/ZCnCBOt8z6aK40xsVgg9DpL6eNDwv+10ays/WF4L7Jvu7i5cga3u
         GF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372489; x=1764977289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IUKZtp816Yi0TtnBHsGkmW2OwUTqMUqiDuhoK3fRm/8=;
        b=k2FMmK7XvsBsYodcX22c/UQo0ltV9ugkqv3zFGr0A0fMt1bhUPr3tOcGxtQXHAXBqh
         lBVRfJSMbPDLlciu/aW4rEd5OaWWd3VE1KVRsoM3WwpcxqhWLZHs+sfmS+pj/2nWinmV
         45pNHQEHgy7Y25/tWki8PoqXGDOhZTuszDqFcu0WLz1ZVs3COxRzQpyxqHPuaCr8Msj8
         wY4mKEHVQ6nZTIMmnmtkqjdkGNI6SEKkaX5VdyFuRQxN3+Rp+U4Yt8r5oV+5aQi6Gkal
         HDkE2Gby1tMkYrXB7zMWeqKE5dFzJRgh1xnPBIOSMqlFjIQqJaFuAU3Wwylqmmdvx+4B
         q4nQ==
X-Gm-Message-State: AOJu0Ywc4In6HZoCIOE/nhSAevKIFRv+wzRz1L28rdJ0StDk2rpJZIwA
	XvsEWiF64ZaNI2BKPyd/3kG1Cxw3Xx0D425Pnxl0CAJ8pkmMl7U2VVNGXfJw+N3N
X-Gm-Gg: ASbGncuhdnEqgOnzDPlr6DAP2GDYCjV+mONuSDvt0Q1AuCX4XBpL4M+4XAZb4JZHZdJ
	B50ttzbfUAuFGZE34e6z+2DLNyS+gPQD5S8M7NvkkaHkFvtgC219U3Rn4S42is5edgIK7uPRRoN
	9TDunh6ZjPPP3E9J/L+4AT/0Di4uOSksoNoZ/yvuDuMeHwvg28BLChmOkU3WpbVeFLSJdTcKGk+
	JQxjuIiEBirpvhIdIV7ApbY9gEr/mgrt/M/Tu7HFxr9oeWGH2Fy8uYQ6XFEJUUCahvZARk8TgUy
	ICYhT9edRUY+mmCJvaZZWZ6Hzvzwhehyhm+RebH6wOM7biCZqbyvtbVxJL07aXTzNW/8K9cxFpc
	fKreNywywxph/RlMmj+7/Q2YXE1r1kCHFy7+wY5mSzoLiQ1PQsBPGw0DEHG0c++I7Q/x3NFtxsy
	xXQPIdmNkJPzZQQkDIhYYZhxkrXH0ot9Qt+3EU8I6LDuUyXwVQ1RgS/4XyZMPJPrAQ
X-Google-Smtp-Source: AGHT+IEPzOFa1KiUawD6nwcvPebRMxHnR3iNFI4/3ChYNw6ARYh4jIQmO1ArKyjX8NzMMLziI5JKiw==
X-Received: by 2002:a5d:5d0a:0:b0:42b:47ef:1d7a with SMTP id ffacd0b85a97d-42cba7b436amr40272542f8f.20.1764372489094;
        Fri, 28 Nov 2025 15:28:09 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1c5d6049sm12425201f8f.10.2025.11.28.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:28:08 -0800 (PST)
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
Subject: [PATCH bpf-next v2 5/6] rqspinlock: Precede non-head waiter queueing with AA check
Date: Fri, 28 Nov 2025 23:28:01 +0000
Message-ID: <20251128232802.1031906-6-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128232802.1031906-1-memxor@gmail.com>
References: <20251128232802.1031906-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=memxor@gmail.com; h=from:subject; bh=0Pk2gc3Rro++XtfmSxYhhbNPKJOh+/pyoSVu60A1n4M=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKi/yRitzwO4MLQyBHE4m6d39DrGQHU6bcxNGF WTkNUql6mWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSov8gAKCRBM4MiGSL8R yuKEEACk6II5TgGIWLC6JP0Vw9ubWjP1vLnYCTWJREZIjEjVnEzRWJqEzkxMxHrBDN9LUkGlH52 JXBmSFZuA1AO4tnurTYIsjAmZkLzMPtjJnYyFtvxKbC1pQYX7Dz530+ZoeHdBwJZctlyBBCb3Fm P0+7a7p3tE+Xqj6DBKOUINUv63lJgDM8F25b1cxq4+LUx+VGNoyGp4M6jAEqRBR/eU6mNaCP9u4 Znr3b5ZlsbO+foytcC3beom1XsrOBllmI4mxMu2sPXzvEAUztho4FhRMo9BkTP68YmN8+WXMNYW tlW4M1torlTNRGOJTLHeabSq9+srNIEb7a5knCQe2ty+paL/r7zVUdIVc24aFwAxQO23b+kRLjg l0FhROUUPDHrBisS514X5p/Gx1zcGkV35+bYceSmkcUkANu5uOYuFloBiWpotz8PLk30PS/AZ7o /p0OFUqpzRZGCMnuGdZHeulE7oXzELGAeidDXVoeTf3IPKIgKmZ0nuzasJlVDmA994lyyfo4NAI UD7p4lIWTkmHuHo6Z8HP2EkarhSQsDDLuGZjFPchcoik+4C9rkGFGOeSNcrPsK56gfvfKLBBwIf 6NwggiMhjrSyTQWp6fz286wI+gXzJZmimZJxjUa5NTFBwflXYx3V83fhUKBtgWS4emar6Jt5qtx aPvcNMJoD7DOuZg==
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
 kernel/bpf/rqspinlock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e35b06fcf9ee..f7d0c8d4644e 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -437,6 +437,19 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
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
+	if (check_deadlock_AA(lock)) {
+		ret = -EDEADLK;
+		goto err_release_entry;
+	}
+
 	lockevent_inc(lock_slowpath);
 	/* Deadlock detection entry already held after failing fast path. */
 	node = this_cpu_ptr(&rqnodes[0].mcs);
-- 
2.51.0


