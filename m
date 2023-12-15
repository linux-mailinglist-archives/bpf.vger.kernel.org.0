Return-Path: <bpf+bounces-17969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9BB8142EF
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 08:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5227B2273F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AF214F93;
	Fri, 15 Dec 2023 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YUPmbRCQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB11094A
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df53e635-9ba2-4dac-8aad-4aa491e61f4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702626405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4rp9Ec3dWdwX0U+BIHBC1Rm+VbFXOEJZSUQO7TBIko=;
	b=YUPmbRCQCJZGt6YVh//jlaKkH55vX6MP74/LYS+BQ88BRMMQJcX6NWqhZMAADoP67Wz+5w
	JCZ0epRSya7G/+KbIko4QIkOQ986g11uxg/xMp0g5VIm+NLX0yimY3coHYtn8iwhWMjLb8
	j7jktM+z7A+RX+BB6RHrCtuexlZ4Y3k=
Date: Thu, 14 Dec 2023 23:46:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 14/14] bpf: pass btf object id in
 bpf_map_info.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-15-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-15-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
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
> index c881befa35f5..26103d8a4374 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3350,5 +3350,6 @@ struct bpf_struct_ops_##_name {					\
>   int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   			     struct btf *btf,
>   			     struct bpf_verifier_log *log);
> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);

This needs to be in the CONFIG_BPF_JIT guard also.

>   
>   #endif /* _LINUX_BPF_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 5c3838a97554..716c6b28764d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6534,7 +6534,7 @@ struct bpf_map_info {
>   	__u32 btf_id;
>   	__u32 btf_key_type_id;
>   	__u32 btf_value_type_id;
> -	__u32 :32;	/* alignment pad */
> +	__u32 btf_obj_id;

may be "btf_vmlinux_id" to make it clear it is a kernel btf and should be used 
with map_info->btf_vmlinux_value_type_id.

>   	__u64 map_extra;
>   } __attribute__((aligned(8)));
>   
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index fd26716fa0f9..51c0de75aa85 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -979,3 +979,10 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	kfree(link);
>   	return err;
>   }
> +
> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
> +
> +	info->btf_obj_id = btf_obj_id(st_map->btf);
> +}
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4aced7e58904..3cab56cd02ff 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4715,6 +4715,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
>   		info.btf_value_type_id = map->btf_value_type_id;
>   	}
>   	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
> +	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
> +		bpf_map_struct_ops_info_fill(&info, map);

This patch should be moved earlier in the set instead of after the selftest 
patch 13. May be after patch 5 where st_map->btf is added.

and where is the test for this?

>   
>   	if (bpf_map_is_offloaded(map)) {
>   		err = bpf_map_offload_info_fill(&info, map);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 5c3838a97554..716c6b28764d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6534,7 +6534,7 @@ struct bpf_map_info {
>   	__u32 btf_id;
>   	__u32 btf_key_type_id;
>   	__u32 btf_value_type_id;
> -	__u32 :32;	/* alignment pad */
> +	__u32 btf_obj_id;
>   	__u64 map_extra;
>   } __attribute__((aligned(8)));
>   


