Return-Path: <bpf+bounces-1769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F6721476
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 05:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686551C20AA1
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 03:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357581C26;
	Sun,  4 Jun 2023 03:24:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2117F6
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 03:24:07 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89999CF
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 20:24:06 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6261616efd2so29679296d6.2
        for <bpf@vger.kernel.org>; Sat, 03 Jun 2023 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685849045; x=1688441045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0/uS12Zx3KeqDK/i7OIHJZfyQUFxBhPWZoDaCJ4TDc=;
        b=rasfcT/zewK2Vy93C2R9npRlcFyDB39XgrZ9k7dfgsY5qvFt67BpLlzvwwWht7mqc+
         VRgFBfCBwePGWEUsI9KKAVG1tn5c1oKuZ9rSh1HJj9cO2wTLwv27WxTzSF27aHB5DbTh
         vKyeXfFKyg7jpK5dhfWSWt+3lfqxUyTHOrkRhNU3LtF4mZRB/QF9mnBA2XPvD4fSWjTL
         1Oun2t/eixC4BCWWmzurpJZh9ZOTu7Wk7fKiPe9BobexjWnb1XVbY9E2+2IhwLr1/iLR
         kiXRzLvML44uViQYyMJ5zmpDrHUq9U/7/WDf7mlwbvPIzqRzEw+fTzOyMrBUxTcjhgQT
         G3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685849045; x=1688441045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0/uS12Zx3KeqDK/i7OIHJZfyQUFxBhPWZoDaCJ4TDc=;
        b=T1jjFvvyRxTTCZGCvD+13UtAyRYDB+111fF+aVu7cPvbdpoMmMiepqXlO9VPLF1seW
         64pzKUfLc9njWj/NQHhzCYH74wRQJLc/mb50GTxe6FPc2vhRPfYItH1e8EIzQKZMVtZ5
         Rxd9O35XKdF5VyPlBmynqMLJ6oGBt3wC7aftO9PExLwX0WMp4HxKPE+KynmMUsoEt/Qo
         b2Nf0CWNmlIMqujlBzF5hlneXDVxl8v7WzHJ6i2576skrSC7Wj9WktqJZId+FaKY3YQe
         kgAcQQiXHg3l3BlxWqfjOb5VsPHByC1d1rYCBVg8oPvpzBOLoTjMf6GxMQpTaOjTQqzr
         HaGw==
X-Gm-Message-State: AC+VfDzOAYv7SlrtINM6xXcgtdGlaLknEdJB9bDXKmje3SoVgzb6Pfgp
	0LeaTIm8DtjPCa/HLWkPhWU9C813qblEgZWwe80=
X-Google-Smtp-Source: ACHHUZ6gpVThxpK3NxbY3ndxqiSs3fBlGgq4FdndA3dNn6J5W6Viu03izsRxFWY4OE+/EOXKF/KDI2lRCgLG4gbVIBc=
X-Received: by 2002:a05:6214:2427:b0:625:aa48:e62f with SMTP id
 gy7-20020a056214242700b00625aa48e62fmr3574026qvb.63.1685849045583; Sat, 03
 Jun 2023 20:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-7-laoar.shao@gmail.com>
 <20230602203845.iklpi4f6wgdfnbll@MacBook-Pro-8.local>
In-Reply-To: <20230602203845.iklpi4f6wgdfnbll@MacBook-Pro-8.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Jun 2023 11:23:29 +0800
Message-ID: <CALOAHbAwizrH6afP864EfSRNgo61eC0gFnpRaztafXRPcK=BNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/6] bpftool: Show probed function in perf_event
 link info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Sat, Jun 3, 2023 at 4:38=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 02, 2023 at 08:52:39AM +0000, Yafang Shao wrote:
> > Show the exposed perf_event link info in bpftool. The result as follows=
,
> >
> > $ bpftool link show
> > 1: perf_event  prog 5
> >         func kernel_clone  addr ffffffffb40bc310  offset 0
> >         bpf_cookie 0
> >         pids trace(9726)
> > $ bpftool link show -j
> > [{"id":1,"type":"perf_event","prog_id":5,"func":"kernel_clone","addr":1=
8446744072435254032,"offset":0,"bpf_cookie":0,"pids":[{"pid":9726,"comm":"t=
race"}]}]
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/link.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 3b00c07..045f59f 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -280,6 +280,12 @@ static int show_link_close_json(int fd, struct bpf=
_link_info *info)
> >                       kernel_syms_show(addrs, info->kprobe_multi.count,=
 0);
> >               jsonw_end_array(json_wtr);
> >               break;
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             jsonw_string_field(json_wtr, "func",
> > +                                u64_to_ptr(info->perf_event.name));
> > +             jsonw_uint_field(json_wtr, "addr", info->perf_event.addr)=
;
> > +             jsonw_uint_field(json_wtr, "offset", info->perf_event.off=
set);
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -416,7 +422,7 @@ void netfilter_dump_plain(const struct bpf_link_inf=
o *info)
> >  static int show_link_close_plain(int fd, struct bpf_link_info *info)
> >  {
> >       struct bpf_prog_info prog_info;
> > -     const char *prog_type_str;
> > +     const char *prog_type_str, *buf;
> >       int err;
> >
> >       show_link_header_plain(info);
> > @@ -472,6 +478,12 @@ static int show_link_close_plain(int fd, struct bp=
f_link_info *info)
> >               addrs =3D (const __u64 *)u64_to_ptr(info->kprobe_multi.ad=
drs);
> >               kernel_syms_show(addrs, cnt, indent);
> >               break;
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             buf =3D (const char *)u64_to_ptr(info->perf_event.name);
> > +             if (buf[0] !=3D '\0' || info->perf_event.addr)
> > +                     printf("\n\tfunc %s  addr %llx  offset %d  ", buf=
,
> > +                            info->perf_event.addr, info->perf_event.of=
fset);
>
> Let's print the name here as well?

Sure, I will use 'name' instead.

--=20
Regards
Yafang

