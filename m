Return-Path: <bpf+bounces-56264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64ABA93FFE
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539553A7560
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A155254B02;
	Fri, 18 Apr 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rMnpn+/w"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6717254AEE
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016445; cv=none; b=ZmI3spChJNsVhpsHbAtBEDIuxljH8xZWqmsvNt1jzlYyPxd+8oQ8g+7wue4q62V2s/+kBiyYJQZhSBQ/bC4ovGmzc28v4lG88r6dPHt1+G2qtglYgbQ0sPMlkzEsG/t8ceJ6yi8PSeykyV7Z1Vx9rOwftIJtlw+3XexxzdwbLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016445; c=relaxed/simple;
	bh=POUP65QfD3Jih/Phx3rYNjjGtPYxJ2oOCLOCs/kFtkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOBcfIWPvNcPqUlW2FV30PJmgMUncoqA7qlJ9wCwjcg2t9yGZ/REzidfEUUVlU/FUXomEpP/ZYTTDnM7tQWFHxnxkZcU4Gtr+fCLU4NiQG60AqSKZ26NxWYIJw13N3LZ/C7lBjTLEgxqyaLdnD5TedD3ZDMyV11rbaF6OJCePek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rMnpn+/w; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0gs555Cz68mhNJtdgXeq87LKiQaPcHB8ENqO0L6Ljs=;
	b=rMnpn+/wE8NeytoHBMVZ6KoNn79A47IQB9lv2Wr7V3GBo4MJRcj1TK75VeirKyJbxlnEBV
	E+OvZ5olbjM/YapFKMH4Fxq4tenuq2vM+609662CfXcDOZHqX6fJiqn9oPEL3tJSv/6u48
	uYFx+ENECjYKXiIHwoGkBo8SSg9HDGE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 05/12] bpf: Allow refcounted bpf_rb_node used in bpf_rbtree_{remove,left,right}
Date: Fri, 18 Apr 2025 15:46:43 -0700
Message-ID: <20250418224652.105998-6-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-1-martin.lau@linux.dev>
References: <20250418224652.105998-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf_rbtree_{remove,left,right} requires the root's lock to be held.
They also check the node_internal->owner is still owned by that root
before proceeding, so it is safe to allow refcounted bpf_rb_node
pointer to be used in these kfuncs.

In the later selftest, a networking flow (allocated by bpf_obj_new)
can be added to two different rbtrees. There are cases that the flow
is searched from one rbtree, held the refcount of the flow,
and then removed from the another rbtree:

struct fq_flow {
	struct bpf_rb_node	fq_node;
	struct bpf_rb_node	rate_node;
	struct bpf_refcount	refcount;
	unsigned long		sk_long;
};

int bpf_fq_enqueue(...)
{
	/* ... */

	bpf_spin_lock(&root->lock);
	while (can_loop) {
		/* ... */
		if (!p)
			break;
		gc_f = bpf_rb_entry(p, struct fq_flow, fq_node);
		if (gc_f->sk_long == sk_long) {
			f = bpf_refcount_acquire(gc_f);
			break;
		}
		/* ... */
	}
	bpf_spin_unlock(&root->lock);

	if (f) {
		bpf_spin_lock(&q->lock);
		bpf_rbtree_remove(&q->delayed, &f->rate_node);
		bpf_spin_unlock(&q->lock);
	}
}

bpf_rbtree_{left,right} do not need this change but are relaxed together
with bpf_rbtree_remove instead of adding extra verifier logic
to exclude these kfuncs.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3624de1c6925..3b905331ca0e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13229,8 +13229,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			} else {
-				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
-					verbose(env, "%s can only take non-owning bpf_rb_node pointer\n", func_name);
+				if (!type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
+					verbose(env, "%s can only take non-owning or refcounted bpf_rb_node pointer\n", func_name);
 					return -EINVAL;
 				}
 				if (in_rbtree_lock_required_cb(env)) {
-- 
2.47.1


