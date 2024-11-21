Return-Path: <bpf+bounces-45304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C833F9D44C8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B2BB21729
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78071846C;
	Thu, 21 Nov 2024 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnrRa/tL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A44C91;
	Thu, 21 Nov 2024 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147673; cv=none; b=jzlvqxmdld5Qcv1tFe6BOj7nry3Tt340OGBvzEr/ySMuHW1YO6SwkiK/SclzDr01QrM0sXout0TZLfeN7Ge+GdTZPXIF8HVyFVDyUVYlzW2K92lsJtT0LKS0sb+uyLBLCpIvbZ34il0tKnmQtl/mp3FSWnPbggTw7hZrw5OunEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147673; c=relaxed/simple;
	bh=6ZzWOuqh+PTTGQmiGrBAkYaST6Soj55F2vyOZAnCkSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bN5K7sG7jJ+ePnYcov3OmAsLYuXwNurswVWnSf287A6kylPMiYAODXmmkDB5ntbHXijGCjJXO5RC9eVh9WYlM3b5zk03bOVnuIZZOotvPPZTW+foWlSDE9VeeK5pyseX0UTJfgD96256/LDog7agDT1PET1TSe5zZ0NXseqHFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnrRa/tL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21278f3d547so2196035ad.1;
        Wed, 20 Nov 2024 16:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732147671; x=1732752471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eq9bebiiP8fIQTkLf9ydmmOmzDlQUc6vhSMtx1tLiE=;
        b=cnrRa/tL+X/MtBfGdYivuZT5yGJkbJHlFBGsgsDyjj2lxXgWQrw+RLBitXy5ecK1Qv
         hR/ZEDzXmcP2X+U1VKU5Y8kbDjegYJCsRKqfnCfBjIaoV/IaJrvOEQgTywSbSmjIepUv
         krzGeu/Idx6J120H+3wy6Ldty7zh1HXjYG11kQg1Q1dKjg5N9r42nMUtp5JB4vI1lo6s
         erKe+NE5bVtrd810MTzLttOkRUKlEipoMtL9DIW/4xboE/cMUPaIt3fMOWC2gEdUdxu3
         x7MJIaO3QYrB53gSYV5QurLP+hdTzqQ0VtHosZ6p+5SRCYZFPjiOELUelODX04Ao2E6G
         RJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732147671; x=1732752471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eq9bebiiP8fIQTkLf9ydmmOmzDlQUc6vhSMtx1tLiE=;
        b=qwIw7jyWctRwzyXJajobUuJyfOxUd4GYQReZ0TUzkZZAbw/rPyruL2ZEpKK6+oPAdG
         lJn9M8jAbKZ6Ki2lodJDs9wyIdX9H7BmyHtovVMMC/8QTC11xA8HCZyqXqay5X/0UI2m
         y8bsKX8xKQGKM7SJJFxaicvzKu1EDH2rYHKSS8RiZJuCa1LeYiWYQI1bXO0yqR9O06jC
         IpqpZi+AFRH05Owk05HVlkIpU81NGneNRq6ZzaGDzE1f3NRjnNtvyVxyrPA7yLhymOkr
         zNQhUCWD578wu9JLzGNuNWTySmEEudGVtxH+/lCtdtaLL6IJssVn17fMEsevPyoBKSiM
         56Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUp+5KXvVb6JfddxwKeJc2yali+Ti68CGkehzHd0srQKa5YByBSqeU12WnWG0E8/wPByWU=@vger.kernel.org, AJvYcCVWQIpG+Vc97zfIZKFogbO132MKBdBcON3XRf5gfs3GC9B8h8DhOuq3FMg2L6m2KRpa8aOyYLEfDAaxqnpO9iNvcv1S@vger.kernel.org, AJvYcCXdMNoSwyN00kdt2lY/zJO2wuCFq8MrmyemKUlzgnft8piXbMvuMbUMSdOkw2K5MnFa030+k4addpzgZ1/2@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiTPPIJY6WSxNsZSt/0t2uo/LHTxXrAnc5xaQY2Ed0ZrJbEh4
	vXGpOpkrRl/MuCUkQrKmlGQzxp7Ez3H2fP3ReIwSZekGK3G8Es/MSgcSk/+qucXwAMHf6WnOAXS
	F3owkldCk2gB3ZwWLEmhWPUAHMlc=
X-Gm-Gg: ASbGnctuApopL8pp5Odjo/v6DNJBUEV1P/aR++6FLE8G1s5eq24x3Jy8g7WYeRtLdIe
	9HTY4IjF7eSEQjlrmIo8N+wbDzEB0dt8ste12t6QYd4YYCcg=
X-Google-Smtp-Source: AGHT+IHAiv8UOCaC6pMM2870Co4VuD6SiUYnvQbVnEefg7X+1/KW9GgWAiN/LKtr7Zg7IailsXK3k36oDF5zJEjfoW8=
X-Received: by 2002:a17:903:950:b0:211:e9c0:31d5 with SMTP id
 d9443c01a7336-2126a42e791mr55828975ad.35.1732147670909; Wed, 20 Nov 2024
 16:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net> <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava> <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
 <20241119091348.GE11903@noisy.programming.kicks-ass.net>
In-Reply-To: <20241119091348.GE11903@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Nov 2024 16:07:38 -0800
Message-ID: <CAEf4BzbhDE2B41pULQuTfx0f_-1fn5ugJEdPpweKWZVJetCxrQ@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:13=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 18, 2024 at 10:06:51PM -0800, Andrii Nakryiko wrote:
>
> > > > Jiri, we could also have an option to support 64-bit call, right? W=
e'd
> > > > need nop9 for that, but it's an option as well to future-proofing t=
his
> > > > approach, no?
> > >
> > > hm, I don't think there's call with relative 64bit offset
> >
> > why do you need a relative, when you have 64 bits? ;) there is a call
> > to absolute address, no?
>
> No, there is not :/ You get to use an indirect call, which means
> multiple instructions and all the speculation joy.

Ah, I misinterpreted `CALL m16:64` (from [0]) as an absolute address
call with 64-bit displacement encoded in the struct, my bad.

  [0] https://www.felixcloutier.com/x86/call

>
> IFF USDT thingies have AX clobbered (I couldn't find in a hurry) then
> patching the multi instruction thing is relatively straight forward, if
> they don't, its going to be a pain.

USDTs are meant to be "transparent" to the surrounding code and they
don't mark any clobbered registers. Technically it could be added, but
I'm not a fan of this.

I'd stick to the 32-bit relative call for now, and fallback to int3 if
we can't reach the uprobe trampoline. So huge .text might suffer
suboptimal performance, but at least USDTs won't pessimize the
surrounding code (and kernel won't make any assumptions about
registers that are ok to use).

