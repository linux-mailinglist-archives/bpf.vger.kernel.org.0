Return-Path: <bpf+bounces-53933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B32A5ECE9
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 08:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73971189BFA6
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A231FCFC9;
	Thu, 13 Mar 2025 07:22:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D11FC11E;
	Thu, 13 Mar 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850572; cv=none; b=Lhmtqkt4s9qdWH0vR4xiXeYwwPQ1aHBIYTX4KPk0oetSaLNWx2KFWhFS0OPlKOOBfjMt3R2aJObbRDKFNcxB5KJp5MQzg3Tn6AEN/YU/KAtYjGteOPkLv9MwcyKFzqEu8sIe03CISd0+Yj+CBiTVXl0FL/dcSdwxswirURDxw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850572; c=relaxed/simple;
	bh=+4UJPRqu7JasO2Yf/capeBLoYVmF+HrA7u/DJDlT/1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lv/eERRptO14VMYCkuQE/ySCXTZY/5sSCoX115F2psodMLCowsPeS8obpnuh6A0uktGcY6tZWOvGSZ8TR7PkfVlDBa5Wis6+lNtKXyySYiCrCoO/t85AVflCH9aQIqeAogRomDBmxx8CdTjf7K+FSfpmxddrpgMnZZoRpHgjRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D6vRg3030456;
	Thu, 13 Mar 2025 00:22:01 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45b0j4smsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Mar 2025 00:22:00 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 13 Mar 2025 00:22:00 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 13 Mar 2025 00:21:56 -0700
From: <jianqi.ren.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>, <bpf@vger.kernel.org>, <bgrech@redhat.com>,
        <wander.lairson@gmail.com>, <wander@redhat.com>
Subject: [PATCH 6.6.y] bpf: Use raw_spinlock_t in ringbuf
Date: Thu, 13 Mar 2025 15:21:55 +0800
Message-ID: <20250313072155.167331-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Cc0I5Krl c=1 sm=1 tr=0 ts=67d28798 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=hWMQpYRtAAAA:8 a=t7CeM3EgAAAA:8
 a=mcpU0V_MDO7S8Gi0BcUA:9 a=KCsI-UfzjElwHeZNREa_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 6AKU1_7RwWQ6zb2c0cXbhaimSrxOWr14
X-Proofpoint-GUID: 6AKU1_7RwWQ6zb2c0cXbhaimSrxOWr14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2503130057

From: Wander Lairson Costa <wander.lairson@gmail.com>

[ Upstream commit 8b62645b09f870d70c7910e7550289d444239a46 ]

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

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: Brian Grech <bgrech@redhat.com>
Signed-off-by: Wander Lairson Costa <wander.lairson@gmail.com>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20240920190700.617253-1-wander@redhat.com
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 kernel/bpf/ringbuf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 528f4d634226..6aff5ee483b6 100644
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
@@ -417,10 +417,10 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
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
@@ -446,7 +446,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	 */
 	if (new_prod_pos - cons_pos > rb->mask ||
 	    new_prod_pos - pend_pos > rb->mask) {
-		spin_unlock_irqrestore(&rb->spinlock, flags);
+		raw_spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
 
@@ -458,7 +458,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	/* pairs with consumer's smp_load_acquire() */
 	smp_store_release(&rb->producer_pos, new_prod_pos);
 
-	spin_unlock_irqrestore(&rb->spinlock, flags);
+	raw_spin_unlock_irqrestore(&rb->spinlock, flags);
 
 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
 }
-- 
2.25.1


