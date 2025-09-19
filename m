Return-Path: <bpf+bounces-68988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBD7B8B61C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC067B5FF1
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB722D3EC7;
	Fri, 19 Sep 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Q2JxgZAS"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F952773C6
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318093; cv=none; b=ndeC7nkYXOD0YFhJUv3KK6S5LSselVISGoRSAfA1DXB/+VY7LSmN4pRYI+KsDEmQoduoACoy4LPM5w1klzAPc7TAfSrEzygWH5gSvWQdcRQENUC7n83763U+Oi6LVq/JYQw9YNngOCVYY2BTv9wmBYEJdHkWTiwURASNTMjnp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318093; c=relaxed/simple;
	bh=5jhtoP1O26weWAsE/cw0o6gDgDwlS4um1vp3bbUO+kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJYtA5XnUJJ10TMiDR0DK9ZRb4wttklXo/Ekx/z5t5x3x6mQm8eOCrsbpft+S4uepLfr6HX1grQZgkqxYtrhp60b8mZwOXhdJGhndonrWy2+r2xcYw7eNiG80FGsoIu87tLhtkTpgqWkx6ocAXB7jbSYTWd1sc5NHQdfQQl1JIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Q2JxgZAS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tvZXU5PIi+9k1rIdKesS4pltd/yGjh0Ma3skK0F+bFU=; b=Q2JxgZASYmecjfzSaPtpSPV91a
	+KgfBRg9VaLG4QKk81oXhY2Hmu1C03CkPR0cvAwvAYzeX8YTZuwf5eZmTgOJ7BIGIrOGPEJJGZ3Yq
	qMd5hnCqZ4tbcTwPmLkB/5EwVxp1euvIfmS58S3seWGMFeiRmKVHVRntWxwT6OJ0S9GcA4iwxPtZc
	77QFk4jw8XoLqp/iFo9acvPetblYtVOWq6zT4YKfn6utYAQJtReuEbRZU1iHNBWBfchhbT6c24DX5
	sPnupexgsX8KPodjfAcVN6XB6Xj4S+vS9yfh3iwBcEvfTFQnuMQoiUWtOfHvdkEbN2xjpsGE39CIi
	Glz5VsBA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzir7-000Orh-05;
	Fri, 19 Sep 2025 23:41:25 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzir6-000EA4-2m;
	Fri, 19 Sep 2025 23:41:24 +0200
Message-ID: <a85acdf3-fba9-46ba-8950-516405ad653c@iogearbox.net>
Date: Fri, 19 Sep 2025 23:41:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov <aspsk@isovalent.com>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-6-a.s.protopopov@gmail.com>
 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
 <aM0AuFAnqGJgI0Kf@mail.gmail.com>
 <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
 <CAADnVQKsZnOXo-+sK-+=aov80WLgouVPbUXvdg8Na9uU-CmCew@mail.gmail.com>
 <284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net>
 <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

On 9/19/25 9:44 PM, Eduard Zingerman wrote:
> On Fri, 2025-09-19 at 21:28 +0200, Daniel Borkmann wrote:
>> On 9/19/25 8:26 PM, Alexei Starovoitov wrote:
>>> On Fri, Sep 19, 2025 at 12:12 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>> On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
>>>>> On 25/09/18 11:35PM, Eduard Zingerman wrote:
>>>>>> On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>>>> index a7ad4fe756da..5c1e4e37d1f8 100644
>>>>>>> --- a/kernel/bpf/verifier.c
>>>>>>> +++ b/kernel/bpf/verifier.c
>>>>>>> @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>>>>>>     struct bpf_insn *insn;
>>>>>>>     void *old_bpf_func;
>>>>>>>     int err, num_exentries;
>>>>>>> + int old_len, subprog_start_adjustment = 0;
>>>>>>>
>>>>>>>     if (env->subprog_cnt <= 1)
>>>>>>>             return 0;
>>>>>>> @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>>>>>>             func[i]->aux->func_idx = i;
>>>>>>>             /* Below members will be freed only at prog->aux */
>>>>>>>             func[i]->aux->btf = prog->aux->btf;
>>>>>>> -         func[i]->aux->subprog_start = subprog_start;
>>>>>>> +         func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
>>>>>>>             func[i]->aux->func_info = prog->aux->func_info;
>>>>>>>             func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
>>>>>>>             func[i]->aux->poke_tab = prog->aux->poke_tab;
>>>>>>> @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>>>>>>             func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
>>>>>>>             if (!i)
>>>>>>>                     func[i]->aux->exception_boundary = env->seen_exception;
>>>>>>> +
>>>>>>> +         /*
>>>>>>> +          * To properly pass the absolute subprog start to jit
>>>>>>> +          * all instruction adjustments should be accumulated
>>>>>>> +          */
>>>>>>> +         old_len = func[i]->len;
>>>>>>>             func[i] = bpf_int_jit_compile(func[i]);
>>>>>>> +         subprog_start_adjustment += func[i]->len - old_len;
>>>>>>> +
>>>>>>>             if (!func[i]->jited) {
>>>>>>>                     err = -ENOTSUPP;
>>>>>>>                     goto out_free;
>>>>>>
>>>>>> This change makes sense, however, would it be possible to move
>>>>>> bpf_jit_blind_constants() out from jit to verifier.c:do_check,
>>>>>> somewhere after do_misc_fixups?
>>>>>> Looking at the source code, bpf_jit_blind_constants() is the first
>>>>>> thing any bpf_int_jit_compile() does.
>>>>>> Another alternative is to add adjust_subprog_starts() call to this
>>>>>> function. Wdyt?
>>>>>
>>>>> Yes, it makes total sense. Blinding was added to x86 jit initially and then
>>>>> every other jit copy-pasted it.  I was considering to move blinding up some
>>>>> time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-aspsk@isovalent.com/),
>>>>> but then I've decided to avoid this, as this requires to patch every JIT, and I
>>>>> am not sure what is the way to test such a change (any hints?)
>>>>
>>>> We have the following covered by CI:
>>>> - arch/x86/net/bpf_jit_comp.c
>>>> - arch/s390/net/bpf_jit_comp.c
>>>> - arch/arm64/net/bpf_jit_comp.c
>>>>
>>>> People work on these jits actively:
>>>> - arch/riscv/net/bpf_jit_core.c
>>>> - arch/loongarch/net/bpf_jit.c
>>>> - arch/powerpc/net/bpf_jit_comp.c
>>>>
>>>> So, we can probably ask to test the patch-set.
>>>>
>>>> The remaining are:
>>>> - arch/x86/net/bpf_jit_comp32.c
>>>> - arch/parisc/net/bpf_jit_core.c
>>>> - arch/mips/net/bpf_jit_comp.c
>>>> - arch/arm/net/bpf_jit_32.c
>>>> - arch/sparc/net/bpf_jit_comp_64.c
>>>> - arch/arc/net/bpf_jit_core.c
>>>>
>>>> The change to each individual jit is not complicated, just removing
>>>> the transformation call. Idk, I'd just go for it.
>>>> Maybe Alexei has concerns?
>>>
>>> No concerns.
>>> I don't remember why JIT calls it instead of the verifier.
>>>
>>> Daniel,
>>> do you recall? Any concern?
>>
>> Hm, I think we did this in the JIT back then for couple of reasons iirc,
>> the constant blinding needs to work from native bpf(2) as well as from
>> cbpf->ebpf (seccomp-bpf, filters, etc), so the JIT was a natural location
>> to capture them all, and to fallback to interpreter with the non-blinded
>> BPF-insns when something went wrong during blinding or JIT process (e.g.
>> JIT hits some internal limits etc). Moving bpf_jit_blind_constants() out
>> from JIT to verifier.c:do_check() means constant blinding of cbpf->ebpf
>> are not covered anymore (and in this case its reachable from unpriv).
> 
> Thank you for the context.
> So, the ideal location for bpf_jit_blind_constants() would be in
> core.c in some wrapper function for bpf_int_jit_compile():
> 
>    static struct bpf_prog *jit_compile(prog)
>    {
>    	tmp = bpf_jit_blind_constants()
>          if (!tmp)
>             return prog;
>          return bpf_int_jit_compile(tmp);
>    }
> 
> A bit of a hassle.

Yes, hassle, and technically when bpf_int_jit_compile() fails and interpreter
is compiled in, then the latter should only get the non-blinded insns, so above
would not be sufficient as-is.

> Anton, wdyt about a second option: adding adjust_subprog_starts()
> to bpf_jit_blind_constants() and leaving all the rest as-is?
> It would have to happen either way of call to bpf_jit_blind_constants()
> itself is moved.

