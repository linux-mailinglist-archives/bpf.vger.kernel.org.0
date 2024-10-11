Return-Path: <bpf+bounces-41752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6198899A84E
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839E31C23642
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73887197A68;
	Fri, 11 Oct 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DquP1FY6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421D195FF1
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661857; cv=none; b=DGLl7vCw8QsCIDo6HNKzGtOGwd2xedr1yNG9aYh7fQ6H1WsR+Un+pILO4DtrY6/SOJRoUwJ2EFOC5j1gMfpkJ+T0AKdOUBDExN5dmhWH47zkMCho28wCF8orJmXYOL1prVJbm45ZoWORMt7K0qHTan7V73v6mr0Jr2rbeg3K7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661857; c=relaxed/simple;
	bh=cZUyyZjEbtnLUtiKMGzRHicAop6Xdfm57OOE5xlry6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMw7gFS4OIOMxk4ZqHYw2M/VNdj1W2+g8BjSVgHOpw1ogzCm7iFIpYEtMIk5/HKhEHE+8xZhpg0XzhsKLtsUnlkNrk3QKnXIT0wU+Dgf7K3Bn/UXbxyaqNbT4KK7ZCLlIA5vLTvFV2LuEfEKvGhoVtItKQKRP89qdvYc723ET6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DquP1FY6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4ba20075so1266454f8f.0
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728661853; x=1729266653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1NzCBNs7o916HxQNZWDvWr6MLhX3CT1kF8mVA+mJzc=;
        b=DquP1FY6vg27PLQd7ubNhWo2En1Kj/0CefYNBRQojtX+zHuxm1eW9JXwAFDTvRROoC
         4Am/Q4OZELZPksegRE7L6XYHLljPFgesRSGcX4naJWFm0LMFBIasvsupxxdYz3G/tG8u
         ErM6i4YgFkHmdE7Kli50EwBznFyuW6t/dcDH2E/hX2jioKikz2xUGf3XWneiWNf82dz+
         sdvT9O0kWdXrSVEjDrKpM7b3Jp6VALjYJufOYZshZHq73CtLgKkTArMRafLYsorjIRYL
         0V5j+M2ZmQMmqFIvIEDrcvRR1msjlMElA7XZyclNXfLEk4NZXGSEHt3ZZf6ICbP6Neo/
         lUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661853; x=1729266653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1NzCBNs7o916HxQNZWDvWr6MLhX3CT1kF8mVA+mJzc=;
        b=bUN2p3sQsiCcWO8DD1o4kpYuB3LWUhjPvFN6fSPLghugHtuRUuFxh/XJpk4lBTaehC
         iOEQBjIRLOJSgEkpEJifUj4PGi/zjcCeWtcqjSJ+OweL4hkEbYumOKE1tJRQFv5ZPnHb
         9XpBTeadDSjIq93+Hf9xP0ewQxD2T1sMwvKkcZ29qdVEG0VnqtThAucU5DpjgHpdSUEe
         4i/QgPrAv76RbtCoRFCI99kYPTxoRdrV6qDJsE0mvYU4Ye/tPGivH7Dhc1mXBjQtwcLt
         CadaDIOjo/G/+8LtOPAdHmCH2gPWEraIETKlSMTJ7YHbQeNPpqu920Jp9vq3svTlHUj+
         GYrw==
X-Gm-Message-State: AOJu0YxuUsz8rFRq+XzC+ww3MSlcQXb5XTI4EIS+MROrmd/+CnJRC5+O
	37y8MEjw7U1nkaxjsf5VzzahgCcBsYCts8aTVEiTKNnpEbQeInaqoH7Oh8FlAW83QHR5m9pQ0qx
	ZrK3vsWFG2coNPZIYEZXUBsHabIo=
X-Google-Smtp-Source: AGHT+IFBg5uXeHbb9hjgTg1DiiBRnd5aZQLzNw8Y9auuyE9B0bz+wrkTj0x9Qo7Jwx9FPB3+zFlfUpPNkVTFAL+drUM=
X-Received: by 2002:adf:ee47:0:b0:37c:d11f:c591 with SMTP id
 ffacd0b85a97d-37d551d5123mr2159708f8f.17.1728661853377; Fri, 11 Oct 2024
 08:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010153835.26984-1-leon.hwang@linux.dev> <20241010153835.26984-2-leon.hwang@linux.dev>
 <CAADnVQL8ie=xxCXt7td=ZhQwyY_hKtig-y9kHwWYwBG9MdfRQA@mail.gmail.com> <c7e49c48-7644-40c3-a4a2-664cc16a702c@linux.dev>
In-Reply-To: <c7e49c48-7644-40c3-a4a2-664cc16a702c@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 08:50:41 -0700
Message-ID: <CAADnVQLh9nBHvkS40gg+PynmfMmPvwuYrcdMh9j2DqoL=9dqqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Prevent tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 8:27=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 11/10/24 01:09, Alexei Starovoitov wrote:
> > On Thu, Oct 10, 2024 at 8:39=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> -static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, st=
ruct bpf_trampoline *tr)
> >> +static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> >> +                                     struct bpf_trampoline *tr,
> >> +                                     struct bpf_prog *tgt_prog)
> >>  {
> >>         enum bpf_tramp_prog_type kind;
> >>         struct bpf_tramp_link *link_exiting;
> >> @@ -544,6 +546,17 @@ static int __bpf_trampoline_link_prog(struct bpf_=
tramp_link *link, struct bpf_tr
> >>                 /* Cannot attach extension if fentry/fexit are in use.=
 */
> >>                 if (cnt)
> >>                         return -EBUSY;
> >> +               guard(mutex)(&tgt_prog->aux->ext_mutex);
> >> +               if (tgt_prog->aux->prog_array_member_cnt)
> >> +                       /* Program extensions can not extend target pr=
og when
> >> +                        * the target prog has been updated to any pro=
g_array
> >> +                        * map as tail callee. It's to prevent a poten=
tial
> >> +                        * infinite loop like:
> >> +                        * tgt prog entry -> tgt prog subprog -> frepl=
ace prog
> >> +                        * entry --tailcall-> tgt prog entry.
> >> +                        */
> >> +                       return -EBUSY;
> >> +               tgt_prog->aux->is_extended =3D true;
> >>                 tr->extension_prog =3D link->link.prog;
> >>                 return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,=
 NULL,
> >>                                           link->link.prog->bpf_func);
> >
> > The suggestion to use guard(mutex) shouldn't be applied mindlessly.
> > Here you extend the mutex holding range all the way through
> > bpf_arch_text_poke().
> > This is wrong.
> >
>
> Understood. The guard(mutex) should indeed limit the mutex holding range
> to as small as possible. I=E2=80=99ll adjust accordingly.
>
> >>         if (kind =3D=3D BPF_TRAMP_REPLACE) {
> >>                 WARN_ON_ONCE(!tr->extension_prog);
> >> +               guard(mutex)(&tgt_prog->aux->ext_mutex);
> >>                 err =3D bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP=
,
> >>                                          tr->extension_prog->bpf_func,=
 NULL);
> >>                 tr->extension_prog =3D NULL;
> >> +               tgt_prog->aux->is_extended =3D false;
> >>                 return err;
> >
> > Same here. Clearly wrong to grab the mutex for the duration of poke.
> >
>
> Ack.
>
> > Also Xu's suggestion makes sense to me.
> > "extension prog should not be tailcalled independently"
> >
> > So I would disable such case as a part of this patch as well.
> >
>
> I=E2=80=99m fine with adding this restriction.
>
> However, it will break a use case that works on the 5.15 kernel:
>
> libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> freplace B.
>
> With this limitation, the chain 'freplace A --tailcall-> freplace B'
> will no longer work.
>
> To comply with the new restriction, the use case would need to be
> updated to:
>
> libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> XDP B.

I don't believe libxdp is doing anything like this.
It makes no sense to load PROG_TYPE_EXT that is supposed to freplace
another subprog and _not_ proceed with the actual replacement.

tail_call-ing into EXT prog directly is likely very broken.
EXT prog doesn't have to have ctx.
Its arguments match the target global subprog which may not have ctx at all=
.

So it's not about disabling, it's fixing the bug.

