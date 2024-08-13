Return-Path: <bpf+bounces-37105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62821950F1D
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769E31C21A4F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF51A76D2;
	Tue, 13 Aug 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kK7XWxql"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049341EA84
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584273; cv=none; b=sjbxXZVaS+Q3jCTmGFMx44n1R9Zw12T53NWJ2MAZqZ6DsZJuecnkMoVl5ZEem9P9cz0AFJuyO1uc0QfUlayojaVRcapuEVpIGjZqjZsCwAD68pFZ76Bi/5AR7By0CavVTkWDaIkrvNlLpbRlgWdy/j5G0Sa+Il5pQe6By1js10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584273; c=relaxed/simple;
	bh=U+ltYSW3H03KoEl1hquEUS1LfizJjnCAHXceoieQ94U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sL0AroiWR0J0EcxZpd+siznrsl8+zITMDlkww3wVQjWrAdgSbT798jQl+g2hsrNo5/Yd8CZVyzwHsLecIO+BcbGVdBqT/3/ZHp+DVnfki6MO0nCPfuycI//zIY0JDQUDk6PJbASm6L+YvYkA9GUn5pS6qEUiiYfJYxMK/lNir5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kK7XWxql; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4928da539c3so1543556137.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723584271; x=1724189071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gGfAmJiiu/Ygvqq8YyYkfJMoa4IB1eMVEEILxfXTAg=;
        b=kK7XWxql/MkkoUgEAXk70fc2r9Hd8JPm7t8te7CZeufUOWd7gKPz/zZSdPzrB0R4pR
         CeaXt77Z9fRDnPqOkJXUJRWPOIJiFcF4kYrymIZJ0L9L9sUrRn2gwClcjjiyIUjD5bBT
         PXYqZvj75wdlrsgACsAbZLwdX1FgSNbcoUZU17mXldpdehRMcR3UcrGJhWxEIiPnK2pJ
         6eev/BhjJNw5lIOLVNA54GvtCzKGvJsS+UdL/55NDhiMP0NOIJgBri8IFhheYxL0WaZW
         QJpZknJkU4rF2nr0DNRZ3oirfL1sMPRjB/kbfu8PuvQu6UY7a2bUgTyKbwQMiez8ifLI
         Qusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723584271; x=1724189071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gGfAmJiiu/Ygvqq8YyYkfJMoa4IB1eMVEEILxfXTAg=;
        b=GcK4dF/eCWuA/u7Kizb/ScIY2rZV7Qe0Rs3us+4v9oBoUkDuR+Oe4PiQZ3Xj3foBow
         iw/WDOnVyErlrZF9nrElQzqQ3ou4ad4qXSoyECFovfrTSaMFnQLOrRJIV4ZvOt4vORPP
         8Jw+enEkXpXGj9WIgnAL3yOzyxZM3YEs7whil0PC8AGv8LGTZ2PwT2EkU57BId9H7eFA
         shSQL+cUcXgihKsiC/CWTXT77aKUkW7OaID8C3OO3EkrapjJBUjmKr/Sx+AnAEmsHdaJ
         QCB/GrPglkqvqOPY565fG6MdNKv7CguyiUeW2Rc/M/2j+MlWUMJ9DtFxOgMW7xY2Kno/
         +uig==
X-Gm-Message-State: AOJu0Yx5/kaBF9sEBa48UfgJ6nU9nLc9aC70vvkZfZQPDZAls43diHPV
	je30dN0ibuWrrFE2yEBvljAUNr9vbuX8l6rgJLopXPWhurT+cbJunLYep/X59IyTP5fC8b2pwiS
	z6f4=
X-Google-Smtp-Source: AGHT+IE2289RsK4LPS1pgGQ2bLLMgmlrpYXA9+uxn0hiaTGvWsO3QB6ai7UttkdJ9knhoXl3zjkEyg==
X-Received: by 2002:a05:6102:2ad3:b0:493:c767:3fe2 with SMTP id ada2fe7eead31-497598ab3ccmr1224689137.1.1723584270723;
        Tue, 13 Aug 2024 14:24:30 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf432fb61dsm21390786d6.52.2024.08.13.14.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:24:30 -0700 (PDT)
From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v4 bpf-next 0/5] Support bpf_kptr_xchg into local kptr
Date: Tue, 13 Aug 2024 21:24:19 +0000
Message-Id: <20240813212424.2871455-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision adds substaintial changes to patch 2 to support structures
with kptr as the only special btf type. The test is split into
local_kptr_stash and task_kfunc_success to remove dependencies on
bpf_testmod that would break veristat results.

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
v3 -> v4
  - Allow struct in prog btf w/ kptr as the only special field type
  - Split tests of stashing referenced kptr and local kptr
  - v3: https://lore.kernel.org/bpf/20240809005131.3916464-1-amery.hung@bytedance.com/

v2 -> v3
  - Fix prog btf memory leak
  - Test stashing kptr in prog btf
  - Test unstashing kptrs after stashing into local kptrs
  - v2: https://lore.kernel.org/bpf/20240803001145.635887-1-amery.hung@bytedance.com/

v1 -> v2
  - Fix the document for bpf_kptr_xchg()
  - Add a comment explaining changes in the verifier
  - v1: https://lore.kernel.org/bpf/20240728030115.3970543-1-amery.hung@bytedance.com/

Amery Hung (1):
  bpf: Let callers of btf_parse_kptr() track life cycle of prog btf

Dave Marchevsky (4):
  bpf: Search for kptrs in prog BTF structs
  bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
  bpf: Support bpf_kptr_xchg into local kptr
  selftests/bpf: Test bpf_kptr_xchg stashing into local kptr

 include/linux/bpf.h                           |  2 +-
 include/uapi/linux/bpf.h                      |  9 +--
 kernel/bpf/btf.c                              | 72 ++++++++++++++-----
 kernel/bpf/helpers.c                          |  6 +-
 kernel/bpf/syscall.c                          |  6 +-
 kernel/bpf/verifier.c                         | 48 ++++++++-----
 .../selftests/bpf/progs/local_kptr_stash.c    | 30 +++++++-
 .../selftests/bpf/progs/task_kfunc_success.c  | 26 ++++++-
 8 files changed, 151 insertions(+), 48 deletions(-)

-- 
2.20.1


