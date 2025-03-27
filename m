Return-Path: <bpf+bounces-54831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8CA73A4A
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE223AF3C0
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D21B0411;
	Thu, 27 Mar 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppk2Fbz2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC991A28D
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095953; cv=none; b=BlXJoCpwbb90W0RRiiex2n3tC88YP19RZeo6PYtRR4sW4XOsuHsRHGlO5Q+Mr90ta7O86+SYPIyH9/N73nE2Cno0XqdCPc1Qpinf7m8pagI+kHF13I4d7oKJzCCJnPHDhfXdRFHl9eu8z1r04MEWuyqy4CD/KQ8vgDGUnroS+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095953; c=relaxed/simple;
	bh=jsaLVoVo2KyFMlyuTNZVdQLOxuxxrYovyhcC1amT0OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgqHGAgSxryL/5Q4WwZPKaoHC9xG8FC82BINKmEOOrQ2qOiOhfxdWeYiDMDvAcnOMgrYc/TZixMyHQ3/uD/UDowjNCt6Nr7JNbO4ILuLuyQ/YKz4MW7C4dCvohNNaVR1BKZjGTNq7HfLuiW2XGL0qx0raNI5UcMa9626mR8jFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppk2Fbz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76E0C4CEDD
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743095952;
	bh=jsaLVoVo2KyFMlyuTNZVdQLOxuxxrYovyhcC1amT0OA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ppk2Fbz2fOLEF9ttqIyKIY+ebaHm6Wk4r7YiGLhvmUgdAZzbXRMrAvCxnN6rC3O2R
	 lq2c0t0+VdZ76hK4vXtl7biU75HLbRLcIhy5Nv8KCsLR97Yx3aGNvk6vwHJtCzzIMo
	 tqi0HtbnffI+UzMyZjzGSmjoxGvlEKd2A38Q7Cb5E5ZFTBDHNmRAiqMKTufIDBjmjv
	 iUZzb84k5pIDLi1iCilLWfxRIfcXSRI0S6KZXViQHFULoSQbnLk8RSulslxvvATTzh
	 ohb+SnqUXQftmk5m0QDTMbp3zzFlh7dlDKXUcf+e1YYA4qhIJOD9JfzDOZ4uRBSG7p
	 5QGSvlVe8ztMg==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5b8d13f73so149195785a.0
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 10:19:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn15VwZqV1SYwrP0h7tyxUjRiNbSbvKGGNE7uyCvJihgDzy52PpNLYf6T/lYCPQ5pGhl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHBxzqU+mf+OIZPOkDhl4xufI1wIA5ZsByvdc+3nVjwA+Enjj
	KFnvuwZe1CGhjqAIX45jXDXA6fbJB/ITS34vYJijiU8StkuA6EWjnHSKL84JUCwYB6UZJ+sR8Pi
	Fjg+M+ysEMSDJM+JM/3OowedroOc=
X-Google-Smtp-Source: AGHT+IFGwF4jeUhQGCIiivGyj+JV0A7pmi4Yd/zvqQcN+TUpM6OM4iy6Ts8hM0aTChrxAWJl7JYENtgEVYnq/fQssKc=
X-Received: by 2002:a05:620a:2403:b0:7c5:49e3:333f with SMTP id
 af79cd13be357-7c5eda7c9a6mr702587385a.36.1743095952093; Thu, 27 Mar 2025
 10:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
In-Reply-To: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 27 Mar 2025 10:19:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW46kTsSzc+B5pE+kM24nc+OUXXGnkgSgZbu+T55HSJb7w@mail.gmail.com>
X-Gm-Features: AQ5f1JrgSCVR54oiJjF2XDIQfE95hEiSGu2gLoj0iUIOwn3YPugrJhjnA-aHwIc
Message-ID: <CAPhsuW46kTsSzc+B5pE+kM24nc+OUXXGnkgSgZbu+T55HSJb7w@mail.gmail.com>
Subject: Re: Question: fentry on kernel func optimized by compiler
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tao,

Compiler optimizations can cause issues for tracing kernel functions. Pleas=
e
refer to Yonghong and Alan's presentation [1] for various cases.

Thanks,
Song

[1] https://lpc.events/event/18/contributions/1945/


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

