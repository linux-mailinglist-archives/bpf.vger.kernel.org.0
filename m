Return-Path: <bpf+bounces-45033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D699D010F
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA41F283C38
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7621AE00C;
	Sat, 16 Nov 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn/+vBLE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23991A3BA1;
	Sat, 16 Nov 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793461; cv=none; b=d8n8Vx/3DoH101l7/y0Zwd1WEUTYCmsd5FpnckMZjtxsQsvBD+wyVkysstJzXIjM5wiViLlfZfeugwGCw2wtiwTYWAkaNEHVq7lfOFfoEt0vG4ic5y1NNYGxAms9MmKlXs5118gKzGzy9vOUcLHVQrh7QuS72tdSJFZa5kKrUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793461; c=relaxed/simple;
	bh=ybOff1SY6gy+w5ELekO/ui7A96bk1jM+ANYjT+EDr6s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay4oepl66T9b/wJlKyMR8GS9/ESTmu+jvvJXvLbF15YG9ZAMoTowNe4WQfkvWsRJEV+R1ZyrZFQPeR0v3YMgvnlBQBNGUnwmq67FD18Rp50GnZdYX1krkMHKoDEHeNz5/hYK2kkCICFzJVNog3YGHiJW7HUas2fQCaIsexacdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn/+vBLE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cf8593ca4bso1061290a12.1;
        Sat, 16 Nov 2024 13:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793456; x=1732398256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMU+i4ucjbISn+pD79KvM8MmX4Sciu+Qz229FVHJzkg=;
        b=Fn/+vBLETBGb6mwEFuGCPM2pk4q7rJH/0nRnW6OZZhuumP79C2o9Pt6wlaDyaovZvU
         2L4pa3RzhcaO/abUwIAvY6hE6GV2IQMsfv7bvtzm9OXhkQupvdmOGXBNYvRoOvJD2SK0
         tMNsDQ8AghGr6YgYwuNr8x9vZBL7g5TgVj8oSCwzCoxJG6iCjP1wv8Q5vSRChvC6tTjg
         2EPi3aToXKAny8VkTigJiqD9/OgsQeFuX1PlKDC5scvbkX16yjuY9CblA7VUKHZs746W
         r4J5DKsP8TrdHKn81/vfhEgN9j5aRtaAdLR1AGPzMxE1+VUhNzlwCvvGARxWW08lQGVX
         CbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793456; x=1732398256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMU+i4ucjbISn+pD79KvM8MmX4Sciu+Qz229FVHJzkg=;
        b=weg5g8A/hquJhJAp3N+E8/hYoTPCSKDHFLIJ/Tcph0W5ImDC7/RCkqk7rPXP6oKs8D
         YgfGDc9SSS1N3KAz8jbyGiJ6lSGtewC8INWUG2v6MwlEfqprsmGk8G0UatoXhLq22Tki
         UESRzj0+JWpuk8mScJ2locQtfmml59DnSGHuEn7YLC7823H0bvARyPutQZhbuML0iof9
         rq1nNPbRDL3mNBo8LAds0YjYMc76/4U72axPQloe5hVyxJyPV4rRSb4kVgOk2ab4koI/
         4Qnm1FSZaxvYiITjlaAEj7poiA58xiqUKxOml58v3LV0719ao5q6CEV47QrC4I4c+miT
         pPNA==
X-Forwarded-Encrypted: i=1; AJvYcCVRInkNi534HK69/g26wRU/htPCGYW8PiLYaqSzTbnN41J/PMR9tD1J5vcp4P/jSldBNfk=@vger.kernel.org, AJvYcCWwDlLcAYN8f/vizHrq7m/MKb5BceAHkUzqHV5iRAn3ipNWUbJll62cnXNCxAwjZwl+tFJeERgY0WSp8Mmm8Y8673ae@vger.kernel.org, AJvYcCX8RVtkjxWpTgXTifvDngYw8qfHXSZoHBcv9dwjNb+uiy0LH87X9emYwis025LD74LKXXOiuOvI/jdRVMJx@vger.kernel.org
X-Gm-Message-State: AOJu0YytLbxPUDgeizOFErl76iGEqxJBTANpiBnxRnCDYoJHj2bcpQ65
	4lYo0JLUY1ON15W9C9fYLFOKrWOGaWIsqhfw4n7WEXh3VNR1gJRL
X-Google-Smtp-Source: AGHT+IG75Y3mJWQbIsFYjSNYnkQdaMbkUlwCGMm9YJenAN2blJ+ANGv2U098hVM2vz9wWhq47dGAyg==
X-Received: by 2002:a17:907:844:b0:a9e:b5d0:de6 with SMTP id a640c23a62f3a-aa483552ea3mr609905866b.50.1731793455841;
        Sat, 16 Nov 2024 13:44:15 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcadsm346638666b.112.2024.11.16.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:44:15 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 22:44:09 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <ZzkSKQSrbffwOFvd@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net>
 <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:44:12PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 8:33 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Nov 05, 2024 at 03:23:27PM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 05, 2024 at 02:33:59PM +0100, Jiri Olsa wrote:
> > > > Adding interface to add special mapping for user space page that will be
> > > > used as place holder for uprobe trampoline in following changes.
> > > >
> > > > The get_tramp_area(vaddr) function either finds 'callable' page or create
> > > > new one.  The 'callable' means it's reachable by call instruction (from
> > > > vaddr argument) and is decided by each arch via new arch_uprobe_is_callable
> > > > function.
> > > >
> > > > The put_tramp_area function either drops refcount or destroys the special
> > > > mapping and all the maps are clean up when the process goes down.
> > >
> > > In another thread somewhere, Andrii mentioned that Meta has executables
> > > with more than 4G of .text. This isn't going to work for them, is it?
> > >
> >
> > not if you can't reach the trampoline from the probed address
> 
> That specific example was about 1.5GB (though we might have bigger
> .text, I didn't do exhaustive research). As Jiri said, this would be
> best effort trying to find closest free mapping to stay within +/-2GB
> offset. If that fails, we always would be falling back to slower
> int3-based uprobing, yep.
> 
> Jiri, we could also have an option to support 64-bit call, right? We'd
> need nop9 for that, but it's an option as well to future-proofing this
> approach, no?

hm, I don't think there's call with relative 64bit offset

there's indirect call through register or address.. but I think we would
fit in nop10 with the indirect call through address

> 
> Also, can we somehow use fs/gs-based indirect calls/jumps somehow to
> have a guarantee that offset is always small (<2GB away relative to
> the base stored in fs/gs). Not sure if this is feasible, but I thought
> it would be good to bring this up just to make sure it doesn't work.
> 
> If segment based absolute call is somehow feasible, we can probably
> simplify a bunch of stuff by allocating it eagerly, once, and
> somewhere high up next to VDSO (or maybe even put it into VDSO, don't
> now).

yes, that would be convenient

jirka

> 
> Anyways, let's brainstorm if there are any clever alternatives here.
> 
> 
> >
> > jirka

