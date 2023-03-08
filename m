Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1CF6B1466
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 22:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCHVoH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 16:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCHVnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 16:43:47 -0500
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6925E1A
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 13:43:04 -0800 (PST)
Message-ID: <1b416290-733b-0470-3217-6e477e574931@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678311755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNrsbffVFkNROQEbEU5vIsZtCP1cCEQsWyVHG+JZueY=;
        b=UePWori+fpMmoaTlv1WrcjFnUaPBmhLH7UREMXhPH+JpffnUl1v2xTZqiWCPiEf1A0Za2m
        GCtO+uR65XyK7TrFPMgImDEkJW4jM5QnNSXQF2rIHelGLi0Oup+jsbVSrXR6SrPk3+WzjA
        GacwUROBbdDcg1qdPKhORHIGiHCWYJg=
Date:   Wed, 8 Mar 2023 13:42:31 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-5-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230308005050.255859-5-kuifeng@meta.com>
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
> @@ -11566,22 +11591,34 @@ struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
>   	return link;
>   }
>   
> +struct bpf_link_struct_ops {
> +	struct bpf_link link;
> +	int map_fd;
> +};
> +
>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>   {
> +	struct bpf_link_struct_ops *st_link;
>   	__u32 zero = 0;
>   
> -	if (bpf_map_delete_elem(link->fd, &zero))
> -		return -errno;
> +	st_link = container_of(link, struct bpf_link_struct_ops, link);
>   
> -	return 0;
> +	if (st_link->map_fd < 0) {

map_fd < 0 should always be true?

> +		/* Fake bpf_link */
> +		if (bpf_map_delete_elem(link->fd, &zero))
> +			return -errno;
> +		return 0;
> +	}
> +
> +	/* Doesn't support detaching. */
> +	return -EOPNOTSUPP;
>   }
>   
>   struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   {
> -	struct bpf_struct_ops *st_ops;
> -	struct bpf_link *link;
> -	__u32 i, zero = 0;
> -	int err;
> +	struct bpf_link_struct_ops *link;
> +	__u32 zero = 0;
> +	int err, fd;
>   
>   	if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>   		return libbpf_err_ptr(-EINVAL);
> @@ -11590,31 +11627,34 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   	if (!link)
>   		return libbpf_err_ptr(-EINVAL);
>   
> -	st_ops = map->st_ops;
> -	for (i = 0; i < btf_vlen(st_ops->type); i++) {
> -		struct bpf_program *prog = st_ops->progs[i];
> -		void *kern_data;
> -		int prog_fd;
> +	/* kern_vdata should be prepared during the loading phase. */
> +	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
> +	if (err) {
> +		err = -errno;
> +		free(link);
> +		return libbpf_err_ptr(err);
> +	}
>   
> -		if (!prog)
> -			continue;
>   
> -		prog_fd = bpf_program__fd(prog);
> -		kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
> -		*(unsigned long *)kern_data = prog_fd;
> +	if (!(map->def.map_flags & BPF_F_LINK)) {
> +		/* Fake bpf_link */
> +		link->link.fd = map->fd;
> +		link->map_fd = -1;
> +		link->link.detach = bpf_link__detach_struct_ops;
> +		return &link->link;
>   	}
>   
> -	err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> -	if (err) {
> +	fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS, NULL);
> +	if (fd < 0) {
>   		err = -errno;
>   		free(link);
>   		return libbpf_err_ptr(err);
>   	}
>   
> -	link->detach = bpf_link__detach_struct_ops;
> -	link->fd = map->fd;
> +	link->link.fd = fd;
> +	link->map_fd = map->fd;

Does it need to set link->link.detach?

>   
> -	return link;
> +	return &link->link;
>   }
>   
>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,

