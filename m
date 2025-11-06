Return-Path: <bpf+bounces-73762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA7C38B42
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD9054E6F9F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561CF222599;
	Thu,  6 Nov 2025 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TD3Ga5F7"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42922226CFD
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392539; cv=none; b=L/Tyrt4TPKHvErFvdPGOxajkcTGXg00wq5cSaZFFjq25adxxGnaqydReWA1rFZy7pYv1aCj9YGRGIZtKSAiHSGAcap3KHdAB7wW0zcZIpFSctU0fz2Zy/z81ybOtYCwSxIgA8W7sDY7ApU7ypXVbiSfK6h08JuWIis92KBpRU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392539; c=relaxed/simple;
	bh=WcHxGvowN6vG+Ksd0VAe7a4iheX3EK/6aEEiaQ1KOCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urPAmqXGaK2s2MGwzgeyJImjs8SvE81DDIPg1yKOUtzupZzDEipJIR5BxjVRsSS0N0gt1Gx5mWKy8NJpiT1H43v1Mc1TI9lNaeW6pdRflc1RUTvSEBk8iDZAsrlF2utHFoJW8X/QrW60YQCwJ8655nhQOlz86BJCW90OUiDHf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TD3Ga5F7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762392526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dq727exngc8zlm8pfuc4gKjHmwYVM713r4sOIDQK0UA=;
	b=TD3Ga5F7AtcPRUVIVybOYXfHSHOBLVZ23jjikCzcHKmeoLDYPZJ8yDSXDliVV9AVm9ICNU
	36uOQSypZKhKzUVevswSg+/NQexeKldP3wnWrkS73A6RXMp/8+hi23TWylYJmlfZShl7Sm
	XnF4yLdIt2TqEEbLhQeH35/qvR08UKg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF funcs
Date: Wed,  5 Nov 2025 17:28:32 -0800
Message-ID: <20251106012835.260373-1-ihor.solodrai@linux.dev>
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

v3->v4: Error handling nit from Eduard
v2->v3: Add patch removing encoder from btf_encoder_func_state

v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodrai@linux.dev/
v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/

Ihor Solodrai (3):
  btf_encoder: Remove encoder pointer from btf_encoder_func_state
  btf_encoder: Refactor btf_encoder__add_func_proto
  btf_encoder: Factor out BPF kfunc emission

 btf_encoder.c | 206 +++++++++++++++++++++++++++++---------------------
 1 file changed, 119 insertions(+), 87 deletions(-)

-- 
2.51.1


