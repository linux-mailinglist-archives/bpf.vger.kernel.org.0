Return-Path: <bpf+bounces-3403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2173D183
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD62280BEB
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2C613D;
	Sun, 25 Jun 2023 14:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2020F4
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:35:23 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBA911A;
	Sun, 25 Jun 2023 07:35:20 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62ff6cf5af0so22819676d6.0;
        Sun, 25 Jun 2023 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703720; x=1690295720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHCMfXAZy9bokhuDNc8S62Wu+gwMZXzuj/u3s1Oev1U=;
        b=RLJT8LFgr+7TjLO7T625L/mSWYjkmrCp8uc6RMLUUth9clMJFmTIZAaxGGQExLScig
         VrW2AMWZ4Za1swgT2nM2taMhphxJoZDU0SVG/+2R3SkOHviXCAE+Qg3KYLCrzxhDyBaa
         Sa9K3XRCH8Ad97i3jXXTZSDifE2UC2ymwhaT+iYM9FUqzlVFDqBT+SVqwJENMoX6073o
         KBE5sVSXrALSPnK69og79ylUu8X9o3GPJ5qrAKMRsidFAPK6o6OM0eiRalrnjZBh4ULO
         fbs4/RnKhjtbNwKan9XYLj8CbLFdZd0yyw+njIdbaxeRdlsXXkGUdrrblOt/0kgaFPKD
         xxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703720; x=1690295720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHCMfXAZy9bokhuDNc8S62Wu+gwMZXzuj/u3s1Oev1U=;
        b=RFweXHepvOIdVbOhjf/i0iKo+nOP0QAeVw1fgqVlBzs/HxCnVy13eCsw+L8ffUIsQb
         ev8jh3loZaLYbv2NNVvUYpqiRmH31CSZQm9BTFv2+xJ6t5X9vkF0An/G4eyWfKoHGN3D
         9EzyjDOrvHYdvkKMTPUouBpzF+ce8a65yrs3EULDIUgbTtor4LLwr8XKa98+10LLVzMf
         9+kuSeEmgpK/A4qZvbEeJSzpBlQDtoRIfHSiJ4oQSxNdIikZ31EibHv8cawC7+m+4dsM
         Vz5xSZAfylZFBYC/P4DnfCJIagCeUVfGl5hn+C1xPLg8cLfaIZT/zrZGR2gtD7wXjEbq
         ajnw==
X-Gm-Message-State: AC+VfDwYSg8XEFo2I7U4FQDgDc4+RjckbPfrGeyBcM3r7GItPaE5/6Ak
	FXlNYOuh5Stw2/mN8NWwt3wPkUdKd2tntdGp00bybdDcK0M=
X-Google-Smtp-Source: ACHHUZ5S0bi3WMTq2ARJgfJnfPxMeDkxoOpHtYZ6UwzhNPJAeYpDubLp5nzo9A+SsYIgKif2olb1TxNU+EG54eqQlAI=
X-Received: by 2002:a05:6214:f2f:b0:62f:f348:78ff with SMTP id
 iw15-20020a0562140f2f00b0062ff34878ffmr36128371qvb.16.1687703719972; Sun, 25
 Jun 2023 07:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-2-laoar.shao@gmail.com>
 <CAEf4BzaYmAmkm9HL1BPoddPtq=A2caqPm0QR_yQn44GA7TZVVQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaYmAmkm9HL1BPoddPtq=A2caqPm0QR_yQn44GA7TZVVQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Jun 2023 22:34:43 +0800
Message-ID: <CALOAHbBrmRJfXTqv6W5G=S5A-k=es91KLym3drec2xkxpFMv8w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 5:45=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 23, 2023 at 7:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > With the addition of support for fill_link_info to the kprobe_multi lin=
k,
> > users will gain the ability to inspect it conveniently using the
> > `bpftool link show`. This enhancement provides valuable information to =
the
> > user, including the count of probed functions and their respective
> > addresses. It's important to note that if the kptr_restrict setting is =
not
> > permitted, the probed address will not be exposed, ensuring security.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  3 files changed, 38 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a7b5e91..23691ea 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6438,6 +6438,11 @@ struct bpf_link_info {
> >                         __s32 priority;
> >                         __u32 flags;
> >                 } netfilter;
> > +               struct {
> > +                       __aligned_u64 addrs; /* in/out: addresses buffe=
r ptr */
> > +                       __u32 count;
> > +                       __u32 flags;
> > +               } kprobe_multi;
> >         };
> >  } __attribute__((aligned(8)));
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 2bc41e6..2123197b 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2459,6 +2459,7 @@ struct bpf_kprobe_multi_link {
> >         u32 cnt;
> >         u32 mods_cnt;
> >         struct module **mods;
> > +       u32 flags;
> >  };
> >
> >  struct bpf_kprobe_multi_run_ctx {
> > @@ -2548,9 +2549,35 @@ static void bpf_kprobe_multi_link_dealloc(struct=
 bpf_link *link)
> >         kfree(kmulti_link);
> >  }
> >
> > +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link =
*link,
> > +                                               struct bpf_link_info *i=
nfo)
> > +{
> > +       u64 __user *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.addrs=
);
> > +       struct bpf_kprobe_multi_link *kmulti_link;
> > +       u32 ucount =3D info->kprobe_multi.count;
> > +
> > +       if (!uaddrs ^ !ucount)
> > +               return -EINVAL;
> > +
> > +       kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link=
, link);
> > +       info->kprobe_multi.count =3D kmulti_link->cnt;
> > +       info->kprobe_multi.flags =3D kmulti_link->flags;
> > +
> > +       if (!uaddrs)
> > +               return 0;
> > +       if (ucount < kmulti_link->cnt)
> > +               return -EINVAL;
>
> it would be probably sane behavior to copy ucount items and return -E2BIG

Agree.

>
> > +       if (!kallsyms_show_value(current_cred()))
> > +               return 0;
>
> at least we should zero out kmulti_link->cnt elements. Otherwise it's
> hard for user-space know whether returned data is garbage or not?

Agree. Should clear it.

>
>
> > +       if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u6=
4)))
>
> s/ucount/kmulti_link->cnt/ ?

Yes. Thanks for pointing it out.

--=20
Regards
Yafang

