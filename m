Return-Path: <bpf+bounces-12587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C37477CE5D4
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4862AB21016
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B80C3FE50;
	Wed, 18 Oct 2023 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF3a6bGE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD9C14F
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67405C433C7;
	Wed, 18 Oct 2023 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697652273;
	bh=4k8XMzk1RS8Ph34JaRjbFlL+oibeV/DFgTpIBKmEPeU=;
	h=From:To:Cc:Subject:Date:From;
	b=fF3a6bGEcnsYk4RBxhsEp1lIXPd/RF5qoY1RUy+I+Tpgzaiv7rAcbYagqy4F1yB7w
	 oU9HiiZKzM3ooUeMkd1t+UmwybVtUoEd23i/DHKKf1Gi8ZTepYGaF4j0NmZJDIIB3a
	 QLytpqjjbStrJ4erL73fclq3wGXv8sxnWkah6ue0wwEheYe1BfEw5n5mIGsKUvzM2v
	 CDxwIRwOXsHPTcH7+eRUiDv8kqTv3+2JlcZ2WnQNJWIESGQS1+hH0a0iOJGd8KEuKo
	 xxWvOiwix20QwHCV4gCgRKEWZ9uMg4dC4VS0xbgZaazedwESfICuIPzxNLqB5/o+5h
	 b700zyfeJDE+A==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 0/7] Allocate bpf trampoline on bpf_prog_pack
Date: Wed, 18 Oct 2023 11:03:29 -0700
Message-Id: <20231018180336.1696131-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This set enables allocating bpf trampoline from bpf_prog_pack on x86. The
majority of this work, however, is the refactoring of trampoline code.
This is needed because we need to handle 4 archs and 2 users (trampoline
and struct_ops).

1/7 through 6/7 refactors trampoline code. A few helpers are added.
7/7 finally let bpf trampoline on x86 use bpf_prog_pack.

Changes in v4:
1. Dropped 1/8 in v3, which is already merged in bpf-next.
2. Add Reviewed-by from Björn Töpel.

Changes in v3:
1. Fix bug in s390. (Thanks to Ilya Leoshkevich).
2. Fix build error in riscv. (kernel test robot).

Changes in v2:
1. Add missing changes in net/bpf/bpf_dummy_struct_ops.c.
2. Reduce one dry run in arch_prepare_bpf_trampoline. (Xu Kuohai)
3. Other small fixes.

Song Liu (7):
  bpf: Let bpf_prog_pack_free handle any pointer
  bpf: Adjust argument names of arch_prepare_bpf_trampoline()
  bpf: Add helpers for trampoline image management
  bpf, x86: Adjust arch_prepare_bpf_trampoline return value
  bpf: Add arch_bpf_trampoline_size()
  bpf: Use arch_bpf_trampoline_size
  x86, bpf: Use bpf_prog_pack for bpf trampoline

 arch/arm64/net/bpf_jit_comp.c   |  55 +++++++++-----
 arch/riscv/net/bpf_jit_comp64.c |  25 ++++---
 arch/s390/net/bpf_jit_comp.c    |  56 +++++++++------
 arch/x86/net/bpf_jit_comp.c     | 124 +++++++++++++++++++++++++-------
 include/linux/bpf.h             |  12 +++-
 include/linux/filter.h          |   2 +-
 kernel/bpf/bpf_struct_ops.c     |  19 +++--
 kernel/bpf/core.c               |  21 +++---
 kernel/bpf/dispatcher.c         |   5 +-
 kernel/bpf/trampoline.c         |  93 ++++++++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c  |   7 +-
 11 files changed, 292 insertions(+), 127 deletions(-)

--
2.34.1

