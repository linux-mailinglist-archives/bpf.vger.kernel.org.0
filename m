Return-Path: <bpf+bounces-46536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E033A9EB94D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B95188A29B
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDD82046BA;
	Tue, 10 Dec 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOyieKAM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173886357;
	Tue, 10 Dec 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855197; cv=none; b=brUeBoT940aweMhR+6sGeHwdzql2GasQ+A9oiOF7RQoEw2vVyHkUK6QyVlsaWAtwjAzqWR5kcOjhFRM1mw4fHSySj2ckq+fqBkt/4J8MqoS2JxEkniXrKtSZdHLg9q8tEPnFlpQy57wPLDrPOcUoW0Y66YhcLHMPvSKRM6dSBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855197; c=relaxed/simple;
	bh=Zq7vdqFd+Tv+nwBb4JDwVuJb5atrVzji/fF/VcbJ7qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1WnMSvtiKF+2+QR+ycNutfNT6Hyp3lnlCkX1dBUyyi/i5NiPb1fAUm+sG94D8bPPVLHlE/jyWOAQAwOett1+pwaNyWcrQ554mFoEkspSkBi0pfBDMz1A2uFIlJnT3kKbQnqNe9hhsE8i/KLQcGChV9NZY1HdDAvNFzgKp8KwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOyieKAM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2164b1f05caso26506725ad.3;
        Tue, 10 Dec 2024 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733855195; x=1734459995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAfTRPNVOivBU4pBJWCSlYqGMyfDH4eBWxGu2g9yRLc=;
        b=hOyieKAMOtPiEZk3/O8m5tWl7Ds3BYbhrdZIFY/M2PF0JUOwMmvWjK9vcgR4b3akwD
         zkn8eFFiCCYa0Cr2UtsCVxW53VA4HzjNmR0YKRY+hQELXaIqCjYxOKO/XAV+bwXOhkv4
         xRQf9tuwh+/9HkDifrE3uqdxjNcxDaGnfT4W+SsbwG0Mp8+5trL8t/YWLpZOVYUE489b
         Z7Y6nkpVdxCX+Apg7B23GvjAUAvw/7EkjQJri5EZya6PFoYmt1P+3HaDiJaVP74ir1E7
         ywin1Sj2eX89gRkclBEavDqhkqAP0+GLR1rUgzYat/MD1TyMZKNnC7UH7VGQPa7VnAen
         usDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855195; x=1734459995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAfTRPNVOivBU4pBJWCSlYqGMyfDH4eBWxGu2g9yRLc=;
        b=wyhOH1k7jtYm91LclDTramj7jT9dtqN9TGd1Zppum7TN2r7aDiE7fsxaHhgDVaTKI+
         sC1i2T2+mjMmcNTM3Zc0GY09BOrEF5HNWpj0J3DEzMakuOtm6gRVvYZvL7gQKnoq4MUK
         iZqa2q/jMHW/39m6cso2e+fnGUAPVkohYiuQ1gAfHWd4jJ8nCx7ITfy0222HjZ3CFyyK
         I5opNbz7CT88vu2Oat6HMtSTBfwUx7gZoEa9ReXvT/WT8frYrsVa+3fGu8tMaO2rofDT
         9Jc5B1NDrNRYiY5RhmfKYwZpY0iodo8g/mWeVXXSQ/QKh+ipW+PojpHZUBLyCk9KHVUo
         0sCw==
X-Forwarded-Encrypted: i=1; AJvYcCUIepfDHTHCVR6GbmgGikZMIaTvhM6yL1k2zzCLbpY0O1SCey+swatHkUCbCZ9np17KGAA=@vger.kernel.org, AJvYcCVFOWytjckJMAWbK+lhssgo7EM/x4blYqVGmF770p2rPO8QkCrNI6zvqbNTXR2uDG3lp77Ym2/AthexpaVv@vger.kernel.org, AJvYcCXKi82VEUt+wUfPvw6FBvFaLUVvIB7oJBrDA80JH3fHWX8xBGI/SorBGgudSeR4LLPNGcXVGXk6o0l0nwNDLJZ5AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0CG+44XkpZFyUaYlmJHyc6f3Ncfr76IU4ooaPM2HUfwe0jNR
	W20OiV7LAvj0nsVSOuIEghjfX4cR/OuGkNUAOCdbgNNHhXcQEhTs1dqGjgKVAzuCoEpJtBk8LBi
	SU0M3yVCcBDD/q/7VAT8uyOGsipA=
X-Gm-Gg: ASbGnctW+g2tsO3yODgkBf7hIhw5HPoROnSYP2BmazfY7diVmQYE+BF1ldy++KEK0/u
	CAq+2kW5WBYTmaTeHmFi1H6IYIQxRT2FlIW+5wdXBs3u1FyKG/zk=
X-Google-Smtp-Source: AGHT+IE59Mfbc3iJ5Sni3swSLrEjOt0LIrXU/GLPXv3V6RcOj5UTEqcADfkKTdGXnSwB5L3JSB+8T/76U7WhoE2LU/k=
X-Received: by 2002:a17:90b:3bc3:b0:2ef:33a4:ae6e with SMTP id
 98e67ed59e1d1-2ef69e1679emr32430042a91.12.1733855194994; Tue, 10 Dec 2024
 10:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204213059.2792453-1-leo.yan@arm.com> <Z1DLYCha0-o1RWkF@google.com>
 <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
In-Reply-To: <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Dec 2024 10:26:22 -0800
Message-ID: <CAEf4BzY-WBs6HmrQBUtq-wCWSUUFruvvw9Fuheb3TfCmqbpj8A@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
To: Quentin Monnet <qmo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:08=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2024-12-04 13:36 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> > Hi Leo,
> >
> > On Wed, Dec 04, 2024 at 09:30:59PM +0000, Leo Yan wrote:
> >> When building perf with static linkage:
> >>
> >>   make O=3D/build LDFLAGS=3D"-static" -C tools/perf VF=3D1 DEBUG=3D1
> >>   ...
> >>   LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool
> >>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-=
gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
> >>   (.text+0x113): undefined reference to `ZSTD_createCCtx'
> >>   /usr/bin/ld: (.text+0x2a9): undefined reference to `ZSTD_compressStr=
eam2'
> >>   /usr/bin/ld: (.text+0x2b4): undefined reference to `ZSTD_isError'
> >>   /usr/bin/ld: (.text+0x2db): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x5a0): undefined reference to `ZSTD_compressStr=
eam2'
> >>   /usr/bin/ld: (.text+0x5ab): undefined reference to `ZSTD_isError'
> >>   /usr/bin/ld: (.text+0x6b9): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x835): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x86f): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x91b): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0xa12): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-=
gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
> >>   (.text+0xbfc): undefined reference to `ZSTD_decompress'
> >>   /usr/bin/ld: (.text+0xc04): undefined reference to `ZSTD_isError'
> >>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-=
gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
> >>   (.text+0xd45): undefined reference to `ZSTD_decompress'
> >>   /usr/bin/ld: (.text+0xd4d): undefined reference to `ZSTD_isError'
> >>   collect2: error: ld returned 1 exit status
> >>
> >> Building bpftool with static linkage also fails with the same errors:
> >>
> >>   make O=3D/build -C tools/bpf/bpftool/ V=3D1
> >>
> >> To fix the issue, explicitly link libzstd.
> >
> > I was about to report exactly the same. :)
>
> Thank you both. This has been reported before [0] but I didn't find the
> time to look into a proper fix.
>
> The tricky part is that static linkage works well without libzstd for
> older versions of elfutils [1], but newer versions now require this
> library. Which means that we don't want to link against libzstd
> unconditionally, or users trying to build bpftool may have to install
> unnecessary dependencies. Instead we should add a new probe under
> tools/build/feature (Note that we already have several combinations in
> there, libbfd, libbfd-liberty, libbfd-liberty-z, and I'm not sure what's
> the best approach in terms of new combinations).
>

So what's the conclusion here? Do we apply this as a fix, or someone
needs to add more feature probing?

> Thanks,
> Quentin
>
>
> [0] https://github.com/libbpf/bpftool/issues/152
> [1] https://github.com/libbpf/bpftool/issues/152#issuecomment-2343131810

