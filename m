Return-Path: <bpf+bounces-68971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE2B8B1A7
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC311898596
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 19:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4A72BE7BB;
	Fri, 19 Sep 2025 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRYLkK4s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6B288522
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311102; cv=none; b=iA+xsVlngmwb3pF6UrPRtPwqotXw+PaOdLLSced0eK3h5zfzVaAw6BFQUA9VmJtQnvO+KUW7uOUxdiPFqRi7HoXP5l2EcS8oyfpjJ2ApJ/Pa/2m5uPY4vMIitlTJ4E6hEjOxC7a2Dy5zNKGrvTuqYsrNU8CzrhSnE/S+E0Iq9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311102; c=relaxed/simple;
	bh=JDpTrY2ZYMhAsILtKQsWUTLY0ax7hpjWKrYudOHiSPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fo4WCTdQb+10vGTwRyN/cF65bi6rs6mEOPvx60oSg/op7HACOM8IXurLXLlgkGEn9RE7kHG9FWra1BMB6WNmwJXLwASu18wtAvbSwgJFU/EDpSArWlI80Q8qIfzHoDlTSaIZ0KKGYSdBc/8i2a0bF4s1+dRDF4dhjTPSYZ4J7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRYLkK4s; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267dff524d1so18255595ad.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311100; x=1758915900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bN+ou3Lk78XCbcxa6bgG9hIWbRoOOkAap8yFtSL2z70=;
        b=XRYLkK4s0nxzisoHiglx4mthUY3ws6WjNeHUPjUrJDOsr8L8Zf9a7bglzuWC8fzWW6
         Uck61Y81q7YSflSG3ja1gfEjb+DfSTBnX6/pGRePms7+nPg0QUz/cdznKPsRyXhwWowC
         n7xkQaqLKf/25QUAHNeCQG0FNGNtZqt11mY0Lj+Z4mv9bbtnIePKB/juWzhHyT9v5gal
         pXUkQScFm8mhAl8sL1PBcqv2iwkXrytFCznJAl3VSEugX/AFHWCIXXvPHZc+yj/dVTci
         N6aLKcGtNKCSvyNTeHawblpdreVtjsulabGNcnIi7yvR/AhphiZxkcKioBPHdRC1punz
         ICaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311100; x=1758915900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bN+ou3Lk78XCbcxa6bgG9hIWbRoOOkAap8yFtSL2z70=;
        b=Kgqyn0M2Wf8yCpZXXGwmolOZhtYlrR7Xuseojj83cIhaYYOySKwhIy9GFgkpZ0Qgs8
         Frs3AKyblK/jDVEo9LrnfnnbSQmnrHcwNhUwOLoOYBThj2m/dMWW3V9+UQXawNSHnTNh
         E+9JZSrDbiciCcmyeTjVJikIkZ0b1QVxI0aBJ0PcmyEb1ais1dT3VnQF+WdYCRFpExed
         81+9ovVU5RpOfHQMHVi6omMm6fz1IPEhoFCVVsP85s+Vu29jeTHbo9flxss75WvJ7C3l
         Ef6NkDjiUO3sYAFDcCfeDr14XYHCn5/3eS1KDTR2RqXQvtH5B7MGyhZvtlheiq3DUdGI
         816Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5taPR6TE3fdtZAyhVKNGtBkplhrA6MM/vha5Ryh9aBNmi3efYdfWCoGy2cX+prsnMT8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19bGHWQGGe4YWsIdKPt1v2C8HTVmiLvnMPIgSnyRafzFug7iR
	/0Eb9rmghugjbIxWq6QMLzB3tAlMZMLKs8jY1CAYlNlCDc6p/Ao/o6Gx
X-Gm-Gg: ASbGnctXIOdWpJj9PShwIR5zaxi4pI0A3K8KldlfveNEliAI4Gah1OkvCv3wehzXHXc
	M/jaNVmcC+gnCem6OWKUbqkHT+v/4gHCvDnuv/Vo7R9+EwTaFVm5pIWe1hlZrBAi++3C058dPjD
	E9WJDo5yipN3qjnWz5y4tguwEbzGvzabJrzX6+jbu05kPnpispMMwIiNtcO2R8vNGfrW3ZDj1LO
	N5CYuHiq8+aGWCY0ThTrHdWN1pJbah5cQpqXHC9R+RCV3P6iolLI9AE4rkZS6vswdMNiJpZGpUr
	mSW3RPo/v9pngQ/9RA/N9lJ6mu0zPHAmouBlkI/iv9IPZfk9Pe0Vl8N2hgyL3fExw/VSrlx+eYy
	XdVBzw4b8PusxaKdHHVE=
X-Google-Smtp-Source: AGHT+IEbR3J4FJDlO4RG/XuEYipGQbPnra+/lvdEbcpFeFDhk2KMFt75t/V+Y18I6ULeRzFM9nR3iA==
X-Received: by 2002:a17:903:2342:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-269ba435239mr61983915ad.12.1758311099726;
        Fri, 19 Sep 2025 12:44:59 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deb3dsm62702425ad.93.2025.09.19.12.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:44:59 -0700 (PDT)
Message-ID: <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov
	 <aspsk@isovalent.com>, Quentin Monnet <qmo@kernel.org>, Yonghong Song
	 <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 12:44:56 -0700
In-Reply-To: <284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-6-a.s.protopopov@gmail.com>
	 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
	 <aM0AuFAnqGJgI0Kf@mail.gmail.com>
	 <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
	 <CAADnVQKsZnOXo-+sK-+=aov80WLgouVPbUXvdg8Na9uU-CmCew@mail.gmail.com>
	 <284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 21:28 +0200, Daniel Borkmann wrote:
> On 9/19/25 8:26 PM, Alexei Starovoitov wrote:
> > On Fri, Sep 19, 2025 at 12:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
> > > > On 25/09/18 11:35PM, Eduard Zingerman wrote:
> > > > > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index a7ad4fe756da..5c1e4e37d1f8 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_veri=
fier_env *env)
> > > > > >    struct bpf_insn *insn;
> > > > > >    void *old_bpf_func;
> > > > > >    int err, num_exentries;
> > > > > > + int old_len, subprog_start_adjustment =3D 0;
> > > > > >=20
> > > > > >    if (env->subprog_cnt <=3D 1)
> > > > > >            return 0;
> > > > > > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_veri=
fier_env *env)
> > > > > >            func[i]->aux->func_idx =3D i;
> > > > > >            /* Below members will be freed only at prog->aux */
> > > > > >            func[i]->aux->btf =3D prog->aux->btf;
> > > > > > -         func[i]->aux->subprog_start =3D subprog_start;
> > > > > > +         func[i]->aux->subprog_start =3D subprog_start + subpr=
og_start_adjustment;
> > > > > >            func[i]->aux->func_info =3D prog->aux->func_info;
> > > > > >            func[i]->aux->func_info_cnt =3D prog->aux->func_info=
_cnt;
> > > > > >            func[i]->aux->poke_tab =3D prog->aux->poke_tab;
> > > > > > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_ver=
ifier_env *env)
> > > > > >            func[i]->aux->might_sleep =3D env->subprog_info[i].m=
ight_sleep;
> > > > > >            if (!i)
> > > > > >                    func[i]->aux->exception_boundary =3D env->se=
en_exception;
> > > > > > +
> > > > > > +         /*
> > > > > > +          * To properly pass the absolute subprog start to jit
> > > > > > +          * all instruction adjustments should be accumulated
> > > > > > +          */
> > > > > > +         old_len =3D func[i]->len;
> > > > > >            func[i] =3D bpf_int_jit_compile(func[i]);
> > > > > > +         subprog_start_adjustment +=3D func[i]->len - old_len;
> > > > > > +
> > > > > >            if (!func[i]->jited) {
> > > > > >                    err =3D -ENOTSUPP;
> > > > > >                    goto out_free;
> > > > >=20
> > > > > This change makes sense, however, would it be possible to move
> > > > > bpf_jit_blind_constants() out from jit to verifier.c:do_check,
> > > > > somewhere after do_misc_fixups?
> > > > > Looking at the source code, bpf_jit_blind_constants() is the firs=
t
> > > > > thing any bpf_int_jit_compile() does.
> > > > > Another alternative is to add adjust_subprog_starts() call to thi=
s
> > > > > function. Wdyt?
> > > >=20
> > > > Yes, it makes total sense. Blinding was added to x86 jit initially =
and then
> > > > every other jit copy-pasted it.  I was considering to move blinding=
 up some
> > > > time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-=
aspsk@isovalent.com/),
> > > > but then I've decided to avoid this, as this requires to patch ever=
y JIT, and I
> > > > am not sure what is the way to test such a change (any hints?)
> > >=20
> > > We have the following covered by CI:
> > > - arch/x86/net/bpf_jit_comp.c
> > > - arch/s390/net/bpf_jit_comp.c
> > > - arch/arm64/net/bpf_jit_comp.c
> > >=20
> > > People work on these jits actively:
> > > - arch/riscv/net/bpf_jit_core.c
> > > - arch/loongarch/net/bpf_jit.c
> > > - arch/powerpc/net/bpf_jit_comp.c
> > >=20
> > > So, we can probably ask to test the patch-set.
> > >=20
> > > The remaining are:
> > > - arch/x86/net/bpf_jit_comp32.c
> > > - arch/parisc/net/bpf_jit_core.c
> > > - arch/mips/net/bpf_jit_comp.c
> > > - arch/arm/net/bpf_jit_32.c
> > > - arch/sparc/net/bpf_jit_comp_64.c
> > > - arch/arc/net/bpf_jit_core.c
> > >=20
> > > The change to each individual jit is not complicated, just removing
> > > the transformation call. Idk, I'd just go for it.
> > > Maybe Alexei has concerns?
> >=20
> > No concerns.
> > I don't remember why JIT calls it instead of the verifier.
> >=20
> > Daniel,
> > do you recall? Any concern?
>=20
> Hm, I think we did this in the JIT back then for couple of reasons iirc,
> the constant blinding needs to work from native bpf(2) as well as from
> cbpf->ebpf (seccomp-bpf, filters, etc), so the JIT was a natural location
> to capture them all, and to fallback to interpreter with the non-blinded
> BPF-insns when something went wrong during blinding or JIT process (e.g.
> JIT hits some internal limits etc). Moving bpf_jit_blind_constants() out
> from JIT to verifier.c:do_check() means constant blinding of cbpf->ebpf
> are not covered anymore (and in this case its reachable from unpriv).

Hi Daniel,

Thank you for the context.
So, the ideal location for bpf_jit_blind_constants() would be in
core.c in some wrapper function for bpf_int_jit_compile():

  static struct bpf_prog *jit_compile(prog)
  {
  	tmp =3D bpf_jit_blind_constants()
        if (!tmp)
           return prog;
        return bpf_int_jit_compile(tmp);
  }

A bit of a hassle.

Anton, wdyt about a second option: adding adjust_subprog_starts()
to bpf_jit_blind_constants() and leaving all the rest as-is?
It would have to happen either way of call to bpf_jit_blind_constants()
itself is moved.

