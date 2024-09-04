Return-Path: <bpf+bounces-38907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DD696C5FF
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7AD1C24694
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2931E00A7;
	Wed,  4 Sep 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oRS5Jxzk"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1B1E1A04
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473340; cv=none; b=ckf3PQwKaMqZ/nBfNZ/KWAzH1wG0ElMhZ+bKqT6VaCEattVKf5g67FnkBDLzP/F4iTFWaKz+VPqV78l7ZAruV14q4/HjkuY9rzDNYZyfohSqRfeSyM3W8XqLCka5aLnOax324X/c0AjLN+s+dEr1MG5AutWdUq7bhlo8gsMKdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473340; c=relaxed/simple;
	bh=fByGkqsjXn6qqon+WDg2ysLIMDouFloDL7sMNuEo6q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oI6iwm+FmMxS9w6djH9pPKVGA0FrvORmU7TbSMB97rbIWk6De6eEDm9V1m6ITa3Q/S8ki5afHOTP4jkLQZ2qz0Rg53fUlBjbRGChwsA+5/KgUJK2961pRzg9I80NzPxF6JKDoljGCoSCLKf/8gnHWRRlk8MYAFzXCS4ygfYEf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oRS5Jxzk; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725473336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jkv91P7bFHRv6ajuNrGmYH+fKmVFawVxl22r/LeRuSM=;
	b=oRS5JxzkbKLAKGinYK4x6svp39C5PQImOOzyp5YTavGryU2LskJP/VAB4GvXWSdnjDG+7/
	wSpmDPEG1rrExyhiaOvoFatPef1ZPWZsQapj8xpgHq3r/e8YXAJzgh1zxyWycRkHicz/E2
	IQ7knhn4iPFJZ9y/3mRwGET1DbGBbRM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] bpf: Follow up on gen_epilogue
Date: Wed,  4 Sep 2024 11:08:43 -0700
Message-ID: <20240904180847.56947-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The set addresses some follow ups on the earlier gen_epilogue
patch set.

Martin KaFai Lau (2):
  bpf: Remove the insn_buf array stack usage from the inline_bpf_loop()
  bpf: Fix indentation issue in epilogue_idx

 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/verifier.c        | 85 ++++++++++++++++++------------------
 2 files changed, 44 insertions(+), 43 deletions(-)

-- 
2.43.5


