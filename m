Return-Path: <bpf+bounces-65164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4FEB1CF70
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B883B627CC7
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B454277C9D;
	Wed,  6 Aug 2025 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODqJWN5A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAE21C179;
	Wed,  6 Aug 2025 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523504; cv=none; b=ZMhH4hYZRN6HhmV2ZO7HsS6Ys6b/VTiHYGmVbCQ+ONXcmV+avP8TnaRC8EyX/eY3rNfitQjnXWjsVqTOoorMG+oLNK2iqHcRy+AccWaNBYH4iHWVxoMZEBcDUKWFzaKLuJCLBiADk+fyTw54rjavi3i1rE6eNz68JQ5C8c9sq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523504; c=relaxed/simple;
	bh=sqI/GEwdoGremF/OUWnATYq0HOTDGAs6joghp/SU8a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5w4nTG11mZZwYuCBUMwoi9qZe/I8hgxc0mTnVyrIOmXoxMqIRJDzRduwdfdAyHGSWWlsXI9IpJWkjR1CtTlPmrM3J6PtC2CIgPRMnRCJUmyH8bZ40XkS6FWQmOEGxIf2PZXzf/onNMbdkyBPrvEoi/BN6XUGbceShtxoTHNf1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODqJWN5A; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af66f444488so61171766b.0;
        Wed, 06 Aug 2025 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754523501; x=1755128301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhqBigQF9nZyV6MxdBcrgjMBesgYA66oBZ2ceJcbdZE=;
        b=ODqJWN5AtSIb0A5kVojl0Yy0V5g2hPqCjk3+bSOkU5h92O0GRkAIkGsjB2GOtOIUf2
         UoO3AfhfTUMkyKXxBSxnO5dP7HLBd8RzghftDep575BBfGt7pUNClpvjdh0bR1j392k4
         E+Ej9eoe1zBAjVS8oul/qF9xYyVFs3zIG4kJ3SyScHiaFhJq0fROUQ+DH9E5RE09+Qzr
         a5EfKWdhHiVgc2/mf836B5As/7NBle2vb73TNKd3TOZIf8oAwNzpEeBOGvgGBG7lY5G+
         PWMe+Hds0REuzhc4sbTQIp7yBKGaf/6Zc+6JQY9EqHh8jFaKm6+CwAMEAZy2kxEoPx9v
         A26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754523501; x=1755128301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhqBigQF9nZyV6MxdBcrgjMBesgYA66oBZ2ceJcbdZE=;
        b=Y3Z7/Yuah5KWrxePZla1UmU7LWf1CGN2jLvfN4D+Th1rVrDVrSi8GY5sbCang2M4WY
         gdDQbbnNkt0k0Tltay8qC5Nt/AZPEIddZ4wOg7Z4ej2BiCHbKTAQH9ZjXHjIxuNUDmDy
         k2GfXDXUaxpNh2tEQ+EGfa3vcBqMGP1dD9QyDhiTkwD4AofvTFOI/omS0bBzhWnWK1hW
         rgNj/238nHCuekuM+g6lvvTaBkDQ2QcAnjden8rGkaX5EOEhP7tlnBbz7xwkgmqwUqe6
         9Ju8qc92En3gm7Ti/sAGmNAdJh8OCC0t+Tbsk4F5aBKBCNwYpoKUN5xokJg3MrLgnW2F
         5Ikg==
X-Forwarded-Encrypted: i=1; AJvYcCUxMfPGoBI9oFbT7Cwsv30C8bWRfoCoPcY8leMHNf1gnT7r61h5/6DhFKzXJM8gptewHkI=@vger.kernel.org, AJvYcCV+rOcTP7UW/mNc7/oJlHDdrer8HPxo7DnHA9k+DWS4yxSvHcS6jK46I9867dvB7uZ1IuqqQLsfvp8Xow==@vger.kernel.org, AJvYcCWluwqtt3JlPKCW1yTyyGTQ7rM/JR5VoFOKUAwnl7514i+hRzPh5si6Mx+wC4trbTKClbvtIoVoQU98kUw1ZlgI6g==@vger.kernel.org, AJvYcCXq8EJEl36RU6HatblEDArkzadT7lizm8Xlwvrdgj2tMZgRYQf6CEZWxtP9VsqcoWi5ww/m940Zdo9UbcSI@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVkaUAAmefeH9neYA+3L6c+kLp6KeY0vL/O9kX4KT6dkUG0M6
	UidQTx7A5VSyU/82ijZGzJ+kWO4u3+eqwFTW/oU7EeBgFkdLAOIR46H1FLzRX6f9Zox2CNO+DqX
	mXm0QqsrYiBuEUZpeklPoi4rQro1KpVo=
X-Gm-Gg: ASbGncvAkwv+HtNmhDNNyONKDoUF8RiPQTsuoDtZkKk1tAHyTBJO1fTRstN3h9MBS8z
	U98vu76lb+Yzcqa1z8Rnr4/Lm229bWn5wJh4m0iAs7e1EDa6bsoX7yliewHZv5S4R6gYZ3Pa+zm
	CM5HtdR7U317AQaOZPXclsggm+BNsDZYSA7UEO5ku3fGkGrXsfFLQ6nltlMtnQOciJRQ8MUgNYx
	ouFIcJrcGRqO3N6b+HMyWMKVOyrDloV0yZ4xi0UUhDeXRY=
X-Google-Smtp-Source: AGHT+IHzqZa1neiF0uyaArNjeHnGfC3u3C63toQez4cHAhPKNPYYG8lWs+NBrvtwsMA4OL/MdhBzMkD1DLcLhev3JBQ=
X-Received: by 2002:a17:906:9f8b:b0:ae3:f299:ba47 with SMTP id
 a640c23a62f3a-af992ba59a5mr376345166b.32.1754523500252; Wed, 06 Aug 2025
 16:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806114227.14617-1-iii@linux.ibm.com> <20250806114227.14617-3-iii@linux.ibm.com>
 <aJPc2NvJqLOGaIKl@google.com>
In-Reply-To: <aJPc2NvJqLOGaIKl@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Aug 2025 16:38:09 -0700
X-Gm-Features: Ac12FXz1F-Xdu0Kpt8aaIXgLMS8YVgSoQxycBjiK4rapVXOu8GkFrx9VZX0LA3A
Message-ID: <CAADnVQJG6U6X1qarpbdXra12m-PhNJK5f-jyw695osnOm6AZnQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] perf bpf-filter: Enable events manually
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 3:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Wed, Aug 06, 2025 at 01:40:35PM +0200, Ilya Leoshkevich wrote:
> > On s390, and, in general, on all platforms where the respective event
> > supports auxiliary data gathering, the command:
> >
> >    # ./perf record -u 0 -aB --synth=3Dno -- ./perf test -w thloop
> >    [ perf record: Woken up 1 times to write data ]
> >    [ perf record: Captured and wrote 0.011 MB perf.data ]
> >    # ./perf report --stats | grep SAMPLE
> >    #
> >
> > does not generate samples in the perf.data file. On x86 the command:
> >
> >   # sudo perf record -e intel_pt// -u 0 ls
> >
> > is broken too.
> >
> > Looking at the sequence of calls in 'perf record' reveals this
> > behavior:
> >
> > 1. The event 'cycles' is created and enabled:
> >
> >    record__open()
> >    +-> evlist__apply_filters()
> >        +-> perf_bpf_filter__prepare()
> >          +-> bpf_program.attach_perf_event()
> >              +-> bpf_program.attach_perf_event_opts()
> >                  +-> __GI___ioctl(..., PERF_EVENT_IOC_ENABLE, ...)
> >
> >    The event 'cycles' is enabled and active now. However the event's
> >    ring-buffer to store the samples generated by hardware is not
> >    allocated yet.
> >
> > 2. The event's fd is mmap()ed to create the ring buffer:
> >
> >    record__open()
> >    +-> record__mmap()
> >        +-> record__mmap_evlist()
> >          +-> evlist__mmap_ex()
> >              +-> perf_evlist__mmap_ops()
> >                  +-> mmap_per_cpu()
> >                      +-> mmap_per_evsel()
> >                          +-> mmap__mmap()
> >                              +-> perf_mmap__mmap()
> >                                  +-> mmap()
> >
> >    This allocates the ring buffer for the event 'cycles'. With mmap()
> >    the kernel creates the ring buffer:
> >
> >    perf_mmap(): kernel function to create the event's ring
> >    |            buffer to save the sampled data.
> >    |
> >    +-> ring_buffer_attach(): Allocates memory for ring buffer.
> >        |        The PMU has auxiliary data setup function. The
> >        |        has_aux(event) condition is true and the PMU's
> >        |        stop() is called to stop sampling. It is not
> >        |        restarted:
> >        |
> >        |        if (has_aux(event))
> >        |                perf_event_stop(event, 0);
> >        |
> >        +-> cpumsf_pmu_stop():
> >
> >    Hardware sampling is stopped. No samples are generated and saved
> >    anymore.
> >
> > 3. After the event 'cycles' has been mapped, the event is enabled a
> >    second time in:
> >
> >    __cmd_record()
> >    +-> evlist__enable()
> >        +-> __evlist__enable()
> >          +-> evsel__enable_cpu()
> >              +-> perf_evsel__enable_cpu()
> >                  +-> perf_evsel__run_ioctl()
> >                      +-> perf_evsel__ioctl()
> >                          +-> __GI___ioctl(., PERF_EVENT_IOC_ENABLE, .)
> >
> >    The second
> >
> >       ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
> >
> >    is just a NOP in this case. The first invocation in (1.) sets the
> >    event::state to PERF_EVENT_STATE_ACTIVE. The kernel functions
> >
> >    perf_ioctl()
> >    +-> _perf_ioctl()
> >        +-> _perf_event_enable()
> >            +-> __perf_event_enable()
> >
> >    return immediately because event::state is already set to
> >    PERF_EVENT_STATE_ACTIVE.
> >
> > This happens on s390, because the event 'cycles' offers the possibility
> > to save auxilary data. The PMU callbacks setup_aux() and free_aux() are
> > defined. Without both callback functions, cpumsf_pmu_stop() is not
> > invoked and sampling continues.
> >
> > To remedy this, remove the first invocation of
> >
> >    ioctl(..., PERF_EVENT_IOC_ENABLE, ...).
> >
> > in step (1.) Create the event in step (1.) and enable it in step (3.)
> > after the ring buffer has been mapped.
> >
> > Output after:
> >
> >  # ./perf record -aB --synth=3Dno -u 0 -- ./perf test -w thloop 2
> >  [ perf record: Woken up 3 times to write data ]
> >  [ perf record: Captured and wrote 0.876 MB perf.data ]
> >  # ./perf  report --stats | grep SAMPLE
> >               SAMPLE events:      16200  (99.5%)
> >               SAMPLE events:      16200
> >  #
> >
> > The software event succeeded both before and after the patch:
> >
> >  # ./perf record -e cpu-clock -aB --synth=3Dno -u 0 -- \
> >                                         ./perf test -w thloop 2
> >  [ perf record: Woken up 7 times to write data ]
> >  [ perf record: Captured and wrote 2.870 MB perf.data ]
> >  # ./perf  report --stats | grep SAMPLE
> >               SAMPLE events:      53506  (99.8%)
> >               SAMPLE events:      53506
> >  #
> >
> > Fixes: b4c658d4d63d61 ("perf target: Remove uid from target")
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Do you mind if I take the whole set through the bpf tree ?

I'm planning to send bpf PR in a couple days, so by -rc1
all trees will see the fix.

