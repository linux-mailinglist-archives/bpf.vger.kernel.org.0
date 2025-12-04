Return-Path: <bpf+bounces-76026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55748CA254A
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 05:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D7F30690E1
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 04:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1A2FFDE8;
	Thu,  4 Dec 2025 04:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DI8Ozwt5"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799F265CAD
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823372; cv=none; b=gHU6E6bau+dJPoqZV/elgEH1/E/IKe+sDwmRg0gII2CwKeB2/9klLQuBmJO0PZ90GhpHpumFTVj9KvCA5903az7AUn74Peuk/kg8dm0KzuaM64Dzy3Ggq/lSji/i/VjJMHzT6Yc/kuGz7g+kmkSRopNEXgcdSg/sChGpUOADkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823372; c=relaxed/simple;
	bh=esekPBUqKlGtdMVjw6GTXNVaQcaHd+t3VIOoqceG/9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=so3AGvJylc/mnulZkYz8bgC38cxAJN9bcAAbTST5NsOB+lIUuNe9nBsHAam4EPk8vGAT2vFwvNkIp6FcMXVZtp2ZMvjlIgelvvgL3F1hjp0lPw3yhbJ+vKsdfiiEvuvPaJQsfhv+JG/8Xvmw6sgXsp+wDlnZ/GKiCIjQYrzASJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DI8Ozwt5; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <728c615d-85d7-4a2f-a68e-dc63baf2c4aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764823366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z+GTOBYjteG8LVcY2nZ26KF6tjESc9aTMhTYZP2C9Y=;
	b=DI8Ozwt5H+8F41KTvQ7XVVZZor3bZ4YwJGC1ifB8dlyLX8dQ6AWhKLEvAd+XZz7CmSJpXt
	cyU2Xxjq5se8i7WJLmp6a7f9TKUaTimm3fpIZWdYXoMajTlF4sD2QSeNxDrB+KAUv+xZS6
	ZHDagBfUZ5QMRowA2FxfrlVxNWWNYAM=
Date: Wed, 3 Dec 2025 20:42:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Alan Maguire <alan.maguire@oracle.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
 <CAEf4BzbuHChnpoAGm1EJt6tVbW7yruV14BCD0iMeJmNt1OyEiA@mail.gmail.com>
 <cbafbf4e-9073-4383-8ee6-1353f9e5869c@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <cbafbf4e-9073-4383-8ee6-1353f9e5869c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/3/25 10:48 AM, Alan Maguire wrote:
> On 01/12/2025 22:16, Andrii Nakryiko wrote:
>> On Thu, Nov 27, 2025 at 10:53 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>
>>> +if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
>>> +       exit 0
>>> +fi
>>> +
>>> +gen_btf_data()
>>> +{
>>> +       info BTF "${ELF_FILE}"
>>> +       btf1="${ELF_FILE}.btf.1"
>>> +       ${PAHOLE} -J ${PAHOLE_FLAGS}                    \
>>> +               ${BTF_BASE:+--btf_base ${BTF_BASE}}     \
>>> +               --btf_encode_detached=${btf1}           \
>>
>> please double-check what pahole version has --btf_encode_detached, we
>> might need to change minimal supported pahole version because of this
>>
> 
> yeah, this landed in v1.22 [1]

Thank you for checking!

> 
> One thing worth thinking about; are there aspects of the gen_btf.sh
> script that could be moved to Makefile.btf to avoid having to compute them
> repeatedly for each module? For example computing resolve_btfids 
> flags based on CONFIG_WERROR could be done there I think. You could
> also determine whether the script is needed at all in Makefile.btf; i.e.
> 
> gen-btf-y				=
> gen-btf-$(CONFIG_DEBUG_INFO_BTF)	= scripts/gen-btf.sh
> 
> export GEN_BTF := $(gen-btf-y)
> 
> That would allow you to get rid of the is_enabled() I think.

Good point. I'll try moving most relevant flags to Makefile.btf

> 
> I'm building this now, but I was wondering if the linking/objcopy changes pose
> any risk to kernel address computations in kallsyms or anything like that? IIRC
> Stephen ran into some issues with global variable addresses as a consequence of
> linking BTF sections [2], but not sure if there are additional concerns here.

This series doesn't change the fact that .BTF is *linked* into final vmlinux,
so a problem described in [2] stands.

That said, AFAIU the suggested change in the linker script will still work.

> 
> [1] https://github.com/acmel/dwarves/releases/tag/v1.22
> [2] https://lore.kernel.org/bpf/20250207012045.2129841-2-stephen.s.brennan@oracle.com/


