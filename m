Return-Path: <bpf+bounces-51150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998CFA30E80
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1196716767F
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE022505B3;
	Tue, 11 Feb 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2BfNFca"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8024C679;
	Tue, 11 Feb 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284611; cv=none; b=HWNPaXzNbnVV1KhdlcuFcS4/7CFvCR2M3t39lYHVqo0flzmgHRQBqoDL76f8on9nzrDmPCb7U0yRJtHy9eqjrwOTWryC/xJxg8/KHp3tEyIJ+xMVLo0dYlW2uBnXosGHLvMhX5ozsk7bdhhqm7H/DBNs1rnngriz4kUhwkA8b6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284611; c=relaxed/simple;
	bh=/aM1bzULbT0YR8QtwmIHthRWeDHo0pPo/NYA4mvs+qc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7R/K8sSWpv8oq4Sqx2sfpgknduHMl0KUUGzvkjdHV4iXpkJ9hR9iOVEXW9/Cz9CR/pR16qKRImJsbzkshz4RKOrwnvdTj8aADXRKXKuQKe6uRY+CCy8vF01/UGBTZPEx5TCkUFjJn+XPVzxXLLMABrTyYA0YCKTDwwyE8der30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2BfNFca; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de74599749so3707209a12.1;
        Tue, 11 Feb 2025 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739284607; x=1739889407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8SaDr/lQ8QeoRPH86F9hyguGpM9i9iIGPdAU8SZ5Xs=;
        b=R2BfNFcaoUw8Q1ZbBw/ABT9yY5OmXE69hSCB2CAPrWZ1Jk9SKFCku7XSL7pQPPp3oY
         MToOSjK5zj7HPtfQ+HIS6ze3CYBYkRPqqLoq41YCxoat2ZbDBKfA31CIrgIln/4mzt3+
         EosQl1tAfcu1JWt8l8nFTMidzuFhCiODp3mVKGXSrgDtDIfp2XhYT4SUTqIL0JerpV4r
         eNfLvWo/ZPqR6yeU0slcpOKJsntM6/sWetJWQDJgmLuIRL0MkK6Q5P/PqdDl2iD2xHra
         7uSS7yTtY4OYIQ56mNNkZDpawZeeteIfukN/389KpZzih3NBWsdoQo/4Ifu2pZPLYRML
         a0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284607; x=1739889407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8SaDr/lQ8QeoRPH86F9hyguGpM9i9iIGPdAU8SZ5Xs=;
        b=X2gErBQJ4bI3g2kr+lZYc3+jGvRA1A1rXhPbCFlo8far7OI5BfBTOVWShAPi0xJnqS
         D3iQDuZuE5vO8Ojm+BHrthkc3sf6H4Y8mvzvUZ4oYGLxBxPPWSdNSOYDKIh8ygDHONRG
         /zG2fJm//CwOV/7RAWbRjfI+mBvCnKht7t8CHZYvbcMcyR8PGZeF5ULSZaWtjxPC0t70
         3obuK3l0+t7oHHdmBgkH7+BiHAQT3Nrl4mHGny51pgZabZwdczfjzDQPPfOLQ2sVuZBo
         q+47KJZu/Xqx2qeasquRrgc/3wbwjy8XQP+WLNBmfc4yTvQ7VKGmGuDxPTkUy2jMBwtn
         +ZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0K1ZR99bSv165CKmsiUvUs2D13f2bvNfkBGTKpp1SHIOOxzK4V3QmkT3JxmTYACnN84k=@vger.kernel.org, AJvYcCWAxLk7SzColfG1eQXY4hzwsWcuB6WC8V1x1byr2V9KfzMK2ne4UMRhahY30l05HLobmAhxq555PrbY1Tq1@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKsWXTb1XWfQ4GzvbQnzl8p0NCLF8y1EnAuaHreZbu+EFHRzR
	QIE3gAhdUH+i4OVlPqPXmW6Th8fgBAjkF1t/UoO1f+mN7268Pfvp
X-Gm-Gg: ASbGncsvDNy3qqMR8686vy5ntEEnxw7AO+09pDjImGG0I2hqnjNIOeYziwuC2CBRm2U
	g/cAT4EmTOA6xqtvNmZODeLE/MXfsr57mr7dWgEawiaXrZQTjX+3mc+ZpV3bE4V3iIEoGLAXmUz
	BBbmQ6K+8K37Qp3jkhcuPobK6id8mUmx4I0RJCW0Kxg/wahOLcZPaZobIOiD95THqsPO8sEZXwf
	N2fjpLYcSOyrT+fN+G5k/C2sZ3YwcU8R/I6J0f4+ZllmAWgmjZ2zUrARTaNk/c9qAXPzQngJr7r
	/A==
X-Google-Smtp-Source: AGHT+IHYvOZdnmN65WKSWrTtKLE9iGk7tyLYJpQ2F0GvdNHtObaePdH2mn0vu4ixNBomaAOGcIqJmQ==
X-Received: by 2002:a05:6402:40d5:b0:5dc:db1e:ab4e with SMTP id 4fb4d7f45d1cf-5de45072163mr18801420a12.19.1739284607424;
        Tue, 11 Feb 2025 06:36:47 -0800 (PST)
Received: from krava ([173.38.220.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b7b0a2sm9650606a12.22.2025.02.11.06.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:36:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Feb 2025 15:36:44 +0100
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: Re: [PATCH bpf-next v6 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
Message-ID: <Z6tgfKgUdCRaQJ9c@krava>
References: <20250211111859.6029-1-chen.dylane@gmail.com>
 <20250211111859.6029-4-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211111859.6029-4-chen.dylane@gmail.com>

On Tue, Feb 11, 2025 at 07:18:58PM +0800, Tao Chen wrote:

SNIP

> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 8ed92ea922b3..ab5591c385de 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -431,6 +431,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
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

we could use libbpf_err(-EOPNOTSUPP) in here and in libbpf_probe_bpf_helper
sry for not spoting it earlier

other than that the patchset looks good to me

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

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
> +			      buf, sizeof(buf));
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

