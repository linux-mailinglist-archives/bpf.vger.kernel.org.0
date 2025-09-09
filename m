Return-Path: <bpf+bounces-67881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5BB500E9
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0243D7AA96A
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5B1350847;
	Tue,  9 Sep 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0hfksql"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D6246788;
	Tue,  9 Sep 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431228; cv=none; b=lShkhaXfIKTAm92bwM8A5UlcarXI74+kZkwTS0Mw5o7qSosVDpWOiWllGecJngv+BONgv1ahTRb2wqfCvg5sLh3GBpdA8Ub36SR5XWyth/OF87Q9wDek7lfDML4EvxJ+YgN6yIO5bboRgR12m0qsSnux3jWCDnORCRtWIIdFl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431228; c=relaxed/simple;
	bh=24MEWkpDU+oPsVLsFh/DCdvIvAifluDEpWqU6cVm6uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8IgQ2C6GS0qYOiXw39l4fywbhs207oaEVSbgwPXtI9DITeotxpw9gn/VQFW83Klg+QEQmjydhlCKL1/ugWAN82dTLuOGTuvGo7cYJx9VBbQDTXL0cnh2ySGLvgvFj+CND0SjJO2zTJioiJnE84Vl2R3Yf7GHrKo6m56gpw9I8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0hfksql; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772481b2329so5951731b3a.2;
        Tue, 09 Sep 2025 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757431227; x=1758036027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLHe+egzyj71r6iVZkeqWuv/uV5QzYXqi8KlStEJB/s=;
        b=H0hfksqlot5u/jKfDrdCsTC4sIKt/zb20BsLETL1lh3Xpt1bo3ou06vwX3t0zwqeqZ
         MiGC7TPPCNAKSQABAm2+R+nV2CNW8l6wWy1h44/CZmGKB/lV3uiR/eh/9dnHiB3dW5Sd
         qiZ+5bpFLdbiWn0yC9grogPxX2mLXfMZsPYz01SCZWd1SXoodaPbSdyqoOl/UUDqu8Zw
         EPhRoXlDhewwNMdSQFl7biQ7NGlYE0QIaUejqFfEI+mqoLe/CDEJ5DKM7vk9zMTErJjs
         k8J0Pvs7VT8RU3LVWCT9e9xY2JMkakCZNh1YgltqhhIcTnpUlthiruofGObFocEy9b8i
         JYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431227; x=1758036027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLHe+egzyj71r6iVZkeqWuv/uV5QzYXqi8KlStEJB/s=;
        b=cDO9zNvouGgt9yTpy6pu8uBsj4aod+fdiLwDEGNCf88It+gbb4I8KmQmvsqpHE4/vc
         3aqxy/W6Pu+M2WYf3ACGw5zbqiohWP2RtBRiSa01pWzhWI1pVD9WuWfuTi9RfJnyFoD+
         n/kLdzBMDLZ1AnvBCmvTVvA0m2plYNYXYixbKQnImhDu12g/FGDjcI6bQ+f85+En/zgh
         GSsr4yrC8XgFyI2EWCCBEqvA5eYYSf8V1bSCv1uB/fvPLlL+ULF6Ve6Km4u5yyso/VO3
         d6Lh0uCxEx46nPxGc4d5NvCUFk2D8OQI+coTDsG7tgaUbrYFar0V3tIf4+a3l7VhIeLN
         Or1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJpBGob1WhjM7y0oknsYZQ+vZzzUqv9tDbOxyPLv/FSoHsK3xafatWDwVnnr2ZMb4Gahw0qKSXffS8VIMCrXdeRnYa@vger.kernel.org, AJvYcCVC/WNNw5g333M2JheBYtDk0M7zzbFhQrFnhnlj37iwiPjDtD6xDcJOInmZxzQtj8Gi3aY=@vger.kernel.org, AJvYcCVuY693xXOl+6/CVcyPLjEddv6O7zVmikFG7+Rke3ZHW6+1pqdmumTiqKlGn0GsX6HlgnL4+YM9tPw6x6Vy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yF+G4usrXkastG1LjDt0+K+nttfT7oSxxHy+JexfDygxIZaV
	3wChxxEe9tWT/ydEQYrvhqDe8zLaP4SWENTA62N9h3RQlCBF/J1Q1UWGMhJ1H6oPpsMwLFv17dg
	nQW2XGXBp7g7cRsTgkHyKc2RLHUabERk=
X-Gm-Gg: ASbGnctdMyv+dRznwaNdiSZAO6zltIuodgnf72t2yQ7VTEub8of5LKiDjPfZwtrlHh0
	RcrHUt6qGfauf2BEiGAU3FeD0VtFIC97YXOhEdT5RmWoYk5Qyn8jmIJ9fyRomw5MVe3VHVDBvo5
	8S+ZteEmdcdntQQzWnwN4KLoTSOsrf6Ji9Hw8kpUhA0qy9w19viHb6XAY8O8X+PJtsYpPQy2Sle
	aYP5T9Py5Q4mSzRNsepOlg=
X-Google-Smtp-Source: AGHT+IHg4JXF1EvCqzPzzXH4bT9W+XFU3eS3rEjSI4kSq0X630Rt8af52WqrdvC1S3yakfX5aw1JR0xXrGCjfGy4yWw=
X-Received: by 2002:a05:6a20:3c8f:b0:248:f4c3:b31e with SMTP id
 adf61e73a8af0-2534441f670mr19093658637.33.1757431226633; Tue, 09 Sep 2025
 08:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821122822.671515652@infradead.org> <aKcqm023mYJ5Gv2l@krava>
 <aKgtaXHtQvJ0nm_b@krava> <CAEf4BzYg9jsEK1XdKW4dKFdOSrY4CAspaCAAv6ZJZScHxkHSyA@mail.gmail.com>
 <aMAiMrLlfmG9FbQ3@krava>
In-Reply-To: <aMAiMrLlfmG9FbQ3@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Sep 2025 11:20:13 -0400
X-Gm-Features: Ac12FXzAifWnHsDNUsovzlMLCf6odlC_hVRrnGq8pMR5gysK-J62aUi7y_H-z10
Message-ID: <CAEf4BzZnvWH-X-7qKvx2LxzR+xkFfvjj27Tfjoui5xnph-urMw@mail.gmail.com>
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org, 
	eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, haoluo@google.com, rostedt@goodmis.org, 
	alan.maguire@oracle.com, David.Laight@aculab.com, thomas@t-8ch.de, 
	mingo@kernel.org, rick.p.edgecombe@intel.com, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:48=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Aug 22, 2025 at 11:05:59AM -0700, Andrii Nakryiko wrote:
> > On Fri, Aug 22, 2025 at 1:42=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Aug 21, 2025 at 04:18:03PM +0200, Jiri Olsa wrote:
> > > > On Thu, Aug 21, 2025 at 02:28:22PM +0200, Peter Zijlstra wrote:
> > > > > Hi,
> > > > >
> > > > > These are cleanups and fixes that I applied on top of Jiri's patc=
hes:
> > > > >
> > > > >   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.=
org
> > > > >
> > > > > The combined lot sits in:
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git =
perf/core
> > > > >
> > > > > Jiri was going to send me some selftest updates that might mean r=
ebasing that
> > > > > tree, but we'll see. If this all works we'll land it in -tip.
> > > > >
> > > >
> > > > hi,
> > > > sent the selftest fix in here:
> > > >   https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kernel.o=
rg/T/#u
> > >
> > > Andrii,
> > > do we want any special logistic for the bpf/selftest changes or it co=
uld
> > > go through the tip tree?
> >
> > let's route selftest changes through tip together with the rest of
> > uprobe changes, it's unlikely to conflict
>
> fyi, there's conflict now between tip/perf/core and bpf-next/master
> in the selftests.. due to usdt SIB argument support changes
>
> please let me know if you need any help in resolving that

so selftest change hasn't landed in tip/perf/core just yet, is that
right? If there is a conflict, I guess that changes equation a bit.
I'd land it in bpf-next and for now disable that test in BPF CI until
the trees converge. WDYT?

>
> jirka

