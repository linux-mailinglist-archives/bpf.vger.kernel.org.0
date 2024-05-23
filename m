Return-Path: <bpf+bounces-30404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E88CD87A
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 18:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B032824BD
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA111BC39;
	Thu, 23 May 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MblfHEwQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997411720;
	Thu, 23 May 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482080; cv=none; b=Adqyu749NtI8j4tos49KBFTrctfMK0zDhLRc50Qio4SLvzl8tf9LJlXklIMFUjamIcgwBZKRyDCB2WKYJXlXXg+kdlhWFMOcJN6KmL6vgy427MEb8tdJJc4rw++cgoS/fVxyyXh9khQMqcz8unFz9QMLf/FpvF2kkHB6YU8/XhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482080; c=relaxed/simple;
	bh=L78QcW1WN+AWEud7mRm7LZni1MC/yOU7IM66UMmp1TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tS+xsTX1wyoQowveLXdLHqgOkSVsjkPnTwbgwPp+SrGkh3regIzjBBaKapnhtuQAQmyfm5s+w6riQTlj4g0aYlut0uMYmf1T2mZWwupqpjUc3If/1VzhuFKDLuAxyZF71ffqBSShGDfGGCkVHs18oBMPf1i+SaPgjP36maAkZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MblfHEwQ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df4ea041bd7so1918408276.2;
        Thu, 23 May 2024 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716482078; x=1717086878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF564b7ceuJtJUxskBv60/ls7oKCNIrLuMPsIluNfCk=;
        b=MblfHEwQ76SIJUIQ7PVoLN/BWIYKOPutHZVSe8i1M5+S8TbOmsh4t0eph6ECzKWijW
         fy3boPxPv3+/whLoeWXZxkB82SMs9vPi9YxmUMAtSwjI7Ca8RGVhzMjClQnIGOy35RDQ
         R/wIBxs1nhREJ+3BVNWMi55lHBK/semTRBXWReEfdWuJ3CXrQzb0m14RiTq5+Egq6ZPP
         bP5chayeBV+FvW7eKQTba22JMAOAuNNnKTHoZZr+rKzhFG7GkGaKH2UBWxuOduekw8HO
         WPTt89QndswvlNTXYgax4+o+WG0NCvjFX/KqBzQZS8qe/WXloLyW5Axd/iilnC5bAct6
         /j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482078; x=1717086878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF564b7ceuJtJUxskBv60/ls7oKCNIrLuMPsIluNfCk=;
        b=AAwlUxkOTjVvtId8cnWdC33Js0yDAhBT3HsMBwy79ZCcDFDohcapZcYksDTwPP9k8f
         ATmvqmdRBsl1MLtkLlzYVkmqeS6sxJ/XTh5ixjdCW8O4Fn+aQ9ueQxG0zbxRA63CyX9h
         hBHQZCTNNEAeXgjvuTdGeeBWujBWWxrX3i5sbVrmIa9XVU/uJUyBA4H7UQHm7eiuQGwe
         Md0r7xrdOPwCuOBOssrOMA+cs1C2HV8DIpDlzs9q3Q8fIS+3xtk9CzqMwYxCtt0ZGQA8
         VIUzj5a9YkJyKigM9BLfiPdmuTMvkQBDbT2+fijbJMiw76TKfHvXZqqCGPq2Z/vQlcMk
         bokA==
X-Forwarded-Encrypted: i=1; AJvYcCX0UI26IKG/Yaps6YAp+XvZvxZsQXTmtNXqe6zEQt7udy7oYTQQKwdNkaT6wsp307nKJtk5AEi7AYLzAqYSZ3kvwK7nbPvQUzadFrt8p/VctKVpffFKQ5WwEaV2YaBkVHRozSPZ0+14Z0SBOMVqu/kO3+Keg5wyxVMqOvQlSVIbMT2PtQ==
X-Gm-Message-State: AOJu0Yy6XL6fyPMRu2yoXzNCVxdxGoeUr48neyETGADxRjKlzBumSJGc
	N6MUZBljm53bmXqUcPOkcan+DbH2i0IlxxwVNR/dxbM5gTIHtafSVgpbYn9UcWlSY29WqjZgFG+
	eu45fAeUgYzOlU7Dp+MLAOqHscNY=
X-Google-Smtp-Source: AGHT+IGHMycQCXAXdn9GPA0HqIe63sdLvbaqaA8StclYtMKe9+LaaPGxeDpnBD2iYljhDYWbHNS1PnIpcZzKN/PQrdU=
X-Received: by 2002:a25:2c3:0:b0:df4:978c:3794 with SMTP id
 3f1490d57ef6-df4e0bcb476mr7516169276.1.1716482077767; Thu, 23 May 2024
 09:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024805.144759-1-howardchu95@gmail.com>
 <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>
 <Zil1ZKc7mibs6ONQ@x1> <CAP-5=fVYHjUk8OyidXbutBvZMPxf48LW7v-N3zvHBe5QME1vVQ@mail.gmail.com>
 <CAM9d7cggak7qZcX7tFZvJ69H3cwEnWvNOnBsQrkFQkQVf+bUjQ@mail.gmail.com>
 <CAH0uvohPg7LtSOLDNaPwnC5ePwjwg0NtKzLZ_oJcAz7zOwdwdw@mail.gmail.com>
 <CAP-5=fUzD8VZRnsxEBNPK_7PAGzdFjzmBAupA-eh=7VCDHBkbA@mail.gmail.com> <CAM9d7cgqr0Op5UuTcV2q8-Ju3yB7cYPvG7=Nrb4K=oW4Lt4Lcg@mail.gmail.com>
In-Reply-To: <CAM9d7cgqr0Op5UuTcV2q8-Ju3yB7cYPvG7=Nrb4K=oW4Lt4Lcg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 24 May 2024 00:34:27 +0800
Message-ID: <CAH0uvojme5j0scQTztiCWxSichhPdAokWy1Lw_D9cFx-SWfHFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, May 23, 2024 at 12:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Wed, May 15, 2024 at 9:56=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, May 15, 2024 at 9:24=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> > >
> > > Hello,
> > >
> > > Here is a little update on --off-cpu.
> > >
> > > > > It would be nice to start landing this work so I'm wondering what=
 the
> > > > > minimal way to do that is. It seems putting behavior behind a fla=
g is
> > > > > a first step.
> > >
> > > The flag to determine output threshold of off-cpu has been implemente=
d.
> > > If the accumulated off-cpu time exceeds this threshold, output the sa=
mple
> > > directly; otherwise, save it later for off_cpu_write.
> > >
> > > But adding an extra pass to handle off-cpu samples introduces perform=
ance
> > > issues, here's the processing rate of --off-cpu sampling(with the
> > > extra pass to extract raw
> > > sample data) and without. The --off-cpu-threshold is in nanoseconds.
> > >
> > > +-----------------------------------------------------+--------------=
-------------------------+----------------------+
> > > | comm                                                | type
> > >                        | process rate         |
> > > +-----------------------------------------------------+--------------=
-------------------------+----------------------+
> > > | -F 4999 -a                                          | regular
> > > samples (w/o extra pass)      | 13128.675 samples/ms |
> > > +-----------------------------------------------------+--------------=
-------------------------+----------------------+
> > > | -F 1 -a --off-cpu --off-cpu-threshold 100           | offcpu sample=
s
> > > (extra pass)           |  2843.247 samples/ms |
> > > +-----------------------------------------------------+--------------=
-------------------------+----------------------+
> > > | -F 4999 -a --off-cpu --off-cpu-threshold 100        | offcpu &
> > > regular samples (extra pass) |  3910.686 samples/ms |
> > > +-----------------------------------------------------+--------------=
-------------------------+----------------------+
> > > | -F 4999 -a --off-cpu --off-cpu-threshold 1000000000 | few offcpu &
> > > regular (extra pass)     |  4661.229 samples/ms |
> > > +-----------------------------------------------------+--------------=
-------------------------+----------------------+
>
> What does the process rate mean?  Is the sample for the
> off-cpu event or other (cpu-cycles)?  Is it from a single CPU
> or system-wide or per-task?

Process rate is just a silly name for the time record__pushfn() takes
to write data from the ring buffer.
record__pushfn() is where I added the extra pass to strip the off-cpu
samples from the original raw
samples that eBPF's perf_output collected.

With -a option it runs on all cpu, system-wide. Sorry that I only
tested on extreme cases.

I ran perf record on `-F 4999 -a `, `-F 1 -a --off-cpu
--off-cpu-threshold 100`, `-F 4999 -a --off-cpu
--off-cpu-threshold 100`, and `-F 4999 -a --off-cpu
--off-cpu-threshold 1000000000`.
`-F 4999 -a` is only cpu-cycles samples which is the fastest(13128.675
samples/ms)
when it comes to writing samples to perf.data, because there's no
extra pass for stripping
extra data from BPF's raw samples.

`-F 1 -a --off-cpu --off-cpu-threshold 100` is mostly off-cpu samples,
which requires considerably
more time to strip the data, being the slowest(2843.247 samples/ms).

 `-F 4999 -a --off-cpu --off-cpu-threshold 100` is half and half, lots
of cpu-cycle samples so
a little faster than the former one(3910.686 samples/ms). Because for cpu-c=
ycles
samples, there's no extra handling(but there's still cost on copying
memory back and forth).

`-F 4999 -a --off-cpu --off-cpu-threshold 1000000000` is a blend of a
large amount of cpu-cycles
samples and only a couple of off-cpu samples. It is the
fastest(4661.229 samples/ms) but still
nowhere near the original one, which doesn't have the extra pass of
off_cpu_strip().

What I'm trying to say is just, stripping/handling off-cpu samples at
runtime is a bad idea, the extra
pass of off_cpu_strip() should be reconsidered. Reading events one by
one, put together samples,
and checking sample_id and stuff introduces lots of overhead. It
should be done at save time.

By the way, the default off_cpu_write() is perfectly fine.

Sorry about the horrible data table and explanation; they will be more
readable next time.

>
> > >
> > > It's not ideal. I will find a way to reduce overhead. For example
> > > process them samples
> > > at save time as Ian mentioned.
> > >
> > > > > To turn the bpf-output samples into off-cpu events there is a pas=
s
> > > > > added to the saving. I wonder if that can be more generic, like a=
 save
> > > > > time perf inject.
> > >
> > > And I will find a default value for such a threshold based on perform=
ance
> > > and common use cases.
> > >
> > > > Sounds good.  We might add an option to specify the threshold to
> > > > determine whether to dump the data or to save it for later.  But id=
eally
> > > > it should be able to find a good default.
> > >
> > > These will be done before the GSoC kick-off on May 27.
> >
> > This all sounds good. 100ns seems like quite a low threshold and 1s
> > extremely high, shame such a high threshold is marginal for the

> > context switch performance change. I wonder 100 microseconds may be a
> > more sensible threshold. It's 100 times larger than the cost of 1
> > context switch but considerably less than a frame redraw at 60FPS (16
> > milliseconds).
>
> I don't know what's the sensible default.  But 1 msec could be
> another candidate for the similar reason. :)

Sure, I'll give them all a test and see the overhead they cause.

I understand that all I'm talking about is optimization, and that premature
optimization is the root of all evil. However, being almost three times
slower for only a few dozen direct off-CPU samples sounds weird to me.

Thanks,
Howard
>
> Thanks,
> Namhyung

