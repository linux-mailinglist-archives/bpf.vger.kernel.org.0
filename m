Return-Path: <bpf+bounces-75740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B4C93484
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DF9B4E128D
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68272EDD4F;
	Fri, 28 Nov 2025 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euL/srhc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD72E8E0E
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371752; cv=none; b=jehUJ5+Sx0NYGZrM5n/ST/tsd5MzCKk1WtPq5h7aKgngiYaDxh7fPPsz+BfjAr+CGqJz3v/9FH3TJOmzH9KqX+1R/h9kmsLZgt69OZv2UEJiZERcqMFyhTDR23gjVOa1pPHBvdghhG2Obt89sH7lKVZypZ52ucJxvwucxYv5Zqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371752; c=relaxed/simple;
	bh=gTlsucPN+Y0mBc8RY+SSQJp/BD5P+ez73AV1R7l6/gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epvqMzFBQiJIdDiTNIupk5gApxDR3kAE4u9oU5JNoYZM4MUaFP37oLS/2/rQIwqZ2FsoHoNv2dXrI/YnqnRBlMyiMKKCfo1qLH6uiu9gue4Er2jDzKeqbwXwcg/2HyMK18x5KV3UqKu7Pc5rE7HunEha8ips46UQSLWAsfP17cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euL/srhc; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47790b080e4so10649545e9.3
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371749; x=1764976549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIDGDZlSgsx03nD43kvh47pwtR5noL6i7s8CZSj47Fw=;
        b=euL/srhc+M6Z2nPOCaXmXnrpoW8xZaxY7VF0yoZR6J9PZfIFCBmhRRuzkBIvYU6LAW
         OpPA4kmv8yjTrPBG6mFHnxCtP9Jctri7/50kTnRnCwVBJ2vz1hrdiNUHSy0mWz2kQMfm
         HEy9dQND9vjHvEIIW8Q4QKqGHSyEMt2H7F9tLJIgdfop7Cg2HxFEw3TghtV0Jvz5jm+g
         ofDa0U+4Ls41Fjy36mS0EuA6YkBnWcRWUZBnc/zv+BWq3QOytX38WOKFf07fjRyiupat
         SlJmjz+FWoZqHJvP0C2wgvJopmEVqviJHWkEmBPR8mwiwbM9zIh03WB/F50LgKmtjIWc
         Qjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371749; x=1764976549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jIDGDZlSgsx03nD43kvh47pwtR5noL6i7s8CZSj47Fw=;
        b=FTY9vvx3evnyyma3Vh+AzR1NLlxMTPRbnZ9KOalEToP8vFAv042AKkvDCeipfPldaw
         ktD9mYWOAe5la6BRdbPsH7fzbejH9+2DpFP9rBV5NxiOlIYrI8tP21ozc29uaqbGP6gp
         wFBEBn3ODEFDcez7D9GEd1D1dbt/iu1l/uEtpYAKYzOGybIIDgc2T+gZuQUr4DX9oesN
         UfOGFiNL6kh3lls0/vf114D70Gne5KvbwasIxtS3VoVIDs/insNqz9/Li4y4QDd4BL/0
         owgUh60T3C+Zp2tIzhrkKmsW8ekJsIzsWMloeDg/FLEYypKkMgc7ZAkMZU0hlBa+YevN
         +eNQ==
X-Gm-Message-State: AOJu0YySt/k9KmAQzW823rYsakAEtdA4pHw5B/z/cbPNigdMwIDFBAjN
	234cBrqf+51Fe4PAH+wEis8MzWkgKdYQAKFToBqkFXLZsibAQYU15Nem9aNZuOf2
X-Gm-Gg: ASbGncthRepVG7grvL4ARODQG49xtCJ9Sx78Wjby3CKz+S6mBmQuR/wacvkLUeD8O+S
	brJtXVwCfgRMVL7G94YOnXrIodKhmqDyw6/dJ/zO/BQ4VtxNEtmWQyJeu/6DUGB8BWcYhKtTxBb
	DR8TYDIgvAWa3WbAurbower/ZJRWB05/ZS36Cz/y8s82TddKFyxccfe1/khn2yjSMoYj59qZ5Om
	Wj3BA5fiXfKkuGa20LEp73vywyXOFbzh07pToVd7cJhMOLh0a/H+BAczqCSNLZx6TdjMoqRBn0F
	x+TJd7eR+qUzs8aBisVy8WcGb2e/VD3O3x8eQwG5GgXghyksKapFp64KGBZguO2ipLkCmNlxl+l
	wgJrYWYXqbZvTopSjFgoeiE+Zzpt0L9dYKniz1EtgWcgvqkfJkgAV+VM/ZOXi+75S69HzRE6aH9
	YypEtjeMW/AdWUeDD3gX0eVAQB7GZl/o/QpCVYmyhIaAEsFOWHYarOOicK24LUAWHi
X-Google-Smtp-Source: AGHT+IF+Cw+uq2NuiVatUCf6cu1eu75ZZaCqZLXjgVtDgm2jN19fKn4GcExNP1peFn1hLng6pXkwOA==
X-Received: by 2002:a05:600c:a08:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-477c11254damr287283485e9.23.1764371748498;
        Fri, 28 Nov 2025 15:15:48 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479040bd209sm102033085e9.3.2025.11.28.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:15:48 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jelle van der Beek <jelle@superluminal.eu>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/6] rqspinlock: Use trylock fallback when per-CPU rqnode is busy
Date: Fri, 28 Nov 2025 23:15:40 +0000
Message-ID: <20251128231543.890923-4-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128231543.890923-1-memxor@gmail.com>
References: <20251128231543.890923-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935; i=memxor@gmail.com; h=from:subject; bh=gTlsucPN+Y0mBc8RY+SSQJp/BD5P+ez73AV1R7l6/gg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKiyQkZ5IXKfEH1KNZ6eoO3hvgcUzy9PUpfUBv lYyTtkT1g2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSoskAAKCRBM4MiGSL8R ynoVD/4hzOYl766u3o2kujJQYN4vKUPuhcyJirWt8zmCtJZKy9/Vs1eGKM1thHC3/JC4vQ7m2TT OyTbhD1RF0zFqjZysq7OZykTLOyl1In1dlbn7ZgVPojIlwcPFaPToY4++DMgqx3Eb2HQNEcw91m 2a38Sqh03G8j3l2zjfCuNU/R+0SVDfsTaxkrF7R+KI4wUjh9Vbb6MnK6aNOGwiTEgS8Z/rfe2FV NkvDc5JF8Y6ln40+6zjM1AoOKaLiFdKGg1GoNgyesEM9ztWN+VHEmhCX8uHuHlE3rLjyoqcC72G vgYSGidt77pLkWNB/ra70wZzaFXWctiuh2XtLTJgnhPyHlBi3QSQFaLf4crQ31hPnPXmmlZqvqE CR5JeLlbti3sqdA1ub9km0n8mFqa9hde2XS6ClfQYMwoghgzSgAE0Xfl08DDTNQhHHA4DQoK6Lz UjyDjYhbs0SK72bFngkXOcnxfvd77Lk+wIXMhx8xwTyqo+OoCJnC9kTIzSVwD9TZPdac85wcFsz QM/VP3qzQI02zO9SpMSOkU7ZJD330GUFf+JHKZWga2jZDpdfEh0DQE+m/11BatcSgGKb046xWXR owF/PsQB/QDp7mB6G2IAlWfo2j5P7+arWwfdEGy1IJ/bF6uQi6rtrjIQt9Ps4eHJYbjoR24KuUn Du/TmVJ5ZfGO9tw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In addition to deferring to the trylock fallback in NMIs, only do so
when an rqspinlock waiter is queued on the current CPU. This is detected
by noticing a non-zero node index. This allows NMI waiters to join the
waiter queue if it isn't interrupting an existing rqspinlock waiter, and
increase the chances of fairly obtaining the lock, performing deadlock
detection as the head, and not being starved while attempting the
trylock.

The trylock path in particular is unlikely to succeed under contention,
as it relies on the lock word becoming 0, which indicates no contention.
This means that the most likely result for NMIs attempting a trylock is
a timeout under contention if they don't hit an AA or ABBA case.

The core problem being addressed through the fixed commit was removing
the dependency edge between an NMI queue waiter and the queue waiter it
is interrupting. Whenever a circular dependency forms, and with no way
to break it (as non-head waiters don't poll for deadlocks or timeouts),
we would enter into a deadlock. A trylock either breaks such an edge by
probing for deadlocks, and finally terminating the waiting loop using a
timeout.

By excluding queueing on CPUs where the node index is non-zero for NMIs,
this sort of dependency is broken. The CPU enters the trylock path for
those cases, and falls back to deadlock checks and timeouts. However, in
other case where it doesn't interrupt the CPU in the slow path while its
queued on the lock, it can join the queue as a normal waiter, and avoid
trylock associated starvation and subsequent timeouts.

There are a few remaining cases here that matter: the NMI can still
preempt the owner in its critical section, and if it queues as a
non-head waiter, it can end up impeding the progress of the owner. While
this won't deadlock, since the head waiter will eventually signal the
NMI waiter to either stop (due to a timeout), it can still lead to long
timeouts. These gaps will be addressed in subsequent commits.

Note that while the node count detection approach is less conservative
than simply deferring NMIs to trylock, it is going to return errors
where attempts to lock B in NMI happen while waiters for lock A are in a
lower context on the same CPU. However, this only occurs when the lower
context is queued in the slow path, and the NMI attempt can proceed
without failure in all other cases. To continue to prevent AA deadlocks
(or ABBA in a similar NMI interrupting lower context pattern), we'd need
a more fleshed out algorithm to unlink NMI waiters after they queue and
detect such cases. However, all that complexity isn't appealing yet to
reduce the failure rate in the small window inside the slow path.

It is important to note that reentrancy in the slow path can also happen
through trace_contention_{begin,end}, but in those cases, unlike an NMI,
the forward progress of the head waiter (or the predecessor in general)
is not being blocked.

Fixes: 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters")
Reported-by: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index d160123e2ec4..e602cbbbd029 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -454,7 +454,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * any MCS node. This is not the most elegant solution, but is
 	 * simple enough.
 	 */
-	if (unlikely(idx >= _Q_MAX_NODES || in_nmi())) {
+	if (unlikely(idx >= _Q_MAX_NODES || (in_nmi() && idx > 0))) {
 		lockevent_inc(lock_no_node);
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
 		while (!queued_spin_trylock(lock)) {
-- 
2.51.0


