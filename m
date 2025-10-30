Return-Path: <bpf+bounces-73063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3FC21C40
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A82C34F090D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F3A36CA9E;
	Thu, 30 Oct 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IFj/IK+r"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4727B335
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848715; cv=none; b=r3DRjLJ3P27Ev9gTyKyI/sBDU4jUl4jPibBLZ4cetatjxuv1KB7FggSoB3ozZT64XErKoo30nxNs0si2d6Z08Me43toFpAMg58peVh8ly3OUrTDMu7wDliJDLlCTYnqQTDBAqP0GotSayB65JLYijITvE+CdE+m9CecMXgfoPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848715; c=relaxed/simple;
	bh=2Pgknc5/HB/ig2WIuI4TOGBwp3K6eip0U6UxWDQZXGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/TlAAWfXVGV0xpj3gzNP13Lr9uByJETjNG+blCPIYOuQQvjZcZZAaKsqVHtW3PkTBjx03g0CMExx8M6g/41JpuwtqBAAzKYGENmEAgYOzuGSQ+ZANhGXqACDXI8IxBmZmuyyBpqxDA2thXDUqburtUNXsw/teC+EQB4TZahWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFj/IK+r; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b44aae0-b2d1-4398-8721-04c052aa2a77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761848698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+yFfh/drdvLsI5J861Yzmp6gYUFNxq4s/PjbkZM9BI=;
	b=IFj/IK+rUoaevpTzgqlcQRc0nhFCo3d35zcxQfmoE8FYSanfcpkBFJSSKV3CSHLQiPcV9M
	qDvUd/OSecEQuiOcv7WN76Vc33t+szI4o95DB5M6GfazL8hsqUlOBHhUwhalBaz1bQq6Lf
	9HQCWpj4GLogICzQpqjmy9+U02fsDQ4=
Date: Thu, 30 Oct 2025 11:24:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 tj@kernel.org, kernel-team@meta.com
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/25 11:14 AM, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
>> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
>>> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
>>>
>>> Do we break compatibility with old pahole versions after this
>>> patch-set? Old paholes won't synthesize the _impl kfuncs, so:
>>> - binary compatibility between new-kernel/old-pahole + old-bpf
>>>   will be broken, as there would be no _impl kfuncs;
>>> - new-kernel/old-pahole + new-bpf won't work either, as kernel will
>>> be
>>>   unable to find non-_impl function names for existing kfuncs.
>>>
>>> [...]
>>
>> Point being, if we are going to break backwards compatibility the
>> following things need an update:
>> - Documentation/process/changes.rst
>>   minimal pahole version has to be bumped
>> - scripts/Makefile.btf
>>   All the different flags and options for different pahole
>>   versions can be dropped.
>>
>> ---
>>
>> On the other hand, I'm not sure this useful but relatively obscure
>> feature grants such a compatibility break. Some time ago Ihor
>> advocated for just having two functions in the kernel, so that BTF
>> will be generated for both. And I think that someone suggested putting
>> the fake function to a discard-able section.
>> This way the whole thing can be done in kernel only.
>> E.g. it will look like so:
>>
>>   __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
>>   { /* real impl here */ }
>>
>>   __bpf_kfunc_proto void btf_foo(void) {}
>>
>> Assuming that __bpf_kfunc_proto hides all the necessary attributes.
>> Not much boilerplate, and a tad easier to understand where second
>> prototype comes from, no need to read pahole.
> 
> Scheme discussed off-list for new functions with __implicit args:
> - kernel source code:
> 
>     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
> 	BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
> 
> - pahole:
>   - renames foo to foo_impl
>   - adds bpf-side definition for 'foo' w/o implicit args
>   vmlinux btf:
> 
>     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
>     void foo(void);

I believe it's the other way around:
     void foo_impl(struct bpf_prog_aux p__implicit);
     __bpf_kfunc void foo(void);

foo() is callable from BPF, but foo_impl() is not.
But we still want foo_impl() in BTF so that the verifier can find the 
correct prototype.

Andrii, please confirm.

> 
> - resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
>   id lists (no changes needed for this, follows from pahole changes);
> - verifier.c:add_kfunc_call()
>   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
>   - Replaces the id with id of 'foo_impl'.
> 
> This will break the following scenario:
> - new kfunc is added with __implicit arg
> - kernel is built with old pahole
> - vmlinux.h is generated for such kernel
> - bpf program is compiled against such vmlinux.h
> - attempt to run such program on a new kernel compiled with new pahole
>   will fail.

I think you meant "new kernel compiled with old pahole".

> 
> Andrei and Alexei deemed this acceptable.


