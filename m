Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8FF5ED214
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 02:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiI1AkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 20:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiI1AkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 20:40:08 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB89D5756
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 17:40:07 -0700 (PDT)
Message-ID: <d6f272a6-020e-6a46-d86a-72c2dcc15264@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664325605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiEULpHops/czqdLZFVnqJLrdEQZnkie6XLxheBJ198=;
        b=D19YDPfcRJI9x71PSIS5EM0teqHbriHMXGW6NTAnnZvwGlPLHNA4LKu9Tvq9Q9HQ2A2NVD
        ilFeYxFx94YOQsspSN0FgLLidJa9kER6QhV72Yp+VVfgK1cu5iTnZfyICQH9OL6YF5hFub
        E0mdmw/oBvgQixnRlSL3RgRoFNeybpc=
Date:   Tue, 27 Sep 2022 17:39:59 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] Ignore RDONLY_PROG for devmaps in libbpf to allow
 re-loading of pinned devmaps
Content-Language: en-US
To:     Pramukh Naduthota <pnaduthota@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf <bpf@vger.kernel.org>
References: <20220927182345.149171-1-pnaduthota@google.com>
 <20220927182345.149171-2-pnaduthota@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220927182345.149171-2-pnaduthota@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/22 11:23 AM, Pramukh Naduthota wrote:
> Ignore BPF_F_RDONLY_PROG when checking for compatibility for devmaps. The
> kernel adds the flag to all devmap creates, and this breaks pinning
> behavior, as libbpf will then check the actual vs user supplied flags and
> see this difference. Work around this by adding RDONLY_PROG to the
> users's flags when testing against the pinned map
> 
> Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF objects")
> Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
> ---
>   tools/lib/bpf/libbpf.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 50d41815f4..a3dae26d82 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4818,6 +4818,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>   	char msg[STRERR_BUFSIZE];
>   	__u32 map_info_len;
>   	int err;
> +	unsigned int effective_flags = map->def.map_flags;
>   
>   	map_info_len = sizeof(map_info);
>   
> @@ -4830,11 +4831,16 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>   		return false;
>   	}
>   
> +	/* The kernel adds RDONLY_PROG to devmaps */
> +	if (map->def.type == BPF_MAP_TYPE_DEVMAP ||
> +	    map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
> +		effective_flags |= BPF_F_RDONLY_PROG;

May be set BPF_F_RDONLY_PROG in effective_flags only when map->def.map_flags 
does not have both BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG set?  Just in case 
the devmap may support setting them during map creation in the future.

> +
>   	return (map_info.type == map->def.type &&
>   		map_info.key_size == map->def.key_size &&
>   		map_info.value_size == map->def.value_size &&
>   		map_info.max_entries == map->def.max_entries &&
> -		map_info.map_flags == map->def.map_flags &&
> +		map_info.map_flags == effective_flags &&
>   		map_info.map_extra == map->map_extra);
>   }
>   

