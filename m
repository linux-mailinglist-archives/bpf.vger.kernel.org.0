Return-Path: <bpf+bounces-41280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED09995693
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BC11F25B51
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AFD212D14;
	Tue,  8 Oct 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOn95lso"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F31E04A9
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412246; cv=none; b=hNbbePWX9TLUANy+gXcsZKAgw4PGxxlVwCQt5i48EeV+dmuGqhg2jinMfMS9AASPNL2ls9cUtpI3eVCx92Z3v8RAHssErAjU/uk01tY4/T/JBvwi0/qpqz4/1fhapkF1ViTe+lVIetUhfRje+UT4Zd/WaD8X6c3eeNw67bVtFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412246; c=relaxed/simple;
	bh=NDwFB338/+9p3H3doK7BhMTkR8AiuF9kJO/eeGbfaW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k62ygkzcLsvzQ1JEiknlpljgpjslnM/fa+BUxC6MlqVwc8VgE9PicN02lVBNIXGZ6irzgqiJaXtWysryy5cPzajv+2d09rH6ggKhwcTZwRmsjZKLERrzbWZyk8U+YUxLCSfYCNqBXnB1ZE4iJZnmtw/wGMR/wwHdMXndZQeeJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOn95lso; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so679060a91.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412245; x=1729017045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvU75VYeJleJ0AQpiisAHqj/6VTknXAuTJyQ+xc8N38=;
        b=gOn95lso2WUw9gIt6TBjocHt1AOJbIAg/1e1YrNG2ZyRhNS0Av9yT4kmXmmd1FSZpG
         TUoWZWMsqMgjmYL+a/1MxHgWnvu7j0GtZnum/zipZsRiGXfFnCRr7yV3AmL4bSPl6QUK
         +YhMwwL76qHb3OYEj1XAgysbqyI7yh14L0W4Cv/XyFFkmr57XYawPxMxLxWAZ/RG+woV
         iC0+wnLPQKvIHiu86bGgdOyKtkPJugVFP1X0ix6bI2awOvWQEuyxtjkvI/Gk11xIW9s9
         HtZWQ5DXGJsxim0KQp6WzzbJbWUUiDqHhYOR0Koxbhwf/SG+K87XoSntFxFLVU43sYVl
         bVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412245; x=1729017045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvU75VYeJleJ0AQpiisAHqj/6VTknXAuTJyQ+xc8N38=;
        b=eqU3Oxyf3j4HSYCrgvheJSNBpsAjQr3MMsKNPDGAsd9GSSezcbZA4QtTqRL9BHygY6
         28HYh1MXwlFAMSFrA3otH+vLSCtM5L+AUYH1gEfeS4+gBWOk0Fo3If0O7UF8R6FGL4pu
         r4Ynz8lKCE7MIZpW9ZxzCF6KdaydrE43FAE92azu7VsSHskvBlwk4lQM9sTxRXmY2SMO
         LDCW08HjCqRGyELYQZrfeg8DF+wL47t8bHwkNn85yZz6Anp6NX/uLYSpQ5vLOa6xEuR9
         OJtVtcGWGjA3h2qUcA+A4ZtxMFEGunYrDrLaoJlyiarAouvC4qb+tEV3RZeS55yKmtof
         Ek2Q==
X-Gm-Message-State: AOJu0YzlVlMMLqGF4kpMzZktPr2wBeyUALbrL2FM+N6Hy1hMJejG4JEG
	MiFjTvMqUmmAVmEPbKn3D0waRlpR02OfLindUX6fejwc+vIeOkCSY11mvZstNv0Tln/Jl5Tyy1G
	4zdxHJSpCCrgWDdsvGP4VABrgv7M=
X-Google-Smtp-Source: AGHT+IEuPd7+DUyZGIf7tm5Nedvv1RYvW5Ok0l4auEGA4ACeAhLLJptI8idd3lcASjWMAnd5g0zEmBnW5OR2iWEWhC8=
X-Received: by 2002:a17:90a:4bcf:b0:2e2:991c:d7a6 with SMTP id
 98e67ed59e1d1-2e2991cd93bmr1108626a91.19.1728412244533; Tue, 08 Oct 2024
 11:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com> <20241008091718.3797027-6-houtao@huaweicloud.com>
In-Reply-To: <20241008091718.3797027-6-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Oct 2024 11:30:32 -0700
Message-ID: <CAEf4BzZ2J+Kd3wHNUM92ro1ikD3kqMF9zXEMPbG7u=GAVev3Xw@mail.gmail.com>
Subject: Re: [PATCH bpf 5/7] bpf: Change the type of unsafe_ptr in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com, 
	xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Under 32-bits host (e.g, arm32) , when a bpf program passes an u64 to
> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to save the
> content of the u64, but the size of bits_copy is only 4-bytes, and there
> will be stack corruption.
>
> Fix it by change the type of unsafe_ptr from u64 * to unsigned long *.
>

This will be confusing as BPF-side long is always 64-bit. So why not
instead make sure it's u64 throughout (i.e., bits_copy is u64
explicitly), even on 32-bit architectures?

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6c0205d5018c..dee69c3904a0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2852,7 +2852,7 @@ struct bpf_iter_bits {
>  } __aligned(8);
>
>  /* nr_bits only has 31 bits */
> -#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(u64))
> +#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(unsigned long=
))
>
>  struct bpf_iter_bits_kern {
>         union {
> @@ -2868,8 +2868,9 @@ struct bpf_iter_bits_kern {
>   * bpf_iter_bits_new() - Initialize a new bits iterator for a given memo=
ry area
>   * @it: The new bpf_iter_bits to be created
>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated =
over
> - * @nr_words: The size of the specified memory area, measured in 8-byte =
units.
> - * Due to the limitation of memalloc, it can't be greater than 512.
> + * @nr_words: The size of the specified memory area, measured in units o=
f
> + * sizeof(unsigned long). Due to the limitation of memalloc, it can't be
> + * greater than 512.
>   *
>   * This function initializes a new bpf_iter_bits structure for iterating=
 over
>   * a memory area which is specified by the @unsafe_ptr__ign and @nr_word=
s. It
> @@ -2879,17 +2880,18 @@ struct bpf_iter_bits_kern {
>   * On success, 0 is returned. On failure, ERR is returned.
>   */
>  __bpf_kfunc int
> -bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, =
u32 nr_words)
> +bpf_iter_bits_new(struct bpf_iter_bits *it, const unsigned long *unsafe_=
ptr__ign, u32 nr_words)
>  {
> -       struct bpf_iter_bits_kern *kit =3D (void *)it;
> -       u32 nr_bytes =3D nr_words * sizeof(u64);
> +       u32 nr_bytes =3D nr_words * sizeof(*unsafe_ptr__ign);
>         u32 nr_bits =3D BYTES_TO_BITS(nr_bytes);
> +       struct bpf_iter_bits_kern *kit;
>         int err;
>
>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(struct=
 bpf_iter_bits));
>         BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
>                      __alignof__(struct bpf_iter_bits));
>
> +       kit =3D (void *)it;
>         kit->allocated =3D 0;
>         kit->nr_bits =3D 0;
>         kit->bits_copy =3D 0;
> @@ -2900,8 +2902,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u=
64 *unsafe_ptr__ign, u32 nr_w
>         if (nr_words > BITS_ITER_NR_WORDS_MAX)
>                 return -E2BIG;
>
> -       /* Optimization for u64 mask */
> -       if (nr_bits =3D=3D 64) {
> +       /* Optimization for unsigned long mask */
> +       if (nr_words =3D=3D 1) {
>                 err =3D bpf_probe_read_kernel_common(&kit->bits_copy, nr_=
bytes, unsafe_ptr__ign);
>                 if (err)
>                         return -EFAULT;
> --
> 2.29.2
>

