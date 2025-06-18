Return-Path: <bpf+bounces-60984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D897BADF592
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7A189DF1F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9619D081;
	Wed, 18 Jun 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsjn7nw1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447CD3085A2;
	Wed, 18 Jun 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270197; cv=none; b=qGyaT8OPyjLCHz/AvaoQR4QXiNY9j79LCsA6le67Ewon4yA3ATTjcRzH89Mi8xEZDtcFK0YPh1djo8sbV8ZTTOf9gEYkX4E+sBZTa/LMORvpHTTWiXvTQ3NikFeTSOUpmuoRy2NkDsZ+InmwDqgAZ6bT2KwcbyuskfVPrWpFI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270197; c=relaxed/simple;
	bh=On704oIKu9Dr5ctv/xQJeCuEwz4a0qT1jIsNz+ZOsdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqtnlP0+kAMnE0BFNN5Wjwawq326HxlNYsDPZS5datr0fZIHad1xHjJ2HOiqqhJLFB8eJ/eH9skCrW/nq7VHeZRaMHaex70IWthhANduiGITWPtOia5PW8IrCZY//UOCaUEJ5B3E9Oz7krgv7v0+m1k0rxDZC+4uF1Wgvl6Ic3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsjn7nw1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso3620612f8f.1;
        Wed, 18 Jun 2025 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750270193; x=1750874993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LE8Fhk0xegOg1s56kac7KefTo/ULDi4ZnHOa+OaXVo=;
        b=Vsjn7nw16Z4wA8zLJLkhCFtwt+Ck9ktNipjGhaD3BpFSoltndmcoscCjctBqtpi0Va
         kDOTALdjC0WiXWXjfLtOqOOFq0RzjHT+c2uOyLsJNc5DHzPZ8Eh60ASOO7qxs0bVaJX+
         QZW5doYyB8HKlKKbenOe48V87H+D/uZqgQQAJDY6J1JwQWFOO/Uand3+JZl0EvjR8/W8
         4gthrIWIYQJtV1XxgFA+eoedFxuSzPJZ5KQ7inQC0gNimSwA8pSsweVSKWTmoTBUR/nS
         n9isgzi/JwtDnqIhjUbLlBewcE4Dhgl1WrcN4UjtL0vZaejTwNC8v9jEtFqkPPNcSb6B
         Btrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270193; x=1750874993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LE8Fhk0xegOg1s56kac7KefTo/ULDi4ZnHOa+OaXVo=;
        b=pFKYkJGcgW7ah5pRXTBmGEZMTHA4aB1YdeA88IvKLI++0JhbqGftkRSNZlDMSAeixP
         Jw87/c1HGh2LOn+ZfVsFPz77wuwiTXMhr6QO/DNFQwn9O11x1Wx5IoVTDSpY4F1L33oq
         jrdSByu8YGTLHM8xEx61+S96zfkiOjOjyU7v8KDshGEHEBvdIDN12HqIGKCeQeKt2REp
         lwlB8Q1T4WDOVyyQ7hDgl4/MY0r7qqQ+5JYXcMHaSO3NHDz/8fvuT90lI9wUjbVWsITp
         Zqw9UclMHJ0olRIHQqqoaErh3o/2S4IWElFh2oetA41HrdwA0q61jJVsekEjGIkM4HQE
         Tg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV13qgXZeGXApWortLaUXILIJrYFUX5TXeCFY/0adnw3zvpcBMDYhGagpHZ2fcgeeS6BLY=@vger.kernel.org, AJvYcCWGyF2TKxsB9FyC3TCX9NXPBjr9NaH5UbHbSBxNMgghtrm7tDtcXcrK5fBedXD3yUqGwh+Nwm5fXDtNa62E@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43yM70323H0MI36AvrHWYrDU8VbZKtVkqTYq0PXuIacjfAtKN
	6ef5225F/6U8uyAVqyw5AeiLq9S8zcTLLd8CF3JbGdXnKBLED1Z9pTspE5p9B9P3nKeV5xLZTkC
	HsUKJ1dCJzyPZG2CQj/RQoY160nRjcGk=
X-Gm-Gg: ASbGnctkxuH2BSvposNgxRvsq7HHAQW29FTxldb5Og2VRj3uf432jSxrF6O5zvXFk8C
	cj5qvb14IPytZv3M0AoknzgEs3UzUOOoVDr+0Pa/OzrBBc4U8dyjzIlR9hLUV+bPfQO020CU25a
	MuJeu+bqpeD+xcYI4DTjx94ipitqXLQJfte0IqEJvlphhPoVoq7JHWb45ist6G9HfCbE9hGpYU
X-Google-Smtp-Source: AGHT+IGCD5LW151sc5yki0YMdtNcdIprrXSlC7W8DnGviRxlIQnrkJCJe8/zU8Tk27NO381B7QV5Qpbl8O2837oOgpo=
X-Received: by 2002:a05:6000:24c8:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3a572e796a8mr16187762f8f.43.1750270193261; Wed, 18 Jun 2025
 11:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618085609.1876111-1-dongml2@chinatelecom.cn> <CAADnVQ+5HOFu=bwQekwZOmOe+FKk26UJW=S1wZY3bSye_7C23w@mail.gmail.com>
In-Reply-To: <CAADnVQ+5HOFu=bwQekwZOmOe+FKk26UJW=S1wZY3bSye_7C23w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 11:09:42 -0700
X-Gm-Features: Ac12FXzbq9n63ydT83EgAJd9LPxeS0jpjikF20EAgueAWy_XTNBYhzOTtep5Rik
Message-ID: <CAADnVQLsV-Yfh+HGFZEEMvSUe8sh0j=e_hUYkj_XtVsW=toFCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make update_prog_stats always_inline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 11:06=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 18, 2025 at 1:58=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The function update_prog_stats() will be called in the bpf trampoline.
> > Make it always_inline to reduce the overhead.
>
> What kind of difference did you measure ?
>
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/bpf/trampoline.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index c4b1a98ff726..134bcfd00b15 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -911,8 +911,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bp=
f_prog *prog, struct bpf_tram
> >         return bpf_prog_start_time();
> >  }
> >
> > -static void notrace update_prog_stats(struct bpf_prog *prog,
> > -                                     u64 start)
> > +static __always_inline void notrace update_prog_stats(struct bpf_prog =
*prog,
> > +                                                     u64 start)
> >  {
>
> How about the following instead:
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index c4b1a98ff726..728bb2845f41 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -911,28 +911,23 @@ static u64 notrace __bpf_prog_enter_recur(struct
> bpf_prog *prog, struct bpf_tram
>      return bpf_prog_start_time();
>  }
>
> -static void notrace update_prog_stats(struct bpf_prog *prog,
> -                      u64 start)
> +static noinline void notrace __update_prog_stats(struct bpf_prog *prog,
> +                         u64 start)
>  {
>      struct bpf_prog_stats *stats;
> -
> -    if (static_branch_unlikely(&bpf_stats_enabled_key) &&
> -        /* static_key could be enabled in __bpf_prog_enter*
> -         * and disabled in __bpf_prog_exit*.
> -         * And vice versa.
> -         * Hence check that 'start' is valid.
> -         */
> -        start > NO_START_TIME) {
> -        u64 duration =3D sched_clock() - start;
> -        unsigned long flags;
> -
> -        stats =3D this_cpu_ptr(prog->stats);
> -        flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
> -        u64_stats_inc(&stats->cnt);
> -        u64_stats_add(&stats->nsecs, duration);
> -        u64_stats_update_end_irqrestore(&stats->syncp, flags);
> -    }
> +    u64 duration =3D sched_clock() - start;
> +    unsigned long flags;
> +
> +    stats =3D this_cpu_ptr(prog->stats);
> +    flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
> +    u64_stats_inc(&stats->cnt);
> +    u64_stats_add(&stats->nsecs, duration);
> +    u64_stats_update_end_irqrestore(&stats->syncp, flags);
>  }
> +#define update_prog_stats(prog, start) \
> +    if (static_branch_unlikely(&bpf_stats_enabled_key) && \

Or make this one always_inline function of two lines
and don't bother with a macro.

> +        start > NO_START_TIME) \
> +        __update_prog_stats(prog, start)
>
>  static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 sta=
rt,
>                        struct bpf_tramp_run_ctx *run_ctx)
>
>
> Maybe
> if (start > NO_START_TIME)
> should stay within __update_prog_stats().
>
> pls run a few experiments.

