Return-Path: <bpf+bounces-73071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE7C221CD
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 21:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5095B34F505
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393334167F;
	Thu, 30 Oct 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FK+7VgDC"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841933A02B
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854550; cv=none; b=iwWsECjWzI48WCVRtGqUlwLbzVpS+p6QiI+FBCCGLv5MCjRorxKBeMNKt4/UxIf8C6ce/Mg3eTr/k/SvFsKYTVBGLsI6YLTT2HeXCL9JegzCPD1lbdmFGt+XbjI0DWloOnRweKZuATbd/6Sg+6uNORUbPc+3nZmAZLiOz/DeSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854550; c=relaxed/simple;
	bh=G2/pswEmamTiQd76Twvc14/AuBgwOUeGzgGBhlw3Rmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNciImHdCXP52g+LkKpDEMaGfCxEH03SCLzjGbrOsPUneRAseXQRkjuT6h7z+flf46jldjNFbwsjDGP3xixOef1ar9PYNjA0G13mJyzUpXZPDLyAu+DNGyt7KgN/xpawLl78WuJH78Z/dmKPWQPzJB1pqO10tfWPFJFO1c7v3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FK+7VgDC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e17948a1-542a-45b5-8fbc-8f469025b223@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761854536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8041uB6C91QKWQmXkH4JYxDp+fzoROwypk8RVkDYHk=;
	b=FK+7VgDC419cDWLdHgcrokn1u063Fwg8TuDBW3P99f38/weXyckMCCz77lQxE8Tg8XofOX
	03bzmw8ydyqHV85/eD8HW53Ib8bIYjPFYaBmk5xywyI0dfuQrDIQBTRX91b+sbnFU1EYw8
	xsmhCHls9mawkordxFz4xnPLKUhVg1A=
Date: Thu, 30 Oct 2025 13:02:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org, acme@kernel.org,
 tj@kernel.org, kernel-team@meta.com
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
 <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
 <710129ad-ebe6-4a92-a21f-3aa1f762fe74@linux.dev>
 <CAEf4Bza1cXRvw+v1CXmpWBF9ivnk+8-JWOUqRQJ2EE95j3i1Pw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bza1cXRvw+v1CXmpWBF9ivnk+8-JWOUqRQJ2EE95j3i1Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/25 12:47 PM, Andrii Nakryiko wrote:
> On Thu, Oct 30, 2025 at 11:46 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 10/30/25 11:26 AM, Alan Maguire wrote:
>>> On 30/10/2025 18:14, Eduard Zingerman wrote:
>>>> On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
>>>>> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
>>>>>> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
>>>>>>
>>>>>> [...]
>>>>
>>>> Scheme discussed off-list for new functions with __implicit args:
>>>> - kernel source code:
>>>>
>>>>     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
>>>>      BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
>>>>
>>>> - pahole:
>>>>   - renames foo to foo_impl
>>>>   - adds bpf-side definition for 'foo' w/o implicit args
>>>>   vmlinux btf:
>>>>
>>>>     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
>>>>     void foo(void);
>>>>
>>>> - resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
>>>>   id lists (no changes needed for this, follows from pahole changes);
>>>> - verifier.c:add_kfunc_call()
>>>>   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
>>>>   - Replaces the id with id of 'foo_impl'.
>>>>
>>>> This will break the following scenario:
>>>> - new kfunc is added with __implicit arg
>>>> - kernel is built with old pahole
>>>> - vmlinux.h is generated for such kernel
>>>> - bpf program is compiled against such vmlinux.h
>>>> - attempt to run such program on a new kernel compiled with new pahole
>>>>   will fail.
>>>>
>>>> Andrei and Alexei deemed this acceptable.
>>>
>>> Okay so bear with me as this is probably a massive over-simplification.
>>> It seems like what we want here is a way to establish a relationship
>>> between the BTF associated with the _impl function and the kfunc-visible
>>> form (without the implicit arguments), right? Once we have that
>>> relationship, it's sort of implicit which are the implicit arguments;
>>> they're the ones the _impl variant has and the non-impl variant doesn't
>>> have. So to me - and again I'm probably missing a lot - the key thing is
>>> to establish that relationship between kfunc and kfunc_impl. Couldn't we
>>> leverage the kernel build machinery around resolve_btf_ids to construct
>>> these pairwise mappings of BTF ids? That way we keep pahole out of the
>>> loop (aside from generating BTF for both variants as usual) and
>>> compatibility issues aren't there as much because resolve_btfids travels
>>> with the kernel, no changes needed for pahole.
>>
>> We've had a couple of rounds of back and forth on this.
>>
>> The reasoning here is that going forward we want to make a kfunc with
>> implicit arguments easy to define. That is:
>>
>>     __bpf_kfunc int bpf_kfunc(int arg, struct bpf_prog_aux *aux__impl) {}
> 
> I don't think we even need __impl suffix for argument name with
> KF_IMPLICIT_ARGS, right?

I mentioned options that we discussed before in the cover letter.

Basically, pahole needs to figure out how many arguments to omit *somehow*.
Using a name suffix (aka annotation) seems to be the most flexible way, as
it allows to avoid changes in pahole if/when we add new implicit arg types.

> 
>>     BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)
>>
>> That's it.
>>
>> In order to keep pahole out of the loop, it's necessary to have both
>> interface and implementation declarations in the kernel. Something
>> like this:
>>
>>     __bpf_kfunc_interface int bpf_kfunc(int arg) {}
>>     __bpf_kfunc int bpf_kfunc_impl(int arg, struct bpf_prog_aux *aux__impl) {}
>>     BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)
>>
>> Which shifts most of the burden of resolving KF_IMPLICIT_ARGS to the
>> verifier. But then of course both variants will be callable from BPF,
>> which is another thing we'd like to avoid.
>>
>> pahole provides an ability to modify BTF only, and make that
>> bpf_kfunc_impl (almost) invisible to the user, which is great.
>>
>> The downside is that maintaining backwards compatibility between
>> kernel, pahole and BPF binaries is difficult.
>>
> 
> I think we should differentiate backwards compat for all existing
> _impl kfuncs and BPF programs that used to work with them, and then,
> separately, what happens going forward with newly added non-_impl
> kfuncs with KF_IMPLICIT_ARGS and BPF programs that want to make use of
> these _impl-less kfuncs.
> 
> For existing _impl kfuncs ("legacy" case), backwards compat is 100%
> preserved, even if the kernel was built with an old pahole that
> doesn't yet know about KF_IMPLICTI_ARGS. There will be BTF for both
> _impl and _impl-less func_protos, all that will work. And BPF programs
> are explicitly calling _impl kfuncs. So even if pahole didn't do
> anything special for KF_IMPLICIT_ARGS, verifier should work fine, it
> will find _impl BTF, etc.
> 
> For all new _impl-less kfunc definitions and/or BPF programs that
> switch to _impl-less calls, yes, we will document and require that
> kernel BTF has to be generated with a newer pahole. We can enforce
> that in Kconfig, but it's a bit too strict/too soon as it's irrelevant
> and unnecessary for the majority of BPF users that don't care about
> _impl-less stuff.

I think some kind of build-time enforcement will be necessary.
It's *very* easy to unintentionally use old(-er) pahole version
for kernel build, especially when the new version is recent.

> 
> Keep in mind, right now we have 4-5 such _impl special functions, but
> going forward we will probably have lots. sched-ext is poised to use
> that very extensively throughout a lot of its kfuncs, so requiring
> these explicit _impl wrappers just to support older pahole with newer
> kernels I think doesn't make sense in the grand scheme of things.
> Getting the latest pahole released/packaged/used for kernel build for
> distros shouldn't be a big deal at all. It's not really like upgrading
> the compiler toolchain at all.
> 
>>
>>>
>>> I'm guessing the above is missing something though?
>>>
>>> Thanks!
>>>
>>> Alan
>>


