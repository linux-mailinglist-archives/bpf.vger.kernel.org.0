Return-Path: <bpf+bounces-73035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D71C20E9B
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5888461CC9
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9E363B89;
	Thu, 30 Oct 2025 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDchMR8v"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B70363377;
	Thu, 30 Oct 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837939; cv=none; b=QHCaVXCmyuFEdsyFGwhefXzZhXIlS7IcfZpNgSb88nQfc12T5RkcEv75gydaJod8pWFkln4bX6AcAkeePqlEd5v4f1wzw/N9ceuWagnzqo1BFBlOlq87K1DX6woSwXyALkEtHWorPQulDwyPqbbXk9p5cf6XTxe+rerjHRDYT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837939; c=relaxed/simple;
	bh=Yzwzxilhtx1Dgk+h+/t4mnPaUIxRfXCRt2Cs2zg0eGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB4ySoVgNo5rEYUmBnR0q6wCsjyp5Jy6xE3dZmWaaGk7xvRL8eg8HMYgqTRZGXnp0uFTWcoQTGWrH1yUowRjsXsJ2j7hIYpxIi+Hz1rW6CP4IIqdfE1mj/aIbHwKOOSd2H+kM+KPuqbI39PZA2FZIv5lAselFgitR5BzVNUcEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDchMR8v; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761837936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMIKbvL/Yl5vdyppYR1GBXYBoknYHgCa29cF1TMUEDc=;
	b=cDchMR8vhlYumlAnZchXQlZPW+Rq/xn81iLfUNjpl8TLj4mm0Q8AdhFmNqGFdzI5Tb76Rb
	xhSp5Ld/iEE67NTsDpUq5XUqDtov4JPfBu4neNvV6G/khvrEyP0QL/BKg5jo3hMOnwhleh
	DaeSHwXqTln8/64/XCVMgDwI4MPTge0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 1/4] bpf: Free special fields when update [lru_,]percpu_hash maps
Date: Thu, 30 Oct 2025 23:24:48 +0800
Message-ID: <20251030152451.62778-2-leon.hwang@linux.dev>
In-Reply-To: <20251030152451.62778-1-leon.hwang@linux.dev>
References: <20251030152451.62778-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As [lru_,]percpu_hash maps support BPF_KPTR_{REF,PERCPU}, missing
calls to 'bpf_obj_free_fields()' in 'pcpu_copy_value()' could cause the
memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
map gets freed.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value[,_long]()' in 'pcpu_copy_value()'.

Fixes: 65334e64a493 ("bpf: Support kptrs in percpu hashmap and percpu LRU hashmap")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f876f09355f0d..3861f28a6be81 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -937,12 +937,14 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 	if (!onallcpus) {
 		/* copy true value_size bytes */
 		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
+		bpf_obj_free_fields(htab->map.record, this_cpu_ptr(pptr));
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		int off = 0, cpu;
 
 		for_each_possible_cpu(cpu) {
 			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
+			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
 			off += size;
 		}
 	}
-- 
2.51.1


