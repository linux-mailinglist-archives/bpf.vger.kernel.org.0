Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC45D40133F
	for <lists+bpf@lfdr.de>; Mon,  6 Sep 2021 03:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhIFBYw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Sep 2021 21:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239789AbhIFBXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Sep 2021 21:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA6B161164;
        Mon,  6 Sep 2021 01:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891305;
        bh=xqDJY+Ve/3PvQAXOoBIQfvHgmdTDQqXae5sOyZFfw4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qs2sBTZaUzOhq/zKi7EID1adXzzzd9hz+hRBuaTsDBKgOUWmSzIYxb8WoT4Xh6dnw
         fbTZdQo68Dxh2Zo19+EHaWX2XmSocAGzZ86QGQNTuBPBP8jmPHhJoNdHoK2SKCq07R
         5d4SDvu65HvO1tJ7Kt8/UBJyi2G0zqgjfr1OyLxNCBvk0x6UG/mzyjG7OdS2jztXUN
         +KVlscXJYZvFRYnFQ+Mdgye3TVQb7sz8MZ4wU4VSiJas7V/TAK/KTq5g4zDOENG/Jy
         miJIRJjsAiR+n8QhGj1iA8Aq7L4gUq2BET1Iq9kF7W7zK0cKgEccP4yusMnR1ytuz3
         u0CbM3TCALHsw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 41/46] io-wq: remove GFP_ATOMIC allocation off schedule out path
Date:   Sun,  5 Sep 2021 21:20:46 -0400
Message-Id: <20210906012052.929174-41-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012052.929174-1-sashal@kernel.org>
References: <20210906012052.929174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit d3e9f732c415cf22faa33d6f195e291ad82dc92e ]

Daniel reports that the v5.14-rc4-rt4 kernel throws a BUG when running
stress-ng:

| [   90.202543] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
| [   90.202549] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2047, name: iou-wrk-2041
| [   90.202555] CPU: 5 PID: 2047 Comm: iou-wrk-2041 Tainted: G        W         5.14.0-rc4-rt4+ #89
| [   90.202559] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
| [   90.202561] Call Trace:
| [   90.202577]  dump_stack_lvl+0x34/0x44
| [   90.202584]  ___might_sleep.cold+0x87/0x94
| [   90.202588]  rt_spin_lock+0x19/0x70
| [   90.202593]  ___slab_alloc+0xcb/0x7d0
| [   90.202598]  ? newidle_balance.constprop.0+0xf5/0x3b0
| [   90.202603]  ? dequeue_entity+0xc3/0x290
| [   90.202605]  ? io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202610]  ? pick_next_task_fair+0xb9/0x330
| [   90.202612]  ? __schedule+0x670/0x1410
| [   90.202615]  ? io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202618]  kmem_cache_alloc_trace+0x79/0x1f0
| [   90.202621]  io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202625]  io_wq_worker_sleeping+0x37/0x50
| [   90.202628]  schedule+0x30/0xd0
| [   90.202630]  schedule_timeout+0x8f/0x1a0
| [   90.202634]  ? __bpf_trace_tick_stop+0x10/0x10
| [   90.202637]  io_wqe_worker+0xfd/0x320
| [   90.202641]  ? finish_task_switch.isra.0+0xd3/0x290
| [   90.202644]  ? io_worker_handle_work+0x670/0x670
| [   90.202646]  ? io_worker_handle_work+0x670/0x670
| [   90.202649]  ret_from_fork+0x22/0x30

which is due to the RT kernel not liking a GFP_ATOMIC allocation inside
a raw spinlock. Besides that not working on RT, doing any kind of
allocation from inside schedule() is kind of nasty and should be avoided
if at all possible.

This particular path happens when an io-wq worker goes to sleep, and we
need a new worker to handle pending work. We currently allocate a small
data item to hold the information we need to create a new worker, but we
can instead include this data in the io_worker struct itself and just
protect it with a single bit lock. We only really need one per worker
anyway, as we will have run pending work between to sleep cycles.

https://lore.kernel.org/lkml/20210804082418.fbibprcwtzyt5qax@beryllium.lan/
Reported-by: Daniel Wagner <dwagner@suse.de>
Tested-by: Daniel Wagner <dwagner@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io-wq.c | 72 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 91b0d1fb90eb..87705ae951fd 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -53,6 +53,10 @@ struct io_worker {
 
 	struct completion ref_done;
 
+	unsigned long create_state;
+	struct callback_head create_work;
+	int create_index;
+
 	struct rcu_head rcu;
 };
 
@@ -273,24 +277,18 @@ static void io_wqe_inc_running(struct io_worker *worker)
 	atomic_inc(&acct->nr_running);
 }
 
-struct create_worker_data {
-	struct callback_head work;
-	struct io_wqe *wqe;
-	int index;
-};
-
 static void create_worker_cb(struct callback_head *cb)
 {
-	struct create_worker_data *cwd;
+	struct io_worker *worker;
 	struct io_wq *wq;
 	struct io_wqe *wqe;
 	struct io_wqe_acct *acct;
 	bool do_create = false, first = false;
 
-	cwd = container_of(cb, struct create_worker_data, work);
-	wqe = cwd->wqe;
+	worker = container_of(cb, struct io_worker, create_work);
+	wqe = worker->wqe;
 	wq = wqe->wq;
-	acct = &wqe->acct[cwd->index];
+	acct = &wqe->acct[worker->create_index];
 	raw_spin_lock_irq(&wqe->lock);
 	if (acct->nr_workers < acct->max_workers) {
 		if (!acct->nr_workers)
@@ -300,33 +298,42 @@ static void create_worker_cb(struct callback_head *cb)
 	}
 	raw_spin_unlock_irq(&wqe->lock);
 	if (do_create) {
-		create_io_worker(wq, wqe, cwd->index, first);
+		create_io_worker(wq, wqe, worker->create_index, first);
 	} else {
 		atomic_dec(&acct->nr_running);
 		io_worker_ref_put(wq);
 	}
-	kfree(cwd);
+	clear_bit_unlock(0, &worker->create_state);
+	io_worker_release(worker);
 }
 
-static void io_queue_worker_create(struct io_wqe *wqe, struct io_wqe_acct *acct)
+static void io_queue_worker_create(struct io_wqe *wqe, struct io_worker *worker,
+				   struct io_wqe_acct *acct)
 {
-	struct create_worker_data *cwd;
 	struct io_wq *wq = wqe->wq;
 
 	/* raced with exit, just ignore create call */
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state))
 		goto fail;
+	if (!io_worker_get(worker))
+		goto fail;
+	/*
+	 * create_state manages ownership of create_work/index. We should
+	 * only need one entry per worker, as the worker going to sleep
+	 * will trigger the condition, and waking will clear it once it
+	 * runs the task_work.
+	 */
+	if (test_bit(0, &worker->create_state) ||
+	    test_and_set_bit_lock(0, &worker->create_state))
+		goto fail_release;
 
-	cwd = kmalloc(sizeof(*cwd), GFP_ATOMIC);
-	if (cwd) {
-		init_task_work(&cwd->work, create_worker_cb);
-		cwd->wqe = wqe;
-		cwd->index = acct->index;
-		if (!task_work_add(wq->task, &cwd->work, TWA_SIGNAL))
-			return;
-
-		kfree(cwd);
-	}
+	init_task_work(&worker->create_work, create_worker_cb);
+	worker->create_index = acct->index;
+	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL))
+		return;
+	clear_bit_unlock(0, &worker->create_state);
+fail_release:
+	io_worker_release(worker);
 fail:
 	atomic_dec(&acct->nr_running);
 	io_worker_ref_put(wq);
@@ -344,7 +351,7 @@ static void io_wqe_dec_running(struct io_worker *worker)
 	if (atomic_dec_and_test(&acct->nr_running) && io_wqe_run_queue(wqe)) {
 		atomic_inc(&acct->nr_running);
 		atomic_inc(&wqe->wq->worker_refs);
-		io_queue_worker_create(wqe, acct);
+		io_queue_worker_create(wqe, worker, acct);
 	}
 }
 
@@ -1010,12 +1017,12 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 static bool io_task_work_match(struct callback_head *cb, void *data)
 {
-	struct create_worker_data *cwd;
+	struct io_worker *worker;
 
 	if (cb->func != create_worker_cb)
 		return false;
-	cwd = container_of(cb, struct create_worker_data, work);
-	return cwd->wqe->wq == data;
+	worker = container_of(cb, struct io_worker, create_work);
+	return worker->wqe->wq == data;
 }
 
 void io_wq_exit_start(struct io_wq *wq)
@@ -1032,12 +1039,13 @@ static void io_wq_exit_workers(struct io_wq *wq)
 		return;
 
 	while ((cb = task_work_cancel_match(wq->task, io_task_work_match, wq)) != NULL) {
-		struct create_worker_data *cwd;
+		struct io_worker *worker;
 
-		cwd = container_of(cb, struct create_worker_data, work);
-		atomic_dec(&cwd->wqe->acct[cwd->index].nr_running);
+		worker = container_of(cb, struct io_worker, create_work);
+		atomic_dec(&worker->wqe->acct[worker->create_index].nr_running);
 		io_worker_ref_put(wq);
-		kfree(cwd);
+		clear_bit_unlock(0, &worker->create_state);
+		io_worker_release(worker);
 	}
 
 	rcu_read_lock();
-- 
2.30.2

