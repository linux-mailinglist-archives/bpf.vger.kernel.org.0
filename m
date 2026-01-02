Return-Path: <bpf+bounces-77677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C2CEECFA
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AED23016720
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDC23AB81;
	Fri,  2 Jan 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EM8bLGf5"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CD1A00F0;
	Fri,  2 Jan 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366113; cv=none; b=dvTnDgmLP61JQHD6UGE3Ub4+aTe8QDPpLlxZct8wgNrbGzHGe5qKf1s62jmuBu5kpiaiLsytJsinB9Se21TeiiL7oPiD+ci8Ya/a9BSpcdKnrGr/vD/J3ojxHtGl5IjYiuebuxl5YXXdhEe/jRFrZkkmOXtORrZQnTIQxi+abE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366113; c=relaxed/simple;
	bh=Ijwkz7QzHZs+f5e9/V+7fXI6NvObA0hQXuFbGSjIzJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtLzSnQFXuI1Liv7XlxHp3wfCr9DgLy0co1bvaSCc8g2FksmATUmmHVLOeM/hAzzb0AY6M2udEBO9tIVFHWSNDk7w2pnvPNzu0cPQnztc3cYH019c8O9WYLD6SIIOZxkoIYlfbNOP8yFXVeCKoC6i+mZYKiRBcLOqQ/G7qarqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EM8bLGf5; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767366108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oQ3SeDCJ6nND2F1EMtNHZ6xlfaLC5tyLUl7Cs/5SH4=;
	b=EM8bLGf5gqL+cBIBPphk6iPPRVabq3f3nlPeYC01WIiT0Dhp2x5DkL28sodqjxwetFCMqm
	2AeAAAi9gjt0Psmxc/crbGHUF4P20CQ0I+Xx/cpQgpJEUB0WK133rH5QuCDnd8P3LU6XZk
	2iFBJh1F7mpTrJ1WG3lwWOgNrvjcrv0=
From: Leon Hwang <leon.hwang@linux.dev>
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
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 1/4] bpf: tailcall: Introduce bpf_arch_tail_call_prologue_offset
Date: Fri,  2 Jan 2026 23:00:29 +0800
Message-ID: <20260102150032.53106-2-leon.hwang@linux.dev>
In-Reply-To: <20260102150032.53106-1-leon.hwang@linux.dev>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_arch_tail_call_prologue_offset() to allow architectures
to specify the offset from bpf_func to the actual program entry point
for tail calls. This offset accounts for prologue instructions that
should be skipped (e.g., fentry NOPs, TCC initialization).

When an architecture provides a non-zero prologue offset, prog arrays
allocate additional space to cache precomputed tail call targets:
  array->ptrs[max_entries + index] = prog->bpf_func + prologue_offset

This cached target is updated atomically via xchg() when programs are
added or removed from the prog array, eliminating the need to compute
the target address at runtime during tail calls.

The function is exported for use by the test_bpf module.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/arraymap.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e7d72dfbcd4..acd85c239af9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3792,6 +3792,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old);
+int bpf_arch_tail_call_prologue_offset(void);
 
 void *bpf_arch_text_copy(void *dst, void *src, size_t len);
 int bpf_arch_text_invalidate(void *dst, size_t len);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1eeb31c5b317..beedd1281c22 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -127,6 +127,9 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 			array_size += (u64) max_entries * elem_size;
 		}
 	}
+	if (attr->map_type == BPF_MAP_TYPE_PROG_ARRAY && bpf_arch_tail_call_prologue_offset())
+		/* Store tailcall targets */
+		array_size += (u64) max_entries * sizeof(void *);
 
 	/* allocate all map elements and zero-initialize them */
 	if (attr->map_flags & BPF_F_MMAPABLE) {
@@ -1087,16 +1090,38 @@ void __weak bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 	WARN_ON_ONCE(1);
 }
 
+int __weak bpf_arch_tail_call_prologue_offset(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bpf_arch_tail_call_prologue_offset);
+
+static void bpf_tail_call_target_update(struct bpf_array *array, u32 key, struct bpf_prog *new)
+{
+	int offset = bpf_arch_tail_call_prologue_offset();
+	void *target;
+
+	if (!offset)
+		return;
+
+	target = new ? (void *) new->bpf_func + offset : 0;
+	xchg(array->ptrs + array->map.max_entries + key, target);
+}
+
 static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 				    struct bpf_prog *old,
 				    struct bpf_prog *new)
 {
 	struct prog_poke_elem *elem;
 	struct bpf_array_aux *aux;
+	struct bpf_array *array;
 
-	aux = container_of(map, struct bpf_array, map)->aux;
+	array = container_of(map, struct bpf_array, map);
+	aux = array->aux;
 	WARN_ON_ONCE(!mutex_is_locked(&aux->poke_mutex));
 
+	bpf_tail_call_target_update(array, key, new);
+
 	list_for_each_entry(elem, &aux->poke_progs, list) {
 		struct bpf_jit_poke_descriptor *poke;
 		int i;
-- 
2.52.0


