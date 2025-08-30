Return-Path: <bpf+bounces-67050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD58B3C64C
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 02:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2287BE83F
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49D43AA4;
	Sat, 30 Aug 2025 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDGbv+GK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CAD191;
	Sat, 30 Aug 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513695; cv=none; b=K95etvpfBKux5SD7K21fkEfH4Jta9MkM4lvbMhumlLSV9ZSqF28ccvDa+3Ba/889bttI0EbDVJa6fheN1CNkYz2loyIRWlGF6XIeqr/+x9Omwc5uNGEABywS5l4aidqI/vgZV5sFBB7JDgJgQ0Yt1g5FfAVL9M9IbeQiveTo89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513695; c=relaxed/simple;
	bh=ZvK4bYA3r8mTlanGVlu/JYxp/7dderxUPye0iM8shsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa3dazD3XsdkDacbdNzCz+onUb2Wix+684bY9PWVSrcy+4n99jd+gf3ql31hnJiOyrWq9Z6EfoA6fQrmJsyrOBjteOgh048q3Tg6bMdM3b5k6yLKqY9B7dag9UiFYlJtqssyEseA2WTiB1HUH/oM43QFki9IdnwV1qLZyDaSd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDGbv+GK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3cf991e8bb8so780483f8f.2;
        Fri, 29 Aug 2025 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756513692; x=1757118492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrhIVs/dJPUCsFAm8+oJ7qqPTnO0H735wh0Jw8oqxj8=;
        b=EDGbv+GKKQsLV0uJWS9E96RLANMVo5nFTCOYefs8WP+Wph6JOBDNqqpWG6s/klSkCt
         TZZTjoMXuAXUwtczYYYC1OD+UieSiYhazFIw3aPCOpDCmd8/CBfLf5jL3t1bdN0TPhC7
         XmSIp52ww3COt9gE6+TMwhOPGWA0/hdp1sQJm2VEww2lvuKVW1ZuKSi9F8/TF3Ad2Rqb
         fdet3pOlY5BsQ1BJ7/cASeNF/opDRDtzqlfvwqxM2tfYwzCIg44bj4JUzEoyWjjjJXIg
         Ua7D8r7V0p27/4yPtPmfHUAetU0IpIg/mmZ6NdOhpA8SzfK+n4eJLOXaenGH3Y2xMSV+
         gMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513692; x=1757118492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrhIVs/dJPUCsFAm8+oJ7qqPTnO0H735wh0Jw8oqxj8=;
        b=e3uBGAe8SymAimt/w+mb1GxAk5pH5V/6WDLetQj4zLu1H+egA1oIz3NbgO6JaFbuNn
         wU2qG7muS4QQzfqoLQlPohfP465WnDG1o6FfrrIa1jHoGsBe+jUcdKrNpsCCfdyZOtVi
         Fy67vGl5S60M5lT1ySalsgGahpya3LgDoDlDitWZnDjcaYaK2bCjSNUkjjfiR2lELYEa
         7gKKMjpQNt9stXe+jFNdVYU0NCfuTRQy+jAMGgTt9Ze/FJKiSWw8T4duB9Y+PwRwGZQo
         FOac7hTEnDqbIwfejjEHvtIVwOjyjfDDPjbK95xWYsvz28/Y51p0NlIwo1d2vepdMQwA
         bcJg==
X-Forwarded-Encrypted: i=1; AJvYcCUDtedRBA49h88Zp/+FiKlaUvYWXUW5F72jiuEcVvKrCr5fQz4nnzzthMGvhMQ72XFM2l0=@vger.kernel.org, AJvYcCUjyKRSy2xGQGQ8mfKHpMCO0v8TJafKMwDmoOYdqMGMUInS+fRDo+WAUlaHJbZ/3oKcFL6ULU4l/qklmkQA@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBP6kYk//8/wavx/Egq56QHK1xbp2wGY0qHv6OQpzUaEnnKFY
	uwnEvvV2EWnrDrmr52tkAYG9rEOoIf3rVlajegCu/Kqp+iUJ1tmBo9dWvYddtiougGZIRdhHtMM
	sHs+YTzx5qCfcemCZN6tNyclt05YpJzo=
X-Gm-Gg: ASbGnctV21bHEPKr3Tt6CAvFdmyUdI+vDZ7vImMyci+qQQv7AhZaorH5bGRjfNVnDK+
	6jzU8M1vBUF2RKEHWnSiux3GPAUbroKkBN2VBvlIITAe7bdWhRMDBabkcDcxy9Div7VOEbJf2F4
	2r52gn3TeWc/29IrQJBy9znpiZxyqBTf9oOXW/zB4N+uiiTN+WcrohVPtohI5i8fVdyWPOjFmeL
	3aYBxAj3Wl1K+wnfbKwp9493zCUcFflfmp+Agig4Mx7rWY=
X-Google-Smtp-Source: AGHT+IHLLfxZUg/Gr9rEauyIEDuTh+gBYRyOxVzgA0NvK1AU6IZrp6Wg6fE87yy64L9t+WHZ8+W2dtWCcrNFNJ9w57w=
X-Received: by 2002:a05:6000:2509:b0:3c8:ed45:497 with SMTP id
 ffacd0b85a97d-3d1dea8cfd0mr216623f8f.47.1756513692178; Fri, 29 Aug 2025
 17:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826212229.143230-1-contact@arnaud-lcm.com>
 <20250826212352.143299-1-contact@arnaud-lcm.com> <CAADnVQ+6bV3h3i-A1LHbEk=nY_PMx69BiogWjf5GtGaLxWSQVg@mail.gmail.com>
 <CAPhsuW5P4sOHmMCmVTZw2vfuz7Rny-xkhuPkRBitfoATQkm=eA@mail.gmail.com>
In-Reply-To: <CAPhsuW5P4sOHmMCmVTZw2vfuz7Rny-xkhuPkRBitfoATQkm=eA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Aug 2025 17:28:01 -0700
X-Gm-Features: Ac12FXz6kWOcxspa5bslzCZuaIzwRt9668IkCzqmvaW4DsWio--34nodGGwXtHs
Message-ID: <CAADnVQK=3xigzt-pCat5OF29xT_F7-5rXDOMG+_FLSS0jRoWsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: fix stackmap overflow check in __bpf_get_stackid()
To: Song Liu <song@kernel.org>
Cc: Arnaud Lecomte <contact@arnaud-lcm.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 11:50=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Fri, Aug 29, 2025 at 10:29=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
> > >
> > >  static long __bpf_get_stackid(struct bpf_map *map,
> > > -                             struct perf_callchain_entry *trace, u64=
 flags)
> > > +                             struct perf_callchain_entry *trace, u64=
 flags, u32 max_depth)
> > >  {
> > >         struct bpf_stack_map *smap =3D container_of(map, struct bpf_s=
tack_map, map);
> > >         struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> > > @@ -263,6 +263,8 @@ static long __bpf_get_stackid(struct bpf_map *map=
,
> > >
> > >         trace_nr =3D trace->nr - skip;
> > >         trace_len =3D trace_nr * sizeof(u64);
> > > +       trace_nr =3D min(trace_nr, max_depth - skip);
> > > +
> >
> > The patch might have fixed this particular syzbot repro
> > with OOB in stackmap-with-buildid case,
> > but above two line looks wrong.
> > trace_len is computed before being capped by max_depth.
> > So non-buildid case below is using
> > memcpy(new_bucket->data, ips, trace_len);
> >
> > so OOB is still there?
>
> +1 for this observation.
>
> We are calling __bpf_get_stackid() from two functions: bpf_get_stackid
> and bpf_get_stackid_pe. The check against max_depth is only needed
> from bpf_get_stackid_pe, so it is better to just check here.

Good point.

> I have got the following on top of patch 1/2. This makes more sense to
> me.
>
> PS: The following also includes some clean up in __bpf_get_stack.
> I include those because it also uses stack_map_calculate_max_depth.
>
> Does this look better?

yeah. It's certainly cleaner to avoid adding extra arg to
__bpf_get_stackid()

