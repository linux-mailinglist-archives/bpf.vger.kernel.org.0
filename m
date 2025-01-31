Return-Path: <bpf+bounces-50221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37393A2433F
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7429B7A21D6
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0561F2C49;
	Fri, 31 Jan 2025 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8p3jlwK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CF28373;
	Fri, 31 Jan 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351764; cv=none; b=Tcr/qm1ZYQoyfqlBFbMxATt7Z4MtA7oGikKfy1FL2vIFMNlgrDyRWJJQY83vFwvC0egxl7HF7T8UDmytIs7ntYOO3eXqbaNQ2wCw0lORw+qPBRF1Sz/c5fiJEtYmJ5KZ7NmZaI0cksE5DfwkZRrdmlweMvJ9KJWnJrIPLlW/JlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351764; c=relaxed/simple;
	bh=OTVrl/urKp7UKsbMSz/tUkgnZXeTehmKqXpyA0M5OPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rWbjCueea52168hT61J4mCNfXQ2TtLJVCRd0CdGwGtg/T/6AMfJ3pMdVo4M2vG8HiaQya4vUC13sGEylFInxVBqvcBmkTky4HPJ3+kRzP7wBQUmNCSKVoC3mbiwL/rYPZvK9wDkiMHJKm+0UVupCtRdeHSKy2TyR2AgghJKAAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8p3jlwK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso3234149a91.1;
        Fri, 31 Jan 2025 11:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351762; x=1738956562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OE74VXVgKsND8FJVRh0NyaG5p+rk7onmLT7r/29eV6M=;
        b=B8p3jlwKYVq9oUc1C3NO2/HtlEx5XneQOiOWL7jDHDfXmoS6K6h4m44/bcXQY45ECq
         GAA/FVz0WR/zN5cTEAa+AW8Rw+/tkElBpVu1AdBbuL5JQFOeSMeiLqRdJsnp2DdypGu1
         SK1VeIhZR5gOmVsA9IO9gllWfpsH02vHYtPA5+/jkWlof1yRbWl1roD7f9enlgvK2D3J
         IwqcWEkKrbwJ9TCySOGO949GDw1XF8yT10vG7Qs+C36wciZPzbCdHzr8V4j+drNQgVZE
         91kYEbjzxpoxzRpGEPdI9KJQsQjyafzHa112eE396b7moln6t7nfe9qbvVW4jgKxtGLi
         745w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351762; x=1738956562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE74VXVgKsND8FJVRh0NyaG5p+rk7onmLT7r/29eV6M=;
        b=INb5LuXqDouyJU1GXE1/898LNVbHjxgTXL/dYM/DPJuaVterRqiqF04UiWUTX62MKx
         G8RtlyolUuw09BGICVWSMzd+ABAaVYlbGjbd0s3+iblFpT794Y9e+hmmWdiK2TBrniEk
         bnYEwXu2k3qFvOq4AqhYoDU3C0RENHhWFbAmxvhywBL43ssTP8p5oLMKDCYPgvciWNEZ
         xg9GWuy0G14Eb9DpVFMblL6vJwA48RZnGJ2xl70VIeonYwYAeMfQohfQNUeGlF869FNg
         i1m7d8MWd3sde1lxchjRq5wUQHi5XTl8x2o8iregYUJ6MFVstW0DVWjWtBYcZD97ly4J
         pzzw==
X-Gm-Message-State: AOJu0YwxdugHi/NeoX2MXyegZ0vbRIaFPT0/Dt0rhZtb8IFb6S9mhn+t
	xu57Fkf9iZt3VwrOZH+JHCdWMCTp/2zlD9XJIzRhRtumIB12GjSfyROBpeSHwQk=
X-Gm-Gg: ASbGncuo87O/SMz1pPBVuy7TVXOv4TRlThJcwnz6l4EKnyKYlTG0EeC6uLigkaCfOEO
	Vdj0/mP9z47Dn0/30QzDtO5sW8eNaDPnyGyTPKdi1xPV5pY4ZbQ78rlLRRe8lm0PNBMSxbbiZSa
	nwGD/gNcKkXP20vfZQVefaxzICfvn2JbUWmTqmrklR86gNAZfHmu3GoH9VNhyXUqqR8md8UKdOm
	2klCD+KnJJWEr6TDtxqrFSFQyYQP+pmufYmlXeAh/FsZc0SJCCz4aW9q+UKq+Z4YOxza/tk8iJv
	XRb70On1ZhcT2dgwnYLw/eKASZuK8I8F+YOzZZw7b44k9I7gLdEpDPcu/RlnlZ0pgA==
X-Google-Smtp-Source: AGHT+IGoyNvi4mUwcU4D+y3mxehUk+PFdxscWg5q4fAKcIVTsN21XF0hKZCrPXgqzsjlZ8W9yOyRHA==
X-Received: by 2002:a17:90b:1f88:b0:2ee:9d36:6821 with SMTP id 98e67ed59e1d1-2f83ac8c273mr17186969a91.27.1738351761998;
        Fri, 31 Jan 2025 11:29:21 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:21 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 00/18] bpf qdisc
Date: Fri, 31 Jan 2025 11:28:39 -0800
Message-ID: <20250131192912.133796-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patchset aims to support implementing qdisc using bpf struct_ops.
This version takes a step back and only implements the minimum support
for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
directly and 2) classful qdisc are deferred to future patchsets. In
addition, we only allow attaching bpf qdisc to root or mq for now.
This is to prevent accidentally breaking exisiting classful qdiscs
that rely on data in a child qdisc. This limit may be lifted in the
future after careful inspection.

* Overview *

This series supports implementing qdisc using bpf struct_ops. bpf qdisc
aims to be a flexible and easy-to-use infrastructure that allows users to
quickly experiment with different scheduling algorithms/policies. It only
requires users to implement core qdisc logic using bpf and implements the
mundane part for them. In addition, the ability to easily communicate
between qdisc and other components will also bring new opportunities for
new applications and optimizations.

* struct_ops changes *

To make struct_ops works better with bpf qdisc, two new changes are
introduced to bpf specifically for struct_ops programs. Frist, we
introduce "__ref" postfix for arguments in stub functions in patch 1-2.
It allows Qdisc_ops->enqueue to acquire an unique referenced kptr to the
skb argument. Through the reference object tracking mechanism in
the verifier, we can make sure that the acquired skb will be either
enqueued or dropped. Besides, no duplicate references can be acquired.
Then, we allow a referenced kptr to be returned from struct_ops programs
so that we can return an skb naturally. This is done and tested in patch 3
and 4.

* Performance of bpf qdisc *

This patchset includes two qdisc examples, bpf_fifo and bpf_fq, for
__testing__ purposes. For performance test, we compare selftests and their
kernel counterparts to give you a sense of the performance of qdisc
implemented in bpf.

The implementation of bpf_fq is fairly complex and slightly different from
fq so later we only compare the two fifo qdiscs. bpf_fq implements a 
scheduling algorithm similar to fq before commit 29f834aa326e ("net_sched:
sch_fq: add 3 bands and WRR scheduling") was introduced. bpf_fifo uses a
single bpf_list as a queue instead of three queues for different
priorities in pfifo_fast. The time complexity of fifo however should be
similar since the queue selection time is negligible.

Test setup:

    client -> qdisc ------------->  server
    ~~~~~~~~~~~~~~~                 ~~~~~~
    nested VM1 @ DC1               VM2 @ DC2

Throghput: iperf3 -t 600, 5 times

      Qdisc        Average (GBits/sec)
    ----------     -------------------
    pfifo_fast       12.52 ± 0.26
    bpf_fifo         11.72 ± 0.32 
    fq               10.24 ± 0.13
    bpf_fq           11.92 ± 0.64 

Latency: sockperf pp --tcp -t 600, 5 times

      Qdisc        Average (usec)
    ----------     --------------
    pfifo_fast      244.58 ± 7.93
    bpf_fifo        244.92 ± 15.22
    fq              234.30 ± 19.25
    bpf_fq          221.34 ± 10.76

Looking at the two fifo qdiscs, the 6.4% drop in throughput in the bpf
implementatioin is consistent with previous observation (v8 throughput
test on a loopback device). This should be able to be mitigated by
supporting adding skb to bpf_list or bpf_rbtree directly in the future.

* Clean up skb in bpf qdisc during reset *

The current implementation relies on bpf qdisc implementors to correctly
release skbs in queues (bpf graphs or maps) in .reset, which might not be
a safe thing to do. The solution as Martin has suggested would be
supporting private data in struct_ops. This can also help simplifying
implementation of qdisc that works with mq. For examples, qdiscs in the
selftest mostly use global data. Therefore, even if user add multiple
qdisc instances under mq, they would still share the same queue. 

* Misc *

This patchset has grown a bit in this iteration. I can split the kptr
acquire/release mechanism for struct_ops into another set if that makes
sense and helps people review.

The performance numbers will be updated again when the set gets closer to
landing.

---
v3:
  * Rebase to bpf-next/master
  * Remove the requirement in the verifier that "__ref arguments must
    acquire ref_obj_id first" by making each prog keeping a copy of
    arg_ctx_info and saving ref_obj_id in it.
  * Generalize prog_ops_moff() to work with any struct_op (now called
    bpf_struct_ops_prog_moff())
  * Use bpf_struct_ops_prog_moff(prog) instead of
    prog->aux->attach_func_name to infer the ops of a program
  * Limit attach to root and mq for now and add corresponding selftests
  * Simplify qdisc selftests with network_helper
  * Fix fq_remove_flow() not deleting the stashed flow

v2: Rebase to bpf-next/master

    Patch 1-4
        Remove the use of ctx_arg_info->ref_obj_id when acquiring referenced kptr from struct_ops arg
        Improve type comparison when checking kptr return from struct_ops
        Simplify selftests with test_loader and nomerge attribute
    Patch 5
        Remove redundant checks in qdisc_init
        Disallow tail_call
    Patch 6
        Improve kfunc ops availabilty filter by
        i) Checking struct_ops->type
        ii) Defining op-specific kfunc set
    Patch 7
        Search and add bpf_kfunc_desc after gen_prologue/epilogue
    Patch 8
        Use gen_prologue/epilogue to init/cancel watchdog timer
    Patch 12
        Mark read-only func arg and struct member const in libbpf
    Link: https://lore.kernel.org/bpf/20241220195619.2022866-1-amery.hung@gmail.com/

v1:
    Fix struct_ops referenced kptr acquire/return mechanisms
    Allow creating dynptr from skb
    Add bpf qdisc kfunc filter
    Support updating bstats and qstats
    Update qdiscs in selftest to update stats
    Add gc, handle hash collision and fix bugs in fq_bpf
    Link: https://lore.kernel.org/bpf/20241213232958.2388301-1-amery.hung@bytedance.com/

past RFCs

v9: Drop classful qdisc operations and kfuncs
    Drop support of enqueuing skb directly to bpf_rbtree/list
    Link: https://lore.kernel.org/bpf/20240714175130.4051012-1-amery.hung@bytedance.com/

v8: Implement support of bpf qdisc using struct_ops
    Allow struct_ops to acquire referenced kptr via argument
    Allow struct_ops to release and return referenced kptr
    Support enqueuing sk_buff to bpf_rbtree/list
    Move examples from samples to selftests
    Add a classful qdisc selftest
    Link: https://lore.kernel.org/netdev/20240510192412.3297104-15-amery.hung@bytedance.com/

v7: Reference skb using kptr to sk_buff instead of __sk_buff
    Use the new bpf rbtree/link to for skb queues
    Add reset and init programs
    Add a bpf fq qdisc sample
    Add a bpf netem qdisc sample
    Link: https://lore.kernel.org/netdev/cover.1705432850.git.amery.hung@bytedance.com/

v6: switch to kptr based approach

v5: mv kernel/bpf/skb_map.c net/core/skb_map.c
    implement flow map as map-in-map
    rename bpf_skb_tc_classify() and move it to net/sched/cls_api.c
    clean up eBPF qdisc program context

v4: get rid of PIFO, use rbtree directly

v3: move priority queue from sch_bpf to skb map
    introduce skb map and its helpers
    introduce bpf_skb_classify()
    use netdevice notifier to reset skb's
    Rebase on latest bpf-next

v2: Rebase on latest net-next
    Make the code more complete (but still incomplete)

Amery Hung (18):
  bpf: Make every prog keep a copy of ctx_arg_info
  bpf: Support getting referenced kptr from struct_ops argument
  selftests/bpf: Test referenced kptr arguments of struct_ops programs
  bpf: Allow struct_ops prog to return referenced kptr
  selftests/bpf: Test returning referenced kptr from struct_ops programs
  bpf: Prepare to reuse get_ctx_arg_idx
  bpf: Generalize finding member offset of struct_ops prog
  bpf: net_sched: Support implementation of Qdisc_ops in bpf
  bpf: net_sched: Add basic bpf qdisc kfuncs
  bpf: Search and add kfuncs in struct_ops prologue and epilogue
  bpf: net_sched: Add a qdisc watchdog timer
  bpf: net_sched: Support updating bstats
  bpf: net_sched: Support updating qstats
  bpf: net_sched: Allow writing to more Qdisc members
  libbpf: Support creating and destroying qdisc
  selftests/bpf: Add a basic fifo qdisc test
  selftests/bpf: Add a bpf fq qdisc to selftest
  selftests/bpf: Test attaching bpf qdisc to mq and non root

 include/linux/bpf.h                           |  12 +-
 include/linux/btf.h                           |   1 +
 include/linux/filter.h                        |  10 +
 kernel/bpf/bpf_iter.c                         |  13 +-
 kernel/bpf/bpf_struct_ops.c                   |  53 +-
 kernel/bpf/btf.c                              |   7 +-
 kernel/bpf/verifier.c                         | 121 ++-
 net/ipv4/bpf_tcp_ca.c                         |  23 +-
 net/sched/Kconfig                             |  12 +
 net/sched/Makefile                            |   1 +
 net/sched/bpf_qdisc.c                         | 447 +++++++++++
 net/sched/sch_api.c                           |  14 +-
 net/sched/sch_generic.c                       |   3 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 210 +++++
 .../prog_tests/test_struct_ops_kptr_return.c  |  16 +
 .../prog_tests/test_struct_ops_refcounted.c   |  12 +
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 720 ++++++++++++++++++
 .../bpf/progs/struct_ops_kptr_return.c        |  30 +
 ...uct_ops_kptr_return_fail__invalid_scalar.c |  26 +
 .../struct_ops_kptr_return_fail__local_kptr.c |  34 +
 ...uct_ops_kptr_return_fail__nonzero_offset.c |  25 +
 .../struct_ops_kptr_return_fail__wrong_type.c |  30 +
 .../bpf/progs/struct_ops_refcounted.c         |  31 +
 ...ruct_ops_refcounted_fail__global_subprog.c |  39 +
 .../struct_ops_refcounted_fail__ref_leak.c    |  22 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  15 +
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   6 +
 32 files changed, 2038 insertions(+), 66 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c

-- 
2.47.1


