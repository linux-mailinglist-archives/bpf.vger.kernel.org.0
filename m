Return-Path: <bpf+bounces-8399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B012B785F3D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03D51C20CEF
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71791F924;
	Wed, 23 Aug 2023 18:08:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019541ED47
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 18:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92065C433CA;
	Wed, 23 Aug 2023 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692814123;
	bh=ZlmdlLwCo6XD+18Ui4QaiBV8awJIuRKcYkiSSpUhvhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CjSWgVPmQ6RD8icjdgVUVVaGlJL8Cy+VbD+YjO7BlkFYmXjg5eMexHEN2Pbs7d9OB
	 GjoyMnaA/ZTsR6kY+1e1RtjtR2lg5VJfpEjQU2kIb4/nEDf0wMp2Et5smVbCb45xqc
	 D5sD8Nn2nc96Rfcrh39952HxYJDrft5oS07sBlbRHvvV7KH4ksKbuHIy55b90wqc3V
	 9DzYH05MreWHek9yY/Ju0nv9IaoJIDrphIWGgNjiWOqDhPnZcwoF5TrRsr13nO7BlL
	 oWsnCFpaF6SzQlaP2yEWFZ9RrcM7ZEaYjALExgRfNLou2MGjdpL3Oy3afr8x/jnon/
	 BWN2HS/lz8ESQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso9077706e87.1;
        Wed, 23 Aug 2023 11:08:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YymB3YXyKB4Pf+b/Le20+E2Lbo+QxqI1bnhsxMHgWx/lQLUdRFd
	Iz20v/I0CNI1MMkZWZIMomv9XEq449Oe0BKjeEo=
X-Google-Smtp-Source: AGHT+IFCemIq+bMNvJXkYFbXSSx0COf3lIKmZpjr1MpwW+o2pfZVw3Izw/5pYtCoTXrtku+DLKFNQB5klSJI23SJfLs=
X-Received: by 2002:a05:6512:ad5:b0:4f8:5604:4b50 with SMTP id
 n21-20020a0565120ad500b004f856044b50mr10505737lfu.64.1692814121404; Wed, 23
 Aug 2023 11:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
 <CAEf4BzbGhhOyeWLuP95K20344aZnQ61TjiQ=scd5TKz_fiP_AQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbGhhOyeWLuP95K20344aZnQ61TjiQ=scd5TKz_fiP_AQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 23 Aug 2023 11:08:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Ao5Dbmu-hx_ZTCxProzkbT5p8bFyZJsggzdASLubpfA@mail.gmail.com>
Message-ID: <CAPhsuW7Ao5Dbmu-hx_ZTCxProzkbT5p8bFyZJsggzdASLubpfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__unpin()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:19=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > For bpf_object__pin_programs() there is bpf_object__unpin_programs().
> > Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().
> >
> > But no bpf_object__unpin() for bpf_object__pin(). Adding the former add=
s
> > symmetry to the API.
> >
> > It's also convenient for cleanup in application code. It's an API I
> > would've used if it was available for a repro I was writing earlier.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  tools/lib/bpf/libbpf.c   | 15 +++++++++++++++
> >  tools/lib/bpf/libbpf.h   |  1 +
> >  tools/lib/bpf/libbpf.map |  1 +
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4c3967d94b6d..96ff1aa4bf6a 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8376,6 +8376,21 @@ int bpf_object__pin(struct bpf_object *obj, cons=
t char *path)
> >         return 0;
> >  }
> >
> > +int bpf_object__unpin(struct bpf_object *obj, const char *path)
> > +{
> > +       int err;
> > +
> > +       err =3D bpf_object__unpin_programs(obj, path);
> > +       if (err)
> > +               return libbpf_err(err);
> > +
> > +       err =3D bpf_object__unpin_maps(obj, path);
> > +       if (err)
> > +               return libbpf_err(err);
> > +
> > +       return 0;
> > +}
> > +
>
> pin APIs predate me, and I barely ever use them, but I wonder if
> people feel fine with the fact that if any single unpin fails, all the
> other programs/maps will not be unpinned? I also wonder if the best
> effort unpinning of everything (while propagating first/last error) is
> more practical? Looking at bpf_object__pin_programs, we try unpin
> everything, even if some unpins fail.

I think the behavior of bpf_object__pin_programs() makes sense for
the error handling path, e.g. undo everything as much as possible.
bpf_object__unpin(), OTOH, is similar to bpf_object__unpin_programs()
and bpf_object__unpin_maps(), if something went wrong, we just give up.

>
> Any thoughts or preferences?

I think current version is ok, as it matches bpf_object__unpin_programs
and bpf_object__unpin_maps behavior. But I guess we can change all
3?

Thanks,
Song

