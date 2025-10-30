Return-Path: <bpf+bounces-73067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C64C21D18
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 638E44E2C63
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F15368384;
	Thu, 30 Oct 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZxnqIDK1"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB041F9F51
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850011; cv=none; b=TvpzKlmmBe2eTmHbH/AA8TCqVPRgEDH2NQYozHq6mj9goAl8ZkYTaVj6E5Z//J3opyZaIv7XHNYF5aGFK+csR7cmJz6emL0o0LMnGcH1cBTdYehhsjjS6bGCRcyNFIKvErbm8+sjKxXueOcQTFvy/GesU/9UQFNvNaJWT48lSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850011; c=relaxed/simple;
	bh=pqxNHriMw1r4afu4RkiP94Fn2Ci3RsF9b4eEXwdr8UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdSqJ6gCoErdcFp75wtyCIQ7nurNIofbP2C+os8iGt4zV42pp1YRbY4hb6pWccryj8wFA2ZW0XA41KAowjE8RZu9XSTF5sjNpyxQ7UN0xRfWt9ZfTMuiNXbzBy9Es3GQzaWP6oEeXOQdX72rtcex7AF69JydVlNETBJxJrI+sVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZxnqIDK1; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <710129ad-ebe6-4a92-a21f-3aa1f762fe74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761849997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTn/s4qWennv6WaQpWLMdKogEFBIvv5r2D6SfWS1Xb8=;
	b=ZxnqIDK1ut4lr7E0jW0DFudT2drfORsZzMwF9WRiRr4ZCMXRxYv/A1ZrkGCtaJRmdqYG7D
	4L4Us5nUgJRlb2jq6N3cIsve5aAzh4DYcNyOJrTitigMHvDhiUgpWSUG8T5zJpESyU3ci+
	VzQB2F1GzbZtk/78ZFRM+MdAB+vUbFQ=
Date: Thu, 30 Oct 2025 11:46:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
To: Alan Maguire <alan.maguire@oracle.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, acme@kernel.org, tj@kernel.org,
 kernel-team@meta.com
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
 <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/30/25 11:26 AM, Alan Maguire wrote:
> On 30/10/2025 18:14, Eduard Zingerman wrote:
>> On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
>>> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
>>>> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
>>>>
>>>> [...]
>>
>> Scheme discussed off-list for new functions with __implicit args:
>> - kernel source code:
>>
>>     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
>> 	BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
>>
>> - pahole:
>>   - renames foo to foo_impl
>>   - adds bpf-side definition for 'foo' w/o implicit args
>>   vmlinux btf:
>>
>>     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
>>     void foo(void);
>>
>> - resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
>>   id lists (no changes needed for this, follows from pahole changes);
>> - verifier.c:add_kfunc_call()
>>   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
>>   - Replaces the id with id of 'foo_impl'.
>>
>> This will break the following scenario:
>> - new kfunc is added with __implicit arg
>> - kernel is built with old pahole
>> - vmlinux.h is generated for such kernel
>> - bpf program is compiled against such vmlinux.h
>> - attempt to run such program on a new kernel compiled with new pahole
>>   will fail.
>>
>> Andrei and Alexei deemed this acceptable.
> 
> Okay so bear with me as this is probably a massive over-simplification.
> It seems like what we want here is a way to establish a relationship
> between the BTF associated with the _impl function and the kfunc-visible
> form (without the implicit arguments), right? Once we have that
> relationship, it's sort of implicit which are the implicit arguments;
> they're the ones the _impl variant has and the non-impl variant doesn't
> have. So to me - and again I'm probably missing a lot - the key thing is
> to establish that relationship between kfunc and kfunc_impl. Couldn't we
> leverage the kernel build machinery around resolve_btf_ids to construct
> these pairwise mappings of BTF ids? That way we keep pahole out of the
> loop (aside from generating BTF for both variants as usual) and
> compatibility issues aren't there as much because resolve_btfids travels
> with the kernel, no changes needed for pahole.

We've had a couple of rounds of back and forth on this.

The reasoning here is that going forward we want to make a kfunc with
implicit arguments easy to define. That is:

    __bpf_kfunc int bpf_kfunc(int arg, struct bpf_prog_aux *aux__impl) {}
    BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)

That's it.

In order to keep pahole out of the loop, it's necessary to have both
interface and implementation declarations in the kernel. Something
like this:

    __bpf_kfunc_interface int bpf_kfunc(int arg) {}
    __bpf_kfunc int bpf_kfunc_impl(int arg, struct bpf_prog_aux *aux__impl) {}
    BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)

Which shifts most of the burden of resolving KF_IMPLICIT_ARGS to the
verifier. But then of course both variants will be callable from BPF,
which is another thing we'd like to avoid.

pahole provides an ability to modify BTF only, and make that
bpf_kfunc_impl (almost) invisible to the user, which is great.

The downside is that maintaining backwards compatibility between
kernel, pahole and BPF binaries is difficult.


> 
> I'm guessing the above is missing something though?
> 
> Thanks!
> 
> Alan


