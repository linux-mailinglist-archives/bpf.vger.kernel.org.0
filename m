Return-Path: <bpf+bounces-67657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA88B4674F
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 01:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD23163EFB
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDA241C89;
	Fri,  5 Sep 2025 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jspLUeqR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE5226CFD
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115976; cv=none; b=VJg0dgV8AklfzX7roypueTV5OMkSNI/YJrHg3RVFgz4IzWfCUEE1cZE25DM48sN/1w3xOPLDWRsFLdyFuZscGhiord7qer/e10luBnolnIlz2Elf5R+tSTPnU0xNK0fJ9Q0B1py1QeIxNYWqIQkuC0pRxS/y67C89Z1R9QXm7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115976; c=relaxed/simple;
	bh=jWv34maFp9Onz9dXbDd9WLzcUQfA/7/Ptzl0B5GHKkI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aGMcpXKnUG0ifpv4gKfm/zyxywg5ZB3HjV8CZ5NV2r8/jGBRzp7Tk1amYb6OX5cu4XVzIIZNz58bdeq8ArcFg7zxPf+OG8D/Xwyk1RG/eDQnnzty6YO6tpmqtnpy1NqUe0wZihpAzg58wLI6DoW+a/KqglsAzJuZq0LDFqtecos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jspLUeqR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24afab6d4a7so51268265ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757115974; x=1757720774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ka3pAMib8mg56UcIRiGYQOnsatMqr/ASQE3iJhG8eFo=;
        b=jspLUeqR6YzMhq6oOGkTObhcIu+AAYqQNNX9jMbCyySkGfwfIyKBbeXqlQ5FPO3mdw
         /AumPWTkxHvXQdRfMToGj0nmkCu0P9Z0htAHRiwo0hTDn1AGwYrXXn793AZgCQQXuaOY
         RI3XYyYFB7XonPKavk73AnLg2NOLjv/JVurSqQCTcDk0XEGTXKjQ0V6mK316JgIGql7j
         TN3fZ82aFcU5SN7VMPb39wTP4Y8sQRpfTnJEh/PiVRyaXcdMUpiibPgSegdybjemEvHi
         s7r1eFkJiDSVogY7jd42cgs6PFQDXqoTHkbM7v2pCnMJ0BJ8muPANLnMal22iYGwXR5X
         0ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757115974; x=1757720774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ka3pAMib8mg56UcIRiGYQOnsatMqr/ASQE3iJhG8eFo=;
        b=dhaFZ3v/e2+WgutMi0BDjwkRLAFG0yOm7qW4HsVKo1Cil+noPVBG28N0yUe6YfSzk9
         A3kuDl7bT0+UfbPg73+WSwa55Q4cjMmz0XiYfyf9kDYkAilf9ZMp04Sm3d71nTCq2QkZ
         6/KAhesh2ecBzpBVtLBwsRg9jacglMcraRNabAV28M+WnNDMX1iO9rcZ4+sdaTxUqrUs
         npYuOy3F5L18KzfVs4ydbjtBU6baXHTswm51srOfh3DjbL5c/Gg4pnST9KuHDcK0aZSG
         yl2QcF5U9RJyT2ATZHkY97G6cMBvXxEsBF8EidQ+k8gpJZpX7J5cp4Qwc9TbiX/5FhxU
         xT5w==
X-Gm-Message-State: AOJu0YwFPNFg50PbRxk94Jx90qZBpR5Lc7lVFtLhsCR8FdsWtJwc8yTC
	Tq5XqZpFcrYCx74Z87ibLa1bXsJwhs7f3yV34S4b9pJd1elNLU+GVNinmepLEYNt4LAGyQVWlvW
	Ct5ZXezplSiqZMg+Z/EKm/9v4ZfeKdW4413dQ3+kizs/9m/w7rase5HE9rv+Sj5n1u08SxWUrPA
	x83aJLN5BPPvuqswR2f63hA+RP5xs/XrTvh+CUvGMa/7s=
X-Google-Smtp-Source: AGHT+IGrorJIHwVe08/3eXVVnnu3ROgHDFhtPU55HCU9Hj6LhTj/S95ofHRY3+PvYuo9S+ud8faNhgZS8ou1Bw==
X-Received: from plrp10.prod.google.com ([2002:a17:902:b08a:b0:243:31a:f8e2])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:138a:b0:24c:9e2d:9a13 with SMTP id d9443c01a7336-25170772b3amr5276615ad.27.1757115974045;
 Fri, 05 Sep 2025 16:46:14 -0700 (PDT)
Date: Fri,  5 Sep 2025 23:45:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905234547.862249-1-yepeilin@google.com>
Subject: [PATCH bpf] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC in __bpf_async_init()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: Peilin Ye <yepeilin@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Currently, calling bpf_map_kmalloc_node() from __bpf_async_init() can
cause various locking issues; see the following stack trace (edited for
style) as one example:

...
 [10.011566]  do_raw_spin_lock.cold
 [10.011570]  try_to_wake_up             (5) double-acquiring the same
 [10.011575]  kick_pool                      rq_lock, causing a hardlockup
 [10.011579]  __queue_work
 [10.011582]  queue_work_on
 [10.011585]  kernfs_notify
 [10.011589]  cgroup_file_notify
 [10.011593]  try_charge_memcg           (4) memcg accounting raises an
 [10.011597]  obj_cgroup_charge_pages        MEMCG_MAX event
 [10.011599]  obj_cgroup_charge_account
 [10.011600]  __memcg_slab_post_alloc_hook
 [10.011603]  __kmalloc_node_noprof
...
 [10.011611]  bpf_map_kmalloc_node
 [10.011612]  __bpf_async_init
 [10.011615]  bpf_timer_init             (3) BPF calls bpf_timer_init()
 [10.011617]  bpf_prog_xxxxxxxxxxxxxxxx_fcg_runnable
 [10.011619]  bpf__sched_ext_ops_runnable
 [10.011620]  enqueue_task_scx           (2) BPF runs with rq_lock held
 [10.011622]  enqueue_task
 [10.011626]  ttwu_do_activate
 [10.011629]  sched_ttwu_pending         (1) grabs rq_lock
...

The above was reproduced on bpf-next (b338cf849ec8) by modifying
./tools/sched_ext/scx_flatcg.bpf.c to call bpf_timer_init() during
ops.runnable(), and hacking [1] the memcg accounting code a bit to make
a bpf_timer_init() call much more likely to raise an MEMCG_MAX event.

We have also run into other similar variants (both internally and on
bpf-next), including double-acquiring cgroup_file_kn_lock, the same
worker_pool::lock, etc.

As suggested by Shakeel, fix this by using __GFP_HIGH instead of
GFP_ATOMIC in __bpf_async_init(), so that if try_charge_memcg() raises
an MEMCG_MAX event, we call __memcg_memory_event() with
@allow_spinning=false and skip calling cgroup_file_notify(), in order to
avoid the locking issues described above.

Depends on mm patch "memcg: skip cgroup_file_notify if spinning is not
allowed".  Tested with vmtest.sh (llvm-18, x86-64):

 $ ./test_progs -a '*timer*' -a '*wq*'
...
 Summary: 7/12 PASSED, 0 SKIPPED, 0 FAILED

[1] Making bpf_timer_init() much more likely to raise an MEMCG_MAX event
(gist-only, for brevity):

kernel/bpf/helpers.c:__bpf_async_init():
 -        cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
 +        cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC | __GFP_HACK,
 +                                  map->numa_node);

mm/memcontrol.c:try_charge_memcg():
          if (!do_memsw_account() ||
 -            page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 -                if (page_counter_try_charge(&memcg->memory, batch, &counter))
 +            page_counter_try_charge_hack(&memcg->memsw, batch, &counter,
 +                                         gfp_mask & __GFP_HACK)) {
 +                if (page_counter_try_charge_hack(&memcg->memory, batch,
 +                                                 &counter,
 +                                                 gfp_mask & __GFP_HACK))
                          goto done_restock;

mm/page_counter.c:page_counter_try_charge():
 -bool page_counter_try_charge(struct page_counter *counter,
 -                             unsigned long nr_pages,
 -                             struct page_counter **fail)
 +bool page_counter_try_charge_hack(struct page_counter *counter,
 +                                  unsigned long nr_pages,
 +                                  struct page_counter **fail, bool hack)
 {
...
 -                if (new > c->max) {
 +                if (hack || new > c->max) {     // goto failed;
                          atomic_long_sub(nr_pages, &c->usage);

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/helpers.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b9b0c5fe33f6..508b13c24778 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1274,8 +1274,14 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		goto out;
 	}
 
-	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	/* Allocate via bpf_map_kmalloc_node() for memcg accounting. Use
+	 * __GFP_HIGH instead of GFP_ATOMIC to avoid calling
+	 * cgroup_file_notify() if an MEMCG_MAX event is raised by
+	 * try_charge_memcg(). This prevents various locking issues, including
+	 * double-acquiring locks that may already be held here (e.g.,
+	 * cgroup_file_kn_lock, rq_lock).
+	 */
+	cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.51.0.355.g5224444f11-goog

