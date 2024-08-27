Return-Path: <bpf+bounces-38188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225599616B2
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8601F255A4
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA271D3194;
	Tue, 27 Aug 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BLQSlbLl"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161101D3188
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782636; cv=none; b=HLQ0h6ms3BxDGdwImAkOfPDhqmP6VS4jhf44RDMZBLoEi1frckFHrgW6sshNNZm37TcHtucOqaDjjw0a+wBiZhUT+tYsjD0LNZphbtRO9n0iyYjqGhcesHUdV20Ys6foNcoFldhI1AIyIRJPwoIhjyCA8stGka92dX84f6E1+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782636; c=relaxed/simple;
	bh=TGLozP1T8y9Syv46OWMDS3t1f/QdzTBqDQJB23S5jMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7NPgau8qdCnjd9V/37sakC5X599PCcDv0K870Rmg1u/NeH2yBAqbdkuTiZ2Ubwbe+kB8hYDdWXZdLE2rzBCMxxJ5tyUD/OmZeMWJfZKWYhSd0QNGQ2jutw9hYbjF1gK9aPsH43z0lr/aVlLxC/XKneBgu2UosSJjB3RpRVOjAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BLQSlbLl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724782630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7C2VtnQMppUsC7qptuP0MiQLIPaakPSFnQH53irf9Y=;
	b=BLQSlbLlsADHBqzgxZJkzG5d6Cd8Gvl9k2X3TV4OvQm96tU/8LnOMRPfT+8XdH0afYIdI4
	nv0abcu0rtocaeVM7QMzNEDEXOyt5hw/e7oaUFycRMAPT8S8kdIZG52FkkorA8OnzbllF0
	epxYiXKBYezqEZQxkM6qse8fS1IBcDw=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 4/9] bpf: Export bpf_base_func_proto
Date: Tue, 27 Aug 2024 11:16:40 -0700
Message-ID: <20240827181647.847890-5-martin.lau@linux.dev>
In-Reply-To: <20240827181647.847890-1-martin.lau@linux.dev>
References: <20240827181647.847890-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf_testmod needs to use the bpf_tail_call helper in
a later selftest patch. This patch is to EXPORT_GPL_SYMBOL
the bpf_base_func_proto.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7e7761c537f8..3956be5d6440 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2034,6 +2034,7 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(bpf_base_func_proto);
 
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
-- 
2.43.5


