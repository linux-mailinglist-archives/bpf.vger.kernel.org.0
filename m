Return-Path: <bpf+bounces-21470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FCB84D7AF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 02:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949551C23D2A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFCD1947E;
	Thu,  8 Feb 2024 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ku8D9lky"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309411E87C
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357429; cv=none; b=Z8vh3kOJaH4QWj6PpXGRHPLiYw87VjGb4XsFlYNFPzQ5pbrg1whWZayH4J2h0cY1mEmhQzzGH+myyMWQBQNhambvBZzYz0sFHXAypTx6XhsXQcdb6/irJEtz8r+IL5KE6SNzjErxHsoWsVSAcfaHkWopWzvnOFfoXKrpl926EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357429; c=relaxed/simple;
	bh=RiV03NKPDB5s3O4Z40AdB4yD/HtacZNmnJx1ahpQEgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTmHQLVLHcHFKmwsWTdnfFFSvgZIh/8fGM5nftLEK7gH11/Rot4GlPVJl2PSlbIqbe+DJPmYFz7ccKdIBzWl2t/8hoMwEBLVDdDMUuvrWtMS8S+fFzY3ePWA1V2q4anTV2plVHU3XFFXf/2LM14nSatNITxSe8RYOB7t1MdXmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ku8D9lky; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f4b6a8d-a4ea-48ff-b195-d00ce2f2fe52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707357424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMQ8YdFT1/WHFequwgApGGz/m97qjfkueX9bBa6+/nY=;
	b=Ku8D9lkybP1ZAW8dvFqvSnFaqSRgguqmpnm4SqZPnVEl12O+AdPQkCEkOhm7iK6U6PcJm7
	Kpk3ZDn54GDpMBuBGkg4wTFiE0xDlMH+tzUp/wLIEf4tEFJviBe51MavSZVSt9CZAgm7Q3
	DMey+wSoNX/SY0WOWZUbrP5n9by7aCE=
Date: Wed, 7 Feb 2024 17:56:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bryce Kahle <bryce.kahle@datadoghq.com>, Bryce Kahle
 <git@brycekahle.com>, Quentin Monnet <quentin@isovalent.com>,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
References: <20240130230510.791-1-git@brycekahle.com>
 <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com>
 <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
 <CALvGib8LtTY8qBN+tvZTzb_GKNOX4R9YEUxkOL0ghuQmjG8Yqg@mail.gmail.com>
 <c4624866-894f-4340-ac97-41bbb683c149@linux.dev>
 <CAEf4BzZ94O0=PGczhtCMc+-T1DoNUV1rG5TsfFq1qFahbMptyg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZ94O0=PGczhtCMc+-T1DoNUV1rG5TsfFq1qFahbMptyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/7/24 4:30 PM, Andrii Nakryiko wrote:
> On Wed, Feb 7, 2024 at 2:38 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 2/7/24 10:51 AM, Bryce Kahle wrote:
>>> On Mon, Feb 5, 2024 at 10:21 AM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>> 3) btf__dedup() will deduplicate everything, so that only unique type
>>>> definitions remain.
>>>>
>> A random thought about another way.
>> At module side, we keep
>>     - module btf
>>     - another section (e.g. .BTF.extra) to keep minimum kernel-side
>>       types which directly used by module btf
>>
>>     for example, module btf has
>>       struct foo {
>>         struct task_struct *t;
>>       }
>>       module btf encoding will have id, say 20,
>>       for 'struct task_struct' which is at that time
>>       the id in linux kernel.
>>     Then the module .BTF.extra contains
>>       id 20: struct task_struct type encoding
>>       there is no need to encode more types beyond pointers.
>>       this can be simpler or more complex depending
>>       on what to do during module load.
>>
>> When a module load:
>>     For each .BTF.extra entry, trying to match
>>     the corresponding types in the current kernel.
>>     The type in the current type should have same
>>     size as the one in .BTF.extra if otherwise
>>     layout in the module btf may change.
>>
>>     If new kernel type can be used for module BTF,
>>     simply replace the old id with new id in module BTF.
>>
>>     Otherwise, type mismatch may happen and the corresponding
>>     module btf type should be invalidated.
> Yes, I agree, see my reply to Alan. I'm just unsure how strict we want
> to be and whether we need to record fields of expected vmlinux BTF
> types. Or if just recording expected size would be enough (to ensure
> correct memory layout if base BTF type is embedded into module BTF
> type).
>
> Perhaps, if BTF type is referenced from some "trusted" BTF type (used
> by kfunc, or in BTF ID set) we might want to enforce strict
> compatibility, but for any other type just make sure that size is
> correct (if it matters at all; i.e., if base BTF type is referenced by
> pointer only, we don't even need to check size).

Agree. The above is a good start. I guess some real-world investigations
can help shape the actual design about what is the minimum change to
make it work.

>
> WDYT?
>
>>> Since minimization only keeps used struct and union members, couldn't
>>> you have two internal types from different modules which conflict and
>>> end up using the wrong offset?
>>>
>>> Example:
>>> in module M:
>>> struct S {
>>> ... // other unused members
>>> int x; // offset 12 (for example)
>>> }
>>>
>>> in module N:
>>> struct S {
>>> ... // other unused members
>>> int x; // offset 20 (something different from S.x in module M)
>>> }
>>>

