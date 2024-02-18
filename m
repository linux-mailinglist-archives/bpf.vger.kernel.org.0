Return-Path: <bpf+bounces-22231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F98859784
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 16:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3D9B21072
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A886BFD3;
	Sun, 18 Feb 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nok6Eciu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302B65BBA
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708268782; cv=none; b=F254NFLXCGbFU0+zZO3yV3x3AAvPEVWAC7z6ts+BwJWnkztXGLAiIetocSEfzOKZZt6ttLICBw5atLBn6vN/xSAWdTcoXrgvk0V8a3zHYS9ma6oERXKlCJEmdbIk4ZXhqgrmEl9wvUKc8GRXKZ+xsSYaegGmNDZVK5XLj2/cmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708268782; c=relaxed/simple;
	bh=tGxXT1XhuS6erETM7SEYMuB1n/Ny+q6o/Kd1LNyFGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE5aYbVo2gOomwd1sKWt6uBBVQHg/2WHVUoiupttoDk5pJ7wM403KoDGsfOAWZO9lMVqgjCZXMO6a4wMiYVeU3v3nYP1VkiqRHXAf+ke0Mxbm4UOzgrrEvfMMCWxsHfnCexAISZ5nUPfsrLUPR6ZVPumTbK6hagnBsjMDn5SAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nok6Eciu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3014887a12.1
        for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708268780; x=1708873580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weWvwdjLFnP8JZ5vKjO/UijVTnJpQLLncBhysMzZFhc=;
        b=Nok6EciuTdMz1z1pS6cwicCCDdDOCTlLLo8ABabxLV63CY9iqUxn64wyit7TOT0kaJ
         QX2hm83AMDkBl2NkOt5cVe4oG7h2l8B+qZVKbsRS73MoqmO7I6RX4K8TrcKX5jtJzLUk
         tI3z8QSxh8c2UaT8LapZMXo5PsTJA9g3cZCDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708268780; x=1708873580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weWvwdjLFnP8JZ5vKjO/UijVTnJpQLLncBhysMzZFhc=;
        b=AXX7x+hNgGYsPdNEKwO183US56f8qQz6KFmxb17I7vH/4VLurE0i4kYFjS/Zs5vnZ5
         p0QF+7/wNIcq2aQSXCWYmLMiKYixEHB8jLmRcbaa55yEnIgu9yOsC8vQ4+91QQgSIhtj
         VGfb5SLmlTD9BeLl5Z8JV2x+Q8heWzsvMJFinrkoseYyl4aju15DFcc0D2LrohYHejAO
         SDeUpsBYWzXGct+Vai/0p5Aq2ejVzlpC479Vr5qINsuWYLXH6joCPYqZHI8dQSh+L2Qi
         K7gYe/SDgZltTMOplRglQ1mkrYv5NWFJl3kHmS6W52CZnGNBqS1Mz+5GDWxS0iglE3fQ
         6Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCUDuAVMVI/Q35e+DlkCAwoTOs4hRiX/WtGnTfiZ68CY7q6dCJMdgFo5DIkwmtnF4PnZEWkdlIgd/S4QOX2+PvAeUuGR
X-Gm-Message-State: AOJu0YyOYMrCes3k7oZgU8WSQqH0qFdcKPGh8kH2zaDIaRwIytKj9pWn
	qzaI2RICvLv7SZDbuTKvX4VCGS47TdqBCEmeaXhdkhRFio1jdFjZNaILX+B0hA==
X-Google-Smtp-Source: AGHT+IG/mO2zX6w/nhGHQ9iPPz8f+kIiHx6ka4l6BoesYRu+P37Fs580FgkZTJG8iwIS84D9OwUWXw==
X-Received: by 2002:a05:6a00:450e:b0:6e2:9bca:fdc4 with SMTP id cw14-20020a056a00450e00b006e29bcafdc4mr4640585pfb.21.1708268780315;
        Sun, 18 Feb 2024 07:06:20 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a30-20020aa78e9e000000b006e45fc20539sm598295pfr.123.2024.02.18.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:06:19 -0800 (PST)
Date: Sun, 18 Feb 2024 07:06:19 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
Message-ID: <202402180701.FA42F70BE2@keescook>
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>

On Sun, Feb 18, 2024 at 11:55:01AM +0100, Christophe Leroy wrote:
> set_memory_ro() can fail, leaving memory unprotected.
> 
> Check its return and take it into account as an error.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/filter.h | 5 +++--
>  kernel/bpf/core.c      | 4 +++-
>  kernel/bpf/verifier.c  | 4 +++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fee070b9826e..fc0994dc5c72 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -881,14 +881,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
>  
>  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
>  
> -static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> +static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
>  {
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  	if (!fp->jited) {
>  		set_vm_flush_reset_perms(fp);
> -		set_memory_ro((unsigned long)fp, fp->pages);
> +		return set_memory_ro((unsigned long)fp, fp->pages);
>  	}
>  #endif
> +	return 0;
>  }
>  
>  static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 71c459a51d9e..c49619ef55d0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2392,7 +2392,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  	}
>  
>  finalize:
> -	bpf_prog_lock_ro(fp);
> +	*err = bpf_prog_lock_ro(fp);
> +	if (*err)
> +		return fp;

Weird error path, but yes.

>  
>  	/* The tail call compatibility check can only be done at
>  	 * this late stage as we need to determine, if we deal
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c5d68a9d8acc..1f831a6b4bbc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19020,7 +19020,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	 * bpf_prog_load will add the kallsyms for the main program.
>  	 */
>  	for (i = 1; i < env->subprog_cnt; i++) {
> -		bpf_prog_lock_ro(func[i]);
> +		err = bpf_prog_lock_ro(func[i]);
> +		if (err)
> +			goto out_free;
>  		bpf_prog_kallsyms_add(func[i]);
>  	}

Just to double-check if memory permissions being correctly restored on
this error path, I walked back through it and see that it ultimately
lands on vfree(), which appears to just throw the entire mapping away,
so I think that's safe. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

