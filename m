Return-Path: <bpf+bounces-69008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2566CB8B9A9
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9336F586B5F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB602D3740;
	Fri, 19 Sep 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekGm6keo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E821FF5E3
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323395; cv=none; b=Bz9zOZ0w0ECn+HQ/pMzbTguOB7UXI665JivU6vj3uEvcmir/ZRqHJkmUdvx16nliq32BdQaJM7ACrv9mFqqwecz4C2K1lR/NqpEImlJdrGXGbViJ1Ja9ye2fH2UVRq/gIOUcl2Hv22oVusTqMdNC/mq74MEsKsDE1CqIrgna2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323395; c=relaxed/simple;
	bh=HY9tKDOUJ7QjRHaaoRji1oijbaIozebjreGllM14yTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouxnsiklvdlobnBcDkZNv1+vjKU6ruMMghtjeF+kBQov1xC4qGwIH1bne7Xn8lvLJBFL06m6iaq7qVuWYzSK4MpYlAIwOPFV0PRreXQTxWl3E9pHo2MwZJqxB3S/wbJi941Bf5z2laNVLbVREJd4bMsww/sMr0MpDyGS2/Jlwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekGm6keo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54dd647edcso2472574a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323393; x=1758928193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/L7k1EaQS0ZD0+t3qmhtzo/Q2KAQtQIeCgBHKEa6ORk=;
        b=ekGm6keo99H3fOSY1H8Ls+gyC2Om+SMR8daEx3Hyxk+BB1oWYlglHDTnsLR0mJJHKN
         IdG4HMVdZg3RMzWe+/jgRf4NiJKkZ2CE5rKDvhxow20wPPbwVOi1+35toWFnn8JmoE6h
         Gb8wpPcFd1AW2FPr7rfS4Wcq1SrLbiJtKTbPzO7qC/Ue8h3QsMR1MLRuCW+4ZMThWOQ7
         X8NqP4WT0qw2DCPhw6xA2ahlg1q3IFBaYv/zwDd3vT9wehZ4Ll3vDWeAgktGjm1Ii/ZK
         a69dN7WNWYfFNLOZ5lniBq01CvNAQ62lohav8+bjNxG7CcPo3EZc2HN7KzmCOZI5W5sU
         wONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323393; x=1758928193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/L7k1EaQS0ZD0+t3qmhtzo/Q2KAQtQIeCgBHKEa6ORk=;
        b=MVXZJMWBxpERcRPVM+eKOvRz1/r9dq3geB+st1mdkWMxLCpzxYNK42ib+Z6InGwiF7
         +paggVmGh53wGD5nfDCt9+RH6YCEaj+T8J2rYgzDzUo1IOuqDO4h39pT1nFrGPqBLElT
         lZCGwAFa7P8fuibkElFzYBmZ6yZ8prh+jhL64491mnG2T5a51/7VNlfULtpqqIgevnbX
         4rk3OOWqb+wj+WfGa2UCvuYoG4mAkoRp8ORNgyI4GoxN9wq5zOHjd6wDvC9TZo+63mMV
         gl/WsjPd0qtODfSYSZ1pmzqTeUO+PYZgV4KjnQb21udJl+6l+LIC4Gh/F196rZAcFkOv
         at/Q==
X-Gm-Message-State: AOJu0YwGdhPZe4io9oCUtqviXHmJyJOu2A2f9Ycmo7ZuXUwfSTrPQbS3
	THP1VJpXwKIXuslpvNXb+CsXC2/FcysPlpuf6jl7maPmHdxiERxYMuwgsSWZCA==
X-Gm-Gg: ASbGncvT3dkL3zO5aECUtkztIvnXcLoMxGSL6Mdmb5a/YpyFvbq96kZjn/pRebxSbG1
	4tFzJYTjvPqwUZioF8dlGprCvVrGaRtX98SX2PRlI2A/5dvMcfp0pUrfxcrRM2TZkKnG5NVNpW6
	BQZRHFRQ3j6Weg1sqE3gZ2ip5D95T2SjshidaZV123P+7PDZctB5b0bGSI9wtJfvdmcDr2KvFs1
	nnX2Rk6ZfVKoHfFuGb4120NWZV3ayRtLuP2s9jNVzH1v1ZM3BQ1ji4kxnx6aWG0ZFwsbKt3n5tP
	5CDpBllhc5BaeEMJ06CAsRbPUZZjR96UaCsIGnNJE2EC8r+nMsQjwDoJUZhIFn4i7pLJzuxTbxP
	SqXi+EdF2a7YKn7oYGumGKcM=
X-Google-Smtp-Source: AGHT+IFLpeOrj/nM+g1tMb8cPBc/YjoloBZYqdtW8eereIYIr/KyYHj23arg+PRGEX534VD6XTHt5A==
X-Received: by 2002:a17:902:db10:b0:266:272b:7277 with SMTP id d9443c01a7336-269ba58f44bmr78810725ad.59.1758323393062;
        Fri, 19 Sep 2025 16:09:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf8bsm66067135ad.44.2025.09.19.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:52 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 0/7] Add kfunc bpf_xdp_pull_data
Date: Fri, 19 Sep 2025 16:09:45 -0700
Message-ID: <20250919230952.3628709-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6 -> v5
  patch 6
  - v5 selftest failed on S390 when changing how tailroom occupied by
    skb_shared_info is calculated. Revert selftest to v4, where we get
    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) by running an XDP
    program

v5 -> v4
  patch 1
  - Add a new patch clearing pfmemalloc bit in xdp->frags when all frags
    are freed in bpf_xdp_adjust_tail() (Maciej)

  patch 2
  - Refactor bpf_xdp_shrink_data() (Maciej)

  patch 3
  - Clear pfmemalloc when all frags are freed in bpf_xdp_pull_data()
    (Maciej)

  patch 6
  - Use BTF to get sizes of skb_shared_info and xdp_frame (Maciej)

  Link: https://lore.kernel.org/bpf/20250919182100.1925352-1-ameryhung@gmail.com/

v3 -> v4
  patch 2
  - Improve comments (Jakub)
  - Drop new_end and len_free to simplify code (Jakub)

  patch 4
  - Instead of adding is_xdp to bpf_test_init, move lower-bound check
    of user_size to callers (Martin)
  - Simplify linear data size calculation (Martin)

  patch 5
  - Add static function identifier (Martin)
  - Free calloc-ed buf (Martin)

  Link: https://lore.kernel.org/bpf/20250917225513.3388199-1-ameryhung@gmail.com/

v2 -> v3
  Separate mlx5 fixes from the patchset

  patch 2
  - Use headroom for pulling data by shifting metadata and data down
    (Jakub)
  - Drop the flags argument (Martin)

  patch 4 
  - Support empty linear xdp data for BPF_PROG_TEST_RUN

  Link: https://lore.kernel.org/bpf/20250915224801.2961360-1-ameryhung@gmail.com/

v1 -> v2
  Rebase onto bpf-next

  Try to build on top of the mlx5 patchset that avoids copying payload
  to linear part by Christoph but got a kernel panic. Will rebase on
  that patchset if it got merged first, or separate the mlx5 fix
  from this set.

  patch 1
  - Remove the unnecessary head frag search (Dragos)
  - Rewind the end frag pointer to simplify the change (Dragos)
  - Rewind the end frag pointer and recalculate truesize only when the
    number of frags changed (Dragos)

  patch 3
  - Fix len == zero behavior. To mirror bpf_skb_pull_data() correctly,
    the kfunc should do nothing (Stanislav)
  - Fix a pointer wrap around bug (Jakub)
  - Use memmove() when moving sinfo->frags (Jakub)

  Link: https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/
  
---

Hi all,

This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
pulling nonlinear xdp data. This may be useful when a driver places
headers in fragments. When an xdp program would like to keep parsing
packet headers using direct packet access, it can call
bpf_xdp_pull_data() to make the header available in the linear data
area. The kfunc can also be used to decapsulate the header in the
nonlinear data, as currently there is no easy way to do this.

Tested with the added bpf selftest using bpf test_run and also on
mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}.
mlx5 with striding RQ enabled always passse xdp_buff with empty linear
data to xdp programs. xdp.test_xdp_native_pass_mb would fail to parse
the header before this patchset.

Thanks!
Amery

Amery Hung (7):
  bpf: Clear pfmemalloc flag when freeing all fragments
  bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
  bpf: Support pulling non-linear xdp data
  bpf: Clear packet pointers after changing packet data in kfuncs
  bpf: Support specifying linear xdp packet data size for
    BPF_PROG_TEST_RUN
  selftests/bpf: Test bpf_xdp_pull_data
  selftests: drv-net: Pull data before parsing headers

 include/net/xdp.h                             |   5 +
 include/net/xdp_sock_drv.h                    |  21 +-
 kernel/bpf/verifier.c                         |  13 ++
 net/bpf/test_run.c                            |   9 +-
 net/core/filter.c                             | 135 +++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 179 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 9 files changed, 463 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


