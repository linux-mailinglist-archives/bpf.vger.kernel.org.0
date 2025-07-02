Return-Path: <bpf+bounces-62119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BEDAF5B6D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6304F1C42AE1
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B943093AA;
	Wed,  2 Jul 2025 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="T5nllRv3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4A3093BE
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467403; cv=none; b=P+LCs1nMxOqazTvjRQO9wpt5gW7k/GJgAKS1AAEEQVSU5OPEAHRjtHwwXm9NP9BLD0RvHgJgeQqXtpb4FpnM+BZqwAx7GAcWelkZO2UfQWdFhWfyF1E2luS7jn6Ms+8b9rXdhtfoVgu0lKxHJ/L7VvKG7sPKhIvSGqhwBVgP2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467403; c=relaxed/simple;
	bh=7ieYX4P9kh5BODj3dVJPI6gxiqyUatebNgpEcZcKuug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1PAEf2X4N6xGbuHAyVXYHspnfByh6qCRkaKVrPoZvaoMXR+uH0soYGIEZHVl+vqopnpEjppXoK4nTlTGtdee4LxBqvFlcjmTAnx6ZxI60Dd8eb6rfLiEN0WJx3TJWzFzjiyBRlNtPM1zRggIHTjc6mLKuYNiKjNvPeYY17oASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=T5nllRv3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-714066c7bbbso78231447b3.3
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751467399; x=1752072199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHS1u14N2gIiDSZbEMedtJN/zBInsexmRoO8Wae5rF8=;
        b=T5nllRv3fG7SV3G283c4KlyGtHZpDMj7pDJKwoSXhCoaBeLyC5VBKlgp6H8+ljodhg
         r75BBSdFOKbK2UCmN80S9aWVlnG5Zpnu+oyUMXuQtrPkr7bw0x2mjCYCXZWaqHMlaKCl
         /Ud23bpRVSzBGMTrYktCJWrs+JI0iG5f/xdvgx04dKhKOFjfmIhJ1TFsCqYqpUGoqb47
         kwb1bWfbWtcnzra46+3J46RjztbHovxsbIW1s8OhnBDyXCy8P1TqQMHQS6kQizmaTpnX
         HHfUrebIyIS74mJIk09tNV3N60Y7KwF/VVKvDuL1ctES1FXIsLbqlEy4xRv88V0QCBcG
         pfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467399; x=1752072199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHS1u14N2gIiDSZbEMedtJN/zBInsexmRoO8Wae5rF8=;
        b=qiNMmxaJYeYdLxD/xc7V2isYz+zct+cjeDtD6YD6eHKQkkS64cOOy5OZGxw+Bp6b0O
         5B9XwwpVmscTfPUQU4dRnm4uQyHQnhwgLYuja9FrcXXeovfqmlWwbr8vWui7WK5Ki9XX
         CFFkQGezNYW8HPPonkcR6/vVtyGw0byuqR7xS85ttm7nrw/raQzYSQAr1fs8rQ1LjJJG
         WItdD0XSAeKdDrmoK5t4sLrrVBY593Gut+XKDRFOzd56RWRQkNYJF6OS96soyHGDFZ7w
         p8X4UXcMRLUPferhB+/lHh8Fh7D3TIOkC6hhwOwqnrW67oGEGZk1wtCgzmjoEUT8yltg
         wN1Q==
X-Gm-Message-State: AOJu0YxYUKnOJTKwzj3EhpjcAW9MKjknXVEgkc6RrvWQx7L0mbHRYvvu
	17R9Ox4JlwGZdtXdc6f3iJKp/vMsr1cviVJJ+DKDRXyl3yTKyBrHFzyIxkSAqIPys516OWbv3yr
	TRL0L9qZBMmyYaPnxLjDcLGBYuQvCBMfoSdiLSghQAZdms3l7GQ4BKIwLuA==
X-Gm-Gg: ASbGnctrD1EjB7Fp00p643XJeVySrjQ4nHonKtPd/lAB6i5qlcGS9CHqM7MI+DDxJc4
	6p2Lt8b1Zzin8I9JswsSPRuPgyUNdM8vX6FqgTGdZjZfRkJZjPVVdZkBaBbqoQRfz5+VbAkoR27
	apdDHcIzc/Lk8EFs4AZVUFobXzk03P0/+WnIB4oENgMAmn
X-Google-Smtp-Source: AGHT+IHzi+uA1WCZkFX9NN7h+XPdx+EK6iWJXeUs8NACvVabOrEwc+rbl+GuTkLvCzcq+ElDTjktVCM7mJXx09SgiR8=
X-Received: by 2002:a05:690c:6c11:b0:70c:a854:8384 with SMTP id
 00721157ae682-7164d469f4fmr46670827b3.11.1751467399306; Wed, 02 Jul 2025
 07:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-2-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-2-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 2 Jul 2025 10:43:07 -0400
X-Gm-Features: Ac12FXyQGD6FS8DdpQLpT0Nc0YAdenr4A0sJc5OcM126vLAD_rDFIl8UaxItr7A
Message-ID: <CABFh=a48_BDA8B0t_ne6bwEup4cDMg6Mm3Q8FwtDi_F4mL0R8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/12] bpf: Refactor bprintf buffer support
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Refactor code to be able to get and put bprintf buffers and use
> bpf_printf_prepare independently. This will be used in the next patch to
> implement BPF streams support, particularly as a staging buffer for
> strings that need to be formatted and then allocated and pushed into a
> stream.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h  | 15 ++++++++++++++-
>  kernel/bpf/helpers.c | 26 +++++++++++---------------
>  2 files changed, 25 insertions(+), 16 deletions(-)
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5dd556e89cce..4fff0cee8622 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3550,6 +3550,16 @@ bool btf_id_set_contains(const struct btf_id_set *=
set, u32 id);
>  #define MAX_BPRINTF_VARARGS            12
>  #define MAX_BPRINTF_BUF                        1024
>
> +/* Per-cpu temp buffers used by printf-like helpers to store the bprintf=
 binary
> + * arguments representation.
> + */
> +#define MAX_BPRINTF_BIN_ARGS   512
> +
> +struct bpf_bprintf_buffers {
> +       char bin_args[MAX_BPRINTF_BIN_ARGS];
> +       char buf[MAX_BPRINTF_BUF];
> +};
> +
>  struct bpf_bprintf_data {
>         u32 *bin_args;
>         char *buf;
> @@ -3557,9 +3567,12 @@ struct bpf_bprintf_data {
>         bool get_buf;
>  };
>
> -int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
> +int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_ar=
gs,
>                         u32 num_args, struct bpf_bprintf_data *data);
>  void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
> +int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
> +void bpf_put_buffers(void);
> +
>
>  #ifdef CONFIG_BPF_LSM
>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f48fa3fe8dec..8f1cc1d525db 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -764,22 +764,13 @@ static int bpf_trace_copy_string(char *buf, void *u=
nsafe_ptr, char fmt_ptype,
>         return -EINVAL;
>  }
>
> -/* Per-cpu temp buffers used by printf-like helpers to store the bprintf=
 binary
> - * arguments representation.
> - */
> -#define MAX_BPRINTF_BIN_ARGS   512
> -
>  /* Support executing three nested bprintf helper calls on a given CPU */
>  #define MAX_BPRINTF_NEST_LEVEL 3
> -struct bpf_bprintf_buffers {
> -       char bin_args[MAX_BPRINTF_BIN_ARGS];
> -       char buf[MAX_BPRINTF_BUF];
> -};
>
>  static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL]=
, bpf_bprintf_bufs);
>  static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>
> -static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
> +int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>  {
>         int nest_level;
>
> @@ -795,16 +786,21 @@ static int try_get_buffers(struct bpf_bprintf_buffe=
rs **bufs)
>         return 0;
>  }
>
> -void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
> +void bpf_put_buffers(void)
>  {
> -       if (!data->bin_args && !data->buf)
> -               return;
>         if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) =3D=3D 0))
>                 return;
>         this_cpu_dec(bpf_bprintf_nest_level);
>         preempt_enable();
>  }
>
> +void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
> +{
> +       if (!data->bin_args && !data->buf)
> +               return;
> +       bpf_put_buffers();
> +}
> +
>  /*
>   * bpf_bprintf_prepare - Generic pass on format strings for bprintf-like=
 helpers
>   *
> @@ -819,7 +815,7 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *dat=
a)
>   * In argument preparation mode, if 0 is returned, safe temporary buffer=
s are
>   * allocated and bpf_bprintf_cleanup should be called to free them after=
 use.
>   */
> -int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
> +int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_ar=
gs,
>                         u32 num_args, struct bpf_bprintf_data *data)
>  {
>         bool get_buffers =3D (data->get_bin_args && num_args) || data->ge=
t_buf;
> @@ -835,7 +831,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, cons=
t u64 *raw_args,
>                 return -EINVAL;
>         fmt_size =3D fmt_end - fmt;
>
> -       if (get_buffers && try_get_buffers(&buffers))
> +       if (get_buffers && bpf_try_get_buffers(&buffers))
>                 return -EBUSY;
>
>         if (data->get_bin_args) {
> --
> 2.47.1
>

