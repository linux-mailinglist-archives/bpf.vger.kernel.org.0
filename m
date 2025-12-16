Return-Path: <bpf+bounces-76661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC6CC0928
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D873013952
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609612D9EF3;
	Tue, 16 Dec 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibSCGHiN"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207632D8DB1
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850883; cv=none; b=stmA5r2XeXokKqW/73wyPbjg2aLwRD+j/YVbl0IMKim/2/d7xR6a9mXoTQTm81Z8QYPoVcoE8wRtXRcUwxY0LNktRznJBBYW9PGgflHF6Uy+nncxc43O0nnhLCwoNQOuGPaSX6BcuZSAAe/ZOi3xmF/2LALHZReVk2+ycm7YtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850883; c=relaxed/simple;
	bh=bIQ6IcNZeBjRNiHyZJt0848kAV2lLn17BQZPhUtOLLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2+HlCelLZw/wxh4g2h3Qrm28pCwwtfCS5A3AW+o8wCgYKnPlPHkxmK/ygM0GnT5KtU0qSF1z0U0C7/dFk5q/Q1pl1CwOh6a54G7gF3WLAS0CJbWfzwaexVeYTdHcvKMZFprbodZx0YaHiBlRefPZJnUIyM+Vl08+ACcnlxJNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibSCGHiN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03d63f28-01f7-4195-9210-f6ce0c8a4dcd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765850867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKCNhAdUISI5J2FgHdslWi3UHrTEte2sHYUrKfSgadc=;
	b=ibSCGHiNA5a/mNju1S2HZH15z1nJnD64aegFhK+10DG3oH+rnSuPpTqysZq3isOKHdx4z/
	dZoO00JWc16SHFzyo8YQA9NQ4MHOCt44mzM0sVxdWk0zBlmAWcfNn0h17esS1RLa8HtEus
	OsiYfTqVuXgGangiO8Ss/2UeUX2/jlk=
Date: Mon, 15 Dec 2025 18:07:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] next/pending-fixes: (build) error: unknown warning
 option '-Wno-suggest-attribute=format'; did...
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, KernelCI bot <bot@kernelci.org>,
 kernelci@lists.linux.dev, kernelci-results@groups.io,
 Linux Regressions <regressions@lists.linux.dev>, gus@collabora.com,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <176584314280.2550.10885082269394184097@77bfb67944a2>
 <20251216122514.7ee70d5f@canb.auug.org.au>
 <3cd2c37e-458f-409c-86e9-cd3c636fb071@linux.dev>
 <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/15/25 5:37 PM, Alexei Starovoitov wrote:
> On Mon, Dec 15, 2025 at 5:32 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 12/15/25 5:25 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> On Mon, 15 Dec 2025 23:59:03 -0000 KernelCI bot <bot@kernelci.org> wrote:
>>>>
>>>> Hello,
>>>>
>>>> New build issue found on next/pending-fixes:
>>>>
>>>> ---
>>>>  error: unknown warning option '-Wno-suggest-attribute=format'; did you mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option] in kernel/bpf/helpers.o (scripts/Makefile.build:287) [logspec:kbuild,kbuild.compiler.error]
>>>> ---
>>>>
>>>> - dashboard: https://d.kernelci.org/i/maestro:32e32983183c2c586f588a4a3a7cda83311d5be9
>>>> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>> - commit HEAD:  326785a1dd4cea4065390fb99b0249781c9912bf
>>>>
>>>> [...]
>>>>
>>>
>>> Presumably caused by commit
>>>
>>>  ba34388912b5 ("bpf: Disable false positive -Wsuggest-attribute=format warning")
>>
>> Hi Stephen,
>>
>> A potential hotfix is here:
>> https://lore.kernel.org/bpf/d80c77cf-c570-4f3b-960f-bbd2d0316fac@linux.dev/
>>
>> Needs acks/nacks.
> 
> I removed the offending patch from bpf tree.

Thanks. The CI is green now at bpf/master tip (1d528e794f3d):
https://github.com/kernel-patches/bpf/actions/runs/20253601894

