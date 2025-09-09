Return-Path: <bpf+bounces-67854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B830FB4A8E6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92643BC843
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F96F2D0C91;
	Tue,  9 Sep 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUXt1rvE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDA28C87C
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411570; cv=none; b=DwVROQ3YVOOa0/GtMiP1mN+nb/18YywuemZ6XZfiI6xs9X9h7W5/c7ZadqGNtKhqMYWgmKAkWcwrqHOyTHpKT9owSRSWZzKdIrhhRjzTZECcHQr2Wej/NKNdzDpg2wBnjs7wHs8DhpMDAHgjoC2ToPA2Idrd786DFQcDRAYAHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411570; c=relaxed/simple;
	bh=DuDv3ua4IwKyYMWhr+S8CTNVoVIcjA8BB/4W4Mu6E1g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UBQdolEBc0tA6H0TBciFucw7RJQ/atS9t4FhdKVuJp9iFqwS4ckBtChk/KPUDnTDVi2NNDBm9dhBJW8SKZRcXR+FSkIqu5grNVf+QILjeaQsXV+7OS45+aBo9qaXEpskvi6YT0wO88vNFwkI/oNTNRA+4AukQDWTz3RL32q6v50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RUXt1rvE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7724877cd7cso6216438b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757411567; x=1758016367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOFVmhbI856obbOouijqOO2ps+J/JpM5ycRu9RASoGg=;
        b=RUXt1rvEoZi+wbOs8CNxEMwi2II4gSE5HVQeyGy1iyrtCQ0GbsNUlfPmutLAAKOj8I
         Y9dxjoB/vcyk2P8l/bMoLoKPjVsDnHnFBVa/joUBLR0jAB3S1cleajY3YLDpgDj5coQy
         Cz/r5T18ei7YyloIYKkCNnxTTkej4u0ZtnXbQGi9yh1B1ZHMirHsYacGoAwqTwA1tecC
         0f7pghkaxuRQ09xdKD6DVrh+GOBnD8OR2782uFCJMVJqhACx243T4U2tT6MinmuCBqpO
         sQtqfqMY6P3Jhv3LVbONnFH7lMM6BqnewRKPO8+xzh4uu7/6PK5wMEvYsYSpKm4DPlvc
         h0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411567; x=1758016367;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOFVmhbI856obbOouijqOO2ps+J/JpM5ycRu9RASoGg=;
        b=uxjXL7OWzv3DIrZi+HgGXOCPa4T6K4TQv2muPF3n8o9xU0AzbofgRfr/pIK5BVBb6M
         /MOC5DhJ0PD1bOQ4vYpzi+HCPev6XG0PN3hM5P3y47IeiZKP1pMsK7qYCiA3EOHG+xlY
         FgISh3Wxz7fbTNZOvRvw0LY6llHG67ucpoEIvWzLdelP1w9SiLFwIh73kKNpoSq+tBMz
         906V6ZcbaQ8UgYkOSEp+LiucTDLS1hLVU+4evNUOG1XN2FjyLrtBKITO+9ZXWzG1PAhi
         uICKkL1Ul+IPZ5eJKyFbnNNHIBHj5vYUH4XFZPC1XFcs4veb0KZVHpqcUGmGtRR4m+6T
         AlCg==
X-Gm-Message-State: AOJu0YyU28ilKNylelpqGltOZ7AhY9mF2vTWlZJj4DFdmpy1lMEJGVEw
	xwh4RXkeSTquDCQCAN5AR12cijL4+JBUlVdChDdS/n0CUWYwZYj/Zx3G7RJZYqe8z5j2dx5cxzc
	cJACm6WOInx68rycpivtjbMjyHmE9OzRP4rJLzen6Yi7vIJKELMjmPYK6uAF5lGv4ixWk8PS5Ay
	zRjET12YllfYwwvP7i9g0dcv/rxXG7tzXr//eH6fw1I0U=
X-Google-Smtp-Source: AGHT+IFqmQ+9VVjPtSUUrkCUHF3CruI5aNTXXYKoJuAYl4F0Pt7URhDMSiYRtDdjo9N8yw+OspG5qKJ1hqcjvg==
X-Received: from pfwy4.prod.google.com ([2002:a05:6a00:1c84:b0:772:630e:8fd4])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:983:b0:772:46b5:cc90 with SMTP id d2e1a72fcca58-7742de71235mr15612483b3a.32.1757411567046;
 Tue, 09 Sep 2025 02:52:47 -0700 (PDT)
Date: Tue,  9 Sep 2025 09:52:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909095222.2121438-1-yepeilin@google.com>
Subject: [PATCH bpf v2] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC in __bpf_async_init()
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
	Barret Rhoden <brho@google.com>, linux-mm@kvack.org, Leon Hwang <leon.hwang@linux.dev>
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
GFP_ATOMIC in __bpf_async_init(), so that e.g. if try_charge_memcg()
raises an MEMCG_MAX event, we call __memcg_memory_event() with
@allow_spinning=false and avoid calling cgroup_file_notify() there.

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
v1: https://lore.kernel.org/bpf/20250905234547.862249-1-yepeilin@google.com/
change since v1:
 - simplify comment, and mention kmalloc_nolock() (Shakeel)

 kernel/bpf/helpers.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b9b0c5fe33f6..8af62cb243d9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1274,8 +1274,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		goto out;
 	}
 
-	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	/* Allocate via bpf_map_kmalloc_node() for memcg accounting. Until
+	 * kmalloc_nolock() is available, avoid locking issues by using
+	 * __GFP_HIGH (GFP_ATOMIC & ~__GFP_RECLAIM).
+	 */
+	cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.51.0.384.g4c02a37b29-goog


