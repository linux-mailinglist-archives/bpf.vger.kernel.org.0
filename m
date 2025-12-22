Return-Path: <bpf+bounces-77305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9810CD6F0A
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7858300F70C
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262933B6D1;
	Mon, 22 Dec 2025 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NiES06SQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B433A9D8
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430734; cv=none; b=jAJ5otxXgYNHjyEX9l0IQSyu2kmgQE9fhltgDWMethJpbWwr8cI0g0JNmBbPw+KJkvo8aMjYMGivAuJYFBe3/IrChKwuXBe6msmnbEV8nEN9BvxUzLiNW8LD+I6q5o0/hk5b8fA3sqhlW/ZvydGGB+/h9zDqZZbjc7+AyTaWch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430734; c=relaxed/simple;
	bh=LAkV5LM0Jt0bY/pjONhNnvWxDPStOVr9zmUxKk7pEbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ie2wE4kdwAvdGoU7/nLkxEB4TuAcx5FHNj1f/TerG7MiyZs25/J2sMg05pBsusBEO/ctIdfEcNIcOo+ahFQEUP84wPFERsm/1PFvqkR9LsWgNF62jO2AbRMlHGA2b/UeaHltZ51+mIWc7se/R9N00zcSbtnXHOOdayiKB4mJxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NiES06SQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2252a8ae-847b-4ea7-8389-3f56a0f9e6bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766430730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAkV5LM0Jt0bY/pjONhNnvWxDPStOVr9zmUxKk7pEbg=;
	b=NiES06SQFN7Dn8PbcAOSnGA9Q6wGO5xZLyhkKSeE14kFacgRcFK1Nphq2piYkQX3cDBdqh
	tyXgzWhoGQJEIp7Xxd097B74hwkjgNE1tNRMtA9S16HRBvNm7nud5+/uUN4bKyeZJ9U0NN
	Bk5iA3Nj2mY65EyLSTwQFhCilnDIKrk=
Date: Mon, 22 Dec 2025 11:12:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation/bpf: Update PROG_TYPE for BPF_PROG_RUN
Content-Language: en-GB
To: SungRock Jung <tjdfkr2421@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251221070041.26592-1-tjdfkr2421@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251221070041.26592-1-tjdfkr2421@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/20/25 11:00 PM, SungRock Jung wrote:
> LWT_SEG6LOCAL no longer supports test_run starting from v6.11
> so remove it from the list of program types supported by BPF_PROG_RUN.
>
> Add TRACING and NETFILTER to reflect the
> current set of program types that implement test_run support.
>
> Signed-off-by: SungRock Jung <tjdfkr2421@gmail.com>

Thanks. I cross-checked the kernel and the patch LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


