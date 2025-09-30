Return-Path: <bpf+bounces-70008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98147BAC2A1
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 11:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F937A952F
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89472853F1;
	Tue, 30 Sep 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYbcZse5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8CC7D07D
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222934; cv=none; b=lMEpFD5dg6Dzh8XxZ830YAUdHGtgXNXO2adyxYPxHQToqG7fprjXblo4D6aVGkF8mxqNko8Qr2JJbzHwGII+UErJXKQGDaxGXXSGH6J1Nu2+2BnEJA91MQlTw5ydP4xjq19ZJtGqJPJyLApcRz7i9vg+lNf7SnRzKg7JX8kyM8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222934; c=relaxed/simple;
	bh=8cA29iBU8VAAXKJXKbsOGxeRiMAs9PB7kcOg6wbZNKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC0/dNn2BNMkz4s3AK9I1CYW6ABa9DQr56DP7Pw6RXDiKi1P3GzdxkGgxRBIl+Z4q9XhfdCtPn+qmaXgbwnKO/E4agyewshpPnhiuXddfuKQCFYTrJpRJMTk1lnJ4QYROdT3uiZIJRVIY4dlPr4Zyi5yGdmE0wPbFA+8xVoqPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYbcZse5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso4341000f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222930; x=1759827730; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0YeFKVTA92RsSMsTUK9J2VEX6PqfTv9kdKMH8GkOS+E=;
        b=TYbcZse5tKWSZLoV3amUf2ddwTnfp+wECt7ZPPxkuLMdWxLlUXXJ7x/1HwQWZTR5u5
         xRVWmUSm0Rnj45BxKp3WLcCp4j65+7mZUDQGx4tiOtbYbdIr/H07aTbebdfauxfekVSj
         AV6oLhD34tcY+hAzgZQX7QKRxKUlHeibbp6bbdHXkN19H8IQslyVgbwRqvTvj5Vc13rz
         W1+RboTBcSuBkhedK82IdRlA/duJrPoDz9sePRIEPxTzKmgz657O0knvAHVgNpsnrVPS
         ML7kZ6R3LuD0+d5uu5SR1HSrCa4v5T68lfLoSqe0vD+9k97DCE0gXLS48NEQjhOw2fK0
         U+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222930; x=1759827730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YeFKVTA92RsSMsTUK9J2VEX6PqfTv9kdKMH8GkOS+E=;
        b=Fv75p5ZLRdiqkmrSgqEi9vWKAcL8jrWv4u/WIVbnOSxB4RhgaUrp9J2AE9Zjqmfe9D
         zXTSbpddzfiqMYYSqE9SpIUm3B3Yz9wQxCDKZThMTWbwuFsKuZXHzaW8Y7PG2Zt89yY2
         W1y5pGjwTmZ3zfMEhxXnkAKub+Jo8Yk1MEGqLQpZfJG/jFA5H8ZhdfJLNuzAk+5QSu+M
         gwZtyxVKHcTt+GoipWgVZlCX8ooNqFEUMiukMEuI2EVJHVQgeXpJqOuhXotRHao0uW6H
         Cxd3F357R61j/Xd/FPHvBZ3YH3H/JQTF5W2dw4NxxoKRlNb4RSqZzgXuF/Jda/giNKlx
         GnHw==
X-Forwarded-Encrypted: i=1; AJvYcCX7zfXsil4/HnKdSRIz6wFQSNhfH5DN0VnDslYXxfV21z7Kxv+FHAensoOW/OEVjWfRFzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/ofTvz2TZw+U+bfX73HcL+TSlXJS5l2Sb6uT65bL4Kf9/lKt
	+0vPgf76lsRGC2b9UA+a66eYjalpJ+fq/SKvdDS8NQFhH+nnnhEpMvtt
X-Gm-Gg: ASbGncuYdH8Ji75ICQW0MgiJHUIrly1IvtRuHbZFzy3KuulJrtmdKKi0J+FXnfxvI0D
	SqBOm64ua2OB8AX7m4jvbM07CY4s0xIhr/q6KyZDHg2/3dG7vMRAX64KAV8o2QJOyE8hQG6oU25
	z9VbAam0o5Q85AUjx5Qzlife4t65pVlvSOO8CE9tyILckLlf7WfkIkU4seY3OzrEJ0M7ifh8NJP
	D+bkmjtpQPyRVVX+yO13Vvafc0PGblW33cbnXx4UWfkW3NHSdtjFaIhw+IvBMLmn0OE7cMUirHH
	RLErEoW7mzfJOs0Po6qJIM6azzg3a1DAmKfb70Y6baM1AdMveZqA2MnfSZt+8p+C1hcLT5hrryt
	R4xzn8uwwSktTSGOzYKriGR1DwQEp3ckxaEM3J74jxLevJUcpEMc/Tb2C
X-Google-Smtp-Source: AGHT+IEM9GJZ075ajqvPEmLLEhL1ayoGfiYUT1m0rXMqvB0EUXZsfAlvPyrWlRR31Ay08OzXtYdb9g==
X-Received: by 2002:a05:6000:240c:b0:3ec:e152:e31c with SMTP id ffacd0b85a97d-40e429c9ba3mr15790220f8f.1.1759222930254;
        Tue, 30 Sep 2025 02:02:10 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc56f7badsm21582293f8f.29.2025.09.30.02.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:02:09 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:07:50 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
Message-ID: <aNud5j56WV+4L0LX@mail.gmail.com>
References: <20250918093850.455051-6-a.s.protopopov@gmail.com>
 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
 <aM0AuFAnqGJgI0Kf@mail.gmail.com>
 <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
 <CAADnVQKsZnOXo-+sK-+=aov80WLgouVPbUXvdg8Na9uU-CmCew@mail.gmail.com>
 <284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net>
 <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>
 <aM28lJL8ivnbr1yf@mail.gmail.com>
 <60c2444047bd44be26f9410515177d6ad2d1f1e2.camel@gmail.com>
 <aNEWx4TqHE0pzuB0@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNEWx4TqHE0pzuB0@mail.gmail.com>

On 25/09/22 09:28AM, Anton Protopopov wrote:
> On 25/09/19 01:47PM, Eduard Zingerman wrote:
> > On Fri, 2025-09-19 at 20:27 +0000, Anton Protopopov wrote:
> > > On 25/09/19 12:44PM, Eduard Zingerman wrote:
> > > > On Fri, 2025-09-19 at 21:28 +0200, Daniel Borkmann wrote:
> > > > > On 9/19/25 8:26 PM, Alexei Starovoitov wrote:
> > > > > > On Fri, Sep 19, 2025 at 12:12 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > > > > On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
> > > > > > > > On 25/09/18 11:35PM, Eduard Zingerman wrote:
> > > > > > > > > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > > > > > > > 
> > > > > > > > > [...]
> > > > > > > > > 
> > > > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > > > index a7ad4fe756da..5c1e4e37d1f8 100644
> > > > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > > > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > > > > >    struct bpf_insn *insn;
> > > > > > > > > >    void *old_bpf_func;
> > > > > > > > > >    int err, num_exentries;
> > > > > > > > > > + int old_len, subprog_start_adjustment = 0;
> > > > > > > > > > 
> > > > > > > > > >    if (env->subprog_cnt <= 1)
> > > > > > > > > >            return 0;
> > > > > > > > > > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > > > > >            func[i]->aux->func_idx = i;
> > > > > > > > > >            /* Below members will be freed only at prog->aux */
> > > > > > > > > >            func[i]->aux->btf = prog->aux->btf;
> > > > > > > > > > -         func[i]->aux->subprog_start = subprog_start;
> > > > > > > > > > +         func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
> > > > > > > > > >            func[i]->aux->func_info = prog->aux->func_info;
> > > > > > > > > >            func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
> > > > > > > > > >            func[i]->aux->poke_tab = prog->aux->poke_tab;
> > > > > > > > > > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > > > > >            func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
> > > > > > > > > >            if (!i)
> > > > > > > > > >                    func[i]->aux->exception_boundary = env->seen_exception;
> > > > > > > > > > +
> > > > > > > > > > +         /*
> > > > > > > > > > +          * To properly pass the absolute subprog start to jit
> > > > > > > > > > +          * all instruction adjustments should be accumulated
> > > > > > > > > > +          */
> > > > > > > > > > +         old_len = func[i]->len;
> > > > > > > > > >            func[i] = bpf_int_jit_compile(func[i]);
> > > > > > > > > > +         subprog_start_adjustment += func[i]->len - old_len;
> > > > > > > > > > +
> > > > > > > > > >            if (!func[i]->jited) {
> > > > > > > > > >                    err = -ENOTSUPP;
> > > > > > > > > >                    goto out_free;
> > > > > > > > > 
> > > > > > > > > This change makes sense, however, would it be possible to move
> > > > > > > > > bpf_jit_blind_constants() out from jit to verifier.c:do_check,
> > > > > > > > > somewhere after do_misc_fixups?
> > > > > > > > > Looking at the source code, bpf_jit_blind_constants() is the first
> > > > > > > > > thing any bpf_int_jit_compile() does.
> > > > > > > > > Another alternative is to add adjust_subprog_starts() call to this
> > > > > > > > > function. Wdyt?
> > > > > > > > 
> > > > > > > > Yes, it makes total sense. Blinding was added to x86 jit initially and then
> > > > > > > > every other jit copy-pasted it.  I was considering to move blinding up some
> > > > > > > > time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-aspsk@isovalent.com/),
> > > > > > > > but then I've decided to avoid this, as this requires to patch every JIT, and I
> > > > > > > > am not sure what is the way to test such a change (any hints?)
> > > > > > > 
> > > > > > > We have the following covered by CI:
> > > > > > > - arch/x86/net/bpf_jit_comp.c
> > > > > > > - arch/s390/net/bpf_jit_comp.c
> > > > > > > - arch/arm64/net/bpf_jit_comp.c
> > > > > > > 
> > > > > > > People work on these jits actively:
> > > > > > > - arch/riscv/net/bpf_jit_core.c
> > > > > > > - arch/loongarch/net/bpf_jit.c
> > > > > > > - arch/powerpc/net/bpf_jit_comp.c
> > > > > > > 
> > > > > > > So, we can probably ask to test the patch-set.
> > > > > > > 
> > > > > > > The remaining are:
> > > > > > > - arch/x86/net/bpf_jit_comp32.c
> > > > > > > - arch/parisc/net/bpf_jit_core.c
> > > > > > > - arch/mips/net/bpf_jit_comp.c
> > > > > > > - arch/arm/net/bpf_jit_32.c
> > > > > > > - arch/sparc/net/bpf_jit_comp_64.c
> > > > > > > - arch/arc/net/bpf_jit_core.c
> > > > > > > 
> > > > > > > The change to each individual jit is not complicated, just removing
> > > > > > > the transformation call. Idk, I'd just go for it.
> > > > > > > Maybe Alexei has concerns?
> > > > > > 
> > > > > > No concerns.
> > > > > > I don't remember why JIT calls it instead of the verifier.
> > > > > > 
> > > > > > Daniel,
> > > > > > do you recall? Any concern?
> > > > > 
> > > > > Hm, I think we did this in the JIT back then for couple of reasons iirc,
> > > > > the constant blinding needs to work from native bpf(2) as well as from
> > > > > cbpf->ebpf (seccomp-bpf, filters, etc), so the JIT was a natural location
> > > > > to capture them all, and to fallback to interpreter with the non-blinded
> > > > > BPF-insns when something went wrong during blinding or JIT process (e.g.
> > > > > JIT hits some internal limits etc). Moving bpf_jit_blind_constants() out
> > > > > from JIT to verifier.c:do_check() means constant blinding of cbpf->ebpf
> > > > > are not covered anymore (and in this case its reachable from unpriv).
> > > > 
> > > > Hi Daniel,
> > > > 
> > > > Thank you for the context.
> > > > So, the ideal location for bpf_jit_blind_constants() would be in
> > > > core.c in some wrapper function for bpf_int_jit_compile():
> > > > 
> > > >   static struct bpf_prog *jit_compile(prog)
> > > >   {
> > > >   	tmp = bpf_jit_blind_constants()
> > > >         if (!tmp)
> > > >            return prog;
> > > >         return bpf_int_jit_compile(tmp);
> > > >   }
> > > > 
> > > > A bit of a hassle.
> > > > 
> > > > Anton, wdyt about a second option: adding adjust_subprog_starts()
> > > > to bpf_jit_blind_constants() and leaving all the rest as-is?
> > > > It would have to happen either way of call to bpf_jit_blind_constants()
> > > > itself is moved.
> > > 
> > > So, to be clear, in this case adjust_insn_arrays() stays as in the
> > > original patch, but the "subprog_start_adjustment" chunks are
> > > replaced by calling the adjust_subprog_starts() (for better
> > > readability and consistency, right?)
> > 
> > Yes, by adding adjust_subprog_starts() call inside
> > bpf_jit_blind_constants() it should be possible to read
> > env->subprog_info[*].start in the jit_subprogs() loop directly,
> > w/o tracking the subprog_start_adjustment delta.
> > (At-least I think this should work).
> 
> Ok, will do this way, thanks.

Actually, I think I will skip it this time. During jit_subprogs
the code of the original program is split into subfuncs via the
_unchanged_ subprog info, as the xlated code is copied for each
new subprog in the loop. So this "adjustment" thing will appear
in some form in any case.

Also, doing adjust_subprog_starts() requires passing env to jits,
which wasn't done yet, and needs to be faked for non-ebpf progs,
I think. So maybe this is better to cleanup/generalize this later,
not as part of this patch.

