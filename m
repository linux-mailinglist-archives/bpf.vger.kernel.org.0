Return-Path: <bpf+bounces-55890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4206A88BDC
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 20:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13FC189AEE4
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D94279785;
	Mon, 14 Apr 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UBZN9XjS"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F513DDC3
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657170; cv=none; b=ZabSqjGT1ZCTKls1+FGT0HHE/wISvbt0BZJvAe9wm7B/7Jl2egZWUFniFr1RQsfNxWPNSEt1DIKI7P9G/90DGZ6x17m14Uxt5uUhx1uGoqyexAJCHX8YVnsw0ybb6SDD4pWkFLxn7YkVfFvLIXnANlk1glzu304yKVYs1N0SYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657170; c=relaxed/simple;
	bh=jqcby5aU8sjBrS4EQPNs0j71WRCd8cBKrejUXGfEjNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikeFS8KrghyAp8zTsOBRjjBnj/UdG5BuwtCspOAEQ6j7AH2LP+gmmAlz5xArD2/k2HvnsnabemKqwLLSzyGZWrfMbqRdrC0DCBVJAlJTgWkUdnzYjNcXcnkEQjtj4XZ3cIOzNzex3rqDfAUNwJXNhG0OT2AV8gw63nhsrtWyFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UBZN9XjS; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744657165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NzGPVflKzUrVqPxT5nn0hlZ7lRcnrSIvdZOA2GajKo=;
	b=UBZN9XjSSpuF3zMBeojyGvbvZtbOiCJehF6gVcwmKrxGorOoL7Uo6RhqJejbeeoargszoP
	GRpOSvyssKeAbKIeQ4pqXaBhJRVaUolWDWrquNzZw2T6kpCR1zhtr+Mikpp0P15I2loWr4
	BzjVlcIBU/evChF6Cz5wkRrlMxIMvXI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] kbuild, bpf: enable --btf_features=attributes
Date: Mon, 14 Apr 2025 11:59:18 -0700
Message-ID: <20250414185918.538195-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pahole v1.30 has a BTF encoding feature for arbitrary attributes, used
in particular for tagging bpf_arena_alloc_pages and
bpf_arena_free_pages BPF kfuncs [1][2].

Enable it for the kernel build.

[1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20250228194654.1022535-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index fbaaec2187e5..db76335dd917 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -23,6 +23,8 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
+pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
+
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
 endif
-- 
2.49.0


