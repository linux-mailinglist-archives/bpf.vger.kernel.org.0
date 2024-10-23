Return-Path: <bpf+bounces-42946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF439AD488
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77E6B228EA
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577814658F;
	Wed, 23 Oct 2024 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asftQDW2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5FB1D07AA;
	Wed, 23 Oct 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710493; cv=none; b=dbdu6UUUomuVlHHx6L2Mtzlw0g2GPXFNIYCRK0fs4Jea4nLONfXa8Hjar1QqWG4FOezeG6eHXOmuHCoLwdWM9QC9iZNQMZcEN3v2VMcj92D+pbX/3FOLEU6ZZ5n6Di40r93+RR5GQPKaRfJR7n5Go1sQzw5ZMYhgW1G/auqIbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710493; c=relaxed/simple;
	bh=pdTXtQRn7xqVR7pJvkIP8Y+IzKqNDARqAlrReafBE/I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLGwCRPwXj5gDnzcY9OdFPt9RPEQs2DGt5QzOpCf/fysIAVD1grXctNRpqqUoJMcasF5I6nvRuCOTPHO8E45UoN3tM0SyV4bOIkRv3I7gDoaZYv/bZiIDbj7yhe118tYjSFOQ2VHUFfTTWrWgO97WIhNIW6MKXOmp6yKk26gpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asftQDW2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so5725066b.3;
        Wed, 23 Oct 2024 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729710490; x=1730315290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aprDIwQrEoZ5K7nhfLeKyeJZjUgprpDiLrP9bHWhnoI=;
        b=asftQDW2JDDXKKjtDk8d3epiVm4LOcG1jfdB1wDHjyCHqzeAUBKz/0W3k1XexApziD
         SSyIJ0Vl06z1FuPXT5AnilWnDJNq+hPZkjbYOsXa7hx1tkrX8Rp+YcAZ+SBOzpoemfuJ
         +5GcXEsow8x1IcVfhoPq4Q4VRlG32QRKEsba6kL9WGQZBwV4Ony0IKOzKJgXC8iaixT7
         tR+LG8W2vbtxrPODEJMGwmcUyV8VD+13i+Zzjnhuclvt3N3dAJ+l7+b8qXrcI3xU1lHw
         yfe8kplTtVr1hW/1oXa0SfdkmRsus28VSXn3LG5ee+bkHZVtzs1rsVkc1ca6x2cyZb+8
         GdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729710490; x=1730315290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aprDIwQrEoZ5K7nhfLeKyeJZjUgprpDiLrP9bHWhnoI=;
        b=vldNP52GOjhhKmMsnZsnnVMB86hdICRvRzz8EzK9awR5hKPpGEvE2Eug18plDiQfMA
         EH28QduyOEjI3pmHchD6gCvlTK0OmZDp0DF3A5YgF+jxnzWx4/QZEZkppLcDkJ4p4PC1
         SuPauNJQCDa2hZfm0gLPP20C3UI9q+Fo/sEF13jmhjdnl1dgmKUcDj30sWqpTJI3sL5W
         /ejtmsd3gCslcTBWjcmvkIkjx2xGVLoOlG1cYxS1BraMeznxgKtulN91KOF/+8QdDe7m
         dSjvEZT4wvYZ+LdKfpTKE39vIFy/ZsZqQGPpvm4eMBfU7cM95TkRJufw1KWZSLoR3B6t
         hJDg==
X-Forwarded-Encrypted: i=1; AJvYcCVM3149O1b82uz3N8J3g5PH+SLuwsSSDKLUyS2hGGS9G+2yhwc1aE39bFtIOJ/K+f1E3IqbGx2tl73lodH69NiWHA==@vger.kernel.org, AJvYcCVncUu/uYRRFcfT3KV+SrOtQRVgOzOFhEpxgfRdwcPO3IOWhX3euJCM7DzbN/lxBPDxW04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE08LeLfXx72SWtkQS0Fk0tZpPm6cZszL4KKE0TH8Pd+O338y/
	6CjQ90B6M4oXNPbujDKJt74CNkzcbwXEreUyQltmGuf7NhAE+kz0
X-Google-Smtp-Source: AGHT+IFijTHfRobc+cPO6sPXqp8Mt4A+Y5BeCZl8iGmUS97gsctEgrCiK4Ybhmu15IehB9apmvuf6Q==
X-Received: by 2002:a17:907:94c3:b0:a9a:8042:bbb8 with SMTP id a640c23a62f3a-a9abf94d4b2mr389580066b.47.1729710489798;
        Wed, 23 Oct 2024 12:08:09 -0700 (PDT)
Received: from krava (85-193-35-94.rib.o2.cz. [85.193.35.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee592sm513369766b.79.2024.10.23.12.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:08:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Oct 2024 21:08:08 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Sean Young <sean@mess.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error
 handling
Message-ID: <ZxlJmGMJ3H_lIkqC@krava>
References: <20241023100131.3400274-1-jolsa@kernel.org>
 <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>

On Wed, Oct 23, 2024 at 09:01:02AM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 23, 2024 at 3:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Peter reported that perf_event_detach_bpf_prog might skip to release
> > the bpf program for -ENOENT error from bpf_prog_array_copy.
> >
> > This can't happen because bpf program is stored in perf event and is
> > detached and released only when perf event is freed.
> >
> > Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
> > make sure the bpf program is released in any case.
> >
> > Cc: Sean Young <sean@mess.org>
> > Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if exclude_prog not found")
> > Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.programming.kicks-ass.net/
> > Reported-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 95b6b3b16bac..2c064ba7b0bd 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> >
> >         old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
> >         ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
> > -       if (ret == -ENOENT)
> > -               goto unlock;
> > +       if (WARN_ON_ONCE(ret == -ENOENT))
> > +               goto put;
> >         if (ret < 0) {
> >                 bpf_prog_array_delete_safe(old_array, event->prog);
> 
> seeing
> 
> if (ret < 0)
>     bpf_prog_array_delete_safe(old_array, event->prog);
> 
> I think neither ret == -ENOENT nor WARN_ON_ONCE is necessary,  tbh. So
> now I feel like just dropping WARN_ON_ONCE() is better.

heh, I was going back and forth with that and decided with 'safer' option,
but it's 2 of you now asking for that, I'll send v2 then

jirka

> 
> >         } else {
> > @@ -2225,6 +2225,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> >                 bpf_prog_array_free_sleepable(old_array);
> >         }
> >
> > +put:
> >         bpf_prog_put(event->prog);
> >         event->prog = NULL;
> >
> > --
> > 2.46.2
> >

