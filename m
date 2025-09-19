Return-Path: <bpf+bounces-68914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4317B881F7
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 09:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3311C868FE
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44F2C0263;
	Fri, 19 Sep 2025 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfun22rc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF429E110
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265962; cv=none; b=KoNRFY+D42nMxn6+CLLFegJUopixqQO9jdSOqytydTIAHMftqqtIzq807fxW7BKkZ5+VuV946YbCN7++lc3Xy53DnP9AgSK9+lulYbAR4zVXX8se/HvIctwGZxeIm6gekt+5muNTBezHpRGpiUKg0XNo4fwDz3SunSrlq1W8BEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265962; c=relaxed/simple;
	bh=+QR7/M5FtmV7w721SMdyUR6puPYYOsBj/ZhJT3a7/hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9/sGUICDqEPO27U6hUnxsEgZaLUkBMj/rj54r73NNKtivqWHE6nSFV0zAfuGHosMm8aaIw4GwY0b1yhUxGhfPL95NzcGC6cwWu3OAdsYssf+i2ZnaaxW5FDgsS4/xBYiyNSevKK0oZaxCgXUcm8ooBbF2TNKYTgxrABWagSXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfun22rc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25669596955so16112825ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758265960; x=1758870760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=POHVsRimi3J17qY1SN712Cw6fNZmUltua2AzaycJWQE=;
        b=hfun22rcmZQtpmGfOdgZ4PW6sHdEF7p32j7E/ZAN/s2+TUBN0ubBbKa0VKwBj5QzmY
         9z6fg/wMwYYD05HPdZLpadhSUF4rnFuKJzXjvRlR2p+aKRVNtfcguqn6KCO+kRgxMh1T
         L8UNKM3OMkIdz7t8P4t2D7Wg0W1DYdduqomqFp57fjy8YUZXvYC0T98BU3NTmzOjf6Az
         7jNxcgv8hs0aEQH7EdluMWqz8tdUMiXtuIRJklWX5VswHxzBKohqLh8IDqvqYvzmQd2T
         qY8OHdPMD1oRHXYFO64/xQ/vrkaaQYpXLmelCtQmNjETGzg1LFLIiAM6o4Hyjmyq3dWu
         TVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265960; x=1758870760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POHVsRimi3J17qY1SN712Cw6fNZmUltua2AzaycJWQE=;
        b=L81mRVikDEqNvepstLIRwkQfHbVYsujI4ZjYMvEqZLEvFczZqFQxhrySrajTa+btsn
         nHCeCGhwNzTZbahdSb7pjq9jh/tfwHR+tLDUuqnSlmz1eEJVCSaGwWdJZZEC67ExIwHU
         44zAEXQFWm91P3Ktix6YcEZ46HmCsToJG4dF10pguS/bpLPQxzMO1az++67UoFtJagKN
         pjcsVWT+kE3ec6HHySVRaF6N23BEz1P+WnU407/NUb2Cz9LXb/V8bTJWGe2fQ6SXTOL7
         P9URiFSF8IfY/6Z73VYq4ToPFG2p+diCBsedp8S/kNRaA+jjwx/OpBShh4hM4Qo866Rb
         j7Pw==
X-Gm-Message-State: AOJu0YxHT3k1N9OR5zdCcEYqRFARiz9XE+5S5s1+uEU9a5aTOxMEfDfm
	XmB72M0ieyervp00CjG3k5iN6om+UByaRaa0YF102U4GkoI4nRcWQSZc
X-Gm-Gg: ASbGncsV48kimR8UE2S6UFqsZSLXpiP7MhbB3PLwFohbtdtlRZ5b67eGqjb7eHZ8p6Z
	zn87JLVTgSNQs2Lm18aMiQOsWK3tgjR0QSFxkcwinq5v0q0q718C0eqslsOpVNCryAMtocg4FHd
	Nb6/NwCDw28YPcGeYWYeJD7N/l/FTGabDfS26dAZzHfUBdoJvF231F5OSPESYtegGu3xzCeDNS7
	APEoL3r/xZyysXZY8zCaCPXl9PKDa3xrZTBrJwo2H/wXLdKtc1U7gg7hLxkPgggeN45ipBAGqxE
	KkqcJ0YLMiWYy2KmhFwZrkxV31qwzvCSThY40ICiLF2VFifzCUDlKal0nywGWmKCZT9UaKfst/i
	/EWr46Mq8rpkxOv+AJUFbyzQHQsmAjA==
X-Google-Smtp-Source: AGHT+IF/Q0TDfbjBO1pawOgliYOvfTXDQvUQljAsuYuBMtTIfDe6OMlnHfJtgoaqB9PiZRpM2iqrQw==
X-Received: by 2002:a17:903:1a0d:b0:268:db2:b78e with SMTP id d9443c01a7336-269ba593019mr26826375ad.60.1758265960454;
        Fri, 19 Sep 2025 00:12:40 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3303ffe611csm6308834a91.9.2025.09.19.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:12:40 -0700 (PDT)
Message-ID: <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 00:12:37 -0700
In-Reply-To: <aM0AuFAnqGJgI0Kf@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-6-a.s.protopopov@gmail.com>
	 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
	 <aM0AuFAnqGJgI0Kf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
> On 25/09/18 11:35PM, Eduard Zingerman wrote:
> > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index a7ad4fe756da..5c1e4e37d1f8 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_e=
nv *env)
> > >  	struct bpf_insn *insn;
> > >  	void *old_bpf_func;
> > >  	int err, num_exentries;
> > > +	int old_len, subprog_start_adjustment =3D 0;
> > > =20
> > >  	if (env->subprog_cnt <=3D 1)
> > >  		return 0;
> > > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_e=
nv *env)
> > >  		func[i]->aux->func_idx =3D i;
> > >  		/* Below members will be freed only at prog->aux */
> > >  		func[i]->aux->btf =3D prog->aux->btf;
> > > -		func[i]->aux->subprog_start =3D subprog_start;
> > > +		func[i]->aux->subprog_start =3D subprog_start + subprog_start_adju=
stment;
> > >  		func[i]->aux->func_info =3D prog->aux->func_info;
> > >  		func[i]->aux->func_info_cnt =3D prog->aux->func_info_cnt;
> > >  		func[i]->aux->poke_tab =3D prog->aux->poke_tab;
> > > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_=
env *env)
> > >  		func[i]->aux->might_sleep =3D env->subprog_info[i].might_sleep;
> > >  		if (!i)
> > >  			func[i]->aux->exception_boundary =3D env->seen_exception;
> > > +
> > > +		/*
> > > +		 * To properly pass the absolute subprog start to jit
> > > +		 * all instruction adjustments should be accumulated
> > > +		 */
> > > +		old_len =3D func[i]->len;
> > >  		func[i] =3D bpf_int_jit_compile(func[i]);
> > > +		subprog_start_adjustment +=3D func[i]->len - old_len;
> > > +
> > >  		if (!func[i]->jited) {
> > >  			err =3D -ENOTSUPP;
> > >  			goto out_free;
> >=20
> > This change makes sense, however, would it be possible to move
> > bpf_jit_blind_constants() out from jit to verifier.c:do_check,
> > somewhere after do_misc_fixups?
> > Looking at the source code, bpf_jit_blind_constants() is the first
> > thing any bpf_int_jit_compile() does.
> > Another alternative is to add adjust_subprog_starts() call to this
> > function. Wdyt?
>=20
> Yes, it makes total sense. Blinding was added to x86 jit initially and th=
en
> every other jit copy-pasted it.  I was considering to move blinding up so=
me
> time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-aspsk@=
isovalent.com/),
> but then I've decided to avoid this, as this requires to patch every JIT,=
 and I
> am not sure what is the way to test such a change (any hints?)

We have the following covered by CI:
- arch/x86/net/bpf_jit_comp.c
- arch/s390/net/bpf_jit_comp.c
- arch/arm64/net/bpf_jit_comp.c

People work on these jits actively:
- arch/riscv/net/bpf_jit_core.c
- arch/loongarch/net/bpf_jit.c
- arch/powerpc/net/bpf_jit_comp.c

So, we can probably ask to test the patch-set.

The remaining are:
- arch/x86/net/bpf_jit_comp32.c
- arch/parisc/net/bpf_jit_core.c
- arch/mips/net/bpf_jit_comp.c
- arch/arm/net/bpf_jit_32.c
- arch/sparc/net/bpf_jit_comp_64.c
- arch/arc/net/bpf_jit_core.c

The change to each individual jit is not complicated, just removing
the transformation call. Idk, I'd just go for it.
Maybe Alexei has concerns?

