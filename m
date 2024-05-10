Return-Path: <bpf+bounces-29519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B48C2A76
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340DE1F237EF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FE487B0;
	Fri, 10 May 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvvto5uQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDA47A62;
	Fri, 10 May 2024 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369056; cv=none; b=B3cA0g2yYdFBb/9LALgWASujEyR5H2OjFMve0yZgPBmA9UAL5makNURa3YaGLh/jvN+xzWmFu4hf3sFSbivq2nKRG/03FHp8x6iZdZSyFf0WoMBulS3+iRTP05fftCyhh41Uaz5hbygV8yXVKtnlhxUnL8yfiWi7KOR7J0SMqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369056; c=relaxed/simple;
	bh=gwKcORrZTVgKbilEj0IBj/n31Yqqw4k5/szSdpM025g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A1iXFx7/KHFKrvfBnXhE4VT2hATYTc8hIwGCCvA++TncYdcMGfxud3RLCjBGSlt4n2zfE20FGwwYjIBABzr3l02yZSAGHZvlp/jnT8k7wUiERVAQCMwfJXXv8jPx68xUkF2ofxIWXfZqXHzE6J28OJDSAT3NwjRIIm6oTcHRyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvvto5uQ; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4df1cb51866so717133e0c.3;
        Fri, 10 May 2024 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369054; x=1715973854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/eUnTFro7FOl+F47KJAx+RfdI70P4+3XVz5qXeWrmc=;
        b=Cvvto5uQwJEribZHIDiPEu1KcDYzsmLnm5EEPUHJWXIITVSBGAS5SbZdpGu/Vk6H5W
         mBr1maVd2uG4Yu096TVlTzYM5C7mlW3ERn1HzgCZ20ZkDTcP2meCFCCbBsOnGXJoAbsZ
         Z4WZ7snECnL3NoKw+oAIUWukuzVsvbfUDpDbO/rTW3kIpj8cIX9PLme6piQ+IKUOYMNy
         tYRhtHRsigGuFGVuEMFwwTFwCy2VrP+YRrlarWm91oIqvE+owKwrcxKRLtOqV8mt8N2J
         dSn2CzMRD/sBEkftGmHVx7tyLDrW6AFuFYG/OcMPD3xD+mIrXjvAHwU7oYax3cNp8Kmk
         p4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369054; x=1715973854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/eUnTFro7FOl+F47KJAx+RfdI70P4+3XVz5qXeWrmc=;
        b=UDrrO6pKedcJsyf+q+aWs7yEUaVCYWMo/v2hgju71qOfp8q8KkupkkKduIUZFYwjDs
         ufrgtlknB3pmZcgUgC/DUXY+TXxQ6rkcy+yI2GAOSGxmd1ygI0Jscp+okxM/eQbwwg94
         mok26JiQ/jTSOeRAy5YLlZRb2RgPrlQqvAVXmEA4rN5U8m3+IU5r4JHW5yKryeMtumj9
         yuKL5YemkeOdhFL+Ec9ZeiWwzqNxInM59RovPOTCAZTd7XkVU+kViOoJFwSFs2AIulp+
         8WNHR8rmNA7kxljkSHSoVZF40WqzHwHZravsoCzTXRPAi5oI1qJ8M4OCc/wjw+jeIrhG
         msDA==
X-Gm-Message-State: AOJu0YwTzM+fX4hkg4sp2ral8eC1p9TFGTFjGrN2/LchSfFB4AtU6cpD
	05elgDgsmqvPhgYJyxHZNH3MbTZaBeF/MzwwGglU/aX3LxzihXES4dp6mQ==
X-Google-Smtp-Source: AGHT+IGnNScmOZ65W302q1K0zOPI40QQjDHoUWlmFjgDGlbPT4on60Rl7oCFpzcMGkPW++Qai78TpQ==
X-Received: by 2002:a05:6102:1505:b0:47b:cca3:aca0 with SMTP id ada2fe7eead31-48077e1cdd8mr4846723137.18.1715369053523;
        Fri, 10 May 2024 12:24:13 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 00/20] bpf qdisc
Date: Fri, 10 May 2024 19:23:52 +0000
Message-Id: <20240510192412.3297104-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v8 of bpf qdisc patchset. While I would like to do more
testing and performance evaluation, I think posting it now may help
discussions in the upcoming LSF/MM/BPF.

* Overview *

This series supports implementing a qdisc using bpf struct_ops. bpf qdisc
aims to be a flexible and easy-to-use infrastructure that allows users to
quickly experiment with different scheduling algorithms/policies. It only
requires users to implement core qdisc logic using bpf and implements the
mundane part for them. In addition, the ability to easily communicate
between qdisc and other components will also bring new opportunities for
new applications and optimizations.

After discussion in the previous patchset [0], we swicthed to struct_ops
to take the benefit of struct_ops and avoid introducing a new abstraction
to users. In addition, three changes to bpf are introduced to make
bpf qdisc easier to program and performant.

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

* Support adding skb to bpf graph *

Allowing users to enqueue an skb directly to a bpf collection improves
users' programming experience and performance of qdiscs. In the previous
patchset (v7), the user would need to allocate a local object, exchange
an skb kptr into the object and then add the object to a collection during
enqueue. The memory allocation in the fast path was hurting the
performance.

To allow adding skb to collection, we first introduced the support for
adding kernel objects to bpf list and rbtree (patch 5-8). Then, we
introduced exclusive-ownership graph nodes so that 1) we can fit
an rb node into an skb, and 2) make it possible for list node and rb node
to coexist in a union in skb (patch 9-12).

We evaluated the benefit of direct skb queueing by comparing the
throughput of simple fifo qdiscs implemented with v7 and v8 patchset.
Both qdisc use a bpf list as the fifo. The fifo v8 is included in the
selftests. While fifo v7 is identical in terms of the queueing logic,
it requires additional bpf_obj_new() and bpf_kptr_xchg() calls to enqueue
a local object containing a skb kptr. The test uses iperf3 to send and 
receive traffic on the qdisc added to the loopback device for 1 minute,
and we repeated it for five times. The result is shown below:

                                    Average throughput   stdev
fifo with indirect queueing (v7)    40.4 Gbps            0.91 Gbps
fifo with direct queueing (v8)      43.5 Gbps            0.24 Gbps

This part of the patchset (patch 5-12) is less tested and the approach may
be overcomplicated, so I especially would like to gather more feedback
before going further.

* Miscellaneous notes *

Finally, this patchset is based on 
34c58c89feb3 (Merge branch 'gve-ring-size-changes') in net-next.

The fq example in selftests requires bpf support of exchanging kptr into
allocated objects (local kptr), which Dave Marchevsky developed and
sent me as off-list patchset.

Todo:
  - Add more bpf testcases
  - Add testcases for bpf_skb_tc_classify and other qdisc ops
  - Add kfunc access control
  - Add support for statistics
  - Remove the requirement of explicit skb->dev restoration
  - Look into more ops in Qdisc_ops
  - Support updating Qdisc_ops

[0] https://lore.kernel.org/netdev/cover.1705432850.git.amery.hung@bytedance.com/

---
v8: Implement support of bpf qdisc using struct_ops
    Allow struct_ops to acquire referenced kptr via argument
    Allow struct_ops to release and return referenced kptr
    Support enqueuing sk_buff to bpf_rbtree/list
    Move examples from samples to selftests
    Add a classful qdisc selftest

v7: Reference skb using kptr to sk_buff instead of __sk_buff
    Use the new bpf rbtree/link to for skb queues
    Add reset and init programs
    Add a bpf fq qdisc sample
    Add a bpf netem qdisc sample

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

Amery Hung (20):
  bpf: Support passing referenced kptr to struct_ops programs
  selftests/bpf: Test referenced kptr arguments of struct_ops programs
  bpf: Allow struct_ops prog to return referenced kptr
  selftests/bpf: Test returning kptr from struct_ops programs
  bpf: Generate btf_struct_metas for kernel BTF
  bpf: Recognize kernel types as graph values
  bpf: Allow adding kernel objects to collections
  selftests/bpf: Test adding kernel object to bpf graph
  bpf: Find special BTF fields in union
  bpf: Introduce exclusive-ownership list and rbtree nodes
  bpf: Allow adding exclusive nodes to bpf list and rbtree
  selftests/bpf: Modify linked_list tests to work with macro-ified
    removes
  bpf: net_sched: Support implementation of Qdisc_ops in bpf
  bpf: net_sched: Add bpf qdisc kfuncs
  bpf: net_sched: Allow more optional methods in Qdisc_ops
  libbpf: Support creating and destroying qdisc
  selftests: Add a basic fifo qdisc test
  selftests: Add a bpf fq qdisc to selftest
  selftests: Add a bpf netem qdisc to selftest
  selftests: Add a prio bpf qdisc

 include/linux/bpf.h                           |  30 +-
 include/linux/bpf_verifier.h                  |   8 +-
 include/linux/btf.h                           |   5 +-
 include/linux/rbtree_types.h                  |   4 +
 include/linux/skbuff.h                        |   2 +
 include/linux/types.h                         |   4 +
 include/net/sch_generic.h                     |   8 +
 kernel/bpf/bpf_struct_ops.c                   |  17 +-
 kernel/bpf/btf.c                              | 255 +++++-
 kernel/bpf/helpers.c                          |  63 +-
 kernel/bpf/syscall.c                          |  22 +-
 kernel/bpf/verifier.c                         | 185 +++-
 net/sched/Makefile                            |   4 +
 net/sched/bpf_qdisc.c                         | 788 ++++++++++++++++++
 net/sched/sch_api.c                           |  19 +-
 net/sched/sch_generic.c                       |  11 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  59 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  29 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  11 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 259 ++++++
 .../selftests/bpf/prog_tests/linked_list.c    |   6 +-
 .../prog_tests/test_struct_ops_kptr_return.c  |  87 ++
 .../prog_tests/test_struct_ops_ref_acquire.c  |  58 ++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  23 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  83 ++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 660 +++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_netem.c     | 236 ++++++
 .../selftests/bpf/progs/bpf_qdisc_prio.c      | 112 +++
 .../testing/selftests/bpf/progs/linked_list.c |  15 +
 .../testing/selftests/bpf/progs/linked_list.h |   8 +
 .../selftests/bpf/progs/linked_list_fail.c    |  46 +-
 .../bpf/progs/struct_ops_kptr_return.c        |  24 +
 ...uct_ops_kptr_return_fail__invalid_scalar.c |  24 +
 .../struct_ops_kptr_return_fail__local_kptr.c |  30 +
 ...uct_ops_kptr_return_fail__nonzero_offset.c |  23 +
 .../struct_ops_kptr_return_fail__wrong_type.c |  28 +
 .../bpf/progs/struct_ops_ref_acquire.c        |  27 +
 .../progs/struct_ops_ref_acquire_dup_ref.c    |  24 +
 .../progs/struct_ops_ref_acquire_ref_leak.c   |  19 +
 41 files changed, 3216 insertions(+), 125 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_ref_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_netem.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_prio.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_dup_ref.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_ref_leak.c

-- 
2.20.1


