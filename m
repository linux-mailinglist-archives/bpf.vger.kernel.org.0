Return-Path: <bpf+bounces-4725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636C74E65E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 07:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22542814AE
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA96125BA;
	Tue, 11 Jul 2023 05:34:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E003C28
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 05:34:42 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65121134
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 22:34:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403470df1d0so29258211cf.0
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689053679; x=1691645679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIwf0DRgkjpa7bcOHOBgKi+H0CPdK3A9qZcBSfK3zR8=;
        b=wHXXXmxYs9YQOrj5t2WFFpthbnwHrAg5bjwSzUd0yy0WBvNnFLSPpvY1R49+kkMk2f
         WQXQsnCSqvaVnMKwq2GMDmQk0CJ7Q4GV0lo4gkhgioqKDx84GolDiISnsgH1qkdUjuFW
         Uuhh4mH6EEDWf5Mn+qQeckcxXwd5h6a5P43Z/Q8qdN78mczYQPx2V1C5fCShwHKM6ss3
         uZw2n2J7SrDDMjQYUoKLqALxUxtYFjk5lfx0rFb5b2oBYe/Euh8VLcrMkekNZb8KaZEV
         XPwABjTxHiKlf1CRn3xV1pjDouLn2n057ldQpfzTZFbPwiWeG3viObLB9jwsFs93wF4k
         +R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689053679; x=1691645679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIwf0DRgkjpa7bcOHOBgKi+H0CPdK3A9qZcBSfK3zR8=;
        b=JAub9UANYLawe4hOgOtsINZ73iBnk/2652gcdwJFveSeGAJzwu6CWZrLLgS2l7t1gV
         8I0EoE5HLphaBZvdnQdnydk8Nj5Mxjzylvz3toCbse2QSKFnmtp4Pxka8yYRSx8SxH8X
         BSImMyyTE1RtJ/5YB6Y4SVBjMdhe3soF9szmJKJJ5v8A3f4FgO3C9PIdpgsB0hYJKPKJ
         mhKhcNV8IhNB7Xvb2Hjvf3Oa2LtB9V/y2noUn1fEstvtuviFdWy200N/zrU5rHO4rIax
         wnB+E5wkJ4NxPAtDtE/Nk833mdybdyKjdRHxaO/RHLG6gODNCRPRxTQJwbV29ouLjMAn
         V6lg==
X-Gm-Message-State: ABy/qLbwqET0aGflPWNjS5RqUvxQLm6VjKUlOolmTd3kwYtuSRat6O1G
	21vYUKtXh1zfKEBmeN1tBxeePiz35Rqi0WEcan9wyNeQDFXgloe6
X-Google-Smtp-Source: APBJJlF3wh2QWP0CsAV7NDrBJUr0sKjUL5tXnd6F7okH8IvlrI9vOLpYlcnuBeAsxImNm6786Y2VhnP2+oUURT+PpAQ=
X-Received: by 2002:a0c:e107:0:b0:635:ddc7:a0fe with SMTP id
 w7-20020a0ce107000000b00635ddc7a0femr16279668qvk.9.1689053679469; Mon, 10 Jul
 2023 22:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr> <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
 <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com> <CAADnVQJR7YFcjqgiGABX-_jJEK7rQTrO8cGFJiZ16oOtpbmVNA@mail.gmail.com>
In-Reply-To: <CAADnVQJR7YFcjqgiGABX-_jJEK7rQTrO8cGFJiZ16oOtpbmVNA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 11 Jul 2023 01:34:29 -0400
Message-ID: <CADx9qWiBxoe6RAvfXq4xRHTshv8YNOtvG6THEx18jVOJ8WFDow@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf, docs: Specify twos complement as format for
 signed integers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 12:47=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 10, 2023 at 8:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
> >
> > On Mon, Jul 10, 2023 at 11:00=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr=
> wrote:
> > > >
> > > > In the documentation of the eBPF ISA it is unspecified how integers=
 are
> > > > represented. Specify that twos complement is used.
> > > >
> > > > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > > > ---
> > > >  Documentation/bpf/instruction-set.rst | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/=
bpf/instruction-set.rst
> > > > index 751e657973f0..63dfcba5eb9a 100644
> > > > --- a/Documentation/bpf/instruction-set.rst
> > > > +++ b/Documentation/bpf/instruction-set.rst
> > > > @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src=
 & mask)
> > > >  BPF_END   0xd0   byte swap operations (see `Byte swap instructions=
`_ below)
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > >
> > > > +eBPF supports 32- and 64-bit signed and unsigned integers. It does
> > > > +not support floating-point data types. All signed integers are rep=
resented in
> > > > +twos-complement format where the sign bit is stored in the most-si=
gnificant
> > > > +bit.
> > >
> > > Could you point to another ISA document (like x86, arm, ...) that
> > > talks about signed and unsigned integers?
> >
> > Thank you for the reply. I hope that this change is useful. I proposed
> > this change to mimic the documentation of "Numeric Data Types" in
> > Volume 1, Chapter 4 of "Intel=C2=AE 64 and IA-32 Architectures Software
> > Developer=E2=80=99s Manual" [1].
> >
> > [1] https://www.intel.com/content/www/us/en/developer/articles/technica=
l/intel-sdm.html
>
> I see where you got the inspiration from.
> It's a "software developer's manual". Not an ISA spec.
> But, say, we adopt this form and proceed to create all 500 pages of it.

Though the RISC-V ISA does include information about the integer
representation, your point is well taken.

As I said in a previous message, I am working on setting up the
skeleton for a strawman for a psABI. I will devote my efforts there
where I hope that they can be more useful.

Will

>
> SDM has this to say about pointers:
> "Pointers are addresses of locations in memory.
> In non-64-bit modes, the architecture defines two types of pointers: a
> near pointer and a far pointer. A near pointer is a 32-bit (or 16-bit)
> offset (also called an effective address) within a segment. Near
> pointers are used
> for all memory references in a flat memory model or for references in
> a segmented model where the identity of the segment being accessed is
> implied."
>
> BPF runs on 32-bit and 64-bit CPUs, so if we document signed vs unsigned
> integers we'd have to say a few words about pointers, bitfields and strin=
gs
> (just like Intel SDM). Pointers in BPF are clearly lacking docs.
>
> Beyond Vol 1, Chapter 4 there are plenty of other chapters.
> Should we have an equivalent for all of them?
> I think it would be great to have something for all that,
> but dropping a patch or two won't get us there.
> It needs to be a full time commitment with SOW, roadmap, etc.
> I doubt the kernel and/or IETF process can accommodate that.
>
> Saying it differently. What is missing in instruction-set.rst
> from making an IETF standard out of it?
> Does it need a signed vs unsigned SDM-like paragraph?
>
> Let's focus on converting instruction-set.rst into a standard
> as fast as possible and tackle all nice-to-have later.

