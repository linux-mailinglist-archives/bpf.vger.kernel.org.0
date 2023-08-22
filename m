Return-Path: <bpf+bounces-8307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2E784C20
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8512C281170
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1734CDE;
	Tue, 22 Aug 2023 21:36:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD42018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:36:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97CCEC
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692740196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBQOgMQJRUbh9wxMdCk/gDJiess5vlOHWyyr/sOqAOQ=;
	b=MiV+QQwhrgRaBR3tZU1Nz7HRLcjm+sS1HZ7b7bkD4uI2kRnV2g71Z+58oRD1bpaN7Jlrdh
	wvCfs89kMXhljz/XgXKZ33/uPKlwDcfRM7JJwMLQVaWlKASRBZ11n3GFDhDchxL+NV+2Qp
	3r9vIn948gBEl+cur4Ti0i+ciM5uL60=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-RnWc1LknODG3j_Mta6KSoA-1; Tue, 22 Aug 2023 17:36:35 -0400
X-MC-Unique: RnWc1LknODG3j_Mta6KSoA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe4aaa6dacso5267170e87.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740192; x=1693344992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBQOgMQJRUbh9wxMdCk/gDJiess5vlOHWyyr/sOqAOQ=;
        b=l1lLeb3SNn6jNbKU3MDSTj5vzmF2rcfr+BT+I/NyFhJlQ/LavgytHrtyK4KvcZ+auZ
         yA/couGqjKE+yJQ7t0DMBk+QJE7DpsPPYdJnwBEMIs0PjAhsmSgWx264ZxtM0AMmGxfR
         Tn7Y4pyRsLViU+vnGgsnPfze+LMlQQWAHyvYZk0qDuNQtiOmZb/VdWt1goyDMe9ZlI2Z
         CDYn7Y6Yzpc5pskl79XEZqTasvZf2kKv0fwBN4Y+ONthjGYKODawEdg7Is/xwHU0ieWe
         oAWFD9vCqs47ieJ6hiMhtmxG2kZWUvcIer2K0FIQKCU5XahI+6IyDea5VQLth4Lqy23R
         rocA==
X-Gm-Message-State: AOJu0YzPOuo7HI5lQ3z/a9o+I3Zo2yd+z45p4aV4PypWw6tFNdJAEIvW
	O1nNtWP11C+Pmbp5gpaG6xGVD0EB3ONp1thmQA3JFH0fwvFd7ozoi27koXW5VjaY5rIi6n8j58F
	+VhS62obKiOu/ZAIQnfxIVsfFYReK
X-Received: by 2002:a05:6512:33c1:b0:4f8:4512:c846 with SMTP id d1-20020a05651233c100b004f84512c846mr9307246lfg.49.1692740192229;
        Tue, 22 Aug 2023 14:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKm2GBxDVov1JaqkcKK8hb+vMJnaCM7rzDbVkGmJZmxaKGyfikCiUZjMDnWq5P6ApdJCEktBHclzVh3N/ERMw=
X-Received: by 2002:a05:6512:33c1:b0:4f8:4512:c846 with SMTP id
 d1-20020a05651233c100b004f84512c846mr9307220lfg.49.1692740191838; Tue, 22 Aug
 2023 14:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
 <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com> <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
In-Reply-To: <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 22 Aug 2023 23:36:20 +0200
Message-ID: <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To: Justin Stitt <justinstitt@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 11:26=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
> On Tue, Aug 22, 2023 at 2:15=E2=80=AFPM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 11:06=E2=80=AFPM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@go=
ogle.com> wrote:
> > > >
> > > [...]
> > > > > > > Here's the invocation I am running to build kselftest:
> > > > > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=
=3D1 ARCH=3Dx86_64
> > > > > > > -j128 V=3D1 -C tools/testing/selftests`
> > > > >
> > > > > I think I fixed the same issue in the script I am running to laun=
ch
> > > > > those tests in a VM. This was in commit
> > > > > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series)=
.
> > > > >
> > > > > And in the commit log, I wrote:
> > > > > ```
> > > > > According to commit 01d6c48a828b ("Documentation: kselftest:
> > > > > "make headers" is a prerequisite"), running the kselftests requir=
es
> > > > > to run "make headers" first.
> > > > > ```
> > > > >
> > > > > So my assumption is that you also need to run "make headers" with=
 the
> > > > > proper flags before compiling the selftests themselves (I might b=
e
> > > > > wrong but that's how I read the commit).
> > > >
> > > > In my original email I pasted the invocation I used which includes =
the
> > > > headers target. What are the "proper flags" in this case?
> > > >
> > >
> > > "make LLVM=3D1 ARCH=3Dx86_64 headers" no?
> > >
> > > But now I'm starting to wonder if that was not the intent of your
> > > combined "make mrproper headers". I honestly never tried to combine
> > > the 2. It's worth a try to split them I would say.
> >
> > Apologies, I just tested it, and it works (combining the 2).
> >
> > Which kernel are you trying to test?
> > I tested your 2 commands on v6.5-rc7 and it just works.
>
> I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
>
> I ran these exact commands:
> |    $ make mrproper
> |    $ make LLVM=3D1 ARCH=3Dx86_64 headers
> |    $ make LLVM=3D1 ARCH=3Dx86_64 -j128 -C tools/testing/selftests
> TARGETS=3Dhid &> out
>
> and here's the contents of `out` (still warnings/errors):
> https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59c6d
>
> I have a feeling I'm doing something fundamentally incorrectly. Any ideas=
?

Sigh... there is a high chance my Makefile is not correct and uses the
installed headers (I was running the exact same commands, but on a
v6.4-rc7+ kernel).

But sorry, it will have to wait for tomorrow if you want me to have a
look at it. It's 11:35 PM here, and I need to go to bed

Cheers,
Benjamin

>
> To be clear, I can build the Kernel itself just fine across many
> configs and architectures. I have, at the very least, the dependencies
> required to accomplish that.
>
> >
> > FTR:
> > $> git checkout v6.5-rc7
> > $> make LLVM=3D1 ARCH=3Dx86_64 mrproper headers
> > $> make LLVM=3D1 ARCH=3Dx86_64 -j8 -C tools/testing/selftests TARGETS=
=3Dhid
> >
> > ->   BINARY   hid_bpf
> >
> > Cheers,
> > Benjamin
> >
>


