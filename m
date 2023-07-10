Return-Path: <bpf+bounces-4615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03674DC34
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 19:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C78D28132F
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167D13AFE;
	Mon, 10 Jul 2023 17:21:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7E107B4
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 17:21:27 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BC01719
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:21:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c475c6da6so1583171a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689009664; x=1691601664;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmU2+5hRWoL+pZqKJ05G+ZLf8jgBoRxUhLoRim7iXdw=;
        b=XjWiHEqfCseEhn60v58akWR+Kii8fw3IX+mzVKNFqTiWNWIYad5u2m6pGwvg9spU3G
         cjRxM+zHzYzkwHW6TpyOlXuRwaOk/G8QzYvIvPx8P6xPkDp454Gk72qwGmtGXL/VaWla
         Q0gLvoCdBGoqyNi4IBJCa/vixwkY7XJWvnXyNj4MvxwHYPJGQ4kWkLckRsYYamjy02Ow
         yOEnUknN0Hk4kVl7+lAFs/YFZ6jMp9BoTee0ZGO3QxxmYJiE1s6yFeqZEjXbHjHISBCN
         lbkYMXuEG4lqiGLjoeTYwOe0+JmCkQ9CreA9CafCg0a7w/FdLusJTGW2rXro0A73QqTB
         QKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009664; x=1691601664;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DmU2+5hRWoL+pZqKJ05G+ZLf8jgBoRxUhLoRim7iXdw=;
        b=E4+/0Zs1zZ1UKLJ9fCBPgkJiWdwWjfJbuiDWuRn9JHVMu0lCEx6uUPcD2pvaM08PBE
         qcAYf8PnsgG03XdHxKgRUashTw9NDomRuAX/TK8f3rvID+pVBAsFQ+rOsVsGjRNbX4yP
         /4wtkKntwRosykH6J/Ym1S2PEgIPotryr0tHRgH76NhTYX/86Lwq+gPOevqRy+9jCT14
         p+GoJdYQ4YwC0nOdYacCsps09JMLhSL6tmJM65kSO2CGMnIkI1T8AFeHMqtIm4PqjJuS
         Plx/P6uVbDZ9xIktoZytoKY9Ay4bQb6MkhGArNZ0cWYRhpPqrlN/jG5mqM3zfr71qaFQ
         Y3bw==
X-Gm-Message-State: ABy/qLYi7/DWStioFcSwS4SfRkBPuG8UZk6kZvckJSb3Yfh65snvkVE/
	8jaBcpKkOmcnWgWSgFc2ukWCvhQ=
X-Google-Smtp-Source: APBJJlESkUSQK49CxEg85CDws6p3+OE/VlXKu5fJXfbxk71EWAjEUZqTOiuIpSgS9EKNVNwvsGND5XQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:9316:0:b0:55a:e71b:45b9 with SMTP id
 b22-20020a639316000000b0055ae71b45b9mr8945120pge.2.1689009664229; Mon, 10 Jul
 2023 10:21:04 -0700 (PDT)
Date: Mon, 10 Jul 2023 10:21:02 -0700
In-Reply-To: <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com> <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
 <ZKhEEJfzCyYI7BfH@google.com> <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com>
 <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
Message-ID: <ZKw9/jIZs73jT190@google.com>
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
From: Stanislav Fomichev <sdf@google.com>
To: Khalid Masum <khalid.masum.92@gmail.com>
Cc: Anh Tuan Phan <tuananhlfc@gmail.com>, daniel@iogearbox.net, martin.lau@linux.dev, 
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/09, Khalid Masum wrote:
> Hi,
>=20
> On Sun, Jul 9, 2023 at 8:38=E2=80=AFPM Anh Tuan Phan <tuananhlfc@gmail.co=
m> wrote:
> >
> > Hi Stanislav,
> >
> > I have updated the Documentation according to your suggestion. Please
> > see it in the below patch. Thanks!
> >
> > On 7/7/23 23:57, Stanislav Fomichev wrote:
> > > On 07/07, Anh Tuan Phan wrote:
> > >>
> > >>
> > >> On 7/7/23 01:16, Stanislav Fomichev wrote:
> > >>> On 07/06, Anh Tuan Phan wrote:
> > >>>> Update the Documentation to mention that some samples require paho=
le
> > >>>> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=3Dy
> > >>>>
> > >>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> > >>>> ---
> > >>>>  samples/bpf/README.rst | 7 +++++++
> > >>>>  1 file changed, 7 insertions(+)
> > >>>>
> > >>>> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> > >>>> index 57f93edd1957..631592b83d60 100644
> > >>>> --- a/samples/bpf/README.rst
> > >>>> +++ b/samples/bpf/README.rst
> > >>>> @@ -14,6 +14,9 @@ Compiling requires having installed:
> > >>>>  Note that LLVM's tool 'llc' must support target 'bpf', list versi=
on
> > >>>>  and supported targets with command: ``llc --version``
> > >>>>
> > >>>> +Some samples require pahole version 1.16 as a dependency. See
> > >>>> +https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
> > >>>> +
> > >>>
> > >>> Any reason no to add pahole 1.16 to this section above?
> > >>>> Compiling requires having installed:
> > >>>  * clang >=3D version 3.4.0
> > >>>  * llvm >=3D version 3.7.1
> > >>>  * pahole >=3D version 1.16
> > >>>
> > >>> Although clang 3.4 probably won't get you anywhere these days. The
> > >>> whole README seems a bit outdated :-)
> > >>>
> > >>
> > >> Put pahole requirement as your idea is better, thanks for suggestion=
.
> > >> Will update it and clang version as well. For clang version, I think=
 I
> > >> can update min version as 11.0.0 (reference from
> > >> https://www.kernel.org/doc/html/next/process/changes.html). Do you s=
ee
> > >> any other potential outdated things in this document? I follow the a=
bove
> > >> steps and it help me compile the sample code successfully.
> > >
> > > Maybe we can reference that doc instead here? Otherwise that copy-pas=
ted
> > > 11.0.0 will also get old. Just mention here that we need
> > > clang/llvm/pahole to compile the samples and for specific versions
> > > put a link to process/changes.rst
> > >
> > >>>>  Clean and configuration
> > >>>>  -----------------------
> > >>>>
> > >>>> @@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::
> > >>>>
> > >>>>   make defconfig
> > >>>>
> > >>>> +Some samples require support for BPF Type Format (BTF). To enable=
 it,
> > >>>> open the
> > >>>> +generated config file, or use menuconfig (by "make menuconfig") t=
o
> > >>>> enable the
> > >>>> +following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
> > >>>> +
> > >>>
> > >>> This is usually enabled by default, so why special case it here?
> > >>> Maybe, if you want some hints about the config, we should add
> > >>> a reference to tools/testing/selftests/bpf/config ?
> > >>>
> > >>
> > >> The config CONFIG_DEBUG_INFO_BTF is disabled for some distros at lea=
st
> > >> for mine. I ran "make defconfig" and it's not enabled by default so =
I
> > >> think it worth to mention it here to help novice get started. I'll
> > >> update it to reference to tools/testing/selftests/bpf/config .
> > >>
> > >>>>  Kernel headers
> > >>>>  --------------
> > >>>>
> > >>>> --
> > >>>> 2.34.1
> >
> > Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> > ---
> >
> > Change from the original patch:
> >
> > - Move pahole to the list installed requirements
> > - Remove minimal version and link the related doc
> > - Add a reference of kernel configuration
> >
> >  samples/bpf/README.rst | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> > index 57f93edd1957..e18500753ba5 100644
> > --- a/samples/bpf/README.rst
> > +++ b/samples/bpf/README.rst
> > @@ -8,9 +8,12 @@ Build dependencies
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  Compiling requires having installed:
> > - * clang >=3D version 3.4.0
> > - * llvm >=3D version 3.7.1
> > + * clang
> > + * llvm
> > + * pahole
> >
> > +The minimal version of the above software is referenced in
> > +https://www.kernel.org/doc/html/next/process/changes.html.
>=20
> I think it is better to not use docs from linux-next as it keeps changing
> too frequently. How about using the latest documentation's link instead? =
:)
>=20
> https://www.kernel.org/doc/html/latest/process/changes.html

+1

We should put Documentation/process/changes.rst here (or whatever
the correct path). The tooling that generates html from rst will
put a proper link.

