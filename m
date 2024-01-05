Return-Path: <bpf+bounces-19083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DAC824C08
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A8D1F22B17
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D83810;
	Fri,  5 Jan 2024 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNA/snBj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726D386
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3E6C433C7;
	Fri,  5 Jan 2024 00:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413351;
	bh=KDoNnybRsUMCTc6AhzryFo62ZMXHTrvjCqFpuohLlZA=;
	h=From:To:Cc:Subject:Date:From;
	b=cNA/snBjfKS9CFWBmCtir7jta+TwTXgGsA4k7YTRopktEvPoMTaHQ5TyQBBGaKiy3
	 kpHJLFKuCzspX+C1gmErIRZdDVTzxzoM2/M83QIea3agnlHGUWP766o+KuGz1Obxth
	 vLG6MjH/xhIgvmIQ3qtsK2O5NoW8s2w12M2PbkqdCiUcSfyiXyuP2wyT8s9HaJd5dU
	 08nlhLM0ZPSXsISBQfybetr+C+PGsAVzxpLNExSmkML/9R988nt3egQfcUQNUbLZEJ
	 O+4KuAMoi8RNImO52UiOmQa5u3TOQ8+x8TsEyjBfJQN/vlGzu0lIisUY/bNvSPkEuP
	 Msfwt/+jJ5qSA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 0/8] PTR_TO_BTF_ID arguments in global subprogs
Date: Thu,  4 Jan 2024 16:09:01 -0800
Message-Id: <20240105000909.2818934-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set follows recent changes that added btf_decl_tag-based argument
annotation support for global subprogs. This time we add ability to pass
PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprograms.
We support explicitly trusted and untrusted arguments. Legacy semi-trusted
variant is not supported.

Patches #2 through #4 do preparatory refactorings to add support for multiple
tags per argument. This is important for being able to use modifiers like
__arg_nonnull together with trusted/untrusted arguments.

Patch #5 is adding the actual __arg_trusted and __arg_untrusted support.

It also raises a question about default nullable vs non-nullable semantics for
PTR_TO_BTF_ID arguments. It feels like having both __arg_nonnull and
__arg_nullable would provide the best kind of experience and flexibility, but
for now we implement nullable by default semantics, as a more conservative
behavior.

Patch #7 adds bpf_core_cast() helper macro which is a wrapper around
bpf_rdonly_cast() kfunc, but hides BTF ID manipulations behind more
user-friendly type argument instead. We utilize this macro in selftests added
in patch #8.

Patch #8 adds a bunch of positive and negative tests to validate expected
semantics for various trusted/untrusted + nullable/non-null variants. We also
make sure that global subprog cannot destroy PTR_TO_BTF_ID, as that would
wreak havoc in caller program that is not aware of this possibility.

There were proposals to do kernel-side type enforcement for __arg_ctx, let's
decide whether we should do that and for which program types, and I can
accommodate the logic in future revisions.

Cc: Dave Marchevsky <davemarchevsky@meta.com>

Andrii Nakryiko (8):
  selftests/bpf: fix test_loader check message
  bpf: make sure scalar args don't accept __arg_nonnull tag
  bpf: prepare btf_prepare_func_args() for multiple tags per argument
  bpf: support multiple tags per argument
  bpf: add __arg_trusted and __arg_untrusted global func tags
  libbpf: add __arg_trusted and __arg_untrusted annotation macros
  libbpf: add bpf_core_cast() macro
  selftests/bpf: add trusted/untrusted global subprog arg tests

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/btf.c                              | 228 +++++++++++++-----
 kernel/bpf/verifier.c                         |  32 ++-
 tools/lib/bpf/bpf_core_read.h                 |  13 +
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   2 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/nested_trust_failure.c          |   2 +-
 .../bpf/progs/sk_storage_omem_uncharge.c      |   2 -
 tools/testing/selftests/bpf/progs/type_cast.c |   4 +-
 .../bpf/progs/verifier_global_ptr_args.c      | 160 ++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   2 +-
 13 files changed, 387 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c

-- 
2.34.1


