Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC46F33A2
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjEAQug (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjEAQuf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 12:50:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22110C2
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 09:50:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b35789313so1884867b3a.3
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682959832; x=1685551832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEflLLcWNWC/jvwtRq92vXF8nN7NQEJ3vnb6+zyUW3E=;
        b=i2lIMFlEup6B76yVsFI7pmvYDcqNsBsWGOLY1GyUxI5iG3png7OSkrrNNfiboXJ81H
         F8Ji1oiS9iDZz6keGPqiIl3eHtItp8pkrsejOebDaKU8nav3CUUr+GiwCxzN1GoiScPL
         67iVTKOkaioYzwWpHZEkF62TnLHrkJG21n3Zuu8U7AMF1KJ16leVwxTNoAs3GsjPyJHS
         D2P2tbXdMwJbM9gOrUdl2c8IjtsPMH7a+xBB96dK/ALZ65iySyCabR2ud3W6NT4xusD5
         DW7cTIR8QXestBCYKEIehDRKCwOHc2LqHt/YgYpFMks1lh3hGyEKAjhwy9wpJqQ26mU2
         w2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959832; x=1685551832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEflLLcWNWC/jvwtRq92vXF8nN7NQEJ3vnb6+zyUW3E=;
        b=ggz2wqThcOc7KIsNZDoPgPuk7xu7wVhUDy3fa5YHnJu6JXy9BfrO5PIKublXUt23Sq
         kyF2bees/FiJq4KrAnwklLub3bzQiieQK4JyN5dKAoU9W0USyElIy3N8+XjsV4dDgZQ+
         XpmBgUBRP2YKVn7T/miFA9CP9xxs3q40zeOxEWjXXfBju1XwVqYIL81ay5KGIHYuUQmF
         mByPBBLEDPs1OufUhdzRsKf0j1nb91DiWa7Ee0FV2OjEH/tzlxJnj5S8aKVsm3G4hjJO
         3H4X0URw3SyxQtEi6AP6Sdj1hLLR1LbpT1x1PWWuwYet7OVszg00RhYOlifojvWip8/z
         +0Uw==
X-Gm-Message-State: AC+VfDyitNbyV7ESxmc5CKET7k8amlfQpKkzB7UnAgkuP66udl0nEPTI
        wPBkSrbXaLpcruUilMOfEvQ=
X-Google-Smtp-Source: ACHHUZ4HnEUc1FMhE0A/kgrzHeEHscgQU9gcE2cqCT/tkCwgltFIFZpE4vUmzQoNbBj4mfyE6nVnUQ==
X-Received: by 2002:a05:6a00:2392:b0:641:4e80:a7c0 with SMTP id f18-20020a056a00239200b006414e80a7c0mr8152537pfc.22.1682959831476;
        Mon, 01 May 2023 09:50:31 -0700 (PDT)
Received: from toolbox ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id g4-20020a056a001a0400b0062a7462d398sm20840494pfv.170.2023.05.01.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:50:30 -0700 (PDT)
Date:   Mon, 1 May 2023 09:50:22 -0700
From:   JP Kobryn <inwardvessel@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/2] libbpf: add capability for resizing datasec
 maps
Message-ID: <ZE/tzq0v/zkfO6cl@toolbox>
References: <20230428222754.183432-1-inwardvessel@gmail.com>
 <20230428222754.183432-2-inwardvessel@gmail.com>
 <ZExdsHwc6Gy716am@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZExdsHwc6Gy716am@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 04:58:40PM -0700, Stanislav Fomichev wrote:
> On 04/28, JP Kobryn wrote:
> > This patch updates bpf_map__set_value_size() so that if the given map is a
> > datasec, it will attempt to resize it. If the following criteria is met,
> > the resizing can be performed:
> >  - BTF info is present
> >  - the map is a datasec
> >  - the datasec contains a single variable
> >  - the single variable is an array
> > 
> > The new map_datasec_resize() function is used to perform the resizing
> > of the associated memory mapped region and adjust BTF so that the original
> > array variable points to a new BTF array that is sized to cover the
> > requested size. The new array size will be rounded up to a multiple of
> > the element size.
> > 
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 138 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 1cbacf9e71f3..991649cacc10 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9412,12 +9412,150 @@ __u32 bpf_map__value_size(const struct bpf_map *map)
> >  	return map->def.value_size;
> >  }
> >  
> > +static bool map_is_datasec(struct bpf_map *map)
> > +{
> > +	struct btf *btf;
> > +	struct btf_type *map_type;
> > +
> > +	btf = bpf_object__btf(map->obj);
> > +	if (!btf)
> > +		return false;
> > +
> > +	map_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
> > +
> > +	return btf_is_datasec(map_type);
> > +}
> > +
> > +static int map_datasec_resize(struct bpf_map *map, __u32 size)
> > +{
> > +	int err;
> > +	struct btf *btf;
> > +	struct btf_type *datasec_type, *var_type, *resolved_type, *array_element_type;
> > +	struct btf_var_secinfo *var;
> > +	struct btf_array *array;
> > +	__u32 resolved_id, new_array_id;
> > +	__u32 rounded_sz;
> > +	__u32 nr_elements;
> > +	__u32 old_value_sz = map->def.value_size;
> > +	size_t old_mmap_sz, new_mmap_sz;
> > +
> > +	/* btf is required and datasec map must be memory mapped */
> > +	btf = bpf_object__btf(map->obj);
> > +	if (!btf) {
> > +		pr_warn("cannot resize datasec map '%s' while btf info is not present\n",
> > +				bpf_map__name(map));
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	datasec_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
> > +	if (!btf_is_datasec(datasec_type)) {
> > +		pr_warn("attempted to resize datasec map '%s' but map is not a datasec\n",
> > +				bpf_map__name(map));
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!map->mmaped) {
> > +		pr_warn("cannot resize datasec map '%s' while map is unexpectedly not memory mapped\n",
> > +				bpf_map__name(map));
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* datasec must only have a single variable */
> > +	if (btf_vlen(datasec_type) != 1) {
> > +		pr_warn("cannot resize datasec map '%s' that does not consist of a single var\n",
> > +				bpf_map__name(map));
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* the single variable has to be an array */
> > +	var = btf_var_secinfos(datasec_type);
> > +	resolved_id = btf__resolve_type(btf, var->type);
> > +	resolved_type = btf_type_by_id(btf, resolved_id);
> > +	if (!btf_is_array(resolved_type)) {
> > +		pr_warn("cannot resize datasec map '%s' whose single var is not an array\n",
> > +				bpf_map__name(map));
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* create a new array based on the existing array but with new length,
> > +	 * rounding up the requested size for alignment
> > +	 */
> > +	array = btf_array(resolved_type);
> > +	array_element_type = btf_type_by_id(btf, array->type);
> > +	rounded_sz = roundup(size, array_element_type->size);
> > +	nr_elements = rounded_sz / array_element_type->size;
> > +	new_array_id = btf__add_array(btf, array->index_type, array->type,
> > +			nr_elements);
> > +	if (new_array_id < 0) {
> > +		pr_warn("failed to resize datasec map '%s' due to failure in creating new array\n",
> > +				bpf_map__name(map));
> > +		err = new_array_id;
> > +
> > +		goto fail_array;
> > +	}
> > +
> > +	/* adding a new btf type invalidates existing pointers to btf objects.
> > +	 * refresh pointers before proceeding
> > +	 */
> > +	datasec_type = btf_type_by_id(btf, map->btf_value_type_id);
> > +	var = btf_var_secinfos(datasec_type);
> > +	var_type = btf_type_by_id(btf, var->type);
> > +
> > +	/* remap the associated memory */
> > +	old_value_sz = map->def.value_size;
> > +	old_mmap_sz = bpf_map_mmap_sz(map);
> > +	map->def.value_size = rounded_sz;
> > +	new_mmap_sz = bpf_map_mmap_sz(map);
> > +
> > +	if (munmap(map->mmaped, old_mmap_sz)) {
> > +		err = -errno;
> > +		pr_warn("failed to resize datasec map '%s' due to failure in munmap(), err:%d\n",
> > +			 bpf_map__name(map), err);
> > +
> > +		goto fail_mmap;
> > +	}
> > +
> > +	map->mmaped = mmap(NULL, new_mmap_sz, PROT_READ | PROT_WRITE,
> > +		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 
> I'm probably missing something, but how does it work? This just mmaps
> new memory which the user-space side will see. What about the BPF side?
> 
In general (not specific to this patch), all datasec maps are
memory mapped with an initialization image. See
bpf_object__load_skeleton() to see how this initial mapping is later
associated with the actual bpf maps (file descriptors) kernel side.

> I'm also assuming (maybe incorrectly?) that if the map is mmaped, it's
> already created in the kernel, so what's the point of the resizing?

This is still the initialization image being resized. This resizing
happens before the map is associated kernel side. If the map has already
been created on the bpf side, attempting to resize returns -EBUSY (not
new in this patch).
-- 

