Return-Path: <bpf+bounces-28991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5F8BF2F8
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C85E1F21DA9
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F2B130AE6;
	Tue,  7 May 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbC/QFHw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203A12EBD8
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124629; cv=none; b=XwRo6Fx+y4B0hmIRwsETsraUZ9DNIXRp3qbag3W/UIB2mZ5YzBZO/gtqvNkztWR5JqGBUuvkMPcC4NyBZSB8KjtbwTp53TOldPuKQYOTnrcM1XnSFA7SyF5bkn4imVKPHyXgZtTeDI3c/I/PPLi8pBE9nXuzoDXGOVVBe4kRJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124629; c=relaxed/simple;
	bh=K/NnQu5gGvpwxpebQf9zdaag+ng94gImfgssHfQNtSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwPKcZTVB36Atf2AnsVem1Chc0nV4tV1pEkdaYSOQjYOe9yvZOAyv3yPXn2VqmsPxXiacLKjFnn+UuU6zRewd6tif2ZH75qjiy4CChgsjdKI+MlJirV1nwRuZo0p2YBcRxg1v3WF3F4Ah/IUKPhOBv8yDfrbN2KFqSpX2h0oCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbC/QFHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1DAC2BBFC;
	Tue,  7 May 2024 23:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715124629;
	bh=K/NnQu5gGvpwxpebQf9zdaag+ng94gImfgssHfQNtSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MbC/QFHwBWtcRNJjjWkITSNSWb0l7FSKiK/SCCBXi0Ex5Xqe85wf3fc+j6EWKED1j
	 c8q7SiohUmfFKXLJzazKc73Ws5GjnzRj3Md5sYKxQ6zX0lqhbkERGW2f7H94qGcRCq
	 uUOYmtNoBW9TEdh052zWfCnywjJbGmlubZZ46rmjTD6Cw+fL/Yzh1BRpMuQnnT9thI
	 ouesHglIOmjPUd0wjahoXl3toqamCQnWYVoUchwKUso6k1U+k3I1Nv2ctoMoCX7yfH
	 fqxjNuBWaBp1h0wDRC2P/x2MYSqdVvDE5jE0CCwFu7/VMtm2nYCx1Vz8zLqnUG713v
	 2cWTg3/oNHd7A==
Message-ID: <e20be6d3-b9c7-4a64-add1-f4c7a6d3a4bc@kernel.org>
Date: Wed, 8 May 2024 00:30:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next] bpftool: introduce btf c dump sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20240506134458.727621-1-yatsenko@meta.com>
 <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2024 22:02, Andrii Nakryiko wrote:
> On Mon, May 6, 2024 at 6:45 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Provide a way to sort bpftool c dump output, to simplify vmlinux.h
>> diffing and forcing more natural definitions ordering.
>>
>> Use `normalized` argument in bpftool CLI after `format c` for example:
>> ```
>> bpftool btf dump file /sys/kernel/btf/fuse format c normalized
>> ```
>>
>> Definitions are sorted by their BTF kind ranks, lexicographically and
>> typedefs are forced to go right after their base type.
>>
>> Type ranks
>>
>> Assign ranks to btf kinds (defined in function btf_type_rank) to set
>> next order:
>> 1. Anonymous enums
>> 2. Anonymous enums64
>> 3. Named enums
>> 4. Named enums64
>> 5. Trivial types typedefs (ints, then floats)
>> 6. Structs
>> 7. Unions
>> 8. Function prototypes
>> 9. Forward declarations
>>
>> Lexicographical ordering
>>
>> Definitions within the same BTF kind are ordered by their names.
>> Anonymous enums are ordered by their first element.
>>
>> Forcing typedefs to go right after their base type
>>
>> To make sure that typedefs are emitted right after their base type,
>> we build a list of type's typedefs (struct typedef_ref) and after
>> emitting type, its typedefs are emitted as well (lexicographically)
>>
>> There is a small flaw in this implementation:
>> Type dependencies are resolved by bpf lib, so when type is dumped
>> because it is a dependency, its typedefs are not output right after it,
>> as bpflib does not have the list of typedefs for a given type.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/bpf/bpftool/btf.c | 264 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 259 insertions(+), 5 deletions(-)
>>
> 
> I applied this locally to experiment. Generated vmlinux.h for the
> production (a bit older) kernel and then for latest bpf-next/master
> kernel. And then tried diff between normalized vmlinux.h dumps and
> non-normalized.
> 
> It took a bit for the diff tool to generate, but I think diff for
> normalized vmlinux.h is actually very usable. You can see an example
> at [1]. It shows whole new types being added in front of existing
> ones. And for existing ones it shows only parts that actually changed.
> It's quite nice. And note that I used a relatively stale production
> kernel vs latest upstream bpf-next, *AND* with different (bigger)
> Kconfig. So for more incremental changes in kernel config/version the
> diff should be much slower.
> 
> I think this idea of normalizing vmlinux.h works and is useful.
> 
> Eduard, Quentin, please take a look when you get a chance.
> 
> My high-level feedback. I like the idea and it seems to work well in
> practice. I do think, though, that the current implementation is a bit
> over-engineered. I'd drop all the complexity with TYPEDEF and try to
> get almost the same behavior with a slightly different ranking
> strategy.
> 
> Tracking which types are emitted seems unnecessary btf_dumper is doing
> that already internally. So I think overall flow could be basically
> three steps:
> 
>   - precalculate/cache "sort names" and ranks;
>   - sort based on those two, construct 0-based list of types to emit
>   - just go linearly over that sorted list, call btf_dump__dump_type()
> on each one with original type ID; if the type was already emitted or
> is not the type that's emitted as an independent type (e.g.,
> FUNC_PROTO), btf_dump__dump_type() should do the right thing (do
> nothing).
> 
> Any flaws in the above proposal?
> 
>   [1] https://gist.github.com/anakryiko/cca678c8f77833d9eb99ffc102612e28

Hi, thanks for the patch - and thanks Andrii for the Cc. I didn't have
time to look at the code yet (will do), but the idea looks great.

My main question would be, how much overhead does the sorting add to the
BTF dump, and if this overhead is low, is it even worth having a
dedicated command-line keyword to trigger the sorting, or should we just
make it the default behaviour for the C-formatted dump? (Or is there any
advantage in dumping with the current, unsorted order?)

Quentin

