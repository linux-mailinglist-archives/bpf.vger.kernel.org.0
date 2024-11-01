Return-Path: <bpf+bounces-43769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A759B9894
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF6028329C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378731D5CFD;
	Fri,  1 Nov 2024 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxfQxMzG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233F1D173A;
	Fri,  1 Nov 2024 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489277; cv=none; b=GDE4gaclnKUJK2mernBH42ywjVjVaU2L/O4IheKMWvT79Ki+m6j4tiAh3rST+L9lS11fxmDGuSeeYo7qgUlV6ioQW9dksmEXtrfvR5fsnsh2dgAHgrDkcrFSgwntLQ6mmFfrR6ckJp+9tj2agmy+xRk+6sNby9wk08QZmDtLKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489277; c=relaxed/simple;
	bh=s61Avs7zSgobVD/THuWizO8AAF88e8p+BibXlbSf6lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQy5cQEn5LfV/N4bPEprxa0yNo51KfSp2yPAX3lFUP9HLR7Poogoq06u7N6zcyh5cnbzaYO4h2GjmAXf2cg72oOVmg3VDEyOQ6Hs+vQtTRlqxIKyG+FYI9ck559GhRjk8ng4KYfgZziocf3pOpPyX7yYJlPSD89grjONZdxZlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxfQxMzG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e23f2931so1753197a91.0;
        Fri, 01 Nov 2024 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730489275; x=1731094075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJa7rQLfYycA/ykj0zqW5gKxLZ5jIBDkEKerYmoG4f8=;
        b=MxfQxMzGQIbmXQ5h800NuTvWeiPx25HQARszl2lqEHtUCHmOkEoKu7rYSc1+KqaBae
         RPqaQwNNeeNKuRVsfJTPWR/a4Mp7700DTWrAlxVJB/gauK2q7J6FVkP4MMbxu+LhKs2+
         CxB5gnuIL7mvW/FOhhMpZ9886cu9RWBEtrjtKiSNWIXmuJVRM97xvo0gBuligb1jTS23
         DMUMA6s6IknysE8cFU67Tp90w8ydgluEcWMTT3j7X0gpfNeRlCMM6CvK7m+zdI+p1p7w
         0DovB6Zi/Vr/dw4rxAkBKfdP+v7aHxGGrTHQIGr7HuX91/CNPo0v4msC76Mb6sbnNIAd
         V0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489275; x=1731094075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJa7rQLfYycA/ykj0zqW5gKxLZ5jIBDkEKerYmoG4f8=;
        b=VnNBJzz27dtvagsPbgKWWvCAiPLkZfQJLfTN7PlozzDCLgnYVhvGv9eXc+eYyPZ8Ai
         tCeprmwhMtU2kkWdj9qZkwnaujhs2nt0cNG4e636odLMPWYArryYM7Spbk0FWKr0DbzV
         YL9dQo1z1l7Ic8OhI7fz6WWXBjW+5REnxhDkmrfM5Aaq52RndFxviirEKyDLWvt65Zv8
         aMlFuBwuPpPBr9fOzrVtwRHQU8m4GwmP6Vqm8dqAHd6k6zqWn4U7y0aVnlu0tbAdebfG
         LpUNkzdHIJb9cvtiyXsucobXyBmvAouH8IAHJwD13GR3dWszQmWQ4rX99pjcuG2O4nN+
         EOIw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4vmsU2cNM9SiUJqZ4TdtIkeL/UccuPQ6k0SO+f8DCAjOFJrfGDZ0xxGgXszLLUCPTlKvsLplExt92Hpn@vger.kernel.org, AJvYcCWtMRODegyn0lUKsbUPlD53Lc5dhWja507j6+VHTZaweDQxGYPCjaGegXMraBuLKDwV+mUbl4lZ@vger.kernel.org, AJvYcCXxvy/F/fTbsd++/C4wxzuuEzlMcKTZBCdxFXPV3HfHCWfPFkibKBuNcySdu9+Wu21tId0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6ELMneYdVU27u2LrUhoWF4Jy4NgyiawgEyz/C3sWAI8P0isy
	o1r9BBkMa/cXX5OK9pEaMZm4nNI3WYTqDvkqTWDDHboBCiftXFiw+DZlfRk1A6HSrxdguwGpOi5
	dvfhAUVtdeGkk2x+R00e9bxNN5Os=
X-Google-Smtp-Source: AGHT+IFs3wBku1BxXBDbM0V1UF6LBJTpzU2ggoOpO/KuHVzmIdRLV3bfwZx22u//QtQ0Ujk0fKJOauZMu8GlvW34cw4=
X-Received: by 2002:a17:90b:1f88:b0:2e2:8bce:3d16 with SMTP id
 98e67ed59e1d1-2e94c2e4cabmr6429806a91.19.1730489275426; Fri, 01 Nov 2024
 12:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101161624.568527-1-mrpre@163.com> <20241101161624.568527-3-mrpre@163.com>
In-Reply-To: <20241101161624.568527-3-mrpre@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:27:43 -0700
Message-ID: <CAEf4BzaMkeCbuaFYHnyHiUSoU9dWWfev73UCPVjmKtB9G+qAMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf: implement libbpf sockmap cpu affinity
To: mrpre <mrpre@163.com>
Cc: yonghong.song@linux.dev, john.fastabend@gmail.com, martin.lau@kernel.org, 
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:17=E2=80=AFAM mrpre <mrpre@163.com> wrote:
>
> implement libbpf sockmap cpu affinity
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  tools/include/uapi/linux/bpf.h                |  4 ++++
>  tools/lib/bpf/bpf.c                           | 22 +++++++++++++++++++
>  tools/lib/bpf/bpf.h                           |  9 ++++++++
>  tools/lib/bpf/libbpf.map                      |  1 +
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 19 ++++++++++++----

please split out selftests into a separate patch from libbpf changes
(but I hope we won't need libbpf changes at all)

>  5 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index f28b6527e815..ba6c39f40f10 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1509,6 +1509,10 @@ union bpf_attr {
>                         __aligned_u64 next_key;
>                 };
>                 __u64           flags;
> +               union {
> +                       /* specify the CPU where sockmap job run on */
> +                       __aligned_u64 target_cpu;
> +               };
>         };
>
>         struct { /* struct used by BPF_MAP_*_BATCH commands */
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 2a4c71501a17..13c3f3cfe889 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -401,6 +401,28 @@ int bpf_map_update_elem(int fd, const void *key, con=
st void *value,
>         return libbpf_err_errno(ret);
>  }
>
> +int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
> +                            __u64 flags, const struct bpf_map_update_opt=
s *opts)
> +{
> +       union bpf_attr attr;
> +       int ret;
> +       __u64 *target_cpu;
> +
> +       if (!OPTS_VALID(opts, bpf_map_update_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       target_cpu =3D OPTS_GET(opts, target_cpu, NULL);
> +       memset(&attr, 0, sizeof(attr));
> +       attr.map_fd =3D fd;
> +       attr.key =3D ptr_to_u64(key);
> +       attr.value =3D ptr_to_u64(value);
> +       attr.flags =3D flags;
> +       attr.target_cpu =3D ptr_to_u64(target_cpu);
> +
> +       ret =3D sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
> +       return libbpf_err_errno(ret);
> +}
> +
>  int bpf_map_lookup_elem(int fd, const void *key, void *value)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index a4a7b1ad1b63..aec6dfddf697 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -147,6 +147,15 @@ LIBBPF_API int bpf_btf_load(const void *btf_data, si=
ze_t btf_size,
>
>  LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *=
value,
>                                    __u64 flags);
> +struct bpf_map_update_opts {
> +       size_t sz;  /* size of this struct for forward/backward compatibi=
lity */
> +       /* specify the CPU where the sockmap job run on */
> +       __u64 *target_cpu;
> +       size_t :0;
> +};
> +#define bpf_map_update_opts__last_field target_cpu
> +LIBBPF_API int bpf_map_update_elem_opts(int fd, const void *key, const v=
oid *value,
> +                                       __u64 flags, const struct bpf_map=
_update_opts *opts);
>
>  LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value)=
;
>  LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *=
value,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 54b6f312cfa8..5a26a1d8624f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -17,6 +17,7 @@ LIBBPF_0.0.1 {
>                 bpf_map_lookup_and_delete_elem;
>                 bpf_map_lookup_elem;
>                 bpf_map_update_elem;
> +                bpf_map_update_elem_opts;

when you are touching unfamiliar code, look around and see what others
did. Did you notice versioned sections in this file? Do you think
adding a new API to 0.0.1 section makes sense when we are already at
1.6.0?

>                 bpf_obj_get;
>                 bpf_obj_get_info_by_fd;
>                 bpf_obj_pin;
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 82bfb266741c..84a35cb4b9fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -190,13 +190,18 @@ static void test_skmsg_helpers_with_link(enum bpf_m=
ap_type map_type)
>         test_skmsg_load_helpers__destroy(skel);
>  }
>
> -static void test_sockmap_update(enum bpf_map_type map_type)
> +static void test_sockmap_update(enum bpf_map_type map_type, bool cpu_aff=
inity)
>  {
>         int err, prog, src;
>         struct test_sockmap_update *skel;
>         struct bpf_map *dst_map;
>         const __u32 zero =3D 0;
>         char dummy[14] =3D {0};
> +       __u64 target_cpu =3D 0;
> +
> +       LIBBPF_OPTS(bpf_map_update_opts, update_opts,
> +               .target_cpu =3D &target_cpu,
> +       );
>         LIBBPF_OPTS(bpf_test_run_opts, topts,
>                 .data_in =3D dummy,
>                 .data_size_in =3D sizeof(dummy),
> @@ -219,7 +224,11 @@ static void test_sockmap_update(enum bpf_map_type ma=
p_type)
>         else
>                 dst_map =3D skel->maps.dst_sock_hash;
>
> -       err =3D bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
> +       if (cpu_affinity)
> +               err =3D bpf_map_update_elem_opts(src, &zero, &sk, BPF_NOE=
XIST, &update_opts);
> +       else
> +               err =3D bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST)=
;
> +
>         if (!ASSERT_OK(err, "update_elem(src)"))
>                 goto out;
>
> @@ -896,9 +905,11 @@ void test_sockmap_basic(void)
>         if (test__start_subtest("sockhash sk_msg load helpers"))
>                 test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
>         if (test__start_subtest("sockmap update"))
> -               test_sockmap_update(BPF_MAP_TYPE_SOCKMAP);
> +               test_sockmap_update(BPF_MAP_TYPE_SOCKMAP, false);
> +       if (test__start_subtest("sockmap update cpu affinity"))
> +               test_sockmap_update(BPF_MAP_TYPE_SOCKMAP, true);
>         if (test__start_subtest("sockhash update"))
> -               test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
> +               test_sockmap_update(BPF_MAP_TYPE_SOCKHASH, false);
>         if (test__start_subtest("sockmap update in unsafe context"))
>                 test_sockmap_invalid_update();
>         if (test__start_subtest("sockmap copy"))
> --
> 2.43.5
>
>

