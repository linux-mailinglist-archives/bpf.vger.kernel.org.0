Return-Path: <bpf+bounces-74384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2382C574F2
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 845C54E4481
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E434EEF2;
	Thu, 13 Nov 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS16h5oz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5A34D397
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035210; cv=none; b=sEo6e8ScGkErWG7wKuzZ+foq1JyGmaaZilyxpS84Eno/rXIqz6hQ3EglMx29LATyPThpMV12J5fGF7tDwQhp/ly+wfOeQW6bWBhm5SBRyjUtaLShYawQY9qn4K459ZlOBaPrwWZLg2woIz7gKWexhpxvsZbWGeYE071aK6BLrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035210; c=relaxed/simple;
	bh=LClQ4VKSgGqRmpKA8muL2DWk6OhWvtI5zTQeCjFWmQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B51ZIREKIzzZFB+vI1/dmFYYlDvvzEfeuBxVGT8QqY5fed9fagD/mBfpwaG2chOMUZFBZKVW7skhcdr2hgogBYGIV4Zvp/axqfhwc64pitCL7Moacn3+5+owu11Ndj6BmNwWs+djqpdoMtvsQDjPg2hADO3w9Ny3hXAMWYtC0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS16h5oz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b312a086eso459938f8f.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763035204; x=1763640004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3KZQy0f9Z9laK13Rj/5BsEUG3RefPiUTImKCIeRBME=;
        b=QS16h5ozTuCt0h2/yQ7uuKDCc1Gb4op3O1viobgHjfdFl7c1JKdNCb2IH2OMYtxIV6
         yfhj1CwOXhgHiA1gTzaU2OEIDp80bdj7/3eg1cWmQ6PBem3SZjxXcoK3civNDqUrfMLH
         oQsXsvzHn19CFug/VwGdFJSZHyIbM1LEva4AHNu3rQAG3or8XLrOezCO4w/fHv5OjY+w
         cVGT3G2u3sOdw0njQsjTX+YJXF8kCEi/09c3EwzjzxaPvVhFtlDTR8nPaE5NT6Ua4bcN
         oh/XqE7QYjhd2eDu0gn4YmtlTBOCB9euy8z1xyTwsi0Hpsag2zrp5FLmO+QM41683YmW
         rpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035204; x=1763640004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h3KZQy0f9Z9laK13Rj/5BsEUG3RefPiUTImKCIeRBME=;
        b=eD5gF8V8t9n0w1zobcfcrWo/WSdX+e/nAutyOuzzouskgG0TyUDc6kDdRi87jAqMMu
         W2gTTidozv0XOX2ViHJt56ee+2rjBFARcjMw7QQ6CJeaoEmriWTj7cc6hLD1beZfSils
         2PMZhnmANZGrnLk8Z7p1/XiKaW8FtHK3YBAbw9/0LCyfGRncz8CBZkD4kHBIut/IXejX
         y8W4z0kSeOC35KydC2nfPC+ALTUA+TMaMZfc783u5/KHSn1o7BVZgty+vQgti+9PAZew
         ZYPwO7KHua0ttDylbkOufgvboGS+2vixqpobywmyvh2GSVBQT40arzEq04vXTGUKG3Aw
         0slw==
X-Forwarded-Encrypted: i=1; AJvYcCXW36tZ/GFEuyZSqpl+BkcEgxKfFVZUHhjGwae0vh8uuGammxKHDe0mzeikQmH/x+RtoBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMYl+GObMB/GGi/V+F3TbhWUUrfHfpfko6GEdtZyrrFEB/2sE
	0oz41klDb3uzQrsMggukYoT5sfgd0tAQKls2U7GLHGpARLeAoRX20w+8
X-Gm-Gg: ASbGncs/fX64LWGFdv5sM/3huDDw+aPzcmjfSRy+Tt24x1a+v5xrDSe6W5Hva5giIUA
	rr/5i8cpTwgGjiyTZlSzhpNIpQQW+v1UqaUbZhsJYfC6wDBt/LyVgkutKUxCNb8aOGailOsyGlU
	BzuKJX+g/SiSJLEXhkY/2p1Zwb6iLgNSVY2KROENfil7GnSk+i3+iWw1SVIxoO+TcZUrOTONMwX
	+ngfPabResEX7O6JK0q8E7pKCpP/xbSzEPQwm9R+yc7dAiJC6dIXltjG8s2wZWMp2dOQ2eHL99e
	c8Rh9fD83Pn9N0YLTrmmrQbPdZVgWa7eqhkYDiWhQ66rSnQMm8C+WJGVfZtZG0XkQ8ZfW3TaXiS
	FvIj4/Obqis7dFzAj8Zi47+UKFkX6J/CU22fjPPmAnuMF2jiR+O9PSF3b6befhuYEwYNJmg==
X-Google-Smtp-Source: AGHT+IFbeftWCviGXNIemZTF2DmXPVZfg2TdG3b62DkOa2qU3mmvsfwD7ETwzpKo0Zpbud+N7iiXQw==
X-Received: by 2002:a5d:5d12:0:b0:42b:3083:5588 with SMTP id ffacd0b85a97d-42b4bdb0570mr6602052f8f.39.1763035204238;
        Thu, 13 Nov 2025 04:00:04 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm3686816f8f.18.2025.11.13.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:00:03 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	ming.lei@redhat.com
Subject: [PATCH v3 04/10] io_uring: extract waiting parameters into a struct
Date: Thu, 13 Nov 2025 11:59:41 +0000
Message-ID: <5343b1306ad898181477470e0ce467bcca329262.1763031077.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763031077.git.asml.silence@gmail.com>
References: <cover.1763031077.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a structure that keeps arguments needed for the current round of
waiting. Namely, the number of CQEs to wait for in a form of CQ tail
index and timeout.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c | 22 ++++++++++++----------
 io_uring/io_uring.h | 14 +++++++++++---
 io_uring/napi.c     |  4 ++--
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4139cfc84221..29f34fbcbb01 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2508,8 +2508,8 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	struct io_ring_ctx *ctx = iowq->ctx;
 
 	/* no general timeout, or shorter (or equal), we are done */
-	if (iowq->timeout == KTIME_MAX ||
-	    ktime_compare(iowq->min_timeout, iowq->timeout) >= 0)
+	if (iowq->ls.timeout == KTIME_MAX ||
+	    ktime_compare(iowq->min_timeout, iowq->ls.timeout) >= 0)
 		goto out_wake;
 	/* work we may need to run, wake function will see if we need to wake */
 	if (io_has_work(ctx))
@@ -2535,7 +2535,7 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	}
 
 	hrtimer_update_function(&iowq->t, io_cqring_timer_wakeup);
-	hrtimer_set_expires(timer, iowq->timeout);
+	hrtimer_set_expires(timer, iowq->ls.timeout);
 	return HRTIMER_RESTART;
 out_wake:
 	return io_cqring_timer_wakeup(timer);
@@ -2551,7 +2551,7 @@ static int io_cqring_schedule_timeout(struct io_wait_queue *iowq,
 		hrtimer_setup_on_stack(&iowq->t, io_cqring_min_timer_wakeup, clock_id,
 				       HRTIMER_MODE_ABS);
 	} else {
-		timeout = iowq->timeout;
+		timeout = iowq->ls.timeout;
 		hrtimer_setup_on_stack(&iowq->t, io_cqring_timer_wakeup, clock_id,
 				       HRTIMER_MODE_ABS);
 	}
@@ -2592,7 +2592,7 @@ static int __io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 */
 	if (ext_arg->iowait && current_pending_io())
 		current->in_iowait = 1;
-	if (iowq->timeout != KTIME_MAX || iowq->min_timeout)
+	if (iowq->ls.timeout != KTIME_MAX || iowq->min_timeout)
 		ret = io_cqring_schedule_timeout(iowq, ctx->clockid, start_time);
 	else
 		schedule();
@@ -2650,18 +2650,20 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 	iowq.wqe.private = current;
 	INIT_LIST_HEAD(&iowq.wqe.entry);
 	iowq.ctx = ctx;
-	iowq.cq_tail = READ_ONCE(ctx->rings->cq.head) + min_events;
+	iowq.ls.cq_tail = READ_ONCE(ctx->rings->cq.head) + min_events;
 	iowq.cq_min_tail = READ_ONCE(ctx->rings->cq.tail);
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
 	iowq.hit_timeout = 0;
 	iowq.min_timeout = ext_arg->min_time;
-	iowq.timeout = KTIME_MAX;
+	iowq.ls.timeout = KTIME_MAX;
 	start_time = io_get_time(ctx);
 
 	if (ext_arg->ts_set) {
-		iowq.timeout = timespec64_to_ktime(ext_arg->ts);
+		ktime_t timeout = timespec64_to_ktime(ext_arg->ts);
+
 		if (!(flags & IORING_ENTER_ABS_TIMER))
-			iowq.timeout = ktime_add(iowq.timeout, start_time);
+			timeout = ktime_add(timeout, start_time);
+		iowq.ls.timeout = timeout;
 	}
 
 	if (ext_arg->sig) {
@@ -2686,7 +2688,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 
 		/* if min timeout has been hit, don't reset wait count */
 		if (!iowq.hit_timeout)
-			nr_wait = (int) iowq.cq_tail -
+			nr_wait = (int) iowq.ls.cq_tail -
 					READ_ONCE(ctx->rings->cq.tail);
 		else
 			nr_wait = 1;
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index a4474eec8a13..caff186bc377 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -101,15 +101,23 @@ struct io_defer_entry {
 	struct io_kiocb		*req;
 };
 
+struct iou_loop_state {
+	/*
+	 * The CQE index to wait for. Only serves as a hint and can still be
+	 * woken up earlier.
+	 */
+	__u32		cq_tail;
+	ktime_t		timeout;
+};
+
 struct io_wait_queue {
+	struct iou_loop_state ls;
 	struct wait_queue_entry wqe;
 	struct io_ring_ctx *ctx;
-	unsigned cq_tail;
 	unsigned cq_min_tail;
 	unsigned nr_timeouts;
 	int hit_timeout;
 	ktime_t min_timeout;
-	ktime_t timeout;
 	struct hrtimer t;
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -121,7 +129,7 @@ struct io_wait_queue {
 static inline bool io_should_wake(struct io_wait_queue *iowq)
 {
 	struct io_ring_ctx *ctx = iowq->ctx;
-	int dist = READ_ONCE(ctx->rings->cq.tail) - (int) iowq->cq_tail;
+	int dist = READ_ONCE(ctx->rings->cq.tail) - (int) iowq->ls.cq_tail;
 
 	/*
 	 * Wake up if we have enough events, or if a timeout occurred since we
diff --git a/io_uring/napi.c b/io_uring/napi.c
index 4a10de03e426..b804f8fdd883 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -360,8 +360,8 @@ void __io_napi_busy_loop(struct io_ring_ctx *ctx, struct io_wait_queue *iowq)
 		return;
 
 	iowq->napi_busy_poll_dt = READ_ONCE(ctx->napi_busy_poll_dt);
-	if (iowq->timeout != KTIME_MAX) {
-		ktime_t dt = ktime_sub(iowq->timeout, io_get_time(ctx));
+	if (iowq->ls.timeout != KTIME_MAX) {
+		ktime_t dt = ktime_sub(iowq->ls.timeout, io_get_time(ctx));
 
 		iowq->napi_busy_poll_dt = min_t(u64, iowq->napi_busy_poll_dt, dt);
 	}
-- 
2.49.0


