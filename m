Return-Path: <bpf+bounces-75752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932AC934B9
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A76774E2226
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403152EDD4F;
	Fri, 28 Nov 2025 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pblmcktw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9F2F12BD
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372490; cv=none; b=AQlR/jm08/aB96z+rSkeTZtPQXNOjLONzbbXVZOtbNJ1SQWPlTw5E2oDSn9x8iw6ZyQ/e9//tMzDL9l6YOGKnQsb3qGIivIwAk5zDoxiIcHnRj/vcoovKAvTDqhjFlKIsyu3fNFWM00AiS5pyvmAwoqF6Pf/qTrMOU3yHbOG5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372490; c=relaxed/simple;
	bh=gTlsucPN+Y0mBc8RY+SSQJp/BD5P+ez73AV1R7l6/gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL/J7s6vVsa6QmENt5VMMi+9vYQRExAM2Qz1ATpSz2hPjkI6dC2TK5qH0QlWw6/fBhzFme66Pcb0vnyD2wOQD93ZpzfwqVuhRDkIkBpb8kcW8UOxw5mKOLHZD6wKqgUBTLGJ8e+/XyNyiUCxDaCJgHTM4nsLheLtIoeoZrYEkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pblmcktw; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so15665785e9.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372487; x=1764977287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIDGDZlSgsx03nD43kvh47pwtR5noL6i7s8CZSj47Fw=;
        b=PblmcktwNlSVoqCoQ/dvL28ZCD/S2+b2Gl93jzBr6WWiwMfWVb74MaKjW8LhadTt9V
         q5X1odlRtackGsrkSAuVHZsyit/GKNn2CBk3ju5MZ3muyRZFMREcCcE+6FsrG9ldXla6
         fpjTG9qfxuIvJtAgVtFXhHhEC8jWRQr7n1ZyoWdkdhJ8GRVOZw8LBlCF92PMKi3RaBvB
         VKkbPG3F1MAHcRI8fqjudbKhWQ/LjihpxX6F+3RjSM7/2+gie8KCiyICYWU/gNB1T5mK
         dUTTLiglbE4v2zmdxN5yEhXodS+/n+Qk/agIoq0VSLA3B2K6CZdDqnB0WQB4MQ34zw3s
         RWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372487; x=1764977287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jIDGDZlSgsx03nD43kvh47pwtR5noL6i7s8CZSj47Fw=;
        b=ojWt7dryoMUWx85Ue829dB7WAAxGZPNN5JL9nziJtEwHa8f4j7qqRQ66eMt5vichpB
         oCrX4Aq9R5FCrkKDjg5+uYLcJegQslz0X0wEdevmWJA2FF+JpMkYKGIxmPb5WPTx+TpG
         BNC+AWI345ti1K/byktcyRdfrFwXIilXwRUk7oMJEUoI8URimsX4KpbKZJ01R1ZLQk32
         WNn/62HaJDQuOne7LZ7spo5W7DLle/fVBD5vbG6m2+CNiQUrNcK2eNaoccdHoEZeRGDr
         k4eACrgPN5Gr2RX2M9AccHhoviWeRgtTPhMLrSQ3Fgx+dQ9F8PUjW//goLb+6Dgb7Vaa
         ApWQ==
X-Gm-Message-State: AOJu0YxbLdxjdS88CnWehp/qLPRTXh6fHQ6n4MCwVlKkDopYxjdMqtRW
	qwTJ0iobcf9qv0tkATnmZUlH4qLjPwxPeOQwsxa/b7gK71chEEllrUqUgOF1T8xA
X-Gm-Gg: ASbGncvExw3lQyaZVkk3YFOzwhRvRgCiW1pY2EJ4KWzGFkxnlWwUgF/TELzYg/pAImN
	pWU0X42SEaq0yoV9vjzQfNsro/Hw7G7/Jolaxbi2Mx1YJ7pBQ29tT6oNWxjGq5nTIDtH0h167CQ
	F1EWrYZYnBhyltK2taGFyhHanU1SsrbCE/q5HsWk8xJGgpcBkpjXwp50cGn+h3XqiiMiZu0EuWl
	PVlkcSZT2XgSjbM+T6awhGP9/+nNuZmrIqBBXs0LylPsrduwS06dUf01trnia3Zpr3RZSu6pVgs
	gj6K6zvEQjERJ7D63BEmQYsbXXjePqSp1yxm8CD3KRzMgZlFKX5+Uk3WEBpC6K/+hbnQbHU7eef
	NcA1vQZIiV//Y9sSGSVrFpCHnwxF5ycvQZ7NO+5YznIWFikd7VQ3dV13VnxZ8cZ2W0leH2IRMZc
	Cl3/C3+h7x54gjAUxWM2H4dUeHQFzclrt+OndB7YjJ4MfAMcKSw+VYzRlM1cLsXkG8
X-Google-Smtp-Source: AGHT+IHnjdgiEULKPtPQBlBwpFoKhsBGSM2uwR2AuHhe/cDbSOHKGr2/c7nvKlxZqebR7Ztd4bnklQ==
X-Received: by 2002:a05:600c:5489:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-477c1119c31mr289531915e9.17.1764372486950;
        Fri, 28 Nov 2025 15:28:06 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4790ade13ddsm171572905e9.8.2025.11.28.15.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:28:06 -0800 (PST)
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
Subject: [PATCH bpf-next v2 3/6] rqspinlock: Use trylock fallback when per-CPU rqnode is busy
Date: Fri, 28 Nov 2025 23:27:59 +0000
Message-ID: <20251128232802.1031906-4-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128232802.1031906-1-memxor@gmail.com>
References: <20251128232802.1031906-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935; i=memxor@gmail.com; h=from:subject; bh=gTlsucPN+Y0mBc8RY+SSQJp/BD5P+ez73AV1R7l6/gg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKi/xkZ5IXKfEH1KNZ6eoO3hvgcUzy9PUpfUBv lYyTtkT1g2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSov8QAKCRBM4MiGSL8R ynEaD/4pu+8iUgqH7v5cNxD/+XYcQ+wrDuReg+VEPExLNjU7u9c+YBlBu7gL1ibWt4yNpupkpmU e5sN/s96LsuVBbjinHPjXShrfelT9e1FHfzdT1G/pwNckwgd/3yQE0lkAZAFjj0bUvRAXogTkms eGzE1IbfKfT9P2k1QgbL3s5FaHhayHjWZw9VNmNUz1270nKGaQ1wtcuor2WvPmSFbpwUjz2FgOn h122S1eJaHBMifcQYGMYVjK5PbAeZp9c5osgE9cM94mCuGsZDn1zdH/8hSAsxnsy+ooEZTQWqx5 kPXgib0TlEt+YvhjcjDL4qUxrDexuTDuX7gbonQnz9KzSueaXPgti7f26Xiay4ki5sYTg5eV8ug Qgdu0W6bxnyiZydGJv5JIIg3uOTkv0grFfHAjugSrO96KkQq7Wgsc0GV5aV40fgc1dx/PRg5WBR efiJqBRI5G9vjIriwgfGNxHo/u9rBmN+um5d+PmhRXRZfvFYaPkMHQn+uKEKvwrG1rXoEcjD8Hf 3p0Psx006cNb7fMxhQr6MO0qMEwfQdgTg3cPMFxD5o+H2myY3N/dLLQtmasafSbcDJVn0Uuw4S3 0M8vmjuQIUVZbtrDEAXaxZlrLryGLnnQin6alDedT8/+HXK8z42iMsyL3dG3okcGMJdRYCcfgAt PaWvWuPWXB3OdAw==
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


