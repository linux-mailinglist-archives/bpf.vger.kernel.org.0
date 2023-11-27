Return-Path: <bpf+bounces-15956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503A7FA8D9
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4F1C20A22
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD43D3A3;
	Mon, 27 Nov 2023 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD8zaHOz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45ED5D
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:20:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so5927282a12.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109212; x=1701714012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s0Db2Epp58bsgnp1eB6JFTM6T0ohIwn79RpPSdco1k=;
        b=eD8zaHOzXrkpjD5+QvGyJT3eVUepLM0XEkF9IZmPl+PtXZ6EXQwNayDKepvvnY/el+
         QhKirCJYvFslvmtOlEUu5dElK3ix1hoF+A9Wp5uLdZhbjD2Eju3cMgnHWS2IXOQOPUwj
         p3smlAobUca71rPk84TsovPLm05qKL3VvnK0ziHvgh9jcvrYUQkNzImSrttXugnkb6jg
         qAU/1dJU8xZxIXFXP5f8MCKX8lwh+b27entvshqRpul7+i/qpUOSGMHqe537ZAAXO9iy
         cFTji3p13W6AEjpMmjyX0j8ldSdc5bpLWWobzRHCPNQ5p95G0sBU2IWwJXPA2Nl47PzC
         fmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109212; x=1701714012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s0Db2Epp58bsgnp1eB6JFTM6T0ohIwn79RpPSdco1k=;
        b=FGGI8MGhsThqfFayhu1kmJpvb2MC5gGw5TiskoRuul4gLS42oyIODRyGAlUkUrpjyi
         BlYu6HOhimZJ6v/DYi30li4KkVIC0qapu1U1+GWzb98zmJcqyTs9Immwhvg7OPrwuTG1
         baFSeqnTjEL29qFNq0OAPvEKn23TDtcceCc98xw5mbQbduWC/VP6RfaDu6hBv1xTPMP8
         gVc4OwljOTPZ4lDDcD+BDwY+SjNEQUFD9d/qXCstlE/6/w/oOcE0pIrzmojuAHWoqiTH
         lBDcb61NGugZYD/hanjx2TVa+yOGF3EElfhorxVnWh2+12vcZR04SzATxtIpGpcOqVGj
         KnFA==
X-Gm-Message-State: AOJu0YzOtdKlKk08COZ3OQONRV/Q5j2oGcNtchTavaIpr1psAgs6IdMr
	D/JIusWgwC2VwxtK1eNpvRakLMzpneT6Z1l9LHI=
X-Google-Smtp-Source: AGHT+IF22+JAft5bkHsBjHX+Y2PqUsgOHunsMUroC6ahHpiOu7WxG8HmFW7tMDCubbojZTIHTl+TbVcRHFCbExI9zq4=
X-Received: by 2002:a17:906:17c7:b0:a03:9aa8:166f with SMTP id
 u7-20020a17090617c700b00a039aa8166fmr8215976eje.37.1701109211791; Mon, 27 Nov
 2023 10:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122011656.1105943-1-andrii@kernel.org> <20231122011656.1105943-5-andrii@kernel.org>
 <a6edebc8d7063836c7d031d86a3c43f2dd0f49bd.camel@gmail.com>
 <CAEf4BzaXazY88jiLgwdrnOw2OgSREfuTp5sAfs_-0FyumQB4BQ@mail.gmail.com> <4x5xpjxbcd4srv66flcaopgegpwfpir45qompzsuiubtyk265k@ycg57nu6o5cw>
In-Reply-To: <4x5xpjxbcd4srv66flcaopgegpwfpir45qompzsuiubtyk265k@ycg57nu6o5cw>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Nov 2023 10:19:59 -0800
Message-ID: <CAEf4BzaY5JOMXSzYbg=Ma+JZ6Lu9giyep5Vwn1RoujcPhRx6_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: enforce exact retval range on
 subprog/callback exit
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 2:55=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Wed, Nov 22, 2023 at 09:45:27AM -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 22, 2023 at 7:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> > > > Instead of relying on potentially imprecise tnum representation of
> > > > expected return value range for callbacks and subprogs, validate th=
at
> > > > both tnum and umin/umax range satisfy exact expected range of retur=
n
> > > > values.
> > > >
> > > > E.g., if callback would need to return [0, 2] range, tnum can't
> > > > represent this precisely and instead will allow [0, 3] range. By
> > > > additionally checking umin/umax range, we can make sure that
> > > > subprog/callback indeed returns only valid [0, 2] range.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > (but please see a question below)
> > >
> > > [...]
> > >
> > > > +static bool retval_range_within(struct bpf_retval_range range, con=
st struct bpf_reg_state *reg)
> > > > +{
> > > > +     struct tnum trange =3D retval_range_as_tnum(range);
> > > > +
> > > > +     if (!tnum_in(trange, reg->var_off))
> > > > +             return false;
> > >
> > > Q: When is it necessary to do this check?
> > >    I tried commenting it and test_{verifier,progs} still pass.
> > >    Are there situations when umin/umax change is not sufficient?
> >
> > I believe not. But we still check tnum in check_cond_jmp_op, for
> > example, so I decided to keep it to not have to argue and prove why
> > it's ok to ditch tnum.
>
> Semi-related proof[1] from awhile back :)
>
> > Generally speaking, I think tnum is useful in only one use case:
> > checking (un)aligned memory accesses. This is the only representation
> > that can make sure we have lower 2-3 bits as zero to prove that memory
> > access is 4- or 8-byte aligned.
> >
> > Other than this, I think ranges are more precise and easier to work wit=
h.
>
> Agree with the above.
>
> I'd vote for ditching tnum for the retval check here. With umin/umax
> check in place there really isn't a need for an additional tnum check at
> all. Keeping it probably does more harm (in the form of confusion) than
> good.

Ok, I think it's as trivial as removing two lines of code. So I'll add
it as the last patch to the series and will let BPF maintainers decide
if they want this change or not.

>
> 1: https://lore.kernel.org/bpf/20220831031907.16133-3-shung-hsi.yu@suse.c=
om/
>
> > But I'm not ready to go on the quest to eliminate tnum usage everywhere=
 :)
> >
> > > > +
> > > > +     return range.minval <=3D reg->umin_value && reg->umax_value <=
=3D range.maxval;
> > > > +}
> > > > +
> > >
> > > [...]

