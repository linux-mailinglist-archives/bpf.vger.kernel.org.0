Return-Path: <bpf+bounces-68948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7FB8ADDB
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9521CC36F8
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7343F25DCE0;
	Fri, 19 Sep 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYIyJdII"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2561D8DE1
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305371; cv=none; b=VQfGuqtLzUCOZOuBZWQWF1lCL9UxRISYZp5wSawFfrFz7CTVa+qsq96AufenbscPXI3/AQf+GZ4HuoIv1DhsH9Ng2PRoJGwM0yR+NEc/lDJhnlqiX3uyQ9omedWQiV3DhGv+pzTWbqvAkMtMzVYZDnY/WflMk8UpyYzzZ2MJu9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305371; c=relaxed/simple;
	bh=wt3AuhBxvcVL1P1Aj0dCyPrtsq234uq/pypnZ//yoYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9SmaEuErxyF4P3WK4x0aoiBIfiOMsMbXjVTD1pik0qeLIe62x7MBpaVHHCl4fdk0IO0bhewcBD6c00xvRVI6q5zuGv7rszo4mm2pJdzDpFYLt0Se8n4gxLnav/jd4ZoipPrjuQ1Msjx1Dz62j40HnSjkHH9DAE2hZZW3d39Urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYIyJdII; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24457f581aeso24812925ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305367; x=1758910167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhFhuvjcD2znhDPzXvfCXa5O+O+dmP6JWKyMh1YLGSw=;
        b=nYIyJdIIzIK0lhs6zwQPpyDcYbzrbOz3kPFu2yKfN82BlzlqB+kdsxsCpiPPWtoHrU
         MuVfv9LsxNZ7wyzoKz6MkH5mZJitS4wka/ggQTSNvXpKnMll4TbVGtxwIMCqgShQhiwq
         g9Uqw2SIhCRB2e6lZnGwxerJwK0x6HR2wc6NxPAfALYDdP9EezSJ7g90u1KMNPfZGSD8
         suaQgLVKMJgAzvs1Ux1gRkg9qrxUV/Ygp/dgi1R0A95PeXBhpJw6fYyfTT8qUyzclKu0
         fNMpJqdM7I57Rz0zKDO0RhBDyHFxbrBQXas2dcn7dTns1lxwZAMFd+y7csm4ds5RlkPj
         WhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305368; x=1758910168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhFhuvjcD2znhDPzXvfCXa5O+O+dmP6JWKyMh1YLGSw=;
        b=wz1kiKmhn4Q0l1mJ0rhfFRgOjPMUvj0hYPCo3Gf01HskrK3aVVf8P+avlJkzggR59O
         BEbKLQkYhYLIhhuw4yTgk+O0TFq3XI8xzrSWPyU0U3zC9JBbOVybTpxaMAa+D3FO1iiH
         +CkhmNbGWKzHzIM/S/isc89fehV9B9NuN0WmXQ/W6vkmLEBEV6ccZ5XRqV47i0rVoNVr
         yvYyNNSQbIxc3XuwAO+c4mCeb+6LO4wLGJB218bHCL5c0uRFKZ2oBjmrBgwwxZWxijPU
         dX/N4yItDSMk4t0PBDbG3k9C7KQQt4t3dtW3/IesOUjKy8+47z/eKadUIJCqzxIGY+8N
         f7fA==
X-Gm-Message-State: AOJu0YwhC77SF+Z72Bz87/Y3jI9ifZvdop49KJtzTvtT6ErvrL1kc4D4
	AvCWSjDiK+dw/nsyA6Snr6RwZIhICC+YY1fvjPtxRBt695ZuGDBVLFN1zcJM/Q==
X-Gm-Gg: ASbGnctxd/IeS0AvZcNsmqAAHqKezOV2DiS8/qc2jjja2qBCIxsfc9LhSTIOrTQiJti
	yxZwPLhKoe3UoaKVeZPg1aDBCDzdytacqnUorAQtmaz8j7vcgyOvsMfVtVAxQOfwyS+3xRqZajp
	M7JDBgEybiX9eXhgFmQ6MQQUsBS9plVzQCYDqqq72TNTCSnPzYq7q+BNatBBeS6cmDIfY5qynIW
	iPVl6JNBv2jSGxPQM3ts/kjgDSJ1L2LLhRRyXlbClJmGrCY4+Nku7wUWsIssqH7zJX7kCBHj4et
	KYEKQUvQSaGY4Md73tNddrVJeB12eJMyRalIemfwpXt+03y3WerEawT0y4TKFkel0Uq8HCL2V4p
	0OBHZykFCRfdk
X-Google-Smtp-Source: AGHT+IFBmImHKIomCIAeYE2WjtEz6ppxJP9ckJpfmnydk+sHXpBsi6ahjP27SR7sxy+yjGGjAK7QQw==
X-Received: by 2002:a17:903:2a8e:b0:267:e09c:7ea3 with SMTP id d9443c01a7336-269ba467aaamr62394935ad.13.1758305367525;
        Fri, 19 Sep 2025 11:09:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030fff0sm60925195ad.105.2025.09.19.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:27 -0700 (PDT)
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
Date: Fri, 19 Sep 2025 11:09:20 -0700
Message-ID: <20250919180926.1760403-1-ameryhung@gmail.com>
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


