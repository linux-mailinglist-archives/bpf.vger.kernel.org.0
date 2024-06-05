Return-Path: <bpf+bounces-31394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D38FC054
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 02:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9397F284BA6
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 00:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399ED17D2;
	Wed,  5 Jun 2024 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcP/PWfy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C9653
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546592; cv=none; b=EAqGnFQoN4ACj8wLcRGoP7NoMIXLLxB5nRAuYmQdtkEPIiFQWPZMkHPBef2i5hgn9I1UXTtU/Zyh214TsPIJ31AV5idUtADJpBY7LAltTHbZIwWNxONv8o7zeglWhPWzVhsbSPNAbR6ZLoZMLPv6mWNXold7r44pCEimEZSM08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546592; c=relaxed/simple;
	bh=XEeITvqHaqOmwmDjc8OTaOgHoqQLRyeQWtz05fSSwGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmzgrW+/H/ncm0KV3s/BoHzIacV45UA97TisddENYVXp44xSTRJVBqmdpS3NTDfqF0vYI7s+Qpnx603ofIBb+0RG0IbJJMJVHpaJEES0SBy8Dw0We3Vt+m21xSMJDmUMfjSO+UoedBblGy6NOwhP71uj3f6PFucsjoPairSMG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcP/PWfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773BAC2BBFC;
	Wed,  5 Jun 2024 00:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717546591;
	bh=XEeITvqHaqOmwmDjc8OTaOgHoqQLRyeQWtz05fSSwGo=;
	h=From:To:Cc:Subject:Date:From;
	b=WcP/PWfyOBq8l1DLx5sVs81rZfl1fvWW+N2cRyCobzb2dOPwtcIecn6m3cE9rEcrP
	 poKFCdSLMMlKPor9P1xd3YBOBpe1hxH4UZPh+YGYL3VpzpMggfmK0Eg2eOPNS33fnm
	 TNiyBk5XmN8i9bzyPjSfI82pbgPTU1b89yU4lSUIyw3mV8agWjqXq8mya1lK7ZQoWl
	 3B0QZhNhqK74EqvrSkwjuee7WokYoSYys0kjwMrzCvOW8XGMviw7KPsMzFWPxxuaoD
	 tjw20jWezEC9C1l21TfxNJ9jLF4oZXsNcMG5DBUPIZKGxKFGSnibTJxFuU25oi5tcX
	 uNRlehqTtxSTw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 0/5] libbpf: BTF field iterator
Date: Tue,  4 Jun 2024 17:16:24 -0700
Message-ID: <20240605001629.4061937-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BTF field (type and string fields, right now) iterator support instead of
using existing callback-based approaches, which make it harder to understand
and support BTF-processing code.

v1->v2:
  - t_cnt -> t_off_cnt, m_cnt -> m_off_cnt (Eduard);
  - simpified code in linker.c (Jiri);
rfcv1->v1:
  - check errors when initializing iterators (Jiri);
  - split RFC patch into separate patches.

Andrii Nakryiko (5):
  libbpf: add BTF field iterator
  libbpf: make use of BTF field iterator in BPF linker code
  libbpf: make use of BTF field iterator in BTF handling code
  bpftool: use BTF field iterator in btfgen
  libbpf: remove callback-based type/string BTF field visitor helpers

 tools/bpf/bpftool/gen.c         |  16 +-
 tools/lib/bpf/btf.c             | 328 +++++++++++++++++++-------------
 tools/lib/bpf/libbpf_internal.h |  26 ++-
 tools/lib/bpf/linker.c          |  58 +++---
 4 files changed, 262 insertions(+), 166 deletions(-)

-- 
2.43.0


