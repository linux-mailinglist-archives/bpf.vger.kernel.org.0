Return-Path: <bpf+bounces-70792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5FABD02F0
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F893BBC7E
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9101B4231;
	Sun, 12 Oct 2025 13:56:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762C1A314E;
	Sun, 12 Oct 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277416; cv=none; b=PgrTqeUh3vfu60ZYs15lEZn/ShHQf/TOgA3z7FAzVxOtlc9++xLiLHBJPoyjOOXfneAhFTrcJNdW1dp8/cwLluWsJrg9y9Gdwa+c8TSxVRKvxSwi1CCLJDxuDfZ4jZEzU7WFQAA7pUOC1F9+0Yffx6oTxu4KibHTiA6hpweCw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277416; c=relaxed/simple;
	bh=dfHmpJ3HxLV4gF+y5WmcffGIAAXZtrfoTvfesEZafuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhorDEr9dtwPDED9/IG/3I+eZ0a4aMExoh8lbg+ac4JrjPVj/4RLHjHtQojAaWWKgvNQhS5iJ10wSEi1KoUxFMKTIOZwcJH0T7Q3d3MXxIc/SEssLxmHLNOS/JHJStetynhfztBOgu9CKMEr5tPtjQ8e7kCKR19PrKPXXdUPlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [89.100.17.9])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 5E5814018F;
	Sun, 12 Oct 2025 13:56:50 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 89.100.17.9) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud lecomte <contact@arnaud-lcm.com>
To: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	contact@arnaud-lcm.com
Subject: test
Date: Sun, 12 Oct 2025 14:56:49 +0100
Message-ID: <20251012135649.59492-1-contact@arnaud-lcm.com>
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
X-PPP-Message-ID: <176027741085.28150.16747354518360343128@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..c0ee51db8eed 100644
--- a/kernel/bpf/stackmap.c

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

@@ -371,15 +391,11 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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

@@ -390,6 +406,10 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
                flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
                ret = __bpf_get_stackid(map, trace, flags);
        }
+
+       /* restore nr */
+       trace->nr = nr;
+
        return ret;
 }

@@ -406,7 +426,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
                            struct perf_callchain_entry *trace_in,
                            void *buf, u32 size, u64 flags, bool may_fault)
 {
-       u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+       u32 trace_nr, copy_len, elem_size, max_depth;
        bool user_build_id = flags & BPF_F_USER_BUILD_ID;
        bool crosstask = task && task != current;
        u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -438,21 +458,20 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
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
@@ -461,7 +480,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
        }

        trace_nr = trace->nr - skip;
-       trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
        copy_len = trace_nr * elem_size;

        ips = trace->ip + skip;
--
2.47.3

