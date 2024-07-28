Return-Path: <bpf+bounces-35821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47893E372
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 05:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767BD281881
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00A42570;
	Sun, 28 Jul 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLBTSeBB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D50A32
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722135704; cv=none; b=Dh91DypVDcC5657KftiaMh+ESjXBpf6yA1f+BdMz0iV7xYTpjsVWP/RfrC06nFq/hx+NY5rqzps4yW6tlv+wxcSlKWOt7DoCTRNiZEqL5lK5IMzulHZ8BjM64+L9G3JqNimsqng6KuLzUt8sZr1SeBcNjhRqIyJYG84tMZc62f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722135704; c=relaxed/simple;
	bh=iKPDF0ZXMociLR/l2q1TsINKUudfuPQlPOBJwRTpOvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KZlavbwBgyEHFdRtw9RLL+N9g8hgzWpkccgUxBnVS1mk4oEKdAICV9P+xffXqooi2yVr72FH1Lkg/YNxV6ghHvMZazFW4sKYLSlqYJqyO82v1gFlF5+zTMWRPXzHXFz26g0PcmbesG+BM/5sAWsQjgPHLriEw9/yJp5ndeFDU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLBTSeBB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d984ed52so124825185a.0
        for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 20:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722135701; x=1722740501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWDh8cr2pKjNl5vEE738rce8qh6uBDiNuIINOokIqz4=;
        b=DLBTSeBBPjW0GKGEOw+TGTGDX0Z9y/NdqXeBqXLESA0a1hcHpIo/fEq5pUdvCh5Tw2
         Whoc4kk/c+U2WgZihG5HTj/VKizZPB34gx3zeX4E0cuqUbyobHBczjF/EUsEM64qYkpn
         5R3V4N+0lZPi741WMcuCc465W24tpe0zME50ZpdsTXgAzzXL40JRxYV/zwa598qiFs3W
         6Y+GGd4kNBzkUH1aWObOn3TMhSgsXa5B/F154eQZUQqSnlo+BaIIRFXmuAj2X3bt7Xzm
         QB+OUwfQBqv/jCh34XBs/N/WPcnr1MH9Gmvv9JPSlfvGeFhdJUc938b2xCBFhJrl1rvF
         YsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722135701; x=1722740501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWDh8cr2pKjNl5vEE738rce8qh6uBDiNuIINOokIqz4=;
        b=ORE4MhKXHhQuMFFg5heU1D683flOi94r6Ox7l6EcrvunW5gPLpln2mxMkA+tECh7Q2
         pTlW1NmieKb7ujBLlzklFvWOPzBNkCQZI8uopHZxohhbr0I5U49z8An/jkVrx/W/4swo
         dwTLqxIrBgipOdIRTF0nWEjQrCM3w0wmaaCPSFBJhRmz+8+meVS7focpzrhlhB+mIKDO
         a2DZooGI2gEf7xEal9k6+Vc4i3Uh4RUftt3gpLxLwURAQix0WHwqCGEbR22RUX2o7GMX
         4tIUBI3Jl/7edqlARfmQKyZyyrj0JZ0N+Xl2jFl9vviAgoDqijVbOk7NjFqNaFa7Lgbt
         DohA==
X-Gm-Message-State: AOJu0YzKMeWGqN6m3u64AAmHB1s7vSBeopBF2o/OvHY9A5uYy0WwjHJ4
	7foymiJ+B8/9ZspWqNjnPMm98gISz86QVQt2F6CDcpTDK7d0I1xBd86FdQ==
X-Google-Smtp-Source: AGHT+IF5ZXj1rbPX4xe7KxAIJ3AX1FbrbnZ0IVMcKhbxcZBU4qdP1fG/ES1glOVx6/O6Im07lsmKtg==
X-Received: by 2002:a05:6214:2629:b0:6b5:e58a:6397 with SMTP id 6a1803df08f44-6bb55aa8b38mr45966136d6.35.1722135701588;
        Sat, 27 Jul 2024 20:01:41 -0700 (PDT)
Received: from n36-183-057.byted.org ([139.177.233.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f90e7b9sm37953306d6.52.2024.07.27.20.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 20:01:41 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 0/4] Support bpf_kptr_xchg into local kptr
Date: Sun, 28 Jul 2024 03:01:11 +0000
Message-Id: <20240728030115.3970543-1-amery.hung@bytedance.com>
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

Dave Marchevsky (4):
  bpf: Search for kptrs in prog BTF structs
  bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
  bpf: Support bpf_kptr_xchg into local kptr
  selftests/bpf: Test bpf_kptr_xchg stashing into local kptr

 include/linux/bpf.h                           |  2 +-
 kernel/bpf/btf.c                              |  6 ++-
 kernel/bpf/helpers.c                          |  2 +-
 kernel/bpf/verifier.c                         | 47 ++++++++++++-------
 .../selftests/bpf/progs/local_kptr_stash.c    | 22 ++++++++-
 5 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.20.1


