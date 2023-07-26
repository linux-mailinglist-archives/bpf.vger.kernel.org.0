Return-Path: <bpf+bounces-5994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63B763F65
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 21:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0791B281EE0
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6204CE97;
	Wed, 26 Jul 2023 19:16:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B174CE84
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 19:16:22 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6E71FF0
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:16:20 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4475615e245so50798137.2
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690398979; x=1691003779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM0ukKexePxMNw1wW/WLU+P2Zc71N+iGNBjfGQCeoCk=;
        b=Bt4VN8O53f0KG+ZxAAB+hWBFMVXZi01E0yyoSRd2/SdgshfnugBS+zAjbbJb0jmMvc
         x62uJrnWRaZRgArfLTjSGX6xbOApAupL9UMIOmREW9tq4WuEL/oTm83ruLYnySW771m0
         NzM4QKDWGw5b+VVrsQcbSG0JWisv9SjjuvKxrGkPEz4cElxEXHy21h0SrW0BMRNcvi7I
         +IArYh0iJfkmLdrQSz5/DE/qdTztllbp5nYvhc5dDslHoi/s4Pa9kD0Ca4YKf/2gpWFo
         OwXBu6k2VbiUIdrt8BrovNc+1txeHGrsUW0o8Z6FHYWpkNvtI2c4jqNkLIN1WIqdyIJu
         se1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690398979; x=1691003779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM0ukKexePxMNw1wW/WLU+P2Zc71N+iGNBjfGQCeoCk=;
        b=h23SmFyhQd2R/+c2qJPKTK6mhDB2A0ZVfUQA904scDNv6UKGerXarRMd92df9/+QRH
         Ng137thBQaW2XIyR9hmQhVZsZ2LARjRR5cBeB/5hcQBlIdViWvfFqXoc9S0dOqA2ppNC
         lZvtclrXJyXK4vewySgBFvPYQxgeuajEVq8w4L2jb6xxVvDgLVseWmNAlvXPJTdKe3aj
         lsxE3oG9aGNREicW2lG//al8M+k5Lk3q7JazqK/T0AkqIaceYnL3899Jk1d2obAvGLV9
         D0vsfIlhxzjRT0ah2Pk97tJvtPuScxtIkHoRqirY9Z3Tp/a6LTO9T3yjHGfn48T0TZEb
         ZF3g==
X-Gm-Message-State: ABy/qLY3rGZz3gK1Sm2fID54zx/YXKqXa2LBkmSejIcdR+dLxTBoKzsv
	EJPDB2OjtARs5TUFfuEY7caztV4UCmR/l7bePAAfShYAGeBuG8ZehdE=
X-Google-Smtp-Source: APBJJlH038bb259dvNC1s2Kh0EZ2ksB/8UiE4ZmHMtZECcEAgle/dnoZe3klf/zzDDbN/4k4M1Lqx5jGP2l5HcooXg0=
X-Received: by 2002:a05:6102:84:b0:440:cbbf:cd72 with SMTP id
 t4-20020a056102008400b00440cbbfcd72mr69039vsp.4.1690398979395; Wed, 26 Jul
 2023 12:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com> <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
In-Reply-To: <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 26 Jul 2023 15:16:08 -0400
Message-ID: <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonbladd@gmail.com>=
 wrote:
>
> On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@microsoft.=
com> wrote:
> > >
> > > I am forwarding the email below (after converting HTML to plain text)
> > > to the mailto:bpf@vger.kernel.org list so replies can go to both list=
s.
> > >
> > > Please use this one for any replies.
> > >
> > > Thanks,
> > > Dave
> > >
> > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > To: bpf@ietf.org
> > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > >
> > > > Dear BPF wg,
> > > >
> > > > I took a look at the draft and think it has some issues, unsurprisi=
ngly at this stage. One is
> > > > the specification seems to use an underspecified C pseudo code for =
operations vs
> > > > defining them mathematically.
> >
> > Hi Watson,
> >
> > This is not "underspecified C" pseudo code.
> > This is assembly syntax parsed and emitted by GCC, LLVM, gas, Linux Ker=
nel, etc.
>
> I don't see a reference to any description of that in section 4.1.
> It's possible I've overlooked this, and if people think this style of
> definition is good enough that works for me. But I found table 4
> pretty scanty on what exactly happens.

Hello! Based on Watson's post, I have done some research and would
potentially like to offer a path forward. There are several different
ways that ISAs specify the semantics of their operations:

1. Intel has a section in their manual that describes the pseudocode
they use to specify their ISA: Section 3.1.1.9 of The Intel=C2=AE 64 and
IA-32 Architectures Software Developer=E2=80=99s Manual at
https://cdrdv2.intel.com/v1/dl/getContent/671199
2. ARM has an equivalent for their variety of pseudocode: Chapter J1
of Arm Architecture Reference Manual for A-profile architecture at
https://developer.arm.com/documentation/ddi0487/latest/
3. Sail "is a language for describing the instruction-set architecture
(ISA) semantics of processors."
(https://www.cl.cam.ac.uk/~pes20/sail/)

Given the commercial nature of (1) and (2), perhaps Sail is a way to
proceed. If people are interested, I would be happy to lead an effort
to encode the eBPF ISA semantics in Sail (or find someone who already
has) and incorporate them in the draft.

Sincerely,
Will

> >
> > > > The good news is I think this is very fixable although tedious.
> > > >
> > > > The other thornier issues are memory model etc. But the overall str=
ucture seems good
> > > > and the document overall makes sense.
> >
> > What do you mean by "memory model" ?
> > Do you see a reference to it ? Please be specific.
>
> No, and that's the problem. Section 5.2 talks about atomic operations.
> I'd expect that to be paired with a description of barriers so that
> these work, or a big warning about when you need to use them. For
> clarity I'm pretty unfamiliar with bpf as a technology, and it's
> possible that with more knowledge this would make sense. On looking
> back on that I don't even know if the memory space is flat, or
> segmented: can I access maps through a value set to dst+offset, or
> must I always used index? I'm just very confused.
>
> Sincerely,
> Watson
>
> --
> Astra mortemque praestare gradatim
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

