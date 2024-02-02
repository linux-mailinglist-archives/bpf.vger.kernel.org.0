Return-Path: <bpf+bounces-21079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF046847939
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90102907AC
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C718061A;
	Fri,  2 Feb 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmOs5All"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C601815E5BF
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900734; cv=none; b=cR2lPOb9t77dTV1HFsbeW9w1Burw/H+B6HeMd+0nnqbr6z9DmG1XRCjJeof+07jnjx2AS4g49m0rtHEYR34mXSwwnpGuQjnHxDgY9nHbPB+Op840Bpdx7OHPp0bxG1uNuimyAfJ7I3SpXS6ZeEKKNXF3tIIhZ7CJVOLlvv9L/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900734; c=relaxed/simple;
	bh=4y0Qcn/ILNJg522cNaeEAJjqBBpestSUNtdyvZ2kPEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sh4Wz4QCFcl6BXYm/lAdNWsLgi0na37jf1cx/N/UEiXrmCGs/uIIQaPBQ90LmU3jBiCq6EUsEwobTn2SLN0OrmcGbR0iN6xvJwKK4nfJwBGuXvTExMRHxbi8U2iwFfINiNcKiPFfragC4SitMWqExUaMUYUWU1y6tXYall+tgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmOs5All; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FB9C433C7;
	Fri,  2 Feb 2024 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900734;
	bh=4y0Qcn/ILNJg522cNaeEAJjqBBpestSUNtdyvZ2kPEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmOs5AllfAeUICasmRjbfMPObvbLP00KnjU9BpWA3R1xhs92whXld4xgthhq1NHfB
	 efqklg9b2D0e8n9YWS+uObEgavOCaInjfd5Me3/5Yect2e7rCB+OhTaLucPkOefh9B
	 GQQX6g51QRRsktsgJjW1pJYMSLpczEDkMinKvSdkDqk3hOTP8ZiHLQF3c/3D1fP64m
	 3EyjwYWdpUcIfyBww6tDohcricG1b1XCJzeYl+3+C3rp0yznY9D2yXcN19WS4f2l/o
	 b3CpdykDXGi/o3935HxUoKCfkO9MetIBgOo7YRG4IA0oF8S65eSA3RS25dvHdjBN2y
	 QZMorz8Cen+UA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] bpf: handle trusted PTR_TO_BTF_ID_OR_NULL in argument check logic
Date: Fri,  2 Feb 2024 11:05:27 -0800
Message-Id: <20240202190529.2374377-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202190529.2374377-1-andrii@kernel.org>
References: <20240202190529.2374377-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PTR_TRUSTED | PTR_MAYBE_NULL modifiers for PTR_TO_BTF_ID to
check_reg_type() to support passing trusted nullable PTR_TO_BTF_ID
registers into global functions accepting `__arg_trusted __arg_nullable`
arguments. This hasn't been caught earlier because tests were either
passing known non-NULL PTR_TO_BTF_ID registers or known NULL (SCALAR)
registers.

When utilizing this functionality in complicated real-world BPF
application that passes around PTR_TO_BTF_ID_OR_NULL, it became apparent
that verifier rejects valid case because check_reg_type() doesn't handle
this case explicitly. Existing check_reg_type() logic is already
anticipating this combination, so we just need to explicitly list this
combo in the switch statement.

Fixes: e2b3c4ff5d18 ("bpf: add __arg_trusted global func arg tag")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd4d780e5400..c6f566d9dc3a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8234,6 +8234,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	switch ((int)reg->type) {
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
+	case PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | PTR_MAYBE_NULL:
 	case PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU:
-- 
2.34.1


