Return-Path: <bpf+bounces-34897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A50932126
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3674D1C21346
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB228DD0;
	Tue, 16 Jul 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta1nTP7B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE06225A8;
	Tue, 16 Jul 2024 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114727; cv=none; b=UAV4cRTNzqxr5hhkqYfaXVgWQWo+WjT/7xsA+Vu05k9vhAhOlck0i0m64u38SYa89e9qFwzGLP3IIZHjRqiWkXRa2TkFlxKomR6mWfNTj6UkChC3Di8uBrGLyNsoCTxKjPdJbJoGDoSCxdHg+Vcn0Fq9fykLySHoQK1lNXMV6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114727; c=relaxed/simple;
	bh=NtKSZ7m9ucMv5FMZ2KxPPKFYZhlsQr3il8/7YHPTDTc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM1slBxdtwD8ebAeLfG+Rb7U+qbM5wYaaCgzedCKGcBgfQwQfQ65bX5qa8+9fvUcEE7QojV9VssJ2zf2CSlfkbAQo/6Q7o7sdCOURmxzbTT99xLQSxcRmWsDFIOeAE8SsVfXao3efojZ6X3pqIqJomwuHP2Ck+TJLoN85pjhb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta1nTP7B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266f535e82so34441305e9.1;
        Tue, 16 Jul 2024 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721114724; x=1721719524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TU7CUD5K5Dcz+Ml2hXnHmVw1Jiy081Oy7EHg5HRuEwo=;
        b=Ta1nTP7B76nY4binkpm0IYUUIXc0TAJHRpBuz/2aWJkNDtw+YqoBcZXFTAMdX3gKD5
         PV16bixHOoxoB4IqDV2gyL0SHuavpmWsPx1S2dJrvxsv1XOfO7ZfYphYNVuOruQokFze
         /TVHPWOqOODfV7UlgQagJG826fySdWhXwGExSFhoronWiKrDgodG7vh/EMAK6SYF/pTU
         j9JlhJCj5wqLQZGKIMhqP3C8bpcGYe3qu+aR0WjoZQxv2T3rZ/Myi9f04etA1AOHk2xO
         Tnc/5z7RtxZyktwuPkUXkFUiT3t1PeL42a3yccRDvqy6sZv8nZGltOGhvJ4o4UVVur/H
         KtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721114724; x=1721719524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU7CUD5K5Dcz+Ml2hXnHmVw1Jiy081Oy7EHg5HRuEwo=;
        b=NAD9PT1FLdn9jlncOIB4PXO5kEblkHUBnlWW0CcBmYDm4BrrpfxXYH1UB56x8HiMkl
         wYYo/n698LrQHrA9x8myiOQddtJSYvSFHGL9GuhJtqv1YdHU2xFfK1dsC2fc5R9bkmK6
         +xJYqWQR37lUhQ/oo7V3WiUINFvaQT9a0+r3RH3LqCWxejuH3p/SN168Op0BSguqC4pH
         bAXoaAS/hxqupp3t8q/KnE0JjpOp2OvG7/xQcVRZtPWHDhkIVF3beQsOEC2UqVTg3Bgr
         5PAKxZsK/UBL68trEFAq3ElZgOnuHKCFP5NeGKK1NvMYs7FcfCEPVQoWNuUAoE4UOMHT
         FnYA==
X-Forwarded-Encrypted: i=1; AJvYcCUkTLjbjAUDHpqf9m9AQdI+6BUmA6PnxgQKqORHHkrIrMGohysLMkQuN8YM5eh7HJ38+gxHpqWeZ+TlYioGdP0sH05t7dsFFBfu52/fSVx3f2x/5s7ZuurKqOMehyJixDV32CCfMeHCGaXhOR/bGJECWrGy6ReBR8K60Ko+HGnGrIVmXA==
X-Gm-Message-State: AOJu0Yzugk0cLQlMmf+7SmPvzoXLL0eUG24LDBI61uZVCc+vJIwfxsIR
	0zUXRy+LPk2iea4mRZkOy18kxS6e3TVycG35mFrdPOX9A09Oz6ja
X-Google-Smtp-Source: AGHT+IETcC+uhL7n71HBlQuBAi445zap6TIzKxMp+t5U77n2cdDJTIp+1rY93nNJkKd1EJXI3i+23g==
X-Received: by 2002:a05:600c:1988:b0:425:7796:8e2c with SMTP id 5b1f17b1804b1-427ba684893mr8865765e9.12.1721114724192;
        Tue, 16 Jul 2024 00:25:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db0f263sm8112744f8f.115.2024.07.16.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:25:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Jul 2024 09:25:21 +0200
To: Kyle Huey <me@kylehuey.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <olsajiri@gmail.com>,
	khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
Message-ID: <ZpYgYaKKbw3FPUpv@krava>
References: <20240713044645.10840-1-khuey@kylehuey.com>
 <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net>
 <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
 <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net>
 <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>

On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> On Mon, Jul 15, 2024 at 9:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> >
> > > I think this would probably work but stealing the bit seems far more
> > > complicated than just gating on perf_event_is_tracing().
> >
> > perf_event_is_tracing() is something like 3 branches. It is not a simple
> > conditional. Combined with that re-load and the wrong return value, this
> > all wants a cleanup.
> >
> > Using that LSB works, it's just that the code aint pretty.
> 
> Maybe we could gate on !event->tp_event instead. Somebody who is more
> familiar with this code than me should probably confirm that tp_event
> being non-null and perf_event_is_tracing() being true are equivalent
> though.
> 

it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
are the only ones having the tp_event pointer set, Masami?

fwiw I tried to run bpf selftests with that and it's fine

jirka


