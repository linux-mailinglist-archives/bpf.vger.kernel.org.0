Return-Path: <bpf+bounces-71425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53FBF2802
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B9A189CC15
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC032F747;
	Mon, 20 Oct 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UyUuTLE/"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933032ED51;
	Mon, 20 Oct 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978799; cv=none; b=pSZH/4JKsBhZiVaamrORtDU2Jw3wIZoNPOm9K3GxXCG2BZAN8eP0H+dGEOTRg/EeiKc3aGwMs01vnmxuFgLjAX4giWQKeoJoy4Ox3LoA7uU8tKypllxPjtexzfwlr6Rgo9jJpQONH/NZxSP5RGKTPJ68jeHFNq3tpceDdYitdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978799; c=relaxed/simple;
	bh=PjmQAumqVG200dBo41AFGYL3MBYNt+UtWyJdspmHbwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPUIyHYCRa5OnRGRbsKQoq/X6EFVpom58OTh2q7WwhUD0/bXisPfTojD6mkyD29/gcUBtAfpjzoaixSJVT2hp6FaiRqEk0C7Ni4TBxGwT9/kh1bWJgOZjqMDHpe2hJ8VCw6yeKDW3nuFzBCloQtVOgK91sHrKPWoX9nxhM2/ClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UyUuTLE/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760978795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDg6q4AF09gd/6Pogmiva+sx2W7UnqDx36lrBRWQ0zU=;
	b=UyUuTLE/S/1ltg7AjGyu3H9tATmwdenQiJPHzf5FY/1+ESu+MW9um2ETivtu66tmt8BycW
	8l0c3Jm/M1E3m8bGLfTo6NEnyaG5BsaHLtHMs6fflhzNGBYU3ignnsHGOUQv5+U44afrxI
	+yJG3HGISbzXAa08hnsOiDibva01dJs=
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
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v2 1/4] bpf: Fix possible memleak in [lru_,]percpu_hash map update
Date: Tue, 21 Oct 2025 00:46:05 +0800
Message-ID: <20251020164608.20536-2-leon.hwang@linux.dev>
In-Reply-To: <20251020164608.20536-1-leon.hwang@linux.dev>
References: <20251020164608.20536-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As [lru_,]percpu_hash maps support BPF_KPTR_{REF,PERCPU}, missing
calls to 'bpf_obj_free_fields()' in 'pcpu_copy_value()' can leak memory
referenced by BPF_KPTR_{REF,PERCPU} fields.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value[,_long]()' in 'pcpu_copy_value()'.

Fixes: 65334e64a493 ("bpf: Support kptrs in percpu hashmap and percpu LRU hashmap")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c2fcd0cd51e51..26308adc9ccb3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -950,12 +950,14 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
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
2.51.0


