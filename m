Return-Path: <bpf+bounces-21801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1A852295
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093E4B21761
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756474F895;
	Mon, 12 Feb 2024 23:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeqV3B7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAA1EB20
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780853; cv=none; b=BlzH/1eJwUmqHTP6q6AADNoJLMuBKP2Hi0efqA5L+dqzoOcZ68UhodRa2Sw1HpEhCpjNndhr2+tTTZclP1yTvYgg/LGj7dEMc5EdPD7nR6ggoO6i34wrC295y1QLfEsbbxOW649yuu/Kaa7spELBoc3fDQZRtqo/FCZazHE+Vi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780853; c=relaxed/simple;
	bh=ElB0aQYi6qg5W3vpk67coQAA6A6ZmLsPgeLLOvUTFuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=di2YcL1ULDhHmFgkyBnq2cAGM+8CvctgGc11XCzBUNtgFAEW4Ru4h/fodxNl3Hv4AoHIurv9sYyaFkV4ne6WpGGYe9yNwTxiYkKoWBXMlI01mPAgJlrtD57eMVIMKi2ylRA7kctgoIGnU8eCwDxZ8TxV+6UzuNf4tFQ5gXoY5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeqV3B7R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410cb9315f6so12073445e9.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707780849; x=1708385649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiQkbqTYDKtAqkX/QCzTTFAJP9oikZLzxIXaAIWMJ2s=;
        b=VeqV3B7RdI7IvZjO4ZE0G3gdyNNwVaVkaceoSJwibJ5V1MHASrTL3sjPfBTm6XTNym
         gKbZLjaNcjUKWb+RStSW+vqmPVeao6zxxVlGARgN8GB0E6pKFSZnClQTFCv3AGudNZ0p
         bXfyJkdoZp0nTY2xSjOj7Oerk+BLw1fbSctGEOhhqXpwUxCTz1o/GWApj1xNLV3yhVyW
         B1wRdORy0Z/WDF1BQ4KBgBX6ziRP8FyynvQDAfNSHdaMBNgynEgZ60HjutWIcMNfpruF
         Zia6JrlTpxyxmgbW/+kusMQogkUj/JMXl0wgRK7CvCRYT2c8VnezHMjDSKZqxv/HhAQv
         1nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780849; x=1708385649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiQkbqTYDKtAqkX/QCzTTFAJP9oikZLzxIXaAIWMJ2s=;
        b=ehofPbR41CvG8v6ESZV5l7q0UbxSoNq37NmdQWZv/OUV08Z4TRJJZx6LLs+1F2r5qU
         NjU5BAsXv4z/m1Do4iy6vdqG/YEneKxRY69JM3qENfVTuKDuTqmuv6zKcPSR2O6pLj11
         EhvrSeKQfYI/xjiYptWZ7zeBQd2Umohiw8Dn9tTDbAgAze/+WFx9WkAmwUZsm2B0/5Ht
         wBE5TwvFnwRmOidxBmJtwPw8JODr1PouR0AwfW2z6LtJW8zrt4+Idbcmw59r/w07Qbob
         XV3nT8odXdv7lfJjFtf32LySoLcASS3Cm2a1QrwAofzixhE5LS7d5kKTlxDbDjL79hAT
         hHfA==
X-Forwarded-Encrypted: i=1; AJvYcCV5GBnlCYPUrI9A9ExHgw1eBGN6qpwUgw1vmDr8C5pzr4RSiErSFeg21IJ01x9U+KCUZiCu+faYBQgma7nBsEkZKI84
X-Gm-Message-State: AOJu0YyCxQ8o/ezrFb20dKOvfWNp4SGTnsct4YvJRLUzy3bxHMAf3dse
	Nh8C/xfYYwngvczycdRUwpiJzL4P1jsOeSb+Ll31ZL5HY+V+xSQ0BaMRkzSws0dHot9fP5wXcOY
	mT6+EnL1w80snDrT6W3qOS2sJfdk=
X-Google-Smtp-Source: AGHT+IFmHIO/h2z74NhMwgvtNJ/IO2eSrTPPPXT2WnZI3bbXdOhzEzIQMJAJ4bk19R1o87032XEkE+dp+GUwnyOtulA=
X-Received: by 2002:a5d:44c5:0:b0:33b:5198:11d9 with SMTP id
 z5-20020a5d44c5000000b0033b519811d9mr5116121wrr.71.1707780849215; Mon, 12 Feb
 2024 15:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian> <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
 <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
In-Reply-To: <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 15:33:57 -0800
Message-ID: <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yan Zhai <yan@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 3:16=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> [288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not tainted
> 6.6.16+ #10

...
> [288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
> [288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
>
> And Jakub CCed here did it for 6.8.0-rc2+

I suspect something is broken in your kernels.
Above is doing generic copy_from_kernel_nofault(),
so one should be able to crash the kernel without any bpf.

We have this in selftests/bpf:
__weak noinline struct file *bpf_testmod_return_ptr(int arg)
{
        static struct file f =3D {};

        switch (arg) {
        case 1: return (void *)EINVAL;          /* user addr */
        case 2: return (void *)0xcafe4a11;      /* user addr */
        case 3: return (void *)-EINVAL;         /* canonical, but invalid *=
/
        case 4: return (void *)(1ull << 60);    /* non-canonical and invali=
d */
        case 5: return (void *)~(1ull << 30);   /* trigger extable */
        case 6: return &f;                      /* valid addr */
        case 7: return (void *)((long)&f | 1);  /* kernel tricks */
        default: return NULL;
        }
}
where we check that extables setup by JIT for bpf progs are working correct=
ly.
You should see the kernel crashing when you just run bpf selftests.

