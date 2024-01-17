Return-Path: <bpf+bounces-19750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87056830EDB
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA641B22F8A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7642562F;
	Wed, 17 Jan 2024 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCiixpDg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723F2557B;
	Wed, 17 Jan 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528588; cv=none; b=ux7jcIlXTvW9xABP189BEtMY474YStJsysC8HkXL9UohhrdUZf8sEN97SYFkptghnm1oxz+hFeB0fLJHXXMKM5T5t8IYCfsO8YamNWxzgLC0QzgF4YSmh4bGQdpV4krthRS6+h1QAL2g6Be/pQI9oZdJOIaXsCFjvrOsQXR21Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528588; c=relaxed/simple;
	bh=b3tZBvwiO15MNJEYdh4IGMwI4un79O2LiLeKkHNVX5c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=DUILYaa2N98aYuc+tHu7LrhAEOq4wHDgwdDtujSprbOeeqfs+xnPNIjY85LZ2iyNPjhLJjJ9qBwja3TK0UxDDUM8CusOenrN83gJ15VmZ5zwLbRxPCe8vTGC9XbBRGTp00PM6KeZQ7ll3Tp/Q8wrFJ9ZNFkS6bNPsnbJqs3ncFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCiixpDg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc83674972so6178753a34.1;
        Wed, 17 Jan 2024 13:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528585; x=1706133385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lg+UaN5yPRzDNhsjWhqTdsIfiRjvGl1dWaIFc3mxXQ=;
        b=UCiixpDgJ7AwyygOV1/+MnyXb8lx89UceCyTfCfTZYZO5noWvjuD4iqgKYKezAhffA
         y5KS53jwr00tf3QM6n3sLCdo+5MFn+N0vw1tMqLl5mZX9k6PwNOEJgm1xA45lW1eHhbF
         PmGO3YJiLZR9Htpe9v/MPKpd0N3qdYQS42NjfpEfy96uyeWp6ZYdDC8+78FeqIIyU2gu
         D6bhfA48K+5ji0gckNmXxO8Le3iNJah4btVgGikeHxiOLFY5e1lhi16+OllJCjocx5e7
         oaah8mXzi/W2H3NrY0YTotZBPuz79tb0mcqyzVu75sj/fcVPrjuU3HRtoWr4NRR2g5bD
         +YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528585; x=1706133385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lg+UaN5yPRzDNhsjWhqTdsIfiRjvGl1dWaIFc3mxXQ=;
        b=bG4ui2Nom9sn2q27v4cn2iKw68j7wajTS2EBk+JqP16UWHazs3GJ5YQDspW6wc8Ij3
         Ml0V6nP9g/GhGPRc0LZ73OP/K3r8i2JHmeLwgyHKGId5Z3waCg1B8+K1dyhvSCXwNywf
         /WaP/xF8j3vX1cxxheVl6iQfjDj8ni2A25POOsucKhQTQY3hi4o5b/RdxF9MDDQshWbw
         QJ8w66YGHZeN6dI8s9x9kwLNjdmDXpxd2zp2MFL1W4AzZTWnud69gDGBTNhxwILv2MKO
         i/ccg9mQd6UC7LopDKbaCkQrRhD4SPJ2dIYDlWfq1xXnfHHZp1vQjJ4f5Xz3CQJeoBu8
         1uNQ==
X-Gm-Message-State: AOJu0YwZhteN/3icTOjDD2QhaOdHdO0ctNYKhTwa3UvviMyfAMxhjULQ
	9LQrftMo5nrHWMFuCaJ7qvMuN33LhgA=
X-Google-Smtp-Source: AGHT+IEPqpMDwXPM5AnFM3hazGD97M/j9k2uCXhvv/07xtOeB+VP9DunkmqV83Kle9USLzyO8xd+Bg==
X-Received: by 2002:a9d:7d8a:0:b0:6dd:e29d:dbf6 with SMTP id j10-20020a9d7d8a000000b006dde29ddbf6mr7581601otn.16.1705528585670;
        Wed, 17 Jan 2024 13:56:25 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:25 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com
Subject: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
Date: Wed, 17 Jan 2024 21:56:16 +0000
Message-Id: <cover.1705432850.git.amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, 

I am continuing the work of ebpf-based Qdisc based on Cong’s previous
RFC. The followings are some use cases of eBPF Qdisc:

1. Allow customizing Qdiscs in an easier way. So that people don't
   have to write a complete Qdisc kernel module just to experiment
   some new queuing theory.

2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
   is before enqueue, it is impossible to adjust those "tokens" after
   packets get dropped in enqueue. With eBPF Qdisc, it is easy to
   be solved with a shared map between clsact and sch_bpf.

3. Replace qevents, as now the user gains much more control over the
   skb and queues.

4. Provide a new way to reuse TC filters. Currently TC relies on filter
   chain and block to reuse the TC filters, but they are too complicated
   to understand. With eBPF helper bpf_skb_tc_classify(), we can invoke
   TC filters on _any_ Qdisc (even on a different netdev) to do the
   classification.

5. Potentially pave a way for ingress to queue packets, although
   current implementation is still only for egress.

I’ve combed through previous comments and appreciated the feedbacks.
Some major changes in this RFC is the use of kptr to skb to maintain
the validility of skb during its lifetime in the Qdisc, dropping rbtree
maps, and the inclusion of two examples. 

Some questions for discussion:

1. We now pass a trusted kptr of sk_buff to the program instead of
   __sk_buff. This makes most helpers using __sk_buff incompatible
   with eBPF qdisc. An alternative is to still use __sk_buff in the
   context and use bpf_cast_to_kern_ctx() to acquire the kptr. However,
   this can only be applied to enqueue program, since in dequeue program
   skbs do not come from ctx but kptrs exchanged out of maps (i.e., there
   is no __sk_buff). Any suggestion for making skb kptr and helper
   functions compatible?

2. The current patchset uses netlink. Do we also want to use bpf_link
   for attachment?

3. People have suggested struct_ops. We chose not to use struct_ops since
   users might want to create multiple bpf qdiscs with different
   implementations. Current struct_ops attachment model does not seem
   to support replacing only functions of a specific instance of a module,
   but I might be wrong.

Todo:
  - Add selftest

  - Make bpf list/rbtree use list/rbnode in skb so that developers
    don't need to allocate bpf objects for storing skb kptrs.

Note:
  - This patchset requires bpf support of exchanging kptr into allocated
    objects (local kptr), which Dave Marchevsky is working on.

  - The user space programs in the sample are adapted from the example
    Peihao Yang written in RFC v5 thread.

---
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

Amery Hung (5):
  net_sched: Add reset program
  net_sched: Add init program
  tools/libbpf: Add support for BPF_PROG_TYPE_QDISC
  samples/bpf: Add an example of bpf fq qdisc
  samples/bpf: Add an example of bpf netem qdisc

Cong Wang (3):
  net_sched: Introduce eBPF based Qdisc
  net_sched: Add kfuncs for working with skb
  net_sched: Introduce kfunc bpf_skb_tc_classify()

 include/linux/bpf_types.h       |   4 +
 include/uapi/linux/bpf.h        |  23 +
 include/uapi/linux/pkt_sched.h  |  24 ++
 kernel/bpf/btf.c                |   5 +
 kernel/bpf/helpers.c            |   1 +
 kernel/bpf/syscall.c            |  10 +
 net/core/filter.c               | 100 +++++
 net/sched/Kconfig               |  15 +
 net/sched/Makefile              |   1 +
 net/sched/sch_bpf.c             | 729 ++++++++++++++++++++++++++++++++
 samples/bpf/Makefile            |  14 +-
 samples/bpf/bpf_experimental.h  | 134 ++++++
 samples/bpf/tc_clsact_edt.bpf.c | 103 +++++
 samples/bpf/tc_sch_fq.bpf.c     | 666 +++++++++++++++++++++++++++++
 samples/bpf/tc_sch_fq.c         | 321 ++++++++++++++
 samples/bpf/tc_sch_netem.bpf.c  | 256 +++++++++++
 samples/bpf/tc_sch_netem.c      | 347 +++++++++++++++
 tools/include/uapi/linux/bpf.h  |  23 +
 tools/lib/bpf/libbpf.c          |   4 +
 19 files changed, 2779 insertions(+), 1 deletion(-)
 create mode 100644 net/sched/sch_bpf.c
 create mode 100644 samples/bpf/bpf_experimental.h
 create mode 100644 samples/bpf/tc_clsact_edt.bpf.c
 create mode 100644 samples/bpf/tc_sch_fq.bpf.c
 create mode 100644 samples/bpf/tc_sch_fq.c
 create mode 100644 samples/bpf/tc_sch_netem.bpf.c
 create mode 100644 samples/bpf/tc_sch_netem.c

-- 
2.20.1


