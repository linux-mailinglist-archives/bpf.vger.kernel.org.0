Return-Path: <bpf+bounces-77296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493C2CD6E61
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A1830361F7
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08D430275E;
	Mon, 22 Dec 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxMJ6TsD"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE502BCF5
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766428526; cv=none; b=lgL3aekjWxuYJ3J3gqIr08Ojv/NvoSBLIJJ5RFVNzyWjkR85JMy/Cq/QRnU/vyoHzdYWlioULopCV1vZxmoU524l0Yb35qbStexHXIsVeS1PhCLtP2PF3NynR9XM6qFLH0fbk5sKdU2ZsYGGNWzMVG6uDgd0RyrrSR1cIxgkHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766428526; c=relaxed/simple;
	bh=vRp40hZl9u3yqPN2eYJU6sVgp9Dd+vm6m3bVcK4OBxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNPkuF7r8tfVCa0rbuwvXgBvdsFjto42o7OppEzHkKLwnRNQOf+VO2WE8qZpIAGkFXyp8vF23rsDyEnTP6/jhktW0/ISmaidRS2H4APhhhp/urMcijoPHpcQV0X4yVTL1TTXLCkYF6nITSuCFQMCiV7DTUJd52YiweySzAPrzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxMJ6TsD; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e806ab68-1820-418b-99c0-0829d1533efa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766428514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRp40hZl9u3yqPN2eYJU6sVgp9Dd+vm6m3bVcK4OBxw=;
	b=gxMJ6TsDZE0avfNL0oAz18ekr1uX/wPJnMUxuTw90QMur1i9rZOXKBftOhuDsKquvB1BqQ
	kkJn3vo9FWo7l14UiMKarR+2qPRPvbqJynD/PX+GhVysOmGK/GjWej8fHaF4x7O7wubBDB
	AbNSHbetAwMWYDCGpdp7a97rZCb+u08=
Date: Mon, 22 Dec 2025 10:35:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests: bpf: fix tests with raw_tp
 calling kfuncs
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
References: <20251222133250.1890587-1-puranjay@kernel.org>
 <20251222133250.1890587-3-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251222133250.1890587-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/22/25 5:32 AM, Puranjay Mohan wrote:
> As the previous commit allowed raw_tp programs to call kfuncs, so of the
> selftests that were expected to fail will now succeed.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


