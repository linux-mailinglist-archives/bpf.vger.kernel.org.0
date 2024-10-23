Return-Path: <bpf+bounces-42920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736EF9ACFFA
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE96DB22574
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B71CC173;
	Wed, 23 Oct 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkfjSJBn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AE1CF28A
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700359; cv=none; b=ogco9lrXT+SbVemamFkdYUkjXIkc4TFThHw2VIF1nwInxFB7z6gv8MvTP6laFph8xPZChaxHZYBjbDx/MyCjaq7tFD+kwbf9t2wpFAvRyn6txr1l/dWtMhxu3RiN1TvOESZYN9eMr/R47Ge8UYL1O1LSVxq6hjAXOIqbYMBM7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700359; c=relaxed/simple;
	bh=USpgvbTZMcJRheOOzUuMhhtF/OZFv+u1yLqt9EKvl4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8CPPjHcTwSjR6aTyLrdJsybuuQDlfcZhkXMRMrYP4mJnOx+eeRRL04k9Xt94AtmukczsozqJBzUtM6/LfbnZn4RevN/vHeqbLSlJh7R8VcpAljIqZwDxe/pxK7X1Mf2/IvClA+7oRcoHN1Bmuvg12PStYF9YEF8nFgs2NdM8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkfjSJBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90716C4CECD;
	Wed, 23 Oct 2024 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729700358;
	bh=USpgvbTZMcJRheOOzUuMhhtF/OZFv+u1yLqt9EKvl4k=;
	h=From:To:Cc:Subject:Date:From;
	b=dkfjSJBnbBDEwsN2zW2gT+ByBqB6cB1ne6dBA7ovfappZTiYLweV33OqH2ILK6MrN
	 frEd6mUERUIyMhYXUJ2RtPyfsv+hvXkCpvGODReOjBXyk+EYnGf1jqIKIsdRFKER/W
	 AUAe1UkZLXAST+HzZnz0ZaimMxlasmY/5LePkPtXYXF/FUVbrst934drzwW2KEd3qL
	 sB0WtKyjaEdgx+Gytc3lDHlWNLJy6vurJy4cfRpGXomVmLD7xr5GR2ligOzUeI5d+K
	 9XHwkgLNNCTTjOfhCuEsTc0RlSASr3gg86k5Dn+11MGUiU33ttnK2nj+gig42UZRx/
	 azYkRNb9O8OrA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf] bpf: fix do_misc_fixups() for bpf_get_branch_snapshot()
Date: Wed, 23 Oct 2024 09:19:16 -0700
Message-ID: <20241023161916.2896274-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need `goto next_insn;` at the end of patching instead of `continue;`.
It currently works by accident by making verifier re-process patched
instructions.

Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Fixes: 314a53623cd4 ("bpf: inline bpf_get_branch_snapshot() helper")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9e2f1cd4975..587a6c76e564 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21210,7 +21210,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_kptr_xchg inline */
-- 
2.43.5


