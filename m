Return-Path: <bpf+bounces-51303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5CCA33094
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 21:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF09188A3A1
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4C20102A;
	Wed, 12 Feb 2025 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oxq/CT7x"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629B271838
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391364; cv=none; b=tzdpo7kDKPnjyj9G3hnwdBhiDyAd6CZ/PGsDN2PznXLoeFAfBR1/LRtAMGnyAIizawIzPxS5D6rLu2POmc1Q0zWr5ed10QjPyAmlT+QXcJ7hwy9SQHAaHSth787zlDlBGYSpkmFJapQszd5Z6rqSAi263kM1KD88HGF0sy39zuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391364; c=relaxed/simple;
	bh=5B7XUY7Nqzv/JAulD/+nuvN7VWFmcG0NDzGHpzzLUec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Udd2SAK0ic2FI1Jy/E9Qa04BN5A63n3u/wtdrh5TQrb0SMb9y8qMoji1lBSz57ShFwYJEMDPKmJwpvwaZ0zfv+1mK4MPseWuQBeatg6JfxedpojC4CWmDzElEd5Bcrq1Ntb2hxxnlF0oJT5h94CUrgNbdAC5xoSDZqAWZhyDiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oxq/CT7x; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739391358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nC7cn+rVIg6MpvIaDSw10GYWFuoeMxoQKkmD5OiTxUw=;
	b=Oxq/CT7xfg29b008y/BkP26YcbU1ZIz2yzEM65Lb++Ey1HmFGP1aQvd1RtlAtpgZ3mRufO
	8Upyme9qMZhuYvc5Z5U7bMICAjkzJRPfD4sRAkDyOkKZqGfDSIfpUALvu9HME7WjanksJt
	DKgZ+8vTyw/BOCxspCDyWuSW9/zH1Zs=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: acme@kernel.org,
	alan.maguire@oracle.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH v2 dwarves 0/4] btf_encoder: emit type tags for bpf_arena pointers
Date: Wed, 12 Feb 2025 12:15:48 -0800
Message-ID: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series implements emitting appropriate BTF type tags for
argument and return types of kfuncs marked with KF_ARENA_* flags.

For additional context see the description of BPF patch
"bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].

The feature depends on recent changes in libbpf [2].

[1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

v1->v2:
  * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
    post-processing step is removed entirely, and kfuncs are tagged in
    btf_encoder__add_func().
  * Nits and renames in patch #2
  * Add patch #4 editing man pages

v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/

Ihor Solodrai (4):
  btf_encoder: refactor btf_encoder__tag_kfuncs()
  btf_encoder: emit type tags for bpf_arena pointers
  pahole: introduce --btf_feature=attributes
  man-pages: describe attributes and remove reproducible_build

 btf_encoder.c      | 282 +++++++++++++++++++++++----------------------
 dwarves.h          |   1 +
 man-pages/pahole.1 |   7 +-
 pahole.c           |  11 ++
 4 files changed, 161 insertions(+), 140 deletions(-)

-- 
2.48.1


