Return-Path: <bpf+bounces-70057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E693DBAE9D6
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 23:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B3C3B841B
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 21:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933429D295;
	Tue, 30 Sep 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFagmWv8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8329C33D
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267603; cv=none; b=c3ZRUtuIyF2+yrLl+lk20maW05X3jvRIvq6M2cwJyO3nDBZm9RP/2XsJf+SMhZDHAVNwNFqciD4WQYJMpskOntEtBCEBP5qkO1OqQw0cWSbxLOh1NmZqZI+RVNOYys9b5ZJ/cPpix8wyCJwDmipwQP3IGy62rF8cewhmG9N90iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267603; c=relaxed/simple;
	bh=EqCFC27PFbRE5F4ZtwcXXDecgBOs9lodTz7fmtynBRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYOclggRwSzuzGTo8y1P5W1xH9M7bPt/IQbl1TWuTk/B0QXa8VyC3RhfsnD27GxtdafJpJc1FtSuoJIlm+HPfpq4kHWBmiAHCgLKHci5zpbtjz2ZlNGp/AHRrb4OHvRjYiwhINac1CeWBaFNRjrXSo1GXtTnZ06+2EJrqmPhwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFagmWv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE54C4CEF0;
	Tue, 30 Sep 2025 21:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759267603;
	bh=EqCFC27PFbRE5F4ZtwcXXDecgBOs9lodTz7fmtynBRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFagmWv8M54z2xbLozjvT5mz0Wl4+WouqBVcNLqZ5U1KlItJxQ0mjor81FlBFi0K1
	 7TQZPF4pTOZ72tYWAj5tURc1e0/Jd4Bg4+nXmCFiSPUl2nBksndtw46PoYYD+B65xq
	 ZHJQ/cgGmGlPsfHlueW7KTUYGtWKLtvh34+9G/EkrkF8+B771pE5QbIpk9fzL1W18A
	 JKYbHczKi01bKLeROlJUAIWRBtxUvJuYSs226NNTgDtLeYyDSRhggxi75oAgWMvwk/
	 fQVNBM3qex5jAgz4HYggWyHlgZcLbJ5gKiDrd8uWknDCqvfja/ymFKV1DRaYiNCpKs
	 F+egrt8s8uXHw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/5] libbpf: make libbpf_errno.c into more generic libbpf_utils.c
Date: Tue, 30 Sep 2025 14:26:15 -0700
Message-ID: <20250930212619.1645410-2-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930212619.1645410-1-andrii@kernel.org>
References: <20250930212619.1645410-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Libbpf is missing one convenient place to put common "utils"-like code
that is generic and usable from multiple places. Use libbpf_errno.c as
the base for more generic libbpf_utils.c.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build                              | 2 +-
 tools/lib/bpf/{libbpf_errno.c => libbpf_utils.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/lib/bpf/{libbpf_errno.c => libbpf_utils.c} (100%)

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index e2cd558ca0b4..c30927135fd6 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
-libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
+libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
 	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_utils.c
similarity index 100%
rename from tools/lib/bpf/libbpf_errno.c
rename to tools/lib/bpf/libbpf_utils.c
-- 
2.47.3


