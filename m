Return-Path: <bpf+bounces-51007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F0A2F57F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EEE166A74
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCEE255E46;
	Mon, 10 Feb 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpPjoSXd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3F2500DA;
	Mon, 10 Feb 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209429; cv=none; b=UuKia105X/+Osj22mLOye3AkOLarq0T8O8885yxYZPpuR5foSF/XUYL7zwhAehuHGaNqz0I65nuGEoCA+Sg6p57CE3FsSKN19F6NQjo3UOK0zj2ED8tOHo28Od0gPrsFKz0qmbf5dOJ4gTMf4xFXw7WxtPEmdciNcKd9sl9MnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209429; c=relaxed/simple;
	bh=rZXHRcMmNM29wd3Y11vNfAOFJ1GwjMnRY8xsUzJ2e/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ASXVwoHznauvYVDsE4Pin1ufCEEtZrweBDra1Qz6bszxtV1X6Gp4Xkx7PGLiLS7x6lKgQm/SVpx+CBAkJYD5XmUU2VWKxg/QK1plSu6fIvJlUm7RctYOCXOcrDcvHxjKbSNDvrTsG2la34TSF53xWQRXuC82Tp3FrNVQIxxV4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpPjoSXd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f5268cf50so46156585ad.1;
        Mon, 10 Feb 2025 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209426; x=1739814226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F04B0Goel6fuRqLnYfUTS4ZEPT2InJoZfozMaHZUimE=;
        b=DpPjoSXdlIauSvYg1HfSVZmLkldLiroiZ/iQ2PRxwv1Plzv26xV+eH2LqjCYqU/S2g
         mpDT2uuC6jDpjhR/JLPubj5HVRkxVgSAfDf9MkthS4BLIPUFLU8CYtq2/F6qeIJEgIWl
         V/cuo0Ne+f7uNTjjLNliW3ZC+NdNjW4XpX51ofYgkuUqbkBT1Aq1kFHFdBjAOyh5aDmt
         UN88Z08MRELZ3Wx2KvHFxRpWolNJqI4E5QEqucuW07HMD3n+9z/EjS/rQccj62bo3ITW
         8/OJnFOZyI1Fp0jbBH0WyyeCdLjeRiMgvmWte9CF6AI+RRv+DZLzapXOjuG5bOhSODlk
         1ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209426; x=1739814226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F04B0Goel6fuRqLnYfUTS4ZEPT2InJoZfozMaHZUimE=;
        b=vLws3RZobPiR4yL1RmlZCJXERfKDY3GrqPWywWEb+9K/IPRHcFZbmymg6IMl6BklZY
         KkU/jp9dh8wuEDUBzxkLD2GfHtS0msXlS0saSFhNLXhnEeJJxecXmJvmKgNrVzUaJTWN
         bIo9C6a3TNCnmmm8bDLB2Y/SApJ2jgt3SzU6sTxZh4Lh9IqTx/OvcOe5fX3kwLetanL2
         fBJHzAXeerPl54LrJiM/iFzRsKTSPqzAyaEDarNh6QEE1i02qHYM5GzqiL/WUYenY2R/
         9ua5Vetr2aW6zTbBbCTL6MsZKov6q9OOMAw/A2TgsHWZcwYvk7Lq1wd7fpDHyPi5l/F7
         4svg==
X-Gm-Message-State: AOJu0YxXKvW46hR3TvmvbHTtfKGdYaZ81A8rsdunxMtti4r0DPxJkLI6
	MzZaxexh4Wuq+wej85+ynd52CRA3T57Q5FMNw/QGO2djMFL3ObdnzuSfgycx
X-Gm-Gg: ASbGncsMrppDI3wU3hC+pjsKXfaPcaLjB/YNNO1ESZ0B4ufVbTeSenEDqeOknqSpTGm
	DaVtiIT5gr4pFRbwBnfNWs3+/0CE68kpkX3Iqo1nhsaS1qF+UOBnf+edsEVnvsLZt7zGleX23us
	5wGg8vQqxEuZFsi5UY0PJCbay8pmNYyDQZeBGNnYqOsEocTpWSFJQlhfBIT7QDKGwy0sbxFP+yW
	94xl9bFUIVnfRjaOrNFAybalj9a13OnzV+b59bDB6R35PfFa/pS5Gir+o7yMymf3+L1cmyHLiYj
	h88c6CQkl7QjbOO+H+n4tu+cxEMTiZktD7Wu4dsksv6/PKXLCBK7hyjduUHVEb/KAw==
X-Google-Smtp-Source: AGHT+IGJUwt3W5XIjDYTlhegLtcocuLm1vXU+SPdPimczmfojgMjwVSmN37TaIqbEk2l4PAFjHhp4A==
X-Received: by 2002:a17:902:d491:b0:216:31aa:1308 with SMTP id d9443c01a7336-21fb64a5fc3mr5091375ad.34.1739209426403;
        Mon, 10 Feb 2025 09:43:46 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:45 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 00/19] bpf qdisc
Date: Mon, 10 Feb 2025 09:43:14 -0800
Message-ID: <20250210174336.2024258-1-ameryhung@gmail.com>
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
v4:
  * Rebase to bpf-next/master
  * Move the root/mq attaching check to bpf_qdisc.c
    (now patch 15)
  * Replace netdevsim with veth for attaching mq

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

Amery Hung (19):
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
  bpf: net_sched: Disable attaching bpf qdisc to non root
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
 net/sched/bpf_qdisc.c                         | 465 ++++++++++++
 net/sched/sch_api.c                           |   7 +-
 net/sched/sch_generic.c                       |   3 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 178 +++++
 .../prog_tests/test_struct_ops_kptr_return.c  |  16 +
 .../prog_tests/test_struct_ops_refcounted.c   |  12 +
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 718 ++++++++++++++++++
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
 32 files changed, 2015 insertions(+), 66 deletions(-)
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


