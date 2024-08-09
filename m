Return-Path: <bpf+bounces-36738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4494C7C8
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7017F1C22AF2
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87584C8E;
	Fri,  9 Aug 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR9QpP/n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A242581
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164707; cv=none; b=tBz1pL84v0pcRrT7kWlUx75zxL3bjL4oKsbz/1H8NxOZTHe/GagziLw3o6yJNSmlDbHDYJfocgazSLkMHKFr+nfORgIwqCguw5tmkZ6wON+XZVCCIUxseptu5td68gDDIAlym5ooh3ptKHRXGWbEMUcmkQpnrbkT+/Tq14ByA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164707; c=relaxed/simple;
	bh=bV8a2GQFTW6ayUlVe4K2+Ks2qV9I2feDWorWFHOgQmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MWAcAqTyVBlddD9UnQLB4iV/3/MKIKc4V6gjJctO0IxdMPrJBgmBKQIXWEpkxOi+wHED3R38pyFDPak7q6xuQXOrj2XWyBxPrgFauizCtUQeubTiFG2JjVIQvNIORZ3BADDB1t3Qg7yTzRdg1fu4XvVgbF1VEeOsfzDqfhRWy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR9QpP/n; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b79c969329so8067216d6.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 17:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164705; x=1723769505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zu1vsD7RS5L+zKpf4q7+WicdA25CeQmUGOTzBKFVzs=;
        b=JR9QpP/nQAknjoPMGlOAyYgVLjbHUUnWnmLVsNiFLUc4v2KBQlRLrKUqaX9vITeecx
         jEhrwfBrf8jNqxvphiKwceCa24pGgE2vqD6tRkbf/J6OHQ4T1s3zFqkZR7ttzpOjcR6X
         4prl0LkjQY73YR4FT72odO4UO2T3ros9JT9LOtj8TlbfHfHe+K9GKJRySyrBGFeB9T/g
         l2wSa7zAA/daka/OdJI8lsVdh4TwxcAMJDnMVvdPN4b9BiG9Kn1l9ZhKqazG+vBKIrzO
         5IhJfZ8//S4PM1mSk3olOfGg214VL+/mXoaLjPlDIJLFXafJwoYRLMo/6Aj9SEFAoebU
         XLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164705; x=1723769505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zu1vsD7RS5L+zKpf4q7+WicdA25CeQmUGOTzBKFVzs=;
        b=t2ySpRjzCOaXmDe3yPPyo7e2+u4AHk3M17GxskWeHQttwyZ10A59301A7HZxnxXBot
         5sMkA+LDxWda/j93ARBh4blj4CELvJfrB+9iMRGXHcD8lN4IiubMqT1pkBB2dXrALqd6
         etp1fQVym0AbD6Hd+xoagv4OHzoE73U8jus+Dqn9VZwMkGluo9SPc6GprmxSbmkXFnhL
         5zJR3yaNHzohGM4j6meYzjocMJ0OqdjK8Vu9ManWMm9CGhCuORZpk3t7zCv+xILAzC+1
         qBjYJGLuzIKnsXrFgDAA08VQwXZ1OAScPCq5YLJVTNq3WRD7nY2xt+RQ4XGtaZ5cXN/r
         o2MQ==
X-Gm-Message-State: AOJu0Yw/OOwoI+exfSPaRkUyTbt8EbCXWD7V9vLsQeGwXGI7WZ5/720D
	jJezGFk9PoIU8qqnszPzqnEvaqXVjTjrDdaUKwoHIkDy9JARuoa0NKxiNw==
X-Google-Smtp-Source: AGHT+IHlFOJHKeE2i1wmAwe3PZ3G8qTn8YLAGut5x3b6aXIAS0tG9eUZQCAdVIQ6V8+ko1dG/AiZXQ==
X-Received: by 2002:a05:6214:5904:b0:6b5:9439:f048 with SMTP id 6a1803df08f44-6bd78d3f60amr73426d6.19.1723164704566;
        Thu, 08 Aug 2024 17:51:44 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797dbdsm71485826d6.52.2024.08.08.17.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:51:44 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
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
Subject: [PATCH v3 bpf-next 0/5] Support bpf_kptr_xchg into local kptr
Date: Fri,  9 Aug 2024 00:51:26 +0000
Message-Id: <20240809005131.3916464-1-amery.hung@bytedance.com>
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
 kernel/bpf/btf.c                              |  5 +-
 kernel/bpf/helpers.c                          |  6 +-
 kernel/bpf/syscall.c                          |  6 +-
 kernel/bpf/verifier.c                         | 48 ++++++++++-----
 .../selftests/bpf/progs/local_kptr_stash.c    | 58 ++++++++++++++++++-
 7 files changed, 104 insertions(+), 30 deletions(-)

-- 
2.20.1


