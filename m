Return-Path: <bpf+bounces-69288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BEB9395A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBBB2A052B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27532C11E6;
	Mon, 22 Sep 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQpujcvL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD414277C8F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584040; cv=none; b=ZcSsL79HXzhlGXBZry62su9O/guCOd/SzwMpG7M4u4BOGn2vZ/V//8BPiAAoH7QKQhHHIrDd456PEjCHsh7ZdjdIhHg86ecYJUIJPw8d26VsAf+1KQfgxo4Up0XUMRABq2YjsMhTB/S6CaHMyjryZRc/CCrszwS1t75lrf54wQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584040; c=relaxed/simple;
	bh=7L0b8xVcWKGl2Um96G9TEeLLcPaAZLg//CEHJzPw1vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uH64hVwaMh+Rrf3QLCl4xwxzhOSBl1rU0YHs/AotX9hvkzLVCHqvAkO1QjQoIXu2xrHrZHfl+c52Ax1b8VjDSUuE/8F46+FbG0sAo1DrM4YqFLvBh2Nw3V7Lh1YpPkeeoK29OyYHlreZzV6/7rir2L1i/WeHHrJ0HjjY8DVNkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQpujcvL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244580523a0so59112185ad.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584038; x=1759188838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNuyT4UIadhF83LQiFA1J7XTqOmNSKvnywAckACKVBw=;
        b=gQpujcvLXCskSaMnAGo6srcLwlaHjthv5ZMZiTFg2e/6eKJJXZDK5w40zo4ZvoN+W0
         Nll58W0Ri36t4lYwVVg62hBrWPjzJ3iu9gL+8P48hq2B8WhrxsqqGhCx6STlccAA/rvA
         SdZUPYyYxHiom3NS2a6Z5K+ze1ADzAvbLrAZTndKaqG8vB/do00q9N6sUp0+Dd3aWFZd
         Cbt9b8cX+sM48LKwOJ6nIv0WXrH3d9MvxnxWur/KM+WHSyiozrZi0l/fX8RXlAE8+zqY
         Ve2JhQhuVgle4FoscCyhUrHUOYJnsia2+uOW9IfsxcUYnGLqO3/PRHNd9ytderA0lsfJ
         39hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584038; x=1759188838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNuyT4UIadhF83LQiFA1J7XTqOmNSKvnywAckACKVBw=;
        b=F6ZYZa4U5IePhn35KmpzFnCGWLikTuC5CBkM+l4tLpMBp/veOwOhLTwngRZGQx0+tz
         dbzPGrqVW/JTA2ad68ETFj9pN5qxXaw2YlKCawB0TKEpdJEFVyRqnQK3VsZ684D8avd4
         TVlcRs6M8zNWNqvHV5S8Sn7r6SghsorG+UMnDoJmhwTVl/h8th9RHeGDiCBISZDo/StO
         eNuTlvJ8rfT7qI2zsxA3++pJNxeWaXcZoEGYwP82LFOK5j18kZYdGcVwb0VSvkdIh4Fg
         D5oCLPFRAxEAMS68/kKKnz5Mm/WvVuAAFNwgrqsWazX3adENDpugt78+am/pnnxcObOy
         th3g==
X-Gm-Message-State: AOJu0YxuXJnapF79mXxKx7SuLksZk37OocEogpcTB48wXZWz1IaB1dFr
	QpMvCqNMKkrJosCTMtdtCymYrrgCSmMSJAfxC2G9yaTVA2X57iAQTvGglLHpSA==
X-Gm-Gg: ASbGncu1HxRIhR5zj/UdDI9//FRLml2eNLxjvf4FOZxhSneOl/5/jKp7AYn4H3yZpM+
	HAlGec8NRHcCBZioaVcSwqCcLFOtw0kmLnmR1uP4YXJQSxO0Av1OSEa3tzCLn9eGDydRbOFo2K+
	aAWpFR8XUicFa0lIB6HCJAyGJamfhjiRh1x8vkd8x2fkkjzd1tmtHn2TeAQub655iIqVNjaV4zL
	RzUBPp1peuMistvy5dMYUOXVUlGROjonGlc8fMROs0Mou/IgRCcAeYpZIKDX3Fjt+i9Emd7DSTI
	/XJpI0srgLMWgScKkPG4820wPaBoO9FeZKdi8g5K4qDmNtc6OYK08qly0uK7Yh+YSs0yhxJTiT0
	4e2bGmhqN/Vr6VQ==
X-Google-Smtp-Source: AGHT+IHhQ89LwsOFfsaS/aRK00/dCrokkNfeWSP99FUsxwIhdesxbkrNbiw0MU1Ga5/z28uybnAB7Q==
X-Received: by 2002:a17:902:e945:b0:246:80b1:8c87 with SMTP id d9443c01a7336-27cc61b8d7bmr6664055ad.43.1758584037621;
        Mon, 22 Sep 2025 16:33:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803587absm140655065ad.137.2025.09.22.16.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:33:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/8] Add kfunc bpf_xdp_pull_data
Date: Mon, 22 Sep 2025 16:33:48 -0700
Message-ID: <20250922233356.3356453-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7 -> v6
  patch 5 (new patch)
  - Rename variables in bpf_prog_test_run_xdp()

  patch 6
  - Fix bugs (Martin)

v6 -> v5
  patch 6
  - v5 selftest failed on S390 when changing how tailroom occupied by
    skb_shared_info is calculated. Revert selftest to v4, where we get
    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) by running an XDP
    program

  Link: https://lore.kernel.org/bpf/20250919230952.3628709-1-ameryhung@gmail.com/

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

Amery Hung (8):
  bpf: Clear pfmemalloc flag when freeing all fragments
  bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
  bpf: Support pulling non-linear xdp data
  bpf: Clear packet pointers after changing packet data in kfuncs
  bpf: Make variables in bpf_prog_test_run_xdp less confusing
  bpf: Support specifying linear xdp packet data size for
    BPF_PROG_TEST_RUN
  selftests/bpf: Test bpf_xdp_pull_data
  selftests: drv-net: Pull data before parsing headers

 include/net/xdp.h                             |   5 +
 include/net/xdp_sock_drv.h                    |  21 +-
 kernel/bpf/verifier.c                         |  13 ++
 net/bpf/test_run.c                            |  37 ++--
 net/core/filter.c                             | 135 +++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 179 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 9 files changed, 479 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


