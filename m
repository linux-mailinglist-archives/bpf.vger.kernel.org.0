Return-Path: <bpf+bounces-76626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D8CBF6C2
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 19:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB48A30413FA
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D139A2C026F;
	Mon, 15 Dec 2025 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU0jMS9O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527627587D
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823015; cv=none; b=p48mQOrwfKSMF1udRPTyWkDgH9dbptWl9KpaMPeJ3IaeZMLx2C7pZjJiOc4wlS9rqZL4k4ZHutYqSX0FVW4gecEcRxRZKG4BeSUXrC9zQD2qNdebC3gKja9rffLSbKrps8uCwBw46qmiMDyyGgAcZeWkL0tctprHF4t1loaj0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823015; c=relaxed/simple;
	bh=iERgVvDELDNyLkgg0UD4/ha6jO7JEe4J8o34FkJuVR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyX6xPhPgGZnIQOP0M+4QBEBHF4N270bLvUzcX0mPj5fuU8GlYczzmUP0uKnlMFFWbux1CpeMXkO/7scSprKLqSm/R6IRgfYFFxtxdEn4btLQCx0K64KA8TzCvZmksvMkv/oIvVHMULphDxuy/T+Tn+IcXSL1SqB2w3lHzvbHgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU0jMS9O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso2194577a91.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 10:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765823012; x=1766427812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLAlAsqPyFMC/0ik6tvBQaaXAy38CJbwFYvBTHiRDyw=;
        b=IU0jMS9OtYC8dkZYf0ti8ijnLcby3swQvkAv4FVJxnkq9VC5lFUr1dtrkxhSXx7HPC
         Sc70XPcGHcEVux2i0CQpwnI8v6zvOypITP1Ys3Y3PPUwCf2RfeF0b0RcKnGA5shV0dKG
         52n9ZOeZISeQkfEpzFU/6GiyEMpouvpzx8HkUXbIv4ojjJEpe+YXLpSFBbR217JBglF2
         BV2gnbZhBcz5DAhss33604CWfn9Wp58vhnCjw+MSkkUvXriZjcVDmRUyGSgk53pZoSmb
         9J83MG+Z7olOrluHCkXHaPXspsk4j1wLd9GkMCaYvf+IJ8dOAIK4VsM/X9R4NzC1WEKF
         kyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765823013; x=1766427813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLAlAsqPyFMC/0ik6tvBQaaXAy38CJbwFYvBTHiRDyw=;
        b=spLL8VTZXqA8DsgA3wr/9KmOhsHCKgThOgkA4WGDnjcibgkuykhqnq5jziu0Y00q2f
         5dAeGQJu1aJnkQlNjGylqe4AV305gdOYQL3EJCsEZP8tKFLX+89wU5ytWu+RrqP0qYz/
         G0yI1EeR62Uns/B9qQpsajPnBMt0vdx5zVMJGOJzcMV8sw/7Lft0iddOhY44NeJ8hUjO
         OOi9VA7dImtHNmzEai2uhDBKTNt2YaRVCkwMHMoshnh6gAQW/omiziGtMsP35M5YahTs
         mf2S76t1xMJ2Esr3Xw0lCKzmQ0KG3o6Nehdvsb/hbX/+3khfw7YEET66s0EJ97DPa1XP
         Sb1g==
X-Forwarded-Encrypted: i=1; AJvYcCXpXHde42E5Mci9SgdwIxPpnT26ARVVh+0/Yb0qfk+g/kKrNP49pnWtzDcUJGeWLsE12JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyaFjjrVZolymDDfZ/0IjvOhJbcDiPNtZc/Zou7UJfqm4hXF1
	rvEwlx3GM0dFZ5zGkNBy66PDMKD0T8NFojK8415nfRuUx7KhLEUigpLCGpqnTOaIT4BdRZ9aqPS
	672uLlp5nNYBpPeLK7h3I+hsRlh8ffKU=
X-Gm-Gg: AY/fxX77cZ0aIj1+IgnLGjdBWGkOQyhNpDIQ97nVCOkpdHHN7NBWjidGuaTmgIHoFdz
	ShejS9UVEf6HCpKlgPk0tYmj7X4cpoclXIGaU8plhWOCBZh5y8NNkH3BLy8j26r+BsREcQzno5Y
	rRKZjlqtdfpx7n1NaciLLYjH81xGaQYoFOVp60lvuSitjufz7g5nA0wj4EDWDzhBTR31YkAQD8R
	UYgMGY3te2HBx06B8YQexdgjOoOKka4aWqi/XafSndcXIVcPLWTyyQxI1QlLAGPcI0Uiwlb9x34
	MRjE0tD9OMg=
X-Google-Smtp-Source: AGHT+IE8tQ3OkO3hxVb9AKZ4E/hZJ6clbrJngBArNu07jF5o8yOp6JHVYLKMHJQLfrdu7AheE93hg3Y+sp8KdzYSFbg=
X-Received: by 2002:a17:90a:fc47:b0:343:a631:28b1 with SMTP id
 98e67ed59e1d1-34abd6d7b37mr11388083a91.16.1765823012540; Mon, 15 Dec 2025
 10:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
 <CAEf4BzZQ_OJehh=5jJgVBUjJBNAkWh2o8Yd9UTa9nFrRO4oAFg@mail.gmail.com> <CAADnVQKtvRhbAVunHrwj_pCsmazddADRvRo5zp5O+k5kc-Eoog@mail.gmail.com>
In-Reply-To: <CAADnVQKtvRhbAVunHrwj_pCsmazddADRvRo5zp5O+k5kc-Eoog@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Dec 2025 10:23:19 -0800
X-Gm-Features: AQt7F2outlx64uGi9wAI3vHX6kOEz8G_Wt6rAEHd33rvNFdQyAPLpvTcZBY6uq0
Message-ID: <CAEf4BzbZwmOCgqhKeyAhEUT0MXyz09cy2dcpB9WCKWP1ikBWdA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 15, 2025 at 9:36=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Dec 10, 2025 at 5:12=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The printing functions in BPF code are using printf() type of format,
> > > and compiler is not happy about them as is:
> > >
> > > kernel/bpf/helpers.c:1069:9: error: function =E2=80=98____bpf_snprint=
f=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format att=
ribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >  1069 |         err =3D bstr_printf(str, str_size, fmt, data.bin_args=
);
> > >       |         ^~~
> > >
> > > kernel/bpf/stream.c:241:9: error: function =E2=80=98bpf_stream_vprint=
k_impl=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 forma=
t attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   241 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__s=
tr, data.bin_args);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:377:9: error: function =E2=80=98____bpf_trac=
e_printk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 for=
mat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, d=
ata.bin_args);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:433:9: error: function =E2=80=98____bpf_trac=
e_vprintk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 fo=
rmat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   433 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, d=
ata.bin_args);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:475:9: error: function =E2=80=98____bpf_seq_=
printf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 forma=
t attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   475 |         seq_bprintf(m, fmt, data.bin_args);
> > >       |         ^~~~~~~~~~~
> > >
> >
> > I just want to point out that the compiler suggestion is wrong here
> > and these functions do not follow printf semantics. Yes, they have
> > printf format string argument, but arguments themselves are passed
> > using a special convention that the compiler won't know how to verify
> > properly. So now, these are not candidates for gnu_printf, and it
> > would be nice to have some way to shut up GCC for individual function
> > instead of blanket -Wno-suggest-attribute for the entire file.
> >
> > Similarly, I see you marked bstr_printf() with __printf() earlier.
> > That also seems wrong, so you might want to fix that mistake as well,
> > while at it.
> >
> > Maybe the pragma push/pop approach would be a bit better and more
> > explicit in the code?
>
> I suggested using makefile and file level disable to avoid polluting
> the code. Even when attr-print applies it doesn't help definitions.
> The attribute is only useful in declaration and in our case it's not
> going to be in vmlinux.h or in bpf_helpers.h
> So having it right or wrong in .c is misleading.

Makefile is fine, even if it's a big hammer, I don't mind or care.

But I think instead of Makefile changes we should fix the root cause
here. And that seems to be just wrong __printf annotations for
seq_bprintf and bstr_printf. They are not printf-like, they should not
be marked as such, and then the compiler won't be wrongly suggesting
bpf_stream_vprintk_impl (and others that make use of either
bstr_printf or seq_bprintf) to be marked with __printf.

