Return-Path: <bpf+bounces-14739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611787E79AA
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 08:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACA1281547
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4CA1C30;
	Fri, 10 Nov 2023 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InAGmmlk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29C15B9
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 07:16:06 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2283C0
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 23:16:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so23485331fa.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699600562; x=1700205362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v19n/5fSlXOKVJg5epoQLCSIErstfxHgISgKNg0ZKOM=;
        b=InAGmmlkxVHwZD1godm/tarLDvZSpv0gGcC2uBYO+uhRaLOjFd6hP+ncGuo/eiyufR
         IHUbZanN26zmXt6PrgXqn9ot3eAWv9eOHm3gNU2cNQkpsoGQZd1flK6j/fKmIgNT3WDt
         FsajPtcHZD061tHE98wlEKidj68F3IIhXnQnFHEg4e8EFYpkoBcA4GZLNeKf44CIu5f2
         O0TF6/KQKhGAKfH+CPECriyiIUZSzJQlNHKZxEV94C6mGK0KVMxtW31CCcLVmcjwRvXM
         54NCm8sspvdaaEM8dxLeEgV4i8J6xd4GYAyUxpCOf1u7kaNN30DGsH++1UVbs3jy8H72
         TL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600562; x=1700205362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v19n/5fSlXOKVJg5epoQLCSIErstfxHgISgKNg0ZKOM=;
        b=JQvvy0Lu4E9+ZrFuhhJSIPjECpDGz6RraUCsy7hRHFNfTG16hx5r4vbCvfaAbMDVQP
         HemQzWb5ilX+aczV4nu5yhaieMfiwYK2zRoiiFZipxiEW/NIMyZ+nZCuE8s/AWODCN4/
         cbI2h8q0enMFrEfOyXr0XlT9A4XB4IIsbQETL+3NSzKC7DwaD7u6lfNvbPu9N8tcuy9t
         GBauhJS5C9q9qvPPhkcaV//LOvtKsJOTFWiC8dphK11nhg9IXNzXSFSONUd9356NFST5
         W7wi0BsX0rNa9lqQ3hqseQ/zyr+tUzxuhxi5E0b2yVIeZNH97+agB7qHSFXAujPBWsly
         6org==
X-Gm-Message-State: AOJu0YxLJq+ScSKL6dv9DCcUUUUtyRjqcz/yzjZGlFUo4sGu1o5Weky5
	OiRxG/L6bLJ15oSdCOV3nZkF2GVzUvAj5bE5QdMeW01WopU=
X-Google-Smtp-Source: AGHT+IFYtKxGzkMPEvaGo0sy8XSyaryYReayY5YxH+Nzc1XBNaTigvcUzGdlV3/khe2+FX0dAYcq5b42MxtR8u9+a9g=
X-Received: by 2002:adf:d1cf:0:b0:323:2d01:f043 with SMTP id
 b15-20020adfd1cf000000b003232d01f043mr7332531wrd.3.1699589304962; Thu, 09 Nov
 2023 20:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-4-andrii@kernel.org>
 <CAADnVQKQ5TGGwGuaO0eghhnLRFZOVgLE7Hume8uPAvbo-AwA5g@mail.gmail.com> <CAEf4BzbVz9kPFSn4=3k+UOEanwQVeaNjOpRh_3pYLFRnbe3vkQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbVz9kPFSn4=3k+UOEanwQVeaNjOpRh_3pYLFRnbe3vkQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 20:08:13 -0800
Message-ID: <CAADnVQL6UrCKQw1WYbOh1GPhMR5cB3F7_An6-vSBK5Y-2=5tzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in
 privileged mode
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:41=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 8, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > >
> > > @@ -15622,11 +15619,11 @@ static int visit_insn(int t, struct bpf_ver=
ifier_env *env)
> > >                 /* conditional jump with two edges */
> > >                 mark_prune_point(env, t);
> > >
> > > -               ret =3D push_insn(t, t + 1, FALLTHROUGH, env, true);
> > > +               ret =3D push_insn(t, t + 1, FALLTHROUGH | CONDITIONAL=
, env);
> > >                 if (ret)
> > >                         return ret;
> > >
> > > -               return push_insn(t, t + insn->off + 1, BRANCH, env, t=
rue);
> > > +               return push_insn(t, t + insn->off + 1, BRANCH | CONDI=
TIONAL, env);
> >
> > If I'm reading this correctly, after the first conditional jmp
> > both fallthrough and branch become sticky with the CONDITIONAL flag.
> > So all processing after first 'if a =3D=3D b' insn is running
> > with loop_ok=3D=3Dtrue.
> > If so, all this complexity is not worth it. Let's just remove 'loop_ok'=
 flag.
>
> So you mean just always assume loop_ok, right?

yes.
Since not detecting the loop early only adds more cycles later
that states_maybe_looping() should catch quickly enough.

> >
> > Also
> > if (ret) return ret;
> > in the above looks like an existing bug.
> > It probably should be if (ret < 0) return ret;
>
> yeah, probably should be error-handling case

I thought that refactoring
commit 59e2e27d227a ("bpf: Refactor check_cfg to use a structured loop.")
is responsible...
but it looks to be an older bug.

