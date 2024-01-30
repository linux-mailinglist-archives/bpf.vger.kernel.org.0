Return-Path: <bpf+bounces-20700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2C8422D4
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD61F22955
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246D266B58;
	Tue, 30 Jan 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewDz92vX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A8C6772C
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613612; cv=none; b=hGZ8y2qwh4YwRirbKYuDUmEOr/GrEn0J5XZlipwAdZLpvy9obANykryBaBE2pd5+cxXDcMiROn3AIgi2eCS5tkkXP4UQzYO4LwXtJ4OS4b9zpiDhnlasNVMvRyLC7FD6FCW6VIMjkXfDxs02OIrL4p3ZZfvsLMyp8NE9qzyLh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613612; c=relaxed/simple;
	bh=FPZGheY36pbF0To5+syTVH3mVtOc/AQ3hyGLWTy3hNE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaFg7tvxTQZrUN1BI4ygUeZNWYufPfexfcSNnbCllQa/Oyay71u7oO+Jv3dct37BBFeyBIbN4GrkfWvFUPmVAKhvETerxWZHaG4Mo1oXWfVQEkwRvRMA4rLdbt1iSfnu6W6zIruvDfrT16B4xZqlcPwIYe+BVSqYBLeBVYPYsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewDz92vX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso472895266b.2
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 03:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706613609; x=1707218409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+/R2/5P1Fn0iWjz4KSoFQjDgDOHLlpXi94KdJ2UdzI=;
        b=ewDz92vXiThLs4axhGf/uu8svxJARzNEZS9gjK91yzaSij05Dv4yYUtIVEsw88K3zu
         uJrNucGppN0ivoTBMmtFxsSa7rC1K4d08pskCyO/tjccSBSg6ceQPRXYI56BWdOYkeND
         3iJabGYx6rhQIovue4eoT4LmVew7ox13g0dIoA8WydxT9dKbkYWc08RIUDxCPblQzb7h
         ALytuuCF0s/l5GTpeWBVTxrWgvVK0T2q2mCB84oa7/MpFw33hW0/tKrssSC3qucxR6nd
         rs7v7LgUVt8xRAUC5dgWBEJ0+5bszaf09sPVnTA1l1EhRx+JHlKnrpvRGgXwZJC3LIMh
         Y2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613609; x=1707218409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+/R2/5P1Fn0iWjz4KSoFQjDgDOHLlpXi94KdJ2UdzI=;
        b=DEBthHTrs6dJtuEb7KvdLE+18TU4RfNHv/e1Mf8fmx6Tne/nQ3Wi/q2taJwH6Rdgfh
         cdcNotqJ0TZeZVJg1AdAIB0frfqekjSkLuWrAsMOM0YdM0aC6wocf71IPhSu5mGxGQ5M
         35fQxvjT2CoX7FJUynz2dI9mSdFE5j2IxaDqvzm4Oyujehm9mR2grQuJxMJrsoHHluHk
         NnSm3UL0kNzmyEOyAimbJiSfiCU96OIAoPrpR9qYKU3Z68+oZvap+6cGFoVwDjjRu3H2
         tAz3XAw3UGc+VpkKNNQY/YFBqS1eJLh2r6qJmPcWXe56tgPkSiJBQiUkNtmCkasNQmnv
         HZ6A==
X-Gm-Message-State: AOJu0Yx9T5ewxsQYxBIhLjoSgejZeTPl0mk48vMlyT+dD0wVXFbpJAux
	Hf6iNiiXCpbwSBidy9k5MCJ1DWv8EIEEriThUOf0wBKow/2hAiaU
X-Google-Smtp-Source: AGHT+IEgxQD9vrlBcdrxMnfA26D1QFSy/m9JL6maPMRrSxOxTGdZKalRhw2HyGxdbahDi877coD+FA==
X-Received: by 2002:a17:906:1792:b0:a35:7192:1f with SMTP id t18-20020a170906179200b00a357192001fmr5832884eje.49.1706613609167;
        Tue, 30 Jan 2024 03:20:09 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id pw18-20020a17090720b200b00a35c1d11621sm1985179ejb.131.2024.01.30.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:20:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Jan 2024 12:20:06 +0100
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: fix potential error return
Message-ID: <ZbjbZjS2IWuj09VK@krava>
References: <20240122164936.810117-1-aspsk@isovalent.com>
 <20240122164936.810117-2-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122164936.810117-2-aspsk@isovalent.com>

On Mon, Jan 22, 2024 at 04:49:32PM +0000, Anton Protopopov wrote:
> The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
> error is a result of bpf_adj_branches(), and thus should be always 0
> However, if for any reason it is not 0, then it will be converted to
> boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
> error value. Fix this by returning the original err after the WARN check.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

> ---
>  kernel/bpf/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fbb1d95a9b44..9ba9e0ea9c45 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -532,6 +532,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
>  
>  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
>  {
> +	int err;
> +
>  	/* Branch offsets can't overflow when program is shrinking, no need
>  	 * to call bpf_adj_branches(..., true) here
>  	 */
> @@ -539,7 +541,12 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
>  		sizeof(struct bpf_insn) * (prog->len - off - cnt));
>  	prog->len -= cnt;
>  
> -	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
> +	err = bpf_adj_branches(prog, off, off + cnt, off, false);
> +	WARN_ON_ONCE(err);
> +	if (err)
> +		return err;
> +
> +	return 0;

could be just 'return err'

jirka

>  }
>  
>  static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
> -- 
> 2.34.1
> 

