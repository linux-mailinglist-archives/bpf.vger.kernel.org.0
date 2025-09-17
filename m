Return-Path: <bpf+bounces-68718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C770EB82349
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 00:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586CE2A86F4
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787E31065C;
	Wed, 17 Sep 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxGy0+WQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E582E5404
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149716; cv=none; b=UpY3ntgFX+dth4bUvKspzpz6KA//kG1Xe7BmMBtdylqZIIrIRWz+vkt4WJ8h7aMuInswgtKtDrfnFTxrynT1iKdBc817lwg4zg0HR318xIkII/pHeMMTJ4SsYv3rEN2p87oS0HbqGBtwX/xOWr/NmbJRTVpYoHn9M2DDNPqaJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149716; c=relaxed/simple;
	bh=wt3AuhBxvcVL1P1Aj0dCyPrtsq234uq/pypnZ//yoYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4TFcI3HW5hrScnkwskEwCIA6W4GSDcPfk1W+y5fFuygKur6eFnUQ7F3emmsT4n3lrSbF+xximr5xh9r2Or7tSTaSVD0ME+Prvc26/bIyo84luHly44uTE3IX5d5wYA0fJxr05syKQXmTQg4OiB8OlQbXqMhcq5iCfdQr2NgYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxGy0+WQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2677a4d4ce3so3745265ad.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149714; x=1758754514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhFhuvjcD2znhDPzXvfCXa5O+O+dmP6JWKyMh1YLGSw=;
        b=SxGy0+WQXnblUTvtfJOKD6aSD/ypFag+/P6wBMwk3rHdEufvEp7U6I9T+g5w4zgYqz
         Gx0emeVQojvqlE6luPQE3kt8a2pXQ7dJ0fuIZUUOMpFB8fGhmnIZLV/tN8smPLw9x6ui
         /kYIceVlfFrn+oZaaFKJ4xrAS9QkSsrHcEZPIiLyME1nX1q2IdMNKkASJPJt7Piz8B28
         2SKYScBA6h2FJALraGbgLNXkM+HPasAUhTEo87286TGd5QgPZ9Yeat2poNxPqkcHKxU1
         RpE1hhH3YwIQNa+wK5sRWvmy1y4/4SXwWUpL0GkQ5WJA1DqFdDdmDypN0E4RlRCpbdWp
         0AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149714; x=1758754514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhFhuvjcD2znhDPzXvfCXa5O+O+dmP6JWKyMh1YLGSw=;
        b=dtKXfnsIQ26x0AmjLT+1pDFhc1txY1zVvwoYjhldWlDXCE2hPNVznavFPM+jKiAX0u
         9Edv8Ss7A5h/tjmClPqTK+EqOWupjSIrqh1+P1k4/Oh/tgBDvWE/CF+tnTFLlAB3kc55
         DLaQW6iX7pSxWt7R2C5gQlKHLuD9m0qZmimTv40puDfAFAPIZ5Y9rqz0CM6HG7lcWHZ4
         F1Eu5oH6D22/3/llOPOW0zZODTo1pkzHMJ0wGX2YpcgmsG2FM5tvFjHZ5aKu5Imy0iGD
         AGEbBTPrRRexuwSV5SMpynB/BWtdT+UXeWH2W10bGkVPSxAto7B64yeU0hjUozLaDBmu
         /D/Q==
X-Gm-Message-State: AOJu0YxmpqrGNuS0k+pYUhn4Bte0kOYCzGU8EePxIrBNX/mMlcfGIfMT
	nRk54SMe9QcML8eeBANyjYaEctM4RRUPanbKNclCuexn/Q4dA4gHrj2O9bWUNg==
X-Gm-Gg: ASbGncvrOZHcBu+xpYAtMa8Bo6bvHw72Z/kUe+Sp02J8kVJWiI2LdRFChNhm38M3VjP
	Aqc5DmRP3v3vDPLjGAcY5KLmrlmkXhuGa3O/mXYzv9gY+wusv1m119QgxtCe71onE5D3d6XjNO9
	u0ev7LVEopDTkxHQjkABbTb5OOkKv4ygF7hHY0M+UalCH8x4Bgow0ZC10K0cM2+PCEKj7k2DGnM
	oaC1dvtF6CLocK+C/ZGfmjykZk52ERqPPF/vZBi3sr2vQ7JBCoxzvIDtkhIU9rByd0vqWQlyNnJ
	CXXiC73PIoT6SUChpGnVXjYIvVx/n20Y667qfacZFX+QOX1SgO0pi+BBjA7DcopKeJIiVz3QDKR
	wUoQjtdb3LZ/8GhnheV7WrQ+XvOP8A+ms
X-Google-Smtp-Source: AGHT+IHEtLKwY1ypVATt1etMR6WD9l8xUsGxj1lDm7z+X8v+6UBTAVcuhSrk5cVBxU8bbIwY4duy/w==
X-Received: by 2002:a17:902:c94f:b0:249:308:353 with SMTP id d9443c01a7336-26813be783amr45692015ad.41.1758149714305;
        Wed, 17 Sep 2025 15:55:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:13::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273e51dsm3424615a91.14.2025.09.17.15.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/6] Add kfunc bpf_xdp_pull_data
Date: Wed, 17 Sep 2025 15:55:07 -0700
Message-ID: <20250917225513.3388199-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 net/bpf/test_run.c                            |   9 +-
 net/core/filter.c                             | 119 ++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 176 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 8 files changed, 445 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


