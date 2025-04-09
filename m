Return-Path: <bpf+bounces-55531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DDDA827B3
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C811B64F1B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32C265CB0;
	Wed,  9 Apr 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzmlOKPI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D8265CB5;
	Wed,  9 Apr 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208718; cv=none; b=h5BbQ0eHXGx6qiyNpY67D/ei3Et3g0DAmrW8GknwOyeKQllDWfl+tf35Cq27lSLfS0nrszy3jckYhE0UPpGW3W9RFicmK3nIBceUsIxMX6qMXX5bow/ZMwfOPyj7+zHZ+Wkoz+tYHWRlxXFGbC+ngHX194iptnfxn+AOqu63ZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208718; c=relaxed/simple;
	bh=qCQcsvfYktQKjto5hQwySNvL5iBrBUQml5G8WWesrTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgHJjCTMmRmGmkAUGHoSmHDQk+5nKjXcyCpXdZANSPYovglbSdnQfOTzfryzaC2hUI7+a/78IZdMwpmwlZyfGje7m2h3wPs8jbi2luJ9SqTVdCGutngSmP71Cm7zIzIc1OJksnJp5VaUHR2wAefnzHEbAxTACLcpqp3/H4FIzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzmlOKPI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30549dacd53so831483a91.1;
        Wed, 09 Apr 2025 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744208715; x=1744813515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zfJxLC7wLvSINk+yl7dVGie7f5vAe0C3LCRWygQl7Xw=;
        b=hzmlOKPIJUawVMKiMrOosO01chQCSWjloIOhh+QCyGhaZD3HRegilQSJpcMXIqDZci
         mrfVgdaq/QjJ56R3eDMaXCPsh/lW/8X48XcStN4L+9EOiXfOUy29atgqpWuGSZP9DCbj
         uC3E4OUr5sPZki9QLzNQSr3nGKZetfPF1KLq9/dpgvtE0oR6094NtuAIWNJTEnpBuEVD
         BHiGSi9GIhoSwgd0RiSn+YK2U0LcCe++7IFVNJlBobQcaG5UgUdLwn6lB2WjY1WmEg8P
         5tfYudYUW/JkzY/xUR1NnveizlbCCor29umfdM/sE9LB2IGsstO0jKSZzlwTMV1fUZ7a
         LW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744208715; x=1744813515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfJxLC7wLvSINk+yl7dVGie7f5vAe0C3LCRWygQl7Xw=;
        b=hvsU69PNblKi4w9vETzaTWBwNi4Tgg7UYoqnUnBXopYjiGq1ab62u/kE2fgrreDGiw
         LUeqJfLS76IFRDvf0lUJtKtSycoZIfrwX0S+b8zAgOLGomgQ1n/3qabV9/79mIWzdLMZ
         lZoKkpdK4+iM+5fS1V4FQacy58VzexjX/HxNxnxqvd9EsYBORKIQY5Eu7oCySHuy/+3M
         H/4IqGhLTsoI4XJTl2gb5qUx6r2G8So58fi+K9Q4FHUt8tyI/qv6JaNBReSSWDbFwqtZ
         ho57Mk6VufEOzmRDFK2Mi0APOe/bO0JHCY43AtHsdWsaoq180XpdG6s/OT9wItMvsCVR
         HPIw==
X-Forwarded-Encrypted: i=1; AJvYcCUGWRGyxYC9w3RkHrdBbJRA7x6CB/3fGtNaWB+G2vIOYGHNgH5puKwdowICijBLiMjDPcFyAwKCXG6+VwqN@vger.kernel.org, AJvYcCXCIKZqRXzSjZ1xFVc8FImRWiitnfvSKD+JZgGD9Cbqpi2hC2D3Cq/DstSHH0alwQWFvSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFC2nmkzzl4thL5OhAz9G8UBFNO3WObGev5/kRJjFKrb7I3z9
	5B8We2tgmjW4Nrrz/Y8YJR1hwdjgM1ff2v2u2Vw8hQCwExu6QQg=
X-Gm-Gg: ASbGncuCTAoy+kgtZ2IYtUnyf1cB1nsm+jpxMVv0gaYt5BJbXzMw5ePLEuQT9/9ZqnQ
	qlVB7rIGIPkeR8QozONmyiyvo2acF6hB9zHx6uPk0TSfU8Ar4V/gx6zlDCN5Aq2hNAv5vZEvBBJ
	vc3/MRCSF2OzdMre3BsPbLSf4XeX0dphI3PScBsrlrqgfEtBkT2/N+EknJkNqr41jmBYxhM1PLu
	3KF6mZL7cPRNNyS1NZK98LJgtKItx0kzGABqOiGqb+kOQ4Dw4SwZzrgNCw0yXlhmj5fTVVExe34
	NwnVsfz0vjvB0g67hS00cf1dMb+Yl2zLAQg+vfYQ
X-Google-Smtp-Source: AGHT+IHGLYcoO/orX7nCWeuHDsnJqoy2EHiHXumGysMZgYJ95by5Ga9thZxXcKt+YCsnQ/TLrwaXgQ==
X-Received: by 2002:a17:90b:5283:b0:2ff:6e58:89f5 with SMTP id 98e67ed59e1d1-306dc0452bfmr4891770a91.6.1744208715405;
        Wed, 09 Apr 2025 07:25:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-306dd10c42asm1832714a91.7.2025.04.09.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:25:14 -0700 (PDT)
Date: Wed, 9 Apr 2025 07:25:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 10/13] bpf: verifier: Add indirection to
 kallsyms_lookup_name()
Message-ID: <Z_aDSipnuvNAhHbE@mini-arch>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
 <7540678e9a46c13f680f2aacab28bb88446583f5.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7540678e9a46c13f680f2aacab28bb88446583f5.1744169424.git.dxu@dxuuu.xyz>

On 04/08, Daniel Xu wrote:
> kallsyms_lookup_name() cannot be exported from the kernel for policy
> reasons, so add this layer of indirection to allow the verifier to still
> do kfunc and global variable relocations.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/bpf.h   |  2 ++
>  kernel/bpf/core.c     | 14 ++++++++++++++
>  kernel/bpf/verifier.c | 13 +++++--------
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 44133727820d..a5806a7b31d3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2797,6 +2797,8 @@ static inline int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
>  }
>  const struct bpf_kfunc_desc *
>  find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset);
> +unsigned long bpf_lookup_type_addr(struct btf *btf, const struct btf_type *func,
> +				   const char **name);
>  int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
>  		       u16 btf_fd_idx, u8 **func_addr);
>  
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e892e469061e..13301a668fe0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1639,6 +1639,20 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
>  }
>  EXPORT_SYMBOL_GPL(find_kfunc_desc);
>  
> +unsigned long bpf_lookup_type_addr(struct btf *btf, const struct btf_type *t,
> +				   const char **name)
> +{
> +	unsigned long addr;
> +
> +	*name = btf_name_by_offset(btf, t->name_off);
> +	addr = kallsyms_lookup_name(*name);
> +	if (!addr)
> +		return -ENOENT;
> +
> +	return addr;
> +}
> +EXPORT_SYMBOL_GPL(bpf_lookup_type_addr);

Let's namespecify all these new exports? EXPORT_SYMBOL_NS_GPL

