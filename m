Return-Path: <bpf+bounces-70790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0EBD0289
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D93B5BD5
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AB274B5A;
	Sun, 12 Oct 2025 13:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7C1D435F;
	Sun, 12 Oct 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760274265; cv=none; b=rdIQg921+ghXkfkp0avWAYd6DPgK2C+NznoIGT7U1zbr727dZoai5rwxD/FTMocKa+GTAdmGjqufY/7MC8sN+W8N/+H4xbZTpPxIdhn49hUcrYtGGDd3fWEsXHOE6Oaw9iJpPNTAatd0eY7wRp2O3YCq2ZcXdthJhM1yr7Yr0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760274265; c=relaxed/simple;
	bh=7K0CSndsKi9wrce/Dppdiz0oKjEKooFoUI1e8ENfAZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6XwiQTLyeDhKEdsZSL9HR/4VQiL1DsGRFj34NOqBdSAkX9aWAFWR4FMA3NsPvRJEM2jW6jRe3Qgkh52pTF7EQ1cCYHIli68B56X7Y43vloCRMMRh998eDa3qVBDIS3laCbMN0pn58DtrIx3yOZmcm7pczPLy0AbHoCE/nnO1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [89.100.17.9])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id E374442344;
	Sun, 12 Oct 2025 13:04:19 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 89.100.17.9) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud lecomte <contact@arnaud-lcm.com>
To: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Syz Test
Date: Sun, 12 Oct 2025 14:04:18 +0100
Message-ID: <20251012130418.49730-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <688809c1.a00a0220.b12ec.00b7.GAE@google.com>
References: <688809c1.a00a0220.b12ec.00b7.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176027426038.31666.1128274319158937673@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..c0ee51db8eed 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *map)
                sizeof(struct bpf_stack_build_id) : sizeof(u64);
 }

+/**
+ * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
+ * @size:  Size of the buffer/map value in bytes
+ * @elem_size:  Size of each stack trace element
+ * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
+ *
+ * Return: Maximum number of stack trace entries that can be safely stored
+ */
+static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
+{
+       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+       u32 max_depth;
+       u32 curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
+
+       max_depth = size / elem_size;
+       max_depth += skip;
+       if (max_depth > curr_sysctl_max_stack)
+               return curr_sysctl_max_stack;
+
+       return max_depth;
+}
+
 static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
 {
        u64 elem_size = sizeof(struct stack_map_bucket) +
@@ -251,8 +273,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 {
        struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
        struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
+       u32 hash, id, trace_nr, trace_len, i, max_depth;
        u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-       u32 hash, id, trace_nr, trace_len, i;
        bool user = flags & BPF_F_USER_STACK;
        u64 *ips;
        bool hash_matches;
@@ -261,7 +283,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
                /* skipping more than usable stack trace */
                return -EFAULT;

-       trace_nr = trace->nr - skip;
+       max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
+       trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
        trace_len = trace_nr * sizeof(u64);
        ips = trace->ip + skip;
        hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
@@ -300,20 +323,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
           u64, flags)
 {
-       u32 max_depth = map->value_size / stack_map_data_size(map);
-       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+       u32 elem_size = stack_map_data_size(map);
        bool user = flags & BPF_F_USER_STACK;
        struct perf_callchain_entry *trace;
        bool kernel = !user;
+       u32 max_depth;

        if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
                               BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
                return -EINVAL;

-       max_depth += skip;
-       if (max_depth > sysctl_perf_event_max_stack)
-               max_depth = sysctl_perf_event_max_stack;
-
+       max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
        trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
                                   false, false);

@@ -390,15 +410,11 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
                return -EFAULT;

        nr_kernel = count_kernel_ip(trace);
+       __u64 nr = trace->nr; /* save original */

        if (kernel) {
-               __u64 nr = trace->nr;
-
                trace->nr = nr_kernel;
                ret = __bpf_get_stackid(map, trace, flags);
-
-               /* restore nr */
-               trace->nr = nr;
        } else { /* user */
                u64 skip = flags & BPF_F_SKIP_FIELD_MASK;

@@ -409,6 +425,10 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
                flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
                ret = __bpf_get_stackid(map, trace, flags);
        }
+
+       /* restore nr */
+       trace->nr = nr;
+
        return ret;
 }

@@ -426,7 +446,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
                            struct perf_callchain_entry *trace_in,
                            void *buf, u32 size, u64 flags, bool may_fault)
 {
-       u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+       u32 trace_nr, copy_len, elem_size, max_depth;
        bool user_build_id = flags & BPF_F_USER_BUILD_ID;
        bool crosstask = task && task != current;
        u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -458,21 +478,20 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
                goto clear;
        }

-       num_elem = size / elem_size;
-       max_depth = num_elem + skip;
-       if (sysctl_perf_event_max_stack < max_depth)
-               max_depth = sysctl_perf_event_max_stack;
+       max_depth = stack_map_calculate_max_depth(size, elem_size, flags);

        if (may_fault)
                rcu_read_lock(); /* need RCU for perf's callchain below */

-       if (trace_in)
+       if (trace_in) {
                trace = trace_in;
-       else if (kernel && task)
+               trace->nr = min_t(u32, trace->nr, max_depth);
+       } else if (kernel && task) {
                trace = get_callchain_entry_for_task(task, max_depth);
-       else
+       } else {
                trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
                                           crosstask, false);
+       }

        if (unlikely(!trace) || trace->nr < skip) {
                if (may_fault)
@@ -481,7 +500,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
        }

        trace_nr = trace->nr - skip;
-       trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
        copy_len = trace_nr * elem_size;

        ips = trace->ip + skip;
--
2.47.3

