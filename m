Return-Path: <bpf+bounces-36329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210E946664
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 02:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABAD1C21035
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD881E;
	Sat,  3 Aug 2024 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI1Fiu0A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BC182
	for <bpf@vger.kernel.org>; Sat,  3 Aug 2024 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643917; cv=none; b=QrKpNnZ8kq4Hq4/z3okZPei99tFmF5yjrKR4GmSEF6+2aiV3TrwVf6djG6sbmwqcWlsLUeccvkKfhIWYeo+JX6WtREJ6kOqt6umj4pXERBhgewciv5gIZE1GxI8gGh2JhILDIh4xPIFGJyhNMHFj7VCArVo0EsPhGKbNmq6KSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643917; c=relaxed/simple;
	bh=5XuilwryXjyCMz91pJLJAyzaJAyFyn9APpiMwvha59A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eGr9qSfz88zhZv5nxEtp4npBlP1HnsEvfPcDgjOVUwi6i4CwDx5DEMfcPyi8SLkUYEWUldEpX6MFzw0a8ogOqsTUbm97rpbtVsCcW5Q6gVnGu/KnXvWPx6q77FV959emQBzR8T0Fyk853yzt6DbCimI6aoScAUH6kORV2QQ305w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI1Fiu0A; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a3574acafeso44423285a.1
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722643914; x=1723248714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHdww+66nrR5odQ3SFUmZX0qXTFCruD+vAP35MzFrzY=;
        b=FI1Fiu0AQ92s4HItLhvMZl4P7Sp4IPG8ea68bMqeJVHZVTNwwjsV8HDzX1+gXjlCkG
         99eSjLxKqzIy7XRIFMast4feFvxq+UuLud0m8WQTOzyPCARsuMgVvFJlkVtJurHlqnAu
         15BeyrN8UwU4IiRnnfUnMcN2TJ6CjI7Z+dUrcQpGs0X2KOnlIbe8OMW7RKqX/CYH5T2i
         P3ayxEnICjJ4iSPx2MRWqJF0wKB/EgIT1JfqDGhUAcWGEWhcySrNdP7353Qk7iVMuCcd
         AHWV722xRTRxFRIoSecR4bct5KIhdgr+D7vdfMmSs68ebnvkxZu5kk7KQTPDmMUiELXa
         z9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722643914; x=1723248714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHdww+66nrR5odQ3SFUmZX0qXTFCruD+vAP35MzFrzY=;
        b=FbjzG3otlNe49UXsrfI7T3lzLlQCJrYiIqOZOyf4hhXHLkor14OLHhbmdwDsu7UX51
         ipKZKrQI5IYNLurm7Gco/rIeSgEoEQRUcm2z76Lr5dKn0FuuRFJ83MVAlVD4mbaRVtkk
         4p9S/ZKWSpH0B5uo7H/oyz+myLam4htnkzOW5UT0kLOZxuVhsTrafA47UndK6n/6uJXH
         a9dJ1Q4ZVls2KHSg5URKgQIztKu9myFy2qoZFniLv/FrwFOSCIcqiTmg3MfswWYL5njV
         agJAR2oR4tFnFojYFFWjjr+P1/UGn3qiLsEc5h5EAz2NqO4MrXGg9CQP2uJVi4kscP2G
         T7KA==
X-Gm-Message-State: AOJu0Yw7R3b9uiWAGRvGyhKFWr0IlVTZJK4ZK8hPRatGG3plDgNbHg5p
	pJw2+sBEacmLaD6IZtEQ9SyYR0ZjJso/i0bId+zMYLqKKUQu4nI/eLPAOg==
X-Google-Smtp-Source: AGHT+IEg30ibyPlnDL0xAWpydlkFeJPjDHqNp0rhRX8YuEcAzecwFMBvuxzT1hORPrjgVNt+0n97sg==
X-Received: by 2002:a05:620a:40d6:b0:7a2:e11:9e9d with SMTP id af79cd13be357-7a34efd7d8cmr666826685a.50.1722643914255;
        Fri, 02 Aug 2024 17:11:54 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dce75sm129547485a.14.2024.08.02.17.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:11:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v2 bpf-next 0/4] Support bpf_kptr_xchg into local kptr
Date: Sat,  3 Aug 2024 00:11:41 +0000
Message-Id: <20240803001145.635887-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series allows stashing kptr into local kptr. Currently, kptrs are
only allowed to be stashed into map value with bpf_kptr_xchg(). A
motivating use case of this series is to enable adding referenced kptr to
bpf_rbtree or bpf_list by using allocated object as graph node and the
storage of referenced kptr. For example, a bpf qdisc [0] enqueuing a
referenced kptr to a struct sk_buff* to a bpf_list serving as a fifo:

    struct skb_node {
            struct sk_buff __kptr *skb;
            struct bpf_list_node node;
    };

    private(A) struct bpf_spin_lock fifo_lock;
    private(A) struct bpf_list_head fifo __contains(skb_node, node);

    /* In Qdisc_ops.enqueue */
    struct skb_node *skbn;

    skbn = bpf_obj_new(typeof(*skbn));
    if (!skbn)
        goto drop;

    /* skb is a referenced kptr to struct sk_buff acquired earilier
     * but not shown in this code snippet.
     */
    skb = bpf_kptr_xchg(&skbn->skb, skb);
    if (skb)
        /* should not happen; do something below releasing skb to
         * satisfy the verifier */
    	...
    
    bpf_spin_lock(&fifo_lock);
    bpf_list_push_back(&fifo, &skbn->node);
    bpf_spin_unlock(&fifo_lock);

The implementation first searches for BPF_KPTR when generating program
BTF. Then, we teach the verifier that the detination argument of
bpf_kptr_xchg() can be local kptr, and use the btf_record in program BTF
to check against the source argument.

This series is mostly developed by Dave, who kindly helped and sent me
the patchset. The selftests in bpf qdisc (WIP) relies on this series to
work.

[0] https://lore.kernel.org/netdev/20240714175130.4051012-10-amery.hung@bytedance.com/

---
v1 -> v2
  - Fix the document for bpf_kptr_xchg()
  - Add a comment explaining changes in the verifier
  - v1: https://lore.kernel.org/bpf/20240728030115.3970543-1-amery.hung@bytedance.com/

Dave Marchevsky (4):
  bpf: Search for kptrs in prog BTF structs
  bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
  bpf: Support bpf_kptr_xchg into local kptr
  selftests/bpf: Test bpf_kptr_xchg stashing into local kptr

 include/linux/bpf.h                           |  2 +-
 include/uapi/linux/bpf.h                      |  9 ++--
 kernel/bpf/btf.c                              |  6 ++-
 kernel/bpf/helpers.c                          |  6 +--
 kernel/bpf/verifier.c                         | 48 ++++++++++++-------
 .../selftests/bpf/progs/local_kptr_stash.c    | 22 ++++++++-
 6 files changed, 65 insertions(+), 28 deletions(-)

-- 
2.20.1


