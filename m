Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4347FC96
	for <lists+bpf@lfdr.de>; Mon, 27 Dec 2021 13:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhL0MZE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Dec 2021 07:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhL0MZE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Dec 2021 07:25:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC7CC06173E
        for <bpf@vger.kernel.org>; Mon, 27 Dec 2021 04:25:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mj19so13297075pjb.3
        for <bpf@vger.kernel.org>; Mon, 27 Dec 2021 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=usu7q2DNsYxHWQbFasIXv9FWg5Bn+1VPbbUaO96KGwg=;
        b=a7hgVdKpuvVO4n7HLY7rAxI/sdAezaey3YtxyyA6HwJ40h7rC+EW2UruDQLK2lLmp1
         VAStGpat7M36EsHFydq3/p0SE1kuYccZ4eKu0GR++JSomiVH3ReRJVdNxm0tqO6nWda3
         lMHSGDlUzvwGw2FJFfJDJ95cUnP6O0Yz6ts4tKmfkJbtQb0s9HveNSYSJTDG51OiagP2
         V7O9rwF3kiYwgcGlAvHcUd5IttV369NPo/IjBJW0FTwT5uULp9wQrB/k/izLAvt7LOvn
         4xB0ksLb/XuXv11XJzDod8WGWm+wHI3SRxxWzFgKsHZ/Wh3p725OdKOf9q+NnLFEYOnx
         67rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=usu7q2DNsYxHWQbFasIXv9FWg5Bn+1VPbbUaO96KGwg=;
        b=iCWDT9WKt+GEqXo1uQR02SAlT84cJ623BiV7bSYXzKaHui2nGdBAhKJBa8GT7r0a1z
         IfpfDFp8aUc4ZO9Tjp2oIEtu2sStA3MFuM8qnponM8SPRhe/Si8pnCWHEx9JVQbIbenB
         Crxgw/GCkX7QJ5NlhIBceiyr09Ipjri7GudnM+0/Si8KR7bb/sebCs+r99Id/k1g+J3J
         bbe50KPvNjkqmPEU08chVK34sHsMCNuA/5NQjFnjO4jeT3TWTRm71ZiC9LsU2RO94+gc
         tZF/F3Q/HReoJyZ41BSTziQJITIzTz+wpqVlu0CqK8GlUG2ibjeqrHuiobfMEBGt2DsK
         OXyA==
X-Gm-Message-State: AOAM533PVBS+QmClVpq+ygdHzK3dgdkg3qnyx0zXfBf63X4Unr2597BU
        9VRnuuoorklPhcUVoq2l/fxynvnbVUGC7g==
X-Google-Smtp-Source: ABdhPJy7Q0N3gSyx62rDccD2NBL5GbCHveExztgfbEFJWeQb40P37OYqocSFgw+LrbD8x4pCn3zLFg==
X-Received: by 2002:a17:902:e5ce:b0:142:780:78db with SMTP id u14-20020a170902e5ce00b00142078078dbmr17280049plf.12.1640607903873;
        Mon, 27 Dec 2021 04:25:03 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id w7sm16636693pfw.133.2021.12.27.04.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 04:25:03 -0800 (PST)
Message-ID: <b572def1-cfdc-6ae3-3772-d92660170fda@gmail.com>
Date:   Mon, 27 Dec 2021 20:25:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next v2] libbpf: Add documentation for bpf_map batch
 operations
Content-Language: en-US
To:     grantseltzer <grantseltzer@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org
References: <20211225203717.35718-1-grantseltzer@gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <20211225203717.35718-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/12/26 4:37 AM, grantseltzer wrote:
> From: Grant Seltzer <grantseltzer@gmail.com>
> 
> This adds documentation for:
> 
> - bpf_map_delete_batch()
> - bpf_map_lookup_batch()
> - bpf_map_lookup_and_delete_batch()
> - bpf_map_update_batch()
> 
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/bpf.c |   4 +-
>  tools/lib/bpf/bpf.h | 112 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9b64eed2b003..25f3d6f85fe5 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -691,7 +691,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>  	return libbpf_err_errno(ret);
>  }
>  
> -int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
> +int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,

Maybe you should drop these const qualifier changes.

All batch operations use `bpf_map_batch_common`, which has the following signature:

static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
                                void *out_batch, void *keys, void *values,
                                __u32 *count,
                                const struct bpf_map_batch_opts *opts)

Adding these const qualifiers causes the following error:

bpf.c:698:15: error: passing argument 5 of ‘bpf_map_batch_common’ discards 
‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]

>  			 const struct bpf_map_batch_opts *opts)
>  {
>  	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
> @@ -715,7 +715,7 @@ int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
>  				    count, opts);
>  }
>  
> -int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
> +int bpf_map_update_batch(int fd, const void *keys, const void *values, __u32 *count,
>  			 const struct bpf_map_batch_opts *opts)
>  {
>  	return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 00619f64a040..01011747f127 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -254,20 +254,128 @@ struct bpf_map_batch_opts {
>  };
>  #define bpf_map_batch_opts__last_field flags
>  
> -LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
> +
> +/**
> + * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
> + * elements in a BPF map.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys pointer to an array of *count* keys
> + * @param count number of elements in the map to sequentially delete
> + * @param opts options for configuring the way the batch deletion works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
>  				    __u32 *count,
>  				    const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF map elements.
> + *
> + * The parameter *in_batch* is the address of the first element in the batch to read.
> + * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
> + * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to indicate
> + * that the batched lookup starts from the beginning of the map.
> + *
> + * The *keys* and *values* are output parameters which must point to memory large enough to
> + * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
> + * buffer must be of *key_size* * *count*. The *values* buffer must be of
> + * *value_size* * *count*.
> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * indicate that the batched lookup starts from the beginning of the map.
> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys pointer to an array large enough for *count* keys
> + * @param values pointer to an array large enough for *count* values
> + * @param count number of elements in the map to read in batch. If ENOENT is
> + * returned, count will be set as the number of elements that were read before
> + * running out of entries in the map
> + * @param opts options for configuring the way the batch lookup works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
>  LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
>  				    void *keys, void *values, __u32 *count,
>  				    const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_and_delete_batch()** allows for batch lookup and deletion
> + * of BPF map elements where each element is deleted after being retrieved.
> + *
> + * Note that *count* is an input and output parameter, where on output it
> + * represents how many elements were successfully deleted. Also note that if
> + * **EFAULT** is returned up to *count* elements may have been deleted without
> + * being returned via the *keys* and *values* output parameters. If **ENOENT**
> + * is returned then *count* will be set to the number of elements that were read
> + * before running out of entries in the map.
> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * get address of the first element in *out_batch*
> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys pointer to an array of *count* keys
> + * @param values pointer to an array large enough for *count* values
> + * @param count input and output parameter; on input it's the number of elements
> + * in the map to read and delete in batch; on output it represents number of elements
> + * that were successfully read and deleted
> + * If ENOENT is returned, count will be set as the number of elements that were
> + * read before running out of entries in the map
> + * @param opts options for configuring the way the batch lookup and delete works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
>  LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
>  					void *out_batch, void *keys,
>  					void *values, __u32 *count,
>  					const struct bpf_map_batch_opts *opts);
> -LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
> +
> +/**
> + * @brief **bpf_map_update_batch()** updates multiple elements in a map
> + * by specifying keys and their corresponding values.
> + *
> + * The *keys* and *values* parameters must point to memory large enough
> + * to hold *count* items based on the key and value size of the map.
> + *
> + * The *opts* parameter can be used to control how *bpf_map_update_batch()*
> + * should handle keys that either do or do not already exist in the map.
> + * In particular the *flags* parameter of *bpf_map_batch_opts* can be
> + * one of the following:
> + *
> + * Note that *count* is an input and output parameter, where on output it
> + * represents how many elements were successfully updated. Also note that if
> + * **EFAULT** then *count* should not be trusted to be correct.
> + *
> + * **BPF_ANY**
> + *     Create new elements or update existing.
> + *
> + * **BPF_NOEXIST**
> + *    Create new elements only if they do not exist.
> + *
> + * **BPF_EXIST**
> + *    Update existing elements.
> + *
> + * **BPF_F_LOCK**
> + *    Update spin_lock-ed map elements. This must be
> + *    specified if the map value contains a spinlock.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys pointer to an array of *count* keys
> + * @param values pointer to an array of *count* values
> + * @param count input and output parameter; on input it's the number of elements
> + * in the map to update in batch; on output it represents the number of elements
> + * that were successfully updated. If EFAULT is returned, *count* should not
> + * be trusted to be correct.
> + * @param opts options for configuring the way the batch update works
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values,
>  				    __u32 *count,
>  				    const struct bpf_map_batch_opts *opts);
>  
> +
>  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
>  
