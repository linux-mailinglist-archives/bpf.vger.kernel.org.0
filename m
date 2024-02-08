Return-Path: <bpf+bounces-21496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12884DDD2
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A1D2873E6
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B26BFC5;
	Thu,  8 Feb 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZxL1rWQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F346A8DD
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386849; cv=none; b=XfgLzDueE/z55w86Q0hzOnv5UIGfG8KjE/DWO3h7WVCXURZntvBSt+Mag9U0b5+fwDhEGM0+lG+ezfuUNvjBhunBWoMGxwf5gfoIOxk48JJQ4sbEVyc0iPdclxyi/Nld7gcURtnDmXTBrVut5wC/Lb2RMIS+0l+R0cGy464Ui0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386849; c=relaxed/simple;
	bh=jB9/BC0KMkISJGJGxdjiwmcbZeYiwh1v7CGd7yKWecE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJeq9r0dwrMgLiCdikH3JJ5wy9AbWQ3Aq/EdwuLkAlWAZM1+g4WSlh1pSdxD04cf+5/df6g3x61h7d7EhtmtJ1zKeEsMpsWtaZHfxXwVMuBPtUTvGyV/+fBbD2Q+fPBGI8EOgRytVuN/aXgD1M80jPscllV+Kf2CqGZteowGFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZxL1rWQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a389ea940f1so122824366b.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707386845; x=1707991645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8fb+YvBsdVcnnHkzFxUln74tRjF4QqHKhCUF3xZSnA=;
        b=kZxL1rWQFvuTQAgwY0P3+drOY+EmY8U6N2jiFmPQCWRatHcNW7at9MBxovOYlNDfIu
         DronWGIki6SCP3NQtiFfmu/Z7uX1E/kqTcbFNUebDo+qDhKwSJKNeIeMf1oAxP2+jDnt
         yMd2wz9Gh9mHl5F5UGVOkN9exLAFSPIXs2vt8EvIaKlWh/+egFwLyX/FV/mxCIiiyNdx
         5D3TpXKpwShz4a0GptAGuiucASecjMS/VZkAo6BoVfzC+SI7810KPqGEb0Acem/Rhm7A
         0jHKk9pDf6GGRifw2IhvjGE09C/DsRnViSEGLd7xYc3Uwz5hfFmLC0RUpd0u91+WjJxL
         mHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386845; x=1707991645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8fb+YvBsdVcnnHkzFxUln74tRjF4QqHKhCUF3xZSnA=;
        b=e9iSjkaa1PZa0BL7LRnw6OL6tK8mJspRSGQOlttukuN2MmrJiQXAsK02MuSJhifycM
         CNTXLS6KiNRJb3f01aMR9XaJwT/VsCFQ38vAjljIAxzIQI1LPNVM0PH7BLRJ3qmCmyeP
         +9+0c2PF08UbvY9FerlHDtHyjkl8m5b8qN9YDSTzS5se/6r4aOdsdXL1OL59NPoQ2W8t
         gKsB0Vz6NsRY5LEYqON+tp4aAJYEUZlyFwdCw0zX8/i0yEnTcQHNKB2BCxuybL3QNr5S
         2fCKcsMKo7dQpUdBAVRDjIWh3rtOXSvfxyn+BHDqK67ZoMCNS1Blu5OWwI2N2TxC2kCN
         EUjA==
X-Forwarded-Encrypted: i=1; AJvYcCXBNTeGddqfGodr/RLEv5zCDX+vFxHzE/3BsvD75YRvUf5nZd+JBvQfw6znyVIbdKEb0Bdp3zQ2GeNJ2isR62YUqJge
X-Gm-Message-State: AOJu0YxVz9ZqHFmsjtZgyjjsulLjkjUQUqFexOb3oxNdttReq+PWR+qP
	7XSn3OSszT3NVWJ6cjOxXLLTvNvxyzcorFgn6up9h+KR+P8Hgglq/DxC8tm3Hg8=
X-Google-Smtp-Source: AGHT+IG3YEfJvenvjYmPoz9ZAmBu+ajib2nUKE9CVt+jzDQyS5/dC4bSLRRLFeOxvF07b0Lv9X9cCg==
X-Received: by 2002:a17:906:5291:b0:a31:7dc1:c7c1 with SMTP id c17-20020a170906529100b00a317dc1c7c1mr6092311ejm.65.1707386845409;
        Thu, 08 Feb 2024 02:07:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDrjgrvUu/tIXuK8aQIZVYawKnPek0WndjeQ5aWBgAFoUaMf/pel+v5gbQHA/xz/XmW98cvcVhEpWBvdQX8tuOXuAngA6T6C5K3mkmTxdttBKHX8DsSXqH/UXJRXEVS2sy4YSkJNLFvxWYVa8IyNxA/mtopsZvb1k16AxWtJOAZHB20tceHw5ritC3gZyPyzu6GU/LBD6yHZhBSzJeQocJC2TE6no4DudJFHbKORXgXYW7oFN1AvDKZumt6MQ4RsAl/mJpBwlDADAMBISHwcpyA11Jde/xPtPUc2jKdli0MJPlk+KTCsrHE1kcBux4zafP/f1c7v63Ap26inwZ0/BM3pTzlo+P7MSZqiPe0H63wdW/vEMnMgKU3I5xx1mS5Qpr0au7rLygeuvi1f4m5qGrXmOefQFDYwyeYcJA/a0nXtKNygjtqIFgQkIdPEeh/+YO3MQ=
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a3891fb4c0esm1231657ejc.107.2024.02.08.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:07:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Feb 2024 11:07:23 +0100
To: Geliang Tang <geliang@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH bpf-next v5 2/3] bpf, btf: Add check_btf_kconfigs helper
Message-ID: <ZcSn24Isfsg45jBJ@krava>
References: <cover.1707373307.git.tanggeliang@kylinos.cn>
 <fa5537fc55f1e4d0bfd686598c81b7ab9dbd82b7.1707373307.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa5537fc55f1e4d0bfd686598c81b7ab9dbd82b7.1707373307.git.tanggeliang@kylinos.cn>

On Thu, Feb 08, 2024 at 02:24:22PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch extracts duplicate code on error path when btf_get_module_btf()
> returns NULL from the functions __register_btf_kfunc_id_set() and
> register_btf_id_dtor_kfuncs() into a new helper named check_btf_kconfigs()
> to check CONFIG_DEBUG_INFO_BTF and CONFIG_DEBUG_INFO_BTF_MODULES in it.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  kernel/bpf/btf.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16eb937eca46..e318df7f0071 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7738,6 +7738,17 @@ static struct btf *btf_get_module_btf(const struct module *module)
>  	return btf;
>  }
>  
> +static int check_btf_kconfigs(const struct module *module)
> +{
> +	if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> +		pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> +		return -ENOENT;
> +	}
> +	if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +		pr_warn("missing module BTF, cannot register kfuncs\n");
> +	return 0;
> +}
> +
>  BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
>  {
>  	struct btf *btf = NULL;
> @@ -8098,15 +8109,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  	int ret, i;
>  
>  	btf = btf_get_module_btf(kset->owner);
> -	if (!btf) {
> -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> -			return -ENOENT;
> -		}
> -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> -			pr_warn("missing module BTF, cannot register kfuncs\n");
> -		return 0;
> -	}
> +	if (!btf)
> +		return check_btf_kconfigs(kset->owner);
>  	if (IS_ERR(btf))
>  		return PTR_ERR(btf);
>  
> @@ -8214,15 +8218,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>  	int ret;
>  
>  	btf = btf_get_module_btf(owner);
> -	if (!btf) {
> -		if (!owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
> -			return -ENOENT;
> -		}
> -		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> -			pr_warn("missing module BTF, cannot register dtor kfuncs\n");

nit, we do lose the 'dtor' from the message but I think it's ok,
for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> -		return 0;
> -	}
> +	if (!btf)
> +		return check_btf_kconfigs(owner);
>  	if (IS_ERR(btf))
>  		return PTR_ERR(btf);
>  
> -- 
> 2.40.1
> 

