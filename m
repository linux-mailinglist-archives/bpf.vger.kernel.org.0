Return-Path: <bpf+bounces-21448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A659184D5E4
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417AF1F2514F
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC41C6A8;
	Wed,  7 Feb 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mssZBIBt"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468E1CD3B
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345507; cv=none; b=JxzGP1zDnA9YotkIeq2WFAS9yEALNkrRRRJ9ciLeX6jPfG9gyFBNXZa9GZHM1Ak8C+TdWodflbdO0/R38Pecz2qkYqsK+JGgeRsrEVEbkAlWLLRqGILPMiPtJiF8DgnN2KseSIpaDTr1OYAm5/XhLZq/spz39vXDqPdNfBeK7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345507; c=relaxed/simple;
	bh=EFyFqr97l6eUtvQxtT7/90WiHYa8pTQXRgy7v/s5gN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKe+rdirq5SOoVQ2HuvEgVmfJI/9//Lqmv5gfn1UfabxKPpdkKlvvrwCxEk4wy1iM4us4p9oL68KOdGOQwBy9OcQFLON1dB2R7uTsAhA8XJtLxRIX3peQ2jwaBgzN4jr4BrQrokxhkRmu6uvrB6TbNLUUvkMu5ZLOnz9tc/Bcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mssZBIBt; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4624866-894f-4340-ac97-41bbb683c149@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707345502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dUpLe5VKtRCC+7jeZ0k7zUAyFvR/2Mp/bkeafn7asc=;
	b=mssZBIBtoPBIdlKAhmyokABoi7E0EgSx3LNczeZN69OP4RzE9s0fhmUnLjeGQ2rqWErumg
	JPLhT0p9wlUeZuovjgtNIORxRVgugJo3YLtGhDeKVkTxi8L1I2JkT5DMhSE8Qlk1QDTGRs
	jxyl+PYWs0gCoG9Otfkpy3Ha+2Zg5d8=
Date: Wed, 7 Feb 2024 14:38:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Bryce Kahle <bryce.kahle@datadoghq.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bryce Kahle <git@brycekahle.com>, Quentin Monnet <quentin@isovalent.com>,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
References: <20240130230510.791-1-git@brycekahle.com>
 <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com>
 <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
 <CALvGib8LtTY8qBN+tvZTzb_GKNOX4R9YEUxkOL0ghuQmjG8Yqg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CALvGib8LtTY8qBN+tvZTzb_GKNOX4R9YEUxkOL0ghuQmjG8Yqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/7/24 10:51 AM, Bryce Kahle wrote:
> On Mon, Feb 5, 2024 at 10:21 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> 3) btf__dedup() will deduplicate everything, so that only unique type
>> definitions remain.
>>
A random thought about another way.
At module side, we keep
   - module btf
   - another section (e.g. .BTF.extra) to keep minimum kernel-side
     types which directly used by module btf

   for example, module btf has
     struct foo {
       struct task_struct *t;
     }
     module btf encoding will have id, say 20,
     for 'struct task_struct' which is at that time
     the id in linux kernel.
   Then the module .BTF.extra contains
     id 20: struct task_struct type encoding
     there is no need to encode more types beyond pointers.
     this can be simpler or more complex depending
     on what to do during module load.

When a module load:
   For each .BTF.extra entry, trying to match
   the corresponding types in the current kernel.
   The type in the current type should have same
   size as the one in .BTF.extra if otherwise
   layout in the module btf may change.

   If new kernel type can be used for module BTF,
   simply replace the old id with new id in module BTF.

   Otherwise, type mismatch may happen and the corresponding
   module btf type should be invalidated.

> Since minimization only keeps used struct and union members, couldn't
> you have two internal types from different modules which conflict and
> end up using the wrong offset?
>
> Example:
> in module M:
> struct S {
> ... // other unused members
> int x; // offset 12 (for example)
> }
>
> in module N:
> struct S {
> ... // other unused members
> int x; // offset 20 (something different from S.x in module M)
> }
>

