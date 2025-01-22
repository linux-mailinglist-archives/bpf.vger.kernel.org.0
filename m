Return-Path: <bpf+bounces-49540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947A2A19AD1
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 23:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED3C160944
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6871C8FB4;
	Wed, 22 Jan 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5MDQrAs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCD1C5F32;
	Wed, 22 Jan 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584536; cv=none; b=bO4gn+x0726VKGocWO9nOZiTKw8Ll+PucafOIEGpEZ9YBb3tlFXRKcuig5+c/5bXDRRoeacDYwAxHMgP12pzFD/ZDjdUrnN7fKkFqP/bz961pYc/0YPE/J4liQ+O7XI4QKb9yiSImxntSJiB5hYXw6Vc0YfJUojl3J6THHSw+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584536; c=relaxed/simple;
	bh=gRra50cyzPzNE6S9eTFrosemF1Wd9wWIfAK7zjV7/AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGj+i1qkdkkMv10R3ZWZqI0KjXhIn2IqdnSLLb5OBC/SamYnYsQ9jd14iEp30JuVQzJtRMze2OayH6cSkD8iaaFIZ/g4jxaSXMl9g8FBwpmza+UeY/E6DUaNe959XU11B/NErWRQNRq1ozKB3WeScyYUjL777i+fNFZgCAIHkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5MDQrAs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2165448243fso4392035ad.1;
        Wed, 22 Jan 2025 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737584534; x=1738189334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1m3yu15mM0/OTV56vuKXAPa0H/DFAzABZ6H37u36x0=;
        b=V5MDQrAs0L6NXKw1dpdRVI1xnU+0UsmyqWlUf/117xeqa4x47xM1+tco88VcHKFlP4
         X3x2NzFKtIFIS4I2+Ey6YZK7Ble0SziVuSS/ubnx+99QhOXSqKeD7mFtw9azB+qj9b1Q
         ouwMFYTkkZ1ErPLWYFQoI96stTvS7Wab87V9pLd0PTKYczoVOOkH4yTLoi+ij6X6CNCv
         i0Thjm13S38zHdDbHhN/ARG6g9ytsBpKEsbeK+IOn4nOlnr4P40oZnKg7RWAkNHi2q1m
         48QRu/JytFWS+EMjX53Fn/YHp+gzt3t9UhbE5/iIydB3aG+RUuPgNBraav8YiaVJ/nTb
         HtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584534; x=1738189334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1m3yu15mM0/OTV56vuKXAPa0H/DFAzABZ6H37u36x0=;
        b=N6uj3Jd7Pg06WOiTkYxttzE5DgkJF0X6PeaW6kcGRXzDemcB8vLr6YFE2IwvZG4cWP
         Mopm8WBVQkCN/nen0UOw6z5KXzL/GbxePU2t3vywX68kjClAEYH/RgQTpQJ8Z+mlXRhT
         Ov0sUVRFDAO5RWhM6dZrzv50aqjvvRzlW83dLK0ZwtSBWh/zt8uvweCLPNDXoVv7cFj1
         RYMwG0o8eIRHziB0JPzErw4TsdwVIiLgDeOEaRm+yQS3br50+WtvCc9f3M7JPrgz14JQ
         njaIFFfAo7Vz7HCJ36ueZkAtPU5L+wJ4BjI+IzvAnOb+cpIqwgfLVxOc2gijV79a+d/P
         0Rfg==
X-Forwarded-Encrypted: i=1; AJvYcCWi8jG3fTUwX5oAleDcxeniVEMwtKjdcVgF4/bOSNR1DoJ86UdaUrbQcnf0sKlDoFZEazY=@vger.kernel.org, AJvYcCWmIvC1FY355Nng4FEzYjTgvm09UJF76SEloW/7rDxdf2KqeKEFgKQ80TLRo4Zvzl2pt2mRcXzwvEQ8IbBf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Vbxb1s1KNtfZmDskElNod4E5jn9kC8subZGqwzA5BqO+CTV9
	6S+XkoUX+a+jqmGu2Ab12IhZC5WtKlWS5Y0XOu3lECwfmz3ct9aW+1fdUjTXV0s4IAlxSFtPoXi
	sopZTQU9ZwxBvRf45jmJEakqqyg8=
X-Gm-Gg: ASbGncukULB9bGlUtgMMqVTXd+3GIrhx4cLfnZ8vGke2W16RMAbnYvwUhiKR6ygV+T6
	hVhHfYj3LhZnVp+C0AvWzZQM7jlVmBnRmMM8SoVHwORvvwjuzTnc1vXoY1FtX1iREYZE=
X-Google-Smtp-Source: AGHT+IFAsykihvk+hrpHeM4LNNh0yZ0EbOsKQutlh/9mDzvDesL1qqa4RMOumFbVQ3AA24faYjyfd28qkrK2cQ58Wk8=
X-Received: by 2002:a05:6a20:244e:b0:1e0:d4f4:5b39 with SMTP id
 adf61e73a8af0-1eb214caa0emr37986003637.24.1737584534236; Wed, 22 Jan 2025
 14:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122171359.232791-1-chen.dylane@gmail.com> <20250122171359.232791-2-chen.dylane@gmail.com>
In-Reply-To: <20250122171359.232791-2-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Jan 2025 14:22:02 -0800
X-Gm-Features: AWEUYZm0LUcVTPk9jhz17ldyNo23V_fTylJoFNGnPffC5Lf97bImleBQsOmsmns
Message-ID: <CAEf4BzZM9YCzbs1-nv6nDk=-V8EO08N76wTC5aawCyHRd9Ptqg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 9:14=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
> used to test the availability of the different eBPF kfuncs on the
> current system.
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h        | 16 +++++++++++++++-
>  tools/lib/bpf/libbpf.map      |  1 +
>  tools/lib/bpf/libbpf_probes.c | 36 +++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 3020ee45303a..3b6d33578a16 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1680,7 +1680,21 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_=
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
> +                                     int kfunc_id, const void *opts);
>  /**
>   * @brief **libbpf_num_possible_cpus()** is a helper function to get the
>   * number of possible CPUs that the host kernel supports and expects.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a8b2936a1646..e93fae101efd 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_buf;
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
> +               libbpf_probe_bpf_kfunc;
>  } LIBBPF_1.5.0;
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index 9dfbe7750f56..bc1cf2afbe87 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -413,6 +413,42 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_=
type, const void *opts)
>         return libbpf_err(ret);
>  }
>
> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
> +                          const void *opts)
> +{
> +       struct bpf_insn insns[] =3D {
> +               BPF_EXIT_INSN(),
> +               BPF_EXIT_INSN(),
> +       };
> +       const size_t insn_cnt =3D ARRAY_SIZE(insns);
> +       int err;
> +       char buf[4096];
> +
> +       if (opts)
> +               return libbpf_err(-EINVAL);

note how libbpf_probe_bpf_helper() rejects some program types because
they can't be really loaded. Let's keep it consistent?

pw-bot: cr

> +
> +       insns[0].code =3D BPF_JMP | BPF_CALL;
> +       insns[0].src_reg =3D BPF_PSEUDO_KFUNC_CALL;
> +       insns[0].imm =3D kfunc_id;
> +
> +       /* Now only support kfunc from vmlinux */
> +       insns[0].off =3D 0;

why not support modules from the very beginning?

> +
> +       buf[0] =3D '\0';
> +       err =3D probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(b=
uf));
> +       if (err < 0)
> +               return libbpf_err(err);
> +
> +       /* If BPF verifier recognizes BPF kfunc but it's not supported fo=
r
> +        * given BPF program type, it will emit "calling kernel function
> +        * bpf_cpumask_create is not allowed"
> +        */
> +       if (err =3D=3D 0 && strstr(buf, "not allowed"))

Looking at kernel code, if kfunc ID is not recognized, it seems like
the verifier won't print anything, is that right? If that's the case,
then this API will behave differently from libbpf_probe_bpf_helper(),
which isn't great.

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

