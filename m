Return-Path: <bpf+bounces-42611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485809A6819
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0091284A1E
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F661F706E;
	Mon, 21 Oct 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVl0pom3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C371E9089;
	Mon, 21 Oct 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513309; cv=none; b=jmAK7SwkXGdIBc8XiwaPh1p9+t8xK1vby0bklFygH4l1GDTz9M2ilkDgl18eBtQQOe+0zKHw7gh/sapci34IlQ2nwNZSSo+9TLg1KST2SoSNn110sO6ulw2SDJXEXxWoGyzTFyhA7N82cEdm7yQZaaCedYuBmy3lKQwgejMEAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513309; c=relaxed/simple;
	bh=B+VLaGzReOrXQUVLIvCM19MOqgqdL54YeTdVPYr1sHM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Omxdt+S8XfM9a4ldGG4dDXWBczBrudKc6wMIZe6qmqITUHUy+TKbV0jp1zB+DAE7YdzHWfHgUF+QVXxu1CNpbQ7JW2AngowkqA2AV8uNuBBz5W5JbW9N7qcsPYYmBJR34+8na2p6hW3P54P6Ds6QhT+C3iQRRZoBP0w+/3ixrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVl0pom3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E698DC4CEE7;
	Mon, 21 Oct 2024 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513309;
	bh=B+VLaGzReOrXQUVLIvCM19MOqgqdL54YeTdVPYr1sHM=;
	h=From:To:Subject:Date:From;
	b=tVl0pom3rlQe9aM/hjZ2mYpEz9YDCN23RGwaN9xZrSTEM2rUBrH15X28wEw3PBlIm
	 qRuLpl0iHy18hzGeMt2rGGufKslkKulrKhttEx1kmWCanhwkkTkUTeKzxMmxVGIkva
	 hlGnv6PW2rwYgMsQsXxnVVn5a8k+S5yXKvZ8S61dHW6V8Oh3a4jKGJnC9MqDoPQ/u9
	 6Zj6PuEW+UMpWRIYGbjIcrX0t3aqzSVaNpAJWrulIgJTPsj1ShjMQBCeOLvDNoMP8u
	 C4sR0vQ0mQVbUvB2yT27z3AGXxlnJvrQ71jlY6EQMVKKpryk7Nst7E/i9TA0rYC3oa
	 18svTXbxvvipw==
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
Subject: [PATCH bpf-next 0/5] Optimize bpf_csum_diff() and homogenize for all archs
Date: Mon, 21 Oct 2024 12:21:07 +0000
Message-Id: <20241021122112.101513-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
built in patch 4:

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

Patch 5 adds a selftest for this helper to verify the results produced by
this helper in multiple modes and edge cases.

Patch 3 reverts a hack that was done to make the selftest pass on all
architectures.

Puranjay Mohan (5):
  net: checksum: move from32to16() to generic header
  bpf: bpf_csum_diff: optimize and homogenize for all archs
  selftests/bpf: don't mask result of bpf_csum_diff() in test_verifier
  selftests/bpf: Add benchmark for bpf_csum_diff() helper
  selftests/bpf: Add a selftest for bpf_csum_diff()

 arch/parisc/lib/checksum.c                    |  13 +-
 include/net/checksum.h                        |   6 +
 lib/checksum.c                                |  11 +-
 net/core/filter.c                             |  37 +-
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_csum_diff.c    | 164 +++++++
 .../bpf/benchs/run_bench_csum_diff.sh         |  10 +
 .../selftests/bpf/prog_tests/test_csum_diff.c | 408 ++++++++++++++++++
 .../selftests/bpf/progs/csum_diff_bench.c     |  25 ++
 .../selftests/bpf/progs/csum_diff_test.c      |  42 ++
 .../bpf/progs/verifier_array_access.c         |   3 +-
 12 files changed, 674 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_csum_diff.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_csum_diff.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_csum_diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_test.c

-- 
2.40.1


