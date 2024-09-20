Return-Path: <bpf+bounces-40144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1C97D9C0
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1150C1F23878
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD618452C;
	Fri, 20 Sep 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7UJKq89"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225DC383B1
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726859262; cv=none; b=iKLfkkiPc0Bq7wlElDRZ0rxwjBaO14CSU7akkS83USLJK7s1014sPPMhhEGPiPsUJva6OwXzt7Askv7LAfQ9SQlyiakR0BqGe55UQquwHMH2jK8lkerSKnC6g6lSnNZmWIvzx+9c2vezi3+x5kQER/R7Tr+Fl1JLN5MYlfFqSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726859262; c=relaxed/simple;
	bh=XYleqDUUULMHmf327GC5FuqVofTnEl06Sl9up1zkKig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bm5xmEveMD8k7sCwFD37BuAs6FpSL61zy9XcJsfCIbf9Wh/iDWuAPCAjkkSDLoQOwqJmyvzyumGz4MYRKEDtpz4IMATdU1uXK1xgCuWKmZPK1OBpid0SBTXP0yaTlfD2H4d4sSXQUnzv1LuddUfiCIPaCd2oRT+4IameUorevnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7UJKq89; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726859258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dS1KGNZWGk2nhsYDCIsD8L7gyADHJUWHZbHDXT7ckqE=;
	b=f7UJKq89SWfnaAuLBMiGq3lO+L2r4UDqv/dDZrNi5IuP2orXGb1wu4CCiiztbMOk6UpKTM
	2HQl/1RFcc3TEQblPsu/hTMQrAF0onkkv6Sl9gFZBR9NgrR6NOqY3EGaC36CRPo3oh+IEH
	gMo7GWBJpyLr0zXX6OsBmK2TgmvKhIU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-jaoiHIvdPqyl0OxF8OxWVA-1; Fri,
 20 Sep 2024 15:07:33 -0400
X-MC-Unique: jaoiHIvdPqyl0OxF8OxWVA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B07D9192DE06;
	Fri, 20 Sep 2024 19:07:30 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.33.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F8C219560A3;
	Fri, 20 Sep 2024 19:07:23 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [RINGBUF]),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander.lairson@gmail.com>,
	Brian Grech <bgrech@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] bpf: use raw_spinlock_t in ringbuf
Date: Fri, 20 Sep 2024 16:06:59 -0300
Message-ID: <20240920190700.617253-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Wander Lairson Costa <wander.lairson@gmail.com>

The function __bpf_ringbuf_reserve is invoked from a tracepoint, which
disables preemption. Using spinlock_t in this context can lead to a
"sleep in atomic" warning in the RT variant. This issue is illustrated
in the example below:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 556208, name: test_progs
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffd33a5c88ea44>] migrate_enable+0xc0/0x39c
CPU: 7 PID: 556208 Comm: test_progs Tainted: G
Hardware name: Qualcomm SA8775P Ride (DT)
Call trace:
 dump_backtrace+0xac/0x130
 show_stack+0x1c/0x30
 dump_stack_lvl+0xac/0xe8
 dump_stack+0x18/0x30
 __might_resched+0x3bc/0x4fc
 rt_spin_lock+0x8c/0x1a4
 __bpf_ringbuf_reserve+0xc4/0x254
 bpf_ringbuf_reserve_dynptr+0x5c/0xdc
 bpf_prog_ac3d15160d62622a_test_read_write+0x104/0x238
 trace_call_bpf+0x238/0x774
 perf_call_bpf_enter.isra.0+0x104/0x194
 perf_syscall_enter+0x2f8/0x510
 trace_sys_enter+0x39c/0x564
 syscall_trace_enter+0x220/0x3c0
 do_el0_svc+0x138/0x1dc
 el0_svc+0x54/0x130
 el0t_64_sync_handler+0x134/0x150
 el0t_64_sync+0x17c/0x180

Switch the spinlock to raw_spinlock_t to avoid this error.

Signed-off-by: Wander Lairson Costa <wander.lairson@gmail.com>
Reported-by: Brian Grech <bgrech@redhat.com>
Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/bpf/ringbuf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e20b90c36131..de3b681d1d13 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -29,7 +29,7 @@ struct bpf_ringbuf {
 	u64 mask;
 	struct page **pages;
 	int nr_pages;
-	spinlock_t spinlock ____cacheline_aligned_in_smp;
+	raw_spinlock_t spinlock ____cacheline_aligned_in_smp;
 	/* For user-space producer ring buffers, an atomic_t busy bit is used
 	 * to synchronize access to the ring buffers in the kernel, rather than
 	 * the spinlock that is used for kernel-producer ring buffers. This is
@@ -173,7 +173,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	if (!rb)
 		return NULL;
 
-	spin_lock_init(&rb->spinlock);
+	raw_spin_lock_init(&rb->spinlock);
 	atomic_set(&rb->busy, 0);
 	init_waitqueue_head(&rb->waitq);
 	init_irq_work(&rb->work, bpf_ringbuf_notify);
@@ -421,10 +421,10 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
 
 	if (in_nmi()) {
-		if (!spin_trylock_irqsave(&rb->spinlock, flags))
+		if (!raw_spin_trylock_irqsave(&rb->spinlock, flags))
 			return NULL;
 	} else {
-		spin_lock_irqsave(&rb->spinlock, flags);
+		raw_spin_lock_irqsave(&rb->spinlock, flags);
 	}
 
 	pend_pos = rb->pending_pos;
@@ -450,7 +450,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	 */
 	if (new_prod_pos - cons_pos > rb->mask ||
 	    new_prod_pos - pend_pos > rb->mask) {
-		spin_unlock_irqrestore(&rb->spinlock, flags);
+		raw_spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
 
@@ -462,7 +462,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	/* pairs with consumer's smp_load_acquire() */
 	smp_store_release(&rb->producer_pos, new_prod_pos);
 
-	spin_unlock_irqrestore(&rb->spinlock, flags);
+	raw_spin_unlock_irqrestore(&rb->spinlock, flags);
 
 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
 }
-- 
2.46.1


