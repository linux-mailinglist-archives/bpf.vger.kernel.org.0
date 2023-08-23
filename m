Return-Path: <bpf+bounces-8415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376A78620E
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 23:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6406E1C20D54
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD5200A4;
	Wed, 23 Aug 2023 21:17:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC8C2CD
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 21:17:19 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E4910DC;
	Wed, 23 Aug 2023 14:17:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so538167a12.0;
        Wed, 23 Aug 2023 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825422; x=1693430222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4xPfqps2kKEKFbrOYaDnemOvZUFi29nYUJXxM/0N8g=;
        b=rcHQ8V/pu5bK6VOXZiKCId45KBijfddk8/Fbbkqutben4eE2vkqmE9K4AoRNH4DDxT
         83da+YSanyY3qgwUQ/XeKdizn1ISPaFhcrtjf7wytmtfpDoqzNWDizTifayv9eZe1BJv
         tl3xFmIfnpq6OAH3CEEaaGuAqiyxGzr8jN0tU+MCue3YT8P/vHAHU7hoN1iioCiYNU4i
         bJaiUf43ZbjkwNRF3k0hIU71DFpTVNFAvJemv35r+igVNWUKKTs7O99l5OiqBRWWeLgC
         OZ+LtxNFGlkFRmV+rQJNHb909emSJz2rSmIN3znrfKnrtyWFUZDwkhljzJdT2a+p0DG4
         uvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825422; x=1693430222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4xPfqps2kKEKFbrOYaDnemOvZUFi29nYUJXxM/0N8g=;
        b=OjUeYdV2iintPHlxxDGq4hGY4bMIe4qsDp89kugc9lQ7cZrS69nE7UE/H/k9m8aoOB
         WbEI3oktdur5x+WbVekTivftlJ+7kcWWYyWC+KjTChf0WXQoBDnVDN5Kv/2vAM07Oy8M
         fpCnE02gLNqoDXo5JPyw7tsV3DxGqI6hb524p/MscLqDM5ewiliBwzO+wDX5dHEIZaUm
         dxNkG4cUs9KcKG0U2LwNczn6z/19PK669M0QwAvb02eqWzjXMIMnGfOrcHKX4CO8sMfE
         EhPchTGrdZWnGPYFn19rAZqqOLyTGHWMKJD280x4DGJcrxOvRtx6nbqCJIInwKuCNoLL
         fUJA==
X-Gm-Message-State: AOJu0YxhQC/WEGituESHdqAOfLStozdzmVnSrAVJsTmALN5ayZ289Vui
	FhVmzgHfaX6vZUbdy/UQb6ULKADedV/+m7AhPFw=
X-Google-Smtp-Source: AGHT+IGlayHDuH/bcetJTem6VlbHoKIKsGHPh0Z1A0hTyqKwrjXGaOpzXcn5M7AwfnWObKpTApe9XEjF37+fHdypWRU=
X-Received: by 2002:a50:fa87:0:b0:525:8124:20fe with SMTP id
 w7-20020a50fa87000000b00525812420femr16840038edr.18.1692825422232; Wed, 23
 Aug 2023 14:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
 <CAEf4BzbGhhOyeWLuP95K20344aZnQ61TjiQ=scd5TKz_fiP_AQ@mail.gmail.com> <gu4eynktnim7l2oln4i4sgmziluhdfmzgcbbukfebv5bo57g5r@5kxyfar7tlzv>
In-Reply-To: <gu4eynktnim7l2oln4i4sgmziluhdfmzgcbbukfebv5bo57g5r@5kxyfar7tlzv>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Aug 2023 14:16:50 -0700
Message-ID: <CAEf4BzayCLQxmzgWkAzU-vzD9K+iDvBHkLYSx8w=da-o9dW75w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__unpin()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 11:43=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Wed, Aug 23, 2023 at 10:19:10AM -0700, Andrii Nakryiko wrote:
> > On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
> > >
> > > For bpf_object__pin_programs() there is bpf_object__unpin_programs().
> > > Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().
> > >
> > > But no bpf_object__unpin() for bpf_object__pin(). Adding the former a=
dds
> > > symmetry to the API.
> > >
> > > It's also convenient for cleanup in application code. It's an API I
> > > would've used if it was available for a repro I was writing earlier.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  tools/lib/bpf/libbpf.c   | 15 +++++++++++++++
> > >  tools/lib/bpf/libbpf.h   |  1 +
> > >  tools/lib/bpf/libbpf.map |  1 +
> > >  3 files changed, 17 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 4c3967d94b6d..96ff1aa4bf6a 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -8376,6 +8376,21 @@ int bpf_object__pin(struct bpf_object *obj, co=
nst char *path)
> > >         return 0;
> > >  }
> > >
> > > +int bpf_object__unpin(struct bpf_object *obj, const char *path)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D bpf_object__unpin_programs(obj, path);
> > > +       if (err)
> > > +               return libbpf_err(err);
> > > +
> > > +       err =3D bpf_object__unpin_maps(obj, path);
> > > +       if (err)
> > > +               return libbpf_err(err);
> > > +
> > > +       return 0;
> > > +}
> > > +
> >
> > pin APIs predate me, and I barely ever use them, but I wonder if
> > people feel fine with the fact that if any single unpin fails, all the
> > other programs/maps will not be unpinned? I also wonder if the best
> > effort unpinning of everything (while propagating first/last error) is
> > more practical? Looking at bpf_object__pin_programs, we try unpin
> > everything, even if some unpins fail.
> >
> > Any thoughts or preferences?
>
> Yeah, I noticed bpf_object__pin_programs() tries to simulate some
> transactionality. However, bpf_object__unpin_programs() and
> bpf_object__unpin_maps() both do not try rollbacks and have already been
> exposed as public API. So I thought it would be best to stay consistent.

yep, makes sense. I guess if I were to rely heavily on
pinning/unpinning, I always have an option to pin/unpin individually.
Ok, please address the other feedback and resubmit.

>
> I also figured it's unlikely only a single unpin() fails. For pin(), you
> could have name collisions. But not for unpin(). I suppose the main
> error case is if some 3rd party (or yourself) comes in and messes with
> your objects in bpffs.
>
> In general, though, there are other places where transactionality would
> be a nice property. For example, if I have a TC prog that I want to
> attach to, say, _all_ ethernet interfaces, I have to be careful about
> rollbacks in the event of failure on a single iface.
>
> It would be really nice if the kernel  had a general way to provide
> atomicity w.r.t. multiple operations. But I suppose that's a hard
> problem.
>
> [...]
>
> Thanks,
> Daniel

