Return-Path: <bpf+bounces-47468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B39F9AC2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3A21898060
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97C22576D;
	Fri, 20 Dec 2024 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnbZ/9gs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF2224B1C;
	Fri, 20 Dec 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724591; cv=none; b=Z+DCaXxUlwuDBUpRpJvF53sQMlDNgezaVQC6tYi/YFgPAYvMFcI4a5ixEQKS6jwKMZpEsdBBxxB+YByaRnSGPBvJXufWiMtNCFozAUNZkgsSXztRa/bkm2e5pRaUISDsszCBRPUemwkPVHAv7zBWh7KgDta4C6R5iWlk99Bfh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724591; c=relaxed/simple;
	bh=EmMt0HwGufodqrUJ79Mv+D4QFHzKz9JoV1BkF56n+pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yx0LOFKuFgggKB0ktFf0uxT++PRKddscno+rm6Gbr1ofpU5cK+7RBj8sTZ+F+U5oEmkM72E2m7Q1qNRY3oNc0bTuf5kuYpgCd8dWYiYwr/YuFUWLG7p6YQFR7cSW07MLu+RvZVITi1wMYYQAeGD+ZxcQZmq3fHIRhDQmuSjI7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnbZ/9gs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21634338cfdso30877065ad.2;
        Fri, 20 Dec 2024 11:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724589; x=1735329389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3H4++rU/2gW9Y3sxU6H3gu3scj3XD16zlupAFQ27BGE=;
        b=bnbZ/9gs4IS0KfwTumSLfHJr0L4iN3VWxoJv8RFAgGqC0r6304K0a+77zqcrBXPzfc
         2NDLusR03FqIfADJbwSjrrer1RjA770DKZPJvC/OM1RpLud+zPVzht8olcH/meqoK1eC
         4g1i5uHLRoA32is+2W7w/S3UvsaGKz2bWOURCtTx6AEMjr9pwTd62Uvta3FfyBIBHDtS
         HT6wMCC2gPJcv220NPzZxQkU4o85VyHgf/jm0/TBUSu4BhKTX8Dj4sXJVqT3MN8jEKf9
         1+l7zofpKpBrh6RFZQzxmtWqMQfBLXpS1wHvICB9a0gSq3kqgYFVYRwKMwG5FHK8rRf9
         Ew8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724589; x=1735329389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3H4++rU/2gW9Y3sxU6H3gu3scj3XD16zlupAFQ27BGE=;
        b=Cn0+W/KsgoqhA+M1dV00lV8mB7yG6xhUNDYeG4gCRs1it9QcERZu6Msijk//uM16tw
         kDfNDO5y5g4ahBwHy1VEAaBHvYd+LjvSq5HRcVT89EUjUCMDFrNwBzoq8R4Yd3WQBXri
         3FUhYSRaywVNzOIIOn8TjsiNtplvVGP0QfyDvK2vhQXYKtZlJGjxBghzinNhK8Fw2/C1
         vjFta9lvCq+9UNQPYHJxmIaCLVzjf0GKLhqh0HSLz0ygSZ7ar5JKou98oL6HXlFEZ37Z
         jOJKPZKGfd3GqcfzByVWlBDMPESlWHwgKzwCp7cmiHbPvhTbAbgnhIBqzFjb188+tJyU
         MSIw==
X-Gm-Message-State: AOJu0YzQaz1jnCda4D+fw7ndfwifYnV3kVV8wZhL78ZBMXymmwVUXqnE
	2tIKPUAioATQKlnGowEqyC9vFTaGk40iFt5v0pgdWtqPp4zKBhKNICUj3Q==
X-Gm-Gg: ASbGncuNx+ut+88DDR1sNoS5Cb6evd0H0Eue+Vue2SYDgJFXwkBRNVFK4Dd+o9Ual8A
	gmS3awQHpy5uArHU23NBmwG0nUkcFd019Gg2jzOgYYVMaRckGJEgttdk51Tq8fhK9YYdU7nt4+s
	BVfoZgxDx09XLc69mXEbxF0oEEIZxyfovyistki0cgOwnlZNq55nWqPnYYyAi/foGL37l4899cm
	uZ1cVtzixvBSiBPgwLQwrxnUuy3x4Ba7o64cmLCurtD1R8mG1iev57Sa7oSb/9n7bLUAnTHcI2K
	vak+zztyewVnnSLoWJ9ANLkgsEeAbAJM
X-Google-Smtp-Source: AGHT+IFD7znQprzR+4fkBWQnwdXR15pt8kVhN4boJOzWyeg807U1bzrwkbZj1t5nxes6PFUtq4dsQg==
X-Received: by 2002:a17:902:ce01:b0:215:97c5:52b4 with SMTP id d9443c01a7336-219e6f2601emr63828005ad.39.1734724588738;
        Fri, 20 Dec 2024 11:56:28 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:28 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 00/14] bpf qdisc
Date: Fri, 20 Dec 2024 11:55:26 -0800
Message-ID: <20241220195619.2022866-1-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
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
directly and 2) classful qdisc are deferred to future patchsets.

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

We tested several bpf qdiscs included in the selftests and their in-tree
counterparts to give you a sense of the performance of qdisc implemented
in bpf.

The implementation of bpf_fq is fairly complex and slightly different from
fq so later we only compare the two fifo qdiscs. bpf_fq implements the
same fair queueing algorithm in fq, but without flow hash collision
avoidance and garbage collection of inactive flows. bpf_fifo uses a single
bpf_list as a queue instead of three queues for different priorities in
pfifo_fast. The time complexity of fifo however should be similar since the
queue selection time is negligible.

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


---
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

Amery Hung (14):
  bpf: Support getting referenced kptr from struct_ops argument
  selftests/bpf: Test referenced kptr arguments of struct_ops programs
  bpf: Allow struct_ops prog to return referenced kptr
  selftests/bpf: Test returning referenced kptr from struct_ops programs
  bpf: net_sched: Support implementation of Qdisc_ops in bpf
  bpf: net_sched: Add basic bpf qdisc kfuncs
  bpf: Search and add kfuncs in struct_ops prologue and epilogue
  bpf: net_sched: Add a qdisc watchdog timer
  bpf: net_sched: Support updating bstats
  bpf: net_sched: Support updating qstats
  bpf: net_sched: Allow writing to more Qdisc members
  libbpf: Support creating and destroying qdisc
  selftests: Add a basic fifo qdisc test
  selftests: Add a bpf fq qdisc to selftest

 include/linux/bpf.h                           |   3 +
 include/linux/btf.h                           |   1 +
 include/linux/filter.h                        |  10 +
 kernel/bpf/bpf_struct_ops.c                   |  40 +-
 kernel/bpf/btf.c                              |   7 +-
 kernel/bpf/verifier.c                         |  98 ++-
 net/sched/Kconfig                             |  12 +
 net/sched/Makefile                            |   1 +
 net/sched/bpf_qdisc.c                         | 443 +++++++++++
 net/sched/sch_api.c                           |   7 +-
 net/sched/sch_generic.c                       |   3 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 185 +++++
 .../prog_tests/test_struct_ops_kptr_return.c  |  16 +
 .../prog_tests/test_struct_ops_refcounted.c   |  12 +
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 726 ++++++++++++++++++
 .../bpf/progs/struct_ops_kptr_return.c        |  30 +
 ...uct_ops_kptr_return_fail__invalid_scalar.c |  26 +
 .../struct_ops_kptr_return_fail__local_kptr.c |  34 +
 ...uct_ops_kptr_return_fail__nonzero_offset.c |  25 +
 .../struct_ops_kptr_return_fail__wrong_type.c |  30 +
 .../bpf/progs/struct_ops_refcounted.c         |  31 +
 ...ruct_ops_refcounted_fail__global_subprog.c |  37 +
 .../struct_ops_refcounted_fail__ref_leak.c    |  22 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  15 +
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   6 +
 30 files changed, 1964 insertions(+), 26 deletions(-)
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
2.47.0


