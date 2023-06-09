Return-Path: <bpf+bounces-2246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A76C72A219
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D51C21137
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4372106F;
	Fri,  9 Jun 2023 18:25:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9020991
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 18:25:20 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACEF35A9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 11:25:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so6633502a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686335117; x=1688927117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA7NWeOROD1fWYb6EdQbAXRnzupDoW3dmlZ4oSOSW1Y=;
        b=gx1aThOzvsBu7BWLc6VEf7J3H8iU/mPAO9ct59xy540uh8kGoJuCQwEC27c1uSqLKE
         7oVecYUwWtab32KADe1f6KeM9WsadjLE68OvshnbzizvENXoMyWTlCSVwyX9ApWcIZAb
         C5uqeGHMijq/IlLBgEY+G9Uu0dsPWNieUbp/H/eDI1AM9wANwotbeWlHDO5UwM8xTpDi
         mRAoh8UVEpok+s5L85aW+iwDQWdlld9/V9ojZj4Tvua/OTDxAVMpFjX5lAr/CSB//5hU
         aoB+QI0fyKYhve5XL+8cnSiCO/DT+jT5xIIdD0Tk9fTihpBjBN9gnj2PZkgTMFwhcgoS
         bCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335117; x=1688927117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA7NWeOROD1fWYb6EdQbAXRnzupDoW3dmlZ4oSOSW1Y=;
        b=YZvyz0lz20W1hsu6Z05VO6rUBtZEGkPLTIRhmRzCUvG7YwVajUqQraSdkZ+7R17AWA
         bl5X+PMp0GGcwizZRSI8Amm4RGZ0nJstvkMbjTHKeS9M3h1cB4/dwyAbeVB+Y04UjbAb
         NIySngRLaSHmlod+SG9Ii/oQ0q3lw1VSf0RPoKJnztgfBpONxQkUc2RV38f5t2JVqAJI
         8/1ud4HDY+7+XcHyuuyWZf5aL/5EZzElYS+PTN8H2kbKuRuOL9Akdyens1kp1TuWYwiX
         XSdbOndhnoP0TLDrx8PPG1XqvdpnXFTM2kouiOlbky2MvIANsNfKUcliQmageRv3oVLW
         8wng==
X-Gm-Message-State: AC+VfDwjvLZ3ult0Cd1pJS3fjqDeMy3hzoOq+yH9OECZEiHYxRgsLmwK
	zysJdd41mlB9p71hxlcfVG1gHYfkIe5mm1QrxRva5HL8rA0=
X-Google-Smtp-Source: ACHHUZ63iV9R8aJ7LFCsK2mctzY3WRYR2gqXgN914B/OV3UkiHVntHVlWAN545bmSa95COB8DCYdwqbvhDBe5jPz08o=
X-Received: by 2002:a17:907:2d29:b0:969:e993:6ff0 with SMTP id
 gs41-20020a1709072d2900b00969e9936ff0mr3170798ejc.25.1686335116919; Fri, 09
 Jun 2023 11:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-2-laoar.shao@gmail.com>
 <CAEf4BzY8Vi4Y6kf7hOmhWQkKOV=R7tBzb4dgCuicni3bBFWb9A@mail.gmail.com> <CALOAHbAfiJ7BWzxBWD3vD9vaAkUa8o_95r8x-A_o5jjAyBFpqA@mail.gmail.com>
In-Reply-To: <CALOAHbAfiJ7BWzxBWD3vD9vaAkUa8o_95r8x-A_o5jjAyBFpqA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 11:25:04 -0700
Message-ID: <CAEf4BzaNnJ4AWTnC4Fpf557zMMYK42ffxYCtcPewaXj4OLQFNg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 2:14=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Fri, Jun 9, 2023 at 7:05=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > With the addition of support for fill_link_info to the kprobe_multi l=
ink,
> > > users will gain the ability to inspect it conveniently using the
> > > `bpftool link show` command. This enhancement provides valuable infor=
mation
> > > to the user, including the count of probed functions and their respec=
tive
> > > addresses. It's important to note that if the kptr_restrict setting i=
s set
> > > to 2, the probed addresses will not be exposed, ensuring security.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  include/uapi/linux/bpf.h       |  5 +++++
> > >  kernel/trace/bpf_trace.c       | 30 ++++++++++++++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h |  5 +++++
> > >  3 files changed, 40 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index a7b5e91..d99cc16 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6438,6 +6438,11 @@ struct bpf_link_info {
> > >                         __s32 priority;
> > >                         __u32 flags;
> > >                 } netfilter;
> > > +               struct {
> > > +                       __aligned_u64 addrs; /* in/out: addresses buf=
fer ptr */
> > > +                       __u32 count;
> > > +                       __u8  retprobe;
> >
> > from kernel API side it's probably better to just expose flags?
>
> Agreed. The flags will be extensible.
>
> > retprobe is determined by BPF_F_KPROBE_MULTI_RETURN flag
>
> Should we print 'flags' in `bpftool link show` directly? As we print
> it in `bpftool map show`.

specifically for kprobe vs kretprobe (and similarly uprobe vs
uretprobe), if bpftool can make it human-readable it would be best. We
can also additionally print flags, but I don't know how useful it
would be.

>
> >
> > > +               } kprobe_multi;
> > >         };
> > >  } __attribute__((aligned(8)));
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 2bc41e6..738efcf 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2548,9 +2548,39 @@ static void bpf_kprobe_multi_link_dealloc(stru=
ct bpf_link *link)
> > >         kfree(kmulti_link);
> > >  }
> > >
> > > +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_lin=
k *link,
> > > +                                               struct bpf_link_info =
*info)
> > > +{
> > > +       u64 __user *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.add=
rs);
> > > +       struct bpf_kprobe_multi_link *kmulti_link;
> > > +       u32 ucount =3D info->kprobe_multi.count;
> > > +
> > > +       if (!uaddrs ^ !ucount)
> > > +               return -EINVAL;
> > > +
> > > +       kmulti_link =3D container_of(link, struct bpf_kprobe_multi_li=
nk, link);
> > > +       if (!uaddrs) {
> > > +               info->kprobe_multi.count =3D kmulti_link->cnt;
> > > +               return 0;
> > > +       }
> > > +
> > > +       if (!ucount)
> > > +               return 0;
> > > +       if (ucount !=3D kmulti_link->cnt)
> > > +               return -EINVAL;
> >
> > should this just check that kmulti_link->cnt is <=3D ucount?...
>
> Agreed.
>
> >
> > > +       info->kprobe_multi.retprobe =3D kmulti_link->fp.exit_handler =
?
> > > +                                     true : false;
> > > +       if (kptr_restrict =3D=3D 2)
> > > +               return 0;
> >
> > use kallsyms_show_value() instead of hard-coding this?
>
> Good point. Will use it.
>
> --
> Regards
> Yafang

