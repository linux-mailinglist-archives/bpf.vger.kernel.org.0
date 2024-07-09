Return-Path: <bpf+bounces-34277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0866392C389
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14F72838A2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 18:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D8182A4A;
	Tue,  9 Jul 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg9kliOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2B80BEC
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551293; cv=none; b=fCe2vLcuD0S1CmtMtl/yXED0LeUafmlg6ikpdPWAYw451SahwxjbHhFNmkUImz/Yn3s7xjEY+M2OrT85VEzL+E2UuJum03hxMjELzHzdg7aYsOZjcTe4/hQ8CDzKrphKyo0qM7RXRqlzm4s4nJQ59EL+6weB+Uu3uvIpKcBf1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551293; c=relaxed/simple;
	bh=nKc6Xfyz1LTZezI04trVSCNAspYleV6waAmDm9GBKbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwJUuWD3Ub+QIC7EaNUa72nZJO7+oXeDqKJxZgbZfVCQsDb+VMtdSIv7V+hoU04p1WKxRMUw1WLRWXCwS6EuirZXterWZ6SwuulyMjPDGX4V898pxjoDMGxrQxFipbeJHLexcLxD4VXHNy0Ei33e4TyxIEc68ZtveNkIGwRIXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg9kliOI; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a77dc08db60so489397866b.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720551290; x=1721156090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEBqLiX+v7k3/CljmBNVSBmS+deJTGADxiomoBN2mjs=;
        b=Jg9kliOIEiQdzM0Banrqe19ln8AnAzqly6enC0o7ZZZ3f06443MyT6FsB1yck4LDvK
         yFGPMytv6CC3taFIOl/AEsOhvDQIQSjuYLQ79Ghg57Z3a+YEibqMvZXFOJg0pVr9cONV
         u4L88kCPilVVlMFzP2u+le4lMltYov4jX+YPOv/CDU2eTs4yfmWQ57mu/Fp3brTP8Bq2
         QMDAP+TSCGx8d1gErc59XDm0n1xHgdHEoodoL3L3Gi3UZfp9FpiDvdKu7egcHeC69MA0
         RDQqkVzOWFycrtRaqw2uonhik0X0xoI57VkJiMe1OFF+n5lO8zuecOdW9u6vkOh++g+L
         YnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551290; x=1721156090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEBqLiX+v7k3/CljmBNVSBmS+deJTGADxiomoBN2mjs=;
        b=gklZZW232SyBOs+mSWZl7YZsuN0deFWBI41QzQZ2XzgwSJk9E6YpudmbXRx9oylrp1
         KMSDRo3lp1m0g6zyAV3f3lJ01t9fGVfDe5OMdat6wa9hZEF5axLoR6aCDBd7mj0SbPus
         qNZF7pE0nZ+VLTdW2GcuGHVvSYVy3VWB9Oq6FQyQUyiK3iwmYPsmitOBLDTqFcGaLc/6
         +7gvfrxMwd3bvHuEsLP9KYP5huxGZ+Bniz/XAug58WLPJ7dAvFlXhXdXLekyyOcfsg6z
         Hka5lTMVJJ89r3BjZbEwrEyYsTUujlGNkYhdpLCWMZL46WRp+LT4kCtFP7flUs/C9r7T
         C2KQ==
X-Gm-Message-State: AOJu0Yye8iXy8e//WRSkb7i/RZrJpeP62LvOAC5Ng3L73v6gC3jGQkOU
	e4aQesGkOzRAJ0S2sogt7cj+sanEIHihTcNb9rAMSX7S10HCW8gY/N+lgv1/
X-Google-Smtp-Source: AGHT+IGWLRP+twsYvajQegmakqFuVUsc8ZFq8+ZmmdOj3aztNCVMSz0Pr9oeeuSpwsDTKsug9yEw+w==
X-Received: by 2002:a17:906:a08:b0:a6f:b702:8a21 with SMTP id a640c23a62f3a-a780b89cbf1mr258099966b.63.1720551289964;
        Tue, 09 Jul 2024 11:54:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dfa93sm97151266b.65.2024.07.09.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:54:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Barret Rhoden <brho@google.com>,
	Tejun Heo <htejun@gmail.com>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf v1 2/3] bpf: Defer work in bpf_timer_cancel_and_free
Date: Tue,  9 Jul 2024 18:54:39 +0000
Message-ID: <20240709185440.1104957-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709185440.1104957-1-memxor@gmail.com>
References: <20240709185440.1104957-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215; i=memxor@gmail.com; h=from:subject; bh=nKc6Xfyz1LTZezI04trVSCNAspYleV6waAmDm9GBKbo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmjYUMrTotNGJbP852a7CanXC1Q5MVSa/4rQoVJ gDiS+YMa6OJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZo2FDAAKCRBM4MiGSL8R ykjPEACx51BoHawpHaiNC5hrO9IoHSO9CC5STU5r9v/fI7xCQKQYEdUOljv2KVw2ShPU0NHEYLU R3FoxXFEuYWv8FQn3CrOrkw9AHj/MUgkli9MG86slHBKnrpcxi4gBgQxmBLlUZjMIWJs9dYLLsY 78p6yxwAuNotjb/zWe9deoubkPqQOmJxVRLb78djAiJ8Eb7JMOO5LdXFt0oIY1MrzZmol6bYv/x AorfUjKEFi7QPEd5r9aEF1EVO9spjUogD2Ktht+e50QJWi7mcSduuVUIyeYZp96hTNkWeVQr7qB tj/i/Yo5zmQKXe9leO8DLkrjrE/NvN9U4bXHTmX+BEsRA5a4KkyWgmSusaIQcwx3xDkyV03pULY k0o2172hN/Ox807/WF3zNhTTYRKIZvsha9v3tqWnwFjU7ZMAf65dl72FtoYO7EwuF4AYb9mja8I RNIk1dYDu9RTJXdMm7z8qM7oGqiFqHEj003XhBNSklzZMRzSWi6zZBKVyiNQIlsO2qmDTXX0GEh bV+8na0pHEcQBlsg6uUtiCLnSeapyc6zZLXh4hHTw+wR8oAxviM7+wewO5iFHFxdFPSqJ9ApvEp JU1rYCUxixOGDUeH8cqhmo/jYnosF29wzXon9y/SSQI0oxcgjVoOVZ20YoyC8amCEK3iZQsMugz QjQ702wsLokbltQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, the same case as previous patch (two timer callbacks trying
to cancel each other) can be invoked through bpf_map_update_elem as
well, or more precisely, freeing map elements containing timers. Since
this relies on hrtimer_cancel as well, it is prone to the same deadlock
situation as the previous patch.

It would be sufficient to use hrtimer_try_to_cancel to fix this problem,
as the timer cannot be enqueued after async_cancel_and_free. Once
async_cancel_and_free has been done, the timer must be reinitialized
before it can be armed again. The callback running in parallel trying to
arm the timer will fail, and freeing bpf_hrtimer without waiting is
sufficient (given kfree_rcu), and bpf_timer_cb will return
HRTIMER_NORESTART, preventing the timer from being rearmed again.

However, there exists a UAF scenario where the callback arms the timer
before entering this function, such that if cancellation fails (due to
timer callback invoking this routine, or the target timer callback
running concurrently). In such a case, if the timer expiration is
significantly far in the future, the RCU grace period expiration
happening before it will free the bpf_hrtimer state and along with it
the struct hrtimer, that is enqueued.

Hence, it is clear cancellation needs to occur after
async_cancel_and_free, and yet it cannot be done inline due to deadlock
issues. We thus modify bpf_timer_cancel_and_free to defer work to the
global workqueue, adding a work_struct alongside rcu_head (both used at
_different_ points of time, so can share space).

Update existing code comments to reflect the new state of affairs.

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 61 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 22e779ca50d5..3243c83ef3e3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1084,7 +1084,10 @@ struct bpf_async_cb {
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
-	struct rcu_head rcu;
+	union {
+		struct rcu_head rcu;
+		struct work_struct delete_work;
+	};
 	u64 flags;
 };
 
@@ -1220,6 +1223,21 @@ static void bpf_wq_delete_work(struct work_struct *work)
 	kfree_rcu(w, cb.rcu);
 }
 
+static void bpf_timer_delete_work(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, cb.delete_work);
+
+	/* Cancel the timer and wait for callback to complete if it was running.
+	 * If hrtimer_cancel() can be safely called it's safe to call
+	 * kfree_rcu(t) right after for both preallocated and non-preallocated
+	 * maps.  The async->cb = NULL was already done and no code path can see
+	 * address 't' anymore. Timer if armed for existing bpf_hrtimer before
+	 * bpf_timer_cancel_and_free will have been cancelled.
+	 */
+	hrtimer_cancel(&t->timer);
+	kfree_rcu(t, cb.rcu);
+}
+
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
 			    enum bpf_async_type type)
 {
@@ -1264,6 +1282,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		t = (struct bpf_hrtimer *)cb;
 
 		atomic_set(&t->cancelling, 0);
+		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
 		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 		t->timer.function = bpf_timer_cb;
 		cb->value = (void *)async - map->record->timer_off;
@@ -1544,25 +1563,39 @@ void bpf_timer_cancel_and_free(void *val)
 
 	if (!t)
 		return;
-	/* Cancel the timer and wait for callback to complete if it was running.
-	 * If hrtimer_cancel() can be safely called it's safe to call kfree(t)
-	 * right after for both preallocated and non-preallocated maps.
-	 * The async->cb = NULL was already done and no code path can
-	 * see address 't' anymore.
-	 *
-	 * Check that bpf_map_delete/update_elem() wasn't called from timer
-	 * callback_fn. In such case don't call hrtimer_cancel() (since it will
-	 * deadlock) and don't call hrtimer_try_to_cancel() (since it will just
-	 * return -1). Though callback_fn is still running on this cpu it's
+	/* We check that bpf_map_delete/update_elem() was called from timer
+	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
+	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
+	 * just return -1). Though callback_fn is still running on this cpu it's
 	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
 	 * from 't'. The bpf subprog callback_fn won't be able to access 't',
 	 * since async->cb = NULL was already done. The timer will be
 	 * effectively cancelled because bpf_timer_cb() will return
 	 * HRTIMER_NORESTART.
+	 *
+	 * However, it is possible the timer callback_fn calling us armed the
+	 * timer _before_ calling us, such that failing to cancel it here will
+	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
+	 * Therefore, we _need_ to cancel any outstanding timers before we do
+	 * kfree_rcu, even though no more timers can be armed.
+	 *
+	 * Moreover, we need to schedule work even if timer does not belong to
+	 * the calling callback_fn, as on two different CPUs, we can end up in a
+	 * situation where both sides run in parallel, try to cancel one
+	 * another, and we end up waiting on both sides in hrtimer_cancel
+	 * without making forward progress, since timer1 depends on time2
+	 * callback to finish, and vice versa.
+	 *
+	 *  CPU 1 (timer1_cb)			CPU 2 (timer2_cb)
+	 *  bpf_timer_cancel_and_free(timer2)	bpf_timer_cancel_and_free(timer1)
+	 *
+	 * To avoid these issues, punt to workqueue context when we are in a
+	 * timer callback.
 	 */
-	if (this_cpu_read(hrtimer_running) != t)
-		hrtimer_cancel(&t->timer);
-	kfree_rcu(t, cb.rcu);
+	if (this_cpu_read(hrtimer_running))
+		queue_work(system_unbound_wq, &t->cb.delete_work);
+	else
+		bpf_timer_delete_work(&t->cb.delete_work);
 }
 
 /* This function is called by map_delete/update_elem for individual element and
-- 
2.43.0


