Return-Path: <bpf+bounces-37645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80073958C95
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 18:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F25D2842A4
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276A1B8E9B;
	Tue, 20 Aug 2024 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqHVddhw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD6125D5;
	Tue, 20 Aug 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172521; cv=none; b=rtb5vo+4FlpQJB0rzAYjw8JGgfwrBdo5a7oS9GlslCrzd+FZe/m1Xdur9FqQXQpfMDR65jS9KiKbHLQvfbTjRO5ez9jmujFJuYw5mFG3/RsYs28NCvs5IG6AFUKSuOLEWcBl6t4OceQa+HD3C3rAndgxk6o0WupaRDBWkPQINqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172521; c=relaxed/simple;
	bh=EY7+jZCbx24zTHEy7TR1y6tkMTvVj0EfuR/scZNnLSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsuZMY8EUz8QsDhfa1y2/iNR9BVS/vRAjj/Yg1u88JsUgIywR8AE6ROJfbiqkQh5FJUg8bX3WLnXbNM1x6fKe5HZr2m7UX34a7172tx+0Zr/q/alEi0k7GG4TmBymPFCNxqF5TjwY6GSlJ+HPKr76Ub8gpfFr3aHV+H0DNjy5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqHVddhw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f01b8738dso4801687e87.1;
        Tue, 20 Aug 2024 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724172517; x=1724777317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY7+jZCbx24zTHEy7TR1y6tkMTvVj0EfuR/scZNnLSg=;
        b=QqHVddhwyC/aAq9KNDFaRWG1qy3Y8KEL37u/GpHMUhbkCwqmPH76y0aDjbqMqAm6CW
         et3joFY21+H/eTXePlczmQYXmVprv/gSgN/VlyJWRv9l6RAoIreiAiGTKG0IOIMs0cZ+
         vJDOpnf2yT3E8u3bHZ5OBvPPYWAAw++q6xx2fEoXu2wkXm11CWA/1JlahzSu0s4JSdDZ
         B3fm+jjsBbefST7AS1Cvt965H1zrl7RD+9o6xTyvbPVFIc+nFNHNe8QpYovRBjjAroEp
         PLHdD+fXfr7BUhjlte9Gvil/dWxtzQcmNE38pTkHKlocOIuW3REF8CmE9jzKFcOqXbxp
         axBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724172517; x=1724777317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY7+jZCbx24zTHEy7TR1y6tkMTvVj0EfuR/scZNnLSg=;
        b=AzMswbDTNOCMG0diUmlwgLdh0f+IaLYvv3wc5Ye/e3l4E1QXGAXNEKYEYfD9RG3Kvx
         dJqBbT1jRfP6nxcR8CezxSrI3SUhbGiZwqX2kqWio6sDU7DdlA9l9zpL/L2bMs8psdTc
         gMpd476eK9NZBT1+Z13Q4mqy1x700TaA5cJOm8oG98Y+A13e7tfVz9i+KcvKuDXbFHvE
         4MSSsXE7CKcjQT71jjwGeJiQsJtCZHmgJ08uahyos/Vzhnv6XppO1UwTokbTKedrV3CJ
         +hhL+nvaR3y3C/ND9yD5FIA4qGLyeJn1CPOZdmKoPCVBXXuc2igtzOFts/aer01vK1EN
         j21A==
X-Forwarded-Encrypted: i=1; AJvYcCXSsKSeE7r4G3REDop/2b662ae18y0MIZyiPLuPri5ebLw3ECqlBtWTjrRBqYuTlWsCYoiUmFHad8l59ItIZwNr797x
X-Gm-Message-State: AOJu0Yx6hS5LH+8BI7fyWHPiKbZQ3LqSkr4KceU0ilrh7y+469PpnIX4
	sizEA9LgekaUhTScuxd+RnplC7swG33o1GF+tBboVeVkiRcQ+rWEBz9V2aF+E1FEYPtyuPDF/rf
	G1sMeOa2k/RZAc4jWB6fLUgk7pPYiazP+CGo=
X-Google-Smtp-Source: AGHT+IFP/T4v4jfCI8OdiHlqJ69vXMH35zvQmtaQtvJe/OTYFWS5FVNj32ofA3JgQ1DnrYOe3Qw30HzTtKuWghcguSs=
X-Received: by 2002:a05:6512:6cd:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-5331c6dc867mr9778925e87.40.1724172516553; Tue, 20 Aug 2024
 09:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEg-Je8=t_cXKsWL0XSx3vF1gsArSWpychfbEf+yjM6wVz3Mjw@mail.gmail.com>
In-Reply-To: <CAEg-Je8=t_cXKsWL0XSx3vF1gsArSWpychfbEf+yjM6wVz3Mjw@mail.gmail.com>
From: Matthew Maurer <matthew.r.maurer@gmail.com>
Date: Tue, 20 Aug 2024 09:48:24 -0700
Message-ID: <CAM22NNBrXSUbrpFAKv8jrREKTBYx_aW0cibtDE5AZ_kTijUrPA@mail.gmail.com>
Subject: Re: Weird failure with bpftool when building 6.11-rc4 with clang+rust+lto
To: Neal Gompa <ngompa@fedoraproject.org>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	"Justin M. Forbes" <jforbes@fedoraproject.org>, Davide Cavalca <dcavalca@fedoraproject.org>, 
	Janne Grunau <jannau@fedoraproject.org>, Hector Martin <marcan@fedoraproject.org>, 
	Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry that this isn't a solution, but I can tell you some background:

Linux currently relies on the `--lang_exclude` flag to `pahole` to
filter Rust debugging information out of the output BTF. This is done
because various downstream tools (for example, bpftool) do not handle
Rust types correctly. The `--lang_exclude` flag works by checking the
language flag on the compilation unit the type is referenced in. Once
LTO is enabled however, things can migrate from one compilation unit
to another, leading to C code having Rust code and types referenced
inside them. The resulting type will be considered C-language type by
`pahole`, but is actually a Rust type. Even if you fixed bpftool,
without additional patches/hacks, once the kernel boots it would
likely fail to parse its own BTF debugging information, and disable
BPF loading.

The most confusing part to me here is that I only encountered this
issue with x-lang LTO enabled, which is not available in the kernel
you're building from. If this is happening without x-lang LTO enabled,
it likely means that there's another way for debug symbols to leak
across CUs during LTO. That's where I'd start looking - use `pahole`
to dump the contents of `vmlinux.o` and see if you can find a
C-language CU referencing a Rust type. Then, try to figure out how
that's possible. With x-lang LTO it was obvious, inlining caused a
bunch of issues.

The last possibility I can think of is that somehow in your build
configuration `pahole` is not being invoked with the `--lang_exclude`
flag when building `vmlinux`. I don't know why that would be, but it
might be worth double checking.

On Tue, Aug 20, 2024 at 5:13=E2=80=AFAM Neal Gompa <ngompa@fedoraproject.or=
g> wrote:
>
> Hey all,
>
> While working on enabling Rust in the Fedora kernel[1], we've managed
> to get the setup almost completely working, but we have a build
> failure with the clang+lto build variant[2][3].
>
> Based on the build failure log[4][5], it looks like there's some
> random mixing of Rust inside of C code or something of the sort (which
> obviously would be invalid).
>
> Can someone help with this?
>
> Thanks in advance and best regards,
>
> [1]: https://gitlab.com/cki-project/kernel-ark/-/merge_requests/3295
> [2]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?p=
refix=3Dtrusted-artifacts/1419488480/build_x86_64/7618803903/artifacts/
> [3]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?p=
refix=3Dtrusted-artifacts/1419488480/build_aarch64/7618803917/artifacts/
> [4]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-arti=
facts/1419488480/build_x86_64/7618803903/artifacts/build-failure.log
> [5]: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-arti=
facts/1419488480/build_aarch64/7618803917/artifacts/build-failure.log
>
>
> --
> Neal Gompa (FAS: ngompa)
>

