Return-Path: <bpf+bounces-45391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1969D50EB
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243D1B24B69
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDA1A01D8;
	Thu, 21 Nov 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G192oEPo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6320157A59;
	Thu, 21 Nov 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207691; cv=none; b=UwzLtubdcbxgdGERf/fs0vaKRn6Y/754/iEW3t4z/EvhHHgYsl1SzIDFCojfrvzFPJEjWsgnhcoopSklXbE4DQaUXmI0N5/zRN7YCTBXEZV1iakDNEzqbHQz8ySX9oxq1smN8bVg4KPpO6GNboD9Nt0wcdrX6WLuNC1uf1m1G5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207691; c=relaxed/simple;
	bh=BM9pgSaIt+maCMBOLXHz7WdI42Z1IXqm9l/EIXFeqO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VL6IzJvp44/O5sTIEjVNNFkyg/YpUp7ymoTgaCwAWwh7ApTXZk/clNVasM3JDCHWMNAtgWrAiYgO0vaSkXp+UzJTbYo2v0OVhdYFQv/CiJtgxFVX55/XbGGDD4G74KP7nM2PlsFadIYD7jayOLvWLnwfdEUhz2S3ItX/ppuSMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G192oEPo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43169902057so9505785e9.0;
        Thu, 21 Nov 2024 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732207688; x=1732812488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM9pgSaIt+maCMBOLXHz7WdI42Z1IXqm9l/EIXFeqO8=;
        b=G192oEPoVYDOaXLjxoZEoy8RXzaSAdSThP49mtIS9UpuU7Dz6iZOBHUQY/aLsV8o5F
         cNj8rYyn6mW666Z2Lje5pUodaTMUjbJbzpImd4B3IicsmupesIjAvj42eiWltV44TLpM
         +MztAqFkmm6zb5VuXXp4e8PLmTX4ewAh6roHVn1rL2yQu0cm/6b/f89mK0oHGfSwIa7K
         jUT7B/9WvDkAMDxPOTTHFvo3sP/KGyWotfZ1T04FUHZJUlWV7umSRnPT2csZlXIftYmk
         qTp8nYxDu5jM8FdMFHF9+WdN08WAkDxnwMQfNIpWnAT6vdx2LB3DSJv1G5cvyktjAua9
         DWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732207688; x=1732812488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM9pgSaIt+maCMBOLXHz7WdI42Z1IXqm9l/EIXFeqO8=;
        b=bd8+j54gVcd8t+ZGtWwjy61yNDjgrky5QaOA6nakrOVtJgUuY3XnVk+H+txJ2O5RhM
         4KJAxuFDkXDs+2/nFwJOBn6wkzV+jD/4qTZ2AOdrn7QdcS+dukaz6FGEWjniGCTe2cpv
         vkGlAP/snWLVse/wbXWTzqdZru9jqiTSIFvpsXrxjwpkZyVrS3Mi2+2v9u6DEi2PcMIY
         MmRMaUn9SHQsAyky5ia0LvvG1/IUpp2oNq7kR8c7wgAU+kHNShAkoEu7QbvYNnGKm7gl
         RQZlz4T8lUIculXKcjWHyhcibKx+UNbAp0VMav8YnUzReRStY6sP3Olzn++taOyb042a
         zoQA==
X-Forwarded-Encrypted: i=1; AJvYcCVrMJe+dtZzJ5nVupJ44v0B8D1Tcufty9dysCM7mwDsOy4o2ZrBtqBFUD7WSvozM3uurqs=@vger.kernel.org, AJvYcCVtVCOQoyHQnMTbN4icqJ4J/1UVzIn3ISxlmukSDqfOl82cWEMUdgssHmEfBMllbJShy8XUD58d9VCzH+MwO6YtVOkk@vger.kernel.org, AJvYcCXamLeWv4BZi4J0yuR2Lkm3u2XWIlS0jIva/XvI8nKWFgxjdELjDeOuQZvmaOCTFXv2dWP9735vTWch0d5J@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXr5ZEQW3grPzV5Hdw5xvnuKA2D5UqkJOVno8dWsyVQvYIEqB
	/VvN5QnLKAqYk9VNkLcYphY/xhE0x3zE8zRfzg8YyxOXl9yj5tRt5Dlni1SzfHc49HNOQE0cDAv
	YDnJ2JvVWFUIzv0mP9oF6CH7YoAU=
X-Gm-Gg: ASbGncvRUlI9X9bJ9Kg4WRgP9tjsnPZ5LqFGDfkE5f+6hD7vpqzSXrC/8dLw5Gb1gWq
	KllKlqr4Jg4CFpUUJ0U0UcbeuNvSVVFQw7dGptHKGDzaMFYY=
X-Google-Smtp-Source: AGHT+IExdSHLQifNlJ/XwcEV2pcntFziBKWf1AUB6H7a1O/taYUss3Q7AjamN8Z/+H7hHYE/VKMrBQZUZaCUbAxKMrI=
X-Received: by 2002:a05:600c:3b25:b0:431:680e:95ff with SMTP id
 5b1f17b1804b1-433489b1b15mr67265025e9.9.1732207687657; Thu, 21 Nov 2024
 08:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-6-jolsa@kernel.org> <20241105142327.GF10375@noisy.programming.kicks-ass.net>
 <ZypI3n-2wbS3_w5p@krava> <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava> <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
 <20241119091348.GE11903@noisy.programming.kicks-ass.net> <CAEf4BzbhDE2B41pULQuTfx0f_-1fn5ugJEdPpweKWZVJetCxrQ@mail.gmail.com>
 <20241121115353.GJ24774@noisy.programming.kicks-ass.net> <CAADnVQJJ0WS=Y1EudjiFD8fn4zHCz6x1auaEEHaYHsP15Vks2Q@mail.gmail.com>
 <20241121163450.GN24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241121163450.GN24774@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Nov 2024 08:47:56 -0800
Message-ID: <CAADnVQ+3VA-SW2FKVv7iSPps00gZRkOb9L7NiKFZ5Jc5NwDedQ@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 8:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 21, 2024 at 08:02:12AM -0800, Alexei Starovoitov wrote:
> > On Thu, Nov 21, 2024 at 4:17=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Nov 20, 2024 at 04:07:38PM -0800, Andrii Nakryiko wrote:
> > >
> > > > USDTs are meant to be "transparent" to the surrounding code and the=
y
> > > > don't mark any clobbered registers. Technically it could be added, =
but
> > > > I'm not a fan of this.
> > >
> > > Sure. Anyway, another thing to consider is FRED, will all of this sti=
ll
> > > matter once that lands? If FRED gets us INT3 performance close to wha=
t
> > > SYSCALL has, then all this work will go unused.
> >
> > afaik not a single cpu in the datacenter supports FRED while
> > uprobe overhead is real.
> > imo it's worth improving performance today for existing cpus.
>
> I understand, but OTOH adding a syscall now, that we'll have to maintain
> for years and years, even through we know it'll not be used much is a
> bit annoying.

No. It _will_ be used for years.

>
> > I suspect arm64 might benefit too. Even if arm hw does the same
> > amount of work for trap vs syscall the sw overhead of handling
> > trap is different.
>
> Well, the RISC CPUs have a much harder time using this, their immediate
> range is typically puny and they end up needing multiple instructions
> and some register in order to set up a call.

We don't care about 32-bit archs and other exotics.
They're not the reasons to leave performance on the table
on dominant archs.

> Elsewhere in the thread Mark Rutland already noted that arm64 really
> doesn't need or want this.

Doesn't look like you've read what you quoted above.
On arm64 the _HW_ cost may be the same.
The _SW_ difference in handling trap vs syscall is real.
I bet once uprobe syscall is benchmarked on arm64 there will
be a delta.

