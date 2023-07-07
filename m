Return-Path: <bpf+bounces-4367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818FD74A83A
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381CC281575
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8810EE;
	Fri,  7 Jul 2023 00:48:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDE7F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 00:48:53 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17920E6E
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:48:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so19763281fa.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688690929; x=1691282929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55CZ8jW030gmBYq7IB4tSq/GczPU4PIduyi/2awZWcU=;
        b=T1xhbehZIrNTiWCUywcSBeW6j5JSfWTqadjZycH0fER0n4egwXUAzu7APBxH6vm8Mr
         ZgK1ag5LMezA1/vosDm0vWRCfSUazI0yACEuctV8+SISk1sk7whhaC4JRFN9MsHoupFc
         mP9AVkk/KLTRyfMNk6AqJt/G4zi+/X9m8DcVBYHRkpsvWvInGxPET5MlKojT/0oDliMl
         rZktgzrvtfd4xfwYaiMKogLPBwyJ7bBbBhpq1kPtIzT+oXhZChhtB6J1xNfqCyPikUQp
         hqpMArD0F3lRvGnIl1vyRr46BtWVQmtfArpmn5O7So/P/DVJPOz1L7E3aLwjaTuWRXT+
         x1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688690929; x=1691282929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55CZ8jW030gmBYq7IB4tSq/GczPU4PIduyi/2awZWcU=;
        b=bZgLLU4XnZGp3H6Vfw6t+McEdPtzwbMOW0y5CWiI2PMGf9ZAhouRg1/Z7AFzinIJY7
         b382Nvzal+/YJ9uHQ0hI/cSL/Led0oesepnWLB+LWuTScGDKKPa4hcZPGCiCK8iALdXP
         xzfiJ0tRnaSu0Sko212cMex4KtHThQiQwDyDbAYBvXxqc5YdgzpCpCuDnsfSghgmZpQ6
         PVMJPJm3Chn8SJFsfQDAHl2y1UMc+y+1czHRoiSYp6t4vApUrfggaMDipL87uY4UPv4x
         6pqGGYGIQ8zJubZsQB01M03JFx3ZWcWPTAHdO4oTDt4SzurrE0IWFMr6CbmgsfilNwN8
         M0oA==
X-Gm-Message-State: ABy/qLZFMQLfX8pV0xtKItlSRFe/pORp+K1+kfTkefv38J2iHQoy9rRJ
	UxIhixeo1YuP/ixNhB4i6AoQ9geFM/VPbYRSn04=
X-Google-Smtp-Source: APBJJlHGCEIjLuv9IRLGaUzuTY751nDylBVUY/SL7sxknpBJAIzYNbdW+kaNL9IousIKMc4LiczcyqBeZxRZE5jmTQ0=
X-Received: by 2002:a2e:8612:0:b0:2b6:a6a6:4a16 with SMTP id
 a18-20020a2e8612000000b002b6a6a64a16mr2430813lji.3.1688690929046; Thu, 06 Jul
 2023 17:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr> <20230706222020.268136-2-hawkinsw@obs.cr>
 <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com> <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com>
In-Reply-To: <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 17:48:37 -0700
Message-ID: <CAADnVQKdV2A+-+PWpgt7_tUF-0uj-6MSsTSAppQDH=7VeXKFrA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH 1/1] bpf, docs: Describe stack contents of function calls
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 5:46=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrote=
:
>
> On Thu, Jul 6, 2023 at 7:32=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jul 6, 2023 at 3:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> w=
rote:
> > >
> > > The execution of every function proceeds as if it has access to its o=
wn
> > > stack space.
> > >
> > > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > > ---
> > >  Documentation/bpf/instruction-set.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bp=
f/instruction-set.rst
> > > index 751e657973f0..717259767a41 100644
> > > --- a/Documentation/bpf/instruction-set.rst
> > > +++ b/Documentation/bpf/instruction-set.rst
> > > @@ -30,6 +30,11 @@ The eBPF calling convention is defined as:
> > >  R0 - R5 are scratch registers and eBPF programs needs to spill/fill =
them if
> > >  necessary across calls.
> > >
> > > +Every function invocation proceeds as if it has exclusive access to =
an
> > > +implementation-defined amount of stack space. R10 is a pointer to th=
e byte of
> > > +memory with the highest address in that stack space. The contents
> > > +of a function invocation's stack space do not persist between invoca=
tions.
> >
> > Such description belongs in a future psABI doc.
> > instruction-set.rst is not a place to describe how registers are used.
>
> Thank you for the feedback!
>
> How does your comment square with the immediately preceding
> description in the document that says:
>
> R10: read-only frame pointer to access stack
>
> (among the description of how other registers are used during function ca=
lls).

See
https://lore.kernel.org/bpf/CAADnVQ+gLnsOVj9s4zpAP6+U6nFHYm6GVZ1FteRac=3DZa=
JvpfDg@mail.gmail.com/

tldr: it's a mess.
We should remove 'Registers and calling convention' section from
instruction-set.rst

