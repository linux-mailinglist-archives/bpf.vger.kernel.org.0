Return-Path: <bpf+bounces-76654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8278CC0768
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB5A53013E94
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3191E25F9;
	Tue, 16 Dec 2025 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mwmdzoit"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F240855
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848721; cv=none; b=fmC5eV25ub5tKFzAxTZsORY/yvjvkEfy/vcqDkEr5egrTBDKvXckG+y0j9H9igbuKNCHbjT3/ng9RjvZIPZIAcazPCRtz88dvW01BwjbTkyaw+Jn0pzFBqcZXu9OXpWnCTBpd1qkEhyukPvV9oiQUfMOv6bZxgVN1Zx/iWGQvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848721; c=relaxed/simple;
	bh=LC8r05fLe2hYe563z3Xy94j/vIQLfyFhduWP99i9SmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clSO3dIAN/1uYxKj/uT6fRskCFmkVf7PQfmLK4bAEe7/rzl7RvKTvgmyax8ZTqG8emdeJ2shNNMKOLG4cVlurhwdYroep0DH9UNAMziKS7hM3Ivv87Ogx/bJjRVMggPaqmWfAj+eWs76CzY7z+aXLOysCNOI8aQMWUawuv0mX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mwmdzoit; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cd2c37e-458f-409c-86e9-cd3c636fb071@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765848712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXNvXf2b3Eq9z1G5L0H6owGsJ0eChNfXY/EEyOk4EJY=;
	b=mwmdzoitBuqdbkA0dRmrsTwrH7HkU9Sf9k9MXxDGx7uq4CWVJuCp9mBeOxpdm6WI2tlon1
	QE6jVbY8XMhuvCR9QeAr1GaaJhRWZGnWz1D5P1LVMKdYiP2L5twumkd7KwF6rDOA9+/DJd
	6j9pWObl9qL3Jz1WsqCnSSr15HKa+e0=
Date: Mon, 15 Dec 2025 17:31:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] next/pending-fixes: (build) error: unknown warning
 option '-Wno-suggest-attribute=format'; did...
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: KernelCI bot <bot@kernelci.org>, kernelci@lists.linux.dev,
 kernelci-results@groups.io, regressions@lists.linux.dev, gus@collabora.com,
 linux-next@vger.kernel.org, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <176584314280.2550.10885082269394184097@77bfb67944a2>
 <20251216122514.7ee70d5f@canb.auug.org.au>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251216122514.7ee70d5f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/15/25 5:25 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 15 Dec 2025 23:59:03 -0000 KernelCI bot <bot@kernelci.org> wrote:
>>
>> Hello,
>>
>> New build issue found on next/pending-fixes:
>>
>> ---
>>  error: unknown warning option '-Wno-suggest-attribute=format'; did you mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option] in kernel/bpf/helpers.o (scripts/Makefile.build:287) [logspec:kbuild,kbuild.compiler.error]
>> ---
>>
>> - dashboard: https://d.kernelci.org/i/maestro:32e32983183c2c586f588a4a3a7cda83311d5be9
>> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> - commit HEAD:  326785a1dd4cea4065390fb99b0249781c9912bf
>>
>>
>> Please include the KernelCI tag when submitting a fix:
>>
>> Reported-by: kernelci.org bot <bot@kernelci.org>
>>
>>
>> Log excerpt:
>> =====================================================
>>   CC      kernel/bpf/helpers.o
>> error: unknown warning option '-Wno-suggest-attribute=format'; did you mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option]
>>
>> =====================================================
>>
>>
>> # Builds where the incident occurred:
>>
>> ## defconfig on (arm64):
>> - compiler: clang-21
>> - config: https://files.kernelci.org/kbuild-clang-21-arm64-mainline-694097d2cbfd84c3cdba292d/.config
>> - dashboard: https://d.kernelci.org/build/maestro:694097d2cbfd84c3cdba292d
>>
>>
>> #kernelci issue maestro:32e32983183c2c586f588a4a3a7cda83311d5be9
>>
>> --
>> This is an experimental report format. Please send feedback in!
>> Talk to us at kernelci@lists.linux.dev
>>
>> Made with love by the KernelCI team - https://kernelci.org
>>
> 
> Presumably caused by commit
> 
>  ba34388912b5 ("bpf: Disable false positive -Wsuggest-attribute=format warning")

Hi Stephen,

A potential hotfix is here:
https://lore.kernel.org/bpf/d80c77cf-c570-4f3b-960f-bbd2d0316fac@linux.dev/

Needs acks/nacks.

> 
> in the bpf tree.


