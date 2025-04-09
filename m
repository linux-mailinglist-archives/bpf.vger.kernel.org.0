Return-Path: <bpf+bounces-55587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F179A83391
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2E71B62D26
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947572147F7;
	Wed,  9 Apr 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbAl53zL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A6101E6;
	Wed,  9 Apr 2025 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235170; cv=none; b=n7G5/4pr/hUOXDhvgMMxyKUxHo8pY6i7GHQ1nCEnbe4IyHdfZkjMGBjxfewkoFb1rWtpuFfUhf4+7GRArMzvSZlhC74iVQAZg17dmImfI5XCu9E3yCgiGnAStYbyNsy7rDu7bliDzjRibvXHGW/N31NDIwM+RK6v/+22uGcrf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235170; c=relaxed/simple;
	bh=QQqdYKnMen+xIhMFpAl6Z+VYe6ezDj46LDbOrisEmg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R3PX9gS0Snz6UKpaICKiWxa5WEk2OFrPuWPEfsXvsB3idtEB/6gC0EFaCdcCrU8bfe6sTF9yeRfv0/6YN2aQIucTm8BuMEBmaOUbQW7Wm+tsoaPbKfqkt5/IPGivjBj5yhOQ2ilJMVJtHLUM2JIQBnp1vgkBqeR2hxFlLnH30Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbAl53zL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso13503365ad.0;
        Wed, 09 Apr 2025 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235167; x=1744839967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHjR+KGHRaH+aWnGMZ7U16bra5QHOdcTkh13kL1yiwk=;
        b=JbAl53zLBK5gNuPo48gQjy8o1/i/B6MlFCp+L0ZHXLSVIl2Zq1LtgVsZodBguYS+09
         7CkJafkY30kcTVC5ZST+bnLXlyg69Z/LHz3cCxT9WP5qqYLpKRrbRVT5CMdhM/AyhL65
         HcEAo11mP/gYGvcbs3SDfEgp5IO8X0fd4h4mCvini3q2Oa+igUpI411Lt68LSimuHsLt
         ZEe+TJYilW2/a/2FZ/IY1B1Mk6kki/z0LH2GD6kkULJmvuI48Mh3rfKkWXmG+KxfcBSR
         DVfqPgwB1dWAVOtYyu9eJyR3p0J+ij3zl8NvWUWEBLzPU2CNZRPAhKGsIcanGO1dmN0+
         ZJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235167; x=1744839967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHjR+KGHRaH+aWnGMZ7U16bra5QHOdcTkh13kL1yiwk=;
        b=bZEQfMTy2DJ8xSLac0TojnPb08eaQRgzD3lkRgAi7NN6fo/wG2+9Kt4aa7XY7nTCJu
         aVXdwm+ZuwZFCbIi4LEKMMvjvJRVAFjK78zIwXY2/YQzQ+0JyenFnAtNWZgQv0TuVEEx
         GcB2G5zJrLHX5HPiOeR4kklGiKZRUpEZeZuGI02oYRkVqB2oIvEmZWP8jdtZkZeKsv0j
         zoy6cAl0Fdw2yDCst7PZNUQ2V4qEZdpQqDYDNWFt15U2pHoTXMnTaZAeQ9y1psczUiTT
         5o1EeykKGR7XV/KdGhDcMQ5VdFLYrpIgxdyZv35ItHMpwPL+vvQ7IV5YTbUxhT7adUqW
         C8kg==
X-Gm-Message-State: AOJu0YyyEFFbYq9xkpZlNJREsqL1gvr8MHso6Jh88Ylua2KyeCidbGvW
	pzDgLnvX15eXDgaWhVERSwPEwz+18U/Wk0UKtfTIwdUGOpZL8yy7LKhmGKHP
X-Gm-Gg: ASbGncvkytdTzT2L/ZhfNLFYmmS7zeVcpQ4oKRontXs0vyxcNwaY5+RprhdHN9QsQSY
	FIT+xUikMOiR3SYVPm/EOmepASosoI4F5JY9xvyF6pRDr5dH/2y/pE6feaoAe1cQbLSpT1stDav
	JmWqx/xLCsaCghZv4W0vUymyiD7hSET2mU3gXdflkTAu/dlR8NcHU8ZdqfJEoXZi7JzFBCMj2St
	gTvqjSsdLgAZ0Cio5qJfM+8kuvp9z2YJhuOOyBoaPkURLa77LpM8BBIouw2ycvNhrF9sH6c0Rvi
	/uESmlpRQY2kkdWMp9MMgxxZ4SEjH0MN
X-Google-Smtp-Source: AGHT+IFOrzQyChFp7CqcwlGAwccn6TJNgDmdoqjG4McS52jHzEmSSBuWaXAlSuGfzEUOjHQf60RGfg==
X-Received: by 2002:a17:903:40cc:b0:226:194f:48ef with SMTP id d9443c01a7336-22b694aa57dmr4564665ad.13.1744235167378;
        Wed, 09 Apr 2025 14:46:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df401abdsm2009380a91.43.2025.04.09.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 00/10] bpf qdisc
Date: Wed,  9 Apr 2025 14:45:56 -0700
Message-ID: <20250409214606.2000194-1-ameryhung@gmail.com>
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


---
v7:
  * Rebase to bpf-next/master and resolve a slight merge conflict due to
    commit 2eb6c6a34cb1 ("net: move replay logic to tc_modify_qdisc")
    moving a module_put(). No functional change from v6.

    Link to v6: https://lore.kernel.org/bpf/20250319215358.2287371-1-ameryhung@gmail.com/

v6:
  * Improve kfunc filter implementation
      - Drop old patch 2 that introduces a function to get member offset
        of struct_ops program
      - Include patch 1 from Juntong Deng from [0], which populates
        prog->aux->st_ops and attach_st_ops_member_off once and early in
        the verification
      - Adopt flag-based kfunc filter proposed in sched_ext [0]
  * Refactor bpf_qdisc_btf_struct_access 
      - Merge old patch 7, which allows writes to Qdisc->qstats with
        patch 3 (Support implementation of Qdisc_ops in bpf)
      - Share checks of bpf_qdisc_sk_buff_access() and
        bpf_qdisc_qdisc_access() in bpf_qdisc_btf_struct_access()
  * Explain what bytecodes in gen_pro/epilogue do in the comment
  * Merge old patch 8, which simply allows writes to Qdisc->q.qlen and
    Qdisc->limit, with patch 3 (Support implementation of Qdisc_ops in
    bpf)
  * Minor fixes
      - Remove bpf_qdisc_get_func_proto that is no longer needed as tail
        call is disabled universally for struct_ops with __ref args
      - Remove .peek's cfi_stub as it is not supported
  * Add SPDX license identifier
  * Add Acked-by from Toke

    [0] https://lore.kernel.org/all/AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com/
    Link to v5: https://lore.kernel.org/bpf/20250313190309.2545711-1-ameryhung@gmail.com/

v5:
  * Rebase to bpf-next/master
  * Remove prerequisite bpf patches that has landed
  * Add Acked-by from Cong

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



Amery Hung (10):
  bpf: Prepare to reuse get_ctx_arg_idx
  bpf: net_sched: Support implementation of Qdisc_ops in bpf
  bpf: net_sched: Add basic bpf qdisc kfuncs
  bpf: net_sched: Add a qdisc watchdog timer
  bpf: net_sched: Support updating bstats
  bpf: net_sched: Disable attaching bpf qdisc to non root
  libbpf: Support creating and destroying qdisc
  selftests/bpf: Add a basic fifo qdisc test
  selftests/bpf: Add a bpf fq qdisc to selftest
  selftests/bpf: Test attaching bpf qdisc to mq and non root

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |   6 +-
 net/sched/Kconfig                             |  12 +
 net/sched/Makefile                            |   1 +
 net/sched/bpf_qdisc.c                         | 477 +++++++++++
 net/sched/sch_api.c                           |   7 +-
 net/sched/sch_generic.c                       |   3 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 180 +++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  31 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 750 ++++++++++++++++++
 14 files changed, 1601 insertions(+), 11 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c

-- 
2.47.1


