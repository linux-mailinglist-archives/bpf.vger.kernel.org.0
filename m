Return-Path: <bpf+bounces-50816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CAA2D090
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 23:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CC016C923
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E11B6D12;
	Fri,  7 Feb 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Ck+ZsT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F1502BE;
	Fri,  7 Feb 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967738; cv=none; b=o1lQYH8gD87UDMWJBMX6zMbS395s9EYNXtv3Gcaw+lEI7g5ExVO1D6WC0m071QmrqxIulioz+kq/LeLtiHhSIvsE88z5PBUY2beSmPPq2WLy9FlUVu0CzI4vvwuOhj8yd/ar6i4ZAouG1A0KevfEd73mfg55WkuS6rUnCcZ4qDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967738; c=relaxed/simple;
	bh=0j4EZ54eWBX6p61+7OOh/N7u8C2HZ4u2kb+r0CqJrLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IrXupn+9V4vcyThB3UwF4Y85s9XXR6Q4IR6G1sp4RtCRHwXzwF8aagVHzr0prpZTdq9QF7+pdbBJ8if+ZyHQw0sHgWt5YuTPYYJS4O3hinwofokLTPtKoZnSJfR66IYnOIl+j8RywmfLiKbpQYE8iqMWtWvdFPkJf1LoVtPPw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Ck+ZsT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6022c2c3so11363425ad.0;
        Fri, 07 Feb 2025 14:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738967736; x=1739572536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62ZydGs9od51owfhsT2kS2eU/SvFA/TuCn+xMfMI8ds=;
        b=J5Ck+ZsTgOYhR4HIrB8+3Kluiw2/i2Zzv7uycmeUBsUp+Y4Mdv05mc3Hjcfjfnt62w
         1eK0OUGad0hFl9ko8YnMyDhypKi/JMX2oRpSyjCvZOch6VaG9nfzBwbrLKN1NxbcUmI0
         WvfbMWTNdH+h+KpCTBm8sYPXfJnXTzeeCf5LrIo8mS/B3cRFfqbKYYmSqiQd3yb05IOt
         cBGE9Uot/TmM/E5SPxEYITcHGGCNcTpaQr+ZegD8G36ZNlnNZSfzGVSa+gSmsJ6/InG9
         oBYsA758BKWZMEliK2acVCu4tVIFGLwNTn90SonaEvEPcojJdVAUBuxEJ1z3F+EePD2h
         R43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738967736; x=1739572536;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62ZydGs9od51owfhsT2kS2eU/SvFA/TuCn+xMfMI8ds=;
        b=KKrcWr77T9bsqvEeVRwElPSHwFQ9RnpNfWDiUX7xpEKnXI/UXivUS2sV8Fpku0d0Aw
         55GN/p7XIAa6qnLVB0QUfpdMxg2d6cD+MjiEea92mwJDp64m5q+NzMOHA8kCVHlp0SjY
         DYwT32nAAVQhC3Xct1q2wIxlhlwtAobm0WgHqAhe1iOCqEM4i6pYA+/CZbi0q/BPGlND
         SYAiilDab8bKmyRMjUPM03ykdVWsar0lqgSiM9y4sAj8wmpuom/BxnvCigHb/sXccSEB
         x5EHQpqnIm1/97WAdMyB76fyYQLIUJ3D4fbUrtHyzwRK9zek/kpSp9nhpxax5YuGl1+k
         28tA==
X-Forwarded-Encrypted: i=1; AJvYcCXb3cme0ssIXLivDYiByXtmCVWsigypVErU9fqVyfuSCBjtrr31GaFHB9sVDL8hS/dblMHTOv9IcY0KhSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvXl0Xf3Q8+WYwjsVyCfYNsUrwTuImwDX6eMSZORtDvc7eRmd
	9rUAzwiUYH0YGRL3+xV7qXqlzRH03T/0CKaDSEKutb4fYaBPNFWz
X-Gm-Gg: ASbGncvYBNmWaraMYSQlcBoRPh9JphuDzJNjZMg4EeD7mbrrFzIZqEXQrufh4eZ2KHL
	dZwfRVqohmj/S0Rol+YJgN9e+DniC2rYCQxNbpJwkfjrbIZu/P3m9vyMKPG6RVolUZupFaHLTnm
	cSoR2iiu4ZZHrC6ZsrZnYeYlMW7ZkVD6H3CB0pymEfpYQ850+Mh5HCVld2VeZy63Ig3cIhh4WCl
	2nXz5XEyYzB91F5aKQ3RprBbMYiK9XHFcRfp0mqL8/d5S0xUtPbpCXLXSJGhY2CLEVFqlmRE7Qc
	lcpI6cvgzv4L
X-Google-Smtp-Source: AGHT+IGW/AHh89sKMygfrR7K04qpHjdyJCX1sKYxE8/UrHkB3xtV6565IZLEXtLcOQQ0yIhfHfLKVg==
X-Received: by 2002:a05:6a20:d818:b0:1e0:d3e9:1f8 with SMTP id adf61e73a8af0-1ee052c5403mr6944825637.10.1738967736246;
        Fri, 07 Feb 2025 14:35:36 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d18asm3523412b3a.36.2025.02.07.14.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:35:35 -0800 (PST)
Message-ID: <7d667c037e7396fb88cf243162c5aa8a537858bb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Feb 2025 14:35:31 -0800
In-Reply-To: <20250206051557.27913-4-chen.dylane@gmail.com>
References: <20250206051557.27913-1-chen.dylane@gmail.com>
	 <20250206051557.27913-4-chen.dylane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 13:15 +0800, Tao Chen wrote:

[...]

>  LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>  				       enum bpf_func_id helper_id, const void *opts);
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
> + * btf_fd is used to point to module's BTF, 0 means kfunc defined in vml=
inux.

Regarding '0' as special value:
in general FD is considered invalid only if it's negative, 0 is a valid FD.
Andrii, I remember there was a lengthy discussion about FD=3D=3D0 and BPF,
but I don't remember the conclusion.

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
> +				      int kfunc_id, int btf_fd, const void *opts);
>  /**
>   * @brief **libbpf_num_possible_cpus()** is a helper function to get the
>   * number of possible CPUs that the host kernel supports and expects.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a8b2936a1646..e93fae101efd 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
>  		bpf_linker__add_buf;
>  		bpf_linker__add_fd;
>  		bpf_linker__new_fd;
> +		libbpf_probe_bpf_kfunc;

This is now in conflict with bpf-next.

>  } LIBBPF_1.5.0;
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index e142130cb83c..c7f2b2dfbcf1 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -433,6 +433,61 @@ static bool can_probe_prog_type(enum bpf_prog_type p=
rog_type)
>  	return true;
>  }
> =20
> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, i=
nt btf_fd,
> +			   const void *opts)
> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, btf_fd, kfu=
nc_id),
> +		BPF_EXIT_INSN(),
> +	};
> +	const size_t insn_cnt =3D ARRAY_SIZE(insns);
> +	char buf[4096];
> +	int *fd_array =3D NULL;
> +	size_t fd_array_cnt =3D 0, fd_array_cap =3D fd_array_cnt;
> +	int ret;
> +
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +
> +	if (!can_probe_prog_type(prog_type))
> +		return -EOPNOTSUPP;
> +
> +	if (btf_fd) {
> +		ret =3D libbpf_ensure_mem((void **)&fd_array, &fd_array_cap,
> +					sizeof(int), fd_array_cnt + btf_fd);

Please take a look at the tools/testing/selftests/bpf/prog_tests/fd_array.c=
,
e.g. test case check_fd_array_cnt__fd_array_ok(). The offset field of the
call instruction does not have to be an fd (as it only has 16 bits),
instead it's an offset inside the fd_array.
Here it would be sufficient to allocate a small array on stack.

> +		if (ret)
> +			return ret;
> +
> +		/* In kernel, obtain the btf fd by means of the offset of
> +		 * the fd_array, and the offset is the btf fd.
> +		 */
> +		fd_array[btf_fd] =3D btf_fd;
> +	}

[...]


