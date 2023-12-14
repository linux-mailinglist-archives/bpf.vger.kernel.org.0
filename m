Return-Path: <bpf+bounces-17788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F78127E7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176DA282568
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAFAD260;
	Thu, 14 Dec 2023 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWRjk8kF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A83A0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:22:26 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-202ffc46e15so986940fac.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702534945; x=1703139745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTvjIkkLn8sdDCBiLJdie7vXKPb4DQKt7YJLWli0kQ4=;
        b=FWRjk8kFI9TkOJ57ogdBh1h+s/p1KxaiLiXwfhHPZLIpsT/+E17nsSPm+3hwRD4kcK
         fAaywukFY5Anno+URdpCIXd9FL0C/H98toaD52D+eWJ/JoY32SqCw++UNdl7iWcppBtv
         PrY3a9RkOVkGlT3CTOBKfP1eEFtfldnvxNESRnxDWGLlZKj365Ukw54b5C8/lsxRyyBx
         LtY8ATn1V6FvPdqClwGnv7wig4knO39u9jDwPOnjDJcMhSsaEae7nHQM2jkS2psOBy8p
         wBAe+CW2pJHnmLZqD74Si8c/RDPz+E12Vcs8MYMfcvD1H2Lf9vHBDT2RUKOaWqRrSqec
         otyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702534945; x=1703139745;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTvjIkkLn8sdDCBiLJdie7vXKPb4DQKt7YJLWli0kQ4=;
        b=CBHrA7AOMt04nVwPwIuFyyzLNTe30XELV9bu8AYOkjXjeamdyEbcUXS1+00oaHlAVq
         NpkOF10XtRA3BL3MTgOnb/0k9XFa/pbAhs2yw9RTwVTh43HCb1fRNuinQh4j/nutpUen
         UOd+ymz6Dt1VAXYIjt3qYvRzgXKyJvad3joXSuDVjUxY1Nvw23/s4TQfPgsM0JOl2gHq
         twSqIWgZwnxgSAQEJdnm6MGi2UdC+SfJ91wKRqBP5L7/4+uwTTOFqhWxasRASwP5OhVK
         RH4UVIL1SMFFmrarUWa/Pg/fuC5ygkh7zm+vNRQNOxGnhPy5zvevGPk8oei4YI8tVkw6
         N9dQ==
X-Gm-Message-State: AOJu0Yy83PmKGkHtkK+MjNWnl4WLzHsgiMvCO9pdMPdrzfNspN5q6WZz
	YGrZKNJNmtXJO20BL7FSKEQ=
X-Google-Smtp-Source: AGHT+IFe13xbEgNzO8DnxtDdJqFf37e9yqEK9jtHluJgENQr26iEIKroLSvPbmPayU5JYdpNRQJkAA==
X-Received: by 2002:a05:6870:b69d:b0:1fa:ecf1:8b67 with SMTP id cy29-20020a056870b69d00b001faecf18b67mr6380716oab.59.1702534944548;
        Wed, 13 Dec 2023 22:22:24 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id h4-20020a655184000000b0059d6f5196fasm9362841pgq.78.2023.12.13.22.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:22:23 -0800 (PST)
Date: Wed, 13 Dec 2023 22:22:22 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, 
 bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Song Liu <song@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 xingwei lee <xrivendell7@gmail.com>, 
 houtao1@huawei.com
Message-ID: <657a9f1ea1ff4_48672208f0@john.notmuch>
In-Reply-To: <20231214043010.3458072-2-houtao@huaweicloud.com>
References: <20231214043010.3458072-1-houtao@huaweicloud.com>
 <20231214043010.3458072-2-houtao@huaweicloud.com>
Subject: RE: [PATCH bpf-next v3 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> callbacks.
> 
> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
> rcu-read-lock because array->ptrs must still be allocated. For
> bpf_fd_htab_map_update_elem(), htab_map_update_elem() only requires
> rcu-read-lock to be held to avoid the WARN_ON_ONCE(), so only use
> rcu_read_lock() during the invocation of htab_map_update_elem().
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 6 ++++++
>  kernel/bpf/syscall.c | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5b9146fa825f..ec3bdcc6a3cf 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2523,7 +2523,13 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
>  	if (IS_ERR(ptr))
>  		return PTR_ERR(ptr);
>  
> +	/* The htab bucket lock is always held during update operations in fd
> +	 * htab map, and the following rcu_read_lock() is only used to avoid
> +	 * the WARN_ON_ONCE in htab_map_update_elem().
> +	 */
> +	rcu_read_lock();
>  	ret = htab_map_update_elem(map, key, &ptr, map_flags);
> +	rcu_read_unlock();

Did we consider dropping the WARN_ON_ONCE in htab_map_update_elem()? It
looks like there are two ways to get to htab_map_update_elem() either
through a syscall and the path here (bpf_fd_htab_map_update_elem) or
through a BPF program calling, bpf_update_elem()? In the BPF_CALL
case bpf_map_update_elem() already has,

   WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held())

The htab_map_update_elem() has an additional check for
rcu_read_lock_trace_held(), but not sure where this is coming from
at the moment. Can that be added to the BPF caller side if needed?

Did I miss some caller path?

 

>  	if (ret)
>  		map->ops->map_fd_put_ptr(map, ptr, false);
>  
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d63c1ed42412..3fcf7741146a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -184,15 +184,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>  		err = bpf_percpu_cgroup_storage_update(map, key, value,
>  						       flags);
>  	} else if (IS_FD_ARRAY(map)) {
> -		rcu_read_lock();
>  		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
>  						   flags);
> -		rcu_read_unlock();
>  	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
> -		rcu_read_lock();
>  		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
>  						  flags);
> -		rcu_read_unlock();
>  	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
>  		/* rcu_read_lock() is not needed */
>  		err = bpf_fd_reuseport_array_update_elem(map, key, value,

Any reason to leave the last rcu_read_lock() on the 'else{}' case? If
the rule is we have a reference to the map through the file fdget()? And
any concurrent runners need some locking, xchg, to handle the update a
rcu_read_lock() wont help there.

I didn't audit all the update flows tonight though.


> -- 
> 2.29.2
> 
> 



