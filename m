Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E26C3869
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 18:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCURix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCURir (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 13:38:47 -0400
Received: from out-19.mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7A5552D
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 10:38:00 -0700 (PDT)
Message-ID: <0c4dc26d-a2d9-bd65-b151-e3bf8bae0660@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679420206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4cFuHfpan97/2eRKpRtNHMInm3hDWxYMDNJid2Gxrk=;
        b=TvjWIT1NPFTZWhQTKO7ieWdrtNDIvvMOr7k/D/7T+t+8c/lWVa9jLlD3zJux+Je51LMvbP
        2qxZkOpTmDrf7U4S/RspnI83nX1cn0qxbDRXzJI1r4MOairdeTtYxSiAjcHIWTII7c+ef3
        7FD6QO20yTpYjoBx010wP+crrGr/Ck4=
Date:   Tue, 21 Mar 2023 10:36:40 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230320192410.1624645-1-kuifeng@meta.com>
 <20230320192410.1624645-5-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
In-Reply-To: <20230320192410.1624645-5-kuifeng@meta.com>
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

On 3/20/23 12:24 PM, Kui-Feng Lee wrote:
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
> @@ -11596,31 +11637,32 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
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
> +	if (err && err != -EBUSY) {
> +		free(link);
> +		return libbpf_err_ptr(err);
> +	}
>   
> -		if (!prog)
> -			continue;
> +	link->link.detach = bpf_link__detach_struct_ops;
>   
> -		prog_fd = bpf_program__fd(prog);
> -		kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
> -		*(unsigned long *)kern_data = prog_fd;
> +	if (!(map->def.map_flags & BPF_F_LINK)) {

hmm... This still does not look right. 'err' could be -EBUSY here and should not 
be treated as success for non BPF_F_LINK case. The above 'err && err != -EBUSY' 
check should also consider the BPF_F_LINK map_flags.

> +		/* w/o a real link */
> +		link->link.fd = map->fd;
> +		link->map_fd = -1;
> +		return &link->link;
>   	}
>   
> -	err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
> -	if (err) {
> -		err = -errno;
> +	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> +	if (fd < 0) {
>   		free(link);
> -		return libbpf_err_ptr(err);
> +		return libbpf_err_ptr(fd);
>   	}
>   
> -	link->detach = bpf_link__detach_struct_ops;
> -	link->fd = map->fd;
> +	link->link.fd = fd;
> +	link->map_fd = map->fd;
>   
> -	return link;
> +	return &link->link;
>   }

