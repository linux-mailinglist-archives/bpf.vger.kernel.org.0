Return-Path: <bpf+bounces-77606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B6CEC55A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF573007CA9
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698429D26B;
	Wed, 31 Dec 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVCWFqgo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE429C338
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201114; cv=none; b=sA9g+uJgvdy7E8YmtkI3qnw901h5loNn4LRlgmyfcy+He08zacBcQ2sY5V15KKDL4af8E6nnytA9ZxjhtsCjX09IUxIe38RPKmhUcbMbkKBvrxQxCn+kEcurTkMDbcoC/WvhBR8XG3v2mVmCSjXSXavkjYoxF02NqlXIsDyTeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201114; c=relaxed/simple;
	bh=gxgchZuOPiy4CUyRD0RvKuYUtpG1oZ1mphFPRdvd90c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRlwBV+TJ6f8f7LIXoSj6B87rWY/ugR71DgCCnkwe4X0mECUou1qbLcXOse67FJvOGDm5DIkQUd2YhliWDMxo2+kxoUFImG06jzV+AgvGfPnz0cilbo3aVZmDXrfutHh2HQFKguRtdjY56+O3eZV5g2nbzYHJR1wKfyP793Si+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVCWFqgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17BEC113D0;
	Wed, 31 Dec 2025 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201113;
	bh=gxgchZuOPiy4CUyRD0RvKuYUtpG1oZ1mphFPRdvd90c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVCWFqgo8rBI03XCSGpc2zrF1xysAL5xSDNiC0KnnAFSAa34skHRXdHn1mYtGSGwS
	 IhlAw6LfK+2MeA8+R++/U4/STfCHBLp5xnVwTXNczt6Bq6DpmpMUXiEHOR62YbRZ9A
	 zlm3EjW++6HDkCB0pkfXULMEYkgHft40GigPnA5iBC9aV3E5vmWetZRbmEQ6HNR8YQ
	 F35ltd3m+gtLtUSPWS3svNZlwPESnvKzjLOmetw3bMV5QlhzhpJ/7kFqWLzfprHWFg
	 b1g6Qh7YaFlU4///G9nhJIyr80vfiQzn8fXOvic0wtwWJGjVPc2i3NsJAXXOFK7Sve
	 DmLh1Uy9wVF6A==
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
Subject: [PATCH bpf-next v2 6/9] selftests: bpf: fix test_kfunc_dynptr_param
Date: Wed, 31 Dec 2025 09:08:52 -0800
Message-ID: <20251231171118.1174007-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231171118.1174007-1-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As verifier now assumes that all kfuncs only takes trusted pointer
arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument as
__nullable or __opt will be rejected with a failure message of: Possibly
NULL pointer passed to trusted arg<n>

Pass a non-null value to the kfunc to test the expected failure mode.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index 061befb004c2..d249113ed657 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -48,10 +48,9 @@ SEC("?lsm.s/bpf")
 __failure __msg("arg#0 expected pointer to stack or const struct bpf_dynptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
-	unsigned long val = 0;
+	static struct bpf_dynptr val;
 
-	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
-					  (struct bpf_dynptr *)val, NULL);
+	return bpf_verify_pkcs7_signature(&val, &val, NULL);
 }
 
 SEC("lsm.s/bpf")
-- 
2.47.3


