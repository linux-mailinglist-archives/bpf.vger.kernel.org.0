Return-Path: <bpf+bounces-64757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFDB16976
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6754620AA9
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00223C50B;
	Wed, 30 Jul 2025 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Wxjh9u6S"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234323A578
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919265; cv=none; b=pZRaU0aGRddB3Mf5hsIPVzsGFplgl0L9DUdJqAESYCI268lY4aJARnfjUGo9TRs2qU8ZeT6X1mJrqwMFRAtoCtMk8zpPPd3DB1Rj/Vbp+KuNy5sU74Ry+8hz/JhF2lq+bx+26NulAzYlvdQAD25QH18g3U0b40eA5JBaM9L8KVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919265; c=relaxed/simple;
	bh=dX1J392rBaD9wk4mGmTjQjYSCvON+mR1AHRmhmllTb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGFiYWJKO0s+CVF3yZ1DhPV/5IVS1KTZL0sjEfICvZ4cXm0XSzmbQHhq5s4G3AKoGl9/qKLA+Z6H4h7Ab2N85fkaP9tN6InCgHgYNbKXpbGrUrrj0siRpzjWEvBw24koKOwek1VQV7WwvxgGfIH2pAVpu00UgcAuZ0n20VU8iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Wxjh9u6S; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8t+R8LktKEX6BvoSsi8lZ/rN54wExMyuQ7NwKJlKUqw=; b=Wxjh9u6SKvEIe2+Qqj1GzQW8qK
	36ZOrAxVtuhR6xcXdFEXnwSDiDPpIuQ9mlomffko3B3lAqfcKFyKXxNCvCnml0Ei0iGZxiSi1RIRz
	WlrfvqXZnE6GcXpv4shOH7vQ/D2WjxkhLhcU0VMoAc6nEKu7BUV4Vk8PYpwLJMuV5Y4KXz+UxRw8R
	1OZ2D5A1bKopzkJ8Y9OhAVYadGDoJwu0LMBAXrZ+AjqRovI+aJA7+XznxoX0P/culM66xY5tQpfIK
	IXRuCQxhx57IWBHeofhS0yMqa7DrbdcKMROlyiZUNJ80e9Hd1ITf0dRug4Zsx8HQh1UaxkIT0YRs9
	N96oP6ZQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uhGWG-0008Qc-0x;
	Thu, 31 Jul 2025 01:47:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	Lonial Con <kongln9170@gmail.com>
Subject: [PATCH bpf v2 4/4] bpf: Fix oob access in cgroup local storage
Date: Thu, 31 Jul 2025 01:47:33 +0200
Message-ID: <20250730234733.530041-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730234733.530041-1-daniel@iogearbox.net>
References: <20250730234733.530041-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27717/Wed Jul 30 18:34:37 2025)

Lonial reported that an out-of-bounds access in cgroup local storage
can be crafted via tail calls. Given two programs each utilizing a
cgroup local storage with a different value size, and one program
doing a tail call into the other. The verifier will validate each of
the indivial programs just fine. However, in the runtime context
the bpf_cg_run_ctx holds an bpf_prog_array_item which contains the
BPF program as well as any cgroup local storage flavor the program
uses. Helpers such as bpf_get_local_storage() pick this up from the
runtime context:

  ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
  storage = ctx->prog_item->cgroup_storage[stype];

  if (stype == BPF_CGROUP_STORAGE_SHARED)
    ptr = &READ_ONCE(storage->buf)->data[0];
  else
    ptr = this_cpu_ptr(storage->percpu_buf);

For the second program which was called from the originally attached
one, this means bpf_get_local_storage() will pick up the former
program's map, not its own. With mismatching sizes, this can result
in an unintended out-of-bounds access.

To fix this issue, we need to extend bpf_map_owner with an array of
storage_cookie[] to match on i) the exact maps from the original
program if the second program was using bpf_get_local_storage(), or
ii) allow the tail call combination if the second program was not
using any of the cgroup local storage maps.

Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 02aa41e301a5..cc700925b802 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -283,6 +283,7 @@ struct bpf_map_owner {
 	enum bpf_prog_type type;
 	bool jited;
 	bool xdp_has_frags;
+	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e5b3a67e87f..5d1650af899d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2378,7 +2378,9 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	struct bpf_prog_aux *aux = fp->aux;
+	enum bpf_cgroup_storage_type i;
 	bool ret = false;
+	u64 cookie;
 
 	if (fp->kprobe_override)
 		return ret;
@@ -2393,11 +2395,24 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->jited = fp->jited;
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
 		map->owner->attach_func_proto = aux->attach_func_proto;
+		for_each_cgroup_storage_type(i) {
+			map->owner->storage_cookie[i] =
+				aux->cgroup_storage[i] ?
+				aux->cgroup_storage[i]->cookie : 0;
+		}
 		ret = true;
 	} else {
 		ret = map->owner->type  == prog_type &&
 		      map->owner->jited == fp->jited &&
 		      map->owner->xdp_has_frags == aux->xdp_has_frags;
+		for_each_cgroup_storage_type(i) {
+			if (!ret)
+				break;
+			cookie = aux->cgroup_storage[i] ?
+				 aux->cgroup_storage[i]->cookie : 0;
+			ret = map->owner->storage_cookie[i] == cookie ||
+			      !cookie;
+		}
 		if (ret &&
 		    map->owner->attach_func_proto != aux->attach_func_proto) {
 			switch (prog_type) {
-- 
2.43.0


