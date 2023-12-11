Return-Path: <bpf+bounces-17400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992080CA4F
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD2EFB20F8F
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893D3C079;
	Mon, 11 Dec 2023 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3bG1Uk0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926ADAF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so16316285e9.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702299367; x=1702904167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07WWJTYtgoBRs54pd3MyHpOVlSOYxugg82Kx39m+wiA=;
        b=J3bG1Uk0e+y7OxCaBJTzXqVdzEA8GyjaxauKjLkw+YnPQqjScFozAa7hCq7ZhLr8Tk
         RSL+ScmRy+8difjdMxgBJvG3GqE6VeqE2aCTTCUiNSU0xMRkBqWssZLjSeuOpV7PzZEr
         9z7ErcPHqHzK96S0M3r8MUPUjSlwGUna0431jtd4yUCdYQMgLORvcTFDCYUDjFDukVk+
         pBaABu3LZR3c4e6JTkxzGVdYSxYWkn748CDcSSX1DK7QoCJnayX0AsBqJJREpLll/Pjm
         9xVHyb5GwbO3KwcvRcA5wDQ0M2hwjR2LOjsN19IefhlMTfStGI/HlYugVn/D92K/bwLr
         b0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299367; x=1702904167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07WWJTYtgoBRs54pd3MyHpOVlSOYxugg82Kx39m+wiA=;
        b=Y2+Ij2zQsjfRLK3fxzVsQ2CUjQJ2f42Wh1r9zQyjMJ5o6Q7yPLmze4bDlmrAvWfTP+
         NdJWD4T0KC77bwHHwLiuA0CfkWQa8rZ3RxoHQJNJI03boMAa3JiLTmEON4tdaKaiL+WN
         9CvzEa4vuc2Y1ZVyeI2rLj+B90oy+bOq+bFNd752bnbdWaN48kaEC2SqSwxwwt7PEU8S
         dXBitt4Fd0a66x1Ex1rN+0ANtLQKb15/oAbjszETF2FZd4NUtbIH3bsvSp0PXyBM/5oR
         wrOXO5/otv6IG+6J+3g8SVyJR81zYhXH/+Uv1HWr1VOxQv0eXJHVVqQVsz3pNVg6nH5c
         MoLQ==
X-Gm-Message-State: AOJu0YyhZ8nMJK8o00a9jgYpX+8S3t3zzjbfOHLLZyEfguNIZneTHAbg
	icOzvZj0vCCg+5zfaEsEWZo=
X-Google-Smtp-Source: AGHT+IFlHAEIBdzDNAeMJ/+uHHI76XL6+5wxUpyDT2qhkLrfuyXTgBPw0MKqKA2PiSgvil1/6vuK3w==
X-Received: by 2002:a05:600c:2d4b:b0:40c:21e6:13cf with SMTP id a11-20020a05600c2d4b00b0040c21e613cfmr1812735wmg.155.1702299366867;
        Mon, 11 Dec 2023 04:56:06 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c384d00b004030e8ff964sm15241964wmr.34.2023.12.11.04.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:56:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 13:56:04 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 2/4] bpf: Use __GFP_NOWARN for kvmalloc_array()
 when attaching multiple kprobes
Message-ID: <ZXcG5AZm4SE08UcA@krava>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-3-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211112843.4147157-3-houtao@huaweicloud.com>

On Mon, Dec 11, 2023 at 07:28:41PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> An abnormally big cnt may also be assigned to kprobe_multi.cnt when
> attaching multiple kprobes. It will trigger the following warning in
> kvmalloc_node():
> 
> 	if (unlikely(size > INT_MAX)) {
> 	    WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> 	    return NULL;
> 	}
> 
> Fix the warning by using __GFP_NOWARN when invoking kvmalloc_array() in
> bpf_kprobe_multi_link_attach().
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  kernel/trace/bpf_trace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 07b9b5896d6c..64f200890c19 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2605,11 +2605,11 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
>  	int err = -ENOMEM;
>  	unsigned int i;
>  
> -	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
> +	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL | __GFP_NOWARN);
>  	if (!syms)
>  		goto error;
>  
> -	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
> +	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL | __GFP_NOWARN);
>  	if (!buf)
>  		goto error;
>  
> @@ -2972,13 +2972,13 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		return -EINVAL;
>  
>  	size = cnt * sizeof(*addrs);
> -	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
> +	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL | __GFP_NOWARN);
>  	if (!addrs)
>  		return -ENOMEM;
>  
>  	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
>  	if (ucookies) {
> -		cookies = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
> +		cookies = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL | __GFP_NOWARN);
>  		if (!cookies) {
>  			err = -ENOMEM;
>  			goto error;
> -- 
> 2.29.2
> 

