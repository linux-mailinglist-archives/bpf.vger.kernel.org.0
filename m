Return-Path: <bpf+bounces-66381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D0AB334F4
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 06:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE16B1899611
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 04:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72E1D7E5B;
	Mon, 25 Aug 2025 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="VKjBGsVP"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C861A256B
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756095390; cv=none; b=d/m1StOSkzUN0DxIsvYWZKfQpBn6/xebyVYWv71wQvEyrdmP/gmfO0nLIhL+w6H/sMnt315i7grFGBkHCg4SBK9Vu7j4R6j9DkOwfL8lTcbvMJDtLgSwqmpAq3SpSSrQHtYD6a3Y00NZRL8WPNd8w7E7N+FymwRfhpQEcEALlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756095390; c=relaxed/simple;
	bh=Kr9q6uouYXx+lDmM6295nU4JmOjpZZBZe+n5ibrXGP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB30U1/bF0Ll7X0itBdLDKBVs+gWGl0wMyOEXYBm3JY5U9Z64eLYgf8KAMOZArm2kTvVpT5spGemf4i2Pp4T2KcK2EeLU0+5EzsLuMKIBvAOaTHlGPXGDDc1/7YdRwMYGZ0QloXgPIGo2tl8DxndprT/fynGDWgSjSJVMkSDCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=VKjBGsVP; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [10.128.8.2] (unknown [14.139.174.50])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id CD78C44CB4;
	Mon, 25 Aug 2025 04:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1756095379;
	bh=Kr9q6uouYXx+lDmM6295nU4JmOjpZZBZe+n5ibrXGP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VKjBGsVPi+seay6SWGAl6oZ5QLjd26FSr8CDpkJJNFFuLIn90lGlCSKSCj88X07kj
	 lp7obf2gyEJ+gAlFQLjQVrQI176izoAevJ2op061eeZ20fILA6c1TP+TvW6ib0UO5+
	 qehnrgxlOxT7dOSDgaD0uSr8lYKhFj9RbWIoi95Tjn4eKq/uR4OYWlAdG3dnPz8+b7
	 JgW83zDWB3FtI1nEuRha3AWXDvsq3gUn5+YUDqFIlM2FpEB2Iq92cws5LSNezXE4e7
	 kpMVA3yjDfmERZzAXC7iIzyMI91RlnRaTFJrSQ6d5OUApcPrCv55NdOM56U26sRqQW
	 POXcDBjsRzUGw==
Message-ID: <132d5874-9a1f-496f-a08c-02b99918aa59@nandakumar.co.in>
Date: Mon, 25 Aug 2025 09:46:15 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
 <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
 <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
 <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Status as of now:

DECIDED:

1. Replace the current outer comment for the new tnum_mul() with a
    cleaner explanation and the example from the README of the test
    program.

2. (Related to PATCH 2/2) Drop the trivial tests.

UNDECIDED:

Instead of just doing tnum_mul(a, b),

a) whether to do best(tnum_mul(a, b), tnum_mul(b, a))
b) whether to do best(best(tnum_mul(a, b), tnum_mul(b, a)),
                       best(tnum_mul_old(a, b), tnum_mul_old(b, a)))

-- 
Nandakumar


