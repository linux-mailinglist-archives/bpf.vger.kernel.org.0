Return-Path: <bpf+bounces-53983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4988A6005C
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491A5880B87
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1E1F130E;
	Thu, 13 Mar 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLZgm360"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F281553AB;
	Thu, 13 Mar 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892601; cv=none; b=RH4bTWP/PSNZeXGQa87si/NgL+bqbt9ZJckRC9GZJCW3HIH83O/KvbeaopndRVsM/+ZrStCjh7ax0nkD3hIiuPA5erSR6PsXSC1PHQAcSkKac+XKgPqazg1bJqbaCIE+AOsmo6OcSQXrtulBbsmkdN45IC8fbqktQrPGIOHggzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892601; c=relaxed/simple;
	bh=NJhRTjUlGAgrvCwvhJuzlj2LFzRbucpehU8BumnGJm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=euSriGZqQ0Uw5YUb3+uYiQIl5UolgXkMCfq1J4DJwspFki0m307OFD2wqkci3RU27oVDteRvFfi2F3f3ZR/48qmd+UX+Q6epOS0p1AzTXPZnOlNTqs5rQHDfhNGQ4Ta7yxU3OhvFab2T0/Aqtr0E+wUmBvHyhtcV1vkzOudtmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLZgm360; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409077c06so36422745ad.1;
        Thu, 13 Mar 2025 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892599; x=1742497399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Azdl0fUq3cpx2ZaSUvDzlQNtzVqi4CmZcTbpC6ZcQsY=;
        b=aLZgm3604MKm+8cyQKIccLKMifkbBMHdyP8NR6XpxS4uPPDC6yswzXRXSe51dQuKM0
         P0uKLFVq1XAbukOXPy2zJFVReUjcqS1zmlniGl9Neo2AhFKUmxqPZJlj5w/HlNQZiMK6
         NaYwm9V4j54SuHhF7p7uc9tbDowEl0VK39uWOyGUZ+khoctfKH+d7VDkpq6OPeLi4g5t
         a5M/79miHN5b8fOI2JLRXdWJMv7/LRo9lA5MkrNa0ipZU/Qc+LF8dRTwD+Bz6dKY0u0P
         hQZXDiXaaHcfSPRrGv6R2iQ/TaLUizSpJs7Lersn7wK7dY8LstH6x/K++sMUeP/nIJLN
         dHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892599; x=1742497399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Azdl0fUq3cpx2ZaSUvDzlQNtzVqi4CmZcTbpC6ZcQsY=;
        b=QaU5Xj8bKZkvpi2H8PSmFdcEorgvIc6dtAKIgiDblgoinJ1VnoLIJAbRmocDFmKnuy
         7QfZt4cV7HP8M/Jhq7N9IORlgrB5IykMHWyjqhWTUhvlJaCdqaDkAs5+dZkinpUlGrFM
         J6wbZDAaoCmZOfow5BSsX+CZbnX7vVVjUsECPXCa7c+TgqA8nGDEu7rWcgM/4xvk1HLw
         Ay8YrwvVdyPnJDs7Z9D7RzTdzxfhGe46vjEyothtwIalBK0a0nIIWepORmtMDyoogahR
         NlL8aDjTO2+d4GuMw4B4OkZog5E9XmQWWXsxFefLotDR7pZAYa8QJCv5hBy4nA+45BpA
         ESlg==
X-Gm-Message-State: AOJu0YxB1rtEexXDP5iCUOWYhSSu/2c3IEz5qxovxPtfMWsxAmql9ieZ
	Lm605nmaF7VfdoI2rCub2qAMPlgbBzhMTP0Mss8jf3l9JyimLchshnHvY2EWq5v7Ow==
X-Gm-Gg: ASbGncu1l47TmJEmnw31HMeNph8P8VdQL408l2YRpQKYMtnfAZBEc1Zqc8C+c9anSB3
	cZkElxiiE5PPeuD4O35MTkmEB6Ydkuh1Q0GjiSvynQGTwossHey2/sJJwqH+DwjAiwtCl6wAyUE
	yw31rSViDzRqE2DQFUIJ/vH/YdeLJhEI8UBQ01Za5tK/rZz1iJSFUhIkho2oEucmiFiJ/4R2IBW
	yDhgKnQ3pivIwVjKNHQMwxijY4qRlGMjBa0IECyVtFYyqtCx53FghUwNIXrG5mxpAO1Lckd/ZL8
	WUoA/QxBwOryqznODpOF8DgfT4tUXwFK4Jphu+ebctBz5Kg9BDaSNhV/XE+QoZdOFdD2hD3nsl7
	fjpHQ7o1zIG47zs7JX5w=
X-Google-Smtp-Source: AGHT+IG1hOFCHN4r/iLM5GKgAGy6jDn3HCZm8btRIqmRsqktFuX2BjoarslrGDtEX+3Ibp5NMDlc1w==
X-Received: by 2002:a05:6a21:6194:b0:1f5:8d91:293a with SMTP id adf61e73a8af0-1f5bd957a5fmr1319138637.41.1741892598606;
        Thu, 13 Mar 2025 12:03:18 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:18 -0700 (PDT)
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
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 00/13] bpf qdisc
Date: Thu, 13 Mar 2025 12:02:54 -0700
Message-ID: <20250313190309.2545711-1-ameryhung@gmail.com>
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

Amery Hung (13):
  bpf: Prepare to reuse get_ctx_arg_idx
  bpf: Generalize finding member offset of struct_ops prog
  bpf: net_sched: Support implementation of Qdisc_ops in bpf
  bpf: net_sched: Add basic bpf qdisc kfuncs
  bpf: net_sched: Add a qdisc watchdog timer
  bpf: net_sched: Support updating bstats
  bpf: net_sched: Support updating qstats
  bpf: net_sched: Allow writing to more Qdisc members
  bpf: net_sched: Disable attaching bpf qdisc to non root
  libbpf: Support creating and destroying qdisc
  selftests/bpf: Add a basic fifo qdisc test
  selftests/bpf: Add a bpf fq qdisc to selftest
  selftests/bpf: Test attaching bpf qdisc to mq and non root

 include/linux/bpf.h                           |   2 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  15 +
 kernel/bpf/btf.c                              |   6 +-
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
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 718 ++++++++++++++++++
 17 files changed, 1570 insertions(+), 32 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c

-- 
2.47.1


