Return-Path: <bpf+bounces-57366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F210AA9CE5
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A217ABD72
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3981A3169;
	Mon,  5 May 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcsBASlo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA671DB546;
	Mon,  5 May 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474971; cv=none; b=ikzzoUZCAksacd2V3Ya2vPAix0ghDj0cMN7o/w2kIlBzGuhqmA9pUOM70pP5r8JdyHGE4IX6ISP2f93/h3VkBLGc+pDCwebWlYUmk0CGtm525Yv/dazj2vmK54HLWRplZG/oR6dyXqo/STuN6AJiLAab/7VhRTOe6epe/fNRFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474971; c=relaxed/simple;
	bh=qCUXvmUqhcyCPoKTl5ehZqXu6VDtNhrHqEkVjLs0yyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSu0yPWQZR1pyWXjhrLhIJPDKjS3bCOiakSNqKRsa+GSQOiwu2tz7oBB8AshFC5iZWfJchi8L96MZ8AmUUGtp2dq0fW2Y3ZB5Hv7iKFHeywq3VeahOYMpkA0xmOMF9VoTSWqQTGP4cPA/NBESTX7gBO4SosbYe3bk7AU/czUco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcsBASlo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7369ce5d323so4435665b3a.1;
        Mon, 05 May 2025 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746474969; x=1747079769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClxAQPppgd2Iy8X5N0XyEm9lGnCdZKtGonPCoelVhgU=;
        b=FcsBASlorqtxq9RaHpQBaJh7jz2JAivtnS6htlZoc7jsz6ArvaYCks78svPBQjdnMu
         vahGsS+JCCC++dM/PRmE3GOMkKHIA4daAjZN60hnrS8m0xV7T0KJJ/7pbaqJFOgdDvrr
         lsANnhc67rRf6Z/2079dblC3ZCX1mbgziNLIvI5FRI1haJThWNDKMi1N+/pIjCZ5iUJM
         3CM9k66/Dr9nTGB/jm0c+n7/xaBQYx/r2cDVQopdQ57oGH6fxGmr4rJiXnZHvDrtRZSJ
         VnRom9wCPSz2qNAyN7osBxebyfMCuHLzgCaYlNYmHNBnmtbaioGqW52r44uJrG8F0sG4
         Qi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746474969; x=1747079769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClxAQPppgd2Iy8X5N0XyEm9lGnCdZKtGonPCoelVhgU=;
        b=rKZPvtRXib8kqeUlf9PoYXAwRBVNC8/RvvTXlvv98L6f0/CPsClHwNMD+TwgBumeEy
         2Ffu4DLLJ1TC+5SKUbfsMK0PWlZlyIH/wV2Bg/Ycqh8NHlJgTREULF+JNpMwhyEol2WJ
         beWrESfUIonSlPEjeBbaRPbNtMlyHLAc3C0x9sAt422Zb8Iu33/YP7fZvdOxzIgypByQ
         eyfTZTSoTQhIAtR/ySOnhRPtHL4eKpkN5JWf4OwdAEHtTY0u0D3YZiOYub1R+y7sdfMQ
         IE1IMHMQHpGM8FbBjndfSiAl0clqpq+60CCM/6g9hekwoflFDzgBdDM5eGxiqvpy514A
         rn7A==
X-Forwarded-Encrypted: i=1; AJvYcCVY6X3pi8dNYdYZvcbcwIxBJRjEGPzxcEpTIde/CdsW4E0IFq+QL5MaltJomYYIk/bgNhw=@vger.kernel.org, AJvYcCVu+U7n2UOa4wyxCzCyhboWIQ6TAtLP3iBqwzwBwP+2RhkvYTdKyrFDy3V8X7wqiLMx+xFkPc2GUzCRzvW5@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAymx76GxHrHKHKGxcVYL7+PFkc0hCoqS0Xu0VbQH+UMLLugl
	y45Fu027Ia4TTpx1BkSVFr1KV3RMbC23wfWNaZhnKwRR0FaDbkDC6UL8sAXdkC50xZJlVuy883N
	yut7UrymKYNhv93F1WbeWZOrEuYM=
X-Gm-Gg: ASbGnctHQyYwi2icnT6qG5b5tsvdPiuxTFfMJy11LBucUjtlaPkf9OTY7AFfGVRXmzV
	HCcqpVS5iO4Hz6IssxSQdfJc3EzmXcHToVF/1vjhn+oW0aZ52xFvNdD9Ide4UJqcMyfXXHMmwOE
	QONFcTFYwChSes6YgtoLTZOoWQY2SUzO51l274QQ==
X-Google-Smtp-Source: AGHT+IHSgzH9hYq7Sa+6aPj0we494FA8Z9DnavKShCmIWzfetMiJiO8idE/qLvqBhoWdnrVSrCE4SMc8758Vok05C/M=
X-Received: by 2002:a05:6a00:8d96:b0:730:95a6:375f with SMTP id
 d2e1a72fcca58-7406f08c870mr12920733b3a.3.1746474969377; Mon, 05 May 2025
 12:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
In-Reply-To: <20250505063918.3320164-1-senozhatsky@chromium.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 May 2025 12:55:56 -0700
X-Gm-Features: ATxdqUEYjifZBFoMPUUx6eMmvBczjwb9sLZHhzHRZxasMBs9QegzQXToZ0NaBCk
Message-ID: <CAEf4BzZkVg39JqGeuAjypf=WXsOG8JVDS8SSkVLDjHUuHzxoow@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 11:40=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> bpf_msleep_interruptible() puts a calling context into an
> interruptible sleep.  This function is expected to be used
> for testing only (perhaps in conjunction with fault-injection)
> to simulate various execution delays or timeouts.

I'm a bit worried that we'll be opening a bit too much of an
opportunity to arbitrarily slow down kernel in a way that would be
actually pretty hard to detect (CPU profilers won't see this, you'd
need to rely on off-CPU profiling, which is not as developed as far as
profilers go).

I understand the appeal, don't get me wrong, but we have no way to
enforce "is expected to be used for testing only". It's also all too
easy to sleep for a really long time, and there isn't really any
reasonable limit that would mitigate this, IMO.

If I had to do this for my own testing/fuzzing needs, I'd probably try
to go with a custom kfunc provided by my small and trivial kernel
module (modules can extend BPF with custom kfuncs). And see if it's
useful.

One other alternative to enforce the "for testing only" aspect might
be a custom kernel config, that would be expected to not make it into
production. Though I'd start with the kernel module approach first,
probably.

P.S. BPF's "sleepable" is really "faultable", where a BPF program
might wait (potentially for a long time) for kernel to fault memory
in, but that's a bit more well-defined sleeping behavior. Here it's
just a random amount of time to put whatever task the BPF program
happened to run in the context of, which seems like a much bigger
leap. So while we do have sleepable BPF programs, they can't just
arbitrarily and voluntarily sleep (at least today).

P.P.S. And when you think about this, we do rely on sleepable/trace
RCU grace periods to be not controlled so directly and arbitrarily by
any one BPF program, while here with bpf_msleep_interruptible() we'll
be giving a lot of control to one BPF program to delay resource
freeing of all other BPF programs (and not just sleepable ones, mind
you: think sleepable hooks running non-sleepable BPF programs, like
with sleepable tracepoints of uprobes).

>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  9 +++++++++
>  kernel/bpf/helpers.c           | 13 +++++++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  tools/include/uapi/linux/bpf.h |  9 +++++++++
>  5 files changed, 34 insertions(+)
>

[...]

