Return-Path: <bpf+bounces-13970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD47DF788
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60511C20EB2
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE451DA4D;
	Thu,  2 Nov 2023 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRcLFHGU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4F14A92
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:21:22 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B63DE3
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:21:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9be02fcf268so172308766b.3
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698942079; x=1699546879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfkyyWeLj3dDUEMqCYYSyDqWXRPqyMVfG/ifi5s+rjc=;
        b=IRcLFHGUxXSmjprJLwW4Knc0imKTBJNbNEOp35LH9uHKuoSZDUkJ+OEQjzz2SlUlBB
         XueTehyAkVunP9g1kDK9IX3I5+Vr/cfMRADI0tKs2ijvDKuE7sl3pi9GYOFCndbkvYeL
         lRWz/2ibrxGxsPnSkgP9r4PPjDqHpL04WpjNTisR16DlECdR8Vya4oqGagCqRc9YUd8V
         zlAkzttJzwObPKZnQVh+B+jxD8Xwesu8OawQ3XOdsRB8W/+sL+OkZHyUnLsSAuwYjmuj
         E56kzkSKkdPSRXjdJ4u8VDRMLUrfRn7In2WS2VpzHj6GOiabGqqgw48iFjT0m9LGubUf
         JKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698942079; x=1699546879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfkyyWeLj3dDUEMqCYYSyDqWXRPqyMVfG/ifi5s+rjc=;
        b=m36g1aPX5XElX6rO/bFXiAqkb03bF5fr6G3ziHQV+X08i/5Bdjlv4+kanEYsX9Afcb
         Z4E1BXjXljzBNjrJCj17QIHJnWFEXeeezSujD9lwM56PPpfOlzLdh7BYOI3HgNEJkdKa
         UgEDcYWmoOvDT6i5ea9VhTLkbwX9CUQx92/GDb4kaIKK94dhx+lqE5vm5KE8DSbOwzod
         H4hWAnNIHjKQilqiV8jK8KnFtxhs28mrp21R6x7q/+5KRZRF3B8YNqZHmePaaVhtlZm4
         cvptE3iQb3qdWtC9GdRo5Jv8TGb3e7T9h9d4hfDqP4xQzmp641jXz/XxYgx9l22H4lhU
         nAlQ==
X-Gm-Message-State: AOJu0YyhDmDz+mMmZN5HvyKjfT+Q0FSVFwkB9zyerkuApYyghyB1UlMR
	IJQiBiBZWUdsx2yYw1Tjo9gw6AUuw6AzQ42lPPw=
X-Google-Smtp-Source: AGHT+IEHg3rFeMWHtU6RzLZ0kMR4TRdUogXZ/Org41NbpE9Z72BAE8LV2z/H0mpZ3BnmsM2g4HSyG5+d0LB9NQMaM5A=
X-Received: by 2002:a17:907:9448:b0:9ad:be8a:a588 with SMTP id
 dl8-20020a170907944800b009adbe8aa588mr5051242ejc.1.1698942078597; Thu, 02 Nov
 2023 09:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-4-jolsa@kernel.org>
 <CAPhsuW6xTHt3PcFEJxjAuWp-8EMgtaUHUp1KTV07OOY-FYeS4A@mail.gmail.com>
 <ZTvJY2n1bZ8KtS/X@krava> <CAEf4BzZETCTyAqbBkfL2KvPo8T3ATXsRyj37f9kfVB2d7kj=sg@mail.gmail.com>
 <ZUO5CRlYDB8N0dNk@krava>
In-Reply-To: <ZUO5CRlYDB8N0dNk@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 09:21:07 -0700
Message-ID: <CAEf4BzYJ2EShHzwodTOihez6aXeonhu-s78uFW2j2reSUdzWJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:58=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Nov 01, 2023 at 03:21:42PM -0700, Andrii Nakryiko wrote:
> > On Fri, Oct 27, 2023 at 7:30=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Oct 26, 2023 at 10:55:35AM -0700, Song Liu wrote:
> > > > On Wed, Oct 25, 2023 at 1:24=E2=80=AFPM Jiri Olsa <jolsa@kernel.org=
> wrote:
> > > > [...]
> >
> > [...]
> >
> > > >
> > > > > +               if (upath_max > PATH_MAX)
> > > > > +                       return -E2BIG;
> > > >
> > > > I don't think we need to fail here. How about we simply do
> > > >
> > > >    upath_max =3D min_ut(u32, upath_max, PATH_MAX);
> > >
> > > ok
> >
> > +1, was going to say the same
> >
> > >
> > > >
> > > > > +               buf =3D kmalloc(upath_max, GFP_KERNEL);
> > > > > +               if (!buf)
> > > > > +                       return -ENOMEM;
> > > > > +               p =3D d_path(&umulti_link->path, buf, upath_max);
> > > > > +               if (IS_ERR(p)) {
> > > > > +                       kfree(buf);
> > > > > +                       return -ENOSPC;
> > > > > +               }
> > > > > +               left =3D copy_to_user(upath, p, buf + upath_max -=
 p);
> > > > > +               kfree(buf);
> > > > > +               if (left)
> > > > > +                       return -EFAULT;
> > > > > +       }
> > > > > +
> > > > > +       if (!uoffsets)
> > > > > +               return 0;
> > > > > +
> > > > > +       if (ucount < umulti_link->cnt)
> > > > > +               err =3D -ENOSPC;
> > > > > +       else
> > > > > +               ucount =3D umulti_link->cnt;
> > > > > +
> > > > > +       for (i =3D 0; i < ucount; i++) {
> > > > > +               if (put_user(umulti_link->uprobes[i].offset, uoff=
sets + i))
> > > > > +                       return -EFAULT;
> > > > > +               if (uref_ctr_offsets &&
> > > > > +                   put_user(umulti_link->uprobes[i].ref_ctr_offs=
et, uref_ctr_offsets + i))
> > > > > +                       return -EFAULT;
> > > > > +               if (ucookies &&
> > > > > +                   put_user(umulti_link->uprobes[i].cookie, ucoo=
kies + i))
> > > > > +                       return -EFAULT;
> > > >
> > > > It feels expensive to put_user() 3x in a loop. Maybe we need a new =
struct
> > > > with offset, ref_ctr_offset, and cookie?
> > >
> > > good idea, I think we could store offsets/uref_ctr_offsets/cookies
> > > together both in kernel and user sapce and use just single put_user
> > > call... will check
> > >
> >
> > hm... only offset is mandatory, and then we can have either cookie or
> > ref_ctr_offset or both, so co-locating them in the same struct seems
> > inconvenient and unnecessary
>
> yes, using struct seems too complicated because of this
>
> but during attach we could store offsets/ref_ctr_offsets/cookies
> in separated arrays (instead of in bpf_uprobe) and just use single
> copy_to_user call for each array in here

I think you are trying to optimize for the wrong thing here. link_info
fetching isn't the most performance critical operation, I wouldn't
bother complicating code just to make it a microsecond faster.

>
> jirka

