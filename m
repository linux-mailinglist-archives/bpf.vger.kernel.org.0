Return-Path: <bpf+bounces-54403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D9A69B93
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD810188C811
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2C21B9D9;
	Wed, 19 Mar 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ5F/Ls5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AA1CAA81;
	Wed, 19 Mar 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421251; cv=none; b=iet/xd/dtIyIDH303lnrde4kI+PUY7w2pBy+mGziqlS04rwreW4pk4Nx/EUaFE5S77+p6n5EuCI+3v3JVMVRzT5gVeLxaPFW9Bi+0LEvsjOdqfqWNgkzwTBy9s0bj3ucWpHr+e3419yKB7k8y5+nfznUL2L4TCfNa7/mWnPpSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421251; c=relaxed/simple;
	bh=ovUjW3+JEEKCw1QwK/KlZRni+WImCsiPn+FD5Dkhy0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XY1KG12wWDZYi92bIUXJ4fRpcHHxpwMlwecjRBbsvqnAz+iErj8dLwj5I/f/28uCZq0CCx7iAUiEjnjKr8BqdKpqcjni78Z9jR0s1mICDSl9Gvg/f1pN4TI/hoWxOZ160pQkzdMbkBkmX/dELgA2CkwKdt9+DR0YA6vH9Blqj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ5F/Ls5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so768925ad.1;
        Wed, 19 Mar 2025 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421249; x=1743026049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwedGqfCxzZAyfi6cGjvG0Mxj7XNSsONwNdfFnKwRDg=;
        b=mZ5F/Ls5UrQUs5KJhCMur7nzoR4kyC9yPXRmG9syaxtxPrI2ckPMDm+Ibf88u5ZTU8
         yPhDHhufe/tMIYLHjtgqKY8s4ETZ0XyJQ6Ag8h44mej53pd8rQ0OyD4xTEeXV5me3Jzh
         2p4hVznHr5GSqsKZLvvytvGXz3mCBiVN9y3ZD6h8eqq0Q8Ew1WlZcIk3C5z4qSgKU1FH
         CU/JingLObPBaijb9VREORsD8rofkhGBwvO1wx5Ae02ytLBX5+uIIcWyMTpwxhxQiufG
         0HprCYp909i0wvxQEiTA/UFegjuwDNbFGI6S/AAJmoZugVRzikn21fjcAMwvv+tS4MqA
         vpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421249; x=1743026049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwedGqfCxzZAyfi6cGjvG0Mxj7XNSsONwNdfFnKwRDg=;
        b=oMRI6dPg3Tm8d9fwDvxnDnnn/GFv9zz6FHAcepMqJbnuTwwIyAwRprIKmZG1T7CO9C
         SvtuCaU40dRDxBtvITOGhjWIoi/0bXBE4NjGE2UCf7+KOQkkiQk+sy+etTq2QltUbIls
         SDTTjGEDn2gS1mHdbe6K41b6PNHt7cwRuoqbHajORHVVj2XFRJq4ESK3TUXfwaBlZbu+
         0zdb6JDE+whn8aZMtmCzj6VHbbwggjEAaQiHT7bfp807+xomNhLIBZ/gZXNMzD59BY7A
         nzxSm08YwNdZ8aYBJTAJT3L621aIbEzS0hw35rSANDeN1fvJSXnBQtVlmNpJfApSPfMm
         CpQQ==
X-Gm-Message-State: AOJu0YyJSq9S8zgw/Obj1uIpOs16t5vSTEGxEY/Cs58V7Jki0pRMML7g
	3SvVjDRKDnnsLb+/Dk4zHyizl76+5Gu24lvjtubvwHRiHsepXQWcmUBK5NNILVg=
X-Gm-Gg: ASbGnctNpoq2oo9ZGFHJLQjCCqr6KRIHY4SoGrR2jGJRKxe0dNZvJN8ITsOal2mcJPn
	MrlRMT3iMD4U+SESRIaOLe+0hrHGDlabo2u6KXTQ978Rohi7foqBx1Hq+2IQ6DZ81UpAwwF8Yh8
	m9UFeiFOlI/Xb9ADyX/0I9jtZMBVIBISAqs0yZj/MIEWADS63ZCfCeE0MLk7xoK4tl15cj2D6SW
	8oR2KMAfP1XHnEMPVzxZ8kEFzhefJRUZ944HBvXYd6T1hvnpQOT2tpgYV4KKNcckasyOoT9yUBv
	DxxFYgCF+rErdBB/FTy4TtuyRwxjkIIfPpJVvtX9DslFe5v22aAejyhJy3PBLcUcH9t9Um3XLFv
	sy9EDn5G5GLsahZYKLfQ=
X-Google-Smtp-Source: AGHT+IHgj0nPSFbqsZmewQkHuSOqxO1oPrf2jzo2q7LrdXwWET/m6CDUVJiXeDbZFHwT0Hzp5ShilA==
X-Received: by 2002:a17:902:f549:b0:220:faa2:c917 with SMTP id d9443c01a7336-2265ee927d4mr14648395ad.34.1742421248569;
        Wed, 19 Mar 2025 14:54:08 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:08 -0700 (PDT)
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
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 00/11] bpf qdisc
Date: Wed, 19 Mar 2025 14:53:47 -0700
Message-ID: <20250319215358.2287371-1-ameryhung@gmail.com>
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


---
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

Juntong Deng (1):
  bpf: Add struct_ops context information to struct bpf_prog_aux

 include/linux/bpf.h                           |   2 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |   6 +-
 kernel/bpf/verifier.c                         |   8 +-
 net/sched/Kconfig                             |  12 +
 net/sched/Makefile                            |   1 +
 net/sched/bpf_qdisc.c                         | 477 +++++++++++
 net/sched/sch_api.c                           |   7 +-
 net/sched/sch_generic.c                       |   3 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 180 +++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  29 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 119 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 752 ++++++++++++++++++
 16 files changed, 1611 insertions(+), 13 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c

-- 
2.47.1


