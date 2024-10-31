Return-Path: <bpf+bounces-43637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33839B76FD
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0361C2202C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6E17BED2;
	Thu, 31 Oct 2024 09:01:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FD1BD9ED
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365271; cv=none; b=CAY9d0zaLqiMXB/kgklMg8K3xYPBx91zNSJoDXfp6VSxVlRQUbDXE8gdciW+w10KGWGn1uNCZXitr+rh6NVsBkASea4MPY6f14AtiAwHtJcrTptTYNilt+/Wdepeae34P7MyYCzGbbDGQ4Qpd1EQzzO70sTV5+qyTtbWEujJ/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365271; c=relaxed/simple;
	bh=XuNBrNSWs/pPoyq8PE9zgW+jDfOBoQit6f45ZwXXwTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eiIqvJwWAD3ksc/+uZRTxAxa2oU4W1HDuwp2PAy8qo4FTOQsxFF+mlbRu4HS5mC8fWNRjXuwX0539hgBQDrc5Tyooluan5ziO6t9xtx3e/ycnBChXg4s7GTRL4xGihR4uWK/SZz2q1nT0eyxbcPTdPZeQdfgtYR439Nd++xXuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4XfHW41fzWzYkxgc;
	Thu, 31 Oct 2024 16:40:16 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 16:42:52 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 16:42:52 +0800
From: <zhongjinji@honor.com>
To: <ast@kernel.org>
CC: <andrii@kernel.org>, <billy@starlabs.sg>, <bpf@vger.kernel.org>,
	<ramdhan@starlabs.sg>, <zhongjinji@honor.com>, <yipengxiang@honor.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>
Subject: [PATCH] bpf: smp_wmb before bpf_ringbuf really commit
Date: Thu, 31 Oct 2024 16:42:46 +0800
Message-ID: <20241031084246.20737-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a018.hihonor.com
 (10.68.17.250)

From: zhongjinji <zhongjinji@honor.com>

To guarantee visibility of writing ringbuffer,it is necessary
to call smp_wmb before ringbuffer really commit.
for instance, when updating the data of buffer in cpu1,
it is not visible for the cpu2 which may be accessing buffer. This may
lead to the consumer accessing a incorrect data. using the smp_wmb
before commmit will guarantee that the consume can access the correct data.

CPU1:
    struct mem_event_t* data = bpf_ringbuf_reserve();
    data->type = MEM_EVENT_KSWAPD_WAKE;
    data->event_data.kswapd_wake.node_id = args->nid;
    bpf_ringbuf_commit(data);

CPU2:
    cons_pos = smp_load_acquire(r->consumer_pos);
    len_ptr = r->data + (cons_pos & r->mask);
    sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
    access to sample

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 kernel/bpf/ringbuf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e1cfe890e0be..a66059e2b0d6 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -508,6 +508,10 @@ static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
 	rec_pos = (void *)hdr - (void *)rb->data;
 	cons_pos = smp_load_acquire(&rb->consumer_pos) & rb->mask;
 
+	/* Make sure the modification of data is visible on other CPU's
+	 * before consume the event
+	 */
+	smp_wmb();
 	if (flags & BPF_RB_FORCE_WAKEUP)
 		irq_work_queue(&rb->work);
 	else if (cons_pos == rec_pos && !(flags & BPF_RB_NO_WAKEUP))
-- 
2.17.1


