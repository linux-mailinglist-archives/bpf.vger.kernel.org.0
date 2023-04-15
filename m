Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AAA6E308E
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDOKcj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOKci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 06:32:38 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E44ED4;
        Sat, 15 Apr 2023 03:32:37 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id dd8so8297927qvb.13;
        Sat, 15 Apr 2023 03:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681554756; x=1684146756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pU8mPmYfUx0WopDIG+8PFI7Uu50MX0UWIDGyAkdkoNg=;
        b=KVxvxIhgD5JDNJULk+z4fhhw/ZmzC3ScRjBBzk5pvVX0iJfHEKppmmtheLp/pab3ah
         h2pWNZYs0YenyCBZQN1v9bEZ3VbqS0qjlDy2sopcKTSUEOEeJB2Ci61Do3bgncFc6IN3
         DOKs3w74rtkEoKRoGcP7cLmPEte5t5f/64HKpRBic85eRbe2NtT3mnFTzViwW8GQ+WSD
         6ZnBKz5E3NTXL+j1TsKGSJqq7BQCm6QLI/8MYC3gsMWZWjV1/STmSJ7+oIic4s4F4LXr
         kvrLa9twh0XSIZe13ugVJQ1lR0GBSk3+bHQrpCZSwUyqgUVBWA4ZvySX0GkEfvcK6sAn
         rF5w==
X-Gm-Message-State: AAQBX9dX7dq+GJw6EI2vGYPK5ER9nle82fDhOh62hd+GYaXP+hIa0wWQ
        KdJVKlHTyn8er2tVp7c5pG0YRp3FIgsn34vGt4k=
X-Google-Smtp-Source: AKy350YMEjHkpgwgpCWPHJqy2Qs3KSrruj4adHpIdfKVn0Q9TsGCzlA+qxQt+Y77YetJqrBR4UNhpA==
X-Received: by 2002:ad4:4ea5:0:b0:5ef:4729:b50c with SMTP id ed5-20020ad44ea5000000b005ef4729b50cmr9283699qvb.38.1681554755986;
        Sat, 15 Apr 2023 03:32:35 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id p10-20020ac8460a000000b003e37d646221sm1825539qtn.96.2023.04.15.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:32:35 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next 0/3] Remove KF_KPTR_GET kfunc flag
Date:   Sat, 15 Apr 2023 05:32:28 -0500
Message-Id: <20230415103231.236063-1-void@manifault.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We've managed to improve the UX for kptrs significantly over the last 9
months. All of the existing use cases which previously had KF_KPTR_GET
kfuncs (struct bpf_cpumask *, struct task_struct *, and struct cgroup *)
have all been updated to be synchronized using RCU. In other words,
their KF_KPTR_GET kfuncs have been removed in favor of KF_RU |
KF_ACQUIRE kfuncs, with the pointers themselves also being readable from
maps in an RCU read region thanks to the types being RCU safe.

While KF_KPTR_GET was a logical starting point for kptrs, it's become
clear that they're not the correct abstraction. KF_KPTR_GET is a flag
that essentially does nothing other than enforcing that the argument to
a function is a pointer to a referenced kptr map value. At first glance,
that's a useful thing to guarantee to a kfunc. It gives kfuncs the
ability to try and acquire a reference on that kptr without requiring
the BPF prog to do something like this:

struct kptr_type *in_map, *new = NULL;

in_map = bpf_kptr_xchg(&map->value, NULL);
if (in_map) {
	new = bpf_kptr_type_acquire(in_map);
	in_map = bpf_kptr_xchg(&map->value, in_map);
	if (in_map)
		bpf_kptr_type_release(in_map);
}

That's clearly a pretty ugly (and racy) UX, and if using KF_KPTR_GET is
the only alternative, it's better than nothing. However, the problem
with any KF_KPTR_GET kfunc lies in the fact that it always requires some
kind of synchronization in order to safely do an opportunistic acquire
of the kptr in the map. This is because a BPF program running on another
CPU could do a bpf_kptr_xchg() on that map value, and free the kptr
after it's been read by the KF_KPTR_GET kfunc. For example, the
now-removed bpf_task_kptr_get() kfunc did the following:

struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
{
	    struct task_struct *p;

	rcu_read_lock();
	p = READ_ONCE(*pp);
	/* If p is non-NULL, it could still be freed by another CPU,
 	 * so we have to do an opportunistic refcount_inc_not_zero()
	 * and return NULL if the task will be freed after the
	 * current RCU read region.
	 */
	|f (p && !refcount_inc_not_zero(&p->rcu_users))
		p = NULL;
	rcu_read_unlock();
    
	return p;
}
    
In other words, the kfunc uses RCU to ensure that the task remains valid
after it's been peeked from the map. However, this is completely
redundant with just defining a KF_RCU kfunc that itself does a
refcount_inc_not_zero(), which is exactly what bpf_task_acquire() now
does.

So, the question of whether KF_KPTR_GET is useful is actually, "Are
there any synchronization mechanisms / safety flags that are required by
certain kptrs, but which are not provided by the verifier to kfuncs?"
The answer to that question today is "No", because every kptr we
currently care about is RCU protected.

Even if the answer ever became "yes", the proper way to support that
referenced kptr type would be to add support for whatever
synchronization mechanism it requires in the verifier, rather than
giving kfuncs a flag that says, "Here's a pointer to a referenced kptr
in a map, do whatever you need to do."

With all that said -- so as to allow us to consolidate the kfunc API,
and simplify the verifier, this patchset removes the KF_KPTR_GET kfunc
flag.

David Vernet (3):
  bpf: Remove bpf_kfunc_call_test_kptr_get() test kfunc
  bpf: Remove KF_KPTR_GET kfunc flag
  bpf,docs: Remove KF_KPTR_GET from documentation

 Documentation/bpf/kfuncs.rst                  | 21 ++---
 include/linux/btf.h                           | 15 ++--
 kernel/bpf/verifier.c                         | 64 ---------------
 net/bpf/test_run.c                            | 12 ---
 tools/testing/selftests/bpf/progs/map_kptr.c  | 40 ++--------
 .../selftests/bpf/progs/map_kptr_fail.c       | 78 -------------------
 .../testing/selftests/bpf/verifier/map_kptr.c | 27 -------
 7 files changed, 18 insertions(+), 239 deletions(-)

-- 
2.40.0

