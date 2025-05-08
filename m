Return-Path: <bpf+bounces-57742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2001AAF659
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 11:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741471BC819E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1623E325;
	Thu,  8 May 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WTn9Yaj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C49EAF6
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695348; cv=none; b=H2hW+WnJnTWB3osNR+eVXKM5dU95uhGhTRHbIQF4oPDq3EI1AsaYSyNyKuMZH7ePK3Fx2M84qVhV2M767N3TMTqEMF0XwBgfuTFhoJJvHHyZFIoITNrBNVWYFl7n9UjWKE6eZXXYVS78FCBRrSsFdjsMY35I0rSSkjZRPMx5jlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695348; c=relaxed/simple;
	bh=0XCg6ybcnAthS/b2WiCugEbc50hf4ea8OcHZ97lOacA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBZp4Ii7UDpaZc5TQpkxyzQDt4dOB1/Ew7EDhRGWAJuBJb0ULwgKKd9u6ofnz9Xj6RgB4f16KBBhluGgcche0A0sUsqGgv0pPHushIMbLqQYBYNxnJADKxXubQ6oS6fkiA1gHY/ysASoI+Qz7BVpQK3Sf9QGgQgoedH/y/FUk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WTn9Yaj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso1303712a12.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 02:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746695344; x=1747300144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVZlhkbC6kOXZ4nFrH1rTC2aA7CuZVy3H27YQjqGXpY=;
        b=1WTn9YajSuVgmISTDPV+k908TfOLaZ0Wx3ZHZdYvMlas8AuLYlVFyrnlGnPNKG30tn
         Fw/qZrMLU6CTUXXLG+bF3ueXxWI96LD3Jj8Ushbvh60UAY7e11GJZ7Jgt405GgcJAHqj
         tROfkVSi2eshfidcozw0G07LOoU5uGb72TB20QkCbboHIVSEX4ToRtmy1VgsXY1QY7Fu
         uqaKL/o4tdboH9VZw9sS6dk52gm9Ic2D2Gx2YlKN3nYFpt1dVfRNdTGVmsOI6vO6P41y
         LVlGf5fHECwtwJ1FMRMdhgaqnlRe8xy53CJlovBEeFWXQPyaZX8SFZZgFwOTMl7/Cc7a
         xLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746695344; x=1747300144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVZlhkbC6kOXZ4nFrH1rTC2aA7CuZVy3H27YQjqGXpY=;
        b=hMS5WmeEpOO73PMPoHiB89LD98FqrgTXMajTBzqN7RtuOW6a/82zpasEzZLC3qLC5I
         FWhSUYMvKmGqLEo+dXOjoO37IvnXDJ6iscNan5mIpQgd1Y0fHZOrTMkByOjTeUP0v/Xw
         zydJkBXB9Qd6UcXu4vSElSLdajVK5V0w1slIs+7jCxSW04tTXrL7Q0iUKMSM8k/434WA
         FiWU+OMmRizbhn/1Z5I76qRKO4dV6OtOdNlM1JL7qVH322QfXQV2I5HjNhgK2DYJsHW6
         JNp2lq6lW8NzMQX4gdzdt2a8m1BvLDwi23WlvQVan+y78uwbcjubBj4gVQ2S03naeYCS
         bDpg==
X-Gm-Message-State: AOJu0Yy2kHflF3hsz25oVAyJxZjgUaonKaggtUFYdSjcwDro+lR7U/gM
	T9eEZE+bOlDoSXL89qV2APe4CxtosU1lZqT5FQjsmQagb0zDr+Jz/OiThFiZWg==
X-Gm-Gg: ASbGncsIWJjQKi9ExibuUiTWSvd5Fej1H0k+u7ZStsIuYdowOFdmQvNFhcvqA9yMVTT
	zpk6mFa9LbZuprKqAqFA4UzvS5Pdi721ZWOU7pb6/W3LttkOQnrPTPQ8CKdNed5qAgA1hBAOVNq
	lVmvAKM8/y+71h1bL4W4tyO/fn5Z4gToFGO4KqR0SwHsg9X4UI604YRQHxrXbjW9q7P1saxoyJA
	EFc5ZZd1Jzrye5SBCSFE3Cw1aEuUwFNsOBZyBNRr8bhVx4CS0IZo2sHT8I2RcFnJ5/XOOGMAIid
	juFCHGimVi/Hffl4ncmEavaJX9EFxGf6qfVbrDSYJZx7n7o/V8hQ4zDhzl15YC9Cnei7Ro4DlKR
	YYoCk3+w=
X-Google-Smtp-Source: AGHT+IFtqBDuksNfU5Vj3Am9WD1YjrE1wyfvk1JHlfCx91W+UJlXk7AZ3N/QtnuEQN2l5E5ghI7wUA==
X-Received: by 2002:a05:6402:270b:b0:5f5:6299:ad68 with SMTP id 4fb4d7f45d1cf-5fbe9dfc01dmr5378235a12.11.1746695344350;
        Thu, 08 May 2025 02:09:04 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbf7562c80sm2151889a12.16.2025.05.08.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 02:09:02 -0700 (PDT)
Date: Thu, 8 May 2025 09:08:58 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Teach vefier to handle const ptrs
 as args to kfuncs
Message-ID: <aBx0qmVvL84Jb3rf@google.com>
References: <cover.1746598898.git.vmalik@redhat.com>
 <1497b70f2a948fe29559c6bfb03551a7cc8638f1.1746598898.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497b70f2a948fe29559c6bfb03551a7cc8638f1.1746598898.git.vmalik@redhat.com>

On Wed, May 07, 2025 at 08:40:36AM +0200, Viktor Malik wrote:
> When a kfunc takes a const pointer as an argument, the verifier should
> not check that the memory can be accessed for writing as that may lead
> to rejecting safe programs. Extend the verifier to detect such arguments
> and skip the write access check for them.
> 
> The use-case for this change is passing string literals (i.e. read-only
> maps) to read-only string kfuncs.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  include/linux/btf.h   |  5 +++++
>  kernel/bpf/verifier.c | 10 ++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ebc0c0c9b944..5cb06c65d91f 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -391,6 +391,11 @@ static inline bool btf_type_is_type_tag(const struct btf_type *t)
>  	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPE_TAG;
>  }
>  
> +static inline bool btf_type_is_const(const struct btf_type *t)
> +{
> +	return BTF_INFO_KIND(t->info) == BTF_KIND_CONST;
> +}

I've seen btf_type_is_* related helpers lean on btf_kind() instead
here, which ultimately just wraps BTF_INFO_KIND() macro.

>  /* union is only a special case of struct:
>   * all its offsetof(member) == 0
>   */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54c6953a8b84..e2d74c4d44c1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8186,7 +8186,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>  }
>  
>  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -			 u32 regno, u32 mem_size)
> +			 u32 regno, u32 mem_size, bool read_only)

Maybe s/read_only/write_mem_access?

>  {
>  	bool may_be_null = type_may_be_null(reg->type);
>  	struct bpf_reg_state saved_reg;
> @@ -8205,7 +8205,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>  	}
>  
>  	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
> -	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
> +	if (!read_only)
> +		err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);

For clarity, I'd completely get rid of the ternary operator usage
here. You can short circuit the call to check_helper_mem_access() w/
BPF_WRITE by simply checking the error code value from the preceding
call to check_helper_mem_access() w/ BPF_READ in the branch condition
i.e.

```
err = check_helper_mem_access(..., BPF_READ, ...);
if (!err && write_mem_access)
   err = check_helper_mem_acces(..., BPF_WRITE, ...);
```

>  	if (may_be_null)
>  		*reg = saved_reg;
> @@ -10361,7 +10362,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
>  			if (ret < 0)
>  				return ret;
> -			if (check_mem_reg(env, reg, regno, arg->mem_size))
> +			if (check_mem_reg(env, reg, regno, arg->mem_size, false))

For clarity, I'd add: /*write_mem_access=*/false). Same with the below
call to check_mem_reg().

>  				return -EINVAL;
>  			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
>  				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
> @@ -13252,7 +13253,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
>  				return -EINVAL;
>  			}
> -			ret = check_mem_reg(env, reg, regno, type_size);
> +			ret = check_mem_reg(env, reg, regno, type_size,
> +					    btf_type_is_const(btf_type_by_id(btf, t->type)));
>  			if (ret < 0)
>  				return ret;
>  			break;
> -- 
> 2.49.0
> 

