Return-Path: <bpf+bounces-41332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EB995CD9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E39D1F261AE
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776F1CD2C;
	Wed,  9 Oct 2024 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDHem5H8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156F18EB0
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436563; cv=none; b=QNF4/+BAYDMgWIMqlH/wWpr0ITXAmDQkiQL3PY4pXu5sx/NtT968+iciQWRq4x73Q9Ot3gaEIorR53wnl8pB57hSYeDDwKv4xe5qgtwbVRH7LbMLqBcrOc3vl6PhPrrc8pnseTwCwZJIuvdWVX30GQfOlBr9aCYvM5ik6nPaK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436563; c=relaxed/simple;
	bh=c7D1JS1eC4MKOPqrCsgj8Gigg1QGtCteJwLq5Mo6UMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faZHPa63ry120YcbDgnBRjWQqZKsrBeqiSbWzSPMKFwk1jxi9s3wCNI8P1K/sWDhVmq+jB4d0+lv9N8Glh2ZFljpr9CCfVTu/KhWoybFLWD8/kxrt5uWZe2Efx5gzzGcvFhJWUbaLmNZ3xWV5PBZj2JreIm53Kc3n2oZWt5LvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDHem5H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D66C4CEC7;
	Wed,  9 Oct 2024 01:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728436561;
	bh=c7D1JS1eC4MKOPqrCsgj8Gigg1QGtCteJwLq5Mo6UMk=;
	h=From:To:Cc:Subject:Date:From;
	b=iDHem5H8E4WAN9Kgfh26n+w0qDZnEY0xoem1p5XPAFrm5O98huTzOp8AE8JIRJSyY
	 Oc1NxK4xkEETWuF4nppOEyv6q2MF0Ar8wHMYKIqzQNz2VXnIEpWTXtuJk+jptTGTXA
	 q858f5pH08lz9fs8eH3S1vDa2RH/nfz7wgULuE/nn9Wgvaw6XEifqs5pDXvxzDIs2q
	 HrPlf6/fgXRHSCP0lc2ZoDpMIcT+0ZRxYRBvbj4ME5Dk5itffDcmPOKhYTP+2o8GId
	 MayhV6OL920prfpzDmr/5zoc6IZnPiZan+86rh1oSeekSGBMXdxPQ9zw7iOwcErGj0
	 QYxzj4F6SZaCQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: fix sym_is_subprog() logic for weak global subprogs
Date: Tue,  8 Oct 2024 18:15:54 -0700
Message-ID: <20241009011554.880168-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sym_is_subprog() is incorrectly rejecting relocations against *weak*
global subprogs. Fix that by realizing that STB_WEAK is also a global
function.

While it seems like verifier doesn't support taking an address of
non-static subprog right now, it's still best to fix support for it on
libbpf side, otherwise users will get a very confusing error during BPF
skeleton generation or static linking due to misinterpreted relocation:

  libbpf: prog 'handle_tp': bad map relo against 'foo' in section '.text'
  Error: failed to open BPF object file: Relocation failed

It's clearly not a map relocation, but is treated and reported as such
without this fix.

Fixes: 53eddb5e04ac ("libbpf: Support subprog address relocation")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 712b95e8891b..05ad264ff09b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4013,7 +4013,7 @@ static bool sym_is_subprog(const Elf64_Sym *sym, int text_shndx)
 		return true;
 
 	/* global function */
-	return bind == STB_GLOBAL && type == STT_FUNC;
+	return (bind == STB_GLOBAL || bind == STB_WEAK) && type == STT_FUNC;
 }
 
 static int find_extern_btf_id(const struct btf *btf, const char *ext_name)
-- 
2.43.5


