Return-Path: <bpf+bounces-48713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5242CA0C3B8
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 22:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453AE188213B
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 21:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877501D2F42;
	Mon, 13 Jan 2025 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTieHjMA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3A1BDCF;
	Mon, 13 Jan 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803860; cv=none; b=DnJAaRKBopDCzJnweSUkyE22+a8/6mgRoiU/oGybpMoOQwNCnXGunHZ8Nlb4WgpWkSaoQldkftWlmC3UEN5k51FgLr7aqnMZ7w8TxcVWqDmBEo3qhgG7cMM1vjo5FkTICJW8tk+R45SI4IOEp9qpKZ9kGd7ntKr5B7WHhcGy2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803860; c=relaxed/simple;
	bh=GzIWB/ozfz9lkuAmR1+RhKyN30aLwcPWK3v+HLQW1KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyz3ajjsmWZDG+gj6O3/UsRk3cR4CFISeXaRZcvO1ilASEJmezjWMiDnR/gr77EXBVKaE/PyGSpfPR+NIZ2uF1JcAyPnkk33Aigp6ANfImOLDlEpUua+5jdeTlmJcOFppIhmftzZwrgu3A0epYp61xVYASUO4Gk5Wia76WADWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTieHjMA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4363ae65100so50287285e9.0;
        Mon, 13 Jan 2025 13:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736803857; x=1737408657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlHn+GtFzKpqovtntNIkOwPzd+eLgTNYUBwAGwpM/AU=;
        b=lTieHjMAv/AHDeu2Ndjx0f6J+PXkeTNNm4sNpOgeJz1BVRl3aa27eb5GszhQRf44rt
         FNwotWh28RwEszCXJNGmNU9skwMSxrz4d65D9aDG5AE56EXJC/fRCPfW7/nJKNGLXRWY
         GMolz2nubbJ+MZrfv4nH1QlV6RU+3J9C6Lx23BOb+h2nrTlVwzeoPYVgTH2YNSyKRgVP
         ppodGapNrimvIKqS3lgx86Ymwe6cvFRbEU6jLAr7pj224gAF+2YMkv95FW7VPhk6Heyc
         xQUKaFAivJdzBykT9DcbyLdY/2i/cvIJ+TIryhzLzG6af3GReXwcx0xNcorUBNI5V+ky
         /Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736803857; x=1737408657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlHn+GtFzKpqovtntNIkOwPzd+eLgTNYUBwAGwpM/AU=;
        b=lx9jtl9v/htP3tRedU5YozpmKFTmR+9mGd9MxzLo/B+NitHt7/VybAYXQ1kSahyzqy
         tqA+0ddhvH6xvzwPro05PkBlbUzV5malsEsmd3wu5oQY0i3k0PnzWeWCxGo/4dS1yBVz
         +1JIfTs/5I9KSvMuQgJjOfjTue4B5hSno/Pw8Hp3dE2iL/Ip+iGcl7j4MaHt/ObwMFm5
         b68o4R7U3/LfCPsEAL+oI3xFdwRxfn4cJOvNY4HQXT7H6kW03YDuhL8p2hrDL8tGt+4X
         kao92qohBkeIIEIBUjK2ws1qzUj4cSW04YPET0nJNEdI86GOhtcLCIvl0ulzroBatbDG
         lNCw==
X-Forwarded-Encrypted: i=1; AJvYcCUJqQHcjAz35atiWa27nmDDjsXJxhSMKqXyuu9S6EtrhL1QVMYwoT6Tzxau3RhMlF4Yj9s=@vger.kernel.org, AJvYcCXfvcfA1b0KsR/IvGv0fTfoPhmB1/Pw8ynVhySbJ3OL5TW4+y99mileO5cRPcSYYhzgyW6L/jzMlSevDLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwekB6UWCWmrMmg6Vt9SvN5UbEvABWgAj1rSvLkL/7s2YYaqVGf
	oC/C/TD8OMu28alboV42342b+Z1CBl9/4UMvMbMn4h6ErUHjliNj2RXLKs32Em96iCDyFW5KDaB
	7oz+ZyzgnkgMeM1HBo/FQi18w+Pg=
X-Gm-Gg: ASbGnctdQl3EwYyBl0zP6ZL8c3g50RVdHGNDM1pW2VKK29qNG4xNh8nChzlFiJo+B3s
	946cKGwf3jGc44DaGzWOxv+6hcjTILBbcU0HPHWcQTgEnAR7ef3xtxg==
X-Google-Smtp-Source: AGHT+IHis/XRGdtkkqf0jNgpkWxfw7jtdestUbZfVnsNrW9/slRe2zVoQskmEpu4PZdDJIP5T15jjzKAjlQAGq36ovc=
X-Received: by 2002:a05:600c:54c5:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-436e3fb231cmr185268125e9.27.1736803856270; Mon, 13 Jan 2025
 13:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
 <20250107120417.1237392-9-tom.leiming@gmail.com> <CAADnVQLGw07CNpi7=XHJRgBL2ku7Q23nfah07pBc45G+xeTKxw@mail.gmail.com>
 <Z4SRrrXeoZ2MwH96@fedora>
In-Reply-To: <Z4SRrrXeoZ2MwH96@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Jan 2025 13:30:45 -0800
X-Gm-Features: AbW1kvYWdKL5LnB6tyJ8tPRoaM8fumrY728TfdKs9Ex-NQZxn7RdDRTVsqjvVxY
Message-ID: <CAADnVQK1y2A_-Co5Jx=eeusbcMbEgErxuPzgCqA0yvUU6Uw1CA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/22] ublk: bpf: add bpf struct_ops
To: Ming Lei <tom.leiming@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 8:08=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> Hello Alexei,
>
> Thanks for your comments!
>
> On Thu, Jan 09, 2025 at 05:43:12PM -0800, Alexei Starovoitov wrote:
> > On Tue, Jan 7, 2025 at 4:08=E2=80=AFAM Ming Lei <tom.leiming@gmail.com>=
 wrote:
> > > +
> > > +/* Return true if io cmd is queued, otherwise forward it to userspac=
e */
> > > +bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request *re=
q,
> > > +                         queue_io_cmd_t cb)
> > > +{
> > > +       ublk_bpf_return_t ret;
> > > +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> > > +       struct ublk_bpf_io *bpf_io =3D &data->bpf_data;
> > > +       const unsigned long total =3D iod->nr_sectors << 9;
> > > +       unsigned int done =3D 0;
> > > +       bool res =3D true;
> > > +       int err;
> > > +
> > > +       if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags))
> > > +               ublk_bpf_prep_io(bpf_io, iod);
> > > +
> > > +       do {
> > > +               enum ublk_bpf_disposition rc;
> > > +               unsigned int bytes;
> > > +
> > > +               ret =3D cb(bpf_io, done);
> >
> > High level observation...
> > I suspect forcing all sturct_ops callbacks to have only these
> > two arguments and packing args into ublk_bpf_io
> > will be limiting in the long term.
>
> There are three callbacks defined, and only the two with same type for
> queuing io commands are covered in this function.
>
> But yes, callback type belongs to API, which should be designed
> carefully, and I will think about further.
>
> >
> > And this part of api would need to be redesigned,
> > but since it's not an uapi... not a big deal.
> >
> > > +               rc =3D ublk_bpf_get_disposition(ret);
> > > +
> > > +               if (rc =3D=3D UBLK_BPF_IO_QUEUED)
> > > +                       goto exit;
> > > +
> > > +               if (rc =3D=3D UBLK_BPF_IO_REDIRECT)
> > > +                       break;
> >
> > Same point about return value processing...
> > Each struct_ops callback could have had its own meaning
> > of retvals.
> > I suspect it would have been more flexible and more powerful
> > this way.
>
> Yeah, I agree, just the 3rd callback of release_io_cmd_t isn't covered
> in this function.
>
> >
> > Other than that bpf plumbing looks good.
> >
> > There is an issue with leaking allocated memory in bpf_aio_alloc kfunc
> > (it probably should be KF_ACQUIRE)
>
> It is one problem which troubles me too:
>
> - another callback of struct_ops/bpf_aio_complete_cb is guaranteed to be
> called after the 'struct bpf_aio' instance is submitted via kfunc
> bpf_aio_submit(), and it is supposed to be freed from
> struct_ops/bpf_aio_complete_cb
>
> - but the following verifier failure is triggered if bpf_aio_alloc and
> bpf_aio_release are marked as KF_ACQUIRE & KF_RELEASE.
>
> ```
> libbpf: prog 'ublk_loop_comp_cb': -- BEGIN PROG LOAD LOG --
> Global function ublk_loop_comp_cb() doesn't return scalar. Only those are=
 supported.
> ```

That's odd.
Adding KF_ACQ/REL to bpf_aio_alloc/release kfuncs shouldn't affect
verification of ublk_loop_comp_cb() prog. It's fine for it to stay 'void'
return.
You probably made it global function and that's was the reason for this
verifier error. Global funcs have to return scalar for now.
We can relax this restriction if necessary.

>
> Here 'struct bpf_aio' instance isn't stored in map, and it is provided
> from struct_ops callback(bpf_aio_complete_cb), I appreciate you may share
> any idea about how to let KF_ACQUIRE/KF_RELEASE cover the usage here.

This is so that:

ublk_loop_comp_cb ->
  ublk_loop_comp_and_release_aio ->
    bpf_aio_release

would properly recognize that ref to aio is dropped?

Currently the verifier doesn't support that,
but there is work in progress to add this feature:

https://lore.kernel.org/bpf/20241220195619.2022866-2-amery.hung@gmail.com/

then in cfi_stabs annotated bio argument in bpf_aio_complete_cb()
as "struct bpf_aio *aio__ref"

Then the verifier will recognize that callback argument
comes refcounted and the prog has to call KF_RELEASE kfunc on it.


>
> > and a few other things, but before doing any in depth review
> > from bpf pov I'd like to hear what block folks think.
>
> Me too, look forward to comments from our block guys.
>
> >
> > Motivation looks useful,
> > but the claim of performance gains without performance numbers
> > is a leap of faith.
>
> Follows some data:
>
> 1) ublk-null bpf vs. ublk-null with bpf
>
> - 1.97M IOPS vs. 3.7M IOPS
>
> - setup ublk-null
>
>         cd tools/testing/selftests/ublk
>         ./ublk_bpf add -t null -q 2
>
> - setup ublk-null wit bpf
>
>         cd tools/testing/selftests/ublk
>         ./ublk_bpf reg -t null ./ublk_null.bpf.o
>         ./ublk_bpf add -t null -q 2 --bpf_prog 0
>
> - run  `fio/t/io_uring -p 0 /dev/ublkb0`
>
> 2) ublk-loop
>
> The built-in utility of `ublk_bpf` only supports bpf io handling, but com=
pared
> with ublksrv, the improvement isn't so big, still with ~10%. One reason
> is that bpf aio is just started, not optimized, in theory:
>
> - it saves one kernel-user context switch
> - save one time of user-kernel IO buffer copy
> - much less io handling code footprint compared with userspace io handlin=
g
>
> The improvement is supposed to be big especially in big chunk size
> IO workload.
>
>
> Thanks,
> Ming

