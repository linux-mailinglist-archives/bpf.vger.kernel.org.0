Return-Path: <bpf+bounces-55-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F26F7996
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 01:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB151C21568
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 23:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF45C15E;
	Thu,  4 May 2023 23:06:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23FC156
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 23:06:53 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6311209A
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 16:06:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ddb2093bso10153966b.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683241610; x=1685833610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jlwGKIxLENI90r9xpO2/15K4ktCczU0BLJCMHugthg=;
        b=CDTkiwHbA2xGOJlM6c1HXtCvbUztpk1uzk7gkpmjYWS98vTMZmr7MymeyWBAwviAA7
         GmXHDRtXOvzqM2+BEKSDOKUcn15K2iYpme8wXahzRjzGYJ3WAE++pVPJsd0dW6Lb2/ea
         NNszRl3lMy8a81nRXMV1sPyHgjESSsjKpQC3tOQYmBH6zGqYPT/gd0TPYaeXhk1K28OW
         reBKzz9zhIfQmyRycLNHLB4LCb/yfkEI+NPo2HeIBo8ir0pVHo9V9NCjxr0+cfGzqNQX
         h1I1yvOSkRVlp9WBLK7h/bjhFkJfDFL/cEMDmunevrN1P9Vy6zDVzEHwv46bmNTaYFH3
         yILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683241610; x=1685833610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jlwGKIxLENI90r9xpO2/15K4ktCczU0BLJCMHugthg=;
        b=ALVeHVayDk+K2H/Yu7h7MG4fogjT7npaTqeddqBwrBv0TzeL7pxJ1/MhhVkPcs09DI
         ZtL/wI22CVvqcKNJ2nnS0537rUA33KFKDOgfdNkCWR4GIyjOCS3l98Hg753Cll78tshH
         fiWnPMc2rzmXCioRibq4NaI2qpAlejt62+7IagvZEjuNBJhECnfQpqQHwEUk33dzr26/
         8Zz5iJHoaWA5wsHpAahL3xwRxqTusG6Z4n59dgECtZDrNYWsnFSSzAOmgybiMKlEKz2o
         7jiXv4CYW0teBq18GJ0u/aPY/qojez/fsHNm/iHdv98KDU3eA41kAMaEzS8E2G7/qFuS
         eNPA==
X-Gm-Message-State: AC+VfDx5RBfXQ+ciyvfMtjUx54PtosQdq1Co65R9eVbHUEuDstJZKxBj
	6XA2Jfyv8NhKepN8/gOx2k4LTflZpXm/zWSdeGjfecLo
X-Google-Smtp-Source: ACHHUZ47MCLJVSG9ElxImH6otXw81o8JNSGr2eM0t9kU+gS5X699ne9Gf+aVgGdNOcSmk6sN0avKVB72vL2XQv7FZzE=
X-Received: by 2002:a17:906:6a1e:b0:879:ab3:93d1 with SMTP id
 qw30-20020a1709066a1e00b008790ab393d1mr562419ejc.4.1683241610570; Thu, 04 May
 2023 16:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-5-andrii@kernel.org>
 <20230504200544.mikkqyc7h7ftxal3@MacBook-Pro-6.local> <CAEf4BzbT1MNiUC5A0MTFjVvYOsXnh06SHukGgvzx-wdjRV8uHw@mail.gmail.com>
 <20230504225459.fjbvxfx45m7ym5ft@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504225459.fjbvxfx45m7ym5ft@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 16:06:38 -0700
Message-ID: <CAEf4BzbszEMZFgxG8rTPaCPNRLtu8PJHWP8zQ7miyBNymVQTFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: remember if bpf_map was unprivileged
 and use that consistently
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 3:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 04, 2023 at 03:51:16PM -0700, Andrii Nakryiko wrote:
> > On Thu, May 4, 2023 at 1:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, May 02, 2023 at 04:06:13PM -0700, Andrii Nakryiko wrote:
> > > >  }
> > > >
> > > > -static struct bpf_map *array_map_alloc(union bpf_attr *attr)
> > > > +static u32 array_index_mask(u32 max_entries)
> > > >  {
> > > > -     bool percpu =3D attr->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARR=
AY;
> > > > -     int numa_node =3D bpf_map_attr_numa_node(attr);
> > > > -     u32 elem_size, index_mask, max_entries;
> > > > -     bool bypass_spec_v1 =3D bpf_bypass_spec_v1();
> > >
> > > static inline bool bpf_bypass_spec_v1(void)
> > > {
> > >         return perfmon_capable();
> > > }
> > >
> > > > +             /* unprivileged is OK, but we still record if we had =
CAP_BPF */
> > > > +             unpriv =3D !bpf_capable();
> > >
> > > map->unpriv flag makes sense as !CAP_BPF,
> > > but it's not equivalent to bpf_bypass_spec_v1.
> > >
> >
> > argh, right, it's perfmon_capable() :(
> >
> > what do you propose? do bpf_capable and perfmon_capable fields for
> > each map separately? or keep unpriv and add perfmon_capable
> > separately? or any better ideas?..
>
> Instead of map->unpriv I'd add map->bpf_capable and map->perfmon_capable
> just like we'll be doing to progs.

ok, sounds good!

