Return-Path: <bpf+bounces-50979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D41A2EEAB
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F591883D3A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B322FF37;
	Mon, 10 Feb 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2x7STB3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044922E409;
	Mon, 10 Feb 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195261; cv=none; b=KRY6Mj29BYutz+dzUbrd1WUEVsvludNpYPWF6/69SNV0OxcP4Bd8NB5dqegqZsMkkZxudT/Deg86IqjFb///5MIzd4RPUhe/sZJteHg81FKxwuKlk2fr/jfpQnc+U0FQ1TO0eTCysMkJOCW4I72ttLrZVQtH9yrzgn8Cxgy1D0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195261; c=relaxed/simple;
	bh=B1fxvcIsrUPtR4V25wkD07PW9OG1KrwliD8bNYnrJg8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Omqwd/OM5SUnmuURXgKpNXkNAMzMc+4jpUuO11ly9So2VHYkTabz2kUFtRLq3BBt0i3Zh3q9WyaG6RVYESfselTAJbme9XKwJBPI1rXDSx0IARnzHrIWW4VTYvdbrwSBRHS0qy9N3eAQKctrbSsVaB0yMIor19z6j6+/rJ2PBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2x7STB3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so8227955e9.3;
        Mon, 10 Feb 2025 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739195258; x=1739800058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Afi6OLWALZHDRnl8260ApL7mj2gU/552a1e0gMmwBKE=;
        b=O2x7STB3aVZcEgNR54N88URwZDtoZytxZqvxGlGJSoqGPApYv6FrdNlythF+G+C8sA
         QlYi+N6v8fNWuy9Yyz5U8Dosk1OGk1IzAIxDVaJV8kZebB6L7BaN3qalLpSPpTR23pG4
         GNp8ZW50Y6Xfa2+6V2cJZgXrRqmdkyuJYIRuI5iA3tD0eQJrGI/yeEkAZurlUTESbBR0
         7by6qWI4voQ0P/+u3xP3VLzDuLShxKwVAItzSfLbQuUYgnHTlffIK7rdMqq08alSo/3q
         LpRJnT8DPUGYdc4VNUOjy/efvhzCIl3Gh1TywMVRFLI0x+RJJM0nJ8Gw670XpeeVRflz
         AabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739195258; x=1739800058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afi6OLWALZHDRnl8260ApL7mj2gU/552a1e0gMmwBKE=;
        b=MZx2f2YPN59x04ixJkl/ZrIhIVFmAVZnE5LmFIT+709rEtYHZHo7yru53rn9xh/LRj
         YRNAQR3cDd1HQBrrjClfIiOOdjWp4vTZpwYNSkqYlPypiWqM8EjCuZsd1qFW6FzjewH2
         MMXDvrAO5rEiuRvx+HOlFmJ3cmOJnI5/c9Xo3tU6Xf95Ea9Ai/uk0eFAOsdQX+4o2q86
         499Pj7Ekr2JB4ZQm62l/C7LAcQk4CsIpE+GBE5M7G3XGNTN4TShFcD0wKjG+du7qHPQ+
         jPNhtj93eO5M6OYF+DwZAg1U70n6uBC//1dd67fX7stzNfHBhACQfVbwlEWgnmUYv+A2
         qX4A==
X-Forwarded-Encrypted: i=1; AJvYcCUaf3XuuZPQ93kQvmn/iHWFIlI1Ab7/w9Sg4SfK3UtV1kctNE1yIGparFcQpQTxw8Tv9Wg=@vger.kernel.org, AJvYcCVm1PyBLjtOdgkzm+WtzuiiFdnLHbDn1TLamUdJ8WXRZrRZGNZL4R6OIZj9wVVTCsxIYcK6L8YXRYAa6no3@vger.kernel.org
X-Gm-Message-State: AOJu0YwZurVXdx57zjy/DfuVyM/BL55+DrLkSV6ihjMwzEoLuSTIeNN5
	X6X3ZJKurtHn7fAx1hWl+2pfQuDTlLLnyzwhUBhZZyixbRg18g4M
X-Gm-Gg: ASbGncvl3ILrZJnvhg//EgaYHPNFXzwoyDXGOobo4kN1FdY03TkBMISHoE9mWORaSe0
	wQQSWPSeGgJO6COk9K4KXTrsGCkn+hS/EghwwHO1Llonz/R6T1ocN4OGTdVbeIjQ9bCOWWpFPKr
	nM+vupiMBaN25xk6k1umrygtdLEZjBIaDbfw7LWyUEvyiSwdFd3+4dVLiayHWExYgxlAeLpqgDB
	VZ/uFOtYQl6K6veHDaR+A1LZAe/0XZFqSL90g8fy4oCg7dib4Q42dKhlYX/QVfdrWAajLm/ohWJ
	/g==
X-Google-Smtp-Source: AGHT+IEIGgrfsFEzcZ3ndLtPC2SgfSsCz2RE9BRnoC1XfJExm3D+xUYOpBIpHCzruSDfrK0U4WHcHw==
X-Received: by 2002:a05:6000:1865:b0:38c:5d42:1529 with SMTP id ffacd0b85a97d-38dc9491b8emr10256410f8f.36.1739195258108;
        Mon, 10 Feb 2025 05:47:38 -0800 (PST)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fd0dsm12271591f8f.75.2025.02.10.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:47:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Feb 2025 14:47:34 +0100
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: Re: [PATCH bpf-next v5 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
Message-ID: <Z6oDdiKkBy7McK-2@krava>
References: <20250210055945.27192-1-chen.dylane@gmail.com>
 <20250210055945.27192-4-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210055945.27192-4-chen.dylane@gmail.com>

On Mon, Feb 10, 2025 at 01:59:44PM +0800, Tao Chen wrote:

SNIP

> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index e142130cb83c..53f1196394bf 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -433,6 +433,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
>  	return true;
>  }
>  
> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
> +			   const void *opts)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 1, kfunc_id),
> +		BPF_EXIT_INSN(),
> +	};
> +	const size_t insn_cnt = ARRAY_SIZE(insns);
> +	char buf[4096];
> +	int fd_array[2] = {-1};
> +	int ret;
> +
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +
> +	if (!can_probe_prog_type(prog_type))
> +		return -EOPNOTSUPP;
> +
> +	if (btf_fd >= 0) {
> +		fd_array[1] = btf_fd;
> +	} else if (btf_fd == -1) {
> +		/* insn.off = 0, means vmlinux btf */
> +		insns[0].off = 0;
> +	} else {
> +		return libbpf_err(-EINVAL);
> +	}
> +
> +	buf[0] = '\0';
> +	ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
> +			      0, buf, sizeof(buf));

hum, you pass fd_array_cnt as 0, which IIUC will work properly

but I guess then we don't need to have fd_array_cnt argument in
probe_prog_load if all callers pass 0 ?

jirka

> +	if (ret < 0)
> +		return libbpf_err(ret);
> +
> +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
> +	 * given BPF program type, it will emit "calling kernel function
> +	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
> +	 * it will emit "kernel btf_id 4294967295 is not a function". If btf fd
> +	 * invalid in module btf, it will emit "invalid module BTF fd specified" or
> +	 * "negative offset disallowed for kernel module function call"
> +	 */
> +	if (ret == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
> +			(strstr(buf, "invalid module BTF fd")) ||
> +			(strstr(buf, "negative offset disallowed"))))
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

