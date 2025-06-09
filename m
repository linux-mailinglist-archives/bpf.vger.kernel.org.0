Return-Path: <bpf+bounces-60099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCECAD28F4
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FE5160C07
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13921FF49;
	Mon,  9 Jun 2025 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DAhiRgCe"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7A1401C
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505820; cv=none; b=YLN+/idHnjsRUm89qhJsMjnuAqrsrrp+N0K3V8auZCO/fXqiZSMrQyNJ9U9fubqDDPzq7l8MnmOpMZauIxK2RYhHfrY+/Bge3kk8vkxFsVxTazNn/o8cduX828LYmP9SsVdU/OTDoG8GHS52O0oBxDXce+hAXAY2ftAF8qz9KWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505820; c=relaxed/simple;
	bh=IUTwAphWgJacqZzXuUcXpIQzKEy/zEhPJ1GKx2EbSas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaxCR+jPhefVPq2JJLDBEYxFZocTY2P9ld2NgUH254zUl9eZ9vCVScxQ1Ph72gFM3eSU94BdTs1daN5GG2Siz6VKoBkien5ODLDtq4uhi5t+Y81n3bNCLy3WdNJ5vsVxUdKCb2QUkZ7ObeAQxvR6jH7U/P8FMyI5OInVfN64p84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DAhiRgCe; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27e23bda-eaf9-4fb2-991c-71dbb3ee9f4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749505804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gf07GSMj+WxyCGAFqt8qw1Fl21dEj2hZCLfaOZpV9+0=;
	b=DAhiRgCeabofWEy2yg3Wo3UFkN2Jg/rSYJJCoSHNSlgMsXnw61w8DeQN0rRI4uweOhhmXu
	Y+jd8SqXPB1E+DxtgC+470/gYEEmRkct9hIzRUh46gvRQDI3T9Phg061syixaoiIu8yVWp
	oAy0HLQIt+BZXis+RyunJ0R4jnZ1C0c=
Date: Mon, 9 Jun 2025 14:49:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF CI update: veristat-scx job
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Kernel Team <kernel-team@meta.com>, kernel-ci@meta.com,
 Alexei Starovoitov <ast@kernel.org>, tj@kernel.org, mkutsevol@meta.com,
 scottbpc@meta.com, jakehillion@meta.com, mykolal@meta.com
References: <c17b2e6c-3626-4d69-8784-01b13a9e2851@linux.dev>
 <CAEf4BzbWZrg1Aq1p0c2h-s2Ro=Fm2Dk1uE7frFynOd3CwZqFZA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzbWZrg1Aq1p0c2h-s2Ro=Fm2Dk1uE7frFynOd3CwZqFZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/9/25 2:43 PM, Andrii Nakryiko wrote:
> On Mon, Jun 9, 2025 at 2:30 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>
>> See an example of successful job run here:
>> https://github.com/kernel-patches/bpf/actions/runs/15543439297/job/43761685117
> 
> Unsuccessful veristat runs are actually more interesting :) Do you
> have a link to some examples with veristat failures?

Here is a recent one (although it's not that interesting either):
https://github.com/kernel-patches/bpf/actions/runs/15496531493/job/43634843627

> 
>>
>> [1] https://github.com/sched-ext/scx
>> [2] https://github.com/libbpf/veristat
>>


