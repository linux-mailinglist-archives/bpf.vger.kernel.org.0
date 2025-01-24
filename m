Return-Path: <bpf+bounces-49676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756CA1BA50
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD3716E009
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989661922F9;
	Fri, 24 Jan 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StkIhkj6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F618A6B2;
	Fri, 24 Jan 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736041; cv=none; b=FNjPMzyQLybWd98bFfSQATONnU4uxbRm5KorkjTDZWLvu3b8P27I2CpBVCNDb1jndXpqDVwZ3eYPUNFuwiZwEQB47nTPyJAY4BEUW+gdVj4EUMKX92OntehgzjKTRzywRjf1h5FJhMu8wP2dWl5pnTad7ClO0BXbRAWyrmLNYy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736041; c=relaxed/simple;
	bh=uH2SLJ1ojihQ5XwWQZyby8cy/ez3/Wz4SuR+nKcYYLE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN1guliYex2cpsQO78OD+haEI3IEUoeHG0p47keYiZz6f+f9aBreUiBoOsqKCzv7yAcfwAbREnqZ4XgocmiokMljT9kFULfkwBBsGee9P+26OXXT9uiyPyEeF1pfNwh5YONW5wTjJ2I09x6U+oHSqBp1CibtU5JXH1YhQ8nkeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StkIhkj6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa689a37dd4so467583066b.3;
        Fri, 24 Jan 2025 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737736037; x=1738340837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krP+D56ePGho1GIPs7fQYRA2g8RC1e9+SCuKtKA5k0g=;
        b=StkIhkj6YJo5SJvhgpZgolxAu5g60+oI4+kh4Iq9NDY4ZLAEP00fQwif2RCzuLF9UJ
         /iCn+Rbe8ORv3ZV0PmcdtALyH549y2pTRpX4r88qcA6IO3dRMDy64iR/jitXrjAjysVU
         yU0HjdwbP2pAuGpB+ti2L+Paa9+dCQiSu/FQYac2jvQj9BY3SytwZkabhyYupLLZVUGs
         ISSmQ8jw8DyVfj74L5aK8WRvzl1PVIPUkDwQGjRFyJIKN8icYKNhlNOMtDOnzMJfNQ/K
         S3AQdcjUj/phffwoFEij/V/xKc727c9m2IMMdDGEh+dxmvgfntIibzj0Di4gWZ0BUTFQ
         Vm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737736037; x=1738340837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krP+D56ePGho1GIPs7fQYRA2g8RC1e9+SCuKtKA5k0g=;
        b=h4rnTQjq46ioOfjLiykZz4A858M+SbnbbqMvIaUOPLxjgFsrNj2XvPLLuG+i7bPfZq
         aj12SqyxA8mV7aizifrjXXOZTgxBEKnq2nJt3xZs8TYyKLjfIuNHb6cF8CDFpv3JMS+g
         b6b0GsigjHU1kquxK0x//wNT3D32ECYvPvRTWeF7BPAhl0kA+h6Lz67YcDmAeKDC0cMV
         /gBxOmrFKt3mj/7bnaU25kLFEUDgtEpX4c+uiAp+THBh6s2JcIWYx4Rzu6+u+NuEowdm
         chAIBjYbzDNHln4rDHSuxQRqcD2lzIpmNci5t1dh+Na0AJgDZXvTqJkaWhg/tzlapcSL
         9X/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUueQ47tqh47p9WtuHHV8c3Y0PKd3+bDtDlgcfzML+7drtmHDs66khDZbB4jM5mkiGfB4g=@vger.kernel.org, AJvYcCVRPkHW+L2qCnN0PEO7I4Pv3mCWqMQz+5gjuBTNeUosurN3grFKcLXhzQ/K7PP3zPzuwiQzo95mhJLk+TVT@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8DvHj9DgQ+4dgw6ztZvYl7wm2C3egTOnsk4uGvVumVP6M8Ga
	icrx9Fni1TIKOZ26CYiPOjFLAZ4MEL5bS8ZmuPMZhOVeaBkKnHAM
X-Gm-Gg: ASbGnculjDHwNDE119sgVQyzf68+haL63x4UjtNP4hvSCRH8ACUT6tebazFHpdFka5A
	XYVvfwro37cPMoal8xqiOWgCHw0gR4/i9f5FpG5IySxC+SjX64x7I4G+OsY5AOhyNyUaALwKld4
	jjoTgs4Vf9dB1wV5cLz/QEhgkoKp884eptIQmCdh8EQfdVLjQVwGiSFx8vwNEZrhBIOFRDBL2Yq
	vFrxjTPMsplkblL5QHV6WyOX4TN1u9NYBJDfywlaSpainz/hh5wlUihWFY3e5yyzzUytFhJt40d
	/gG47d+yWHLrUA==
X-Google-Smtp-Source: AGHT+IFhtgWLFr6sntSR1XCkx2aT6VCsxkGwWu9KAVBwqfpJ7SZvPsqcnSpBopMsXjkeLIHvEbPjZg==
X-Received: by 2002:a17:907:9717:b0:aa6:84c3:70e2 with SMTP id a640c23a62f3a-ab38b240af9mr2539607666b.20.1737736037215;
        Fri, 24 Jan 2025 08:27:17 -0800 (PST)
Received: from krava (37-188-182-96.red.o2.cz. [37.188.182.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675c45ac2sm150744066b.0.2025.01.24.08.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:27:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Jan 2025 17:27:12 +0100
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: Add libbpf_probe_bpf_kfunc API
Message-ID: <Z5O_YCV6Lnqymy-V@krava>
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-3-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124144411.13468-3-chen.dylane@gmail.com>

On Fri, Jan 24, 2025 at 10:44:10PM +0800, Tao Chen wrote:
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
> @@ -1680,7 +1680,22 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
>   */
>  LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>  				       enum bpf_func_id helper_id, const void *opts);
> -
> +/**
> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
> + * use of a given BPF kfunc from specified BPF program type.
> + * @param prog_type BPF program type used to check the support of BPF kfunc
> + * @param kfunc_id The btf ID of BPF kfunc to check support for
> + * @param btf_fd The module BTF FD, 0 for vmlinux
> + * @param opts reserved for future extensibility, should be NULL
> + * @return 1, if given combination of program type and kfunc is supported; 0,
> + * if the combination is not supported; negative error code if feature
> + * detection for provided input arguments failed or can't be performed
> + *
> + * Make sure the process has required set of CAP_* permissions (or runs as
> + * root) when performing feature checking.
> + */
> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
> +				      int kfunc_id, __s16 btf_fd, const void *opts);
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
>  } LIBBPF_1.5.0;
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index b73345977b4e..cd7d16c1cc49 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -446,6 +446,36 @@ static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn insn,
>  	return 0;
>  }
>  
> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
> +			   __s16 btf_fd, const void *opts)
> +{
> +	struct bpf_insn insn;
> +	int err;
> +	char buf[4096];
> +
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +
> +	insn.code = BPF_JMP | BPF_CALL;
> +	insn.src_reg = BPF_PSEUDO_KFUNC_CALL;
> +	insn.imm = kfunc_id;
> +	insn.off = btf_fd;

nit, you could use

        struct bpf_insn insns[] = {
        	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, off, imm),
                BPF_EXIT_INSN(),
        };

jirka

> +
> +	err = probe_func_comm(prog_type, insn, buf, sizeof(buf));
> +	if (err)
> +		return err;
> +
> +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
> +	 * given BPF program type, it will emit "calling kernel function
> +	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
> +	 * it will emit "kernel btf_id 4294967295 is not a function".
> +	 */
> +	if (err == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function")))
> +		return 0;
> +
> +	return 1; /* assume supported */
> +}
> +
>  int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>  			    const void *opts)
>  {
> -- 
> 2.43.0
> 

