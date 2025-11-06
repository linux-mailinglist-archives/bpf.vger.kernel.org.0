Return-Path: <bpf+bounces-73766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 057BDC38C2C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 580264F2B8E
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5662522A4DB;
	Thu,  6 Nov 2025 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfwZJbZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9E2144CF
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394183; cv=none; b=b6ym+VsXmzGIeQMi2xK3kJpoFlXtP/vnzWRvKOZLrnjB5Fc5uGKl2IiTaM31reNcof9HNEttKGmoZ04w+Vg4XSEr59m3cRhQqKWDn8fFcqsBeOWfwo8XX0jit1teT3YYT3PjyOn1CbpQgD8yGepzWm1vZeQN3P19LiOD0/cswLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394183; c=relaxed/simple;
	bh=lWdmCCx3hTdIji+2ETPgIeSq0Pa5Gt+iqk21j70P55Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5wSZN0AI6BYZwfkLUYTfbeK2BU+sL02ALfY7gdmpR7cJFYjbiPdrEbgkehq0EHF2iDhHNLM6oqZUfL0lGZ6BKNPqbszX5exL2hPtzKh0BP4Fx2lVM5Ng1zo6K3poF7fuh/nljZe0t4tEO3GklS5WOXWaxN3kV3Ul17vjiAvuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfwZJbZ6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429bccca1e8so281135f8f.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 17:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762394180; x=1762998980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgBFJI2TLWqjJ/A72wTyxjsMmugV5fd2ORst+LbbIHc=;
        b=WfwZJbZ63J2QGM8bA4HkDnzRr1pe3+pUn/+bk9TDW/Y8WdxSuO4yan6rpa15eeM/qZ
         nQq/fH6qf1oNKIRyWtfMfOaF+bnSWij2aBqTuV1gJibWZrxAb6hcte/8WI3JAjujxc6N
         0YNclVw+VKQ3ZBOe9i4zfGKbrfsotdZAHr05HYxsoqlGkW6EBb3C3NXo69mQaLD+7zCa
         o89WMoIMYkFSw++XK+dle6OUKypXTEzht9q+FIt4nvoLfFhaTdWnmbRpjD0vp95xcgVX
         h2+kiqSNsIUt3C/2i8DXD9WDWS/R9fToZGQMTc/4TQnxLXBW6SpTwv6HyuNX/h1nmfX6
         jX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762394180; x=1762998980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgBFJI2TLWqjJ/A72wTyxjsMmugV5fd2ORst+LbbIHc=;
        b=WJqnDhOkX/T0tiqSd1KJXlKeyBBXMRwFWPuMB0jSdw0s2qkG4ydQZmh6kmYjzPILx8
         NBthuDPK3vUjL6zJ3cUAZEFUGP9emzoQUnYYTCr8LknYcgID1LLBscrUsontKoFmlFwX
         irkyyLlik6+IIB5Hc4nsJfG0KPM+/XPZyLeg4bcu1Pce5IQwy1mHjIOfe+6psxZfNE2b
         aSaKtCM+wbUZ+dfwfNmf9w4IUeUol6n8sXl0Oc6w5S2APKY+iT9+I+6lw+yk0QvraJ11
         yeVJ1HTJMYClyvhMfV39EgSLFCdBQ1qges+53TNPDRWfDfX7PGG+bgjakhA75s5NI+qE
         Qv2A==
X-Forwarded-Encrypted: i=1; AJvYcCWSwlU5da3pwM5R4MTOd6UD5CCFC+gXp0yAlrZzsQKGAQ/JTRDWV4PDZ47XGAiBIgnpRKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMD7WBCj6uWmcD5xhrtsr16M+c3yvqAf2nv9MrUS5mJwcEJRu
	mNVJ6qnV523AbMU7sMn/WDOSidEzi8QuV9WAtOLnoxo2L1pxfpWbwpaahMaDuT78KV0LsksQEMW
	OXx+CRqR0fCSlLVR22RhGhIwCO9DdXXk=
X-Gm-Gg: ASbGnctSv5ChDqqhVD30W75khTf3CCC2FGUGWx9I2xnpgqKu52VdxA5X7ckzx463cs4
	Qq8Oe0GzwLQQrmQUiEtdF0uizB8xPc6XPwWIzmJuoyIJ4Je+wWjImvNSq9oI646h3zqRbNyyisO
	Mqedzdlp85+i3BL7Td3BAfjWZZXfQIiagMGY7mLsJzB6MnqweKzucP6nhh/38egKsF61B0xZM06
	e9OMeLs3y8iwpH0/a5BU7gxAfzYyI/uS7SWYtKzGKDb+bD/b4vaAUtXfy3w3YmR/oLwFnmPhTtH
	on4wcits8btF3Wgi+Q==
X-Google-Smtp-Source: AGHT+IGie9+RT+2dqRTxBJTXbNC/QSUhVpXeRjJORgVE55JgGaU+ry2XDDa1qs/VquHZ9LYfZQHKb9j5FV351cb4d5o=
X-Received: by 2002:a05:6000:647:b0:429:ba8a:a860 with SMTP id
 ffacd0b85a97d-429e32c60e9mr5400063f8f.12.1762394180289; Wed, 05 Nov 2025
 17:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <7463cbcabcd06016d7dfbd858f4e089c4acd88f1.camel@gmail.com> <aQvHiSXN72/Q1qE+@mail.gmail.com>
In-Reply-To: <aQvHiSXN72/Q1qE+@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 17:56:09 -0800
X-Gm-Features: AWmQ_bmAEIZnSLRq7L43wW6SHHrVPqIRrbuOiNm1J6Lql51wIY7ekOn5E97RTAg
Message-ID: <CAADnVQJfLehMmreJXy65RpuwFkc+UK5wx_jkZM6e4-kof7k14Q@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 00/12] BPF indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:48=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/11/05 12:51PM, Eduard Zingerman wrote:
> > On Wed, 2025-11-05 at 09:03 +0000, Anton Protopopov wrote:
> > > This patchset implements a new type of map, instruction set, and uses
> > > it to build support for indirect branches in BPF (on x86). (The same
> > > map will be later used to provide support for indirect calls and stat=
ic
> > > keys.) See [1], [2] for more context.
> > >
> > > Short table of contents:
> > >
> > >   * Patches 1-6 implement the new map of type
> > >     BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
> > >     be used to track the "original -> xlated -> jitted mapping" for
> > >     a given program.
> > >
> > >   * Patches 7-12 implement the support for indirect jumps on x86 and =
add libbpf
> > >     support for LLVM-compiled programs containing indirect jumps, and=
 selftests.
> > >
> > > The jump table support was merged to LLVM and now can be
> > > enabled with -mcpu=3Dv4, see [3]. The __BPF_FEATURE_GOTOX
> > > macros can be used to check if the compiler supports the
> > > feature or not.
> > >
> > > See individual patches for more details on the implementation details=
.
> >
> > I retested this series with upstream clang [1] (includes latest
> > changes for relocations handling from Yonghong), and all works as
> > expected.
> >
> > The series is ready to land from my perspective.
> > (AI has a few notes on tests, though).
>
> Thanks.  The fixes to the latest AI comments are as follows:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_gotox.c
> index ea1cd3cda156..d138cc7b1bda 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> @@ -90,7 +90,7 @@ static void check_one_map_two_jumps(struct bpf_gotox *s=
kel)
>
>         for (i =3D 0; i < prog_info.nr_map_ids; i++) {
>                 map_fd  =3D bpf_map_get_fd_by_id(map_ids[i]);
> -               if (!ASSERT_GE(map_fd, 0, "bpf_program__fd(one_map_two_ju=
mps)"))
> +               if (!ASSERT_GE(map_fd, 0, "bpf_map_get_fd_by_id"))
>                         return;
>
>                 len =3D sizeof(map_info);
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/to=
ols/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index cf852318eeb2..269870bec941 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -406,7 +406,7 @@ static void check_no_map_reuse(void)
>
>         /* correctness: check that prog is still loadable without fd_arra=
y */
>         extra_fd =3D prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> -       if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD): expected no error=
"))
> +       if (!ASSERT_GE(extra_fd, 0, "bpf(BPF_PROG_LOAD): expected no erro=
r"))

Fixed while applying. Thanks a bunch everyone.

