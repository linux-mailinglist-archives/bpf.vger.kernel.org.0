Return-Path: <bpf+bounces-34276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8384492C388
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BEB1C22768
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE818005F;
	Tue,  9 Jul 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcOTrehF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22EB17B045
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551292; cv=none; b=JGDzPM+UBAHKUEhl+T7MSS4d+satLK/Sh2GaEJ8d2lYs8TsrofyKahqZhlO1g4ABFAMwpMwn2UJRKt3FrsdDN1aIUhetACgpujjBuhU8DCHBXZMCe+T7fqScxKxBf4mBziOm1iDYvp8NROGqQP6RktbjitqM0QP7bW7rvVu1SB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551292; c=relaxed/simple;
	bh=MNW+92E/Nw/DexAy7fnWsWfXJIC72yC+uqyEd9vvLe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R75YtmoT3COGoK7TxDNY27iisrMmU8v474vOI6JDrSjamPqc/scFOhV7en2Y4qvGbuDluMhj5kfFBrh09iawU5G2x+JRLq2Kkmchb0LeW5IxwBxa4d/NFlB+64h2D3UVGqKWrguJIQjzRgVQHGkyqARrPip2aPxaZ+7BYibEqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcOTrehF; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so7300328a12.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720551288; x=1721156088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsI5BPkq+USbt3b1GIUPIPi4gqY5NbC67o1W6F1/MlY=;
        b=IcOTrehFzIt6LNLA5BHv46fZg6PQELOFyQh0/J0Ks+CEGZEK0jgngdf8PVXm4MMcTD
         44dJROPRETYsp47jR/m+BE6GsWXHB4/mbK6SxpO2oMBO15p/IHBokcWq7ApHAU2FoSS7
         k/Q+LA1wpWBbjLBLOU7c1zPi8Ic62Ovv1GD+iB4QvBCXc1tfVl5D1WTMvPws9ikUk79b
         XN5bwG3j8W/jaOo7Twwr3sbcfxtvB5a7Damf1j6VIhJJg7zj8Ekgci1F7IShqnTNDg3M
         MbbH3XSMR1rw4ESGQJqd6c43en15SCPg8H0ua+XMY3hVzRc72Fj17UW/iqeBdq24LVmj
         Onlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551288; x=1721156088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsI5BPkq+USbt3b1GIUPIPi4gqY5NbC67o1W6F1/MlY=;
        b=ZiX4ogdnSS733IV9/5PadUQ/uav89venT+Otq+7qwKQwXOvYGvURQ6DrmYxqM05B+a
         RyuROSdM6Mcg7EAipmy/E/zRRRjrO9iidrc2nwL+najm2I9fFeVyqyT6zECIhEBvzPpQ
         aBpCbBOiFf7X4ekakGdHVrCFAdZHLk0/pqGvivIhrOk0f6VjLf2EsglS9hGhGW/U+/8w
         bGMnizi+tiJ1Pr24b0+iGtBCPM90fqC4R9Bu6DCKVZLXpLaDZucs1ctZR2nt2pMG1wa7
         pa9fhVLIGL7a8y5A+2H4whWfhPF8JPEHzAF+JWz9R6VspQ9jsAwVqKwOlEypM5XcJUnN
         YrKA==
X-Gm-Message-State: AOJu0Ywvr+g5/HbQLQ+tYZG1EeiX+SSwyqO3YnQpNcp2m4jP4dfD1sHg
	J9Oul5f9yMqIuw2dOSYH54L55Ih4nDk+tTkWz/Aw56cCO0uHXPnyM+VEWf21
X-Google-Smtp-Source: AGHT+IGOuHYCH5BoI1MXT31d9Vp9tIkDcQ3XhhUgXl83joPX/omfw0hym1E/RVIQUqS+tbztoKKuIw==
X-Received: by 2002:a05:6402:2688:b0:57c:ff70:5429 with SMTP id 4fb4d7f45d1cf-594ba98f43dmr2571304a12.8.1720551288289;
        Tue, 09 Jul 2024 11:54:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda27f56sm1364348a12.80.2024.07.09.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:54:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Barret Rhoden <brho@google.com>,
	Tejun Heo <htejun@gmail.com>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf v1 1/3] bpf: Fail bpf_timer_cancel when callback is being cancelled
Date: Tue,  9 Jul 2024 18:54:38 +0000
Message-ID: <20240709185440.1104957-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709185440.1104957-1-memxor@gmail.com>
References: <20240709185440.1104957-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5488; i=memxor@gmail.com; h=from:subject; bh=MNW+92E/Nw/DexAy7fnWsWfXJIC72yC+uqyEd9vvLe8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmjYULVCA5muRocCwBiYJKLfs4+U03w0OplMC+0 b/Q5vX5Z46JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZo2FCwAKCRBM4MiGSL8R ytj2D/0Q0zR5QtIWT90OdzImpLz3L0js8aFVmj7CthpBTB4RUfYDRZz/O0+4c8Vjg0HmzE1Vwy0 pf+/1NIJVagW4Vo7d+vaNHQqz839W9eaN3Xws39332A1V+iwDnTx2hoV7+rtjK+0srvoeVtib+c oDfOupTK3A7Tsc3rNoTLISdB0aPobRWoUo2mx6F+NAOJ6uvp2SmIZxGoQBR/DzOmw6rOEwvQG5v YwXi2gRHTbPpPEa+6vnJX/leXXqF1lqVBJsstNtNQu8lXOVCSRqn63RDsKYi5PVXzOfAqGjtjqV 0ISnS1szmq6yx67pz2YM2FxK5L9lW2tzS9D6cx2upHzcm9bf53jw2rz8YJ/nZSoM3/cFSBa5QmU +KY/9hkQFcjaSaDuKGM/La1DaVgSTopVNy6mxEgbUvFNRT8IZMoP9uz9Ymn8c5kH1hpyiEQoIEX fOR/rM0SxRPXI7+w0+VmJ1Pk5XV+VpxYhe3+le5dmE5mRaXiChFEx0//4d2ji6WoEP8KSVnt8xN 6jBGGnYN3XLyqesQDqBquKora2hB9JMot2/swCqATV9kdUJLSTLnlvIhZfBQxQf0RG4l9UjWorV gGCBy24HHRtm9tGlkzzlpXbOBmbz+lPKyv2FDJ/t9axCRqQpeDFO5gVCSiOPJZAjwMJIjSknSRu 9HYuM42CWmlgzJw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Given a schedule:

timer1 cb			timer2 cb

bpf_timer_cancel(timer2);	bpf_timer_cancel(timer1);

Both bpf_timer_cancel calls would wait for the other callback to finish
executing, introducing a lockup.

Add an atomic_t count named 'cancelling' in bpf_hrtimer. This keeps
track of all in-flight cancellation requests for a given BPF timer.
Whenever cancelling a BPF timer, we must check if we have outstanding
cancellation requests, and if so, we must fail the operation with an
error (-EDEADLK) since cancellation is synchronous and waits for the
callback to finish executing. This implies that we can enter a deadlock
situation involving two or more timer callbacks executing in parallel
and attempting to cancel one another.

Note that we avoid incrementing the cancelling counter for the target
timer (the one being cancelled) if bpf_timer_cancel is not invoked from
a callback, to avoid spurious errors. The whole point of detecting
cur->cancelling and returning -EDEADLK is to not enter a busy wait loop
(which may or may not lead to a lockup). This does not apply in case the
caller is in a non-callback context, the other side can continue to
cancel as it sees fit without running into errors.

Background on prior attempts:

Earlier versions of this patch used a bool 'cancelling' bit and used the
following pattern under timer->lock to publish cancellation status.

lock(t->lock);
t->cancelling = true;
mb();
if (cur->cancelling)
	return -EDEADLK;
unlock(t->lock);
hrtimer_cancel(t->timer);
t->cancelling = false;

The store outside the critical section could overwrite a parallel
requests t->cancelling assignment to true, to ensure the parallely
executing callback observes its cancellation status.

It would be necessary to clear this cancelling bit once hrtimer_cancel
is done, but lack of serialization introduced races. Another option was
explored where bpf_timer_start would clear the bit when (re)starting the
timer under timer->lock. This would ensure serialized access to the
cancelling bit, but may allow it to be cleared before in-flight
hrtimer_cancel has finished executing, such that lockups can occur
again.

Thus, we choose an atomic counter to keep track of all outstanding
cancellation requests and use it to prevent lockups in case callbacks
attempt to cancel each other while executing in parallel.

Reported-by: Dohyun Kim <dohyunkim@google.com>
Reported-by: Neel Natu <neelnatu@google.com>
Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2a69a9a36c0f..22e779ca50d5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1107,6 +1107,7 @@ struct bpf_async_cb {
 struct bpf_hrtimer {
 	struct bpf_async_cb cb;
 	struct hrtimer timer;
+	atomic_t cancelling;
 };
 
 struct bpf_work {
@@ -1262,6 +1263,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		clockid = flags & (MAX_CLOCKS - 1);
 		t = (struct bpf_hrtimer *)cb;
 
+		atomic_set(&t->cancelling, 0);
 		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 		t->timer.function = bpf_timer_cb;
 		cb->value = (void *)async - map->record->timer_off;
@@ -1440,7 +1442,8 @@ static void drop_prog_refcnt(struct bpf_async_cb *async)
 
 BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 {
-	struct bpf_hrtimer *t;
+	struct bpf_hrtimer *t, *cur_t;
+	bool inc = false;
 	int ret = 0;
 
 	if (in_nmi())
@@ -1452,14 +1455,41 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		ret = -EINVAL;
 		goto out;
 	}
-	if (this_cpu_read(hrtimer_running) == t) {
+
+	cur_t = this_cpu_read(hrtimer_running);
+	if (cur_t == t) {
 		/* If bpf callback_fn is trying to bpf_timer_cancel()
 		 * its own timer the hrtimer_cancel() will deadlock
-		 * since it waits for callback_fn to finish
+		 * since it waits for callback_fn to finish.
+		 */
+		ret = -EDEADLK;
+		goto out;
+	}
+
+	/* Only account in-flight cancellations when invoked from a timer
+	 * callback, since we want to avoid waiting only if other _callbacks_
+	 * are waiting on us, to avoid introducing lockups. Non-callback paths
+	 * are ok, since nobody would synchronously wait for their completion.
+	 */
+	if (!cur_t)
+		goto drop;
+	atomic_inc(&t->cancelling);
+	/* Need full barrier after relaxed atomic_inc */
+	smp_mb__after_atomic();
+	inc = true;
+	if (atomic_read(&cur_t->cancelling)) {
+		/* We're cancelling timer t, while some other timer callback is
+		 * attempting to cancel us. In such a case, it might be possible
+		 * that timer t belongs to the other callback, or some other
+		 * callback waiting upon it (creating transitive dependencies
+		 * upon us), and we will enter a deadlock if we continue
+		 * cancelling and waiting for it synchronously, since it might
+		 * do the same. Bail!
 		 */
 		ret = -EDEADLK;
 		goto out;
 	}
+drop:
 	drop_prog_refcnt(&t->cb);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
@@ -1467,6 +1497,8 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
+	if (inc)
+		atomic_dec(&t->cancelling);
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.43.0


