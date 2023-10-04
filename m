Return-Path: <bpf+bounces-11364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEAE7B7F0A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BFFCE2819D0
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9313AF9;
	Wed,  4 Oct 2023 12:27:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3512B99;
	Wed,  4 Oct 2023 12:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75416C433C8;
	Wed,  4 Oct 2023 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696422446;
	bh=RkzvF8X+SXDFLfFH4P6mrq7fuBmqThHF3EmjygH38s8=;
	h=From:To:Cc:Subject:Date:From;
	b=tCdbg9GWUdthDNNxMYvE7a+R5KpNE1fdxO3rcSy3ibki5AKOYZ0Lt/gpZ/20g5Mvk
	 ytPpLV7Uoxx9ug7IpnI9UHmzf1dbPyMJaPvem9GjgK/Lg5FJavmEJxeNjtntr0Uqm/
	 ZflKPumsYQ2Ny/9BxNVQnztfvrAjTsjY+seWYkQy6eyBejCB/rvkTZJAeSzNdEYN6Q
	 Lm9LaMzQCEXoIl9vRKZQC+eM9ni2Qsxc52jMxDVyfUnKf7p4JTjMwqgUKg9E+V/ojh
	 zFFI6IbCR+wnvjbirjdr5WVioLGtQ8F1zSp1I0Jy+oS2R/2wwjvOAiz3L4l/L1xvE6
	 1nLMCm9DXFZKA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 0/3] selftest/bpf, riscv: Improved cross-building support
Date: Wed,  4 Oct 2023 14:27:18 +0200
Message-Id: <20231004122721.54525-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Yet another "more cross-building support for RISC-V" series.

An example how to invoke a gen_tar build:

  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- CC=riscv64-linux-gnu-gcc \
  |    HOSTCC=gcc O=/workspace/kbuild FORMAT= \
  |    SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" -j $(($(nproc)-1)) \
  |    -C tools/testing/selftests gen_tar


Björn

Björn Töpel (3):
  selftests/bpf: Add cross-build support for urandom_read et al
  selftests/bpf: Enable lld usage for RISC-V
  selftests/bpf: Add uprobe_multi to gen_tar target

 tools/testing/selftests/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


base-commit: 2147c8d07e1abc8dfc3433ca18eed5295e230ede
-- 
2.39.2


