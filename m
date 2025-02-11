Return-Path: <bpf+bounces-51188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF44A31891
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 23:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FE21687EE
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18871268FDC;
	Tue, 11 Feb 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZidp6tz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DA267714;
	Tue, 11 Feb 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312656; cv=none; b=TB/I0+9M+23t5olI6c1N2GEXj2rA9q3Y422Av0ThxI/MBzBH49lV3NBzHXMVAnftA6HNTS1Z7e+KCxiUsPcsfwk8DOq7U01n/79L6CvztCvOfupbxaZl2OgnMP3YtG0ucXCV6vsCEh/Tfaz0fMtnTWnr0ITM8HknG2bdpc48GEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312656; c=relaxed/simple;
	bh=0qiEksKdGYOJmGD9Mjny+GHXBvFNEMW7GuR40DN0oCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYGxok28RvqQq0qzKcFzppC3T1uYuh6PncGx4KwmoMwCX3AdQNUZVXjPRugvZT7nLi9L2uBmoTuw2eQ8FUnuzyivpS9yhZLemDrZ8GOdejoBNA8FFcG40oynZSjzCBzyhN79D+9gW5DBIuH3kSjVAcpXsO89lIwlLEDbszSRv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZidp6tz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f48ebaadfso103769915ad.2;
        Tue, 11 Feb 2025 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312654; x=1739917454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbEiKzr8IwTOSc3q8xjyBSjMXv9mfiu/xaNUlmv8nQE=;
        b=BZidp6tz6nZJIHP4pMpgavjoCNuzt4rlFOhZZcru8o3UCA09vCkQIlrbCseQelfPg8
         3c6vH6BOmh0fqydbZgNIvxZxtdK+DG+rBQj17/ivkAguAMYJXPIVDHnKDgbvayY9qXNW
         58FRLaKl6hRoDLl5eiBm8h4JvqG9eYVBTmGK2wXenTtZZlMt0aJnkdVfkrgMFUeEQuVn
         z3K3qJSnjqab2UNOXqVa8zzf5eKlFNiRIYVq2LhvkzDU6uM3Q9nV4oN7zarKOv1ARjlC
         Kb+ZGHXDKc09wQZQs9iudtsOO06MFUAxvIixwpQve8/MKekKkZunT87R4AvRPvlfh191
         Rnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312654; x=1739917454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbEiKzr8IwTOSc3q8xjyBSjMXv9mfiu/xaNUlmv8nQE=;
        b=aFIy5t4uUzWzMpv6XT7DvJJRDw7ne3RgUq8uJznkmVSVp3FzTUUo4+FTMIFoYe84Wt
         bXwtcEgIILAqzHLAalX100Gl4lk0/Cz6r6sGdr6U1R5IjANGrtmtvNG8ODWIuITIo1x6
         0uj6UxAjx7TPH7PHlnRtJaPDrWAwSNGyDljqQsCgZ281JLbHTNTqoKt7dIIOVuTUGKgy
         xsUj3yPyxrlPZ0G8gI4TTKGGvaW3yuOcO14H2qKuYOLARZnUT29XOV3Vl8frI2UmrgEH
         etL7t4dkKTM6Mlii5ane0Gv8S3jfEftT6dupWntJT/xRCxckxkTv5p5sNdVYF0RmMXe+
         U8qw==
X-Forwarded-Encrypted: i=1; AJvYcCUiF0nxfGukZdQ17o4FkoIQdGIRE5NZowfTA1SAf/hqMx0oIwArvXtnYmA0Z7gV/MTXkL0=@vger.kernel.org, AJvYcCVhyVY1gXahM848Y76zy93fqCW2ClhbRaGpOH46JO9uogrYanLwabqYLyHyqRDgPRDr8rdbmfUJyffvzDC8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Pz7rQwOyWdUFS5Ey3p+ITkkN2yhpiGKsCmVdruiEzNLtelIp
	gNQMVvW78tgAh8vdoAcaYkbPEoTC/pcyUb/+rwI50lFYFOWDDIIWZXGYG5VNfYlFMQ1vwqvvLFA
	0i1Opn71xhjf55ozDEM1fsXhvpcE=
X-Gm-Gg: ASbGncuVq/fye5+qTcx+u7AUv7luBiga4X83UeddNP+tVyEJu5sj+Vxn5CEMWkROkNt
	eaYxSermJYmsGrXTs3YLcsxHL35mR1jb2GnXCaOpW6iw/bCN36uqtcl8yug2L7pQRZt1tqYJT2d
	akJRiM1qpGQUc+
X-Google-Smtp-Source: AGHT+IF8+uq8JTQnius6fGGs/WSVKgGjeg+Ow4Q/x5jXaN0Gde1xbyB/GDJblIEfXuwwEjlAbWe6McGUXE8qla3J8Ho=
X-Received: by 2002:a05:6a00:3d41:b0:730:9424:ea3e with SMTP id
 d2e1a72fcca58-7322c39c2d9mr1347968b3a.11.1739312654338; Tue, 11 Feb 2025
 14:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211111859.6029-1-chen.dylane@gmail.com> <20250211111859.6029-4-chen.dylane@gmail.com>
In-Reply-To: <20250211111859.6029-4-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Feb 2025 14:24:01 -0800
X-Gm-Features: AWEUYZmu1NKIZ_eQHXqGz5mFJn4es42uTbEcRc-H3RNlbf532lVlL2NVXPNqA-4
Message-ID: <CAEf4BzbQv4D65kuYRr+i8aqGqUY+YT7oKGJNNBxSUUBsj+Zhrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tao Chen <dylane.chen@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:19=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
> used to test the availability of the different eBPF kfuncs on the
> current system.
>
> Cc: Tao Chen <dylane.chen@didiglobal.com>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h        | 19 +++++++++++++-
>  tools/lib/bpf/libbpf.map      |  1 +
>  tools/lib/bpf/libbpf_probes.c | 48 +++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 3020ee45303a..e796e38cf255 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1680,7 +1680,24 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_=
map_type map_type, const void
>   */
>  LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>                                        enum bpf_func_id helper_id, const =
void *opts);
> -
> +/**
> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports t=
he
> + * use of a given BPF kfunc from specified BPF program type.
> + * @param prog_type BPF program type used to check the support of BPF kf=
unc
> + * @param kfunc_id The btf ID of BPF kfunc to check support for
> + * @param btf_fd The module BTF FD, if kfunc is defined in kernel module=
,
> + * btf_fd is used to point to module's BTF, which is >=3D 0, and -1 mean=
s kfunc
> + * defined in vmlinux.
> + * @param opts reserved for future extensibility, should be NULL
> + * @return 1, if given combination of program type and kfunc is supporte=
d; 0,
> + * if the combination is not supported; negative error code if feature
> + * detection for provided input arguments failed or can't be performed
> + *
> + * Make sure the process has required set of CAP_* permissions (or runs =
as
> + * root) when performing feature checking.
> + */
> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
> +                                     int kfunc_id, int btf_fd, const voi=
d *opts);
>  /**
>   * @brief **libbpf_num_possible_cpus()** is a helper function to get the
>   * number of possible CPUs that the host kernel supports and expects.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b5a838de6f47..3bbfe13aeb6a 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
>                 bpf_linker__new_fd;
>                 btf__add_decl_attr;
>                 btf__add_type_attr;
> +               libbpf_probe_bpf_kfunc;
>  } LIBBPF_1.5.0;
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index 8ed92ea922b3..ab5591c385de 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -431,6 +431,54 @@ static bool can_probe_prog_type(enum bpf_prog_type p=
rog_type)
>         return true;
>  }
>
> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, i=
nt btf_fd,
> +                          const void *opts)
> +{
> +       struct bpf_insn insns[] =3D {
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL=
, 1, kfunc_id),
> +               BPF_EXIT_INSN(),
> +       };
> +       const size_t insn_cnt =3D ARRAY_SIZE(insns);
> +       char buf[4096];
> +       int fd_array[2] =3D {-1};
> +       int ret;
> +
> +       if (opts)
> +               return libbpf_err(-EINVAL);
> +
> +       if (!can_probe_prog_type(prog_type))
> +               return -EOPNOTSUPP;

libbpf_err() here

pw-bot: cr

> +
> +       if (btf_fd >=3D 0) {
> +               fd_array[1] =3D btf_fd;
> +       } else if (btf_fd =3D=3D -1) {

let's not hard-code the equality, use < 0 (though I'd follow
verifier's offset =3D=3D 0 convention for vmlinux BTF here as well to stay
conceptually consistent)

> +               /* insn.off =3D 0, means vmlinux btf */
> +               insns[0].off =3D 0;
> +       } else {
> +               return libbpf_err(-EINVAL);
> +       }
> +
> +       buf[0] =3D '\0';
> +       ret =3D probe_prog_load(prog_type, insns, insn_cnt, btf_fd >=3D 0=
 ? fd_array : NULL,
> +                             buf, sizeof(buf));
> +       if (ret < 0)
> +               return libbpf_err(ret);
> +
> +       /* If BPF verifier recognizes BPF kfunc but it's not supported fo=
r
> +        * given BPF program type, it will emit "calling kernel function
> +        * bpf_cpumask_create is not allowed", if the kfunc id is invalid=
,

bpf_cpumask_create -> <name> to keep comments generic?

> +        * it will emit "kernel btf_id 4294967295 is not a function". If =
btf fd

same as above, use <id> placeholder instead of specific number?

and keep BTF (all caps) use consistent, please

> +        * invalid in module btf, it will emit "invalid module BTF fd spe=
cified" or

ditto, btf -> BTF

> +        * "negative offset disallowed for kernel module function call"
> +        */
> +       if (ret =3D=3D 0 && (strstr(buf, "not allowed") || strstr(buf, "n=
ot a function") ||
> +                       (strstr(buf, "invalid module BTF fd")) ||
> +                       (strstr(buf, "negative offset disallowed"))))

stylistically, given amount of checks, I'd probably go with the
following structure

if (ret > 0)
    return 1;

if (strstr(buf, "not allowed") ||
    strstr(buf, "not a function") ||
...)
    return 0;

> +               return 0;
> +
> +       return 1; /* assume supported */
> +}
> +
>  int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_=
id helper_id,
>                             const void *opts)
>  {
> --
> 2.43.0
>

