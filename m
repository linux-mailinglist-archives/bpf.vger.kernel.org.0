Return-Path: <bpf+bounces-68956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC98B8AE44
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C615A04C9
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C444264608;
	Fri, 19 Sep 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR7/r6rz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9A25D535
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306063; cv=none; b=Jx2FgS1HCrOUlFwL0Qj6R5AWjajrfYzReNutgb9KRGwbUWrI54QrCW86P8B5qPmUfUCPMNW+71Loo7uVZLUsoATMMFdEbFnOIm8bJSEbFNHlWdxq/4CODnUkVN3U8qfg1EYzKwwWQAIiGluNQIDhOT1ds1vADxwX/7BMkgosTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306063; c=relaxed/simple;
	bh=As4c3uNPwTSpJC/JzobkChPyp3a+dPMZxtFxCNQ0QlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miAZnIJKyC+funODm7TSZP/M3e1nrI6UlFV6BxN0lMfoX8nAKA6L97AU2/9EPvWWcblssVsmsmGRzBOFCyrrlGlmnrzpm8hHVnppD8WD5jPBBVbrRA2l2kZClghSWNudI7mFTsQrAZuU6Q6OpN/XQaL+ZMWCPq3yxxSqTsS0vMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR7/r6rz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f581aeso24926645ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306061; x=1758910861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cggPHM2KnCKDS4lWsfOe667l+bJ6peDQ5Y1x/RYcIAQ=;
        b=KR7/r6rzHTVmUvQ67yIBgz/uHeVYY/mehfsKjHLnWrisVWHp6w3mEMLDKNtKo2jjPM
         6ZXoGCbQA1kHa2EqZBAJFmci1jU8wYXr0qAW7lKTKkLTlu48QxKtWsCkee8BUL0qG87l
         fV3FThXEWedoZyDULroG2GdZeX4xpkQ+CnGIt+Z6wUhKMBZOYnIAGp3+F3NCrXE/OkIg
         wD5e2Nlkzx4J4+W6KLWYy+nC5AIA7/LH3kzaXmqLf9ahhMwKeb2u+Cd/oGvbhev1RSTg
         fiVmdOYSzGkfEJqAzjDN7RGIA51Q5TkseaINZK9KcfXi8SmnU3jVDHxFSHJkqW3n+sB9
         dZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306061; x=1758910861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cggPHM2KnCKDS4lWsfOe667l+bJ6peDQ5Y1x/RYcIAQ=;
        b=aMMVp6Cgr2DWWSee9rn+2Q75/e5KN3An7RDbVg5yvBHDqo1tL6T9BFDkFbD9krRwpc
         COfAwow1RKO7hEgBPo70aKzvB33odcylS2YF2WtnVpWturnWnxk9LU4fZFbMy3KXVu3Z
         40nKQBLoc5igVbmPZ+qpKr5lRSdTUjYGr2tJd4GIfE7rBwEQKQgOEnWl2tHqsCdhm+Ol
         mX4+1fowpzrRYqMaFLiVIgHN7P+5Ur7vbeKd6sNADhrl/JVxqlaBmYFw8EeMxAofvZyO
         sblTjTHUzqmlmvk4Jrpqzj2R8bo4qZOD+ZoCCr+1zMG1qU6iCP3N892J+oCsql465JCc
         I6mQ==
X-Gm-Message-State: AOJu0YxrK/iO2NVjGAwxEkDGxWsZ31ZEcx0LExUOzJA0mLllnxyMPcfA
	nhvBpHpXuzS3GOS5348e4IIQH2foV3prVVGf6qVUAEO5ChP7xWF+/Sz7QfxLvw==
X-Gm-Gg: ASbGncs6Q56846Zw+jZD18x4zKYWRSsJ4QZnFQ0+lUGy8nTJUvbtyPImuauYaujTW14
	IY5z/pTCmRXho0SKbWjDbW1HjJ5S9t/ZSVLGPu4ukPeI90K8nRx0j+sngHkZ9540807PSHKILl8
	T2QhLkc8X5/mlYEZpF0hNtSo179OhFbW4AamMZ5Wpxou9ZTfuf0XKE8GGIzwhoqq5hiFTMNr25j
	5LPpW8k/Iv2BRNDsn8Aieu2Xw57BKjBlPUaSWHB4cH87BjdyfBX8oeE9T/EtQvFdDhhqD/ucIzU
	zN/Km7rQP6j0tFDN60sv1XpS2eaXB5cEFS/+V1SsNp1DWWp3yz6QrGbvumiNilG1brxpVlzRL7U
	0zVbP6Ymph29IhkKPuC4y6E4z
X-Google-Smtp-Source: AGHT+IHJJPHBPil21G+e6OZnsB4WE6D765W+i57jX32TBjQeilwzm/yypWvPMl8+IrXa9yP/grM1wg==
X-Received: by 2002:a17:903:1b68:b0:264:5c06:4d7b with SMTP id d9443c01a7336-269ba51703cmr58232005ad.32.1758306061211;
        Fri, 19 Sep 2025 11:21:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053ef0sm61795685ad.28.2025.09.19.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/7] Add kfunc bpf_xdp_pull_data
Date: Fri, 19 Sep 2025 11:20:53 -0700
Message-ID: <20250919182100.1925352-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 include/net/xdp_sock_drv.h                    |  21 ++-
 kernel/bpf/verifier.c                         |  13 ++
 net/bpf/test_run.c                            |   9 +-
 net/core/filter.c                             | 135 ++++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 169 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  36 ++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 9 files changed, 441 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


