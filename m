Return-Path: <bpf+bounces-42908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A49ACF04
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5159E1F210CC
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCA1CC158;
	Wed, 23 Oct 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YunnH0yf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D81CACDE;
	Wed, 23 Oct 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697978; cv=none; b=Gc1UgVMJIv+6Ff9CBzdnbKEH/c3FwXHynOKCfmYmRmrEQBBmBBPnFehBUGvV6/pDlVzFMj74hvgysjyzRDWM/rcb46gClsdBeX6xiM0OzvAx7sthQSRTSHRvjEKz0OSd3ptQ+lNhbeEovCEI5m20tP0ooPfcWf48ejqjzguCilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697978; c=relaxed/simple;
	bh=mdNPVEeAmRMvE8WVCh/WUhH2bcKZHSXxSo0wo2DESkA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CokR5sMRky7EPrLq+OwQzACOsxvny0DOSBZGrabdsQKjBwmrkxrzgZAcMJrhz/yT5f6a6iAGuVO5tA6Ei3pXjv1WHgYEEYYtxX6mjSsuR3clLwIWJUQQnvR2Jmv9rPpAQalNgjf/a1hbApj9UdsktlO93hWdc/JReKFupZWvsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YunnH0yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8F4C4CEC6;
	Wed, 23 Oct 2024 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729697977;
	bh=mdNPVEeAmRMvE8WVCh/WUhH2bcKZHSXxSo0wo2DESkA=;
	h=From:To:Subject:Date:From;
	b=YunnH0yffkCAihsC0tg0RcEVUBcTBtsB0ug2bVopVHAnVtK9gbyJtP8z7e9OjzKqv
	 y3elm87l+rQJA5AmW0NpAiZuQcBfRWg8YfQG8CkHR7VTimoB1NdCzibk7s9tEAEksB
	 vRqlbe4Hel0esh5klowxnJUEftF2dv4LHsnoiRawfeCXCIYyL7qYJueUYsfuD+nYlU
	 NqVTt9VyT/Jotqx9W0IbRwE5beA+fkI0JW0txbSFwXwHS0323OL6V23bd9EKtZ0B2l
	 nGWGGddDAMMPyGOauGcRr+b9qvA/2A1Y1hNAEzC9lRI3rKvh3nDlkLF2DTxFBjyRiI
	 lLNtQiXQwXh2Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Helge Deller <deller@gmx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2 0/4] Optimize bpf_csum_diff() and homogenize for all archs
Date: Wed, 23 Oct 2024 15:39:18 +0000
Message-Id: <20241023153922.86909-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
v1: https://lore.kernel.org/all/20241021122112.101513-1-puranjay@kernel.org/
- Remove the patch that adds the benchmark as it is not useful enough to be
  added to the tree.
- Fixed a sparse warning in patch 1.
- Add reviewed-by and acked-by tags.

NOTE: There are some sparse warning in net/core/filter.c but those are not
worth fixing because bpf helpers take and return u64 values and using them
in csum related functions that take and return __sum16 / __wsum would need
a lot of casts everywhere.

The bpf_csum_diff() helper currently returns different values on different
architectures because it calls csum_partial() that is either implemented by
the architecture like x86_64, arm, etc or uses the generic implementation
in lib/checksum.c like arm64, riscv, etc.

The implementation in lib/checksum.c returns the folded result that is
16-bit long, but the architecture specific implementation can return an
unfolded value that is larger than 16-bits.

The helper uses a per-cpu scratchpad buffer for copying the data and then
computing the csum on this buffer. This can be optimised by utilising some
mathematical properties of csum.

The patch 1 in this series does preparatory work for homogenizing the
helper. patch 2 does the changes to the helper itself. The performance gain
can be seen in the tables below that are generated using the benchmark
built in patch 4 of v1 of this series:

  x86-64:
  +-------------+------------------+------------------+-------------+
  | Buffer Size |      Before      |      After       | Improvement |
  +-------------+------------------+------------------+-------------+
  |      4      | 2.296 ± 0.066M/s | 3.415 ± 0.001M/s |   48.73  %  |
  |      8      | 2.320 ± 0.003M/s | 3.409 ± 0.003M/s |   46.93  %  |
  |      16     | 2.315 ± 0.001M/s | 3.414 ± 0.003M/s |   47.47  %  |
  |      20     | 2.318 ± 0.001M/s | 3.416 ± 0.001M/s |   47.36  %  |
  |      32     | 2.308 ± 0.003M/s | 3.413 ± 0.003M/s |   47.87  %  |
  |      40     | 2.300 ± 0.029M/s | 3.413 ± 0.003M/s |   48.39  %  |
  |      64     | 2.286 ± 0.001M/s | 3.410 ± 0.001M/s |   49.16  %  |
  |      128    | 2.250 ± 0.001M/s | 3.404 ± 0.001M/s |   51.28  %  |
  |      256    | 2.173 ± 0.001M/s | 3.383 ± 0.001M/s |   55.68  %  |
  |      512    | 2.023 ± 0.055M/s | 3.340 ± 0.001M/s |   65.10  %  |
  +-------------+------------------+------------------+-------------+

  ARM64:
  +-------------+------------------+------------------+-------------+
  | Buffer Size |      Before      |      After       | Improvement |
  +-------------+------------------+------------------+-------------+
  |      4      | 1.397 ± 0.005M/s | 1.493 ± 0.005M/s |    6.87  %  |
  |      8      | 1.402 ± 0.002M/s | 1.489 ± 0.002M/s |    6.20  %  |
  |      16     | 1.391 ± 0.001M/s | 1.481 ± 0.001M/s |    6.47  %  |
  |      20     | 1.379 ± 0.001M/s | 1.477 ± 0.001M/s |    7.10  %  |
  |      32     | 1.358 ± 0.001M/s | 1.469 ± 0.002M/s |    8.17  %  |
  |      40     | 1.339 ± 0.001M/s | 1.462 ± 0.002M/s |    9.18  %  |
  |      64     | 1.302 ± 0.002M/s | 1.449 ± 0.003M/s |    11.29 %  |
  |      128    | 1.214 ± 0.001M/s | 1.443 ± 0.003M/s |    18.86 %  |
  |      256    | 1.080 ± 0.001M/s | 1.423 ± 0.001M/s |    31.75 %  |
  |      512    | 0.887 ± 0.001M/s | 1.411 ± 0.002M/s |    59.07 %  |
  +-------------+------------------+------------------+-------------+

Patch 3 reverts a hack that was done to make the selftest pass on all
architectures.

Patch 4 adds a selftest for this helper to verify the results produced by
this helper in multiple modes and edge cases.

Puranjay Mohan (4):
  net: checksum: move from32to16() to generic header
  bpf: bpf_csum_diff: optimize and homogenize for all archs
  selftests/bpf: don't mask result of bpf_csum_diff() in test_verifier
  selftests/bpf: Add a selftest for bpf_csum_diff()

 arch/parisc/lib/checksum.c                    |  13 +-
 include/net/checksum.h                        |   6 +
 lib/checksum.c                                |  11 +-
 net/core/filter.c                             |  37 +-
 .../selftests/bpf/prog_tests/test_csum_diff.c | 408 ++++++++++++++++++
 .../selftests/bpf/progs/csum_diff_test.c      |  42 ++
 .../bpf/progs/verifier_array_access.c         |   3 +-
 7 files changed, 469 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_csum_diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_test.c

-- 
2.40.1


