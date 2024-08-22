Return-Path: <bpf+bounces-37831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1353095B039
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B9BBB23442
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C517DE06;
	Thu, 22 Aug 2024 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZerDaVse"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D316F271
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315134; cv=none; b=Vx0Dremz9bcrxj7JuiKkY5ElMgmYw97bvbYJaL0JURb3oBpMYoxzQesrD2/xmHc95YnGZOdmpqD9ad8UZ/pR6kRgqkOTALHQsT1gjlXDhpgxzV/ObjM7P9YaowXWfb0smMsQhjQsjegROExfPD+3J4X5ZHyxzBY4DrnDS/yMpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315134; c=relaxed/simple;
	bh=nvGsja343OkPEOmTnZePk7VBpQa7rGsvn+1UyN4C8Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJk2ySSRIWotV0YWQwq2RLHAH5j1rErAnTpP5IhliZgt7XqXhSszXbIOWLt1qW7bC9aCvw0hZKGx/GkL9TbQ5dVYZSibW7xeI3+nefj7IP7IxkHD5Bqb9v3vcAtjVDNezQqFiv/k7pML+cdYnf8/TdZY9QK5Un2WKuQlhs6ys24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZerDaVse; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724315131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=60ZmGMMj/oNEyr5Dg12eoH4vxkNmR3gh9oRVlxexhQw=;
	b=ZerDaVse9iki1cluYxMMVK75EMqpn/QKdGiK4WRn9xvOcduX1gy438DJagPWq2782Uyyzj
	cKY1Ux2BFAZ4mqRAxC8E+uoGgo9dVVXgCuPByecgW1v9JHTmvJtMNiHyfEXqGEQAhl+Z2Q
	b7+xKIXm/HlJscSScNec9VbsrmgRouE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-NTHhRH1kMPekFS4LfkPL7g-1; Thu,
 22 Aug 2024 04:25:28 -0400
X-MC-Unique: NTHhRH1kMPekFS4LfkPL7g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 036CE1954B0F;
	Thu, 22 Aug 2024 08:25:27 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C61A01955F21;
	Thu, 22 Aug 2024 08:25:24 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	bpf@vger.kernel.org,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH] objpool: fix choosing allocation for percpu slots
Date: Thu, 22 Aug 2024 10:25:19 +0200
Message-ID: <20240822082519.216070-1-vmalik@redhat.com>
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
are equal to GFP_ATOMIC is wrong and causes kmalloc to be used in most
cases (even if GFP_KERNEL is requested). Since kmalloc cannot allocate
large amounts of memory, this may lead to unexpected OOM errors.

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


