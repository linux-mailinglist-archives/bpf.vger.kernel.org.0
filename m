Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF716F35C4
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjEASXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEASXP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 14:23:15 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03FDF
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 11:23:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517bfcfe83fso1403147a12.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682965394; x=1685557394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUSvbTlQz6CHNkllC+k+THJoORehdMWbOzB7KMTGjRI=;
        b=NSY2UQkgJUdNmi9xb/vElr6vOd0japjC/Dlvj6+Fp+VVSOb8oh/V0ZODuWXMh9xACc
         n2sUtKa0lDtw5G0NALwqKV89oLolj4fPOOp8s2G7qPmmq+n+yqmo4u7GjJyG4UbLYveM
         BEPvfSmSmo97Ou/x5Tc3sQqP/Zpn2uTXtLW5Q5xnWDoIb82AKKXZ16EXmFU1q2i4T1S/
         z/jV4e3tdOpsznyhzthIBfvt4gHUF2q6SxMGa9u1gwPBSRZLe7IViIZKj5Dl7rYKHUVy
         3+zSZpkOWdvDf2FAhGNwpI4Xh3omV8//scf5+c3xqSwq58fj6jGw0GfKNc8ngjuK7BEj
         wBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682965394; x=1685557394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUSvbTlQz6CHNkllC+k+THJoORehdMWbOzB7KMTGjRI=;
        b=VUYTGt/CvoYoA2m1Pz1GlqpiSl8GpbQnr2xgKtBP5dbbBs1CM/pYjtryWLJRPiS5OS
         GeaH0QFDh4SLBqtXYZ3ODKrkhVqbtH7lJX2QXpo+X1WNdbbWDxRN1CqWUgozBeX6pJe0
         Q6045jCTekzbf+iAp82rwgUCz0Cmc41u2FT+/Wk1h8HPQX0AW/r3naX6qMemW5DEB+VB
         1XwoePqJmm+JHTsUEsgXh133svde6JmDPrjrvO1BBYfAUDbKvbTLt0V7LJps5fsDmzL3
         9buzYaqfn+Nf6BiJqG5d59x6i3DEwudadYBLbQilL0TXw0A1OewbzFG8PirusnzrPuyC
         JVRA==
X-Gm-Message-State: AC+VfDxbBcGKqsunE4w/cop2wKE9+2x2Pn4pF/C7Flhu1khLAEbLDJeI
        iF7iPo9aNmUOxmMi94SLIjl2A9A=
X-Google-Smtp-Source: ACHHUZ6xxKM1sECNIAxpnS9QpXHVBhSR0L+Gt+wT2/ZG8Ip9qDhsM+iQBwCRKJxqv6LfApSmtBa2sjQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6c85:0:b0:52c:3fd6:6ae0 with SMTP id
 h127-20020a636c85000000b0052c3fd66ae0mr88042pgc.12.1682965393928; Mon, 01 May
 2023 11:23:13 -0700 (PDT)
Date:   Mon, 1 May 2023 11:23:12 -0700
In-Reply-To: <ZE/tzq0v/zkfO6cl@toolbox>
Mime-Version: 1.0
References: <20230428222754.183432-1-inwardvessel@gmail.com>
 <20230428222754.183432-2-inwardvessel@gmail.com> <ZExdsHwc6Gy716am@google.com>
 <ZE/tzq0v/zkfO6cl@toolbox>
Message-ID: <ZFADkPfQq7vKuOaH@google.com>
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

On 05/01, JP Kobryn wrote:
> On Fri, Apr 28, 2023 at 04:58:40PM -0700, Stanislav Fomichev wrote:
> > On 04/28, JP Kobryn wrote:
> > > This patch updates bpf_map__set_value_size() so that if the given map is a
> > > datasec, it will attempt to resize it. If the following criteria is met,
> > > the resizing can be performed:
> > >  - BTF info is present
> > >  - the map is a datasec
> > >  - the datasec contains a single variable
> > >  - the single variable is an array
> > > 
> > > The new map_datasec_resize() function is used to perform the resizing
> > > of the associated memory mapped region and adjust BTF so that the original
> > > array variable points to a new BTF array that is sized to cover the
> > > requested size. The new array size will be rounded up to a multiple of
> > > the element size.
> > > 
> > > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 138 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 138 insertions(+)
> > > 
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 1cbacf9e71f3..991649cacc10 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -9412,12 +9412,150 @@ __u32 bpf_map__value_size(const struct bpf_map *map)
> > >  	return map->def.value_size;
> > >  }
> > >  
> > > +static bool map_is_datasec(struct bpf_map *map)
> > > +{
> > > +	struct btf *btf;
> > > +	struct btf_type *map_type;
> > > +
> > > +	btf = bpf_object__btf(map->obj);
> > > +	if (!btf)
> > > +		return false;
> > > +
> > > +	map_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
> > > +
> > > +	return btf_is_datasec(map_type);
> > > +}
> > > +
> > > +static int map_datasec_resize(struct bpf_map *map, __u32 size)
> > > +{
> > > +	int err;
> > > +	struct btf *btf;
> > > +	struct btf_type *datasec_type, *var_type, *resolved_type, *array_element_type;
> > > +	struct btf_var_secinfo *var;
> > > +	struct btf_array *array;
> > > +	__u32 resolved_id, new_array_id;
> > > +	__u32 rounded_sz;
> > > +	__u32 nr_elements;
> > > +	__u32 old_value_sz = map->def.value_size;
> > > +	size_t old_mmap_sz, new_mmap_sz;
> > > +
> > > +	/* btf is required and datasec map must be memory mapped */
> > > +	btf = bpf_object__btf(map->obj);
> > > +	if (!btf) {
> > > +		pr_warn("cannot resize datasec map '%s' while btf info is not present\n",
> > > +				bpf_map__name(map));
> > > +
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	datasec_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
> > > +	if (!btf_is_datasec(datasec_type)) {
> > > +		pr_warn("attempted to resize datasec map '%s' but map is not a datasec\n",
> > > +				bpf_map__name(map));
> > > +
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!map->mmaped) {
> > > +		pr_warn("cannot resize datasec map '%s' while map is unexpectedly not memory mapped\n",
> > > +				bpf_map__name(map));
> > > +
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* datasec must only have a single variable */
> > > +	if (btf_vlen(datasec_type) != 1) {
> > > +		pr_warn("cannot resize datasec map '%s' that does not consist of a single var\n",
> > > +				bpf_map__name(map));
> > > +
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* the single variable has to be an array */
> > > +	var = btf_var_secinfos(datasec_type);
> > > +	resolved_id = btf__resolve_type(btf, var->type);
> > > +	resolved_type = btf_type_by_id(btf, resolved_id);
> > > +	if (!btf_is_array(resolved_type)) {
> > > +		pr_warn("cannot resize datasec map '%s' whose single var is not an array\n",
> > > +				bpf_map__name(map));
> > > +
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* create a new array based on the existing array but with new length,
> > > +	 * rounding up the requested size for alignment
> > > +	 */
> > > +	array = btf_array(resolved_type);
> > > +	array_element_type = btf_type_by_id(btf, array->type);
> > > +	rounded_sz = roundup(size, array_element_type->size);
> > > +	nr_elements = rounded_sz / array_element_type->size;
> > > +	new_array_id = btf__add_array(btf, array->index_type, array->type,
> > > +			nr_elements);
> > > +	if (new_array_id < 0) {
> > > +		pr_warn("failed to resize datasec map '%s' due to failure in creating new array\n",
> > > +				bpf_map__name(map));
> > > +		err = new_array_id;
> > > +
> > > +		goto fail_array;
> > > +	}
> > > +
> > > +	/* adding a new btf type invalidates existing pointers to btf objects.
> > > +	 * refresh pointers before proceeding
> > > +	 */
> > > +	datasec_type = btf_type_by_id(btf, map->btf_value_type_id);
> > > +	var = btf_var_secinfos(datasec_type);
> > > +	var_type = btf_type_by_id(btf, var->type);
> > > +
> > > +	/* remap the associated memory */
> > > +	old_value_sz = map->def.value_size;
> > > +	old_mmap_sz = bpf_map_mmap_sz(map);
> > > +	map->def.value_size = rounded_sz;
> > > +	new_mmap_sz = bpf_map_mmap_sz(map);
> > > +
> > > +	if (munmap(map->mmaped, old_mmap_sz)) {
> > > +		err = -errno;
> > > +		pr_warn("failed to resize datasec map '%s' due to failure in munmap(), err:%d\n",
> > > +			 bpf_map__name(map), err);
> > > +
> > > +		goto fail_mmap;
> > > +	}
> > > +
> > > +	map->mmaped = mmap(NULL, new_mmap_sz, PROT_READ | PROT_WRITE,
> > > +		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > 
> > I'm probably missing something, but how does it work? This just mmaps
> > new memory which the user-space side will see. What about the BPF side?
> > 
> In general (not specific to this patch), all datasec maps are
> memory mapped with an initialization image. See
> bpf_object__load_skeleton() to see how this initial mapping is later
> associated with the actual bpf maps (file descriptors) kernel side.
> 
> > I'm also assuming (maybe incorrectly?) that if the map is mmaped, it's
> > already created in the kernel, so what's the point of the resizing?
> 
> This is still the initialization image being resized. This resizing
> happens before the map is associated kernel side. If the map has already
> been created on the bpf side, attempting to resize returns -EBUSY (not
> new in this patch).

I see, makes sense now, thanks!

Acked-by: Stanislav Fomichev <sdf@google.com>
