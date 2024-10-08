Return-Path: <bpf+bounces-41184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B843993DA3
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293701F24C45
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3B86F2F3;
	Tue,  8 Oct 2024 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc1xeqau"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88008481D5;
	Tue,  8 Oct 2024 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358945; cv=none; b=iR68L30c35sduFwXetRM/kVYbAGQH3fL3NiybaBJ6jxSLA3PEYgMIja7jDl71CEfP1macVvei7GbHeEdGSWAeHtvKJ3zfZwnmfonwbyIJCg3HBx+qymD7BLfUNMO9DPyb3feapVjt/IS4Id39AAaIq2ecdKUBpzn5CAGl7tn2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358945; c=relaxed/simple;
	bh=dUHbNs8OmoCq9sXfHPYJOtN5idPzbJLg8OjvpWacNB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXBQb2KDGZJbl8wUcxO+PLdGCR+UaN4KL3C0cpCFEK3nPhDpgn/g+2NPIlU8jPritDmsAk72TQMoxDQ+HDGG+b26Lu2n/32oaciknA/YxgaeirBrqP3D0ieZ+2/Z6UUfD9j+nSBehFPzqkCRRZ6MT3dubLLrbWakCnloWEUBMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc1xeqau; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e199b1d157so3751047a91.2;
        Mon, 07 Oct 2024 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358944; x=1728963744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPEVXLPoipOBRRKiHrAP6XN83PjGEwIU888cgWWAXMg=;
        b=Tc1xeqaudl2usCDxfE/Lg9dYhCPgsE5jRugQcsUrYkRcBxSZyKN2VIBPXii6a6fpwK
         dgQXDCSIANayX5UmAkGWJw61AJyXc01Xid1qgWZrarCGcBNTkHZ/gwuIpbbD9r7m4YIx
         AuyfInK827ijG/9Q4KnoZ+2xISAKgmqqrbraA0erwWMHO+0IhvU5vBtIDgH3OGWunVLJ
         +qH+neo7u65IuYbYh9uQGNs0zrLAE3G+QMvCo3jaMdL0IxnnXejozlxZb8OmzmDWCEIs
         B2hI8ArizxH6e4HC4W4hXga2LweqaPgwDZr6MKL/CECK05CdQGOl78Hl269Njcvgwpt6
         08rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358944; x=1728963744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPEVXLPoipOBRRKiHrAP6XN83PjGEwIU888cgWWAXMg=;
        b=sMXBDc1x+Q+AlmHnfP26yqEfpwuuyFaMA/rh93FAQNnK3z1FiDsZlGi2QZoxt+Mkd+
         90Xo1QHTBMHIZHvTBqwV0ckhybUjvDl2mQYAuYi3JcwSQ7x9e17rafbiNXWSYVUGPM74
         Xrgi+ymCTsEvAZd/blfIgVOidQNNyDJqVPL274WW4wjhzWxw6Cn8Fsa1rJb4U5usIKiL
         nzw+EjjsE7UC7eOX4JsFnLIsHXyV/R/SznYQv52HG7FeOlRlzULzvRBl2JFVB6tOTdVJ
         JHMV1CKhAL/nZsrU77MASCKxjTRz8U6fVxpVcuMoN/iBOiW0VSWU455oIWgrz4LPYeCz
         loEg==
X-Forwarded-Encrypted: i=1; AJvYcCW38NQ51qIl6gRK+Gxn1pkWdou5iuO9yxqVfYOqHq0WFp/EbLdJggQ+VhKwsSAgonYTJ+Qrsv4CKFpfyZtA@vger.kernel.org, AJvYcCWfpsEDv7fCkqq8VKwUwqg0KYjhiQHXuwdHUhnGaIurEf/rwziqPG8jHa++r9ar76S1yRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7n9M9r0LHcNjvMHaxP55WJCChiEmjDJ9v935spziPnKtFmeo
	JgK1X5RjgPI12JESzvz/AbiQhR5VV7snW614tZvYppIxHvoiyrc8bcfxrVH8+4ZwPUZkW/u/2uy
	fK0BTj23RyZ8ZjLXsE24G5Z5RQJDrdDiQ
X-Google-Smtp-Source: AGHT+IHbsCmDw5B5kRBUKxVj7JPgnQIF6fZjT7eb0JBWn+hDcF6KtfdbkPBNVgmp291ZdvJ/bTSdRyQzhSdqarOOj7k=
X-Received: by 2002:a17:90b:1a85:b0:2d8:8ead:f013 with SMTP id
 98e67ed59e1d1-2e1e621355dmr16162945a91.7.1728358943759; Mon, 07 Oct 2024
 20:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007164648.20926-1-richard120310@gmail.com> <3be8b6307e7576e5a654f42414a1f0f45a754901.camel@gmail.com>
In-Reply-To: <3be8b6307e7576e5a654f42414a1f0f45a754901.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Oct 2024 20:42:10 -0700
Message-ID: <CAEf4BzbpxXqNLa02r0=xw-bHzDoO5BELHqX+Ux35Hh7XRNY92w@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix integer overflow issue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-10-08 at 00:46 +0800, I Hsin Cheng wrote:
> > Fix integer overflow issue discovered by coverity scan, where
> > "bpf_program_fd()" might return a value less than zero. Assignment of
> > "prog_fd" to "kern_data" will result in integer overflow in that case.
> >
> > Do a pre-check after the program fd is returned, if it's negative we
> > should ignore this program and move on, or maybe add some error handlin=
g
> > mechanism here.
> >
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a3be6f8fac09..95fb5e48e79e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8458,6 +8458,9 @@ static void bpf_map_prepare_vdata(const struct bp=
f_map *map)
> >                       continue;
> >
> >               prog_fd =3D bpf_program__fd(prog);
> > +             if (prog_fd < 0)
> > +                     continue;
> > +
>
> The 'progs' variable comes from 'st_ops->progs' array.
> Elements of this array are set in two places:
> a. bpf_object__collect_st_ops_relos() called from
>    bpf_object__collect_relos() called from
>    bpf_object_open().
>    This handles relocations pointing to programs in global struct ops
>    maps definitions, e.g.:
>
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops testmod_1 =3D {
>            .test_1 =3D (void *)test_1,     // <--- this one
>            ...
>     };
>
> b. bpf_map__init_kern_struct_ops() called from
>    bpf_object__init_kern_struct_ops_maps() called from
>    bpf_object_load().
>    This copies values set from "shadow types", e.g.:
>
>     skel->struct_ops.testmod_1->test_1 =3D skel->some_other_prog
>
> The bpf_map_prepare_vdata() itself is called from
> bpf_object_prepare_struct_ops() called from
> bpf_object_load().
>
> The call to bpf_object_prepare_struct_ops() is preceded by a call to
> bpf_object_adjust_struct_ops_autoload() (c), which in turn is preceded
> by both (a) and (b). Meaning that autoload decisions are final at the
> time of bpf_map_prepare_vdata() call. The (c) enables autoload for
> programs referenced from any struct ops map.
>
> Hence, I think that situation when 'prog_fd < 0' should not be
> possible here =3D> we need an error log before skipping prog_fd
> (or aborting?).
>

Not sure what Eduard is suggesting here, tbh. But I think if this
actually can happen that we have a non-loaded BPF program in one of
those struct_ops slots, then let's add a test demonstrating that.

Worst case of what can happen right now is the kernel rejecting
struct_ops loading due to -22 as a program FD.

pw-bot: cr

> (Also, please double-check what Song Liu suggests about
>  obj->gen_loader, I am not familiar with that part).
>
> >               kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[=
i];
> >               *(unsigned long *)kern_data =3D prog_fd;
> >       }
>
>

