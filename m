Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19315287B5A
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgJHSG5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 14:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbgJHSG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Oct 2020 14:06:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C39620725;
        Thu,  8 Oct 2020 18:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602180414;
        bh=QEGfGxdKlVDACmAwD/Tcr7eTiDnlpZXvXWt3K3Ln8h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N41snErwAyvdnc9mi493M4HuRJSYdkjNddcW/3WIlB5eihlKyLeuRhfoRIs7D30Zb
         m1bg0Nqj7ougOQQu3CEvaMYywtnfEUdzwwNaK5JGLqUBr66Th/SnaAXKZ4xhz+Rq1I
         B9ZHJ9GTwNjUE3xta2a6nF8rKSDwaL8vajQcU81g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CBC82403AC; Thu,  8 Oct 2020 15:06:51 -0300 (-03)
Date:   Thu, 8 Oct 2020 15:06:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 04/11] btf_loader: use libbpf to load BTF
Message-ID: <20201008180651.GD246083@kernel.org>
References: <20200930042742.2525310-1-andriin@fb.com>
 <20200930042742.2525310-5-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930042742.2525310-5-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Sep 29, 2020 at 09:27:35PM -0700, Andrii Nakryiko escreveu:
> Switch BTF loading to completely use libbpf's own struct btf and related APIs.
> BTF encoding is still happening with pahole's own code, so these two code
> paths are not sharing anything now. String fetching is happening based on
> whether btfe->strings were set to non-NULL pointer by btf_encoder.
 
This patch is not applying, since there was a fix in the btf_loader.c
file where lexblocks (DWARF concept) wasn't being initialized and then
some other tool was segfaulting when trying to traverse an uninitialized
list.

I tried applying this patch by hand, but it seems it needs some
massaging before I can use plain vim on it:

diff --git a/btf_loader.c b/btf_loader.c
index 9db76957a7e5..c31ee61060f1 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -46,21 +46,17 @@ static void *tag__alloc(const size_t size)
 }
=20
 static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto=
, uint32_t tag,
-                              uint32_t type, uint16_t vlen, struct btf_param *args, uint32_t=
 id)
+                              const struct btf_type *tp, uint32_t id)
 {
-       int i;
+       const struct btf_param *param =3D btf_params(tp);
+       int i, vlen =3D btf_vlen(tp);
=20
        proto->tag.tag  =3D tag;
-       proto->tag.type =3D type;
+       proto->tag.type =3D tp->type;
        INIT_LIST_HEAD(&proto->parms);
=20
-       for (i =3D 0; i < vlen; ++i) {


Can you please check?

The first three patches are already applied an in master, both at
kernel.org and its mirror at github.com.

- Arnaldo

> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  btf_loader.c | 244 +++++++++++++++++++--------------------------------
>  libbtf.c     | 116 +++++-------------------
>  libbtf.h     |  11 +--
>  3 files changed, 113 insertions(+), 258 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 9db76957a7e5..c31ee61060f1 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -46,21 +46,17 @@ static void *tag__alloc(const size_t size)
>  }
>  
>  static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto, uint32_t tag,
> -			       uint32_t type, uint16_t vlen, struct btf_param *args, uint32_t id)
> +			       const struct btf_type *tp, uint32_t id)
>  {
> -	int i;
> +	const struct btf_param *param = btf_params(tp);
> +	int i, vlen = btf_vlen(tp);
>  
>  	proto->tag.tag	= tag;
> -	proto->tag.type = type;
> +	proto->tag.type = tp->type;
>  	INIT_LIST_HEAD(&proto->parms);
>  
> -	for (i = 0; i < vlen; ++i) {
> -		struct btf_param param = {
> -		       .name_off = btf_elf__get32(btfe, &args[i].name_off),
> -		       .type	 = btf_elf__get32(btfe, &args[i].type),
> -		};
> -
> -		if (param.type == 0)
> +	for (i = 0; i < vlen; ++i, param++) {
> +		if (param->type == 0)
>  			proto->unspec_parms = 1;
>  		else {
>  			struct parameter *p = tag__alloc(sizeof(*p));
> @@ -68,25 +64,22 @@ static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto, uint32
>  			if (p == NULL)
>  				goto out_free_parameters;
>  			p->tag.tag  = DW_TAG_formal_parameter;
> -			p->tag.type = param.type;
> -			p->name	    = param.name_off;
> +			p->tag.type = param->type;
> +			p->name	    = param->name_off;
>  			ftype__add_parameter(proto, p);
>  		}
>  	}
>  
> -	vlen *= sizeof(*args);
>  	cu__add_tag_with_id(btfe->priv, &proto->tag, id);
>  
> -	return vlen;
> +	return 0;
>  out_free_parameters:
>  	ftype__delete(proto, btfe->priv);
>  	return -ENOMEM;
>  }
>  
> -static int create_new_function(struct btf_elf *btfe, struct btf_type *tp, uint64_t size, uint32_t id)
> +static int create_new_function(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	strings_t name = btf_elf__get32(btfe, &tp->name_off);
> -	unsigned int type_id = btf_elf__get32(btfe, &tp->type);
>  	struct function *func = tag__alloc(sizeof(*func));
>  
>  	if (func == NULL)
> @@ -96,8 +89,8 @@ static int create_new_function(struct btf_elf *btfe, struct btf_type *tp, uint64
>  	// but the prototype, the return type is the one in type_id
>  	func->btf = 1;
>  	func->proto.tag.tag = DW_TAG_subprogram;
> -	func->proto.tag.type = type_id;
> -	func->name = name;
> +	func->proto.tag.type = tp->type;
> +	func->name = tp->name_off;
>  	cu__add_tag_with_id(btfe->priv, &func->proto.tag, id);
>  
>  	return 0;
> @@ -165,26 +158,24 @@ static struct variable *variable__new(strings_t name, uint32_t linkage)
>  	return var;
>  }
>  
> -static int create_new_base_type(struct btf_elf *btfe, void *ptr, struct btf_type *tp, uint32_t id)
> +static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	uint32_t *enc = ptr;
> -	uint32_t eval = btf_elf__get32(btfe, enc);
> -	uint32_t attrs = BTF_INT_ENCODING(eval);
> -	strings_t name = btf_elf__get32(btfe, &tp->name_off);
> -	struct base_type *base = base_type__new(name, attrs, 0,
> -						BTF_INT_BITS(eval));
> +	uint32_t attrs = btf_int_encoding(tp);
> +	strings_t name = tp->name_off;
> +	struct base_type *base = base_type__new(name, attrs, 0, btf_int_bits(tp));
> +
>  	if (base == NULL)
>  		return -ENOMEM;
>  
>  	base->tag.tag = DW_TAG_base_type;
>  	cu__add_tag_with_id(btfe->priv, &base->tag, id);
>  
> -	return sizeof(*enc);
> +	return 0;
>  }
>  
> -static int create_new_array(struct btf_elf *btfe, void *ptr, uint32_t id)
> +static int create_new_array(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	struct btf_array *ap = ptr;
> +	struct btf_array *ap = btf_array(tp);
>  	struct array_type *array = tag__alloc(sizeof(*array));
>  
>  	if (array == NULL)
> @@ -200,81 +191,67 @@ static int create_new_array(struct btf_elf *btfe, void *ptr, uint32_t id)
>  		return -ENOMEM;
>  	}
>  
> -	array->nr_entries[0] = btf_elf__get32(btfe, &ap->nelems);
> +	array->nr_entries[0] = ap->nelems;
>  	array->tag.tag = DW_TAG_array_type;
> -	array->tag.type = btf_elf__get32(btfe, &ap->type);
> +	array->tag.type = ap->type;
>  
>  	cu__add_tag_with_id(btfe->priv, &array->tag, id);
>  
> -	return sizeof(*ap);
> +	return 0;
>  }
>  
> -static int create_members(struct btf_elf *btfe, void *ptr, int vlen, struct type *class,
> -			  bool kflag)
> +static int create_members(struct btf_elf *btfe, const struct btf_type *tp,
> +			  struct type *class)
>  {
> -	struct btf_member *mp = ptr;
> -	int i;
> +	struct btf_member *mp = btf_members(tp);
> +	int i, vlen = btf_vlen(tp);
>  
>  	for (i = 0; i < vlen; i++) {
>  		struct class_member *member = zalloc(sizeof(*member));
> -		uint32_t offset;
>  
>  		if (member == NULL)
>  			return -ENOMEM;
>  
>  		member->tag.tag    = DW_TAG_member;
> -		member->tag.type   = btf_elf__get32(btfe, &mp[i].type);
> -		member->name	   = btf_elf__get32(btfe, &mp[i].name_off);
> -		offset = btf_elf__get32(btfe, &mp[i].offset);
> -		if (kflag) {
> -			member->bit_offset = BTF_MEMBER_BIT_OFFSET(offset);
> -			member->bitfield_size = BTF_MEMBER_BITFIELD_SIZE(offset);
> -		} else {
> -			member->bit_offset = offset;
> -			member->bitfield_size = 0;
> -		}
> +		member->tag.type   = mp[i].type;
> +		member->name	   = mp[i].name_off;
> +		member->bit_offset = btf_member_bit_offset(tp, i);
> +		member->bitfield_size = btf_member_bitfield_size(tp, i);
>  		member->byte_offset = member->bit_offset / 8;
>  		/* sizes and offsets will be corrected at class__fixup_btf_bitfields */
>  		type__add_member(class, member);
>  	}
>  
> -	return sizeof(*mp);
> +	return 0;
>  }
>  
> -static int create_new_class(struct btf_elf *btfe, void *ptr, int vlen,
> -			    struct btf_type *tp, uint64_t size, uint32_t id,
> -			    bool kflag)
> +static int create_new_class(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	strings_t name = btf_elf__get32(btfe, &tp->name_off);
> -	struct class *class = class__new(name, size);
> -	int member_size = create_members(btfe, ptr, vlen, &class->type, kflag);
> +	struct class *class = class__new(tp->name_off, tp->size);
> +	int member_size = create_members(btfe, tp, &class->type);
>  
>  	if (member_size < 0)
>  		goto out_free;
>  
>  	cu__add_tag_with_id(btfe->priv, &class->type.namespace.tag, id);
>  
> -	return (vlen * member_size);
> +	return 0;
>  out_free:
>  	class__delete(class, btfe->priv);
>  	return -ENOMEM;
>  }
>  
> -static int create_new_union(struct btf_elf *btfe, void *ptr,
> -			    int vlen, struct btf_type *tp,
> -			    uint64_t size, uint32_t id,
> -			    bool kflag)
> +static int create_new_union(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	strings_t name = btf_elf__get32(btfe, &tp->name_off);
> -	struct type *un = type__new(DW_TAG_union_type, name, size);
> -	int member_size = create_members(btfe, ptr, vlen, un, kflag);
> +	struct type *un = type__new(DW_TAG_union_type, tp->name_off, tp->size);
> +	int member_size = create_members(btfe, tp, un);
>  
>  	if (member_size < 0)
>  		goto out_free;
>  
>  	cu__add_tag_with_id(btfe->priv, &un->namespace.tag, id);
>  
> -	return (vlen * member_size);
> +	return 0;
>  out_free:
>  	type__delete(un, btfe->priv);
>  	return -ENOMEM;
> @@ -293,22 +270,20 @@ static struct enumerator *enumerator__new(strings_t name, uint32_t value)
>  	return en;
>  }
>  
> -static int create_new_enumeration(struct btf_elf *btfe, void *ptr,
> -				  int vlen, struct btf_type *tp,
> -				  uint16_t size, uint32_t id)
> +static int create_new_enumeration(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	struct btf_enum *ep = ptr;
> -	uint16_t i;
> +	struct btf_enum *ep = btf_enum(tp);
> +	uint16_t i, vlen = btf_vlen(tp);
>  	struct type *enumeration = type__new(DW_TAG_enumeration_type,
> -					     btf_elf__get32(btfe, &tp->name_off),
> -					     size ? size * 8 : (sizeof(int) * 8));
> +					     tp->name_off,
> +					     tp->size ? tp->size * 8 : (sizeof(int) * 8));
>  
>  	if (enumeration == NULL)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < vlen; i++) {
> -		strings_t name = btf_elf__get32(btfe, &ep[i].name_off);
> -		uint32_t value = btf_elf__get32(btfe, (uint32_t *)&ep[i].val);
> +		strings_t name = ep[i].name_off;
> +		uint32_t value = ep[i].val;
>  		struct enumerator *enumerator = enumerator__new(name, value);
>  
>  		if (enumerator == NULL)
> @@ -319,32 +294,25 @@ static int create_new_enumeration(struct btf_elf *btfe, void *ptr,
>  
>  	cu__add_tag_with_id(btfe->priv, &enumeration->namespace.tag, id);
>  
> -	return (vlen * sizeof(*ep));
> +	return 0;
>  out_free:
>  	enumeration__delete(enumeration, btfe->priv);
>  	return -ENOMEM;
>  }
>  
> -static int create_new_subroutine_type(struct btf_elf *btfe, void *ptr,
> -				      int vlen, struct btf_type *tp,
> -				      uint32_t id)
> +static int create_new_subroutine_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	struct btf_param *args = ptr;
> -	unsigned int type = btf_elf__get32(btfe, &tp->type);
>  	struct ftype *proto = tag__alloc(sizeof(*proto));
>  
>  	if (proto == NULL)
>  		return -ENOMEM;
>  
> -	vlen = btf_elf__load_ftype(btfe, proto, DW_TAG_subroutine_type, type, vlen, args, id);
> -	return vlen < 0 ? -ENOMEM : vlen;
> +	return btf_elf__load_ftype(btfe, proto, DW_TAG_subroutine_type, tp, id);
>  }
>  
> -static int create_new_forward_decl(struct btf_elf *btfe, struct btf_type *tp,
> -				   uint64_t size, uint32_t id)
> +static int create_new_forward_decl(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	strings_t name = btf_elf__get32(btfe, &tp->name_off);
> -	struct class *fwd = class__new(name, size);
> +	struct class *fwd = class__new(tp->name_off, 0);
>  
>  	if (fwd == NULL)
>  		return -ENOMEM;
> @@ -353,41 +321,33 @@ static int create_new_forward_decl(struct btf_elf *btfe, struct btf_type *tp,
>  	return 0;
>  }
>  
> -static int create_new_typedef(struct btf_elf *btfe, struct btf_type *tp, uint64_t size, uint32_t id)
> +static int create_new_typedef(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	strings_t name = btf_elf__get32(btfe, &tp->name_off);
> -	unsigned int type_id = btf_elf__get32(btfe, &tp->type);
> -	struct type *type = type__new(DW_TAG_typedef, name, size);
> +	struct type *type = type__new(DW_TAG_typedef, tp->name_off, 0);
>  
>  	if (type == NULL)
>  		return -ENOMEM;
>  
> -	type->namespace.tag.type = type_id;
> +	type->namespace.tag.type = tp->type;
>  	cu__add_tag_with_id(btfe->priv, &type->namespace.tag, id);
>  
>  	return 0;
>  }
>  
> -static int create_new_variable(struct btf_elf *btfe, void *ptr, struct btf_type *tp,
> -			       uint64_t size, uint32_t id)
> +static int create_new_variable(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	strings_t name = btf_elf__get32(btfe, &tp->name_off);
> -	unsigned int type_id = btf_elf__get32(btfe, &tp->type);
> -	struct btf_var *bvar = ptr;
> -	uint32_t linkage = btf_elf__get32(btfe, &bvar->linkage);
> -	struct variable *var = variable__new(name, linkage);
> +	struct btf_var *bvar = btf_var(tp);
> +	struct variable *var = variable__new(tp->name_off, bvar->linkage);
>  
>  	if (var == NULL)
>  		return -ENOMEM;
>  
> -	var->ip.tag.type = type_id;
> +	var->ip.tag.type = tp->type;
>  	cu__add_tag_with_id(btfe->priv, &var->ip.tag, id);
> -	return sizeof(*bvar);
> +	return 0;
>  }
>  
> -static int create_new_datasec(struct btf_elf *btfe, void *ptr, int vlen,
> -			      struct btf_type *tp, uint64_t size, uint32_t id,
> -			      bool kflag)
> +static int create_new_datasec(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
>  	//strings_t name = btf_elf__get32(btfe, &tp->name_off);
>  
> @@ -397,12 +357,11 @@ static int create_new_datasec(struct btf_elf *btfe, void *ptr, int vlen,
>  	 * FIXME: this will not be used to reconstruct some original C code,
>  	 * its about runtime placement of variables so just ignore this for now
>  	 */
> -	return vlen * sizeof(struct btf_var_secinfo);
> +	return 0;
>  }
>  
> -static int create_new_tag(struct btf_elf *btfe, int type, struct btf_type *tp, uint32_t id)
> +static int create_new_tag(struct btf_elf *btfe, int type, const struct btf_type *tp, uint32_t id)
>  {
> -	unsigned int type_id = btf_elf__get32(btfe, &tp->type);
>  	struct tag *tag = zalloc(sizeof(*tag));
>  
>  	if (tag == NULL)
> @@ -419,104 +378,77 @@ static int create_new_tag(struct btf_elf *btfe, int type, struct btf_type *tp, u
>  		return 0;
>  	}
>  
> -	tag->type = type_id;
> +	tag->type = tp->type;
>  	cu__add_tag_with_id(btfe->priv, tag, id);
>  
>  	return 0;
>  }
>  
> -void *btf_elf__get_buffer(struct btf_elf *btfe)
> -{
> -	return btfe->data;
> -}
> -
> -size_t btf_elf__get_size(struct btf_elf *btfe)
> -{
> -	return btfe->size;
> -}
> -
>  static int btf_elf__load_types(struct btf_elf *btfe)
>  {
> -	void *btf_buffer = btf_elf__get_buffer(btfe);
> -	struct btf_header *hp = btf_buffer;
> -	void *btf_contents = btf_buffer + sizeof(*hp),
> -	     *type_section = (btf_contents + btf_elf__get32(btfe, &hp->type_off)),
> -	     *strings_section = (btf_contents + btf_elf__get32(btfe, &hp->str_off));
> -	struct btf_type *type_ptr = type_section,
> -			*end = strings_section;
> -	uint32_t type_index = 0x0001;
> -
> -	while (type_ptr < end) {
> -		uint32_t val  = btf_elf__get32(btfe, &type_ptr->info);
> -		uint32_t type = BTF_INFO_KIND(val);
> -		int	 vlen = BTF_INFO_VLEN(val);
> -		void	 *ptr = type_ptr;
> -		uint32_t size = btf_elf__get32(btfe, &type_ptr->size);
> -		bool     kflag = BTF_INFO_KFLAG(val);
> -
> -		ptr += sizeof(struct btf_type);
> +	uint32_t type_index;
> +	int err;
> +
> +	for (type_index = 1; type_index <= btf__get_nr_types(btfe->btf); type_index++) {
> +		const struct btf_type *type_ptr = btf__type_by_id(btfe->btf, type_index);
> +		uint32_t type = btf_kind(type_ptr);
>  
>  		switch (type) {
>  		case BTF_KIND_INT:
> -			vlen = create_new_base_type(btfe, ptr, type_ptr, type_index);
> +			err = create_new_base_type(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_ARRAY:
> -			vlen = create_new_array(btfe, ptr, type_index);
> +			err = create_new_array(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_STRUCT:
> -			vlen = create_new_class(btfe, ptr, vlen, type_ptr, size, type_index, kflag);
> +			err = create_new_class(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_UNION:
> -			vlen = create_new_union(btfe, ptr, vlen, type_ptr, size, type_index, kflag);
> +			err = create_new_union(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_ENUM:
> -			vlen = create_new_enumeration(btfe, ptr, vlen, type_ptr, size, type_index);
> +			err = create_new_enumeration(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_FWD:
> -			vlen = create_new_forward_decl(btfe, type_ptr, size, type_index);
> +			err = create_new_forward_decl(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_TYPEDEF:
> -			vlen = create_new_typedef(btfe, type_ptr, size, type_index);
> +			err = create_new_typedef(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_VAR:
> -			vlen = create_new_variable(btfe, ptr, type_ptr, size, type_index);
> +			err = create_new_variable(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_DATASEC:
> -			vlen = create_new_datasec(btfe, ptr, vlen, type_ptr, size, type_index, kflag);
> +			err = create_new_datasec(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_VOLATILE:
>  		case BTF_KIND_PTR:
>  		case BTF_KIND_CONST:
>  		case BTF_KIND_RESTRICT:
> -			vlen = create_new_tag(btfe, type, type_ptr, type_index);
> +			err = create_new_tag(btfe, type, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_UNKN:
>  			cu__table_nullify_type_entry(btfe->priv, type_index);
> -			fprintf(stderr, "BTF: idx: %d, off: %zd, Unknown kind %d\n",
> -				type_index, ((void *)type_ptr) - type_section, type);
> +			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
>  			fflush(stderr);
> -			vlen = 0;
> +			err = 0;
>  			break;
>  		case BTF_KIND_FUNC_PROTO:
> -			vlen = create_new_subroutine_type(btfe, ptr, vlen, type_ptr, type_index);
> +			err = create_new_subroutine_type(btfe, type_ptr, type_index);
>  			break;
>  		case BTF_KIND_FUNC:
>  			// BTF_KIND_FUNC corresponding to a defined subprogram.
> -			vlen = create_new_function(btfe, type_ptr, size, type_index);
> +			err = create_new_function(btfe, type_ptr, type_index);
>  			break;
>  		default:
> -			fprintf(stderr, "BTF: idx: %d, off: %zd, Unknown kind %d\n",
> -				type_index, ((void *)type_ptr) - type_section, type);
> +			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
>  			fflush(stderr);
> -			vlen = 0;
> +			err = 0;
>  			break;
>  		}
>  
> -		if (vlen < 0)
> -			return vlen;
> -
> -		type_ptr = ptr + vlen;
> -		type_index++;
> +		if (err < 0)
> +			return err;
>  	}
>  	return 0;
>  }
> diff --git a/libbtf.c b/libbtf.c
> index 7a01ded4e612..02a55dbd7e13 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -62,89 +62,29 @@ static int btf_var_secinfo_cmp(const void *a, const void *b)
>  	return av->offset - bv->offset;
>  }
>  
> -uint32_t btf_elf__get32(struct btf_elf *btfe, uint32_t *p)
> -{
> -	uint32_t val = *p;
> -
> -	if (btfe->swapped)
> -		val = ((val >> 24) |
> -		       ((val >> 8) & 0x0000ff00) |
> -		       ((val << 8) & 0x00ff0000) |
> -		       (val << 24));
> -	return val;
> -}
> -
> -static int btf_raw__load(struct btf_elf *btfe)
> +static int libbpf_log(enum libbpf_print_level level, const char *format, va_list args)
>  {
> -        size_t read_cnt;
> -        struct stat st;
> -        void *data;
> -        FILE *fp;
> -
> -        if (stat(btfe->filename, &st))
> -                return -1;
> -
> -        data = malloc(st.st_size);
> -        if (!data)
> -                return -1;
> -
> -        fp = fopen(btfe->filename, "rb");
> -        if (!fp)
> -                goto cleanup;
> -
> -        read_cnt = fread(data, 1, st.st_size, fp);
> -        fclose(fp);
> -        if (read_cnt < st.st_size)
> -                goto cleanup;
> -
> -	btfe->swapped	= 0;
> -	btfe->data	= data;
> -	btfe->size	= read_cnt;
> -	return 0;
> -cleanup:
> -        free(data);
> -        return -1;
> +	return vfprintf(stderr, format, args);
>  }
>  
>  int btf_elf__load(struct btf_elf *btfe)
>  {
> -	if (btfe->raw_btf)
> -		return btf_raw__load(btfe);
> -
> -	int err = -ENOTSUP;
> -	GElf_Shdr shdr;
> -	Elf_Scn *sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr, ".BTF", NULL);
> +	int err;
>  
> -	if (sec == NULL)
> -		return -ESRCH;
> -
> -	Elf_Data *data = elf_getdata(sec, NULL);
> -	if (data == NULL) {
> -		fprintf(stderr, "%s: cannot get data of BTF section.\n", __func__);
> -		return -1;
> -	}
> -
> -	struct btf_header *hp = data->d_buf;
> -	size_t orig_size = data->d_size;
> -
> -	if (hp->version != BTF_VERSION)
> -		goto out;
> +	libbpf_set_print(libbpf_log);
>  
> -	err = -EINVAL;
> -	if (hp->magic == BTF_MAGIC)
> -		btfe->swapped = 0;
> +	/* free initial empty BTF */
> +	btf__free(btfe->btf);
> +	if (btfe->raw_btf)
> +		btfe->btf = btf__parse_raw(btfe->filename);
>  	else
> -		goto out;
> +		btfe->btf = btf__parse_elf(btfe->filename, NULL);
>  
> -	err = -ENOMEM;
> -	btfe->data = malloc(orig_size);
> -	if (btfe->data != NULL) {
> -		memcpy(btfe->data, hp, orig_size);
> -		btfe->size = orig_size;
> -		err = 0;
> -	}
> -out:
> -	return err;
> +	err = libbpf_get_error(btfe->btf);
> +	if (err)
> +		return err;
> +
> +	return 0;
>  }
>  
>  
> @@ -251,26 +191,17 @@ void btf_elf__delete(struct btf_elf *btfe)
>  
>  	__gobuffer__delete(&btfe->types);
>  	__gobuffer__delete(&btfe->percpu_secinfo);
> +	btf__free(btfe->btf);
>  	free(btfe->filename);
>  	free(btfe->data);
>  	free(btfe);
>  }
>  
> -char *btf_elf__string(struct btf_elf *btfe, uint32_t ref)
> +const char *btf_elf__string(struct btf_elf *btfe, uint32_t ref)
>  {
> -	struct btf_header *hp = btfe->hdr;
> -	uint32_t off = ref;
> -	char *name;
> -
> -	if (off >= btf_elf__get32(btfe, &hp->str_len))
> -		return "(ref out-of-bounds)";
> -
> -	if ((off + btf_elf__get32(btfe, &hp->str_off)) >= btfe->size)
> -		return "(string table truncated)";
> +	const char *s = btf__str_by_offset(btfe->btf, ref);
>  
> -	name = ((char *)(hp + 1) + btf_elf__get32(btfe, &hp->str_off) + off);
> -
> -	return name[0] == '\0' ? NULL : name;
> +	return s && s[0] == '\0' ? NULL : s;
>  }
>  
>  static void *btf_elf__nohdr_data(struct btf_elf *btfe)
> @@ -310,8 +241,10 @@ static const char *btf_elf__name_in_gobuf(const struct btf_elf *btfe, uint32_t o
>  {
>  	if (!offset)
>  		return "(anon)";
> -	else
> +	else if (btfe->strings)
>  		return &btfe->strings->entries[offset];
> +	else
> +		return btf__str_by_offset(btfe->btf, offset);
>  }
>  
>  static const char * btf_elf__int_encoding_str(uint8_t encoding)
> @@ -836,11 +769,6 @@ out:
>  	return err;
>  }
>  
> -static int libbpf_log(enum libbpf_print_level level, const char *format, va_list args)
> -{
> -	return vfprintf(stderr, format, args);
> -}
> -
>  int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
>  {
>  	struct btf_header *hdr;
> @@ -886,7 +814,7 @@ int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
>  		return -1;
>  	}
>  	if (btf__dedup(btf, NULL, NULL)) {
> -		fprintf(stderr, "%s: btf__dedup failed!", __func__);
> +		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;
>  	}
>  
> diff --git a/libbtf.h b/libbtf.h
> index be06480bf854..5f29b427c4fd 100644
> --- a/libbtf.h
> +++ b/libbtf.h
> @@ -11,6 +11,7 @@
>  
>  #include <stdbool.h>
>  #include <stdint.h>
> +#include "lib/bpf/src/btf.h"
>  
>  struct btf_elf {
>  	union {
> @@ -26,7 +27,6 @@ struct btf_elf {
>  	struct gobuffer   percpu_secinfo;
>  	char		  *filename;
>  	size_t		  size;
> -	int		  swapped;
>  	int		  in_fd;
>  	uint8_t		  wordsize;
>  	bool		  is_big_endian;
> @@ -34,6 +34,7 @@ struct btf_elf {
>  	uint32_t	  type_index;
>  	uint32_t	  percpu_shndx;
>  	uint64_t	  percpu_base_addr;
> +	struct btf	  *btf;
>  };
>  
>  extern uint8_t btf_elf__verbose;
> @@ -70,13 +71,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
>  void btf_elf__set_strings(struct btf_elf *btf, struct gobuffer *strings);
>  int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
>  
> -char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
> +const char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
>  int btf_elf__load(struct btf_elf *btf);
>  
> -uint32_t btf_elf__get32(struct btf_elf *btf, uint32_t *p);
> -
> -void *btf_elf__get_buffer(struct btf_elf *btf);
> -
> -size_t btf_elf__get_size(struct btf_elf *btf);
> -
>  #endif /* _LIBBTF_H */
> -- 
> 2.24.1
> 

-- 

- Arnaldo
