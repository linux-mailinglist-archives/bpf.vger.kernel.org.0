Return-Path: <bpf+bounces-71112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78349BE40CE
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D610058765A
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C813451BE;
	Thu, 16 Oct 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVO/gtE0"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F90343D97
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626742; cv=none; b=TJ8TnaF59LV4w/m7NUFsJy7rcZ+p2nC6wfVxLg95odIPurr9YzwHVmIHDaIVMaxZLmrzoDp9JPyC4QOMQD2x+MZ1ppBwm1sn96LGfE8/ukHQyq8srYYEwL8D6tUsEBHh6Yb+DO/QWjxIukHKpzbVEAAhRp4CXp4e6bvBpE8P5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626742; c=relaxed/simple;
	bh=PjmQAumqVG200dBo41AFGYL3MBYNt+UtWyJdspmHbwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXNwDMz+8dCy/wg7GVXWWC/W46odmTL++tgvS1zzjVY5z/2QEsE8+d4gWQ7a01QR65eTPswfIGtFuEwJ66NdcUekFsvmkP9QwSQfg0dned3xyU5yBZUayTBOF/OUyXokNx0v4Uwg/fO//EMnxxk6BHg5jSk2Fz81BPt5YiiEBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVO/gtE0; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760626738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDg6q4AF09gd/6Pogmiva+sx2W7UnqDx36lrBRWQ0zU=;
	b=LVO/gtE0lB85Sg2LUz3oIaXGWK1z4EMKpOw17P4RqyIo4PuWNoawV0XrLVUczffmS7b7YB
	+iB+FI7EVxf13hlmEUxE5nkzrRSwEa/1SMSJOr6xBSoHRZ+z84HcdLFiTfNFwFBKcP+rTW
	7l3AlGwLNQQ31AchnIpQ7uhO8RIDpaA=
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
Subject: [PATCH bpf 1/3] bpf: Fix possible memleak in [lru_,]percpu_hash map update
Date: Thu, 16 Oct 2025 22:57:59 +0800
Message-ID: <20251016145801.47552-2-leon.hwang@linux.dev>
In-Reply-To: <20251016145801.47552-1-leon.hwang@linux.dev>
References: <20251016145801.47552-1-leon.hwang@linux.dev>
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


