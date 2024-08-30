Return-Path: <bpf+bounces-38501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B509654A7
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79C91C2163C
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90428DD0;
	Fri, 30 Aug 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T/x+KRdX"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFB4A2F
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980945; cv=none; b=Pm96nRwYi6th01dZXaNaBJergADxQTW/uLidjSkdJfdBuLntbxmHqoo+1/5ywEQyTTE70btKfHv8JJUfN/r6bw1/S9xHNWamLsUvMk+aYIWySghHm8GZeS8BSo1+HvkVDWnqwMLRb329n0ICUgSFdxQnDwUFu0rhYr1l8doxjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980945; c=relaxed/simple;
	bh=VtqeRBS1aTVgSaYUAHxVwFG1dhZY76qoUatES7sTT2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYovBfK3fJ6+ZI0Aw3wDazlDideZFACcxfkNNSBEa1GxTNaFKo9heaB0TpI2d8jgi+JgeQpMarxyneKWihRt4ByqSY/7Hmo4u9whbUgy7JOpGgR0SR9tMWX7FZPTBnzp00Yst0PQ2ZmPP9XeA8bSogi+DYCswhyjNikLlqEtb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T/x+KRdX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724980941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lJhDAS3XFgEKfHyWHHDQ+c00q7Zff6y2UoJOnusdOVg=;
	b=T/x+KRdXknoft9a/w0HnwTsbZR7qia7Q83tIesnBtfUVrZlEpAN867FBZaT4pOL11aDZ7C
	wk+XZk6ebbhhFt2tYVTxA0yoIUyY1/KWepE9E3G05UchT51AEyUN4PLnPiCvnGRAg/8kE3
	IUSyLOoAOajkoC7ZRwI4qpx5gNCug1I=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf] bpf: Fix a crash when btf_parse_base() returns an error pointer
Date: Thu, 29 Aug 2024 18:22:14 -0700
Message-ID: <20240830012214.1646005-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The pointer returned by btf_parse_base could be an error pointer.
IS_ERR() check is needed before calling btf_free(base_btf).

Cc: Alan Maguire <alan.maguire@oracle.com>
Fixes: 8646db238997 ("libbpf,bpf: Share BTF relocate-related code with kernel")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
It was discovered in a bpf CI run that crashed in s390 due to
the wrong endian in the btf header. It caused the btf_parse_base()
to fail and triggered this crash.

This patch is tested in the bpf CI. It fails to load the bpf_testmod
but does not crash the kernel:
https://github.com/kernel-patches/bpf/actions/runs/10623574366/job/29450422150?pr=7630

 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..e3377dd61f7e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6283,7 +6283,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 
 errout:
 	btf_verifier_env_free(env);
-	if (base_btf != vmlinux_btf)
+	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
 		btf_free(base_btf);
 	if (btf) {
 		kvfree(btf->data);
-- 
2.43.5


