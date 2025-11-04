Return-Path: <bpf+bounces-73445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB5BC3181B
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D03D344C53
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FB732E74D;
	Tue,  4 Nov 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A0vCuAyb"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997A32E6A8
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266467; cv=none; b=VOsEz3zGmtshfgRm6vMA9IjDfFp+N3JDsPeYDLM2LLplJFdsVOkpmZLw7c7qkvxS7BWmgJbiHZcFnhfnA9LYuDlBD39DwqcW8d/nwCXFqN5PnZvL8yJW1aqBzv3ldzeKxjYMFk0RUJgMFWyt8wJZ9kQpn+0EqdoXGBi7qZXMRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266467; c=relaxed/simple;
	bh=YLD/iRTRP+HO4v1RX/uc2DeaukXT/KBzPHOhINWqnvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pO9kFFqXjmpvlL9J6nrfnAReg9P8UukUPx32bm0pyJOaCgyeG7lu7FEs3qShi5jQIDjbwPwgTshH/+kTjRpFJnNBQnaCGYMfBeXJ5miVeWdbSfBzQ1P2RttDYcIaKM5thLGg8QskAnTghUdZ96eaz6LC+ZMEogT/oiioUcdp/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A0vCuAyb; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762266463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wf4o4RfAWjC+W+jZbgaiPoYOH9gNsOAhXwym48ZG3Ec=;
	b=A0vCuAybcfrz5Zm2BCoSp+yFGHTd5Q48VUEdtmRkcgAVmrQESzZgV8maq65Ni9mYZMuZJA
	xpUqGk5OOWJYL4g9c4iPihCLN+QatPyXjNrmqbBZHgnuK7iVJeLqIwg6J54lbngipbkG6E
	Cz9hEaDCw9jH8J2VuKRM+WniYeRmaTo=
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
Subject: [PATCH bpf-next v5 1/2] bpf: Free special fields when update [lru_,]percpu_hash maps
Date: Tue,  4 Nov 2025 22:27:13 +0800
Message-ID: <20251104142714.99878-2-leon.hwang@linux.dev>
In-Reply-To: <20251104142714.99878-1-leon.hwang@linux.dev>
References: <20251104142714.99878-1-leon.hwang@linux.dev>
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
 kernel/bpf/hashtab.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f876f09355f0d..c8a9b27f8663b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -934,15 +934,21 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 			    void *value, bool onallcpus)
 {
+	void *ptr;
+
 	if (!onallcpus) {
 		/* copy true value_size bytes */
-		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
+		ptr = this_cpu_ptr(pptr);
+		copy_map_value(&htab->map, ptr, value);
+		bpf_obj_free_fields(htab->map.record, ptr);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		int off = 0, cpu;
 
 		for_each_possible_cpu(cpu) {
-			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
+			ptr = per_cpu_ptr(pptr, cpu);
+			copy_map_value_long(&htab->map, ptr, value + off);
+			bpf_obj_free_fields(htab->map.record, ptr);
 			off += size;
 		}
 	}
-- 
2.51.1


