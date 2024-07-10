Return-Path: <bpf+bounces-34449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC27B92D8BE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760611F24FDE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6A198827;
	Wed, 10 Jul 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG7NlbkQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405D197A7B
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638230; cv=none; b=hfn0N5HCMV7GdQkSCgfrq8jSvsq823ZSZXq5GFdRFjCr5zYj5Ya5+gQiUxu/BOMnIF5ohK4hPwlPbQEWIx47XhabAxlf6dyt+ZZHz+n4r8mD4caS102sEbbene/WpftMMqSl/dY08sMWBQIGMo90RJIF0b1IbZSDRPJ3e4kB6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638230; c=relaxed/simple;
	bh=Ln1OTiJMSuMg4r+DNu+enzW37/upcnTn0RVHvLbSg18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YY5+4wd+4rBqK0JZ8rH13LuTpvn+w4n/f+V82w9UG5xKt3hy1iPDVDxuOQmh8wmLicVakYlYU1ubkhAgSJdLozSE0J2AGL2bcLCe6hIRdfF9SaSGJedRD/8SKrfNV/u1wPXOTd3FfLmqPWIkbHiZmQA4W0zu2Rb3/CIK99Qpr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG7NlbkQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70af0684c2bso126201b3a.0
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720638228; x=1721243028; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x1vJowV7BdEyZNITI0f9l5o8QvSi2ubg7kUAWWEnXAI=;
        b=jG7NlbkQmDRsRYoiIN4h8+jkfKkHlaoMHZ73raphPFVYKxbp3gFG9+OkZHpeQS5H9a
         xJFTjxf5sumF/mRzNlJueHcgB/0DcDfimLdYSj9Ern845z/nLrWmiD892yaGjXgWJUit
         nKdOpcMeDPgj5oxJc942JwWB2PAIZjUzvCwEtvG7vwxKgQoC741jcyhVHz3FYVCOoF+C
         q/tCj1KCOD6S9dLsP5qoeDv0/AT5bLljk2AY27eAlAnK2XITcTFcwn/uLyHD6dgYE920
         9JcvuE5h5vnOQJMmvf521UC/ugJxfEbSyKmQLedpowDKKa8a4V8/qTGFM292N4nQL+7B
         y6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638228; x=1721243028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1vJowV7BdEyZNITI0f9l5o8QvSi2ubg7kUAWWEnXAI=;
        b=XnMRqtR0m3NmPKPqdb26IwprWiCEI6HWP8d9jr1zULXjsEIscD8+wsTcdK8emI6UJg
         cfsHaudbQMWHYIp34JO1mPuah3tuTSt7q2/NuS3+QFKRa6JHg2wjVIFksRXbYcEhYO64
         eH7EqHRMn23RCacGrwmwYa5tXpPnNqjeBziyQP7kLbjW6koOa3HPDAqsqqTwcs2//obS
         igfQXE7Ym7anrjwreKxIpYi+wNY+DlbXTcplhnKA/3xl9x2Clt48rM039uvo3rLRqoQ0
         nCOKX1dGxF3J/Xe+MGg2nA56J8llrM0dF7uCdxTM6ShDUNm+zmpvGiA4m+v5XNcRS4Br
         8gXg==
X-Gm-Message-State: AOJu0YyYr9wEHKIuYX6MYnSbn69OGoZVZuSSOFUCGHj831OpghrWnvmV
	uFjodahKM64aTKmQTvrLkzjV2lOa2wjraWtBcAvsw+Jy5xlVtIsH6lMOLw==
X-Google-Smtp-Source: AGHT+IFzzif4217y2J/QoYzONXM0/bs4viya3iVMtoqTE/rMP2lcmwo/TIsEsF+O3pbXGA1Pkvl8oQ==
X-Received: by 2002:a05:6a20:734c:b0:1c0:f328:8e5a with SMTP id adf61e73a8af0-1c2984cdf96mr6551870637.47.1720638228034;
        Wed, 10 Jul 2024 12:03:48 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967545sm4135400b3a.115.2024.07.10.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:03:47 -0700 (PDT)
Message-ID: <a317a04fc5b51d2c11b2cce6055b35a326183c43.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  puranjay@kernel.org, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 12:03:42 -0700
In-Reply-To: <CAEf4BzZD=1KmBi-t=qPcfFU=BrH0qDkLgjbBjNCohhBv2vc1EA@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-3-eddyz87@gmail.com>
	 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
	 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
	 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
	 <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
	 <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
	 <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
	 <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com>
	 <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com>
	 <CAEf4BzZD=1KmBi-t=qPcfFU=BrH0qDkLgjbBjNCohhBv2vc1EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 11:49 -0700, Andrii Nakryiko wrote:
> On Wed, Jul 10, 2024 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2024-07-10 at 10:50 -0700, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > > > Ok, I see, this wasn't obvious that you want this behavior. I act=
ually
> > > > > find it surprising (and so at least let's call this possibility o=
ut).
> > > > >=20
> > > > > But, tbh, I'd make this stricter. I'd dictate that within a subpr=
ogram
> > > > > all no_csr patterns *should* end with the same stack offset and I
> > > > > would check for that (so what I mentioned before that instead of =
min
> > > > > or max we need assignment and check for equality if we already
> > > > > assigned it once).
> > > >=20
> > > > This makes sense, but does not cover a theoretical corner case:
> > > > - suppose there are two nocsr functions A and B on the kernel side,
> > > >   but only was A marked as nocsr during program compilation;
> > > > - the spill/fill "bracket" was generated for a call to function B b=
y
> > > >   the compiler (because this is just a valid codegen).
> > >=20
> > > In this case the call to A shouldn't be changing nocsr_offset at all,
> > > though? You should find no spill/fill and thus even though A is
> > > *allowed* to use no_csr, it doesn't, so it should have no effect on
> > > nocsr offsets, no?
> >=20
> > Consider the following code:
> >=20
> >     *(u64 *)(r10 - 24) =3D r1;
> >     call A                     // kernel and clang know that A is nocsr
> >     r1 =3D *(u64 *)(r10 - 24);   // kernel assumes .nocsr_stack_offset =
-24
> >     ...
> >     *(u64 *)(r10 - 16) =3D r1;
> >     call B                     // only kernel knows that B is nocsr
> >     r1 =3D *(u64 *)(r10 - 16);   // with stricter logic this would disa=
ble
> >                                // nocsr for the whole sub-probram
>=20
> oh, you mean that r10-16 accesses are valid instructions emitted by
> the compiler but not due to nocsr? I mean, tough luck?... We shouldn't
> reject this, but nocsr is ultimately a performance optimization, so
> not critical if it doesn't work within some subprogram.

Not critical, but the difference between allowing and disallowing nocsr
for this case is '<' (current) vs '=3D=3D' (suggested) check for .nocsr_sta=
ck_offset.
I think that current algo should not be made more strict.

> > > But your example actually made me think about another (not theoretica=
l
> > > at all) case. What if we have calls to A and B, the kernel is slightl=
y
> > > old and knows that B is nocsr, but A is not. But the BPF program was
> > > compiled with the latest helper/kfunc definitions marking A as no_csr
> > > eligible (as well as B). (btw, THAT'S THE WORD for allow_csr --
> > > ELIGIBLE. csr_eligible FTW! but I digress...)
> > >=20
> > > With the case above we'll disable nocsr for both A and B, right? That
> > > sucks, but not sure if we can do anything about that. (We can probabl=
y
> > > assume no_csr pattern and thus allow spill/fill and not disable nocsr
> > > in general, but not remove spill/fills... a bit more complication
> > > upfront for longer term extensibility.. not sure, maybe performance
> > > regression is a fine price, hmm)
> > >=20
> > > So I take it back about unmarking csr in the *entire BPF program*,
> > > let's just limit it to the subprog scope. But I still think we should
> > > do it eagerly, rather than double checking in do_misc_followups().
> > > WDYT?
> >=20
> > With current algo this situation would disable nocsr indeed.
> > The problem is that checks for spilled stack slots usage is too simplis=
tic.
> > However, it could be covered if the check is performed using e.g.
> > process I described earlier:
> > - for spill, remember the defining instruction in the stack slot struct=
ure;
> > - for fill, "merge" the defining instruction index;
> > - for other stack access mark defining instruction as escaping.
>=20
> Sorry, I have no idea what the above means and implies. "defining
> instruction", "merge", "escaping"
>=20
> As I mentioned above, I'd keep it as simple as reasonably possible.

It should not be much more complex compared to current implementation.

    1: *(u64 *)(r10 - 16) =3D r1; // for stack slot -16 remember that
                                // it is defined at insn (1)
    2: call %[nocsr_func]
    3: r1 =3D *(u64 *)(r10 - 16); // the value read from stack is defined
                                // at (1), so remember this in insn aux

If (1) is the only defining instruction for (3) and value written at (1)
is not used by other instructions (e.g. not passed as function argument,
"escapes"), the pair (1) and (3) could be removed.

> > >=20
> > - on the first pass true .nocsr_stack_off is not yet known,
> >   so .nocsr_pattern is set optimistically;
> > - on the second pass .nocsr_stack_off is already known,
> >   so .nocsr_pattern can be removed from spills/fills outside the range;
> > - check_nocsr_stack_contract() does not need to scan full sub-program
> >   on each violation, it can set a flag disabling nocsr in subprogram in=
fo.
>=20
> I'm not even sure anymore if we are agreeing or disagreeing, let's
> just look at the next revision or something, I'm getting lost.
>=20
> I was saying that as soon as check_nocsr_stack_contract() detects that
> contract is breached, we eagerly set nocsr_pattern and
> nocsr_spills_num to 0 for all instructions within the current subprog
> and setting nocsr_stack_off for subprog info to 0 (there is no more
> csr). There will be no other violations after that within that
> subprog. Maybe that's what you mean as well and I just can't read.

Ok, I'll send v3, let's proceed from there.

[...]

