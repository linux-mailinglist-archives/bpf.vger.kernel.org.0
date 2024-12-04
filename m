Return-Path: <bpf+bounces-46089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E19E4100
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A61614C3
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A9214A96;
	Wed,  4 Dec 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs52pY+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA76214A64;
	Wed,  4 Dec 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331681; cv=none; b=pu/FzFEIjiBZhK6NOsfxHCOGww+ZVQllHbcuX0XLH9LAtzgBeYIRt5xLH/C3fqjeE+soM8Nwf6Sznox2uWnZ8gHTC2Cd7Do3OvXCErwLpdJXxXv2WfMMk2TXohaBCc94Inx+k12i47sTQYuq4M/S9kxxHK6NPAzfLsBXPjpqjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331681; c=relaxed/simple;
	bh=6gPE+fenbPtKeQLn3Z+1VggrmVSyTAw3blFgm50DDCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EplQKT8Cu5PexO8dQofS4nrW0t3OZgd4hMI+4K4wv1f+UQwubNQmtVlmldaVHtkigrEXJz/I1iH27xq0ptcWrXW1JgVd/lhoOxRzaPtySYNpeRfWUuwFlrJYxh/40D5QxZ5LOY4zTQEXRXt3Vi44ZHa9HvJsOJEuZ+qPOcRiLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs52pY+U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e87b25f0so726169f8f.0;
        Wed, 04 Dec 2024 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733331678; x=1733936478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0pOXTmAKAV8r7uAQE4p3uR7vbfVoxqeLgjHnVe01Fk=;
        b=Cs52pY+UOQP45ARZHkQLT38LSCfzMfN8xGVN0L+IXSBs+zKfyxd8YJHM+EWnfIXFmO
         1I+pdE4fiZt7dzWawuzQMwd7fi+kIaMVl206aSK0kcfDM2V2k9vG6WwQ+9UriFtB0/xY
         /DPy90Ivg64oLtI01u4Z0ix5r3nx5VMe5ySNzENdHlDhOVH9pnbdPzew8BD8Vsdl3+I2
         OsqOpGj4sM1zAopmhlywmoGwqOy/viQbXRBZCoO4H0nmYX6BjzljdOxAw/pvgUanQ46w
         0BJHlLHeweZzwYSnGb5YHFIw31zZA3tM75zKnYolwyeg0dImflGVVgSW+29cBvXaQwLC
         muiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331678; x=1733936478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0pOXTmAKAV8r7uAQE4p3uR7vbfVoxqeLgjHnVe01Fk=;
        b=EsI44VF/LIqgz8Quw4o/Ih/0w42JlI413ZcdfTNs4OO5+2GgFGDgMtLlJqUR+g+hZm
         g4zoZdqW5cw+y7V9HYWm8fKQb1vrTwbZ4qoy3D47GutJ01KRuc0fxSZM4ftC6svR07nH
         29TPvX36mcSr2THv5uni+WEXQ4fwS2pMOFeZrZpnyKnmlEuNGre3SEOMmE7lxna40pYA
         gcdo3DIhJtaJewdlDtwmCFoMdw5cqShV1HECPg4My7pvbDZ2iYJvGLkz7q8MtbtPvX31
         Ba+osuK4exNr5rhGSmbYF0adEPMiawA7SiPWePIlyiir6R56sG0RayXDqsPq5Sb+5zNs
         FFQw==
X-Forwarded-Encrypted: i=1; AJvYcCVgt0106Abedngm+r9uW75oVMCbpZwKXqfQYRvEX3lxmDm/47RHDXC+k4O9ffUIq/e+Lpg=@vger.kernel.org, AJvYcCX9ZREtb4KP3qL0eJthIZnG0LSFvriGfiomXEMyAAJ0rqwJzx1fD27B1BBLa3etEq0ByCydeGaSmlJbhgZ7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WyzOHlbYZForbch6aipAmzzL5LlEdfAphHVvGAz0V/ADXxD9
	dYGi/b4ydwW78LMXx17+jHlmqzz3V5G2ehBdbB2O7yVexSUIFpUGxURVY7rDbcv7pkXswA2MTOK
	ACrMJ5XaZM7u8FDoJZBRUvLFiTRg=
X-Gm-Gg: ASbGncu3sBJwBefN5tgm2RaKCP1Y2y3fOn8IXPHShxFGWhPmzhleNwNdhQ+65BNIUne
	9jUALgF3Xpt8PEPginUdaCrPzr6GnmXm4Ng==
X-Google-Smtp-Source: AGHT+IH1NBy6bWFZw7pkijVpmV68E0djJQ+VXoqqh5rsAmEl6Cif36GjAkNjEZfz2bgrojCnwjYaLtlxrBeG8uhkMtA=
X-Received: by 2002:a5d:47ad:0:b0:385:e9c0:85d9 with SMTP id
 ffacd0b85a97d-3861bb8936cmr102707f8f.16.1733331676993; Wed, 04 Dec 2024
 09:01:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126005206.3457974-1-andrii@kernel.org> <20241127165848.42331fd7078565c0f4e0a7e9@linux-foundation.org>
 <CAEf4BzZF8Gt_H=7J9SYXGorcjukQAqPJoX-a8vqBFdo73ZnXFA@mail.gmail.com>
In-Reply-To: <CAEf4BzZF8Gt_H=7J9SYXGorcjukQAqPJoX-a8vqBFdo73ZnXFA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Dec 2024 09:01:06 -0800
Message-ID: <CAADnVQKwZqajMd04Fp2CMmNbSAkfSKkUZiBwzoo4Dno1AzX7zQ@mail.gmail.com>
Subject: Re: [PATCH mm/stable] mm: fix vrealloc()'s KASAN poisoning logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, dakr@kernel.org, 
	Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew,

What is the status of this urgent fix ?

vrealloc() is broken with kasan atm.

On Wed, Nov 27, 2024 at 10:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 27, 2024 at 4:58=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Mon, 25 Nov 2024 16:52:06 -0800 Andrii Nakryiko <andrii@kernel.org> =
wrote:
> >
> > > When vrealloc() reuses already allocated vmap_area, we need to
> > > re-annotate poisoned and unpoisoned portions of underlying memory
> > > according to the new size.
> >
> > What are the consequences of this oversight?
> >
> > When fixing a flaw, please always remember to describe the visible
> > effects of that flaw.
> >
>
> See [0] for false KASAN splat. I should have left a link to that, sorry.
>
>   [0] https://lore.kernel.org/bpf/67450f9b.050a0220.21d33d.0004.GAE@googl=
e.com/
>
> > > Note, hard-coding KASAN_VMALLOC_PROT_NORMAL might not be exactly
> > > correct, but KASAN flag logic is pretty involved and spread out
> > > throughout __vmalloc_node_range_noprof(), so I'm using the bare minim=
um
> > > flag here and leaving the rest to mm people to refactor this logic an=
d
> > > reuse it here.
> > >
> > > Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")
> >
> > Because a cc:stable might be appropriate here.  But without knowing the
> > effects, it's hard to determine this.
>
> This is KASAN-related, so the effect is a KASAN mis-reporting issue
> where there is none.
>
> >
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -4093,7 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t siz=
e, gfp_t flags)
> > >               /* Zero out spare memory. */
> > >               if (want_init_on_alloc(flags))
> > >                       memset((void *)p + size, 0, old_size - size);
> > > -
> > > +             kasan_poison_vmalloc(p + size, old_size - size);
> > > +             kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORM=
AL);
> > >               return (void *)p;
> > >       }
> > >
> >

