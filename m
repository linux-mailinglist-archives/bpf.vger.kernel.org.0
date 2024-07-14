Return-Path: <bpf+bounces-34778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2C930B0C
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD181F21D31
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E713C827;
	Sun, 14 Jul 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8hgj0hK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5FA15C0;
	Sun, 14 Jul 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979494; cv=none; b=Laoj6/+GcBuFhDyzaDWUejsaahflBvEFl8HqvaK2rvnnoOvLwLoCn/tyF0w0NXbCp2xJnPTr02n/02buZrfBOxmfF5K094EMdoMwbzza40Dv8frL5GOZRYEBYUaT+iF0ho/AGKLy5pt2ix40Iqir6M0fTCf6LC/0d0+vuMZTj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979494; c=relaxed/simple;
	bh=Wk/fAgif21ZTPLwUEv0nzy5h6aetAxhk7e7VOkM3aZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jH1CmzWDafua60W9t7fXzkmJ5cweWRhaby4in9ffIc7pMGQgs+7M7k4Ziu14WhVOnSHD7KAeqkIV5LNgm6aCXjd1FBEtaaBg1MovNxSijDVBkz2smIg3dHS2WmgqzbWVmJVzFKMENtHsDQel6p91hBXAGNaCav7BFb8XpDdCD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8hgj0hK; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f0e7faafcso286457785a.3;
        Sun, 14 Jul 2024 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979491; x=1721584291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfaiOOrjESjDdpDGyOKMuYRm7PD0zFekR/TMfjqNaVk=;
        b=Y8hgj0hKkq6OnUC0wV48H2ccFyAkBljlkNOXMVmNMC4OT8KFaBzPf6gZlMVA4SP4jK
         3lBTb8v1S0CQImrlVQmkK50ufm2eF4Ka/RI3R3zcqCZ9u//4ulOmVY4xz/mfJcn40ixH
         cquNClgtebkbss536M6C+Fipv8gJprSFq7QPcg76R7R8ClFuMqvo7CCddKIg0q6+l8zI
         5DpeXiq0jvEg6Z8GTuw1S+l1AlvZF9fohQFp7lDQIWWpCCto8o7WEi2C5qHj+EWzVpHR
         EzQEk2m3zdr6oApX0eV2lvLUkKKRGkNJSd0FRUkmMVv/wwsO9RnlgA7BkER9uFkLaYjs
         mbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979491; x=1721584291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfaiOOrjESjDdpDGyOKMuYRm7PD0zFekR/TMfjqNaVk=;
        b=lma1CEEmYwpi1Zlen0Z9TnFq/vG8cWch+CL/1fVMRz/YxKhM5FwJCv9d3+6Jo/4ok7
         /lUdxud0eNo11TeBqrliKtDzK1iQJhGLzgaIQbV8YiYe/BkgN9tNmb14ds0qanib82c/
         2aSQcPdsFxp7jFzd3FUF3G1m5PLZjQtC9FdBHBW0ok3PIQC8nUuDCSSu3J1JvM25NE8g
         C7T3rbn8JUxEfm8LQo+EwjYZBHhUBOcUxkU405cx7mlwSu2TZEdaRQIrUAnjAUMAF9uP
         6NjsF6jwtZPHDuRnYE/88arpojMtkmsS2s3JB0XT/T76jNYecrmuUQfLWihZ4v9GTMqj
         SpeA==
X-Gm-Message-State: AOJu0Yw/2xfNRuqZBrdM7UC9kL3XEwgnKw0+8mwL3doitAUqFXvrNwHC
	BLbVJw1/7ZtZBYy2l+lscnXG+pd2yFqv5R0oohAI22qHkQFmPtIESjjJZg==
X-Google-Smtp-Source: AGHT+IE+RGOlXzeml+sAdPLKly8bs87or7oWVbagsDC3FnoQjxORWegW1yJuAvQfdOA+VTjR3R5joQ==
X-Received: by 2002:a05:620a:20c5:b0:79f:38e:c015 with SMTP id af79cd13be357-79f19aaee70mr1749088085a.62.1720979491448;
        Sun, 14 Jul 2024 10:51:31 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 00/11] bpf qdisc
Date: Sun, 14 Jul 2024 17:51:19 +0000
Message-Id: <20240714175130.4051012-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
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
introduce "ref_acquired" postfix for arguments in stub functions [1] in
patch 1-2. It will allow Qdisc_ops->enqueue to acquire an referenced kptr
to an skb just once. Through the reference object tracking mechanism in
the verifier, we can make sure that the acquired skb will be either
enqueued or dropped. Besides, no duplicate references can be acquired.
Then, we allow a reference leak in struct_ops programs so that we can
return an skb naturally. This is done and tested in patch 3 and 4.

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
release skbs in queues (bpf graphs or maps), which might not be a safe
thing to do. The solution remains to be explored in the next version and
Martin has suggested to store skb in qdisc private data.

* Miscellaneous notes *

The bpf qdiscs in selftest requires support of exchanging kptr into
allocated objects (local kptr), which Dave Marchevsky developed and
kindly sent me as off-list patchset.

Todo:
  - Properly clean up skb in bpf qdisc during reset
  - Support updating Qdisc_ops

---
v9: Drop classful qdisc operations and kfuncs
    Drop support of enqueuing skb directly to bpf_rbtree/list

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

Amery Hung (11):
  bpf: Support getting referenced kptr from struct_ops argument
  selftests/bpf: Test referenced kptr arguments of struct_ops programs
  bpf: Allow struct_ops prog to return referenced kptr
  selftests/bpf: Test returning referenced kptr from struct_ops programs
  bpf: net_sched: Support implementation of Qdisc_ops in bpf
  bpf: net_sched: Add bpf qdisc kfuncs
  bpf: net_sched: Allow more optional operators in Qdisc_ops
  libbpf: Support creating and destroying qdisc
  selftests: Add a basic fifo qdisc test
  selftests: Add a bpf fq qdisc to selftest
  selftests: Add a bpf netem qdisc to selftest

 include/linux/bpf.h                           |   3 +
 include/linux/btf.h                           |   1 +
 include/net/sch_generic.h                     |   7 +
 kernel/bpf/bpf_struct_ops.c                   |  26 +-
 kernel/bpf/btf.c                              |   3 +-
 kernel/bpf/verifier.c                         |  84 ++-
 net/sched/Makefile                            |   4 +
 net/sched/bpf_qdisc.c                         | 412 ++++++++++++
 net/sched/sch_api.c                           |  18 +-
 net/sched/sch_generic.c                       |  11 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  15 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   6 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 215 ++++++
 .../prog_tests/test_struct_ops_kptr_return.c  |  87 +++
 .../prog_tests/test_struct_ops_refcounted.c   |  41 ++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  16 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 102 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 623 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_netem.c     | 258 ++++++++
 .../bpf/progs/struct_ops_kptr_return.c        |  29 +
 ...uct_ops_kptr_return_fail__invalid_scalar.c |  24 +
 .../struct_ops_kptr_return_fail__local_kptr.c |  30 +
 ...uct_ops_kptr_return_fail__nonzero_offset.c |  23 +
 .../struct_ops_kptr_return_fail__wrong_type.c |  28 +
 .../bpf/progs/struct_ops_refcounted.c         |  67 ++
 .../struct_ops_refcounted_fail__ref_leak.c    |  17 +
 28 files changed, 2153 insertions(+), 22 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_netem.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c

-- 
2.20.1


