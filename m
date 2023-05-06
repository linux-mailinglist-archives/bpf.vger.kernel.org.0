Return-Path: <bpf+bounces-173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB656F8E1C
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 04:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C3D1C21B0B
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 02:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3D139B;
	Sat,  6 May 2023 02:45:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078207E
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 02:45:49 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30167AB8
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 19:45:47 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-b9d8730fe5aso3373547276.1
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 19:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683341147; x=1685933147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvU874J6onlFBdXdDCmohehWjuB+sd1VWvQbA53aTwo=;
        b=ZH6ZzzGguNREMXzAOKvpiT9mNk9qZSwYNu0z4duVVVxeGDOwPelypXTgvT5QH9yhRh
         HbQCE99wbF2yRTvAxgN24e9gQsKBroh/I0J2OBZVX9Nh1Sd7F1GAwcgG3OTcNvXdg8Ra
         oN3fkLwaFhyRoOJJGzPq87Ei134/hacWsY34LZTYt+41T6ugH1T+MgKvm/zO9vTXi1pu
         78fV4PZiN6FsQVWqchMxZPHYiI2tELzqaTFPmq/rFB7zwyb/TorH0cSEyGBiga2wMO1H
         bqPKF+zbQIr070Ny5Gp7axWiDFb76ZL9+58x4QmuNbOt1sbA1IDtLP6ok9CGPxr88/gD
         +WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683341147; x=1685933147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvU874J6onlFBdXdDCmohehWjuB+sd1VWvQbA53aTwo=;
        b=XHSlDoccXJ+tF6mW5EIdzrnn2WRw3wMhY6YQSrgRk1Gh1NkmGyg0i1OISuRGiAUVOG
         XpcpmwYofimHGpbXlbz4QiOgMmuKbFmiLosuPb+K4MD0rR+QbgwujyBmxpVP0p5HP3mD
         Ne0tTo19xv+yH+ry32WWAfSj+mp0s4xVEcQ7yJhc5lncI/mvj+G4tHT2GZzp9yVT9RKB
         JUYEbrhB7hWFUOE0WHZAlk6+w9OPwhwuNpIV1et1TEUXqIiqWfo5SMhAHXFQdzeJAFpp
         GNCkVoB/O5jUiM2rA+Ys4O28/RkiXyfKp+n3L5GTusAUT+woy0fERtuENULtonM1a+XC
         S7Kg==
X-Gm-Message-State: AC+VfDy2T14N55DA4uFyDzJnqHEDawDLEptmaXFIpOIGYNQ37oMWhjsg
	wWLjLJ6UwSI36Nhfd3HV7XAdztT2YcKIYOaC2Bcq1nKwCfC0PSGB
X-Google-Smtp-Source: ACHHUZ6l4LajZxW5r/pzRmeIjxYzpTzcYwKBNNRa+MaAUbZVZNPwCPtR48I/ckLDvemH/YlNR2v5953C46MxaHqxbwo=
X-Received: by 2002:a25:4d84:0:b0:ba1:d664:caed with SMTP id
 a126-20020a254d84000000b00ba1d664caedmr3643522ybb.36.1683341147085; Fri, 05
 May 2023 19:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
 <d79d6281-845f-c395-79eb-5963389971d3@meta.com> <CADxym3bb6wxF-aRRJBYrfiwMRU8=JjYn69YffSwtKphj7Cetbg@mail.gmail.com>
 <CAEf4BzaF4F1rKH=VYVRj0Qapwze-Fj519eoAz+Qq6cHH=52arw@mail.gmail.com>
 <CADxym3bf_-2tgtviiE1azAWGofZK1waR44KBuq1PnmOg1pe07Q@mail.gmail.com> <CAEf4BzZR1NB8tr_qc_fpW5-rLVOzVQGtrdevL+FguoPuiVZ3hQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZR1NB8tr_qc_fpW5-rLVOzVQGtrdevL+FguoPuiVZ3hQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 6 May 2023 10:45:35 +0800
Message-ID: <CADxym3b5zGP_zX3cUurqmwfR-dPhDXKx=QoxVG+-5EVtiadnFA@mail.gmail.com>
Subject: Re: bpf: add support to check kernel features in BPF program
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Alan Maguire <alan.maguire@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, May 6, 2023 at 12:58=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 4, 2023 at 11:54=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Fri, May 5, 2023 at 12:12=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, May 4, 2023 at 7:42=E2=80=AFPM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > On Fri, May 5, 2023 at 12:53=E2=80=AFAM Yonghong Song <yhs@meta.com=
> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 5/4/23 4:09 AM, Menglong Dong wrote:
> > > > > > Hello,
> > > > > >
> > > > > > I find that it's not supported yet to check if the bpf features=
 are
> > > > > > supported by the target kernel in the BPF program, which makes
> > > > > > it hard to keep the BPF program compatible with different kerne=
l
> > > > > > versions.
> > > > > >
> > > > > > For example, I want to use the helper bpf_jiffies64(), but I am=
 not
> > > > > > sure if it is supported by the target, as my program can run in
> > > > > > kernel 5.4 or kernel 5.10. Therefore, I have to compile two ver=
sions
> > > > > > BPF elf and load one of them according to the current kernel ve=
rsion.
> > > > > > The part of BPF program can be this:
> > > > > >
> > > > > > #ifdef BPF_FEATS_JIFFIES64
> > > > > >    jiffies =3D bpf_jiffies64();
> > > > > > #else
> > > > > >    jiffies =3D 0;
> > > > > > #endif
> > > > > >
> > > > > > And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.=
h
> > > > > > with -DBPF_FEATS_JIFFIES64 or not.
> > > > > >
> > > > > > This method is too silly, as I have to compile 8(2*2*2) version=
s of
> > > > > > the BPF program if I am not sure if 3 bpf helpers are supported=
 by the
> > > > > > target kernel.
> > > > > >
> > > > > > Therefore, I think it may be helpful if we can check if the hel=
pers
> > > > > > are support like this:
> > > > > >
> > > > > > if (bpf_core_helper_exist(bpf_jiffies64))
> > > > > >    jiffies =3D bpf_jiffies64();
> > > > > > else
> > > > > >    jiffies =3D 0;
> > > > > >
> > > > > > And bpf_core_helper_exist() can be defined like this:
> > > > > >
> > > > > > #define bpf_core_helper_exist(helper)                        \
> > > > > >      __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)
> > > > > >
> > > > > > Besides, in order to prevent the verifier from checking the hel=
per
> > > > > > that is not supported, we need to remove the dead code in libbp=
f.
> > > > > > As the kernel already has the ability to remove dead and nop in=
sn,
> > > > > > we can just make the dead insn to nop.
> > > > > >
> > > > > > Another option is to make the BPF program support "const value"=
.
> > > > > > Such const values can be rewrite before load, the dead code can
> > > > > > be removed. For example:
> > > > > >
> > > > > > #define bpf_const_value __attribute__((preserve_const_value))
> > > > > >
> > > > > > bpf_const_value bool is_bpf_jiffies64_supported =3D 0;
> > > > > >
> > > > > > if (is_bpf_jiffies64_supported)
> > > > > >    jiffies =3D bpf_jiffies64();
> > > > > > else
> > > > > >    jiffies =3D 0;
> > > > > >
> > > > > > The 'is_bpf_jiffies64_supported' will be compiled to an imm, an=
d
> > > > > > can be rewrite and relocated through libbpf by the user. Then, =
we
> > > > > > can make the dead insn 'nop'.
> > > > >
> > > > > A variant of the second approach should already work.
> > > > > You can do,
> > > > >
> > > > > volatile const is_bpf_jiffies64_supported;
> > > > >
> > > > > ...
> > > > >
> > > > > if (is_bpf_jiffies64_supported)
> > >
> > > you don't even have to use global variable to detect helper support, =
you can do:
> > >
> > > if (bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_jiffies64))
> > >     jiffies =3D bpf_jiffies64();
> > > else
> > >     jiffies =3D 0;
> >
> > Perfect! Now I don't even have to probe the helper support
> > in the user space. It maybe a good idea to introduce a:
> >
> > #define bpf_core_helper_exist(name) \
> >   bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_##name)
> >
> > to help the users who don't know this method.
>
> I'm hesitant because such a macro assumes that enum bpf_func_id (which
> presumably comes from user-supplied vmlinux.h) is up-to-date to
> contain all the interesting helpers. Such kind of assumptions make me
> question whether adding such macros as part of official APIs is the
> right choice.

You are right, it can confuse the users if the target helper
isn't present in the vmlinux.h.

>
> But using bpf_core_enum_value_exists() for checking helper support is
> explicitly called out ([0]) in the BPF CO-RE reference guide, so
> hopefully that makes it a bit more apparent to users.
>
>   [0] https://nakryiko.com/posts/bpf-core-reference-guide/#bpf-core-enum-=
value-exists
>

This reference guide is awesome! I won't have these questions
if I have read it.

Thanks!
Menglong Dong

> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > > > >      jiffies =3D bpf_jiffies64();
> > > > > else
> > > > >      jiffies =3D 0;
> > > > >
> > > > >
> > > > > After skeleton is openned but before prog load, you can do
> > > > > a probe into the kernel to find whether the helper is supported
> > > > > or not, and set is_bpf_jiffies64_supported accordingly.
> > > > >
> > > > > After loading the program, is_bpf_jiffies64_supported will be
> > > > > changed to 0/1, verifier will do dead code elimination properly.
> > > > >
> > > >
> > > > Great, that works! Thanks~
> > > >
> > > > > >
> > > > > > What do you think? I'm not sure if these methods work and want
> > > > > > to get some advice before coding.
> > > > > >
> > > > > > Thanks!
> > > > > > Menglong Dong

