Return-Path: <bpf+bounces-45143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B39D1FF6
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 07:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58959B2151F
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 06:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33161534FB;
	Tue, 19 Nov 2024 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqL/X1vt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95A2A1B2;
	Tue, 19 Nov 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996425; cv=none; b=hZaj2O7jutVLxSrLv8VmtngVc2Q/ndDJYUHHJtcjBtu4cUolUCVao3mBR56JKnDA//WPVCDn0Vg+kTaknTV2PNXjN9wvHoxHF0ZURQdpbKNUq5sc/C/qTigVmc/yyabug7d2fRU8yL0Qgs/wDVNZZErfQM9zw3vA3Ldz5Yffrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996425; c=relaxed/simple;
	bh=kSn5hT/36oDDOOMjJ7TG9vM8Uzf66e0X2QvRIUOn5OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhLvmdum1J9+UE7nhsDnW2lJo+WMpA7RZRfxkG1iiloHyhTL3cFv8FLrlSS32O6t2/e/nuzoBCXuM6T3AGFWSuVnTprXh7ZqF4Lr/sSADM7ZSu/yhPbmapGjgywHvEgXizhQ7Uhp68OWkttE8OnKqh/ZFR8cYIlFzrj0EnH7Dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqL/X1vt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cb7139d9dso4892815ad.1;
        Mon, 18 Nov 2024 22:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731996423; x=1732601223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOl713F9bWIPDqTcKla/qAdbz1UXp39S0aAzrV9TNpU=;
        b=GqL/X1vto2CnGFb7DQH9Gg9GzwN4a6Cno/RdvwtMDFddzYApNjxej4fuScCB+1ozx1
         M+IsWh+G02hZMVaJhBUiqIreHBVKACI163dAzclQumYM9jDPEl5mMrrJmf8p/ofLFoj5
         89nIg64GmuhEOBwsUOWMsJSzEaHOFzdCeD4x9JTNo1REWJn565TtoigHfknid9YzenOR
         IIFPbcNKDMNDZuqSli0dslIw43K4W4sm5cF6z1aHfuNu65D5MBgwIEp/dEUye8e8aCbp
         +vvYiSpEE4F72NdpPZ1xTPuuWWJcAAKt6wN88JY0ur3AiegKLPv/IahPfeAQpAGoXz1j
         ctTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731996423; x=1732601223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOl713F9bWIPDqTcKla/qAdbz1UXp39S0aAzrV9TNpU=;
        b=Czb3kBlCVTGcLUndIxdMvOlQ0QWyn4GFWLHELa5CsNgWLFaxioeNK8oa5tH4SKPJMq
         +BL6QTPdU8m2FIaJ3QSeiaMvO9qHwQa2UYrnfYrlmBJ9hVgOMi1o3QPuEqnKxHVc2bUi
         aKb0Pbn3HbHcR9F7L6MxgIEfRRgYvkIGZp+5c3mFARpmH4vuoT/ue5tBEcfv9M4TMAN2
         AM9nZYGoG/17UcqoPsTTPRkwVACp0sPgPWg71UmlgW9aq7pnt2Flu5zn7w2+FQhyCA+y
         GRueQpjwf0oDLz+T96uxeB+rvPtKQ9oPXgTkoJKIAbj6a0MXU0TgN5sMZIte28t8piLl
         CDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcjC+8YFYCrjswSJn09LUobuQh6tUgq92pl1xd+5hhtEHDsEUkRDBg6famqAMq9cmuxXc=@vger.kernel.org, AJvYcCW9nnqWsboU/9G84LzMhROvoEV/NdkGN9pQ+w/rHC6LudcSKPUDEFbr3Kb96kQ2FLbEAmSfWODWzPkInzeE@vger.kernel.org, AJvYcCX6ZTfmPR7D2Cc0Co9cHKHwjP0x8SHgxvcg46JI5lqxnQYUi8nleCifo8kABnj0mQ0qLp+Oy6BjbPXL//Qsmuzlub0Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5t+qkXnPGp/ih5ghFwKkxn2MB9+/pwzptZOCz0v/g32ovzMT
	wNwHCBFkZCuGTW9WUU0vA/W8AzTBght4+gaitMaUo+aWmocS0wnY4zXI424bSCDCxD8tzLH9yzl
	gr4iofoeR++LeEIBx4EuHBktl79w=
X-Google-Smtp-Source: AGHT+IFGaAlEWBDn2mPuLgPDdWeVW+qCmdjYZnkUxtySofjU+ljzQ0ZymdcEf5Trp8imtYn3Nv3JPucYh70S1eRIYl0=
X-Received: by 2002:a17:90b:4f82:b0:2ea:a737:60a2 with SMTP id
 98e67ed59e1d1-2eaa73795a4mr3116350a91.13.1731996422991; Mon, 18 Nov 2024
 22:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net> <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com> <ZzkSKQSrbffwOFvd@krava>
In-Reply-To: <ZzkSKQSrbffwOFvd@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Nov 2024 22:06:51 -0800
Message-ID: <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 1:44=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Nov 14, 2024 at 03:44:12PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 5, 2024 at 8:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Tue, Nov 05, 2024 at 03:23:27PM +0100, Peter Zijlstra wrote:
> > > > On Tue, Nov 05, 2024 at 02:33:59PM +0100, Jiri Olsa wrote:
> > > > > Adding interface to add special mapping for user space page that =
will be
> > > > > used as place holder for uprobe trampoline in following changes.
> > > > >
> > > > > The get_tramp_area(vaddr) function either finds 'callable' page o=
r create
> > > > > new one.  The 'callable' means it's reachable by call instruction=
 (from
> > > > > vaddr argument) and is decided by each arch via new arch_uprobe_i=
s_callable
> > > > > function.
> > > > >
> > > > > The put_tramp_area function either drops refcount or destroys the=
 special
> > > > > mapping and all the maps are clean up when the process goes down.
> > > >
> > > > In another thread somewhere, Andrii mentioned that Meta has executa=
bles
> > > > with more than 4G of .text. This isn't going to work for them, is i=
t?
> > > >
> > >
> > > not if you can't reach the trampoline from the probed address
> >
> > That specific example was about 1.5GB (though we might have bigger
> > .text, I didn't do exhaustive research). As Jiri said, this would be
> > best effort trying to find closest free mapping to stay within +/-2GB
> > offset. If that fails, we always would be falling back to slower
> > int3-based uprobing, yep.
> >
> > Jiri, we could also have an option to support 64-bit call, right? We'd
> > need nop9 for that, but it's an option as well to future-proofing this
> > approach, no?
>
> hm, I don't think there's call with relative 64bit offset

why do you need a relative, when you have 64 bits? ;) there is a call
to absolute address, no?

>
> there's indirect call through register or address.. but I think we would
> fit in nop10 with the indirect call through address
>
> >
> > Also, can we somehow use fs/gs-based indirect calls/jumps somehow to
> > have a guarantee that offset is always small (<2GB away relative to
> > the base stored in fs/gs). Not sure if this is feasible, but I thought
> > it would be good to bring this up just to make sure it doesn't work.
> >
> > If segment based absolute call is somehow feasible, we can probably
> > simplify a bunch of stuff by allocating it eagerly, once, and
> > somewhere high up next to VDSO (or maybe even put it into VDSO, don't
> > now).
>
> yes, that would be convenient
>
> jirka
>
> >
> > Anyways, let's brainstorm if there are any clever alternatives here.
> >
> >
> > >
> > > jirka

