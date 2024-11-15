Return-Path: <bpf+bounces-44933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F20329CDA6D
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF0B2286C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56238189F30;
	Fri, 15 Nov 2024 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkHnrbJO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC52B9B7
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659170; cv=none; b=o7ep/Pfqhh2Jn+YptnjNW1sKSZsH2uIt2ePC8zjyI5Ji4hFcReN/4p9Z8Eo1aChfXP1lBS39PZds6mHTsjUfbXUwLRELTrjXw1GbjTlMyaneKN4p5KQuLH4/uF93YNP8i0FHgcP55tiUl7Zo4+WLPdyWfYJ5dK7tC3kqExaIE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659170; c=relaxed/simple;
	bh=HVxEviNA/RgwRinzXUn3nAOwo6clK1G8lX/PS/GWZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBQV3wHOPpplESOdIadqbf5drspINmoaZRtLRZCKb+fanz1eceiFAiHWyyc3BkpHTYzzeirxjfDOcRIrL68g7F+ybT7/huUq/j/c3gPuOMrWJqlKxs6y8DCGhtd/WEwIyudMmACsbDbzBxPGaij0s/xOU2tOn3XFSoGDwz0Zqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkHnrbJO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731659168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GT2vW1PesPz8e7hj5p5WDYdWOm34OWl139ZOKyDu0SY=;
	b=SkHnrbJOYwV9jOm407X/Ez1gB4TO1ptu9dPPZlg/6KIlynn9BGYE3SqpwSiOfKGZuWTtZL
	cofjvIy7jSvFyqcB+TiidUwgNvbwujVMGHPCknmqa4nhDfmhv5RsovAEcFyH0xG2jU7REo
	6gGene+5NRqw5L19h7Rqjo/R0syVqTs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-UFc1kiciNXivQUOKu21ETQ-1; Fri,
 15 Nov 2024 03:26:03 -0500
X-MC-Unique: UFc1kiciNXivQUOKu21ETQ-1
X-Mimecast-MFC-AGG-ID: UFc1kiciNXivQUOKu21ETQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 878AF1955F41;
	Fri, 15 Nov 2024 08:25:59 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44112195E48C;
	Fri, 15 Nov 2024 08:25:53 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next] bpf: Do not alloc arena on unsupported arches
Date: Fri, 15 Nov 2024 09:25:48 +0100
Message-ID: <20241115082548.74972-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Do not allocate BPF arena on arches that do not support it, instead
return EOPNOTSUPP. This is useful to prevent bugs such as soft lockups
while trying to free the arena which we have witnessed on ppc64le [1].

[1] https://lore.kernel.org/bpf/4afdcb50-13f2-4772-8db1-3fd02bd985b3@redhat.com/

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/arena.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 3e1dfe349ced..945a5680f6a5 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -3,6 +3,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/err.h>
+#include "linux/filter.h"
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
@@ -99,6 +100,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	u64 vm_range;
 	int err = -ENOMEM;
 
+	if (!bpf_jit_supports_arena())
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (attr->key_size || attr->value_size || attr->max_entries == 0 ||
 	    /* BPF_F_MMAPABLE must be set */
 	    !(attr->map_flags & BPF_F_MMAPABLE) ||
-- 
2.47.0


