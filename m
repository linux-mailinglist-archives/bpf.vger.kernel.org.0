Return-Path: <bpf+bounces-79172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18874D297D2
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 02:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FCCF303E001
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE93148DD;
	Fri, 16 Jan 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+/ocZAo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A054237713
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525443; cv=pass; b=Gbd2bTudpYXyxZjwZ3In+G9LUQ825IUx2e5aCeEYge/00qF9ZRq+ySMjWdvraLNAkUDMgOAelwsj1QtAn9/MukavoTkCSg9EvkKJeB67nEeM2j6wEzbRmFdgG117KLk5wksjua6hh7xSArJaUnDuqdhQ/svY9BbI7Gv3GwuUImE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525443; c=relaxed/simple;
	bh=/nDSPEoleac2+xpkTHnFfZtCQkeyZqRXyawQC6wb4aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUzu35EnFFgEYKzjbY5YEnzMcsXtH4N1mpvcvvy2qeZ1oxBa/a4MbNmWUdiK+I19L6UEikk8BeMJOY3hAgOeJ9MJvJwCeQfYbM260QubEKTjYxujJAyXQIclvq0dudB4tXI6AgWT/AVAKZX+pMYYFu2ch1woHXYAwPffhAdxlvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+/ocZAo; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c213f7690so980780a91.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768525441; cv=none;
        d=google.com; s=arc-20240605;
        b=F4bF7MZ6eca98rIpCwqVYrMXLS7tqFSco6xATq+92t2Oyvt14pZ5kYi8NF+Z0GvIZm
         Ysj1MMFkvqwAttDSmmfPr8BgLqC0oUmo9fVvJl1OgSsNA36wnSp5BQRzZuQszzHiTbaP
         uYIl97LFTNVh7or9j5NpepLe8Dzr1wssypjomKdtELxzaRIz7dP10H86oRTpUsDiCF48
         457EQEPdefzUVRLluXXMYYZuDD4FrQpKTr5w22HIAItkZm5ynadVGrUZkqh9tnO7dKzi
         mimE3pQoDZItzplpHK+pu1WY+0HHadcFuRsIFfI6tItajAq7IN5GA/UaRBqobvtq5GNe
         0hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AtgvNqeSdjk7ZoyeHzTO1+o4oj79gdVlzDQPPfdYyu0=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=BzO+QVwkul0vvQo2B2LoxvD+9myXsm+O/kjU71dCLVdmJyJqVjMvfl3EC1IJDn9A+b
         rcEZm+ZWfZT4wEMaJUusHeXIBdZs1xtAP73K/S75Qd/dRu/pGZA3eCB/j018Zafaxsl7
         oKgCQ+YbkvSfp8cMz0NCSwmdhsYIvhACxZO8yR2bbHoYbBC9W8RjObo24g7IiOT9zL+K
         4AQYqrUYW6GYFM40K7Q0ycwENnfC+3LNAZkJMOyK1aLqRtXGzb1CpvBKltT2NHsJzZWH
         isjWhXJ6f2hV9QXz7Mytpp3np9t5KzNKs5O8x1G65g+3TtjkIT2iBu1O9QwYfPdvnH3g
         2kmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525441; x=1769130241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtgvNqeSdjk7ZoyeHzTO1+o4oj79gdVlzDQPPfdYyu0=;
        b=P+/ocZAoMIK+62cVb3xUHpGTQitTmI0Ik1vpn4w9m+o7qpJdeNrgZe2Iqdn9IZL/Yi
         +3Ghy3blb9MNiG7PQyOteapCZsj+0sGe5uag9SfvGm1yieVb/EVnGY+lKs6XaXFBVEag
         +ENXf++TL39Gnn3Y/A50Qs9i02H6QzGSzvPQAIN0V5hnByZFZJ8T6x9KVFdjdJJ8TJAY
         41Nx+MepPHtPM+t8Z0dtWskgQs4llrKFaKxglPUAAANbYXpRgTeukmJIjbdL0mTFsBuQ
         CF1HIg0clr4CIUbW/8+RLobMeOrI9XvqntB2f926Feupfm1V55KgUY7OPU2VnD8PrX3t
         nrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525441; x=1769130241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtgvNqeSdjk7ZoyeHzTO1+o4oj79gdVlzDQPPfdYyu0=;
        b=QAzbdGbcjEWRwhMiViwP8jcx2Hmx8pAuwGDeEN84pih/aTxQPjfMcyt8LRl35sbnvg
         V9EhH6tyQ+Bw1HtvqHHPtD2+zSOiO0Y1dyvECxlBBphi0HUnc8CtPRFHgXbFyfVs0Dxz
         YQyisUaMlAhk6t/mrJ3jjlJp74n4xiAZ5DG76tirwvPjHQx9jUvH9o36AQm0mcPs6P9l
         1b3mmo0O9PUMDNNN91EDNVhi/Ja1X3CRSB0gmnZBhMoTvH7fYs3czc+LiANfuBsOws+f
         s0sYolr/PUs02DTSYDx6nJLGLcMv6Ry/8Wqmze6C9gD+I7ZBZsLwbaF6H9Gsx95WNKXN
         wqMg==
X-Gm-Message-State: AOJu0YxbTvaEL3dxPqYyFjyMX/AUSEwcfUJqRUOBgsKofF7KurQqlFAM
	/gaUBgpSFMEh/sCwrtXaQl/3hWaBXpa+/y+ZV0CobVOOR9kfgBbmEK8Jv5L84ISMgbuOxRQ9W4d
	Jc8A2YAOhoZnEI7tUnDPb/omP/3tQsyySHBvG
X-Gm-Gg: AY/fxX4s5UF9J9+twU104qJii6Y839Jr+5btY3MG3FEYc0My86KbxDPp6oQlRBbjmwq
	IRN5K4KrJR70mnjY0GdAwLQWu9KaDqVAVYD9MLNGa5rmDHK8rR/mj2DBeoQrDU1ALiNq3LrxlCT
	kOq6Fw8bMHpNB3BypHdceo8uoY93BmKjCPUD+5PYlulF+X6t/kHMWp0IufDNAcxEHu692NNCb0V
	x/TrkhCaSeJpQig/Bo652yYYj9fjBuflFpBpXJlA/d2BknwI5vVtFsZPSPbeqgCe+t+E5Y1Um4B
	4pq6KSrQ
X-Received: by 2002:a17:90b:1c0f:b0:340:c060:4d44 with SMTP id
 98e67ed59e1d1-35272edb230mr1051322a91.14.1768525440897; Thu, 15 Jan 2026
 17:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-9-leon.hwang@linux.dev>
In-Reply-To: <20260112145616.44195-9-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 17:03:48 -0800
X-Gm-Features: AZwV_QiwsfiIZXloLgetJdC1SzbljtaOOlNq74X8WhHXjQjo2O1x2f53BHYEByM
Message-ID: <CAEf4BzarSrW1aTRcjrheLWqxFCh1FFd7vwJ4OQup1dbT13EapQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 8/9] libbpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> With the previous commit adding common attribute support for
> BPF_MAP_CREATE, users can now retrieve detailed error messages when map
> creation fails via the log_buf field.
>
> Introduce struct bpf_syscall_common_attr_opts with the following fields:
> log_buf, log_size, log_level, and log_true_size.
>
> Extend bpf_map_create_opts with a new field common_attr_opts, allowing
> users to capture and inspect log messages on map creation failures.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 15 ++++++++++++++-
>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index d44e667aaf02..d65df1b7b2be 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -207,6 +207,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    const struct bpf_map_create_opts *opts)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh_size);
> +       const size_t common_attr_sz =3D sizeof(struct bpf_common_attr);
> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
> +       struct bpf_common_attr common_attr;
>         union bpf_attr attr;
>         int fd;
>
> @@ -240,7 +243,17 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash,=
 NULL));
>         attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, =
0);
>
> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       common_attr_opts =3D OPTS_GET(opts, common_attr_opts, NULL);
> +       if (common_attr_opts && feat_supported(NULL, FEAT_EXTENDED_SYSCAL=
L)) {
> +               memset(&common_attr, 0, common_attr_sz);
> +               common_attr.log_buf =3D ptr_to_u64(OPTS_GET(common_attr_o=
pts, log_buf, NULL));
> +               common_attr.log_size =3D OPTS_GET(common_attr_opts, log_s=
ize, 0);
> +               common_attr.log_level =3D OPTS_GET(common_attr_opts, log_=
level, 0);
> +               fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &co=
mmon_attr, common_attr_sz);
> +               OPTS_SET(common_attr_opts, log_true_size, common_attr.log=
_true_size);
> +       } else {
> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);

OPTS_SET(log_true_size) to zero here, maybe?

> +       }
>         return libbpf_err_errno(fd);
>  }
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 2c8e88ddb674..c4a26e6b71ea 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -37,6 +37,18 @@ extern "C" {
>
>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>
> +struct bpf_syscall_common_attr_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +
> +       char *log_buf;
> +       __u32 log_size;
> +       __u32 log_level;
> +       __u32 log_true_size;
> +
> +       size_t :0;
> +};
> +#define bpf_syscall_common_attr_opts__last_field log_true_size

see below, let's drop this struct and just add these 4 fields directly
to bpf_map_create_opts

> +
>  struct bpf_map_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>
> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
>
>         const void *excl_prog_hash;
>         __u32 excl_prog_hash_size;
> +
> +       struct bpf_syscall_common_attr_opts *common_attr_opts;

maybe let's just add those log_xxx fields here directly? This whole
extra bpf_syscall_common_attr_opts pointer and struct seems like a
cumbersome API.

> +
>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field excl_prog_hash_size
> +#define bpf_map_create_opts__last_field common_attr_opts
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> --
> 2.52.0
>

