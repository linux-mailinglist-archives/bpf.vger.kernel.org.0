Return-Path: <bpf+bounces-54863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB3A74F2C
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118EC164C11
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE861C8FD7;
	Fri, 28 Mar 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir+RP5et"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566823CB
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182519; cv=none; b=c7hDW3ABua/+chXtsZevgszDsiYBh4hTnWvREtILcLEU9tk533FUjnhdVoSnuyfBsenS3ltxXQISdgx8049KQWvOo/UH1UNuq3Brwzuwm0BC0UsC5jtvMl77HWa6p0ap5izMsnVC46m/TKBgGIrha29UGQkDxB2OGhNDelCIpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182519; c=relaxed/simple;
	bh=LJhEmdFTwSEQgmi6em0HR+PW3qTkOAsaTNGOUALza/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4n/xsLf9zRkZuNr0gpTlPszE0VNubUXEPdXwG0Mou59bXD7IQp5AJf4DQrtF3FqYE1GeYKppZguL5xWGAEhXGEkbJE+/UDbjxrPSQ4TQ8vSS8r9pAsywo3Y2wF9b/HeOd8DOdjLEof4FRGh06FakyPjHiFU6dvnm8LwIObwMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir+RP5et; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225df540edcso70257415ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743182517; x=1743787317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLicBjbj/212seg4QYb8w1t4cVicjiCqi7CsUijIHWQ=;
        b=ir+RP5etfLEqeotxVeGT+AvYQofiPqkAbF6eV7dWxn3L6IFeQPs1ek5L4cRe9YIGJD
         +8+dYfKQ9lA0DGJLaxbBCLjylUjnNl0W28w1UST1U+nP904Ay7GYbgjxSXuWROkYfSJI
         p+aK5cZ71vCVVfht0BTGgT45e/ljeDHBy41c0RsrufKe6BTr2jHzcwJgUhyNqJYroL9F
         lbgYFmXppahZM6nAeX5aJjHr9P7ETu0QWHAbV/o0035pwT0WrduWgZEHDONZO/EZbEQs
         AczARdWP26MOcBNWcHpqziC6WamnHwQmG1eLquEmMA/0gtLLGa3bzBvILKJo28PE3t1p
         Ga9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743182517; x=1743787317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLicBjbj/212seg4QYb8w1t4cVicjiCqi7CsUijIHWQ=;
        b=X9fzXSHL51JwoXdVBikjwvsCLMuU4gCnacaKBZg8HzJxJUNR262v+PMmlAnvmWb0Q1
         1ws637tLeOsPIkeHpZkIqP044a8kyWv+smyBkjxOGfwmMJj/AvdH3jhS16lCKWEeH3di
         FOGuHzADexSef82evqE15eNSB/xlxPZRGv6O5at6djIC36/fCiqlJgFWRrCrB6skpgLO
         OTRsQvqh8mQyXMBHP1oP2xC17uO/3mgDh0GvArXbKCA5cjR/nYGjx2EBlARkbOyVCW29
         4wSXm/nV1aFL4cilRDe2ODMNXKo4U1h/jxHPHq+vKDXPzAwkqbgce5BRhFay2ABJjMsx
         96Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWBIHn0O3CDxPJ25Q3ElDKwFQYwTqJ99aNmX+nQ3ykYMvxWZ879cAdcw5vVM9ljLX7qAaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3v/YVNf7Alvh0ZcNcC+zJm9xQ3JtrO7hKiYM+5ieziyzkfRc
	eTGOL60QhkUzD+dStDN1IqYeTEs8aLEqnynWtVxpkCOzEDB2ONWURT4dxmmHjHHaDde6Ukvfman
	n+JrdoPk4yK6o2Sj9F/GoUvp35bk=
X-Gm-Gg: ASbGncupCQhs8VeG6KefBU6Kw6ETvglYx0UeGQvZQVdJLadnAXmQwuf+Hz2qNWeLL45
	AlOy77FrtxFlz0jrAtYqiY44Xofw6UJRMOfeXX6gWgVKRIWkeXx5i+6kLL61LPCz4HidqnMkkHz
	m1mT7W8bDQmw1pP3brt0LGpGnLS89V4rkyad+5xCuQWg==
X-Google-Smtp-Source: AGHT+IGD9gnTAle4v7hVARgWNzQH92AUKyz/2Aw+fO4qQPla0+uGDBX7htTdRj2ekga2Rhq8DuiOuwuQVaJVYAxalx8=
X-Received: by 2002:a05:6a00:1151:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-7397f369169mr572605b3a.5.1743182517123; Fri, 28 Mar 2025
 10:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
In-Reply-To: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 10:21:44 -0700
X-Gm-Features: AQ5f1Jo4A5l75XMtG0rjpoLOVx-PeKVZzfQE16ZwwXMC0yjoz1EnSn26XB6839c
Message-ID: <CAEf4BzaEg1mPag0-bAPVeJhj-BL_ssABBAOc_AhFvOLi2GkrEg@mail.gmail.com>
Subject: Re: Question: fentry on kernel func optimized by compiler
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 9:03=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Hi,
>
> I recently encountered a problem when using fentry to trace kernel
> functions optimized by compiler, the specific situation is as follows:
> https://github.com/bpftrace/bpftrace/issues/3940
>
> Simply put, some functions have been optimized by the compiler. The
> original function names are found through BTF, but the optimized
> functions are the ones that exist in kallsyms_lookup_name. Therefore,
> the two do not match.
>
>          func_proto =3D btf_type_by_id(desc_btf, func->type);
>          if (!func_proto || !btf_type_is_func_proto(func_proto)) {
>                  verbose(env, "kernel function btf_id %u does not have a
> valid func_proto\n",
>                          func_id);
>                  return -EINVAL;
>          }
>
>          func_name =3D btf_name_by_offset(desc_btf, func->name_off);
>          addr =3D kallsyms_lookup_name(func_name);
>          if (!addr) {
>                  verbose(env, "cannot find address for kernel function
> %s\n",
>                          func_name);
>                  return -EINVAL;
>          }
>
> I have made a simple statistics and there are approximately more than
> 2,000 functions in Ubuntu 24.04.
>
> dylane@2404:~$ cat /proc/kallsyms | grep isra | wc -l
> 2324
>
> So can we add a judgment from libbpf. If it is an optimized function,

No, we cannot. It's a different function at that point and libbpf
isn't going to be in the business of guessing on behalf of the user
whether it's ok to do or not.

But the user can use multi-kprobe with `prefix*` naming, if they
encountered (or are anticipating) this situation and think it's fine
for them.

As for fentry/fexit, you need to have the correct BTF ID associated
with that function anyways, so I'm not sure that currently you can
attach fentry/fexit to such compiler-optimized functions at all
(pahole won't produce BTF for such functions, right?).

> pass the suffix of the optimized function from the user space to the
> kernel, and then perform a function name concatenation, like:
>
>          func_name =3D btf_name_by_offset(desc_btf, func->name_off);
>         if (optimize) {
>                 func_name =3D func_name + ".isra.0"
>         }
>          addr =3D kallsyms_lookup_name(func_name);
>
> --
> Best Regards
> Tao Chen
>
>

