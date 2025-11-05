Return-Path: <bpf+bounces-73692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8330C3767F
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 19:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5DB1895C7A
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F77314B74;
	Wed,  5 Nov 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIrIVMWq"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B014318151
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369195; cv=none; b=J0IllJNdG7GDdZithpN/k+Wg3d9Ead/YQb4Oi1Cdlrk8bpvl4MqgZjwYSCu7GXrmWQ9fzCqeQDn1xpcXWKuh7cMFlxevWnDJG9GZd2c7oY/grS0GgKs4f2aAiP9j07SOVPxW8IuBVocQffxS8NbOqku8raQAjKxTW3I0Kpm/XPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369195; c=relaxed/simple;
	bh=3GwN5gWb07Yf5LOcMgdhPtd1aiTrudPwLqJ4k/U+JCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h31+7pEO+V81fDWQyvCuN9VKfWC91zSr1KFiEPqnRD8mRDSqY4RxgnqmYDLEVu544Fqx7l6zOu5AfRPc0wU5Vcv3XRBloxOU15KGXn+/K2NIRQhEgUNDQnL5StHnwJC3uWixstlq0VY801LgnWDKaRXrFfc5o33XRZw5WZvcDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIrIVMWq; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762369182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ArQX/hFYiBzDmap8PQiaxRMbGd76dktq6M3+JyIauSY=;
	b=uIrIVMWq52vlGdnIkfacilq22rSLri3ZM1/+oo2YTwZCTkVdeRBWO07XYd2xZpFcMHBSdX
	GY7McJeXKav45eYdVCeJ6OvKouxpCdHNcxi63yBr1b0QYlHqNtQe1KgramLUlJhsteZEOU
	HJ77ErUBmahykAEqXgwZC+yFEU/IjEg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v3 0/3] btf_encoder: refactor emission of BTF funcs
Date: Wed,  5 Nov 2025 10:59:23 -0800
Message-ID: <20251105185926.296539-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series refactors a few functions that handle how BTF functions
are emitted.

While addressing comments from Eduard, I noticed that we don't
actually need to carry the encoder in btf_encoder_func_state, because
only one encoder exists at all times. So in v3 I added a patch
removing encoder from the state struct, which resolves the ambiguity
of where state->encoder should be used.

v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/

Ihor Solodrai (3):
  btf_encoder: Remove encoder pointer from btf_encoder_func_state
  btf_encoder: Refactor btf_encoder__add_func_proto
  btf_encoder: Factor out BPF kfunc emission

 btf_encoder.c | 204 +++++++++++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 87 deletions(-)

-- 
2.51.1


