Return-Path: <bpf+bounces-18223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B081781F
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1939A1F24CB8
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEB14FF77;
	Mon, 18 Dec 2023 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM2raQkk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A245A84E
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e266e8d39eso26510757b3.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 09:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702919126; x=1703523926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0Ycwx4ZDsHCTKhKkVD93B5AiyiliIaKPVUtqKtdHgA=;
        b=jM2raQkkZ8Q2L6LcqoebuRwf7p5IfKfmKNfGi5Kr4Flwh2iaiSkfJkbVoDBIYoTt7d
         dEDOx3SetHaPmBxM5Z9aMEjgdYXdZXvp7pTsMrVMveDHvnXRos3Ocv7MjuVv1Nd6ACc2
         DEhtYKQedl/QQGTuNTdSVoLrGQmVn2oU1auWaB/biy+jU8svzTqmf8EmT7tEf8vLoB0a
         x6m1xWQAqp8IzkULxLEAaS33V7ZEOhcy2D+ucuYAjr8veqtN1U10DMXldd2RbSY5VZuC
         0JKHkbKHAWl917IG7dwk9sWiNztyyVO9hxBZHngLIy2aQMdTD6v0Qy9uQAo7uT39q+VN
         qwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919126; x=1703523926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0Ycwx4ZDsHCTKhKkVD93B5AiyiliIaKPVUtqKtdHgA=;
        b=Avtfqszc7M4RGGi/w1bE1ZSvf3vJ/IV2iXzKnhBXmUZASoA1lp9qw3OOtYaPqXTb37
         b3ZV0T/KfRO7ilS/FNggX1lk/TsKk3DdP0vLwYn+Oly5oqKFWD4seIAzLHxbRRAwAhkw
         RDd3ty0MFBMWyIZ4krwsnyfpAD+xn5w6GF0l3twEDgpCNvcf9b/BSrHC3JTnSTxbtMo4
         rwES7BXzCut/y5TR65JmGPDH8BTRzujbSBzNluP4WCi9ZJsznukucqJyRwbip6tIucJm
         dbmY6JS7TBf3O0Uv6KaI9fBDUnUS7OyllDxNsUxNUH+hBnnEnyP1KX8a4vCk0jj6yBzR
         rapA==
X-Gm-Message-State: AOJu0Ywr4IrJXrKLyCoZKMXnCXogC+wRibloCrTfdtZVu1qzrvPSqxc5
	o6HVTkKjRicGx+ODeuDfOUw=
X-Google-Smtp-Source: AGHT+IGPphGKW8yM0fDnB4lrMwt1X1zN7y6hzavJ8RBSRC2p8V5toNcm7pWq/wa/wVbDQblblKACvg==
X-Received: by 2002:a0d:db50:0:b0:5e7:4f54:c9fe with SMTP id d77-20020a0ddb50000000b005e74f54c9femr541512ywe.94.1702919125392;
        Mon, 18 Dec 2023 09:05:25 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:aaf8:ac2b:d59b:f654? ([2600:1700:6cf8:1240:aaf8:ac2b:d59b:f654])
        by smtp.gmail.com with ESMTPSA id e66-20020a0dc245000000b005e40d124effsm3496578ywd.31.2023.12.18.09.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:05:25 -0800 (PST)
Message-ID: <510d1a0f-db8e-4b15-a68f-8c3f6e6bedc5@gmail.com>
Date: Mon, 18 Dec 2023 09:05:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v14 06/14] bpf: pass btf object id in
 bpf_map_info.
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
References: <20231217081132.1025020-1-thinker.li@gmail.com>
 <20231217081132.1025020-16-thinker.li@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231217081132.1025020-16-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry! Please skip this particular patch, which is a redundant of
another patch in the same subject. I sent this out accidentally.

On 12/17/23 00:11, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Include btf object id (btf_obj_id) in bpf_map_info so that tools (ex:
> bpftools struct_ops dump) know the correct btf from the kernel to look up
> type information of struct_ops types.
> 
> Since struct_ops types can be defined and registered in a module. The
> type information of a struct_ops type are defined in the btf of the
> module defining it.  The userspace tools need to know which btf is for
> the module defining a struct_ops type.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h            | 1 +
>   include/uapi/linux/bpf.h       | 2 +-
>   kernel/bpf/bpf_struct_ops.c    | 7 +++++++
>   kernel/bpf/syscall.c           | 2 ++
>   tools/include/uapi/linux/bpf.h | 2 +-
>   5 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 432f37c979ff..469d26d27e64 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1740,6 +1740,7 @@ struct bpf_dummy_ops {
>   int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   			    union bpf_attr __user *uattr);
>   #endif
> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
>   #else
>   static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
>   {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e0545201b55f..7ab00babcccc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6529,7 +6529,7 @@ struct bpf_map_info {
>   	__u32 btf_id;
>   	__u32 btf_key_type_id;
>   	__u32 btf_value_type_id;
> -	__u32 :32;	/* alignment pad */
> +	__u32 btf_vmlinux_id;
>   	__u64 map_extra;
>   } __attribute__((aligned(8)));
>   
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 2b0c402740cc..679bcdf763ef 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -947,3 +947,10 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	kfree(link);
>   	return err;
>   }
> +
> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
> +
> +	info->btf_vmlinux_id = btf_obj_id(st_map->btf);
> +}
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d63c1ed42412..54a97c269e7a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4726,6 +4726,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
>   		info.btf_value_type_id = map->btf_value_type_id;
>   	}
>   	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
> +	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
> +		bpf_map_struct_ops_info_fill(&info, map);
>   
>   	if (bpf_map_is_offloaded(map)) {
>   		err = bpf_map_offload_info_fill(&info, map);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index e0545201b55f..7ab00babcccc 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6529,7 +6529,7 @@ struct bpf_map_info {
>   	__u32 btf_id;
>   	__u32 btf_key_type_id;
>   	__u32 btf_value_type_id;
> -	__u32 :32;	/* alignment pad */
> +	__u32 btf_vmlinux_id;
>   	__u64 map_extra;
>   } __attribute__((aligned(8)));
>   

