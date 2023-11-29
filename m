Return-Path: <bpf+bounces-16158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD27FDCF2
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D933B20F69
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183303AC23;
	Wed, 29 Nov 2023 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eujh9XfI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1798F
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:23:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a178d491014so93822366b.3
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701275034; x=1701879834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fqxIvGQFdDlpb5rax8CkZrJACPX7NZrGa1OOAItN14=;
        b=Eujh9XfIkV8iiYKerPS/MuWu/FMYamV1ocEz9O1Kxh0tLldT3yEGRArX+gNoX6tIvm
         hYlViyUIEihZbYanHfpKlK6p4Af6/hhC4czDd5yVKhsFoVfYmZRXI6vWBeskes8VaBPC
         UAF2Q3TMsAxeX83wGC8f0VmP4mb4/ZMWGLU2mTdGb8U7mAm/LrfC43OyoDX3iAsAkyA+
         LVSA2bBYIFkFWLov0ufF/xHeRCaSICzn3AdOloNvpyKsY0Ox0TCCMVBJfrGZwxZeUWFx
         4IunlLE6SmjmF81jVV4j933NNicB6IIDwWQi3xGCavMypMEOpRvgF5eNBXt+um/D1M1r
         8qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275034; x=1701879834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fqxIvGQFdDlpb5rax8CkZrJACPX7NZrGa1OOAItN14=;
        b=LKQ2QHaK8/PPQt/Nvcc0nKI84na+lcvkzyAIVBBA4P7StKlFoSx0cp61qVI28vGiTm
         yvZZoIIyqUFTbID8s5WEJmFKG58rJGjBru0JtOQsAofmmIa10AMs5uYsqElfoq93aU33
         i83n7tmW0aW0rHkSR7wy1KiKFHlLBQaJGVuglwCsocYVSzWOF8lTpfc3rg992AkhbKW/
         +dk6iJEkL1JgNvim0wpbpDEIcAb2xcrWR1eTsOu420BhPqVi5BrRgj0XpISfbCEE22tV
         OEWW7o5twa6t898yKIuAz03a0yX8uPa6b21mdpRotKQ9xkiuicfHNCzR612YwIe+vlPh
         rlNg==
X-Gm-Message-State: AOJu0YzKRCLJifQHOpF8ThvHu164rhjn3qdkopxmhEH9X21f4mMDKQMW
	9JyV8wLydA4TIZ7+c9Dp8qiDEgBF42lEAI3LOug=
X-Google-Smtp-Source: AGHT+IF6qru3jO2xaH4gmtpvheoBBQVCXZxZMjfraVmfylr2hAoQ9ede51RO5E/hiZSqmTe7osj2jtEjNZKPFiQTpdw=
X-Received: by 2002:a17:906:7398:b0:a17:c431:730 with SMTP id
 f24-20020a170906739800b00a17c4310730mr990884ejl.73.1701275034222; Wed, 29 Nov
 2023 08:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003620.1049610-1-andrii@kernel.org> <20231129003620.1049610-6-andrii@kernel.org>
 <f4zdgu5gyjo5ldq5pvrdzyrhvyx7ec2xus6ngcfdok5ibma3op@jzf4cofcyab6>
In-Reply-To: <f4zdgu5gyjo5ldq5pvrdzyrhvyx7ec2xus6ngcfdok5ibma3op@jzf4cofcyab6>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Nov 2023 08:23:41 -0800
Message-ID: <CAEf4BzZyHd80b3WEJLrBfim4oZ6t7pVMYhk_oznPg63a-r-P_Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/10] bpf: enforce precise retval range on
 program exit
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 3:24=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Tue, Nov 28, 2023 at 04:36:15PM -0800, Andrii Nakryiko wrote:
> > Similarly to subprog/callback logic, enforce return value of BPF progra=
m
> > using more precise umin/umax range.
> >
> > We need to adjust a bunch of tests due to a changed format of an error
> > message.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> ...
>
> Q: should the missing register name and values be added?
>

Probably not, it makes future refactoring a bit less painful. If the
important part is to check that there *was* a message about invalid
return result, rather *what exact format* of that message was, then
matching for a substring is enough and makes the test a bit more
robust to future slight refactorings.

> I know relatively little about selftest, but scrolling through it looks
> as though the expect verifier message is incomplete. (Admittedly lots of
> them are like this even before this patch, and this patch improves the
> situation already)
>

Often times it's actually a mistake to expect exact format, it makes
for painful refactoring and improvements. I feel it every time I touch
verifier log formatting logic :( So I don't want to add to that pain.


> e.g.
>
> > --- a/tools/testing/selftests/bpf/progs/test_global_func15.c
> > +++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
> > @@ -13,7 +13,7 @@ __noinline int foo(unsigned int *v)
> >  }
> >
> >  SEC("cgroup_skb/ingress")
> > -__failure __msg("At program exit the register R0 has value")
> > +__failure __msg("At program exit the register R0 has ")
> >  int global_func15(struct __sk_buff *skb)
> >  {
> >       unsigned int v =3D 1;
>
> looks like it is missing umin/umax=3D1
>
> ...
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retc=
ode.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> > index d6c4a7f3f790..4655f01b24aa 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> > @@ -7,7 +7,7 @@
> >
> >  SEC("cgroup/sock")
> >  __description("bpf_exit with invalid return code. test1")
> > -__failure __msg("R0 has value (0x0; 0xffffffff)")
> > +__failure __msg("umax=3D4294967295 should have been in [0, 1]")
> >  __naked void with_invalid_return_code_test1(void)
> >  {
> >       asm volatile ("                                 \
>
> looks like it is missing mention of R0, etc.

