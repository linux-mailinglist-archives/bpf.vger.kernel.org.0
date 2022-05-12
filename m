Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A335952556B
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357931AbiELTMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357915AbiELTMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 15:12:15 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6240274A3B
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 12:12:14 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1npEEO-000GP3-Sh; Thu, 12 May 2022 21:12:12 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1npEEO-000Pqy-O9; Thu, 12 May 2022 21:12:12 +0200
Subject: Re: [PATCH bpf-next 1/2] libbpf: add safer high-level wrappers for
 map operations
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com
References: <20220511231448.571909-1-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cb4f508b-fdcf-aff6-3e94-db387791c8ff@iogearbox.net>
Date:   Thu, 12 May 2022 21:12:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220511231448.571909-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26539/Thu May 12 10:04:41 2022)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/12/22 1:14 AM, Andrii Nakryiko wrote:
> Add high-level API wrappers for most common and typical BPF map
> operations that works directly on instances of struct bpf_map * (so you
> don't have to call bpf_map__fd()) and validate key/value size
> expectations.
> 
> These helpers require users to specify key (and value, where
> appropriate) sizes when performing lookup/update/delete/etc. This forces
> user to actually think and validate (for themselves) those. This is
> a good thing as user is expected by kernel to implicitly provide correct
> key/value buffer sizes and kernel will just read/write necessary amount
> of data. If it so happens that user doesn't set up buffers correctly
> (which bit people for per-CPU maps especially) kernel either randomly
> overwrites stack data or return -EFAULT, depending on user's luck and
> circumstances. These high-level APIs are meant to prevent such
> unpleasant and hard to debug bugs.
> 
> This patch also adds bpf_map_delete_elem_flags() low-level API and
> requires passing flags to bpf_map__delete_elem() API for consistency
> across all similar APIs, even though currently kernel doesn't expect any
> extra flags for BPF_MAP_DELETE_ELEM operation.
> 
> List of map operations that get these high-level APIs:
>    - bpf_map_lookup_elem;
>    - bpf_map_update_elem;
>    - bpf_map_delete_elem;
>    - bpf_map_lookup_and_delete_elem;
>    - bpf_map_get_next_key.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[...]

(Looks like the set needs a rebase, just small comment below.)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4867a930628b..0ee3943aeaeb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9949,6 +9949,96 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset)
>   	return libbpf_err_ptr(-ENOTSUP);
>   }
>   
> +static int validate_map_op(const struct bpf_map *map, size_t key_sz,
> +			   size_t value_sz, bool check_value_sz)
> +{
> +	if (map->fd <= 0)
> +		return -ENOENT;
> +	if (map->def.key_size != key_sz)
> +		return -EINVAL;
> +
> +	if (!check_value_sz)
> +		return 0;
> +
> +	switch (map->def.type) {
> +	case BPF_MAP_TYPE_PERCPU_ARRAY:
> +	case BPF_MAP_TYPE_PERCPU_HASH:
> +	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
> +		if (value_sz != libbpf_num_possible_cpus() * roundup(map->def.value_size, 8))
> +			return -EINVAL;
> +		break;

I think this is fine, imho. My initial reaction would be that we should let
kernel handle errors and not have some kind of additional gate in libbpf that
would later on make it hard to debug/correlate where errors are coming from,
but this one here is imho valid given we've seen hard to debug corruptions
in the past, e.g. f3515b5d0b71 ("bpf: provide a generic macro for percpu values
for selftests"), where otherwise no error is thrown but just corruption. Maybe
the above grants a pr_warn() in addition to the -EINVAL. Other than that I
think we should be very selective in terms of what we add into this here to
avoid the mentioned err layers. Given it's user choice what API to use, the
above is okay imho.

> +	default:
> +		if (map->def.value_size != value_sz)
> +			return -EINVAL;
> +		break;
> +	}
> +	return 0;
> +}
> +
> +int bpf_map__lookup_elem(const struct bpf_map *map,
> +			 const void *key, size_t key_sz,
> +			 void *value, size_t value_sz, __u64 flags)
> +{
> +	int err;
> +
> +	err = validate_map_op(map, key_sz, value_sz, true);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
> +}
> +
[...]
