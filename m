Return-Path: <bpf+bounces-69187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D96B8FBD0
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 11:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D433818A1973
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB2A285045;
	Mon, 22 Sep 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDDQBoGD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09C203706
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532960; cv=none; b=QFY1PX9pdywj6xH4rbXgu41QX60ltfg/rsm5Dw2JXXZ4IPSb2x1qc09oy3rTj0S7bC/JLXSAyWbKiTf8cjAU8kmiObRNHbVldtKXr2JiKSS2Ik2icqjyv4oFlvrxxzixPLA0FU1J3hZdF9Dus9Ge2oVMqhEPjfbvwZSCR29RqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532960; c=relaxed/simple;
	bh=21PE8FD8cNB8CkHQ4Bvtcd2vqjNrhJ91BXc/MFU9kLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9zt0cwwh1+jvHYPYWOk/NO8pRcvcM0mkr1YtT+6AtoXjx2oyoJdJ7QNzd9wrAM/UQlpxkI/x/emRF7gATjaq1BjRgGoEYI68wQsigo6fWnzbxPkLauPOurjn1jMd89Y9wfI8Dnc31qXQ02CQ0qGM9LnnhL7zI1uR4R5HPGpmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDDQBoGD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-468973c184bso14194685e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758532957; x=1759137757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tK5w55PP0ALJFnxAHJL2OR4MuIUR93fI/tBNqcj/Zbk=;
        b=jDDQBoGDWzuFlrT4Sgqw+1v37scc6jSrpIntNEM1mrF+C5HqR914XLbwFdw7w9GLGl
         ER8/iltlwgkkFufDxRe4fTXNcDi4XHdJZch/FthOW1b1P1eOQ78BpVsnKwviUm3/H3Cs
         59HIqpOIPq3qu6Ber/SqoXR2GNZak5s4j4b8I5MJNkTJlMXA/jm3kl94WbeDIo61Uw8o
         6TcuWrCoKgFjKBQOpI/AUjMUsxBQJTHDhg5cFt/aAo8jxQTvMnGf1MDU0IBMZxEqFevN
         wZoRTfyTNARAX/SoV2jXZOF2cAIzh0H4Ho3TkQ8QJojC/ZQnVSdp/SfjAWoDgVl6eMD4
         zDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532957; x=1759137757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tK5w55PP0ALJFnxAHJL2OR4MuIUR93fI/tBNqcj/Zbk=;
        b=Aq/QK+cNJjPvRHshC8ttzXjaQW2xNjiXg2XHEsXvk6zL/UbNKJm9Cx7t+ULprinGDd
         MSqmm6FIL40UeSl9+KLGE7WSQAAYGgsHVAwnxfan877SThJRewN6ZaelXTGM6etAPCJU
         s84zWfM0JeljHPvida40jwEQC9PKFKvFjGJaBbW/D3z+Uka1NuvKHst+0Ukv4UYD5Xq3
         DRQ0vbRH7w5fOMcYKlZeaBkZNp2Te3MA7w8nibPwizPWEKaQKwopLEaHqu/WXSAc61Zz
         cn9rVwqGLSJCyotALCn+aJmAcuN9r24dfz2AllCzIMZ0O4YcSiqxLdzN00bobyLI1n3a
         QX3A==
X-Forwarded-Encrypted: i=1; AJvYcCWDwdB6YJP6ACqHnbpyWTHGxeLxTzWwmLrX6DiUqaANt7VsK6f8W4dNP7x3uFIyXYtDnKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlBSMYyZaNRPR33IfkBOd00dUNIl/PD9nuvQ9fQ3JOPcrJ5Ih
	UaAaoLs4ba2rU6Vks3TBekWtBtOe7/hIYqTf2hz/bjf1NaF4ENPBjQt0
X-Gm-Gg: ASbGncvUtVRVjawxUMGXsM4qk5Y6olzLufRL0lOb4hrcgkKqBiLJQ0ZeqhzTbeU2IqR
	3cpel/hnWk0DA+++XzCCLo85ol/eNRIKIWS5JnbC1hbrM+vkwZYDLpbREVHXVHEIfDtSeIsrFS9
	0ZFtlK6uqTk2WVBHXYQ86HcAy5PPM+/r6cu8c51fNJYlh8sWSu9+y927AfzbAOlAY2TKPgRMrhu
	snv6Aa3d/kXVFHivxCWEM7gEkJWZ4pfASU8n6wckDGInF9MPKmnhtQLuFjCMSpo/C1jbsegXLbG
	JqTuBoFRr8lo/KBpYU5ac0horyWenFKZJE/mMZyLaQMxbhrhtLzgnDmfCskAQGUHtLY7WX+qds2
	HEtMOd0GAsxAvg7eKRxfJyFzYJeH9j9UO
X-Google-Smtp-Source: AGHT+IFhCtX6qcqW2rTVG/tp9fFYjfYps32wAFif3rj7KAKd++yJ0GGfOnOR41N+gQXCgi8JnAhUlA==
X-Received: by 2002:a05:600c:1e8f:b0:45d:d50d:c0db with SMTP id 5b1f17b1804b1-467e6f37dc1mr106117295e9.15.1758532956647;
        Mon, 22 Sep 2025 02:22:36 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407ccasm19121453f8f.15.2025.09.22.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:22:36 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:28:39 +0000
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
Message-ID: <aNEWx4TqHE0pzuB0@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-6-a.s.protopopov@gmail.com>
 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
 <aM0AuFAnqGJgI0Kf@mail.gmail.com>
 <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
 <CAADnVQKsZnOXo-+sK-+=aov80WLgouVPbUXvdg8Na9uU-CmCew@mail.gmail.com>
 <284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net>
 <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>
 <aM28lJL8ivnbr1yf@mail.gmail.com>
 <60c2444047bd44be26f9410515177d6ad2d1f1e2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60c2444047bd44be26f9410515177d6ad2d1f1e2.camel@gmail.com>

On 25/09/19 01:47PM, Eduard Zingerman wrote:
> On Fri, 2025-09-19 at 20:27 +0000, Anton Protopopov wrote:
> > On 25/09/19 12:44PM, Eduard Zingerman wrote:
> > > On Fri, 2025-09-19 at 21:28 +0200, Daniel Borkmann wrote:
> > > > On 9/19/25 8:26 PM, Alexei Starovoitov wrote:
> > > > > On Fri, Sep 19, 2025 at 12:12 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > > > On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
> > > > > > > On 25/09/18 11:35PM, Eduard Zingerman wrote:
> > > > > > > > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > > 
> > > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > > index a7ad4fe756da..5c1e4e37d1f8 100644
> > > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > > > >    struct bpf_insn *insn;
> > > > > > > > >    void *old_bpf_func;
> > > > > > > > >    int err, num_exentries;
> > > > > > > > > + int old_len, subprog_start_adjustment = 0;
> > > > > > > > > 
> > > > > > > > >    if (env->subprog_cnt <= 1)
> > > > > > > > >            return 0;
> > > > > > > > > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > > > >            func[i]->aux->func_idx = i;
> > > > > > > > >            /* Below members will be freed only at prog->aux */
> > > > > > > > >            func[i]->aux->btf = prog->aux->btf;
> > > > > > > > > -         func[i]->aux->subprog_start = subprog_start;
> > > > > > > > > +         func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
> > > > > > > > >            func[i]->aux->func_info = prog->aux->func_info;
> > > > > > > > >            func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
> > > > > > > > >            func[i]->aux->poke_tab = prog->aux->poke_tab;
> > > > > > > > > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > > > > >            func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
> > > > > > > > >            if (!i)
> > > > > > > > >                    func[i]->aux->exception_boundary = env->seen_exception;
> > > > > > > > > +
> > > > > > > > > +         /*
> > > > > > > > > +          * To properly pass the absolute subprog start to jit
> > > > > > > > > +          * all instruction adjustments should be accumulated
> > > > > > > > > +          */
> > > > > > > > > +         old_len = func[i]->len;
> > > > > > > > >            func[i] = bpf_int_jit_compile(func[i]);
> > > > > > > > > +         subprog_start_adjustment += func[i]->len - old_len;
> > > > > > > > > +
> > > > > > > > >            if (!func[i]->jited) {
> > > > > > > > >                    err = -ENOTSUPP;
> > > > > > > > >                    goto out_free;
> > > > > > > > 
> > > > > > > > This change makes sense, however, would it be possible to move
> > > > > > > > bpf_jit_blind_constants() out from jit to verifier.c:do_check,
> > > > > > > > somewhere after do_misc_fixups?
> > > > > > > > Looking at the source code, bpf_jit_blind_constants() is the first
> > > > > > > > thing any bpf_int_jit_compile() does.
> > > > > > > > Another alternative is to add adjust_subprog_starts() call to this
> > > > > > > > function. Wdyt?
> > > > > > > 
> > > > > > > Yes, it makes total sense. Blinding was added to x86 jit initially and then
> > > > > > > every other jit copy-pasted it.  I was considering to move blinding up some
> > > > > > > time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-aspsk@isovalent.com/),
> > > > > > > but then I've decided to avoid this, as this requires to patch every JIT, and I
> > > > > > > am not sure what is the way to test such a change (any hints?)
> > > > > > 
> > > > > > We have the following covered by CI:
> > > > > > - arch/x86/net/bpf_jit_comp.c
> > > > > > - arch/s390/net/bpf_jit_comp.c
> > > > > > - arch/arm64/net/bpf_jit_comp.c
> > > > > > 
> > > > > > People work on these jits actively:
> > > > > > - arch/riscv/net/bpf_jit_core.c
> > > > > > - arch/loongarch/net/bpf_jit.c
> > > > > > - arch/powerpc/net/bpf_jit_comp.c
> > > > > > 
> > > > > > So, we can probably ask to test the patch-set.
> > > > > > 
> > > > > > The remaining are:
> > > > > > - arch/x86/net/bpf_jit_comp32.c
> > > > > > - arch/parisc/net/bpf_jit_core.c
> > > > > > - arch/mips/net/bpf_jit_comp.c
> > > > > > - arch/arm/net/bpf_jit_32.c
> > > > > > - arch/sparc/net/bpf_jit_comp_64.c
> > > > > > - arch/arc/net/bpf_jit_core.c
> > > > > > 
> > > > > > The change to each individual jit is not complicated, just removing
> > > > > > the transformation call. Idk, I'd just go for it.
> > > > > > Maybe Alexei has concerns?
> > > > > 
> > > > > No concerns.
> > > > > I don't remember why JIT calls it instead of the verifier.
> > > > > 
> > > > > Daniel,
> > > > > do you recall? Any concern?
> > > > 
> > > > Hm, I think we did this in the JIT back then for couple of reasons iirc,
> > > > the constant blinding needs to work from native bpf(2) as well as from
> > > > cbpf->ebpf (seccomp-bpf, filters, etc), so the JIT was a natural location
> > > > to capture them all, and to fallback to interpreter with the non-blinded
> > > > BPF-insns when something went wrong during blinding or JIT process (e.g.
> > > > JIT hits some internal limits etc). Moving bpf_jit_blind_constants() out
> > > > from JIT to verifier.c:do_check() means constant blinding of cbpf->ebpf
> > > > are not covered anymore (and in this case its reachable from unpriv).
> > > 
> > > Hi Daniel,
> > > 
> > > Thank you for the context.
> > > So, the ideal location for bpf_jit_blind_constants() would be in
> > > core.c in some wrapper function for bpf_int_jit_compile():
> > > 
> > >   static struct bpf_prog *jit_compile(prog)
> > >   {
> > >   	tmp = bpf_jit_blind_constants()
> > >         if (!tmp)
> > >            return prog;
> > >         return bpf_int_jit_compile(tmp);
> > >   }
> > > 
> > > A bit of a hassle.
> > > 
> > > Anton, wdyt about a second option: adding adjust_subprog_starts()
> > > to bpf_jit_blind_constants() and leaving all the rest as-is?
> > > It would have to happen either way of call to bpf_jit_blind_constants()
> > > itself is moved.
> > 
> > So, to be clear, in this case adjust_insn_arrays() stays as in the
> > original patch, but the "subprog_start_adjustment" chunks are
> > replaced by calling the adjust_subprog_starts() (for better
> > readability and consistency, right?)
> 
> Yes, by adding adjust_subprog_starts() call inside
> bpf_jit_blind_constants() it should be possible to read
> env->subprog_info[*].start in the jit_subprogs() loop directly,
> w/o tracking the subprog_start_adjustment delta.
> (At-least I think this should work).

Ok, will do this way, thanks.

