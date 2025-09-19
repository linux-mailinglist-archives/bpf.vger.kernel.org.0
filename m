Return-Path: <bpf+bounces-68974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B6B8B393
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BC414E1410
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21B2C029C;
	Fri, 19 Sep 2025 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW/ChQ6X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F729B8EF
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314887; cv=none; b=FS74srPyiSkG4dODF/MuHIyRlD62yoEZ3+khOOal7l8WbitKdjpiE/9dT2Hj+wa1QGmg5IXsVkg9CF3kdfBQ6yXxqza5SBoj4KC4wVrdWFm3DsDij9IfE/84S0ru/vYeGYqrxo2E8JHbh2uNndLnOyfuNGYTD5i6heuZYtAOB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314887; c=relaxed/simple;
	bh=Q0avjw0+r3llO8w7s+sbxiEtvrbNttLjQA+zIuaHstE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMmXatx8Z3NiUdaSCR6mYqfHc/yvj42CwzItP1AJmT7waievd/W3p0zh61P9DId2PPSJG5m7WWxO6ZJLKPcbVrx5vsQnTRMFCdJtpu6g8SQXD7PpI6/c1kK3ZTW48ARNYcvXjOsukIwEIqFgbcnUlBm3sBuWqGWn5sgb/AAtuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW/ChQ6X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-267fac63459so23372305ad.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758314883; x=1758919683; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSkHm0G5hA1hOD4PwidgHzylDSpk2MuIEoe9sdnym7Y=;
        b=nW/ChQ6XGzxmd7vv074c2LKlNj3r7sbJVTs4KZ/B38LDoNZTfwxz3WxJzY87rqkt7B
         1BthjV4ooLLaaSWCsOA+m+0nyRp4Or3t+M6pDdO7vE9I70bo995GOLxhFosUMtp7BLOJ
         Ox9vIRhz6B1zeCQiVKX4er/3orxIWFg+u5TctUkV5IaqFV+Q/6VUSXgL32EkMstcVJtK
         Dg12F7CyzapM8gkbholye3dJx4VOEljatilZwcXrTpVUAf5xVztZtEqKPf8g10bwVFrR
         ahGKOzHeYD4yvwWI+2rKmk53q7nKRaW9tNXVo8C4UFzP4QfRlIIjjDSVQly+tEUr/MSE
         sryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314883; x=1758919683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSkHm0G5hA1hOD4PwidgHzylDSpk2MuIEoe9sdnym7Y=;
        b=awUu6qSaOsSS5jT/jShhFqxO2WQcTsp7IOl6SFhVtZInIJBNrucMhJ3P0l70cVS/CC
         spmtcxNxmEXE3/hANfxgVekNIraVQ2yAEdJHKvnh5zNxkMPtLeqbDTXQDPjj1SKgVaSh
         YXZEAygeyWfMG/udyBIgPHS9S1jHIXwaCi3elEt597A+ZPWkdb3hMLIA4oVQRaxpWoP9
         sJ2J42POBpuRyOKgEYNHtv4nMrhRzvVTeZEBeTxgM9E1snt2Qvp9OyPQ62LR/YY9usz3
         se02u+GsBVePw8ewp8xY9yvHD/pqwPY/bMaOf8GSMAzG2LH51Q41L8TSwv5ThYzRCp3W
         y3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXqrS+aOHDbEizB8e1MMw+eMToMFvzAgWNDoQznrj7gjuzli6EtgkrQtOKAfWeqSxhCJNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9Yn9KZJLjH3lldtmM8LALQJwhEtVx7XtKIh04uFunvGoFkye
	6gcDufzZ9IBIVeI+QFxs4D5pklzbPOi1KslUOTv4QhNPK/jR5XSJ55Ku
X-Gm-Gg: ASbGncuZ9y8S9VpdehKwpf8DKWpsu7YxL0Jh/A4BT//HkTesE/b6BubM7sIAk3SJIGo
	9hiA3vlI1YbDOD8GcF9IXyU5VWVQ4mBuZBj5C8yc3e0mXr/3NvIbl/Pd+sRsxyiPDMbpxWW55mr
	GTRLDagXfv50j/0gmmp8WM6tIkATu/xMgwNKgf7E4olwCs0OZ3IhWOejW0f2UbO6+ey9s95EULP
	WYPeco4beiT9DxLGj1nuxpY+HuDLLT9dkSucGoa7iAryeeEj3e4Tj5P9FnupmdmkX+59oIfGi9o
	6bvtZ1ceV0Xl3MHcXT4uevJInj5ssRqjN6SL+gI2cZpVPFFxQ6OUsb7iCtkC1PVGg7kojdrApDS
	2b501aMnxF8nqM3UDEp4=
X-Google-Smtp-Source: AGHT+IFCNtqVVamjgLmzw8nFd+GRE1bWRMl5iiqrgbXfXYUiDPnCDfyyUh2JoNN6O+9RzxocCYgUjw==
X-Received: by 2002:a17:902:e74b:b0:264:3519:80d0 with SMTP id d9443c01a7336-269ba516ec9mr69276345ad.33.1758314882894;
        Fri, 19 Sep 2025 13:48:02 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm8854365ad.80.2025.09.19.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 13:48:02 -0700 (PDT)
Message-ID: <60c2444047bd44be26f9410515177d6ad2d1f1e2.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov	 <aspsk@isovalent.com>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 13:47:59 -0700
In-Reply-To: <aM28lJL8ivnbr1yf@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-6-a.s.protopopov@gmail.com>
	 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
	 <aM0AuFAnqGJgI0Kf@mail.gmail.com>
	 <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
	 <CAADnVQKsZnOXo-+sK-+=aov80WLgouVPbUXvdg8Na9uU-CmCew@mail.gmail.com>
	 <284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net>
	 <6237d7ce580a4c99361a460bd4724f882706746b.camel@gmail.com>
	 <aM28lJL8ivnbr1yf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 20:27 +0000, Anton Protopopov wrote:
> On 25/09/19 12:44PM, Eduard Zingerman wrote:
> > On Fri, 2025-09-19 at 21:28 +0200, Daniel Borkmann wrote:
> > > On 9/19/25 8:26 PM, Alexei Starovoitov wrote:
> > > > On Fri, Sep 19, 2025 at 12:12=E2=80=AFAM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > > On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
> > > > > > On 25/09/18 11:35PM, Eduard Zingerman wrote:
> > > > > > > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > > > > >=20
> > > > > > > [...]
> > > > > > >=20
> > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > index a7ad4fe756da..5c1e4e37d1f8 100644
> > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_=
verifier_env *env)
> > > > > > > >    struct bpf_insn *insn;
> > > > > > > >    void *old_bpf_func;
> > > > > > > >    int err, num_exentries;
> > > > > > > > + int old_len, subprog_start_adjustment =3D 0;
> > > > > > > >=20
> > > > > > > >    if (env->subprog_cnt <=3D 1)
> > > > > > > >            return 0;
> > > > > > > > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_=
verifier_env *env)
> > > > > > > >            func[i]->aux->func_idx =3D i;
> > > > > > > >            /* Below members will be freed only at prog->aux=
 */
> > > > > > > >            func[i]->aux->btf =3D prog->aux->btf;
> > > > > > > > -         func[i]->aux->subprog_start =3D subprog_start;
> > > > > > > > +         func[i]->aux->subprog_start =3D subprog_start + s=
ubprog_start_adjustment;
> > > > > > > >            func[i]->aux->func_info =3D prog->aux->func_info=
;
> > > > > > > >            func[i]->aux->func_info_cnt =3D prog->aux->func_=
info_cnt;
> > > > > > > >            func[i]->aux->poke_tab =3D prog->aux->poke_tab;
> > > > > > > > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf=
_verifier_env *env)
> > > > > > > >            func[i]->aux->might_sleep =3D env->subprog_info[=
i].might_sleep;
> > > > > > > >            if (!i)
> > > > > > > >                    func[i]->aux->exception_boundary =3D env=
->seen_exception;
> > > > > > > > +
> > > > > > > > +         /*
> > > > > > > > +          * To properly pass the absolute subprog start to=
 jit
> > > > > > > > +          * all instruction adjustments should be accumula=
ted
> > > > > > > > +          */
> > > > > > > > +         old_len =3D func[i]->len;
> > > > > > > >            func[i] =3D bpf_int_jit_compile(func[i]);
> > > > > > > > +         subprog_start_adjustment +=3D func[i]->len - old_=
len;
> > > > > > > > +
> > > > > > > >            if (!func[i]->jited) {
> > > > > > > >                    err =3D -ENOTSUPP;
> > > > > > > >                    goto out_free;
> > > > > > >=20
> > > > > > > This change makes sense, however, would it be possible to mov=
e
> > > > > > > bpf_jit_blind_constants() out from jit to verifier.c:do_check=
,
> > > > > > > somewhere after do_misc_fixups?
> > > > > > > Looking at the source code, bpf_jit_blind_constants() is the =
first
> > > > > > > thing any bpf_int_jit_compile() does.
> > > > > > > Another alternative is to add adjust_subprog_starts() call to=
 this
> > > > > > > function. Wdyt?
> > > > > >=20
> > > > > > Yes, it makes total sense. Blinding was added to x86 jit initia=
lly and then
> > > > > > every other jit copy-pasted it.  I was considering to move blin=
ding up some
> > > > > > time back (see https://lore.kernel.org/bpf/20250318143318.65678=
5-1-aspsk@isovalent.com/),
> > > > > > but then I've decided to avoid this, as this requires to patch =
every JIT, and I
> > > > > > am not sure what is the way to test such a change (any hints?)
> > > > >=20
> > > > > We have the following covered by CI:
> > > > > - arch/x86/net/bpf_jit_comp.c
> > > > > - arch/s390/net/bpf_jit_comp.c
> > > > > - arch/arm64/net/bpf_jit_comp.c
> > > > >=20
> > > > > People work on these jits actively:
> > > > > - arch/riscv/net/bpf_jit_core.c
> > > > > - arch/loongarch/net/bpf_jit.c
> > > > > - arch/powerpc/net/bpf_jit_comp.c
> > > > >=20
> > > > > So, we can probably ask to test the patch-set.
> > > > >=20
> > > > > The remaining are:
> > > > > - arch/x86/net/bpf_jit_comp32.c
> > > > > - arch/parisc/net/bpf_jit_core.c
> > > > > - arch/mips/net/bpf_jit_comp.c
> > > > > - arch/arm/net/bpf_jit_32.c
> > > > > - arch/sparc/net/bpf_jit_comp_64.c
> > > > > - arch/arc/net/bpf_jit_core.c
> > > > >=20
> > > > > The change to each individual jit is not complicated, just removi=
ng
> > > > > the transformation call. Idk, I'd just go for it.
> > > > > Maybe Alexei has concerns?
> > > >=20
> > > > No concerns.
> > > > I don't remember why JIT calls it instead of the verifier.
> > > >=20
> > > > Daniel,
> > > > do you recall? Any concern?
> > >=20
> > > Hm, I think we did this in the JIT back then for couple of reasons ii=
rc,
> > > the constant blinding needs to work from native bpf(2) as well as fro=
m
> > > cbpf->ebpf (seccomp-bpf, filters, etc), so the JIT was a natural loca=
tion
> > > to capture them all, and to fallback to interpreter with the non-blin=
ded
> > > BPF-insns when something went wrong during blinding or JIT process (e=
.g.
> > > JIT hits some internal limits etc). Moving bpf_jit_blind_constants() =
out
> > > from JIT to verifier.c:do_check() means constant blinding of cbpf->eb=
pf
> > > are not covered anymore (and in this case its reachable from unpriv).
> >=20
> > Hi Daniel,
> >=20
> > Thank you for the context.
> > So, the ideal location for bpf_jit_blind_constants() would be in
> > core.c in some wrapper function for bpf_int_jit_compile():
> >=20
> >   static struct bpf_prog *jit_compile(prog)
> >   {
> >   	tmp =3D bpf_jit_blind_constants()
> >         if (!tmp)
> >            return prog;
> >         return bpf_int_jit_compile(tmp);
> >   }
> >=20
> > A bit of a hassle.
> >=20
> > Anton, wdyt about a second option: adding adjust_subprog_starts()
> > to bpf_jit_blind_constants() and leaving all the rest as-is?
> > It would have to happen either way of call to bpf_jit_blind_constants()
> > itself is moved.
>=20
> So, to be clear, in this case adjust_insn_arrays() stays as in the
> original patch, but the "subprog_start_adjustment" chunks are
> replaced by calling the adjust_subprog_starts() (for better
> readability and consistency, right?)

Yes, by adding adjust_subprog_starts() call inside
bpf_jit_blind_constants() it should be possible to read
env->subprog_info[*].start in the jit_subprogs() loop directly,
w/o tracking the subprog_start_adjustment delta.
(At-least I think this should work).

