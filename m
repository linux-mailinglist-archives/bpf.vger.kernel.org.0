Return-Path: <bpf+bounces-49698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A649A1BC56
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D91C7A4FDC
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7540A2248B4;
	Fri, 24 Jan 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htulIxNi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18E192B74;
	Fri, 24 Jan 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744407; cv=none; b=jkApnTQzRjUS7l/cwPcDd3+CfqErzuu0z9kA9YIX38XXAoR0/h2csZ2RQyf+kGv66imcoNJrAAcnTIEQVweN06IlerFzALtP/CUyYJGvaGDtwGum6bEBdKkMcdUMHthYZ2MhBbDc+zBwlsh3fTgpRIMPPUq08bjMsyvCCGdI8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744407; c=relaxed/simple;
	bh=F4CXV6WVQb309+9/znI+oAYDkc9EM5p19zMV8jrs21Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyzvHDVVu5RpazYOh1+P/y14jaUIwSR//g19tEDXYG3g0NioxaTkwIUSQZFWj1oeHi2h6z5uIIJMsrj7JWgxWfJouX3I6ceW9S8l1riHZJ9+hnrruDDYLKehg7EjIS0oHWjhuVQ8mK1RH4lL/ZMFAb0CxWBONxd/v6Uf6AwsEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htulIxNi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21661be2c2dso43547295ad.1;
        Fri, 24 Jan 2025 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737744405; x=1738349205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOF3CE7NlB8bZ9/iXARKj/Ja70d7k3ShY9EtOLLOGwg=;
        b=htulIxNi3aX7czG8f/am9MxoRfqI8EyVBU6y2Foc75yridZ3Qi9vT8lkif+JFx/IWH
         iZ8lZ0oY8AderVyzQfjrVOmDDSq89PkNDb6sacMmiXqfL7sGMak7kd73AR1ckaC1kfz6
         4n/jd/SqGwqt0DRMP/1Fo6xae8YUDCteI6GkP17hkqA4xZh2DDDRcsbttPIb/hZ0kU5J
         Z/mWpJxt3Df7ULsqlGrxQ03e4JgrHBiYJ/O1jgLhAjGwoCjb9PIUc6X/XDz4WFDy/pev
         P6InAOLIMrK2NzE/wXhyQJwAth76NBxEgKd+ukwleYEdOsPxzFhcsrEh9UC2V7xA5STP
         Aw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744405; x=1738349205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOF3CE7NlB8bZ9/iXARKj/Ja70d7k3ShY9EtOLLOGwg=;
        b=ifb6WOMD+1EmoMN48C+zG26dvHL5y0khiHAGlGFSObEbhOWhn4ZH7JmDB2cXmQFXZs
         4YD3GnOei85HVXgR/58NPsjy7MfdYnV0W87CNbZdcaDvMLoLcVw2xWQvzI8jnLGcK5ag
         Zq+XCINP4wj7P5uzD+Oi17Z4soqtLshgCTq2euQrepyVCDYQ44z62X7PoFmiGyDxB1ip
         D8t+KhoewjZOW9tnvHa+DQBxn8Vpbwb9oP1o4X6icfdNqLo2yWIMf7RyU4lCecIXaTp0
         qHjj8a8MA+5kBIMlRXtGgS5o5vfzC8oCcp7tqLKnH6I5/9KvHn+3z4VX8OxznMSb72n9
         K2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5egFcw8uoLvHXNdHoMlvYUqcG3OMtqodn0pJobp6Rw8oqHYe6sMN5HzEN6icGuz3MWKV+hbL1iuDpXzck@vger.kernel.org, AJvYcCVIHg3Wa++Tk4vDyBDj5QbascycH0/OLkIJUe+Jmy+pQ9Pcbqt2EHajmbS00yIA0QLx3bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8de3sB53f/928C8EFzE5nWvGZg95JOXnrX8GXPUjxpesgghf
	FC9Nf3T31Pt2X1ic9DADxmiiQC6+1Mi0F73evTULDVQTbjSAaTouHRjqQEmaQFJbHbhsy8uovAD
	cUxmDE6WHOeea88hToITLO72wwCA=
X-Gm-Gg: ASbGncsN5KOkvUkAfLcKLmoao9AbQDiufEkniijdSzWhG2Bi9kpjfY2Nhg/oLXdF0Oy
	vtVdniTazSNOCDaSjSwxEDGwU3ezSqCa2H1wfYP7J0zhBu7Kh4A8PkOP7mUM3+sesxi9j866YFl
	xvuQ==
X-Google-Smtp-Source: AGHT+IEjh0zGvXYjYCDtzjr6/7MRHJWVbPB5yZr67UNwmZAUO7La7Gog5yhhPx2w3kinxasWRvarLlj7Gq7QMlQLPb4=
X-Received: by 2002:a05:6a00:2443:b0:71d:f2e3:a878 with SMTP id
 d2e1a72fcca58-72daf9bd003mr38532439b3a.5.1737744404679; Fri, 24 Jan 2025
 10:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124144411.13468-1-chen.dylane@gmail.com> <20250124144411.13468-3-chen.dylane@gmail.com>
In-Reply-To: <20250124144411.13468-3-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:46:32 -0800
X-Gm-Features: AWEUYZl6AyMryLI-H7zUSb7si4asGu-1pBrTRJwftCNZ-I8xUr-UjnhrCnQQNJU
Message-ID: <CAEf4BzbYMqLdyG-HxQg6w_pn50irFH5OJE+N8NhQZEaqUJ9_yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: Add libbpf_probe_bpf_kfunc API
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 6:44=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
> used to test the availability of the different eBPF kfuncs on the
> current system.
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h        | 17 ++++++++++++++++-
>  tools/lib/bpf/libbpf.map      |  1 +
>  tools/lib/bpf/libbpf_probes.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 3020ee45303a..035829e22099 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1680,7 +1680,22 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_=
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
> + * @param btf_fd The module BTF FD, 0 for vmlinux
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
> +                                     int kfunc_id, __s16 btf_fd, const v=
oid *opts);
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
> index b73345977b4e..cd7d16c1cc49 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -446,6 +446,36 @@ static int probe_func_comm(enum bpf_prog_type prog_t=
ype, struct bpf_insn insn,
>         return 0;
>  }
>
> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
> +                          __s16 btf_fd, const void *opts)

btf_fd should be int (and mention in documentation that if kfunc is
defined in kernel module btf_fd is used to point to module's BTF)

> +{
> +       struct bpf_insn insn;
> +       int err;
> +       char buf[4096];
> +
> +       if (opts)
> +               return libbpf_err(-EINVAL);
> +
> +       insn.code =3D BPF_JMP | BPF_CALL;
> +       insn.src_reg =3D BPF_PSEUDO_KFUNC_CALL;
> +       insn.imm =3D kfunc_id;
> +       insn.off =3D btf_fd;
> +
> +       err =3D probe_func_comm(prog_type, insn, buf, sizeof(buf));
> +       if (err)
> +               return err;
> +
> +       /* If BPF verifier recognizes BPF kfunc but it's not supported fo=
r
> +        * given BPF program type, it will emit "calling kernel function
> +        * bpf_cpumask_create is not allowed", if the kfunc id is invalid=
,
> +        * it will emit "kernel btf_id 4294967295 is not a function".
> +        */
> +       if (err =3D=3D 0 && (strstr(buf, "not allowed") || strstr(buf, "n=
ot a function")))
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

