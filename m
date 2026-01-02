Return-Path: <bpf+bounces-77681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1ECEED79
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFF7F30019F4
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF1258CCC;
	Fri,  2 Jan 2026 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgGRgVAi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31577F9D9
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367156; cv=none; b=uEjCP9QTc3x3m1cde31g1j+9BgCD5jNVD5e57DqFmk7HbyDrQdRJzLSBwTymr7PGVg3FAxdKOCJuP51WIY7HqluZnZBd+UMw31xEZOtTaD1ITGA/OWCYVshgoF1M1uj3ATqsmf+mRVduuwqln/hA6Kkst0V3T7v4oKtRQ5afIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367156; c=relaxed/simple;
	bh=/AuHRA5pSaM+eE8MGXfMkFuYu1WALIU3m+ZdH293gYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mi43iAx37ddl7Z3Fe9Rx0TgriDSvjKdxmqmulJaPs3DFZ/sSGkfz5lkgN6I5i4r84wHUCBovmqjmzuFZFkFWNbTXAyKffIfaOdfPI1d+WgVDDAA11M2eCPAk30E240zPy212jr9ofgxCuZVCdoYZHTrn4OTmBtzvFj7Jp8XuN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgGRgVAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86722C116B1;
	Fri,  2 Jan 2026 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767367155;
	bh=/AuHRA5pSaM+eE8MGXfMkFuYu1WALIU3m+ZdH293gYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EgGRgVAiLzubobK0P4sCuB2jIxZHw1UxhW9uenrcMOUkKrg5TaSMdczodU5qGNIwY
	 BMmz02LZATL7yV2XXI2OkFdT+XxFkPhTG4DO6ChpixP3RtpAIvecQjm3m6FNKRCI0n
	 ImD11oHFFX9dOAnXm4LKBV0PmQIaGGW+uBYa+jdq0T4m8cC6S+fNVpn1Pi1SqYmEFM
	 IELiCAVzPhKra0sQlEcXApVBiAeZl3glrcj5RTMTnD/PDjOtBGtkCz7EGTVW09JnUa
	 Qv5/r1H+l+zUOKN41OJzRQk2dopT9g5g1duhE4T8XY3X9TlH7FA4qyaDpDLV5+rf17
	 6k+v8dN9UEQ5Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/2] memcg accounting for BPF arena
Date: Fri,  2 Jan 2026 07:18:48 -0800
Message-ID: <20260102151852.570285-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/all/20251231141434.3416822-1-puranjay@kernel.org/
Changes in v2->v3:
- Remove memcg accounting from bpf_map_alloc_pages() as the caller does
  it already. (Alexei)
- Do memcg set/recover in arena_alloc/free_pages() rather than
  bpf_arena_alloc/free_pages(), it reduces copy pasting in
  sleepable/non_sleepable functions.

v1: https://lore.kernel.org/all/20251230153006.1347742-1-puranjay@kernel.org/
Changes in v1->v2:
- Return both pointers through arguments from bpf_map_memcg_enter and
  make it return void. (Alexei)
- Add memcg accounting in arena_free_worker (AI)

This set adds memcg accounting logic into arena kfuncs and other places
that do allocations in arena.c.

Puranjay Mohan (2):
  bpf: syscall: Introduce memcg enter/exit helpers
  bpf: arena: Reintroduce memcg accounting

 include/linux/bpf.h     | 15 ++++++++++++
 kernel/bpf/arena.c      | 34 +++++++++++++++++++++++----
 kernel/bpf/range_tree.c |  5 ++--
 kernel/bpf/syscall.c    | 52 +++++++++++++++++++----------------------
 4 files changed, 72 insertions(+), 34 deletions(-)


base-commit: c286e7e9d1f1f3d90ad11c37e896f582b02d19c4
-- 
2.47.3


