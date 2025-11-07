Return-Path: <bpf+bounces-73970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1239C410F2
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD641A41A7A
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7F3358C6;
	Fri,  7 Nov 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRN45tTn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07D335095
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537065; cv=none; b=JKmL5Bn+IHZRoQAs0kmNfxBk9/RILx/qb04uO7SG1VVzrmHP94Odvuh36jIAGS6J3YltXaaAncFpih1aRc7JLIuYDzPZP694obn/IRiErxMmBIbTNdxcMnOS6OfktHwYkJ7fPYfHt/r6j+KCwZ89fT+eg6abmv2MHx8ZKmblo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537065; c=relaxed/simple;
	bh=ufIasMXmrbykI1h7RIcJjNYMxgJoIysu+7F6qFsRmBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrP/OixGjmc832aNeGj+JviklHpopXe5rGfKQqonJJ+8lFgBZqVfv8tS4JpL+YPUgh/MnYUSacj3p6Yoz/PiEtg65QOFQDxJZSpcwxq+H19TPvTIPST9Khs2PwG57P6x7wChkINhdtP4vwcq0oVN3U84JgifX+r6AZvmwmaganw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRN45tTn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426fc536b5dso645322f8f.3
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762537062; x=1763141862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHObz/27sv0COJISHz74cJj2IGM7c2IBQU/5nIifxWg=;
        b=DRN45tTn58oaMcU4kyAZFdBAAN5H17FaGvGm7edj/WA+dmxpgwVJHxnggaswS3LUtB
         /T6DtSy53K+wkGgu6iBb5w1gLIiHzOMthfp+to9aPlfvemajkEweJrnO2ZrNoMhjoUsA
         kRaGZ7kavcvw1RMvsbSBvE2M5dDaK3sqTE0aksKcE297E8hoiHxvMX9z+HO8zQpgDdfT
         qY58AS/Cuv9bF7xqLoXO2I0YA/6V5xQsO/IyyJB4CLwHHeYFIY3zNP76GKFMvqT6RwR9
         yMf8+1hTD37abC2PeJjBQPZ9xCQ8HNmaQ9afunDf9zJivLKsIQRbaR36g9AoVYN21RpT
         ioMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762537062; x=1763141862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHObz/27sv0COJISHz74cJj2IGM7c2IBQU/5nIifxWg=;
        b=BOj1AhncUScHM/r230yY1+LHh2z0noLEEpGL/yIYww34lqW7V6fP2n9rWAW1WFNmYh
         uZsELuXbEEGcZ9pJWY5qgsuPf08BHMMGw9lYiVfceaFYAj0hMk3aohi/k2Gjjqq6XiW1
         uWlD7sO/ssl2rWVlujAXChYHKKGCsuKHNsg+YQqnQOw/Fpw4edz4Lvu+gz1LWlNGFZfa
         5K1C4DrXqYiGhAuguX7SUuQqTZtbSlOjvAFbZl1eCDtYcwc4/vAjAp4dm5TVkBJxuSJP
         fbH95LJIUYvdSEGOV4u61F8LjwBaySYPEzqu6LacVC5RbiOWFNmXVaDgZv0Cccjvn+/C
         7+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEf0z3PVcN1Zr3ZU11nvzKq4+ETTJh87A/AaWX0pqqdvx94NPjBkwvcoA5wiopbmn50gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrX1HFcRHeb605Svbx/YupotawTnR9e0Fs/uZ+0n8RLh83hCZD
	KcGNj7huPh4AwXfy6QdZIBqGPKJVjEwMDgatYDoc+dbn/PLAj3S2l6vg4AeHgBiz3yaBwKiVBEC
	Ky19/tcstx0LEf5kuJ2LXyE3+0LKLXps=
X-Gm-Gg: ASbGncv4CJCDkBCUIlFJWHXY1kyIr2KPxnw94slylCq/RBzOVtmDhPjpeva81hoBpqu
	h0NIKbYfWefXD04qhy6/3dNwX0Ji3i8EG2M+2rmo5S/dp9gtb+gmHrTKpyQE04uv+A4sOCfvZcd
	MAQ84R5TjzuL3KD/IEskEDOQS2RcnSZhCUhlwtzjUzyb6VZgDavZZ1gYBvZ6Stw9r+5iGTOxil3
	SK4f8hMQrky+Xcrg418r95iCDx+Ao9X6WumcaK4wY90j563g0jzph9lSdZzjS3T/QMye1f2c7Dw
	OBZ0N+G0t3dkEnrIzbq0+WnwkRfk
X-Google-Smtp-Source: AGHT+IGJ9JVXSNfoFVt0zgc1KaFggpC3AxcNToWkOlY0xNrMkdGAWaJ3AOy9YEsJYQDtSGrGASi28GHO+RGf3ibia2A=
X-Received: by 2002:a05:6000:4008:b0:429:bac1:c7f5 with SMTP id
 ffacd0b85a97d-42ae5ae82c8mr3566390f8f.44.1762537061514; Fri, 07 Nov 2025
 09:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105142319.1139183-1-pmladek@suse.com> <20251105142319.1139183-4-pmladek@suse.com>
 <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com> <aQ3vWIqG31BgE4YD@pathway.suse.cz>
In-Reply-To: <aQ3vWIqG31BgE4YD@pathway.suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Nov 2025 09:37:29 -0800
X-Gm-Features: AWmQ_bkSjVWhwwiyAdu8xQ2wTU8xFFXQd6OpWnFcdI-Hml8q4hACs20Z2y_lQms
Message-ID: <CAADnVQL3q1GYZDWeRyAzz79H2WdW6w=hy+uyUfYABq1RLE-Taw@mail.gmail.com>
Subject: Re: [PATCH 3/6] kallsyms/bpf: Set module buildid in bpf_address_lookup()
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:08=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2025-11-05 18:53:23, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 6:24=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > >
> > > Make bpf_address_lookup() compatible with module_address_lookup()
> > > and clear the pointer to @modbuildid together with @modname.
> > >
> > > It is not strictly needed because __sprint_symbol() reads @modbuildid
> > > only when @modname is set. But better be on the safe side and make
> > > the API more safe.
> > >
> > > Fixes: 9294523e3768 ("module: add printk formats to add module build =
ID to stacktraces")
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > > ---
> > >  include/linux/filter.h | 15 +++++++++++----
> > >  kernel/kallsyms.c      |  4 ++--
> > >  2 files changed, 13 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index f5c859b8131a..b7b95840250a 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned =
long addr);
> > >
> > >  static inline int
> > >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > > -                  unsigned long *off, char **modname, char *sym)
> > > +                  unsigned long *off, char **modname,
> > > +                  const unsigned char **modbuildid, char *sym)
> > >  {
> > >         int ret =3D __bpf_address_lookup(addr, size, off, sym);
> > >
> > > -       if (ret && modname)
> > > -               *modname =3D NULL;
> > > +       if (ret) {
> > > +               if (modname)
> > > +                       *modname =3D NULL;
> > > +               if (modbuildid)
> > > +                       *modbuildid =3D NULL;
> > > +       }
> > > +
> > >         return ret;
> > >  }
> > >
> > > @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_fi=
nd(unsigned long addr)
> > >
> > >  static inline int
> > >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > > -                  unsigned long *off, char **modname, char *sym)
> > > +                  unsigned long *off, char **modname,
> > > +                  const unsigned char **modbuildid, char *sym)
> > >  {
> > >         return 0;
> > >  }
> > > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > > index 9455e3bb07fc..efb12b077220 100644
> > > --- a/kernel/kallsyms.c
> > > +++ b/kernel/kallsyms.c
> > > @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long =
addr,
> > >         ret =3D module_address_lookup(addr, symbolsize, offset,
> > >                                     modname, modbuildid, namebuf);
> > >         if (!ret)
> > > -               ret =3D bpf_address_lookup(addr, symbolsize,
> > > -                                        offset, modname, namebuf);
> > > +               ret =3D bpf_address_lookup(addr, symbolsize, offset,
> > > +                                        modname, modbuildid, namebuf=
);
> >
> > The initial bpf_address_lookup() 8 years ago was trying
> > to copy paste args and style of kallsyms_lookup().
> > It was odd back then. This change is doubling down on the wrong thing.
> > It's really odd to pass a pointer into bpf_address_lookup()
> > so it zero initializes it.
> > bpf ksyms are in the core kernel. They're never in modules.
> > Just call __bpf_address_lookup() here and remove the wrapper.
>
> I agree that it is ugly. It would make sense to initialize the
> pointers in kallsyms_lookup_buildid and call there
> __bpf_address_lookup() variant. Something like:
>
> static int kallsyms_lookup_buildid(unsigned long addr,
>                         unsigned long *symbolsize,
>                         unsigned long *offset, char **modname,
>                         const unsigned char **modbuildid, char *namebuf)
> {
>         int ret;
>
>         if (modname)
>                 *modname =3D NULL;
>         if (modbuildid)
>                 *modbuildid =3D NULL;
>         namebuf[0] =3D 0;
> [...]
>         if (!ret)
>                 ret =3D __bpf_address_lookup(addr, symbolsize, offset, na=
mebuf);
>
> }

Yes. Exactly.

> As a result bpf_address_lookup() won't have any caller.
> And __bpf_address_lookup() would have two callers.

yep

> It would make sense to remove bpf_address_lookup() and
> rename __bpf_address_lookup() to bpf_address_lookup().

yep

> How does that sound?
> Would you prefer to do this in one patch or in two steps, please?

Whichever way is easier. I think it's fine to do it in one go,
though it crosses different subsystems.

