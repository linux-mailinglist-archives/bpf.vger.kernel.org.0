Return-Path: <bpf+bounces-53463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909ECA546B1
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E503AA579
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91E20ADC9;
	Thu,  6 Mar 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpLafwmc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA120A5CF;
	Thu,  6 Mar 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254144; cv=none; b=ikMTSnp2hLWrOFAzBz2D+PCYjqOUKfPd8xwcXonI1EBvqhhO7c/yN2IXToZqPY+r/xfynDXZR8cV/4aM9hP7Vl9/2FXH/kK0hzM43xYz8RwfsyPG9yHWZghzQMzcHEUP4YDV+k/iO2hy0Sw6QAlk6hm6qjYItP5eTZTPlwU3xZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254144; c=relaxed/simple;
	bh=qgAL/rqV2yuyE+RUXMmy4rkUVwXU7w6M3wrqaHA5JGE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAm+LUlVh0QunrpOC9jmoZzNpFlOpks29n3H0m1fTXKW7QBw5y0dQcp1jHhtWaw9Ohe2Enxtvkbx7c2OhPkGzMGZKJWrW7xPB0BoDaGqey8+GHGQJHCBe+8W71JCQCTwo4annKFUEyyQWq1M1qbVswO5zC0Nx7B9xEm9Rsvt1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpLafwmc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso89617666b.3;
        Thu, 06 Mar 2025 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741254141; x=1741858941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4lnHb9qdu1TBKioUS3a347jyWbtNj/owKNfUkwY+ok=;
        b=dpLafwmcZDoeOH4aeVFZP7XpTvV4vAty+lAGU3V6ymfkNGxXIt5nlrZ3AZ5lvQGZHH
         dGTBg5E/9zidptIgdU0vHIVwQaQ7oiOck1Mpypv4YFljZk7rsCzrXYacewGJtL2Bz+Qz
         MzQoQPHMHeW8UKAc0oEKJbom1gIHfZVCYDLU9O+zxpt4bpYnK3pNLiAClE4ArVeY7S8m
         JTzRA8n57S7i1m2Llj+PhWUtQ3l3o/mmreaRFcGSn1t2hUDfuEKd0Z8MtJw4ICM+Qhrx
         aPkzo65KCLA76DGS8GX1m8ksShNfkvdTktJVXUY3TA3gWEFofh3SOYSBsKdh8hdpAtra
         /DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254141; x=1741858941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4lnHb9qdu1TBKioUS3a347jyWbtNj/owKNfUkwY+ok=;
        b=ilXj377jdrweOErFUJ1y7YFuCg1KAzQsAgQnXShKi6xK1zeOfMwttAQBKRQsGktJPg
         UykfRVswJ75z43h7rDub/sQUc65LEvAedE30583lcpJy58BZyi0gk1+QCs6jaDYKNKEJ
         Vs5uV6bs4PzbDW4G+zrhhrXW+HPpGTxGu9OZax/dpW9rqJXy7+/HpEM5coVmBlsDNeon
         RJQwdACbMxbsR2xuQMAnIkfsjOc/vTVkfIY77413mJrhgec94Pz+JwMlwHjB20Lla+4U
         +ae2ZB/FQ/zDWrCiz40Uz43AMyI7H76IWiIQtMygW+KFdRO8SyKRb+Rc1o5QZ1Om3ZJx
         97ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVgyJDXS34Jt4o5isAj4jfjzttyjwsFPiZ/daGfkD+Nqy49S1klf/W75O4qZsAu9Iwh7Augkxza@vger.kernel.org, AJvYcCWUxfXGDqyx3qyPqD1IchnsuqvnDNeN7hGmNk2W6h3r4MSUz9eX+MU3p98xkGPrMIdl2ugNzL6ZiQiQ3te0@vger.kernel.org, AJvYcCXEzvTQOgPFc+a4mANJW3l7ASZFTDN2CBZmUy6KBBh1oCOjcBo9QO+Y/8p9pnqi5dMP/gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHlyGo0lavqqnEVP9fklOp2NWcK/u+HTwSseZGjBnZTgwiyjuQ
	N/amF4BDJyYl/dPtVjA63rucKIs/nlt30UhtitT+f/l8+CzU5Fht
X-Gm-Gg: ASbGncuiRWqIB1LPcGG8CDRbUIBKLDlxpTgmWGHS9J+wo5lBIH0K1mU+4jaIHocd4Sc
	y2IJObDAnFXAnpu8nTb/HiZsP4luVKUfe8jxm2tRfApIH6Fnl7deAnKlgjqhD/Y8kgAh9Bl3vba
	pMNSJvg+KvM135j/ktMYh0mVEcN7mL3YSinDV+IbgNs64wJ0A0AVv9DlSnowcyV0qyay5f8IQyp
	RUlScZhzPWcAhhw44Vcp/XsvFOh/zF01pdGgUmyKSzp6YzeBcFBuMubryyzAA6dRuGB/pXD/de1
	9QFDmmaoJeMFR0qTqTb6MmaN4Y1j1Qw=
X-Google-Smtp-Source: AGHT+IFrPcY0lrj9hG+4Y/pg0PftN6YiW/IgVjN3D/G0eNKrvex5TMsd21ZA9mYagzX3a+00QQ5ttg==
X-Received: by 2002:a17:907:7241:b0:ac1:791c:1526 with SMTP id a640c23a62f3a-ac20db00b0emr623854666b.56.1741254140487;
        Thu, 06 Mar 2025 01:42:20 -0800 (PST)
Received: from krava ([173.38.220.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239481685sm67119666b.58.2025.03.06.01.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:42:19 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 6 Mar 2025 10:42:17 +0100
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Sasha Levin <sashal@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] lib/buildid: Handle memfd_secret() files in
 build_id_parse()
Message-ID: <Z8lt-X7yyhjKMTR7@krava>
References: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>

On Thu, Mar 06, 2025 at 01:06:58PM +0800, Chen Linxuan wrote:
> Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> Handle memfd_secret() files in build_id_parse()") to address an issue
> where accessing secret memfd contents through build_id_parse() would
> trigger faults.
> 
> Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> 
> This repro will cause BUG: unable to handle kernel paging request in
> build_id_parse in 5.15/6.1/6.6.

hi,
so this patch is meant for one of 5.15/6.1/6.6?

if so you need to send it separately and add that to the subject,
please check Documentation/process/stable-kernel-rules.rst

and you can check other stable kernel patches on the mailing list
like [1][2]

thanks,
jirka


[1] https://lore.kernel.org/bpf/20241206153403.273068-2-daniel@iogearbox.net/
[2] https://lore.kernel.org/bpf/20241104175256.2327164-3-jolsa@kernel.org/

> 
> Some other discussions can be found in [1].
> 
>   [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel.org/T/#u
> 
> Cc: stable@vger.kernel.org
> Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> ---
>  lib/buildid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 9fc46366597e..b78d119ed1f7 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  	if (!vma->vm_file)
>  		return -EINVAL;
>  
> +#ifdef CONFIG_SECRETMEM
> +	/* reject secretmem folios created with memfd_secret() */
> +	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
> +		return -EFAULT;
> +#endif
> +
>  	page = find_get_page(vma->vm_file->f_mapping, 0);
>  	if (!page)
>  		return -EFAULT;	/* page not mapped */
> -- 
> 2.48.1
> 

