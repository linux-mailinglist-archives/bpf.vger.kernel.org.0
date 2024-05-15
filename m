Return-Path: <bpf+bounces-29792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B908C6B98
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E31F2363E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B043032A;
	Wed, 15 May 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k51Yfg4/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6639FE4
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794759; cv=none; b=TpF8z8ewJG4BaulXQOz1qafflGPV1UkU49GjRd0ZIFccQpIpY6e6A33768+j9dO2oSPLu+Ad24CG/Od3ws6nzjHfdjW9zDOQk2rP07vbYpgfArvymoz7Z6QlnmcjzglOSOMTYmon0xNeqidsc3Hj1MjpLvIMQSgtnSizgt5z55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794759; c=relaxed/simple;
	bh=p07boBCL2/GwD13qsVqUM9ebWhmEg5Pu7asTAv4Yb+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6bB1VmIUi0iHo+pg0xXwxrOUE+8VEDNEUvA7EbO4WS+nOCMJrJWB9GqrmCdB3jJ4r8B+zgUCtYuRaAIPPynTc/XlrMyAQMAg9qkRagn6Za4Nql3ynQKcBSWMexZub5y5cwgKgR352MPPT8fmsxEz2GxBVRTpPqGwHr/ZzmPj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k51Yfg4/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso35351a12.0
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715794756; x=1716399556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKLVYctWbrEOc7GL4VlkuESIidRYpab7R3opOD7N7jE=;
        b=k51Yfg4/pryeJsipNTX80n3kMl3G6mGJe0As1ksB2+7Og4xjuzoDRmqeJjZq9+Gy3D
         a0GfftUY5JxJ9Y9HW4FjMwrO00tBKMAhAuCPmpfRRqksUVk0BmuAWawksfot3v5FEPxI
         t3pW9u0vDb0vHmkSdu26VoxXIYZDQfhXuje+HLKGdiJx5RJK7w6ISY/e1/jzRF5G7R0R
         2kTPBvvVcu2da43rI6rgWj+j3U8bijWDqwqpddaynbyyhijeK+5doDAJhpGVdAqeLcN5
         158/C3zAISZ1nB3wN0SJUzVZCo19a1BfCKxbmcvuWrP4oEk4w7ZFzZueiM2X/S7dGYUa
         TYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794756; x=1716399556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKLVYctWbrEOc7GL4VlkuESIidRYpab7R3opOD7N7jE=;
        b=sKdzqbVpP42ANDb0nSjvs9Wr94bTJlZAYcVYw+IEB7uRTPj+x/UIVm3NptnS68gj6Z
         bKyQxfkKHT+C1gpUH2bgOj2eb3mX5pWveI4xAxkrtTy+zFugdL3Rx3jCbKSNZzQHnhmF
         kKp4rW7c+6C114JUJcZU8UWqtJxuBGevWvzIHL5DiU3Mf3qIjbi5iJq4QJItbkq34rqL
         B8nUeq7/8i1yzlVclMKzg3wgqQSfRS3zmoaWLI6RLlb/pzO9lcokZ3EzrdFC110Jy9Ro
         AaTNW08Sfjm8GBxycqytA0Y/DIk301bfpm3O0kAo1K+83QwjOf8rvprM6rcfqe3ffNAH
         LiKw==
X-Forwarded-Encrypted: i=1; AJvYcCUJeCPE4Fz3A8fhPSRfLiA/dxo3l/zIChIr8lQByJ/7Q5SPZicPyKP3AfjAatge7mG+TFzGguwqV5v09xRU/gVniISJ
X-Gm-Message-State: AOJu0Yw/oTTY18kk5ZPKBwdowlHOTsN3iw2zvCGso1ang9SLuwaNGZC/
	02HcHQciZKcsO+7mfdamL3NA0lj9FOx+kBGoK7vdNAIsYBrQ+PZqyiC2cG2qrj2FL9h+kYapZ5I
	o+bsWwaGe4lWY3LtWB2KO7PVbZocwLRw43Xk=
X-Google-Smtp-Source: AGHT+IGyktch+M6iWO5ulke6CgJpEkTsLZ+6zTMOnCvKIwpZsMqeg1GMJqbTSW9Hzl6ImHPpTMIx03EfjgzCAZqXil4=
X-Received: by 2002:a50:c90b:0:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-5743a0a4739mr813646a12.2.1715794755056; Wed, 15 May 2024
 10:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-2-yabinc@google.com>
 <20240515085755.GC40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240515085755.GC40213@noisy.programming.kicks-ass.net>
From: Yabin Cui <yabinc@google.com>
Date: Wed, 15 May 2024 10:39:01 -0700
Message-ID: <CALJ9ZPPyLP3xYtaoJ9+j1o_CMhMCA0tbd2xhh6CbeidDqW0s6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] perf/core: Save raw sample data conditionally
 based on sample type
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good suggestion! I will send a new version.



On Wed, May 15, 2024 at 1:58=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, May 10, 2024 at 12:14:21PM -0700, Yabin Cui wrote:
>
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index d2a15c0c6f8a..9fc55193ff99 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1240,12 +1240,16 @@ static inline void perf_sample_save_callchain(s=
truct perf_sample_data *data,
> >  }
> >
> >  static inline void perf_sample_save_raw_data(struct perf_sample_data *=
data,
> > +                                          struct perf_event *event,
> >                                            struct perf_raw_record *raw)
> >  {
> >       struct perf_raw_frag *frag =3D &raw->frag;
> >       u32 sum =3D 0;
> >       int size;
> >
> > +     if (!(event->attr.sample_type & PERF_SAMPLE_RAW))
> > +             return;
> > +
>
> Should we add something like:
>
>         if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_RAW))
>                 return;
>
> ? And I suppose the same for all these other patches.
>
> >       do {
> >               sum +=3D frag->size;
> >               if (perf_raw_frag_last(frag))
>
>

