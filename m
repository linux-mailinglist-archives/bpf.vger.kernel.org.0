Return-Path: <bpf+bounces-51983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0293A3CAEA
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3DD1660A4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026AF25335A;
	Wed, 19 Feb 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lv0sWPn7"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFF25335D
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999131; cv=none; b=fJa/YV6FmAZ3hHuBokgZaaDCEjizwYjBBqjZVJsQHPpnX9RHzDVwgnTd8atqMNph+tQhpWBMXBOflMHxjCpuEWNtokHOp3H4xT5BWiHnENrMpJf2aiNo4mwa7bWDNK+SkFl2XoUUBdbPZNNNNyktudtyFxvMBpassn2YpRd7qHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999131; c=relaxed/simple;
	bh=RDNSzPt7ShA3Rnf15yh6odlzN8CCjDVq6sV8TF6IvlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncdmJUQRf1vWy6xbfFl3oj03ctjYBLSAHae3Jzfhp4zVuAstLfUHnQk+Eqi6iHtxl2wZGl1X4SEKfgQeeQ2AvYz1pbWbPxcQF7I6EVB1fEF7rQkzu0R2YNZDBHnK+xBDSZ1cLxro41wZPrM63zfqtyLcxPa3zKvs3LxIs+rEBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lv0sWPn7; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739999127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cWZ0db+RoQgD8qTJHTANRLZGuTVn3avW8QgDO1JPepY=;
	b=Lv0sWPn707n30/CMS4xeDVLHUN13dAh9t/nqnSSfWSU6SA/FOMP89U5HjZtiG8Msu8ORh6
	VmckpjP8iRIVmr3plneh8CwXrm3baYXpJw43UveXb+fDhDzLBXrX8zXycZiTlOOzfg2pkz
	+HW7adwdEi0rdCCdz/F/yOeyO98xn2Q=
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
Subject: [PATCH bpf-next v3 0/4] btf_encoder: emit type tags for bpf_arena pointers
Date: Wed, 19 Feb 2025 13:05:16 -0800
Message-ID: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
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

v2->v3:
  * Nits in patch #1

v1->v2:
  * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
    post-processing step is removed entirely, and kfuncs are tagged in
    btf_encoder__add_func().
  * Nits and renames in patch #2
  * Add patch #4 editing man pages

v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solodrai@linux.dev/
v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/

Ihor Solodrai (4):
  btf_encoder: refactor btf_encoder__tag_kfuncs()
  btf_encoder: emit type tags for bpf_arena pointers
  pahole: introduce --btf_feature=attributes
  man-pages: describe attributes and remove reproducible_build

 btf_encoder.c      | 279 +++++++++++++++++++++++----------------------
 dwarves.h          |   1 +
 man-pages/pahole.1 |   7 +-
 pahole.c           |  11 ++
 4 files changed, 158 insertions(+), 140 deletions(-)

-- 
2.48.1


