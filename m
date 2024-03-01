Return-Path: <bpf+bounces-23151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534A86E43E
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 16:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB51F249F4
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05D6E60B;
	Fri,  1 Mar 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+RP8+ky"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A896BFDE;
	Fri,  1 Mar 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306674; cv=none; b=F9NxyOsV5ncyDL6YhT15cfYEoQRFYAuu7RBmeZ08zq+tDa2Zvd2Vv8M57nBTcsixR/kU3ts2erHKl+03T+ob2uTNTIPB3o541vadSXhV0JyelbRsL8ed/VKmSjQ02NuCuVtjX2TX/SoYObFIYnTvHjTtSQzOvnROO0E5ldWRjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306674; c=relaxed/simple;
	bh=33/sPwUCVGJBaZBqwstRiFLOxGbB42pYs5Iiv3cqK7o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/dceocY31wK/Lujs3v3xj358Ms1Jz5jazV3/jZFIvLXbyg3QBbc5axi1vJ8hZMlaSuCpya4AAfbEuRDhAnxL6hn+7cR6cDyZxHZq6lCu2zAxRqWD71LYMjyprww5Ob0xTMgQO23s9qmxsbS+B47puqdB97Q3UBAgKE9AB2qGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+RP8+ky; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4429c556efso372364666b.0;
        Fri, 01 Mar 2024 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709306670; x=1709911470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brg+65tHP59HmD9Vnjm4p9WorCcCtyt7c+xm8JLyK9c=;
        b=e+RP8+ky0ywyO7Yv8Tr7Zxg+YDbxHh8f3GD1ilDFkRajKosOa59kt6vUgCdZHRn3I/
         OBqWXpnH77u3ljyLTJczh+f531nw3gvcpiP3x11IEh+z5EgzJQYT+1zzLQntkHLgpUEb
         u1tQs31pDjWIYnecTfLoVk/QT3IIyXEv8MzPPydBGQ/9JCfmVWvkHBw9H7/ziR2hnLPK
         FdUzciWgjQC7xjDiJBo/h/NrMeU5FYQhQ1BS66HpPq/To7I58BhtpG+r1mY2FnVfhU4b
         9dSTMCEBh3vMxApBZHwzIxedBN9N/jy+SVpwy+Gn3CtjgV5hG96oRHp47HcUuY8XuUXn
         XY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306670; x=1709911470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brg+65tHP59HmD9Vnjm4p9WorCcCtyt7c+xm8JLyK9c=;
        b=ep1ldovrCPP0N+tAJjgFZCRn/Ur4D5jJuJnWl3d2E6soF84lvk8hibAvdqPV166e+p
         VwwThh/DuKJCAgCiUxhPgLgXm6oa2Ncz+F6ONwEW1szFh9mJ6MdgS5YqjhOtFAXJN3Ce
         vQFb45Tqk1zYVdfqlmq0maxubfo0spvEfk0jAcTXr5oNQN5x8WkrXbA1mWLA7AqibTxg
         It1EXYGAn6sSrR7Eohe9UgcPC4flj4LTinSPfiy60a7ZDAOig4EUlgrFp9dFI5kBek2y
         z/HS7xIXPKo4M0vD5LWrzIDjufoDdQLcb6yxjjE7h9XVfWPM+dCsZLcwe4ok33XzRu1O
         G9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLLp4RycvBUKFy/s8B+Mu3HKGW4O5tV7O/40dAolsaGQ9U4Umg29Pvob89M3pwRerodTQDaLvXP9IQGicDi0+XnuTJQOnNxlctLv/14tNdAB32xz/ftyDSgjeabA==
X-Gm-Message-State: AOJu0YxJ2UPYuYwybQWSSVNNAKcTfYH6BiKdFHkBXmIZfolJHgR+ob2f
	57QLX4YnmC0E25/F3f6URvAtJK4cGNU0LPD3ZAFZDDqHdr5Gwn84
X-Google-Smtp-Source: AGHT+IGdIg1Fx/66nR8+ZiIAK3H+G2ZRWvuAhhWWmjqq3C/K278FtYNFGDreQe+XJHjJbBgQv/xGFg==
X-Received: by 2002:a17:906:2c57:b0:a43:ff8c:6d9c with SMTP id f23-20020a1709062c5700b00a43ff8c6d9cmr1866346ejh.56.1709306669484;
        Fri, 01 Mar 2024 07:24:29 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ot7-20020a170906ccc700b00a43c3e5e008sm1786296ejb.205.2024.03.01.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:24:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Mar 2024 16:24:27 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@redhat.com, dwarves@vger.kernel.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: dynamically allocate the vars array
 for percpu variables
Message-ID: <ZeHzK52IeDx2aZfP@krava>
References: <20240301124106.735693-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301124106.735693-1-alan.maguire@oracle.com>

On Fri, Mar 01, 2024 at 12:41:06PM +0000, Alan Maguire wrote:
> Use consistent method across allocating function and per-cpu variable
> representations, based around (re)allocating the arrays based on demand.
> This avoids issues where the number of per-CPU variables exceeds the
> hardcoded limit.
> 
> Reported-by: John Hubbard <jhubbard@nvidia.com>
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: John Hubbard <jhubbard@nvidia.com>

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  btf_encoder.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index fd04008..a43d702 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -50,8 +50,6 @@ struct elf_function {
>  	struct btf_encoder_state state;
>  };
>  
> -#define MAX_PERCPU_VAR_CNT 4096
> -
>  struct var_info {
>  	uint64_t    addr;
>  	const char *name;
> @@ -80,8 +78,9 @@ struct btf_encoder {
>  			  is_rel;
>  	uint32_t	  array_index_id;
>  	struct {
> -		struct var_info vars[MAX_PERCPU_VAR_CNT];
> +		struct var_info *vars;
>  		int		var_cnt;
> +		int		allocated;
>  		uint32_t	shndx;
>  		uint64_t	base_addr;
>  		uint64_t	sec_sz;
> @@ -983,6 +982,16 @@ static int functions_cmp(const void *_a, const void *_b)
>  #define max(x, y) ((x) < (y) ? (y) : (x))
>  #endif
>  
> +static void *reallocarray_grow(void *ptr, int *nmemb, size_t size)
> +{
> +	int new_nmemb = max(1000, *nmemb * 3 / 2);
> +	void *new = realloc(ptr, new_nmemb * size);
> +
> +	if (new)
> +		*nmemb = new_nmemb;
> +	return new;
> +}
> +
>  static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *sym)
>  {
>  	struct elf_function *new;
> @@ -995,8 +1004,9 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
>  		return 0;
>  
>  	if (encoder->functions.cnt == encoder->functions.allocated) {
> -		encoder->functions.allocated = max(1000, encoder->functions.allocated * 3 / 2);
> -		new = realloc(encoder->functions.entries, encoder->functions.allocated * sizeof(*encoder->functions.entries));
> +		new = reallocarray_grow(encoder->functions.entries,
> +					&encoder->functions.allocated,
> +					sizeof(*encoder->functions.entries));
>  		if (!new) {
>  			/*
>  			 * The cleanup - delete_functions is called
> @@ -1439,10 +1449,17 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
>  	if (!encoder->is_rel)
>  		addr -= encoder->percpu.base_addr;
>  
> -	if (encoder->percpu.var_cnt == MAX_PERCPU_VAR_CNT) {
> -		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
> -			MAX_PERCPU_VAR_CNT);
> -		return -1;
> +	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
> +		struct var_info *new;
> +
> +		new = reallocarray_grow(encoder->percpu.vars,
> +					&encoder->percpu.allocated,
> +					sizeof(*encoder->percpu.vars));
> +		if (!new) {
> +			fprintf(stderr, "Failed to allocate memory for variables\n");
> +			return -1;
> +		}
> +		encoder->percpu.vars = new;
>  	}
>  	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
>  	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
> @@ -1720,6 +1737,9 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
> +	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
> +	free(encoder->percpu.vars);
> +	encoder->percpu.vars = NULL;
>  
>  	free(encoder);
>  }
> -- 
> 2.39.3
> 

