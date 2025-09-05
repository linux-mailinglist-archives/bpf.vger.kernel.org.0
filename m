Return-Path: <bpf+bounces-67534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD25B44DE5
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D3DA02705
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766282877DF;
	Fri,  5 Sep 2025 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apGnHtW7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFEE23B62B
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053225; cv=none; b=L+etIUnEMbS61cxofPVN0us+dcuM30wXs6dX7MPWLWcQsQrlpcF/0Gc4IgdVNDfQOESVHp8Z7N4ft2sciqmflNRxOSeHSTaPFqQwfZFlCyNRS0xBqcYJwsrQ3EShoa9ucE4C6EdPu1EDFDZ9w0XkXwFmtP9cq22XujqvBJPujzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053225; c=relaxed/simple;
	bh=JqpB++P/0OvIJlIHiQMfVH5hHb6C3gVgFNSUC1/1k2U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y/ezQFy8NOxkCeapXVXy9Hp9eJq1hcp353mQ4e51w5yXGKUr77hya4dN/Ry0O1da4y4/0jNsHNkngwnFuDik6ESIv/ErLD4bjPffGDw9itXvWZmMa1GBwjIycr4Dsgpmm4MxWINsMRbJ1wZO0VkFQSM8KYZNbUbZXeNsnxiYN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apGnHtW7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24afab6d4a7so34633875ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 23:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757053223; x=1757658023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1D0tFcFLqHF1Q9avcWY7GzaOPrSnhPfLlTS1ShqQ78=;
        b=apGnHtW7LjLRuqUhw0HcdC68Mz9fFWaDo8WB2PV2Zpdf5HvQL0NNbWKQhDiLAaMSC1
         WDN+fWydujpiqCOERMAz2CKWnAsbiB5qpk5EVaFk0xkoSEQGmoJ7JBEAMomL1OrOAn9f
         /xFdsE2ZA9OsfcT2F1eCL5rNvIixd5NAZ+vfJwwVP7TLFt3RakWIMxRQC1cviJiwQFuG
         GRpvGtGn42qKsxw0NwU1c3U90ng4lfqIASQNfWEy32ARLxnvhzFhlnQk4vQQ9oWn2gjB
         KyxQ2E1E7ApsgRzRsq15DA9qZjMhgGthXQsi2y24J8WbwCE1i2H5hy/lWEAIPxY4WV9E
         z1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757053223; x=1757658023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1D0tFcFLqHF1Q9avcWY7GzaOPrSnhPfLlTS1ShqQ78=;
        b=S/+f5XibU3lxb/CYCJkIG4dLFvyXCdbfxyQTucCxcq0zCluoTGCfRnGXXQYYoZhFpR
         +e9E3ArpZU+AbEBiv5vdd2aV4vD1Rz+7hpbWmjPEvcrxTHUkGtdiOo+pvckWAqbzsM5W
         Fs41wibsZLF+N4xwN63/HTcIur+SX8aaM008b7UAbRxOdpAwiqWGNE66auaOCc+Rtjm4
         NfTqO5e624TBer71D7HwIOZqX9fuP5DvOAOq5DghW2a/emhqzy0esyZiRji/qcssgP8u
         +1WUGPhizhW9kA8hlcLrvscbQCMcVsBrKPCh8F7EUUoRi3Tg1LJfYp49z5o92RZDdZ82
         VWtg==
X-Gm-Message-State: AOJu0Yzoo8YVUhNKpV8BRsKI9sZZ+vHV7yHaZOatpAcv9um5foB5VHCC
	TluRn58p4GT3fdsIiQh4k4UnOrCD65GxH09BOvg7biqFRkOlaEdfEObh4vMomtfokiSOI1a2Bq4
	2X2gdyp18EpxfCPNfE/kzlBLqUSXI0eVj+o2n1iOur0eRbZobXUulDyd3V20TFLTaAyT+ONwCBg
	RXd8MPCsQwLb0zMmqJXRKjkn2VuGFZN88VueFfMojh8HE=
X-Google-Smtp-Source: AGHT+IFQQDegPK1JLquYa2Btt2xTEI3n2zBVoGBAzlptzLJMmHcH1ccI1Z2dCflzOBy5lBuwZ3lh/EeBbPTHpg==
X-Received: from plem9.prod.google.com ([2002:a17:902:e409:b0:24a:d8b8:ee35])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c06:b0:246:cfc5:1b61 with SMTP id d9443c01a7336-24944b15b97mr283825415ad.55.1757053222726;
 Thu, 04 Sep 2025 23:20:22 -0700 (PDT)
Date: Fri,  5 Sep 2025 06:19:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905061919.439648-1-yepeilin@google.com>
Subject: [PATCH bpf] bpf/helpers: Skip memcg accounting in __bpf_async_init()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"

Calling bpf_map_kmalloc_node() from __bpf_async_init() can cause various
locking issues; see the following stack trace (edited for style) as one
example:

...
 [10.011566]  do_raw_spin_lock.cold
 [10.011570]  try_to_wake_up             (5) double-acquiring the same
 [10.011575]  kick_pool                      rq_lock, causing a hardlockup
 [10.011579]  __queue_work
 [10.011582]  queue_work_on
 [10.011585]  kernfs_notify
 [10.011589]  cgroup_file_notify
 [10.011593]  try_charge_memcg           (4) memcg accounting raises an
 [10.011597]  obj_cgroup_charge_pages        MEMCG_MAX event
 [10.011599]  obj_cgroup_charge_account
 [10.011600]  __memcg_slab_post_alloc_hook
 [10.011603]  __kmalloc_node_noprof
...
 [10.011611]  bpf_map_kmalloc_node
 [10.011612]  __bpf_async_init
 [10.011615]  bpf_timer_init             (3) BPF calls bpf_timer_init()
 [10.011617]  bpf_prog_xxxxxxxxxxxxxxxx_fcg_runnable
 [10.011619]  bpf__sched_ext_ops_runnable
 [10.011620]  enqueue_task_scx           (2) BPF runs with rq_lock held
 [10.011622]  enqueue_task
 [10.011626]  ttwu_do_activate
 [10.011629]  sched_ttwu_pending         (1) grabs rq_lock
...

The above was reproduced on bpf-next (b338cf849ec8) by modifying
./tools/sched_ext/scx_flatcg.bpf.c to call bpf_timer_init() during
ops.runnable(), and hacking [1] the memcg accounting code a bit to make
it (much more likely to) raise an MEMCG_MAX event from a
bpf_timer_init() call.

We have also run into other similar variants both internally (without
applying the [1] hack) and on bpf-next, including:

 * run_timer_softirq() -> cgroup_file_notify()
   (grabs cgroup_file_kn_lock) -> try_to_wake_up() ->
   BPF calls bpf_timer_init() -> bpf_map_kmalloc_node() ->
   try_charge_memcg() raises MEMCG_MAX ->
   cgroup_file_notify() (tries to grab cgroup_file_kn_lock again)

 * __queue_work() (grabs worker_pool::lock) -> try_to_wake_up() ->
   BPF calls bpf_timer_init() -> bpf_map_kmalloc_node() ->
   try_charge_memcg() raises MEMCG_MAX -> cgroup_file_notify() ->
   __queue_work() (tries to grab the same worker_pool::lock)
 ...

As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
bpf_hrtimer and bpf_work, to skip memcg accounting.

Tested with vmtest.sh (llvm-18, x86-64):

 $ ./test_progs -a '*timer*' -a '*wq*'
...
 Summary: 7/12 PASSED, 0 SKIPPED, 0 FAILED

[1] Making a bpf_timer_init() call (much more likely) to raise an
MEMCG_MAX event (gist-only, for brevity):

kernel/bpf/helpers.c:__bpf_async_init():
          /* allocate hrtimer via map_kmalloc to use memcg accounting */
 -        cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
 +        cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC | __GFP_HACK,
 +                                  map->numa_node);

mm/memcontrol.c:try_charge_memcg():
          if (!do_memsw_account() ||
 -            page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 -                if (page_counter_try_charge(&memcg->memory, batch, &counter))
 +            page_counter_try_charge_hack(&memcg->memsw, batch, &counter,
 +                                         gfp_mask & __GFP_HACK)) {
 +                if (page_counter_try_charge_hack(&memcg->memory, batch,
 +                                                 &counter,
 +                                                 gfp_mask & __GFP_HACK))
                          goto done_restock;

mm/page_counter.c:page_counter_try_charge():
 -bool page_counter_try_charge(struct page_counter *counter,
 -                             unsigned long nr_pages,
 -                             struct page_counter **fail)
 +bool page_counter_try_charge_hack(struct page_counter *counter,
 +                                  unsigned long nr_pages,
 +                                  struct page_counter **fail, bool hack)
 {
...
 -                if (new > c->max) {
 +                if (hack || new > c->max) {     // goto failed;
                          atomic_long_sub(nr_pages, &c->usage);
                          /*

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/helpers.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..f7f3c6fb59ee 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1085,10 +1085,7 @@ struct bpf_async_cb {
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
-	union {
-		struct rcu_head rcu;
-		struct work_struct delete_work;
-	};
+	struct work_struct delete_work;
 	u64 flags;
 };
 
@@ -1221,7 +1218,7 @@ static void bpf_wq_delete_work(struct work_struct *work)
 
 	cancel_work_sync(&w->work);
 
-	kfree_rcu(w, cb.rcu);
+	bpf_mem_free_rcu(&bpf_global_ma, w);
 }
 
 static void bpf_timer_delete_work(struct work_struct *work)
@@ -1230,13 +1227,13 @@ static void bpf_timer_delete_work(struct work_struct *work)
 
 	/* Cancel the timer and wait for callback to complete if it was running.
 	 * If hrtimer_cancel() can be safely called it's safe to call
-	 * kfree_rcu(t) right after for both preallocated and non-preallocated
+	 * bpf_mem_free_rcu(t) right after for both preallocated and non-preallocated
 	 * maps.  The async->cb = NULL was already done and no code path can see
 	 * address 't' anymore. Timer if armed for existing bpf_hrtimer before
 	 * bpf_timer_cancel_and_free will have been cancelled.
 	 */
 	hrtimer_cancel(&t->timer);
-	kfree_rcu(t, cb.rcu);
+	bpf_mem_free_rcu(&bpf_global_ma, t);
 }
 
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
@@ -1270,8 +1267,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		goto out;
 	}
 
-	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	cb = bpf_mem_alloc(&bpf_global_ma, size);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
@@ -1567,7 +1563,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
 	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
 	 * just return -1). Though callback_fn is still running on this cpu it's
-	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
+	 * safe to free 't' because bpf_timer_cb() read everything it needed
 	 * from 't'. The bpf subprog callback_fn won't be able to access 't',
 	 * since async->cb = NULL was already done. The timer will be
 	 * effectively cancelled because bpf_timer_cb() will return
@@ -1577,7 +1573,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 * timer _before_ calling us, such that failing to cancel it here will
 	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
 	 * Therefore, we _need_ to cancel any outstanding timers before we do
-	 * kfree_rcu, even though no more timers can be armed.
+	 * bpf_mem_free_rcu(), even though no more timers can be armed.
 	 *
 	 * Moreover, we need to schedule work even if timer does not belong to
 	 * the calling callback_fn, as on two different CPUs, we can end up in a
@@ -1604,7 +1600,7 @@ void bpf_timer_cancel_and_free(void *val)
 		 * completion.
 		 */
 		if (hrtimer_try_to_cancel(&t->timer) >= 0)
-			kfree_rcu(t, cb.rcu);
+			bpf_mem_free_rcu(&bpf_global_ma, t);
 		else
 			queue_work(system_unbound_wq, &t->cb.delete_work);
 	} else {
-- 
2.51.0.355.g5224444f11-goog


