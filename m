Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE969749C
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 03:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBOC6O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 21:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBOC6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 21:58:14 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86752749F
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:58:03 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id oo13-20020a17090b1c8d00b0022936a63a22so375046pjb.8
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrnnhttW8o5jppQu6CGekge3hogvq4Llv3K4cmrNAEk=;
        b=R8w+1GO9/fK3naU2BZC34B1qjEucjMXw+Mju6gGGNt2YEWNDvy1DWZH21y9ciRvZfu
         ZjgpsjRHB+NYjRspDGIOm/b0PQz1jjee/PwZ1/Db/uyMs2HVdpB9/WsYQj5It7XFj0QS
         rz5JdWFnZjsRfl955RjFMPtpyf4r8CZGvyH/Xp93cCLZpbp0s3fKngDXG1XWq+5l58te
         hYIXpuD6c2bwUwx/9AGrniaYxOkRDttzAxtNrjmZ0rwk6tYy2Wne7/LEut+BR+3wt49a
         qkgOF3lgNeZsY/UHhnHWfeaiQ+la9j9x/M8wTjZDGjPXoIfMwK0/0rjuHxdDInEaok/j
         LClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrnnhttW8o5jppQu6CGekge3hogvq4Llv3K4cmrNAEk=;
        b=pwpHmpPrSjZtyChe3hQ1eAYUg7o1I5qVG1rIqRzWaa1zGhA/65/gOhZIlHwyRORcAe
         j0TL1EGAnNsZJPYJ4Q+lWDuSsITCnGudTOfkbfTN1tx0RmZOuXj3Jgo+swIHm9GtGqoB
         oHtRpr3JYCSC4rgfMA1ITY1bvdUgNfXyupuEEjZc09oD/mJsYKPjpZWryKcCcLNjVvlC
         BC5V81tPbahFCyY0wtNUDr7ywRVfD9A6CD5hsp4iLHxlUZ5q3sDHts0aSQdaEJggm2zD
         WvrKJ1wYO7VjnWUU57CvSYhcniBiXyUYSqWZ48B0CtJbMQ2MgCj3l1u1elb8FEoqhkV4
         hYJA==
X-Gm-Message-State: AO0yUKV7KABP8rQpGS0w2oABaXl7HBWP8tXJgLNX/VM3xKJrNYFCBWv4
        U+POeylkyvR3hb7OhR36Lnnrd3Q=
X-Google-Smtp-Source: AK7set8rJxdvbVtgN1eiHXMhLl1rqBwe99RitYnBSMF21lnB7oomKd8UzcoMEvK/Imr217yiSkWbc/U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:2911:0:b0:4fb:a525:3eae with SMTP id
 bt17-20020a632911000000b004fba5253eaemr101798pgb.1.1676429883242; Tue, 14 Feb
 2023 18:58:03 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:58:02 -0800
In-Reply-To: <20230214221718.503964-5-kuifeng@meta.com>
Mime-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-5-kuifeng@meta.com>
Message-ID: <Y+xKOq4gW58IDMWE@google.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
From:   Stanislav Fomichev <sdf@google.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/14, Kui-Feng Lee wrote:
> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
> placeholder, but now it is constructing an authentic one by calling
> bpf_link_create() if the map has the BPF_F_LINK flag.

> You can flag a struct_ops map with BPF_F_LINK by calling
> bpf_map__set_map_flags().

> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 15 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 75ed95b7e455..1eff6a03ddd9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const  
> struct bpf_program *prog)
>   	return link;
>   }

> +struct bpf_link_struct_ops_map {
> +	struct bpf_link link;
> +	int map_fd;
> +};

Ah, ok, now you're adding bpf_link_struct_ops_map. I guess I'm now
confused why you haven't done it in the first patch :-/

And what are these fake bpf_links? Can you share more about it means?

> +
>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>   {
> +	struct bpf_link_struct_ops_map *st_link;
>   	__u32 zero = 0;

> -	if (bpf_map_delete_elem(link->fd, &zero))
> +	st_link = container_of(link, struct bpf_link_struct_ops_map, link);
> +
> +	if (st_link->map_fd < 0) {
> +		/* Fake bpf_link */
> +		if (bpf_map_delete_elem(link->fd, &zero))
> +			return -errno;
> +		return 0;
> +	}
> +
> +	if (bpf_map_delete_elem(st_link->map_fd, &zero))
> +		return -errno;
> +
> +	if (close(link->fd))
>   		return -errno;

>   	return 0;
>   }

> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> +/*
> + * Update the map with the prepared vdata.
> + */
> +static int bpf_map__update_vdata(const struct bpf_map *map)
>   {
>   	struct bpf_struct_ops *st_ops;
> -	struct bpf_link *link;
>   	__u32 i, zero = 0;
> -	int err;
> -
> -	if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> -		return libbpf_err_ptr(-EINVAL);
> -
> -	link = calloc(1, sizeof(*link));
> -	if (!link)
> -		return libbpf_err_ptr(-EINVAL);

>   	st_ops = map->st_ops;
>   	for (i = 0; i < btf_vlen(st_ops->type); i++) {
> @@ -11468,17 +11480,48 @@ struct bpf_link  
> *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   		*(unsigned long *)kern_data = prog_fd;
>   	}

> -	err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> +	return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> +}
> +
> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> +{
> +	struct bpf_link_struct_ops_map *link;
> +	int err, fd;
> +
> +	if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	link = calloc(1, sizeof(*link));
> +	if (!link)
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	err = bpf_map__update_vdata(map);
>   	if (err) {
>   		err = -errno;
>   		free(link);
>   		return libbpf_err_ptr(err);
>   	}

> -	link->detach = bpf_link__detach_struct_ops;
> -	link->fd = map->fd;
> +	link->link.detach = bpf_link__detach_struct_ops;

> -	return link;
> +	if (!(map->def.map_flags & BPF_F_LINK)) {
> +		/* Fake bpf_link */
> +		link->link.fd = map->fd;
> +		link->map_fd = -1;
> +		return &link->link;
> +	}
> +
> +	fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS_MAP, NULL);
> +	if (fd < 0) {
> +		err = -errno;
> +		free(link);
> +		return libbpf_err_ptr(err);
> +	}
> +
> +	link->link.fd = fd;
> +	link->map_fd = map->fd;
> +
> +	return &link->link;
>   }

>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct  
> perf_event_header *hdr,
> --
> 2.30.2

