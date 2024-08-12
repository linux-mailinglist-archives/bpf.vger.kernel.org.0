Return-Path: <bpf+bounces-36897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD8494F18D
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BE51C220B5
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4B184522;
	Mon, 12 Aug 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iErFR8Wx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164B183CB4;
	Mon, 12 Aug 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476172; cv=none; b=N/IwmZ3mMeuX8cwikALv+F7llCg6tBXMZQpcNQKCcba1FaGUKBpygtZDH36fFD0FRsA1lzNUVAtOL0UB3M2+QlU7TJso7yvDRzcasJhL0vPP4tOrfPIPtauN0Seie92jPe2z1Hum3UYJwhzJX2wReWwGZ2o52I0yd23F2AsnPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476172; c=relaxed/simple;
	bh=qpEUS3rYpbENzBlOxYTw3kKabVJQQCAW1JuPdQCxAng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCoKV5940LKusLot1OEoz6C7GWbvOylbgxoch3X5TDIsu2vmH8tmMRQVPnESMD0HxmsEMMJiwqQF1zX19n2FmTccgbKpMtYlLFedIj/fFBRFkmjOnIr4MDz6Jz0yqf+PlCz6EZM74kzyXVpSk7z0ys/6H26DYlC00PbYcKCEbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iErFR8Wx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2590982a12.2;
        Mon, 12 Aug 2024 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476170; x=1724080970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpZ18i+l3ZklnBKOQpiJoYi+QXkzGYaSATzzcHWTrOQ=;
        b=iErFR8Wx2xwquzphdV5/+GVA1NsWMX0iNPnVfAbUV+P8HvbhXX9nZS/FYr4SwRjlWq
         yR3zblQpjnmmgxjLIhEPyJLovNeEmC2AEG+KIYm67BwyoP9nNsoVUAvd+tERck2ErKIs
         M95iYbmMJN8OxJjCPS7+AH7PR07oKbD/lkda4cNHPZYDRgtXnp+6jhYssmnx2QaZ0PGx
         7bMqHvCoJuJS1nUAlsUg5rihKETToC3dc6VnQC9RSU3XUfcA9O9FnjR5SaR8uhyYYn3Q
         AMLpSLL8pMMT936A7X+BZhSHwuNhYaSYjK0x4PJtwMyzwN5ewtTImDhSKbxZ7wap1uw+
         GIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476170; x=1724080970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpZ18i+l3ZklnBKOQpiJoYi+QXkzGYaSATzzcHWTrOQ=;
        b=aSNFc1CJB5U6+HZO+r01P0PaEyYin1ULeQONLZ1kxoYgBqIAzdq/S7eVu3k3rLBLBB
         gKvQ8UhynGKXpbZQOzFtYupqWypgKLclcrcpb+BS0IKcx7bR79AjYyIgMyIiwkLgWHFY
         H8BmrHwgQguAWAZhkidkfS0kTi1zRCAeiNyLQzDP3+ExdSfFx8Ah/Vh4ZKfGYgd8XNai
         i81gHceQ+MBiLQ+85eo1w9Ul9bdpC8Tm1SZqWyDWp/heC+y+eiyEeuimPlQGmBtuPSe+
         raHYVexMhdvNkKcPaZUikxcgjJ2vXleq7kiZUDFMbgwbPmbP6/D/X+nAzhBYYlBxmw4Q
         cnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy+hDhMD/fE4Faqcu5YZKzaWRudWTae/g9nQ0Pts76mSyop6S4TXKU+LwHR+HVSIXZ1Gf+rtiiRLUte+zo3eM1MlXH9C10YtN55jkih62yaxcVo+GRC8fiKfwq/vHY6PHcUoojlq1NDGe2uDWs8rACF98fJ+DddbacsO6kcvTJf3EOTYqlLFQk80LptZ07UR96+3K1vTIZ6VN7g/KEQ2MYapD6VQyXBw==
X-Gm-Message-State: AOJu0YydfWMW9N4iDC0MiBz8setgJCrE7o2hlNtxcPpgjoVR+F83uhbQ
	c2RdFONpAoagaUIxECpGByyrouFsCGH+ZwKaOGNlYVvTdJ9UqMBxAGY1z/EDenFSI1irZTh2GYU
	a5Jsiov9PhHyTbujYOIac6sI05gI=
X-Google-Smtp-Source: AGHT+IHnFJyV11a3EU8J8N3K1x1M16K/y4cKmqEh2p++7UG3C19tPYQT99trjEzXWSi0Zkhm9/1S8wZ1G2i0SavJEA8=
X-Received: by 2002:a17:90a:d90d:b0:2c9:8189:7b4f with SMTP id
 98e67ed59e1d1-2d39264bf9emr567114a91.32.1723476169915; Mon, 12 Aug 2024
 08:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000382d39061f59f2dd@google.com> <20240811121444.GA30068@redhat.com>
 <20240811123504.GB30068@redhat.com> <CAEf4Bza8Ptd4eLfhqci2OVgGQZYrFC-bn-250ErFPcsKzQoRXA@mail.gmail.com>
 <20240812100028.GA11656@redhat.com>
In-Reply-To: <20240812100028.GA11656@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 08:22:37 -0700
Message-ID: <CAEf4BzZ6coCZHY_KMnSQQUyc_-xziKurOQ0j3xaCvHhnDaafuQ@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, jolsa@kernel.org, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

adding bpf ML, given it's bpf's code base

On Mon, Aug 12, 2024 at 3:00=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/11, Andrii Nakryiko wrote:
> >
> > On Sun, Aug 11, 2024 at 5:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > Something like below on top of perf/core. But I don't like the usage =
of
> > > "i" in the +error_unregister path...
> > >
> >
> > Wouldn't the below be cleaner?
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index cd098846e251..3ca65454f888 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3491,8 +3491,10 @@ int bpf_uprobe_multi_link_attach(const union
> > bpf_attr *attr, struct bpf_prog *pr
> >         }
> >
> >         err =3D bpf_link_prime(&link->link, &link_primer);
> > -       if (err)
> > +       if (err) {
> > +               bpf_uprobe_unregister(&path, uprobes, cnt);
>
> I disagree. This code already uses the "goto error_xxx" pattern, why

Well, if you have strong preferences, so be it (it's too trivial code
to argue about). We do have quite a lot of "hybrid" error handling
code that combines undoing the last step (especially if it's a simple
function call) and then doing goto for the rest of common error
handling, so I didn't (and still don't) see any problem with that.

> duplicate bpf_uprobe_unregister() ? What if another "can fail" code
> comes between register and bpf_link_prime() ?
>
> See the patch below, on top of perf/core.
>
> > We should probably route this through the bpf tree, I don't think it
> > will conflict with your changes, right?
>
> It will conflict, and in this sense it is even worse than the "#syz test"
> patch I sent in https://lore.kernel.org/all/20240811125816.GC30068@redhat=
.com/
>
> Because with your version above the necessary change
>
>         -       bpf_uprobe_unregister(&path, uprobes, cnt);
>         +       bpf_uprobe_unregister(uprobes, cnt);
>
> won't be noticed during the merge, I guess.
>

Yeah, my bad, I forgot that the signature of bpf_uprobe_unregister()
also changed with your patches.

> So can we route this fix through the perf/core ? I'll add "cc: stable",
> in the next merge window the Greg's scripts will report the "FAILED"
> status of the -stable patch, I'll send the trivial backport in reply.

Yep, absolutely, given the bpf_uprobe_unregister() change, I don't see
any problem for it to go together with your refactorings.

For the fix:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> No?
>
> Oleg.
> ---
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4e391daafa64..90cd30e9723e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3484,17 +3484,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>                                                     &uprobes[i].consumer)=
;
>                 if (IS_ERR(uprobes[i].uprobe)) {
>                         err =3D PTR_ERR(uprobes[i].uprobe);
> -                       bpf_uprobe_unregister(uprobes, i);
> -                       goto error_free;
> +                       link->cnt =3D i;
> +                       goto error_unregister;
>                 }
>         }
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
>         if (err)
> -               goto error_free;
> +               goto error_unregister;
>
>         return bpf_link_settle(&link_primer);
>
> +error_unregister:
> +       bpf_uprobe_unregister(uprobes, link->cnt);
> +
>  error_free:
>         kvfree(uprobes);
>         kfree(link);
>

