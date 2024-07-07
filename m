Return-Path: <bpf+bounces-34011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B465929633
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 02:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14EA1F21680
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF4139B;
	Sun,  7 Jul 2024 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwqQicta"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBA4A1C
	for <bpf@vger.kernel.org>; Sun,  7 Jul 2024 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312957; cv=none; b=fzfUG/JFdyVwG5LzNL7HPiKrl8iOLhi6251XCglmqFwi8ureEWY0hPLoCYOd4IQh1aNpA0GH5/UGKbIOqa8FUolaAfl5stnb2xAG76r/rhqbFC9dRs61JgPDmEjU6DGE39wA11i2m3F5Jf9o8HKG2Zo1R/RomNPM/OZdUCBHJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312957; c=relaxed/simple;
	bh=9Fg6RExrb2i4afspEkkehUxQ7k+6jLHb3K3qiz+Kb8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3MlFl4BbLYVrafBdoZvUzw1Ua+tNcI8nd+rw/NamKcqecyp595hSRLN68Ijunkjto2jEzn/VK1F9XgdXywoLP5IbN6qkuyAu5m31tLIT7+Sr+OQBJHMUXm8ts8kPu1/ooBOFw209ScvbAzpctjCY8pHufcygkji9FP/GXVvleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwqQicta; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42666fd6261so311695e9.3
        for <bpf@vger.kernel.org>; Sat, 06 Jul 2024 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720312954; x=1720917754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBNpdJEM26PF4dd0j3nvfO/XQPh40tyVm8IypiptEXU=;
        b=HwqQicta+GrsiKmbuEnL2wOI+3IUQljnbJRBxwEv+tNVbMEfq4q1d433LZs8gVFjh9
         h008wHbHG6VQ3B4g0wJNcOyDC1fLcFUK+WWNAAwxTQirgHRw8Seh5a0nncO9m0JtCpSE
         siF0YQXoeCl0+OiJ5RdkCHb9j/kmgrdvQN1hSSy3WKA54k3txz+zqekss1vu1Htwq/RL
         eYHmHekBaOGQrq7YFnp5Y0NCHJT6E7xO5xdAAiDVyuOj8bxfWCtUfUpQgk2XquDlnmfh
         b+F9Kul4obndzawRnhgMTTh4dc7dV9HJoed4khfBps3CPgqk41/LfYlvEHBUzl5yxzuZ
         ADYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720312954; x=1720917754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBNpdJEM26PF4dd0j3nvfO/XQPh40tyVm8IypiptEXU=;
        b=FiLutsRCXX4/3CLRGcz5drGpg9SgkoossQPtIzhRgoM6HsuenS6HFf9uoA8Dkodyp5
         kVdt2z36JiOZOjnmpJlcjhxBXBMCDT2AF+sBYNrglX2fYEd9C4CGpn8vQhxqrIgYAUou
         WQpMX/yc98tt2LmCskIiaduVW6dQ8gNMq6S8VUUGaNb7RrQkctU+5brwqhOW9NBj1ndx
         wIOW1uP+P7+pshO6lZNUmavA7ChXBjw7nU+RfgUfQ/vFc8X4MUJp/rRtNfpxy6dFFxlI
         wmIYy2Qxt3V4HuYlBRAb3K+Ig1eoF4daecjb0S4Wd9SleJrP4J4is2nlGCcGw1N+F09m
         muGw==
X-Gm-Message-State: AOJu0YySj8Yq39bOnR+/Q2duYp2yymIEI121FncopH2iVKmPUYvAjt8/
	PWLGoD82THVCIGjc2lNr7u0BfLd6TJJoUaBzjtG/TAo5YCTS4HGYmjEULpQw6AHzomvLQMnTbE3
	osENtd/1Q+XM7sRGW9k4PLNxQ9qI=
X-Google-Smtp-Source: AGHT+IEEWlSdbsgPU9pmJpSUS4OOU0cDDU86x2qsp1FqF+hCnrRU3tZ5IduJGS9+KEfZb2PPsJu35xrEOHc2ALrHkRs=
X-Received: by 2002:adf:f04a:0:b0:367:8a3e:c127 with SMTP id
 ffacd0b85a97d-3679dd80615mr5866227f8f.63.1720312953808; Sat, 06 Jul 2024
 17:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702142542.179753-1-bigeasy@linutronix.de>
 <20240702142542.179753-2-bigeasy@linutronix.de> <CAADnVQKPLGKWT9Dx750CcR6B53cw1cW_cihQtONwBmHqrCRjDA@mail.gmail.com>
 <20240704080033.eaXWEjdS@linutronix.de>
In-Reply-To: <20240704080033.eaXWEjdS@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 6 Jul 2024 17:42:22 -0700
Message-ID: <CAADnVQ+W3xY2denu6wT-OkO2HHQPxnivNLOpvztoqccs00WEHg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add casts to keep sparse quiet.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:00=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-07-03 14:39:16 [-0700], Alexei Starovoitov wrote:
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 25ea393cf084b..f45b03706e4e9 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6290,12 +6290,12 @@ struct bpf_tunnel_key {
> > >   */
> > >  struct bpf_xfrm_state {
> > >         __u32 reqid;
> > > -       __u32 spi;      /* Stored in network byte order */
> > > +       __be32 spi;     /* Stored in network byte order */
> > >         __u16 family;
> > >         __u16 ext;      /* Padding, future use. */
> > >         union {
> > > -               __u32 remote_ipv4;      /* Stored in network byte ord=
er */
> > > -               __u32 remote_ipv6[4];   /* Stored in network byte ord=
er */
> > > +               __be32 remote_ipv4;     /* Stored in network byte ord=
er */
> > > +               __be32 remote_ipv6[4];  /* Stored in network byte ord=
er */
> > >         };
> > >  };
> >
> > I don't think we should be changing uapi because of sparse.
> > I would ignore the warnings.
>
> There are other struct member within this bpf.h which use __be32 so it
> is known to userland (in terms of the compiler won't complain about an
> unknown type due to missing include). The type is essentially the same
> since the __bitwise attribute is empty except for sparse (which defines
> __CHECKER_).
> Therefore I wouldn't say this changes the uapi in an incompatible way.

There are two remote_ipv[46] fields in uapi/bpf.h added in 2016 and 2018
with __u32. We're not going to change one them to __be32 now,
because you noticed a sparse warn on the _kernel_ side.

In general, sparse warn is never a reason to change uapi.
If you want to shut up sparse, adjust the kernel side only,
or better yet ignore it.

