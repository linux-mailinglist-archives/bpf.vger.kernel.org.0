Return-Path: <bpf+bounces-68445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738FB587C7
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EF6484237
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDDF2D837E;
	Mon, 15 Sep 2025 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApcF3/lm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD523957D
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976484; cv=none; b=hfHWXcX4pHP+59i482SOFLsYb4afZdVCaE5vRL1KrtMmS1kwkvQEZVQIvEPslfOC+Lgc0PuW9lz1WZokKrTIcmMogQpylWlaBl2sDgFceVKF16c4ztRzTQuVI2p3nRAOctVVWQenvzj/KxVx4BLqHDhwa3KlPMwHpHl+4lLGGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976484; c=relaxed/simple;
	bh=5UqF3Ysp9JENJ7uuLz3lTDyBwWGPJsirLelAb96xPRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsmtIkrT45/WzgyRuz3XAWb4DNhHdGeKXEnqTevuu6WOWJfWBeSsidAOvr2Dm7f8WGYKTFq1bnYRkOkDazJICXm3W1hXKgaBy43IDGCT4Ji2Con/Tfsj24EjmTsC4wNJyajZ6so2vPoCDR9uF8VRVZUcTWrINNpyShC6DJ3aLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApcF3/lm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32e0ef1ba46so1647527a91.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976482; x=1758581282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8K+vUyHnagTGCHkW/l0LZwpJ9q9Aeei9zIs+piSAMHw=;
        b=ApcF3/lmNvLsXvjsfu4LF7jS7lU5AgMU7Pug+RgcQZEF/BpcMewGf9u4vUrwvz30p/
         2j64n7afSH7myiRg0C6UPbKr1VlR55Om8aZon3IOzJSZLaPRxnWQx5XMfiAVYoGfkbVm
         6qf6H0omoLUZfauHPFTFp9LoSKSFOUSt1v8R13zGeHBv14IJSefCnEapVLNEYWybLniG
         +PZ44H4UDKvY/SDe1A0rQU7JDq6NNzSvBNuOO+Sp/ed6wm5uti5joshaDMeaZhFNU8SP
         vQ4RDVDHUDO4aCfSrjHoLEkkluy+CYyz2n6QH+mmUAL99IE9i4RHgXx9ILxXp4HeGfe8
         R/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976482; x=1758581282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K+vUyHnagTGCHkW/l0LZwpJ9q9Aeei9zIs+piSAMHw=;
        b=Tbj3/kre8o3TThU2i49uJ6saxZApHX4pvPtuqdhMe5Gu8+/ZxSG0v2LpsxF5vGDza9
         tnc919w/LsYfNm9c2pqKLr5B4xAq7TRz//x8dz7oGkcTQPo6ZIaIB3unIYoPMQ+THGN0
         PuWb5cmbMfYo7GUv/M/lMycGZmMXgzw+JnjQPSaftDVzmv5g9pDVHn8xImv0TzWi8vDn
         ghN+OVTfutvoJRTbDO5D52aFkjD/qYJz7RbFTQ2lkwCWFB2PgQJXFD8iiCSnD4cb2kh0
         O16mGFQ2Zt4Uo//scbPWn5QUsmrV9ynGyRbpleeOh01sSapQAE5zsl3FOK/yKm0NEuo3
         Wm/A==
X-Gm-Message-State: AOJu0YzaUuWNYwvejG1l4X2WnHclsKI3emAjdGqmyk12+WUKCtJ5ICIl
	LMbHGrBCWDANL63IDWrYR4LTBN3l1ncA31eUfIPql/iGAF8G924I89U9fMFThw==
X-Gm-Gg: ASbGnculQahNf5g6+kZ6ym1ho7AWj2VkwP88FiqYwDw5jTVRUXqlSeSLqhLx3V7JQwW
	3jqhhP92X+XelpkhkYQPQ+W/zvflkC7Cglvw8ja7LwGa0caa1r5xaV4HtjEs1lXU/bNXq6xunbJ
	DE79u4/b1exPunQxZ8y5xWCbMtyyhCqJYL99AS7Yaqw20MJJJfbMhY1mRArrxn62wVdIGrFhdNV
	fXMX/JdeLKB2kcO0ZWkOBe4xZgq9Uhw9xwqrpgzoiJbOfoa4Ek+1k2vgmFBVjmu34E1eZnzdgTl
	f2daSbULt7/hwrNZeqqnaGThAMqH1Ixv7xKHgsw4hHe2ECIyILRH1JEKdiHY7Z/4OSug73D9eVp
	BR5SXZCK/QoLXc4C1nqfF9iI9
X-Google-Smtp-Source: AGHT+IFj4Kb0bj2s7cASfusQq0lXXQW/RqCm9lTCjvMdEqDtDDqv3xwiA9bm2QBvz8klP9UvpGSqog==
X-Received: by 2002:a17:90b:4d06:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-32de780ec01mr13932391a91.22.1757976482407;
        Mon, 15 Sep 2025 15:48:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:15::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b43a7sm15682797a91.13.2025.09.15.15.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/6] Add kfunc bpf_xdp_pull_data
Date: Mon, 15 Sep 2025 15:47:55 -0700
Message-ID: <20250915224801.2961360-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 -> v3
  Separate mlx5 fixes from the patchset

  Patch 2
  - Use headroom for pulling data by shifting metadata and data down
    (Jakub)
  - Drop the flags argument (Martin)

  Patch 4 
  - Support empty linear xdp data for BPF_PROG_TEST_RUN

v1 -> v2
  Rebase onto bpf-next

  Try to build on top of the mlx5 patchset that avoids copying payload
  to linear part by Christoph but got a kernel panic. Will rebase on
  that patchset if it got merged first, or seperate the mlx5 fix
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

This patchset also tries to fix an issue in the mlx5 driver. The driver
curretly assumes the packet layout to be unchanged after xdp program
runs and may generate packet with corrupted data or trigger kernel warning
if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail(),
bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.

Tested with the added bpf selftest using bpf test_run and also on
mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}. mlx5
with striding RQ always pass xdp_buff with empty linear data to xdp
programs. xdp.test_xdp_native_pass_mb would fail to parse the header before
this patchset.

Grateful for any feedback (especially the driver part).

Thanks!
Amery

Amery Hung (6):
  bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
  bpf: Support pulling non-linear xdp data
  bpf: Clear packet pointers after changing packet data in kfuncs
  bpf: Support specifying linear xdp packet data size for
    BPF_PROG_TEST_RUN
  selftests/bpf: Test bpf_xdp_pull_data
  selftests: drv-net: Pull data before parsing headers

 include/net/xdp_sock_drv.h                    |  21 ++-
 kernel/bpf/verifier.c                         |  13 ++
 net/bpf/test_run.c                            |  26 ++-
 net/core/filter.c                             | 123 +++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 174 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 8 files changed, 456 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


