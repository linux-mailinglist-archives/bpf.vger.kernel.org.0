Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4A6F2174
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 01:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347062AbjD1X6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 19:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347047AbjD1X6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 19:58:44 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA426A2
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 16:58:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51b67183546so196272a12.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682726322; x=1685318322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfYkrAoukEhOX0SrNXwfENrtbAo80Vbu2Y1/P7a0d2U=;
        b=DpPE5qZ9aIc4IstKx9+hbptJ573gPBQDawiaMolKkFtTnoZ5o/LHkQgacL7K7aA3vO
         LwxbpyQggq/Kqf32bYrdopoZ5MmYkelAErxkIc+udcYnl8njc7ssWKfK96jNGatEiF+J
         tHsq4/rixAVcDSrJLxxF+S1tqbv4sKRNvuXd+fvNgHTRMAedfMr9GSfAdRm+NU45OkNJ
         V9HTeiY1qXG8GbJJ7VfqKaLldpfmB+jLRiwNubLzwSuDgVNcD/IQswFNUnjtsbvUIeVu
         e9jyesJAIJ4xiBAjbSACEWlhRBUIeOHmI3nNBAmTjnpCALMNH2Fyzr80qgpBAxzjMsM5
         vVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682726322; x=1685318322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfYkrAoukEhOX0SrNXwfENrtbAo80Vbu2Y1/P7a0d2U=;
        b=I/r2KmMVyv9QPPTDq1kRbgakzC/nLhsGVi99ujAJvAWr1DvWCXgqlPHbGPL+Lk3piE
         22KR3eBxymAbsRd9Az+ZalOAP+wnLO58ys/p5n7moIR3JgPHvcINFqneptfmpYVmlTRs
         rktqHvh4QUyUuG2eHp19pabnMAEb/25VEHrLoNyjPveXWTPY+K6pTBWMURCB5kqzxcJR
         bQZ1WpGX+tSiB7jFrb8Ah8iQ2wYDlkjXjoa4pYpp0o1txk9x0rCMj7YpMZkkFQ/ZSS1P
         OD4B7s3ApqHlzNPs+ZWjgDR7//1zHcI2EmRUDPzD9ZCxksPld9Gv8WiQqI4VJqSnc1ZC
         +cfg==
X-Gm-Message-State: AC+VfDyRMGMqB+s2EnmLs3iFXk8iLOxdkEUktC5W8PSRynAFSJjWPlK3
        /rOHSOg4o73YUU5k4c9U2Z/rHWs=
X-Google-Smtp-Source: ACHHUZ5knRVz+TuRIiUuXkAIIdC7l10b4uFPirDG5I23XAlukftUF/Uh5befRnxWwzXk/iWV9YY7L8M=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6bc1:0:b0:503:77c9:45aa with SMTP id
 g184-20020a636bc1000000b0050377c945aamr1725510pgc.9.1682726322501; Fri, 28
 Apr 2023 16:58:42 -0700 (PDT)
Date:   Fri, 28 Apr 2023 16:58:40 -0700
In-Reply-To: <20230428222754.183432-2-inwardvessel@gmail.com>
Mime-Version: 1.0
References: <20230428222754.183432-1-inwardvessel@gmail.com> <20230428222754.183432-2-inwardvessel@gmail.com>
Message-ID: <ZExdsHwc6Gy716am@google.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add capability for resizing datasec maps
From:   Stanislav Fomichev <sdf@google.com>
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/28, JP Kobryn wrote:
> This patch updates bpf_map__set_value_size() so that if the given map is a
> datasec, it will attempt to resize it. If the following criteria is met,
> the resizing can be performed:
>  - BTF info is present
>  - the map is a datasec
>  - the datasec contains a single variable
>  - the single variable is an array
> 
> The new map_datasec_resize() function is used to perform the resizing
> of the associated memory mapped region and adjust BTF so that the original
> array variable points to a new BTF array that is sized to cover the
> requested size. The new array size will be rounded up to a multiple of
> the element size.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 138 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1cbacf9e71f3..991649cacc10 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9412,12 +9412,150 @@ __u32 bpf_map__value_size(const struct bpf_map *map)
>  	return map->def.value_size;
>  }
>  
> +static bool map_is_datasec(struct bpf_map *map)
> +{
> +	struct btf *btf;
> +	struct btf_type *map_type;
> +
> +	btf = bpf_object__btf(map->obj);
> +	if (!btf)
> +		return false;
> +
> +	map_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
> +
> +	return btf_is_datasec(map_type);
> +}
> +
> +static int map_datasec_resize(struct bpf_map *map, __u32 size)
> +{
> +	int err;
> +	struct btf *btf;
> +	struct btf_type *datasec_type, *var_type, *resolved_type, *array_element_type;
> +	struct btf_var_secinfo *var;
> +	struct btf_array *array;
> +	__u32 resolved_id, new_array_id;
> +	__u32 rounded_sz;
> +	__u32 nr_elements;
> +	__u32 old_value_sz = map->def.value_size;
> +	size_t old_mmap_sz, new_mmap_sz;
> +
> +	/* btf is required and datasec map must be memory mapped */
> +	btf = bpf_object__btf(map->obj);
> +	if (!btf) {
> +		pr_warn("cannot resize datasec map '%s' while btf info is not present\n",
> +				bpf_map__name(map));
> +
> +		return -EINVAL;
> +	}
> +
> +	datasec_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
> +	if (!btf_is_datasec(datasec_type)) {
> +		pr_warn("attempted to resize datasec map '%s' but map is not a datasec\n",
> +				bpf_map__name(map));
> +
> +		return -EINVAL;
> +	}
> +
> +	if (!map->mmaped) {
> +		pr_warn("cannot resize datasec map '%s' while map is unexpectedly not memory mapped\n",
> +				bpf_map__name(map));
> +
> +		return -EINVAL;
> +	}
> +
> +	/* datasec must only have a single variable */
> +	if (btf_vlen(datasec_type) != 1) {
> +		pr_warn("cannot resize datasec map '%s' that does not consist of a single var\n",
> +				bpf_map__name(map));
> +
> +		return -EINVAL;
> +	}
> +
> +	/* the single variable has to be an array */
> +	var = btf_var_secinfos(datasec_type);
> +	resolved_id = btf__resolve_type(btf, var->type);
> +	resolved_type = btf_type_by_id(btf, resolved_id);
> +	if (!btf_is_array(resolved_type)) {
> +		pr_warn("cannot resize datasec map '%s' whose single var is not an array\n",
> +				bpf_map__name(map));
> +
> +		return -EINVAL;
> +	}
> +
> +	/* create a new array based on the existing array but with new length,
> +	 * rounding up the requested size for alignment
> +	 */
> +	array = btf_array(resolved_type);
> +	array_element_type = btf_type_by_id(btf, array->type);
> +	rounded_sz = roundup(size, array_element_type->size);
> +	nr_elements = rounded_sz / array_element_type->size;
> +	new_array_id = btf__add_array(btf, array->index_type, array->type,
> +			nr_elements);
> +	if (new_array_id < 0) {
> +		pr_warn("failed to resize datasec map '%s' due to failure in creating new array\n",
> +				bpf_map__name(map));
> +		err = new_array_id;
> +
> +		goto fail_array;
> +	}
> +
> +	/* adding a new btf type invalidates existing pointers to btf objects.
> +	 * refresh pointers before proceeding
> +	 */
> +	datasec_type = btf_type_by_id(btf, map->btf_value_type_id);
> +	var = btf_var_secinfos(datasec_type);
> +	var_type = btf_type_by_id(btf, var->type);
> +
> +	/* remap the associated memory */
> +	old_value_sz = map->def.value_size;
> +	old_mmap_sz = bpf_map_mmap_sz(map);
> +	map->def.value_size = rounded_sz;
> +	new_mmap_sz = bpf_map_mmap_sz(map);
> +
> +	if (munmap(map->mmaped, old_mmap_sz)) {
> +		err = -errno;
> +		pr_warn("failed to resize datasec map '%s' due to failure in munmap(), err:%d\n",
> +			 bpf_map__name(map), err);
> +
> +		goto fail_mmap;
> +	}
> +
> +	map->mmaped = mmap(NULL, new_mmap_sz, PROT_READ | PROT_WRITE,
> +		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);

I'm probably missing something, but how does it work? This just mmaps
new memory which the user-space side will see. What about the BPF side?

I'm also assuming (maybe incorrectly?) that if the map is mmaped, it's
already created in the kernel, so what's the point of the resizing?
