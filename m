Return-Path: <bpf+bounces-4042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC464748308
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2981C20B09
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B86FB5;
	Wed,  5 Jul 2023 11:39:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7F2578;
	Wed,  5 Jul 2023 11:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9CAC433C8;
	Wed,  5 Jul 2023 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688557173;
	bh=ZbcL7/Ws+420j+1VsDqK0BIHNk64SeGaagfrpJQvNdU=;
	h=From:To:Cc:Subject:Date:From;
	b=Mmty4s3lrufZwNUJbmiCj64hkHAdaNMtj0NrKL1xoLIeHV/15A0PRwZ5cpSk8y3Z0
	 DeQv/e6LxOjNjfnGKpXI/au6LQHfFGqF4L44oXy3W0OkKpzvlJ6jFa7LSMpm+7LcsP
	 /6DOgupRUUJXsl3R4AuugfH+Mz1J+zdndck/Q6UGo/Nxn8/M1IiBRQBtkmTeNPAmU/
	 1Sm6UbRVvPU1yEvbv7ez9eiiPmjY1XMg9CtIA7ONv22VXO4O8HThPKzKCDlnWA1l+2
	 9Dh0bwIaHEG0r/3BWpDbObUv7Zxsop3rbGRukHQRokz8Q3dcuhYDVlI/rnOOKQrsIE
	 qg6SHth7qP4YA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 0/2] BPF kselftest cross-build/RISC-V fixes
Date: Wed,  5 Jul 2023 13:39:24 +0200
Message-Id: <20230705113926.751791-1-bjorn@kernel.org>
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

This series has two minor fixes, found when cross-compiling for the
RISC-V architecture.

Some RISC-V systems do not define HAVE_EFFICIENT_UNALIGNED_ACCESS,
which made some of tests bail out. Fix the failing tests by adding
F_NEEDS_EFFICIENT_UNALIGNED_ACCESS.

...and some RISC-V systems *do* define
HAVE_EFFICIENT_UNALIGNED_ACCESS. In this case the autoconf.h was not
correctly picked up by the build system.


Cheers,
Björn

Björn Töpel (2):
  selftests/bpf: Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests
  selftests/bpf: Honor $(O) when figuring out paths

 tools/testing/selftests/bpf/Makefile                  | 4 ++++
 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c | 1 +
 tools/testing/selftests/bpf/verifier/ctx_skb.c        | 2 ++
 tools/testing/selftests/bpf/verifier/jmp32.c          | 8 ++++++++
 tools/testing/selftests/bpf/verifier/map_kptr.c       | 2 ++
 tools/testing/selftests/bpf/verifier/precise.c        | 2 +-
 6 files changed, 18 insertions(+), 1 deletion(-)


base-commit: a94098d490e17d652770f2309fcb9b46bc4cf864
-- 
2.39.2


