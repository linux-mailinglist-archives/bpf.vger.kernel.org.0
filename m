Return-Path: <bpf+bounces-38046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B05795E846
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 08:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4881F21317
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 06:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E3880BFC;
	Mon, 26 Aug 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETQf3ddw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B428063C
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652455; cv=none; b=AUNwl5q/J57/9oosK6Si39rx7MuwG/ha+eyuq4YrP5IuAJv3KISY4WINIFjIBnIkBDlB4Nh3GiWQ21Q2hAN04PHApk+SWhzvfoqbgRu8oNufGw+kF6hQ4jhjyZz6jxHOlbI0iSE+1hNUlpzcDv8agW73zuTHWL0V+hzLiTsmhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652455; c=relaxed/simple;
	bh=MMSiQ6lhkGsqFXG/rMGNy9B1dCR4Ngw80CFeon1CB/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJf9hJFXKc+LiX7WKn5aSRcZXVmIVArce3GeY4osOx+a42LVMg+WJWTmd6si5+o6ZjFL6dCc22bAlIRmd7udX8ToN/bxsAUepvwj3xMuy92ve6SEzHQ6PjHtF/hJ4LH8GNhW3FEc+YWXvfwXK0g2wEHacSquZIFza0dDf/9N3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETQf3ddw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724652452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lFnENs5r2pJcJI/rrlJl9gwi0xMLjZODILVM4z0LNSs=;
	b=ETQf3ddw4JSH0PIIzh+Rjwh547PQaghDeoZc/cvFyA/+OlDNF9Wh8OKMOEqxMCQeClOZQs
	sFEmKr2sS61M9W4FuasGu8If6bcV4MG3C8BVwBrfw2N/gVU99+0qhww9OqXRLXaiuwy7G3
	T7GkulzF6Ew26bxc+zZb5tzEOqjP08w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-mEv3_q-nO0-bFzCz0vQdCw-1; Mon,
 26 Aug 2024 02:07:27 -0400
X-MC-Unique: mEv3_q-nO0-bFzCz0vQdCw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFC481955BEE;
	Mon, 26 Aug 2024 06:07:25 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.132])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9892619560A3;
	Mon, 26 Aug 2024 06:07:22 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	bpf@vger.kernel.org,
	Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2] objpool: fix choosing allocation for percpu slots
Date: Mon, 26 Aug 2024 08:07:18 +0200
Message-ID: <20240826060718.267261-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

objpool intends to use vmalloc for default (non-atomic) allocations of
percpu slots and objects. However, the condition checking if GFP flags
are equal to GFP_ATOMIC is wrong b/c GFP_ATOMIC is a combination of bits
(__GFP_HIGH|__GFP_KSWAPD_RECLAIM) and so `pool->gfp & GFP_ATOMIC` will
be true if either bit is set. Since GFP_ATOMIC and GFP_KERNEL share the
___GFP_KSWAPD_RECLAIM bit, kmalloc will be used in cases when GFP_KERNEL
is specified, i.e. in all current usages of objpool.

This may lead to unexpected OOM errors since kmalloc cannot allocate
large amounts of memory.

For instance, objpool is used by fprobe rethook which in turn is used by
BPF kretprobe.multi and kprobe.session probe types. Trying to attach
these to all kernel functions with libbpf using

    SEC("kprobe.session/*")
    int kprobe(struct pt_regs *ctx)
    {
        [...]
    }

fails on objpool slot allocation with ENOMEM.

Fix the condition to truly use vmalloc by default.

Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
---
 lib/objpool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/objpool.c b/lib/objpool.c
index 234f9d0bd081..fd108fe0d095 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -76,7 +76,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
 		 * mimimal size of vmalloc is one page since vmalloc would
 		 * always align the requested size to page size
 		 */
-		if (pool->gfp & GFP_ATOMIC)
+		if ((pool->gfp & GFP_ATOMIC) == GFP_ATOMIC)
 			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
 		else
 			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
-- 
2.46.0


