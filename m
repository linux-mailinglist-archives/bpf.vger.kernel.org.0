Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0696B151D
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCHWdH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCHWdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 17:33:05 -0500
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [IPv6:2001:41d0:203:375::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320D196A8
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 14:33:00 -0800 (PST)
Message-ID: <1a6c3d38-b55c-bde8-3b99-e52a5ac028b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678314778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RB/Cc3Bm4bnm5R1V9f7gpJvvsl3w9tyqhJ4LKIWoRz4=;
        b=R07ylwJR69DAhWG+OM0vt5MhUod3tUXhR880mkQhenR5Pcj7bH0TdSC4+0diHHTF8Qdt5W
        MF9a1IRmf4xU/AKg3JJmkFRd0zppHE1YoG3gM3jJ+tVPvXjps9Igmm2SrqGTbIJ+8O4P1j
        ByXE8J/4ocE5uV95+0UphdBmsp0Z7BI=
Date:   Wed, 8 Mar 2023 14:32:55 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 6/8] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-7-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230308005050.255859-7-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
> Introduce bpf_link__update_struct_ops(), which will allow you to
> effortlessly transition the struct_ops map of any given bpf_link into
> an alternative.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   tools/lib/bpf/libbpf.c   | 36 ++++++++++++++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.h   |  1 +
>   tools/lib/bpf/libbpf.map |  1 +
>   3 files changed, 38 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f70b55c0f40e..0406d0e00e1f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11657,6 +11657,42 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   	return &link->link;
>   }
>   
> +/*
> + * Swap the back struct_ops of a link with a new struct_ops map.
> + */
> +int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
> +{
> +	struct bpf_link_struct_ops *st_ops_link;
> +	__u32 zero = 0;
> +	int err, fd;
> +
> +	if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> +		return -EINVAL;
> +
> +	st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
> +	/* Ensure the type of a link is correct */
> +	if (st_ops_link->map_fd < 0)
> +		return -EINVAL;
> +
> +	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
> +	if (err && errno != EBUSY) {
> +		err = -errno;
> +		free(link);

hmm... this looks wrong to free here.

> +		return err;
> +	}
> +
> +	fd = bpf_link_update(link->fd, map->fd, NULL);
> +	if (fd < 0) {
> +		err = -errno;
> +		free(link);

same here.

> +		return err;
> +	}
> +
> +	st_ops_link->map_fd = map->fd;
> +
> +	return 0;
> +}
> +
>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>   							  void *private_data);
>   
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index db4992a036f8..1615e55e2e79 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -719,6 +719,7 @@ bpf_program__attach_freplace(const struct bpf_program *prog,
>   struct bpf_map;
>   
>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
> +LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
>   
>   struct bpf_iter_attach_opts {
>   	size_t sz; /* size of this struct for forward/backward compatibility */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 50dde1f6521e..cc05be376257 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -387,6 +387,7 @@ LIBBPF_1.2.0 {
>   	global:
>   		bpf_btf_get_info_by_fd;
>   		bpf_link_get_info_by_fd;
> +		bpf_link__update_map;
>   		bpf_map_get_info_by_fd;
>   		bpf_prog_get_info_by_fd;
>   } LIBBPF_1.1.0;

