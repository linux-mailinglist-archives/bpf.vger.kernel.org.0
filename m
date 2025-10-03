Return-Path: <bpf+bounces-70344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913CBB8052
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 22:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145D73C8467
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 20:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8FE21B1AA;
	Fri,  3 Oct 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLoaxSQQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777F17A2E1
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521760; cv=none; b=thYIFUSNIW1kxxPps1ERkPmhe1McbftZmR7bYIZxwMG2AJQlwJU9RW1cxpOYa7Z0Zj61I0Kig+NMogh5XYG+edb959Eg/ypKUwY5lkrM5pLtU/n95NRd7LEK7ckAyKn2Hcb/GmKYHLcf7bgK384Cf23S8mlWk8eYyiHxT9zDqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521760; c=relaxed/simple;
	bh=IFgY3CJVfbo6qp/y8x7wU6PPfCEUnbVjPYHa2UJsr5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udr8NSsfffEHDsZfdCd4sxnENmLoCOqkcIo4LeYKE45vpHNoExEu4PItXRuz1wPEKQSbMzIBp4WEB1w0Yt1cntsrcxbzCCaBFQBJP/KoVJBUAvIdLX+usMUj5p73aEfmPI+GJQHK+m3ZvhHLDfL+xEpwIZGR6d7aPheCjFdjzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLoaxSQQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso2820426a91.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759521757; x=1760126557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqRN7pheGqlvKFjZ5PWdppZhXzdsA+Z5oLozrt3EKeM=;
        b=NLoaxSQQ5ZqWYcVlYidCXVZAGjguM+kAY9o+KOnrVv+BNcO3QYlT48d8ej7kBVoZDl
         lPrP+f6Ky3zp7PfNdsR6VjtCj5pdxWdFp1sV/ud4JeHveBlXzC3xnzcrKKyBRB1mFnmU
         YkvwHUqO1ICOrcBa06AGDIvi3DKL3lPnV+nY+pwc9QQzbDNcargfi0CeB6DCDkyI8AFs
         UrYapUBTFWPrL2xMQNutiXW17Lg1kvEILzq+TPc1CinQo75kz4mbevIzolYzLBqLkS2o
         ZZKeooeD5K6YVcQzqrDeOO5PJwju6AfSH/7XJJDgagTasBGHrBLXIVfzI0LGzblTFp55
         ecaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521757; x=1760126557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqRN7pheGqlvKFjZ5PWdppZhXzdsA+Z5oLozrt3EKeM=;
        b=JICUbrQ1k1GmlsCV66thkmvaR3QFanYWy5BaCYRWDVW2OfPJpHzPp3hEqOaMpFaClD
         O/98i48U+M6uNvHyA97hn5HItAz4z7h/IYFEKOocjsHvGPfvQwo7r8FKziHvSYy2g6vm
         SAjuM42K5JX8oO5hgm+WTZnmBppPx3u/WVygeMIjce0cspThV7Us8LVf/vVt0OxU8rsQ
         H4oK0XLg28cQdtpse9GSlu58IpddPxPKQncCCC0sm6hOJRGULWOJveW3DU8YTrsuG61l
         RQhoI1EiGfrnuqosWnJq0bm3WpWUaeLaufOgwCjL3G52saAUaD4ScrsYbBI9TBwHXFTE
         xRXA==
X-Gm-Message-State: AOJu0Yx82cvHL+jGRjSM8DoB/oBydPRONFOFJ+Pmul5sWj+VSjNOM0uS
	HhVz5dM6IW5JKE/r8fdbD6y5MhWaSXZEys2PuSYUjUcc34gdqQglABk/6dOO/eDHT9sgIDdgI+L
	dVAYZ0HjPy88+ipfU4crGvfnGDaXFIBI=
X-Gm-Gg: ASbGncuLe8gYqg3CemHWdoix46gdmJM+2lo8vKl0gVGR3MKFWZeMfjvjNDGzCY0W9qF
	6cWxY9XZilMq/MtyMFBfnU7d9szUuRG/lbySFDCm+t7bLXJxmeOAL/hKeGKawsu/qH/vUjtsl5V
	9Vou7YU3uG29BRfo+CwkJXu1kQZc03Lqlro47ypkUWqtlUHJ4IU0IDjUEb5NSEXjO87TxKO5yHT
	ygpTEjOxPHji6frTlLyVuQ+H2uyZD+QD4aaa0XJRp8hpQ7ZvKqu5LHqeA==
X-Google-Smtp-Source: AGHT+IHcn0cndKgTw6FwFfuru2PFds6NUSoB1MhQkHstiiaDhK+kZDWnbjSCgnMvUbpz9hnawdtnLOsKzk7BVuyenME=
X-Received: by 2002:a17:90b:33d2:b0:32d:fcd8:1a9 with SMTP id
 98e67ed59e1d1-339c279f4cemr4288600a91.32.1759521757473; Fri, 03 Oct 2025
 13:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 13:02:22 -0700
X-Gm-Features: AS18NWDbmc7l-WV-B8_nvDqFngEHwo0c-T0MD0wTNvmB421zS0xwGqwP04VreU4
Message-ID: <CAEf4Bzbw+udD6Fud2WshVrCK=mGqisjagZrapsQwM=0G9ipesg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] selftests/bpf: add file dynptr tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introducing selftests for validating file-backed dynptr works as
> expected.
>  * validate implementation supports dynptr slice and read operations
>  * validate destructors should be paired with initializers
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/file_reader.c    |  81 ++++++
>  .../testing/selftests/bpf/progs/file_reader.c | 241 ++++++++++++++++++
>  .../selftests/bpf/progs/file_reader_fail.c    |  57 +++++
>  3 files changed, 379 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
>  create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
>  create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

Non-sleepable file dynptr can fail to read, so this test is a bit
fragile. Let's have a sleepable test (fentry.s or something like
that?)

Plus, can you please add a test that validates that we do page in file
contents even if it was not physically in memory? see madvise(addr,
page_sz, MADV_PAGEOUT) in selftests

> +int err;
> +void *user_ptr;
> +char buf[1024];
> +char *user_buf;
> +volatile const __u32 user_buf_sz;
> +volatile const __s32 test_type =3D -1;
> +
> +static int process_vma(struct task_struct *task, struct vm_area_struct *=
vma, void *data);
> +static int search_elf(struct file *file);
> +static int validate_large_file_read(struct file *file);
> +static int task_work_callback(struct bpf_map *map, void *key, void *valu=
e);
> +
> +SEC("raw_tp/sys_enter")
> +int on_getpid(void *ctx)
> +{
> +       struct task_struct *task =3D bpf_get_current_task_btf();
> +       struct elem *work;
> +       int key =3D 0;

this will be called for every syscall in the system, regardless of the
process, so you probably need to filter this by process ID?

> +
> +       work =3D bpf_map_lookup_elem(&arrmap, &key);
> +       if (!work) {
> +               err =3D 1;
> +               return 0;
> +       }
> +       bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work=
_callback, NULL);
> +       return 0;
> +}
> +

[...]

> +static long process_vma_unreleased_ref(struct task_struct *task, struct =
vm_area_struct *vma,
> +                                      void *data)
> +{
> +       struct bpf_dynptr dynptr;
> +
> +       if (!vma->vm_file)
> +               return 1;
> +
> +       err =3D bpf_dynptr_from_file(vma->vm_file, 0, &dynptr);
> +       return err ? 1 : 0;
> +}
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> +__failure __msg("Unreleased reference id=3D") int on_nanosleep_unrelease=
d_ref(void *ctx)

nit: keep annotations on separate line from the function itself

> +{
> +       struct task_struct *task =3D bpf_get_current_task_btf();
> +
> +       bpf_find_vma(task, (unsigned long)user_ptr, process_vma_unrelease=
d_ref, NULL, 0);
> +       return 0;
> +}
> +
> +SEC("xdp")
> +__failure __msg("Expected a dynptr of type file as arg #0")
> +int xdp_wrong_dynptr_type(struct xdp_md *xdp)
> +{
> +       struct bpf_dynptr dynptr;
> +
> +       bpf_dynptr_from_xdp(xdp, 0, &dynptr);
> +       bpf_dynptr_file_discard(&dynptr);
> +       return 0;
> +}
> +
> +SEC("xdp")
> +__failure __msg("Expected an initialized dynptr as arg #0")
> +int xdp_no_dynptr_type(struct xdp_md *xdp)
> +{
> +       struct bpf_dynptr dynptr;
> +
> +       bpf_dynptr_file_discard(&dynptr);
> +       return 0;
> +}
> --
> 2.51.0
>

