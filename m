Return-Path: <bpf+bounces-66738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC13B38E71
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D6774E1E9A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA6B2E1C63;
	Wed, 27 Aug 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P4jpIdmW"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADD72612
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333690; cv=none; b=PC0ceKc0+JEC5w+Bg3jubeJWKjBuUS1yEhQFCwVS7A/tN0SwxZD+ZAESAaaCiKrVUfpUmKZlxKjsPA+83Qp1hNGNAVvgK88RNVtD/0inqHYvQ7sScn3U5m/iMhm4akVvMdEuiqJvpzBLgA2oimTaTSaZhlUEg2DYBkyArS/VH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333690; c=relaxed/simple;
	bh=WmhUhpitk+M1fksgRD3QATbaAN4mdKBQ7BKzuEwVXDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5X0OXcVSsRmpNmkayZiscLOu8gCMVZSLBpUUmy/mTIQx1n613VTRZ5VpQ1OFA2Nej4+D1LBkIi3EUg3j/PauioutwlOis2M4lixY41z0899t1qY4lyykL8WqkmAb58RnGTZDDN+AwxvdNfCKp1N98oQOZ3mqhsOlhm65m5lqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P4jpIdmW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f29deaa-e426-457f-8e93-1fdaa111d3d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756333686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUxbqUkSO58s3byyGyKFemo4dQMbxCx8I/oKnOo6GV0=;
	b=P4jpIdmWyk5D7yEOCu3ECiYeLEo0gFIyPJ1l3/YRcN5J8x1gwevNw30WdocA4yDASV9n0m
	QD5bq3/p/B/QTaYGFKsq/FdFzb6hf5qLWz12fzCH3x5h8W6AxT/15dM3FFNQ3aIEGA5Y8p
	qBBgIOWrDAZ1VBxZIWlkoDdZ0nYJBGQ=
Date: Wed, 27 Aug 2025 15:28:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
 <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
 <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
 <c41268ae-e09c-43e3-9bd3-89b762989ec0@oracle.com>
 <0d5c5cf8e1f3efb35b1f597dae2ae2bf0fb9a346.camel@gmail.com>
 <53ab50de-04e0-48b1-af19-f1dbf60b0927@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <53ab50de-04e0-48b1-af19-f1dbf60b0927@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/27/25 12:52 PM, Alan Maguire wrote:
> On 27/08/2025 20:41, Eduard Zingerman wrote:
>> On Wed, 2025-08-27 at 20:28 +0100, Alan Maguire wrote:
>>
>> [...]
>>
>>> I'm working on a small 2-patch series at the moment to improve this. The
>>> problem is we currently have no way to associate the DWARF with the
>>> relevant ELF function; DWARF representations of functions do not have
>>> "." suffixes either so we are just matching by name prefix when we
>>> collect DWARF info about a particular function.
>> Oh, I see, there is no way to associate DWARF info with either
>> 'bpf_strnchr' or 'bpf_strnchr.constprop.0' w/o checking address.
>> Thank you.
>>
>>> The series I'm working on uses DWARF addresses to improve the DWARF/ELF
>>> association, ensuring that we don't toss functions that look
>>> inconsistent but just have .part or .cold suffixed components that have
>>> non-matching DWARF function signatures. ".constprop" isn't covered yet
>>> however.
>> Is ".constprop" special, or just has to be allowed as one of the prefixes?
>>
> Yonghong can remind me if I've got this wrong, but .constprop is
> somewhat different from .part/.cold in that the latter aren't really on

For symbol with .cold, it is not a function. It is just a jump target
from another function.

For symbol with .part, it is a actual function, but mostly like its
function signature has changed as it is part of the original
function.

For symbol with .constprop, is a clone of another function but
with less parameters, i.e., some parameters become a constant
inside the .constprop.<n> function.

With gcc build, you can see even more complicated suffixes:
   ffffffff81825bf0 t __remove_instance.part.0.constprop.0
   ffffffff81ed07c0 t eventfd_ctx_fileget.part.0.isra.0
   ...

> function boundaries. Sometimes we want to retain .constprop
> representations since they are function boundaries and sometimes do not
> mess with parameters in incompatible ways. If we can find a good
> heuristic for tossing them when they are not helpful as in the above
> case that would be great, but I'm not sure how to do that without losing

It is indeed very hard to have a good heuristic for those function
with suffixes. '<func>.constprop.<n>' might be easier as you can
check location in the subprogrm, if there is no location, most
likely that parameter has become a constant inside the function.

Currently I am working on llvm to add
   - function with suffixes
   - function with changed signature and without suffixes.

Such infomation should have better mapping from func to
its type.

> BTF representations which are useful. Any suggestions on that would be
> really great; in the meantime I'll try and get the series dealing with
> .part and .cold functions out ASAP. Thanks!
>
> Alan


