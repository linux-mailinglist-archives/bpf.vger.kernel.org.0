Return-Path: <bpf+bounces-68528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A5B59C97
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABD6482B52
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F26371EA7;
	Tue, 16 Sep 2025 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hcv7u1/Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4352371EB3
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037960; cv=none; b=rJaRt6Xisoy3w1pET8UdizAtveX4pQ8NSOpCNQRGvFLv/nV0wk/5rhLTm1M/i9vDqu2/LDauUjzrdgfDHGKNrwLBDw6oC+NMn1Vbx5SCiyo8tcWKDyBMHL1KGrE8hOh0c9Ousk24N0QVFvF4h8ZAMYA9VobOsfrgLTC6rFWiSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037960; c=relaxed/simple;
	bh=zLogIUQfjN90DsfVQszT/RJ0E7wUnOkcyo6exmVmY/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPqIjo6437HMvkoXmqfSTAbUwg7LA6CV0aVOeAlaDxHz6tKf6CzzmJo5KzJeAb+EBi2HKbgWuhEuEyEC3v4TnSk/4tq6p42rbBqFzba9HSb+6pGk0YSNOTbanArZmBgAOrBVNP/scTNwjdG1yCDOHDv0UiVCQC6TIppEtQDF0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hcv7u1/Y; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758037956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MM/1iOdBfee7UinVEA2suRJCfd+3AXgaab4GkLtBc0Q=;
	b=hcv7u1/Yt3kL4da5azzvZSSDQywoedaonfx7nljEoEMo5NnUs51j8vkysER6/BbYO7HM8I
	aCHt1AFi/0wa2SBtx6Dia4BJDHEHzXxnyegy4NHr8VMBZknZ8KPr2ZVpydhX/YOYMTD7Hf
	tNlhHWH4kcFNnHis22k9iCCet2R2UKA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	yatsenko@meta.com,
	puranjay@kernel.org,
	davidzalman.101@gmail.com,
	cheick.traore@foss.st.com,
	chen.dylane@linux.dev,
	mika.westerberg@linux.intel.com,
	ameryhung@gmail.com,
	menglong8.dong@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/3] bpf, x64: Add union argument support in trampoline
Date: Tue, 16 Sep 2025 23:52:10 +0800
Message-ID: <20250916155211.61083-3-leon.hwang@linux.dev>
In-Reply-To: <20250916155211.61083-1-leon.hwang@linux.dev>
References: <20250916155211.61083-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As verifier allows functions with 'union' argument can be traced, add
'union' arguments support in trampoline if the argument's size is in
range '(8, 16]'.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8d34a9400a5e4..f30d3455ecf07 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3164,7 +3164,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	/* extra registers for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+		if (m->arg_flags[i] & (BTF_FMODEL_STRUCT_ARG | BTF_FMODEL_UNION_ARG))
 			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 	}
 
-- 
2.50.1


