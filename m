Return-Path: <bpf+bounces-6120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E77660F5
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F7D282560
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8419B15C1;
	Fri, 28 Jul 2023 01:06:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCD7C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:06:00 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA1B113
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:05:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso24709481fa.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690506356; x=1691111156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRvF7S6BCKQOHpa/hnG8yDSBjnyYzzktXP0BSYr1PV4=;
        b=eCnXOAzpwp4vq7NmQJ5aKaCKwOGzi6EApZnV9f7A86ZKFNq40vhQgT/66eiKnFv22+
         HZlGeUvJ6/Mw1vTJUqsUlBkLjKorQRdWWFmzkmopxFxQice31QEvq+QaBJX48PRzG6PG
         Zb7m9KgvWP/g+TaS78Conpa9t0BHj+H9/EdR4LKxpQoAxHn/2q8XWwiZItD6m/TegOwe
         gJvie7dbISxrnniLEXMAMN2t8fEbeHjRbbdKniiHTdLipPyTS3r8uawkg19h+8drz/cJ
         KPzcJLlGMNf2yO42CV28ZvassA6jtDc2Ct68wuW7KRwbF2bBcVMJGi4DbV5v/1glzu3N
         dJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690506356; x=1691111156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRvF7S6BCKQOHpa/hnG8yDSBjnyYzzktXP0BSYr1PV4=;
        b=ZPrkIx+hybC5Qp+P3aQi6vwM6qPjUDr+Aofdul3tZOfrmAryFReBX63BVj1WNFoLSZ
         ogZ9ucPyV2p8ADOKntU1uXDoQsTZ2+aHZXoc4KEBLB4kUDwyTe09fTS3BvfzoyODne6f
         gAFxZ7EgG6QSQUOCw8Q8NfwGNHb95vQ786kXVu7qxvuwi/BOUj3NCskm9EJmeF1JCf9B
         gRT5GluONdjnC5E9jSGb4DYmyYlU0Vc2NWjaxLdjhvYH4s1hBebalX9R9Dawly9oCSvb
         eNNDD9QIP7cS1FM/YAp8LK5otY1n4IDs15PWeD3pjO1OlhOT7KhgqxkIDop6FYQoRWUY
         qD5A==
X-Gm-Message-State: ABy/qLbv4A/SZeGK6n0Fot2wVxwVzy9YX9HqSiROZtr22JkFGxArTRQr
	Cax93vN5klVzK8siJkgjC+awfAfrlB2U9yCfqmI=
X-Google-Smtp-Source: APBJJlFpsa9S+MbwDuUpA001xWkpqg8vP9isN2mtCBJKVJix7GUmVZtCItBEoyaul1kXK9WPf7t8cs95jF+g0y69LkE=
X-Received: by 2002:a2e:9b8b:0:b0:2b7:117:e54 with SMTP id z11-20020a2e9b8b000000b002b701170e54mr579538lji.4.1690506355615;
 Thu, 27 Jul 2023 18:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com> <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
In-Reply-To: <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 18:05:44 -0700
Message-ID: <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
>
> On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonbladd@gmail.co=
m> wrote:
> >
> > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@microsof=
t.com> wrote:
> > > >
> > > > I am forwarding the email below (after converting HTML to plain tex=
t)
> > > > to the mailto:bpf@vger.kernel.org list so replies can go to both li=
sts.
> > > >
> > > > Please use this one for any replies.
> > > >
> > > > Thanks,
> > > > Dave
> > > >
> > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > To: bpf@ietf.org
> > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > >
> > > > > Dear BPF wg,
> > > > >
> > > > > I took a look at the draft and think it has some issues, unsurpri=
singly at this stage. One is
> > > > > the specification seems to use an underspecified C pseudo code fo=
r operations vs
> > > > > defining them mathematically.
> > >
> > > Hi Watson,
> > >
> > > This is not "underspecified C" pseudo code.
> > > This is assembly syntax parsed and emitted by GCC, LLVM, gas, Linux K=
ernel, etc.
> >
> > I don't see a reference to any description of that in section 4.1.
> > It's possible I've overlooked this, and if people think this style of
> > definition is good enough that works for me. But I found table 4
> > pretty scanty on what exactly happens.
>
> Hello! Based on Watson's post, I have done some research and would
> potentially like to offer a path forward. There are several different
> ways that ISAs specify the semantics of their operations:
>
> 1. Intel has a section in their manual that describes the pseudocode
> they use to specify their ISA: Section 3.1.1.9 of The Intel=C2=AE 64 and
> IA-32 Architectures Software Developer=E2=80=99s Manual at
> https://cdrdv2.intel.com/v1/dl/getContent/671199
> 2. ARM has an equivalent for their variety of pseudocode: Chapter J1
> of Arm Architecture Reference Manual for A-profile architecture at
> https://developer.arm.com/documentation/ddi0487/latest/
> 3. Sail "is a language for describing the instruction-set architecture
> (ISA) semantics of processors."
> (https://www.cl.cam.ac.uk/~pes20/sail/)
>
> Given the commercial nature of (1) and (2), perhaps Sail is a way to
> proceed. If people are interested, I would be happy to lead an effort
> to encode the eBPF ISA semantics in Sail (or find someone who already
> has) and incorporate them in the draft.

imo Sail is too researchy to have practical use.
Looking at arm64 or x86 Sail description I really don't see how
it would map to an IETF standard.
It's done in a "sail" language that people need to learn first to be
able to read it.
Say we had bpf.sail somewhere on github. What value does it bring to
BPF ISA standard? I don't see an immediate benefit to standardization.
There could be other use cases, no doubt, but standardization is our goal.

As far as 1 and 2. Intel and Arm use their own pseudocode, so they had
to add a paragraph to describe it. We are using C to describe BPF ISA
semantics. I don't think we need to explain C in the BPF ISA doc.
The only exception is "s>=3D", but it is explained in the doc already.

