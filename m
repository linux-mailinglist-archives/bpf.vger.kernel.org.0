Return-Path: <bpf+bounces-49606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32DFA1AADA
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 21:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFCD188D8CD
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F801ADC93;
	Thu, 23 Jan 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0AHKcOx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE358BF8;
	Thu, 23 Jan 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662841; cv=none; b=qZUg9mP6/w+esri2eA+jUWRXV4SpQ47cXLnN7sYiGKn5qZ5yJ+3U5iEVY8D9u5ikrZDCUj1CmBSUqjlkt+MvyL+YqPN0r1IQtg358tUx/Q7VxAJeyAcIA1fqF8IJ+fjWOtqjelZ9icvQbtg0tNPCArKLllunWQ3gEBq9IDycdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662841; c=relaxed/simple;
	bh=F3k+2o5p3cGFu1mEuiZd5vIGhxlUJhQ45DK1B5xu3E4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN9JRCa+w03kkLnm0XWxyTE98fe0iLMnf7w3ePt+PlzsOKrd1V5nbozXtfLGvowROOfuLWAVdNLCtW9NQ3qEPnk2yj4Iu2DrWf8EPiR+UsuF/CKaD1Qdp3lVH2sQ/0N8ThLGAg9CR7lov6NhF5mMQeWYMU2ykMIa0JQ4PkcGYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0AHKcOx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so218353466b.1;
        Thu, 23 Jan 2025 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737662837; x=1738267637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6E2Wu5yB9j3dLzOt9MtpZj+V+q5hIzD4zRX8ZuTsq+g=;
        b=N0AHKcOxY1QH2lX9N6GPNw0ZTkZ/u2Kc63tnyptCEY/hTSs3crcPRR8lSW7775Ka2f
         lbIHOIUA0mglWkV6nf6p2INAW3KH6FQSAG7SiJfYv6R8JllOiIfU88ugsrRuQIbiCQMH
         VpRlN2gusGu7tVsbfrs6bDFvxLyf1kWSRp2I0c/KZxwAA8N9CItrpTUWJvEMFlq3rcCo
         o0pQ/LblQ9wWCNWUqrhwzSYdHjLvH4At9yOXvNC46ze9UdQ0bAc8gkRB5I3gl9Rg1kuQ
         VQo+m4Lc3OAqMM14aqugdDQfAZwwriwPagVGA6I9IDfMG6AmO7HcEybOivJq4bz4hArh
         PMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737662837; x=1738267637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E2Wu5yB9j3dLzOt9MtpZj+V+q5hIzD4zRX8ZuTsq+g=;
        b=UQ7avasyfHkau1CLzK0yw1OC1NeoIIZmitAa9a3mxEADOAPb84RUerugDLtLddHM+7
         XpilEzuIK8czPC/1m03P2XRHzoWAVVzMxEj3WdRU3ergp3Nju7lCiAt1JSvsgaKHaubo
         R7YLYv8D96aexcNKSK3vIawBjhmjP1INrjmSlbf1oGdrraK88aJ5xWAtEKjOY1zt/6Xj
         miLYzNLuIKqoMJ00pBdf5/osF39iFHONpO+hxsM9a6LzghVBNyT/1HkhcgDFcHPtY7G9
         S+d3D/etiXa98BCDc5uY2gD3Fj/D+fE3j4+JumMvLvch1r9Xy9bJJALRkSppEVFI+VKk
         7cvA==
X-Forwarded-Encrypted: i=1; AJvYcCVPjFYzvfgy5+09gbmZI7l9mM5X7F7wf43ceDpKmwdCINawOHdeoXoO3zQrXXujph97Bnx7esqz+3Yt9ZfP@vger.kernel.org, AJvYcCW8mHW9uwd+SxHFzILx4InsgCtCAlWD0wIRk5dextXx1RCDSdP2XHM0dLoGvFrGYgN1V5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzueFcI4IcIUfTHkSY+Qe3P22C40eGHe7AjVs8lTpf/6Lw6iMD
	/XJ/hj4s0nNulpi2rVOC1KFlkXqNERPk8ghhZkmQTIkw/ujATxJN
X-Gm-Gg: ASbGncsRc9V/NhDipCrFi121ya4EHA5vMebiYZVaCSNRmg6VTg98d77/EAejky4vu+D
	J7j8pXBOERze/BceLWC2zI22poFEytrVXgzz4BTUWBUYp0j19/MBW+Lo/f6OGkjtwSlVlZyIQNP
	oHxAnBG/AokviyxD1416vN6Zs1b0v9zR0rdNU8yOhwfmAFNStXqIbKu/JKpYSXO8YWN/4FqVywK
	vI6SMjQFXwh2nMO7gOpanrFoQfvJQY0G1hKeSM1DQqcfmdLVnKtbBfM5/Yh9MTrc25QC0Jqvl4m
	uDft8JAw4Ys5Og==
X-Google-Smtp-Source: AGHT+IFIYQuO9EZqfg/UiaER0dMp9DT44/UaA6IlkCO+zc5bbPCwbQSBuiX4ejyfr8PuUXlXW19fdg==
X-Received: by 2002:a17:907:9694:b0:aab:f014:fc9a with SMTP id a640c23a62f3a-ab38b10f4c6mr2208553166b.22.1737662836735;
        Thu, 23 Jan 2025 12:07:16 -0800 (PST)
Received: from krava (37-188-182-96.red.o2.cz. [37.188.182.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8acb6sm11537166b.76.2025.01.23.12.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:07:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Jan 2025 21:07:11 +0100
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
Message-ID: <Z5Khb2qaSJCo16Yf@krava>
References: <20250122170620.218533-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122170620.218533-1-chen.dylane@gmail.com>

On Thu, Jan 23, 2025 at 01:06:19AM +0800, Tao Chen wrote:
> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
> used to test the availability of the different eBPF kfuncs on the
> current system.

hi,
there's "bpf_kfunc" DECL_TAG for each kfunc in BTF data,
I think that should do the same job? please check [1] and
related commits for details

jirka


[1] 770abbb5a25a bpftool: Support dumping kfunc prototypes from BTF

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
> @@ -1680,7 +1680,21 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
>   */
>  LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>  				       enum bpf_func_id helper_id, const void *opts);
> -
> +/**
> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
> + * use of a given BPF kfunc from specified BPF program type.
> + * @param prog_type BPF program type used to check the support of BPF kfunc
> + * @param kfunc_id The btf ID of BPF kfunc to check support for
> + * @param opts reserved for future extensibility, should be NULL
> + * @return 1, if given combination of program type and kfunc is supported; 0,
> + * if the combination is not supported; negative error code if feature
> + * detection for provided input arguments failed or can't be performed
> + *
> + * Make sure the process has required set of CAP_* permissions (or runs as
> + * root) when performing feature checking.
> + */
> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
> +				      int kfunc_id, const void *opts);
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
> index 9dfbe7750f56..bc1cf2afbe87 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -413,6 +413,42 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
>  	return libbpf_err(ret);
>  }
>  
> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
> +			   const void *opts)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_EXIT_INSN(),
> +		BPF_EXIT_INSN(),
> +	};
> +	const size_t insn_cnt = ARRAY_SIZE(insns);
> +	int err;
> +	char buf[4096];
> +
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +
> +	insns[0].code = BPF_JMP | BPF_CALL;
> +	insns[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
> +	insns[0].imm = kfunc_id;
> +
> +	/* Now only support kfunc from vmlinux */
> +	insns[0].off = 0;
> +
> +	buf[0] = '\0';
> +	err = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
> +	if (err < 0)
> +		return libbpf_err(err);
> +
> +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
> +	 * given BPF program type, it will emit "calling kernel function
> +	 * bpf_cpumask_create is not allowed"
> +	 */
> +	if (err == 0 && strstr(buf, "not allowed"))
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

