Return-Path: <bpf+bounces-129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D36F8727
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D6628105E
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A0C2FB;
	Fri,  5 May 2023 16:58:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCF8BF1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 16:58:22 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAC30EE
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 09:58:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965cc5170bdso237180966b.2
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683305899; x=1685897899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3mFSDN9hyXUmX/bLoIQSBxxOO9I7CmknjFA9AKDBjs=;
        b=QvPe8WJgbvEfEZ+pf1TaE3zKqiCZ4f156yxXK95pY1ia0Zh8laRQ+iPNzxCrLKdsUs
         BneOnTGTJ8Jd2sNh/3b6Rf+LKaqSHfHhvhiGFoT+xF5rHLfIv3d0+5mH3jFdtE/GXmpA
         WlvFN4V/6Qs0EOFfXtmTceBaE+BKOQv0LcwkgbMkdLAgAuPDDXUqZCZZ8ZiCIxKd2vrF
         2L/J7ZvC2QAqjxj4tDozuh30oC1bMLMnh0Dw1V+2+eeqJzyA+PY9C2j+uPTLf9FByz2z
         9XQLP1FJ77P2xWnLv0kM/KuWvg0+/sA66pR7Xkv6K4Qbt3A00Bc8d/2m3iAJ2/wmT8uP
         xR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305899; x=1685897899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3mFSDN9hyXUmX/bLoIQSBxxOO9I7CmknjFA9AKDBjs=;
        b=bMUUgFsxiM3JBYpGCjNvbxd9cPIsfmpOu7TuupRv3j3eg8sJFMFCzZvv4ngKwGBBJ2
         n72ETvhu0JBtafpTxdcwBdLhOGQu9g1o8Tx6sQdE2sd/CEqdW98VbxhamcLg+cVPLZn+
         /cZDA90vwCywnNCQu8FLPGkAdQYzeXJrQsDOBHG2vKHv+qopcGnZo5bIIMTKSSjjjmwK
         9uztSLwFskUZr11kb5z5gVdaH5ZPUXnwd9ANUGrUuZ+6pEBFX6Z01AUr7ObY+jhL1fD0
         pH0inVxk8dsnnChoxDzAMB91fj12X0QUWmn1o1KJMNkay30fYBlX1kV9jJ7QC66364p3
         EQtg==
X-Gm-Message-State: AC+VfDxaY9FRy866Ci0qNFMfkt7Z5uhYzdMbr/8D+1PkdJaLO608G5hh
	5H9vAbn/MO1qgClHdhhmlYh2TbxHjv5XlivL+n4=
X-Google-Smtp-Source: ACHHUZ5L4S5s9E4PfhO9ZcTyAe6Y/pP6nKdETYJo3ieLCqw/d+YWeJY3gb/gFGJ22MAB2caFvALnhFQd6z8HoaV4ZDc=
X-Received: by 2002:a17:907:3602:b0:947:5acb:920c with SMTP id
 bk2-20020a170907360200b009475acb920cmr1534019ejc.34.1683305899076; Fri, 05
 May 2023 09:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
 <d79d6281-845f-c395-79eb-5963389971d3@meta.com> <CADxym3bb6wxF-aRRJBYrfiwMRU8=JjYn69YffSwtKphj7Cetbg@mail.gmail.com>
 <CAEf4BzaF4F1rKH=VYVRj0Qapwze-Fj519eoAz+Qq6cHH=52arw@mail.gmail.com> <CADxym3bf_-2tgtviiE1azAWGofZK1waR44KBuq1PnmOg1pe07Q@mail.gmail.com>
In-Reply-To: <CADxym3bf_-2tgtviiE1azAWGofZK1waR44KBuq1PnmOg1pe07Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 May 2023 09:58:07 -0700
Message-ID: <CAEf4BzZR1NB8tr_qc_fpW5-rLVOzVQGtrdevL+FguoPuiVZ3hQ@mail.gmail.com>
Subject: Re: bpf: add support to check kernel features in BPF program
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Alan Maguire <alan.maguire@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 11:54=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, May 5, 2023 at 12:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 4, 2023 at 7:42=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > On Fri, May 5, 2023 at 12:53=E2=80=AFAM Yonghong Song <yhs@meta.com> =
wrote:
> > > >
> > > >
> > > >
> > > > On 5/4/23 4:09 AM, Menglong Dong wrote:
> > > > > Hello,
> > > > >
> > > > > I find that it's not supported yet to check if the bpf features a=
re
> > > > > supported by the target kernel in the BPF program, which makes
> > > > > it hard to keep the BPF program compatible with different kernel
> > > > > versions.
> > > > >
> > > > > For example, I want to use the helper bpf_jiffies64(), but I am n=
ot
> > > > > sure if it is supported by the target, as my program can run in
> > > > > kernel 5.4 or kernel 5.10. Therefore, I have to compile two versi=
ons
> > > > > BPF elf and load one of them according to the current kernel vers=
ion.
> > > > > The part of BPF program can be this:
> > > > >
> > > > > #ifdef BPF_FEATS_JIFFIES64
> > > > >    jiffies =3D bpf_jiffies64();
> > > > > #else
> > > > >    jiffies =3D 0;
> > > > > #endif
> > > > >
> > > > > And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.h
> > > > > with -DBPF_FEATS_JIFFIES64 or not.
> > > > >
> > > > > This method is too silly, as I have to compile 8(2*2*2) versions =
of
> > > > > the BPF program if I am not sure if 3 bpf helpers are supported b=
y the
> > > > > target kernel.
> > > > >
> > > > > Therefore, I think it may be helpful if we can check if the helpe=
rs
> > > > > are support like this:
> > > > >
> > > > > if (bpf_core_helper_exist(bpf_jiffies64))
> > > > >    jiffies =3D bpf_jiffies64();
> > > > > else
> > > > >    jiffies =3D 0;
> > > > >
> > > > > And bpf_core_helper_exist() can be defined like this:
> > > > >
> > > > > #define bpf_core_helper_exist(helper)                        \
> > > > >      __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)
> > > > >
> > > > > Besides, in order to prevent the verifier from checking the helpe=
r
> > > > > that is not supported, we need to remove the dead code in libbpf.
> > > > > As the kernel already has the ability to remove dead and nop insn=
,
> > > > > we can just make the dead insn to nop.
> > > > >
> > > > > Another option is to make the BPF program support "const value".
> > > > > Such const values can be rewrite before load, the dead code can
> > > > > be removed. For example:
> > > > >
> > > > > #define bpf_const_value __attribute__((preserve_const_value))
> > > > >
> > > > > bpf_const_value bool is_bpf_jiffies64_supported =3D 0;
> > > > >
> > > > > if (is_bpf_jiffies64_supported)
> > > > >    jiffies =3D bpf_jiffies64();
> > > > > else
> > > > >    jiffies =3D 0;
> > > > >
> > > > > The 'is_bpf_jiffies64_supported' will be compiled to an imm, and
> > > > > can be rewrite and relocated through libbpf by the user. Then, we
> > > > > can make the dead insn 'nop'.
> > > >
> > > > A variant of the second approach should already work.
> > > > You can do,
> > > >
> > > > volatile const is_bpf_jiffies64_supported;
> > > >
> > > > ...
> > > >
> > > > if (is_bpf_jiffies64_supported)
> >
> > you don't even have to use global variable to detect helper support, yo=
u can do:
> >
> > if (bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_jiffies64))
> >     jiffies =3D bpf_jiffies64();
> > else
> >     jiffies =3D 0;
>
> Perfect! Now I don't even have to probe the helper support
> in the user space. It maybe a good idea to introduce a:
>
> #define bpf_core_helper_exist(name) \
>   bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_##name)
>
> to help the users who don't know this method.

I'm hesitant because such a macro assumes that enum bpf_func_id (which
presumably comes from user-supplied vmlinux.h) is up-to-date to
contain all the interesting helpers. Such kind of assumptions make me
question whether adding such macros as part of official APIs is the
right choice.

But using bpf_core_enum_value_exists() for checking helper support is
explicitly called out ([0]) in the BPF CO-RE reference guide, so
hopefully that makes it a bit more apparent to users.

  [0] https://nakryiko.com/posts/bpf-core-reference-guide/#bpf-core-enum-va=
lue-exists

>
> Thanks!
> Menglong Dong
>
> >
> > > >      jiffies =3D bpf_jiffies64();
> > > > else
> > > >      jiffies =3D 0;
> > > >
> > > >
> > > > After skeleton is openned but before prog load, you can do
> > > > a probe into the kernel to find whether the helper is supported
> > > > or not, and set is_bpf_jiffies64_supported accordingly.
> > > >
> > > > After loading the program, is_bpf_jiffies64_supported will be
> > > > changed to 0/1, verifier will do dead code elimination properly.
> > > >
> > >
> > > Great, that works! Thanks~
> > >
> > > > >
> > > > > What do you think? I'm not sure if these methods work and want
> > > > > to get some advice before coding.
> > > > >
> > > > > Thanks!
> > > > > Menglong Dong

