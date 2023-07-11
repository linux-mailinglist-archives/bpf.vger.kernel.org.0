Return-Path: <bpf+bounces-4723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE674E60A
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 06:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E0428115C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C31523A;
	Tue, 11 Jul 2023 04:47:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234372104
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 04:47:03 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4DD90
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:47:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b5c2433134so65623861fa.0
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689050820; x=1691642820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WtPqk+6efPvU9PidMZCkDRjbOAk0RVLnoir7RR0hoE=;
        b=ZLDb61qbQBSAy/NOC/5lD+sZ21YgRIb/og1ZzwDTexzY0O1zxAjDC0omOkVzfqNTbG
         c3vmW5aeC7KkAQ4cY/gzSrf87sG5hr68gywOn9jRKrWo/ZPd8ZY2sBjFxcg5wxdk/9eS
         t7TRlKBk1Xr4pfoK1+zvMFq/r3CVSUrl0UiGrQjtWvKeuFbGQWtbXKba64KVS4LcyR36
         AYT0lwAKLLAUv+Bi09ofxfKc5tiEnkbVtiod9tfcqm4NYTYmZHeSHabl3XRv7Vwz+awf
         ba25B+LtfPh6K+kOGiNwUkZ8q5QQf0h9aDqThClU1SHONa4vGOtmW8oNgslOJHXy1HL4
         GUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050820; x=1691642820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WtPqk+6efPvU9PidMZCkDRjbOAk0RVLnoir7RR0hoE=;
        b=B1VgMIMjzezsthLWxY+uPS+1Ea0bE5INfwh/VwjLStWEttAkiQMrxqAMUTJAPA1Ypx
         Rq2BorAmXJL2jVEK9i+l0n6D1OPG6537fG5pvepbvD8p03oXrgorS3eWiv4gSZqa6tme
         VRSn/zU/pnwQvxLmKmXc5iGVB4fyXBObq7W9nm4VX9LxKEtkeLp6tDRxaMo7hes8iljG
         zAn+muI/4xjtN/4Gc57uV0KZ7R/axSsjfNANHUIs16pfPrChwGxxLoM2DWUlymVmB5ga
         enoj2AqMJmGSU2mAah0y8NgC9z/F+YaYoeNy/H3TlNLHvScXRf909BOngfgwAkfCHk/u
         Mf9g==
X-Gm-Message-State: ABy/qLZr2yNAmT496/9geV1FXjwja02T3jjIxzNNaQCw69yiBf6G9b21
	OnpCZj9w+IKJqyk37hLvlOxkrj5Zhf1LLIDq4ACbz3Zrs5c=
X-Google-Smtp-Source: APBJJlFTgw2KDx4ae2+/8cEbMybK19AfRSMlbeWfU9BNuPOKAOhDBJLsk4sTbjqWWAmJObD/5NXYL7hvY3fbaaggSCE=
X-Received: by 2002:a2e:3c04:0:b0:2b6:98c2:635f with SMTP id
 j4-20020a2e3c04000000b002b698c2635fmr5990631lja.11.1689050819712; Mon, 10 Jul
 2023 21:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr> <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com> <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
In-Reply-To: <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 21:46:48 -0700
Message-ID: <CAADnVQJR7YFcjqgiGABX-_jJEK7rQTrO8cGFJiZ16oOtpbmVNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf, docs: Specify twos complement as format for
 signed integers
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 8:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> On Mon, Jul 10, 2023 at 11:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> > >
> > > In the documentation of the eBPF ISA it is unspecified how integers a=
re
> > > represented. Specify that twos complement is used.
> > >
> > > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > > ---
> > >  Documentation/bpf/instruction-set.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bp=
f/instruction-set.rst
> > > index 751e657973f0..63dfcba5eb9a 100644
> > > --- a/Documentation/bpf/instruction-set.rst
> > > +++ b/Documentation/bpf/instruction-set.rst
> > > @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src &=
 mask)
> > >  BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_=
 below)
> > >  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > +eBPF supports 32- and 64-bit signed and unsigned integers. It does
> > > +not support floating-point data types. All signed integers are repre=
sented in
> > > +twos-complement format where the sign bit is stored in the most-sign=
ificant
> > > +bit.
> >
> > Could you point to another ISA document (like x86, arm, ...) that
> > talks about signed and unsigned integers?
>
> Thank you for the reply. I hope that this change is useful. I proposed
> this change to mimic the documentation of "Numeric Data Types" in
> Volume 1, Chapter 4 of "Intel=C2=AE 64 and IA-32 Architectures Software
> Developer=E2=80=99s Manual" [1].
>
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/=
intel-sdm.html

I see where you got the inspiration from.
It's a "software developer's manual". Not an ISA spec.
But, say, we adopt this form and proceed to create all 500 pages of it.

SDM has this to say about pointers:
"Pointers are addresses of locations in memory.
In non-64-bit modes, the architecture defines two types of pointers: a
near pointer and a far pointer. A near pointer is a 32-bit (or 16-bit)
offset (also called an effective address) within a segment. Near
pointers are used
for all memory references in a flat memory model or for references in
a segmented model where the identity of the segment being accessed is
implied."

BPF runs on 32-bit and 64-bit CPUs, so if we document signed vs unsigned
integers we'd have to say a few words about pointers, bitfields and strings
(just like Intel SDM). Pointers in BPF are clearly lacking docs.

Beyond Vol 1, Chapter 4 there are plenty of other chapters.
Should we have an equivalent for all of them?
I think it would be great to have something for all that,
but dropping a patch or two won't get us there.
It needs to be a full time commitment with SOW, roadmap, etc.
I doubt the kernel and/or IETF process can accommodate that.

Saying it differently. What is missing in instruction-set.rst
from making an IETF standard out of it?
Does it need a signed vs unsigned SDM-like paragraph?

Let's focus on converting instruction-set.rst into a standard
as fast as possible and tackle all nice-to-have later.

