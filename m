Return-Path: <bpf+bounces-36350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD51947047
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2024 20:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883E11F2141C
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2024 18:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E771EF01;
	Sun,  4 Aug 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Edejz/yB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B58AD59;
	Sun,  4 Aug 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722797783; cv=none; b=AXP4UIT8nI0b1L5iR4+7+DyVH/YTiyes1nqhNuJQEuOKn8HPcoEzObwMz3t7uYIvNJVybSDp7XIwgdtUBw8r7U3oVKctKCUkYiskxPp1S5urxG5HZJ2FYPgi7PhX3o/Y+ha19P+lrCMhcyEFwmhg8axGER9q6QDVVJpOxHQ3wxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722797783; c=relaxed/simple;
	bh=dgwtvjzxsbaGerEaKttw4CyPjPyHlqJqoWk5sY740hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4cMoqdym2XWAgj5kgKFYW/88HlSownPVYaa7zlL49QPWDgKL9udQ1EMMXd/4V/i7nAljhx0XFPAd7/OKZZXW4jcQRu9t3RM45mkn9jP3C7MlYq6OPwZcD8mu86EBtQD5IMTN20Cv6ZVNwfpgp1s7u75gbgRCRECi476VyQuHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Edejz/yB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso1105485166b.0;
        Sun, 04 Aug 2024 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722797779; x=1723402579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3Jd5P/b/Luqq/fhRwc/udhsX1VSD2BhFY/Sb6tFCP4=;
        b=Edejz/yBBTsmCYPLpA9eLGSLZPfymDL7TxMqorJv+BmpJaxAH1CeGtrFWfrDMrcxGb
         Fr/Y3dOPQwtZ6AvIRtsU9xWwHDHO3+N/MKINg+DEHg8qko4qBqN6Inu817Sz5JDliykM
         SwWRk/IU25R33jaZzEZC+RHTMQa0G3NfqGXw233WJIbg593mIq4X+icpSgVR0QM1mqeH
         rfneCajifvaikqgpQ5DTm+uuVlkzZOHMJBVCMYZq53r8VSgZ9/z9siNH138mOPrQw/Qn
         epSaDL7EMg6lgFZlgGS1zksdHV25I1In0T8zQivLY5IlSaCKiClfx5kqQHpfOZ/F09uh
         cdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722797779; x=1723402579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3Jd5P/b/Luqq/fhRwc/udhsX1VSD2BhFY/Sb6tFCP4=;
        b=Jctl5jSDUZlnDHt9x3BsTMqpYIqWEqfgQrkl1E7rCMiicrJAvV5xZntikLQlDEblio
         wmvWoXxlO4eEZMnP4GE/gMX+xhP8lCARZNM9dbQjS6viyiyIoTmJTcEAewS0jQaFC6l+
         WoTHhJ9nLHPxnV8lE29+JmVxkUdWMZbl+LRHANsptuhnkgv1ItzdXtwNkI/lIxo0zJjV
         w06XbvV6H3UkAl93CfWGu09dBf5xciMBDo0al5Ash2sPuT9cHTedEHO9PwhCxMUNyFc2
         RjnmTtgkKjtA5oP7abWqux6IvC1CCeTw/aeIgULlHAAV5xIIsUxRNmTHiKnps8S7mA7l
         s3UA==
X-Forwarded-Encrypted: i=1; AJvYcCVAHEUa5n9s4OY9K4ZOnTiPxzZwxPc4icq7mU+hUb/c5gziLgGirH7GxLoZwR+2mDQBXhlqQUMYxldJOZ2t2ygc0J09JyGLNWpR7FLQ
X-Gm-Message-State: AOJu0Yxeom7ywtKenUZzGNvflTyRBMWq/0veUoRVJU+3fk2EaKscYsga
	+SlY7cn1WRezETto4LRO9sS57Qv4rvHc5jFUEspHdUWwzNauexcb2hIX6YGlETg=
X-Google-Smtp-Source: AGHT+IEVkPLKDn07qjir4k29ITd2jGtIXSuLH87JGmhWwwlOjp2uX/0HsA5iByU3Bl1fTfk4pwR2BA==
X-Received: by 2002:a17:907:72d1:b0:a7d:2c91:fb1b with SMTP id a640c23a62f3a-a7dc511c22dmr591920866b.68.1722797778597;
        Sun, 04 Aug 2024 11:56:18 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecabb2sm355735166b.214.2024.08.04.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 11:56:18 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] bpf: Fix percpu address space issues
Date: Sun,  4 Aug 2024 20:55:22 +0200
Message-ID: <20240804185604.54770-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In arraymap.c:

Assign return values of bpf_array_map_seq_start() and
bpf_array_map_seq_next() from the non-percpu array.

Correct the declaration of pptr pointer in __bpf_array_map_seq_show()
to void * __percpu * (void __percpu pointer to void pointer) and
cast the value from the generic address space to the __percpu
address space via uintptr_t [1].

In hashtab.c:

Assign the return value from bpf_mem_cache_alloc() to void pointer
and cast the value to void __percpu ** (void pointer to percpu void
pointer) before dereferencing.

In memalloc.c:

Explicitly declare __percpu variables.

Cast obj to void __percpu **.

In helpers.c:

Cast ptr in BPF_CALL_1 and BPF_CALL_2 from generic address space
to __percpu address space via const uintptr_t [1].

Found by GCC's named address space checks.

There were no changes in the resulting object files.

[1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/arraymap.c |  8 ++++----
 kernel/bpf/hashtab.c  |  8 ++++----
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/memalloc.c | 12 ++++++------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 188e3c2effb2..544ca433275e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -600,7 +600,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 	array = container_of(map, struct bpf_array, map);
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
-	       return array->pptrs[index];
+	       return array->ptrs[index];
 	return array_map_elem_ptr(array, index);
 }
 
@@ -619,7 +619,7 @@ static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	array = container_of(map, struct bpf_array, map);
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
-	       return array->pptrs[index];
+	       return array->ptrs[index];
 	return array_map_elem_ptr(array, index);
 }
 
@@ -632,7 +632,7 @@ static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int off = 0, cpu = 0;
-	void __percpu **pptr;
+	void * __percpu *pptr;
 	u32 size;
 
 	meta.seq = seq;
@@ -648,7 +648,7 @@ static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
 		if (!info->percpu_value_buf) {
 			ctx.value = v;
 		} else {
-			pptr = v;
+			pptr = (void __percpu *)(uintptr_t)v;
 			size = array->elem_size;
 			for_each_possible_cpu(cpu) {
 				copy_map_value_long(map, info->percpu_value_buf + off,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index be1f64c20125..a49212bbda09 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1049,14 +1049,14 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = htab_elem_get_ptr(l_new, key_size);
 		} else {
 			/* alloc_percpu zero-fills */
-			pptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
-			if (!pptr) {
+			void *ptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
+			if (!ptr) {
 				bpf_mem_cache_free(&htab->ma, l_new);
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			l_new->ptr_to_pptr = pptr;
-			pptr = *(void **)pptr;
+			l_new->ptr_to_pptr = ptr;
+			pptr = *(void __percpu **)ptr;
 		}
 
 		pcpu_init_value(htab, pptr, value, onallcpus);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..dd7529153146 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -715,7 +715,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 	if (cpu >= nr_cpu_ids)
 		return (unsigned long)NULL;
 
-	return (unsigned long)per_cpu_ptr((const void __percpu *)ptr, cpu);
+	return (unsigned long)per_cpu_ptr((const void __percpu *)(const uintptr_t)ptr, cpu);
 }
 
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
@@ -728,7 +728,7 @@ const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 
 BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
 {
-	return (unsigned long)this_cpu_ptr((const void __percpu *)percpu_ptr);
+	return (unsigned long)this_cpu_ptr((const void __percpu *)(const uintptr_t)percpu_ptr);
 }
 
 const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index dec892ded031..b3858a76e0b3 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -138,8 +138,8 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 {
 	if (c->percpu_size) {
-		void **obj = kmalloc_node(c->percpu_size, flags, node);
-		void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
+		void __percpu **obj = kmalloc_node(c->percpu_size, flags, node);
+		void __percpu *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
 
 		if (!obj || !pptr) {
 			free_percpu(pptr);
@@ -253,7 +253,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 static void free_one(void *obj, bool percpu)
 {
 	if (percpu) {
-		free_percpu(((void **)obj)[1]);
+		free_percpu(((void __percpu **)obj)[1]);
 		kfree(obj);
 		return;
 	}
@@ -509,8 +509,8 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  */
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 {
-	struct bpf_mem_caches *cc, __percpu *pcc;
-	struct bpf_mem_cache *c, __percpu *pc;
+	struct bpf_mem_caches *cc; struct bpf_mem_caches __percpu *pcc;
+	struct bpf_mem_cache *c; struct bpf_mem_cache __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
 	int cpu, i, unit_size, percpu_size = 0;
 
@@ -591,7 +591,7 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 {
-	struct bpf_mem_caches *cc, __percpu *pcc;
+	struct bpf_mem_caches *cc; struct bpf_mem_caches __percpu *pcc;
 	int cpu, i, unit_size, percpu_size;
 	struct obj_cgroup *objcg;
 	struct bpf_mem_cache *c;
-- 
2.42.0


