Return-Path: <bpf+bounces-33913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD36927EC2
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 23:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9651C21FFC
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3642144315;
	Thu,  4 Jul 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbGLiGjP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12856A039;
	Thu,  4 Jul 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720130123; cv=none; b=MTwpv4aYh+bMl+N97QphmoAqMkNqhoML02uETd299tv8WwmYV3ic+9IdoIYg9O115hNtcYE9TovcrUKXq1ezhDiz8fUdA3VT4moJH8IXvtYXzRM0JZxejQm4/ppGHQQ2dpfW2TH7PXgWHcCTXOrAe3f/7JEl5cx85yhZ6TfEqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720130123; c=relaxed/simple;
	bh=UMtKACPAKb5kPODKBAoPlmRU2/hW+T7OmyYCvNE5WO4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/RK7jktDcv4RaRYqvwGxMuifM3CyUNmXSEDR0nfX42bPx0TnDASCdx24Q36zDEjRnQkc3xFkgLGT76fbmo0ZCHXDuT+u+YA+y9v9dSkgl1y6M/al6jE6nykwAX2WZUiKvaVFEnMlb19e4N5JcpSgjdBQDXffxDIKmWTHU7ipmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbGLiGjP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e99060b41so1029507e87.2;
        Thu, 04 Jul 2024 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720130120; x=1720734920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0Mucu4azB4762rQz2sUA0weJJHmfoyRkDcYhqdYRss=;
        b=QbGLiGjPS++mampRZyGkgRNGlMALaX+BIFZbWfNad/OjGku5C58I/8VFgcAfRycG1Y
         Lqie6mtzmkT5vOmKzyD0gRG8EN4SUe/GC+H3GNpgxxhNYZONmrkjZI4Mw2nwPIFUb3Rf
         Vc1R5T/D/w68jQNG2IH453fqSjU/ieund2eJW29eZ1tZr/z6DBZgim3LFs9kr2JwDwcc
         pcc7NzAgbVcxqkXszUT6DL3aiuetFvn5dcp5PG+9bwWksowdt6LN2mmt+afKT8n0MI0K
         o8y191xuLTiuoq/xTWL1Ihojknpi/qwnkEOsxlm23+bHu5p2dFzC3HNR2zy9ed8U7Dnw
         WY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720130120; x=1720734920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Mucu4azB4762rQz2sUA0weJJHmfoyRkDcYhqdYRss=;
        b=cc/C+RJEwgr7ACCKgpIlRlnOQKJC/55uM4LMmemVdmi/wpl7MIo4Rfe9ZxDVBxDAX5
         /0VO93vhcAFL59EoLo1R5B7nJqYked8E2+WepPFZ8VjmEsDg9LapcEOxg/MiDwuu2XMO
         M7eW3X5YhUKzLWQ3XoAK67hU1b1TCJYgOH8gM0joJqnZwF6X4XA3O51GxUtdZzHT7Q5I
         ZOdbH4QSYeOLk5aohgXZB4USOAmPrOfTgd6qcAWSmsO3fFPSzq/Jvefqn7MVztdD/Kdy
         mhBVIG3+ypnmJw/mA8lofJ48o22mfFZntx7XniQ8V2HkxZPwdmrtMISWsNMG22f1La3R
         OePg==
X-Forwarded-Encrypted: i=1; AJvYcCWQcU8GGGCqnjkky3wjpIwguUEGMXNCqc31dfmZI29ixstXEpNU0/tqOH+XBp+PvMfrLGNdFSwZwRaSRaEjt5SGIr8Nn7LwlVPUI7uDDUIdxgIhGZ2dXgo3bcasONUAdSL6OzCdVIkuwjwEzdFfBm2C6f/bb0hhwWOYiYmT7g4XS5Rk
X-Gm-Message-State: AOJu0Yz3aNnW4Cyr0PgBVsB3gIqOkSrg7DncxFzyzvGezPbdjGsfLe8k
	DiM5MJHSqcg7wohfna6pybUuci1TXQwNllp0FifAye1dAht4Zj4y
X-Google-Smtp-Source: AGHT+IF0OzApOl8VduWwGHxJNAkdy4vso6GRZTazOFmoHK9BpHFnD+7UypBCbNa1hxmdSIUi2UPTkA==
X-Received: by 2002:a05:6512:3ec:b0:52e:9942:e8c7 with SMTP id 2adb3069b0e04-52ea0706ba3mr1493155e87.69.1720130119525;
        Thu, 04 Jul 2024 14:55:19 -0700 (PDT)
Received: from krava (net-93-147-243-58.cust.vodafonedsl.it. [93.147.243.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58e2f7c0e00sm1410611a12.6.2024.07.04.14.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 14:55:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jul 2024 23:55:16 +0200
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: remove unnecessary loop in
 task_file_seq_get_next()
Message-ID: <ZocaRENGH-HFLo4p@krava>
References: <ZoWJF51D4zWb6f5t@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoWJF51D4zWb6f5t@stanley.mountain>

On Thu, Jul 04, 2024 at 10:19:19AM -0500, Dan Carpenter wrote:
> After commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") this
> loop always iterates exactly one time.  Delete the for statement and pull
> the code in a tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/task_iter.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index ec4e97c61eef..02aa9db8d796 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -261,6 +261,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>  	u32 saved_tid = info->tid;
>  	struct task_struct *curr_task;
>  	unsigned int curr_fd = info->fd;
> +	struct file *f;
>  
>  	/* If this function returns a non-NULL file object,
>  	 * it held a reference to the task/file.
> @@ -286,12 +287,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>  	}
>  
>  	rcu_read_lock();
> -	for (;; curr_fd++) {
> -		struct file *f;
> -		f = task_lookup_next_fdget_rcu(curr_task, &curr_fd);
> -		if (!f)
> -			break;
> -
> +	f = task_lookup_next_fdget_rcu(curr_task, &curr_fd);
> +	if (f) {
>  		/* set info->fd */
>  		info->fd = curr_fd;
>  		rcu_read_unlock();
> -- 
> 2.43.0
> 

