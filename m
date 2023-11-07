Return-Path: <bpf+bounces-14372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BC7E34BA
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 05:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA60C1C20A41
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D317C9;
	Tue,  7 Nov 2023 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYcFgrqR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BB39C;
	Tue,  7 Nov 2023 04:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B89C433C8;
	Tue,  7 Nov 2023 04:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699333052;
	bh=FEAVTYnq5P+zoOl7iLkCDYHlmmR3rx7D3cbgsDSuPws=;
	h=From:To:Cc:Subject:Date:From;
	b=RYcFgrqR7o/ZeU88BuJgkK7vSG/6uugt2AR53k78fCxWU6+00nJwCxoZ8nzmS110H
	 Z/vZsCXKfMqq5+SYwy9xrpFnIEfvrBOOAy5OLmGNBfyijpQN71JJ0KFISFdgS0J/Ag
	 566ATE9alX9OcVXpdSFtGBC/5EWEHQPGpE4UvK9TyDF1dgUPB/HNeNqjmW1Mau8mZZ
	 ZYEoirBoi5DXsqguZ9EvlVN9VCz6k8NJaV8RZubt9Blf6pJoDQjV8qdq9+Jp45UETi
	 1fD2YY9KDrKdsLmaxekcH9lg2DAsOTAUseLBfsv6SdzKd2E+A/sTleP5Xb6RS8NU66
	 tgbfiUML2XZWw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	kpsingh@kernel.org,
	vadfed@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/3] bpf: __bpf_dynptr_data* and __str annotation
Date: Mon,  6 Nov 2023 20:57:22 -0800
Message-Id: <20231107045725.2278852-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set contains the first 3 patches of set [1]. Currently, [1] is waiting
for [3] to be merged to bpf-next tree. So send these 3 patches first to
unblock other works, such as [2]. This set is verified with new version of
[1] in CI run [4].

Changes since v12 of [1]:
1. Reuse bpf_dynptr_slice() in __bpf_dynptr_data(). (Andrii)
2. Add Acked-by from Vadim Fedorenko.

[1] https://lore.kernel.org/bpf/20231104001313.3538201-1-song@kernel.org/
[2] https://lore.kernel.org/bpf/20231031134900.1432945-1-vadfed@meta.com/
[3] https://lore.kernel.org/bpf/20231031215625.2343848-1-davemarchevsky@fb.com/
[4] https://github.com/kernel-patches/bpf/actions/runs/6779945063/job/18427926114

Song Liu (3):
  bpf: Add __bpf_dynptr_data* for in kernel use
  bpf: Factor out helper check_reg_const_str()
  bpf: Introduce KF_ARG_PTR_TO_CONST_STR

 Documentation/bpf/kfuncs.rst |  24 ++++++++
 include/linux/bpf.h          |   2 +
 kernel/bpf/helpers.c         |  19 +++++++
 kernel/bpf/verifier.c        | 104 +++++++++++++++++++++++------------
 kernel/trace/bpf_trace.c     |  12 ++--
 5 files changed, 121 insertions(+), 40 deletions(-)

--
2.34.1

