Return-Path: <bpf+bounces-68972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C102B8B2E8
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1217C5A7D5E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90A2853F7;
	Fri, 19 Sep 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k60AlQwV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82322758F
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313253; cv=none; b=N4T9BMdZ5x2l0oFyyq6fy6dXl54+dn58m/Dn439xzZRKGkkAlQ2yLI6ijzv4ss6hWTWB/VWJTHnU01UqXiEkV+uBMPxhL9ZoYm6E6SAhAmQBQ+zByF6BQIV8Gi/lf2V5vQE4iILte0Zvxl9y0+h/6nAi+FG/mLZklrUo2w1TNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313253; c=relaxed/simple;
	bh=u1RH+BSwyaOJ0wgdNvLm6nCyhR5rLJKWH2G9B5/9PAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cugku4kpETijthnrjjSouvlHU6uEYhpowLAsBoOn/Mph/dHnmIHvX9IGIEJluNdq2hdz7BEQPZmAwl3QXbE1FBWrlL4iBt7irrHiNSJwVnlqvKcD7A3yyFm5Q0Jhvyv+KHLQmbcsUP9a57D7evKimJ2IA3hbJ6yJyDKvuOtHDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k60AlQwV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso16683435e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758313250; x=1758918050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybea8ewozRt4COxRaLVIj4tItqXn7jNgfv1+lgZx3Lk=;
        b=k60AlQwVR8GwK6ZPX2aQ46ZUgB3hcI4g6CXIVJPYy2b4czEl8JMFnzpVxnBhV4kXk7
         acejExSfdm0mCLp0F2qzGX0oZ6tyN3CAICF5HCZJmBY8K3JDfpRERxfy6WC/ASB2j15Y
         gwt54q39153PUzDLgCB1k+as5pCF3vp0HqJTipk9ezms5ELSLwiDb+dJizy+Knu837xn
         /wYmZYcdV+2Nt3e+j9yr+oPmvhJvW4R3Ow1CvJQgTfYAvmoHwfFoCpW9oIbb+oXcW2jh
         5yr+LSAElG14t8gtdLrTC95OL5VoWaz7nfnw0mcWvKkaUskACl/CWf5Sk3JmOva6oT3V
         3QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758313250; x=1758918050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybea8ewozRt4COxRaLVIj4tItqXn7jNgfv1+lgZx3Lk=;
        b=hzrRR0l1psNtwgyf/l78yVbEq08Yxw3LgeLBbNOw/K9V9dIcjlI5Z+pLLtkjIl/nxW
         Mu9DL5gdkhh9qHZpqjJqvxj2qygqC3JKXG7NIFDLkqQ7THgVXfI/e2r7ssEXXWE8paIM
         q+p45pJvG5GMdxQWAhR4uSfo7rmkkeYAneelFXhY3/JFQtMi3pF9Q/LnYpb9A6srwzdz
         u9SMnD+8v4fA2/WA2OJsTQDNQgggGZdNLPELT2zMVSTuhMuIctMrinLENBnX8JuX+236
         XPv++cLGmMiiaaJLkpZfoL0VJsLbH1yTj26IFDLCKFp9XeXaBOGjS8tW49u3BP7wyb6V
         nDlg==
X-Forwarded-Encrypted: i=1; AJvYcCWe6vg/Q9JM3gds2s1Ps/CDr2dhxi4CwhTjALZBqFx/sYMi/2ayyIabE4l447LBz2vM+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3UcAwAlYyVJcILCOVDeDomUixi8J1Vk26oQN7/oomMbfBZew
	Fs0NBvQye1GZzuVd5STtIYPXxdusmvNeAT6fpMvRBjbLg0Q/q2CJlKNV
X-Gm-Gg: ASbGnct48yBc4gkCHBlR1nb7n5Pn1RJFS+RO3eNWBsJ/HFhLhsDFeYR8IoPWavgOabz
	srKHgkpovpXQOxoEIFB3eXKNSexsVRrKJxwR2YciaOtTStXPueORqI0y7brAcxSk5WY76046NNv
	gy6cs4/Ptf4KuuvKZWTfpwKwRg4YoD1ra/nKI9X0HpwJG5eUgcbOX0BI4GJv1siE0nqtdQSMuZt
	wlHEmR6Cfy4rnh/an+aodkBXZdYvMN8qTvRw0Ky3KogUPiVnGjhCIM259Bjn7ulcFDXLbndLx08
	72KqbAMxGVAotdKAjQsN4ehNorK4aacPULDI/J8cSPatfTBeUhTHF/T5rJorX3pfNQjoZWkytwA
	esDMDKkTrSYoLsm2VVJPBOJScGoRS2u2U
X-Google-Smtp-Source: AGHT+IEcLORqD554hc1CDrsh6he2Zf4nEBmSUSazrjhFMSPJVCgb1Dxj1/jQOnIilUicln+l+NWazg==
X-Received: by 2002:a05:600c:3114:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-467ead6871cmr37649045e9.18.1758313249695;
        Fri, 19 Sep 2025 13:20:49 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f5392sm8904804f8f.13.2025.09.19.13.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 13:20:49 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:27:00 +0000
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
Message-ID: <aM28lJL8ivnbr1yf@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-6-a.s.protopopov@gmail.com>
 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
 <aM0AuFAnqGJgI0Kf@mail.gmail.com>
 <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
 <CAADnVQKsZnOXo-+sK-+=aov80WLgouVPbUXvdg8Na9uU-CmCew@mail.gmail.com>
 <284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net>
 <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>

On 25/09/19 12:44PM, Eduard Zingerman wrote:
> On Fri, 2025-09-19 at 21:28 +0200, Daniel Borkmann wrote:
> > On 9/19/25 8:26 PM, Alexei Starovoitov wrote:
> > > On Fri, Sep 19, 2025 at 12:12 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
> > > > > On 25/09/18 11:35PM, Eduard Zingerman wrote:
> > > > > > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > index a7ad4fe756da..5c1e4e37d1f8 100644
> > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > >    struct bpf_insn *insn;
> > > > > > >    void *old_bpf_func;
> > > > > > >    int err, num_exentries;
> > > > > > > + int old_len, subprog_start_adjustment = 0;
> > > > > > > 
> > > > > > >    if (env->subprog_cnt <= 1)
> > > > > > >            return 0;
> > > > > > > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > >            func[i]->aux->func_idx = i;
> > > > > > >            /* Below members will be freed only at prog->aux */
> > > > > > >            func[i]->aux->btf = prog->aux->btf;
> > > > > > > -         func[i]->aux->subprog_start = subprog_start;
> > > > > > > +         func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
> > > > > > >            func[i]->aux->func_info = prog->aux->func_info;
> > > > > > >            func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
> > > > > > >            func[i]->aux->poke_tab = prog->aux->poke_tab;
> > > > > > > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > >            func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
> > > > > > >            if (!i)
> > > > > > >                    func[i]->aux->exception_boundary = env->seen_exception;
> > > > > > > +
> > > > > > > +         /*
> > > > > > > +          * To properly pass the absolute subprog start to jit
> > > > > > > +          * all instruction adjustments should be accumulated
> > > > > > > +          */
> > > > > > > +         old_len = func[i]->len;
> > > > > > >            func[i] = bpf_int_jit_compile(func[i]);
> > > > > > > +         subprog_start_adjustment += func[i]->len - old_len;
> > > > > > > +
> > > > > > >            if (!func[i]->jited) {
> > > > > > >                    err = -ENOTSUPP;
> > > > > > >                    goto out_free;
> > > > > > 
> > > > > > This change makes sense, however, would it be possible to move
> > > > > > bpf_jit_blind_constants() out from jit to verifier.c:do_check,
> > > > > > somewhere after do_misc_fixups?
> > > > > > Looking at the source code, bpf_jit_blind_constants() is the first
> > > > > > thing any bpf_int_jit_compile() does.
> > > > > > Another alternative is to add adjust_subprog_starts() call to this
> > > > > > function. Wdyt?
> > > > > 
> > > > > Yes, it makes total sense. Blinding was added to x86 jit initially and then
> > > > > every other jit copy-pasted it.  I was considering to move blinding up some
> > > > > time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-aspsk@isovalent.com/),
> > > > > but then I've decided to avoid this, as this requires to patch every JIT, and I
> > > > > am not sure what is the way to test such a change (any hints?)
> > > > 
> > > > We have the following covered by CI:
> > > > - arch/x86/net/bpf_jit_comp.c
> > > > - arch/s390/net/bpf_jit_comp.c
> > > > - arch/arm64/net/bpf_jit_comp.c
> > > > 
> > > > People work on these jits actively:
> > > > - arch/riscv/net/bpf_jit_core.c
> > > > - arch/loongarch/net/bpf_jit.c
> > > > - arch/powerpc/net/bpf_jit_comp.c
> > > > 
> > > > So, we can probably ask to test the patch-set.
> > > > 
> > > > The remaining are:
> > > > - arch/x86/net/bpf_jit_comp32.c
> > > > - arch/parisc/net/bpf_jit_core.c
> > > > - arch/mips/net/bpf_jit_comp.c
> > > > - arch/arm/net/bpf_jit_32.c
> > > > - arch/sparc/net/bpf_jit_comp_64.c
> > > > - arch/arc/net/bpf_jit_core.c
> > > > 
> > > > The change to each individual jit is not complicated, just removing
> > > > the transformation call. Idk, I'd just go for it.
> > > > Maybe Alexei has concerns?
> > > 
> > > No concerns.
> > > I don't remember why JIT calls it instead of the verifier.
> > > 
> > > Daniel,
> > > do you recall? Any concern?
> > 
> > Hm, I think we did this in the JIT back then for couple of reasons iirc,
> > the constant blinding needs to work from native bpf(2) as well as from
> > cbpf->ebpf (seccomp-bpf, filters, etc), so the JIT was a natural location
> > to capture them all, and to fallback to interpreter with the non-blinded
> > BPF-insns when something went wrong during blinding or JIT process (e.g.
> > JIT hits some internal limits etc). Moving bpf_jit_blind_constants() out
> > from JIT to verifier.c:do_check() means constant blinding of cbpf->ebpf
> > are not covered anymore (and in this case its reachable from unpriv).
> 
> Hi Daniel,
> 
> Thank you for the context.
> So, the ideal location for bpf_jit_blind_constants() would be in
> core.c in some wrapper function for bpf_int_jit_compile():
> 
>   static struct bpf_prog *jit_compile(prog)
>   {
>   	tmp = bpf_jit_blind_constants()
>         if (!tmp)
>            return prog;
>         return bpf_int_jit_compile(tmp);
>   }
> 
> A bit of a hassle.
> 
> Anton, wdyt about a second option: adding adjust_subprog_starts()
> to bpf_jit_blind_constants() and leaving all the rest as-is?
> It would have to happen either way of call to bpf_jit_blind_constants()
> itself is moved.

So, to be clear, in this case adjust_insn_arrays() stays as in the
original patch, but the "subprog_start_adjustment" chunks are
replaced by calling the adjust_subprog_starts() (for better
readability and consistency, right?)

