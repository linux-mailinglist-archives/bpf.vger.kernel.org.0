Return-Path: <bpf+bounces-53249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E6A4F015
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 23:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE307A7D36
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8927811A;
	Tue,  4 Mar 2025 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB7iVAvg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73F278115
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126874; cv=none; b=tj/VcGKciVaYDQ7qb4nAAfdd7OwGHrWneoQTG08utpgGf6Aq7+3aEp59k3QyW3Q44CH85nvvb9cYpSOBBaHymzhSkjAk9XatoZuoZk7y+0t3w+1Ec+PuAyPBmikYnpJOyt0kXLEWnnIRiP9QZEG1R1nAKV021yuB9U5zUHlUCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126874; c=relaxed/simple;
	bh=tZKinVoJtw6DPZhOO7wWa1K/Ei0QLGpXm3vxpMCpKEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ID9XYgxJ5HjaylP21zMeR+FgSjJpnBGc56FI0bYC6EDqIua+3yGmvnY+WLsK5FO9YtS7SGoblfPJmOCB+tQO1jJnvbwBsxb2kOcgNKKanROzBcInTwkVq3Rtq2nZNhksnbmaMOgs4NNoILFCGAIuHkaERP2HXDJOOBlOdLDjkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB7iVAvg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso420205a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741126872; x=1741731672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umJQOC6K5tQAiYNNpbAmZyUV1D4ShaYRRVvkBGbtKF8=;
        b=TB7iVAvgacbUkYKtoV99MVctwN57eM36JRlqligfJp4DOknnL4UOBZ566pw+8i7PJN
         KqsJquV++p5mFZ1L7dY0ZWuReswZSU4wYFYbU6k4phGP1bsYWlU0yvXz7lSbtVirzUCE
         ly3R1iALO1MV8s0S1tzz/V3a7ky690lnnm6f4HOvnWZLMw3uIsw4GlnYEBCbf1NK6din
         TnE1CU5VXRzLM6an9bhuQlRU9FZw3MjIPRjqWIgG4kWqqNbxOcgPG1JNkLmZQkHIRKkx
         Iz0kot4+xoPJ1jPfRwxf5BgPk8DR+pIGc6T2GOTIJ7t3mqGBJKYVe3RQsgpKtlYBG6Hy
         UO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126872; x=1741731672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umJQOC6K5tQAiYNNpbAmZyUV1D4ShaYRRVvkBGbtKF8=;
        b=K8aeVH1+cobs9LHltNK/QNG5yWkET61/rheZYw1sm88SaBqtqxoQ0qYPYjwQ2WKVgS
         SaQ/ADsA2uqte6UvKJQbIbci0Oqez9sBzZKdYvdH20WZFFC2MkEL43y2pwsZca9ymkFz
         FQX8gySxO8zur2F429JgL0oEExsCtg5q/BAYryLf0BwUwjX1Rkyf/UKMCJ6SD2McO8Hp
         AmDFGiBAd1qgDTGNEa+V418GQntkY42uQTNsKcLMz8reFaATcDl1aOudyXDoIq2cjLGt
         GLvKqppf9+oYj1D4WblMrXtHOTDt/7y4A3nT5zQ5OQ1ji2V6Q6912VqFNbISH40VL6pX
         dz/A==
X-Gm-Message-State: AOJu0Yymi9ay12jxujkHqbKul8Iuag/WCWvgzoRNdETOL2g3Hvnm1wet
	vHv/jtwrQFM/xBhe5W/Ha3rG6RcJgvpkbsD+WByJc+osjZHM5FEUYPnHz2peRUYfI9QVZGkeqq0
	fK7L9uucS2AHIGvqdNA4efFSHrbc=
X-Gm-Gg: ASbGncsqUV7bd4UVkkOYof1i+sNZEIFc5p2m+g0btQalwRqz5e3WDcqb+AHRRIk7lTp
	HlV+LE8kjmwYFVZhh3PomByPGJm6mht4LnSQLX5eRvDIDPaMOaLLlLuoLhmDmfp7+zx7p8pSjYI
	c0CexHRxOBNfsffKFBzxqIWVgM11KPrRVc+aSHv48I1w==
X-Google-Smtp-Source: AGHT+IHkmZJroilfgI+Krc40XwlBkErciar/iwvFINcA8PWok2utanFVKIVO6Vnn6uSehW4UuDxAgxvSJwb/o6kMSsM=
X-Received: by 2002:a17:90b:384a:b0:2fa:2252:f436 with SMTP id
 98e67ed59e1d1-2ff49a50f49mr1290406a91.3.1741126872513; Tue, 04 Mar 2025
 14:21:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com> <20250304211500.213073-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250304211500.213073-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Mar 2025 14:21:00 -0800
X-Gm-Features: AQ5f1JqaIqzK-14gtF_ofgxZdfMx63DvgtlRyucpj-B2-OHKeS5T-vDHrLIXLwY
Message-ID: <CAEf4BzaZEBZbnxqwFv0_pVEp70aUKNQLJ6UZ1A_Sja+dEoCvLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: pass BPF token from find_prog_btf_id
 to BPF_BTF_GET_FD_BY_ID
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:15=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Pass BPF token from bpf_program__set_attach_target to
> BPF_BTF_GET_FD_BY_ID bpf command.
> When freplace program attaches to target program, it needs to look up
> for BTF of the target, this may require BPF token, if, for example,
> running from user namespace.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/include/uapi/linux/bpf.h  |  1 +
>  tools/lib/bpf/bpf.c             |  3 ++-
>  tools/lib/bpf/bpf.h             |  4 +++-
>  tools/lib/bpf/btf.c             | 10 ++++++++--
>  tools/lib/bpf/libbpf.c          | 10 +++++-----
>  tools/lib/bpf/libbpf_internal.h |  1 +
>  6 files changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index bb37897c0393..73c23daacabf 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h

let's update tools/include/uapi/linux/bpf.h in the same patch as
include/uapi/linux/bpf.h itself

> @@ -1652,6 +1652,7 @@ union bpf_attr {
>                 };
>                 __u32           next_id;
>                 __u32           open_flags;
> +               __s32           token_fd;
>         };
>
>         struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 359f73ead613..783274172e56 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1097,7 +1097,7 @@ int bpf_map_get_fd_by_id(__u32 id)
>  int bpf_btf_get_fd_by_id_opts(__u32 id,
>                               const struct bpf_get_fd_by_id_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, token_fd);
>         union bpf_attr attr;
>         int fd;
>
> @@ -1107,6 +1107,7 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
>         memset(&attr, 0, attr_sz);
>         attr.btf_id =3D id;
>         attr.open_flags =3D OPTS_GET(opts, open_flags, 0);
> +       attr.token_fd =3D OPTS_GET(opts, token_fd, 0);
>
>         fd =3D sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 435da95d2058..544215d7137c 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -487,9 +487,11 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, =
__u32 *next_id);
>  struct bpf_get_fd_by_id_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 open_flags; /* permissions requested for the operation on f=
d */
> +       __u32 token_fd;
>         size_t :0;
>  };
> -#define bpf_get_fd_by_id_opts__last_field open_flags
> +
> +#define bpf_get_fd_by_id_opts__last_field token_fd
>
>  LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index eea99c766a20..251071e1ce1d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1619,12 +1619,13 @@ struct btf *btf_get_from_fd(int btf_fd, struct bt=
f *base_btf)
>         return btf;
>  }
>
> -struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base=
_btf)
> +struct btf *btf_load_from_kernel_by_id_split(__u32 id, struct btf *base_=
btf, int token_fd)

that's quite a name we now have :) let's call it just "btf_load_from_kernel=
"

>  {
>         struct btf *btf;
>         int btf_fd;
> +       LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts, .token_fd =3D token_fd);
>
> -       btf_fd =3D bpf_btf_get_fd_by_id(id);
> +       btf_fd =3D bpf_btf_get_fd_by_id_opts(id, &opts);
>         if (btf_fd < 0)
>                 return libbpf_err_ptr(-errno);
>

[...]

