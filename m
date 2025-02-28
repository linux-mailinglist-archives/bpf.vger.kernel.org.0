Return-Path: <bpf+bounces-52899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D8A4A2EA
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97348189B025
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F811EF39D;
	Fri, 28 Feb 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vN6oGCSJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB9277016
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772027; cv=none; b=CYOCydHffZXnCbb0IKGnVHEjfXvHxA8L8ZkM/HaFY+quQQw4IlfSBFIp2ySun9SgPbWAExJWlvrtOwfUitGOegGOLJKlzg5I0+Osg5IRJPdUz/8VKbVnXHTijIrIOoUB76TFYb0eD81GFqDhW2SCv4qyFcp5G74JKQiS5DLaUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772027; c=relaxed/simple;
	bh=ckQNuNmGjM8ecvTnFMutrWxOhwHzxGo6fdCAJ6Ia6sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAg07zKYBMmjiUXWRsiOGD5Z/i9cOT/M6JzlsC3YQ+OxET8miCAZyhe78NZUujCDdTY0MM7X+lddDyrdYwvebLWl7QEMsoez8qV0s0jfE23hFTnRj32PKtWvXtErpqYW6EHfeqfVKdmbzbZlhwk7CM+BEGHQdWyWX3/6tSKticg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vN6oGCSJ; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R6NtA1IcvY6lp5dUu6ImTMyn+vAgJw/OBPwKBKOPKck=;
	b=vN6oGCSJ2ZXCthutI5ziUuKgKerR0T0OK10QFpcgAjYuOiso0A/8keMevSECaQW4X/yaEr
	dtdfJCAv/w3gQJtE47blsDmjHOC3CKsZSGsa6ktA2uTRCi6DU8IbOCOPexPm3godoe1vG7
	HmyV3Glz/6bWd3GmDV1hdvKs2vCSa8E=
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
Subject: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena pointers
Date: Fri, 28 Feb 2025 11:46:48 -0800
Message-ID: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
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

v3->v4:
  * Add a patch (#2) replacing compile-time libbpf version checks with
    runtime checks for symbol availablility
  * Add a patch (#3) bumping libbpf submodule commit to latest master
  * Modify "btf_encoder: emit type tags for bpf_arena pointers"
    (#2->#4) to not use compile time libbpf version checks

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

Ihor Solodrai (6):
  btf_encoder: refactor btf_encoder__tag_kfuncs()
  btf_encoder: use __weak declarations of version-dependent libbpf API
  pahole: sync with libbpf mainline
  btf_encoder: emit type tags for bpf_arena pointers
  pahole: introduce --btf_feature=attributes
  man-pages: describe attributes and remove reproducible_build

 btf_encoder.c      | 328 ++++++++++++++++++++++-----------------------
 dwarves.h          |  13 +-
 lib/bpf            |   2 +-
 man-pages/pahole.1 |   7 +-
 pahole.c           |  11 +-
 5 files changed, 188 insertions(+), 173 deletions(-)

-- 
2.48.1


