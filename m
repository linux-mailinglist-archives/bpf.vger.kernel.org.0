Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F7686E8A
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 19:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBAS7t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 13:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBAS7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 13:59:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590128A4B
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 10:59:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB7CF61923
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 18:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5154C433EF;
        Wed,  1 Feb 2023 18:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675277981;
        bh=0WKXtvls9gRXuHu4MaR54AYkdzG1V+eSi1zNNM1IE10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jx3h0tSbn7Z/9VN7WJnu5RCsH295Gsc+f05lFF3NJnV95LmfFNCZkzkvcIlOcugJr
         3UlWGC0AbL3nbnqUcAdzWj9vq4Jbif641S2LtwIbP+enrrp2oORzoqe823F+0y5Jao
         9CfXg2KrPUne0OpeSGOsckaCvDZp/ELda8tyDc+dxJQSp3Gps/TAdzomRs2/+EzT0L
         kxrPky9iKYB2dlXqshoMRE/GykYkhdshTyrccg6eub30bJ6+VCOiRoLL/GDpg3oIEu
         ugNM3kvkcVtTEiTvMJ7kwuzbIn3MDNj6z/nnlFosnTGCK8gmcdaiVZlqz5caAoa/xx
         hHAaV1c0NWHMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62393405BE; Wed,  1 Feb 2023 15:59:38 -0300 (-03)
Date:   Wed, 1 Feb 2023 15:59:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: refactor function addition
 into dedicated btf_encoder__add_func
Message-ID: <Y9q2mqQ5Fat+jf+H@kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-3-git-send-email-alan.maguire@oracle.com>
 <Y9qfMMrdro8PK5J1@kernel.org>
 <9d06aa0a-2d46-9bce-7911-8c976e162c51@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d06aa0a-2d46-9bce-7911-8c976e162c51@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 01, 2023 at 05:50:45PM +0000, Alan Maguire escreveu:
> On 01/02/2023 17:19, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 30, 2023 at 02:29:42PM +0000, Alan Maguire escreveu:
> >> This will be useful for postponing local function addition later on.
> >> As part of this, store the type id offset and unspecified type in
> >> the encoder, as this will simplify late addition of local functions.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  btf_encoder.c | 101 +++++++++++++++++++++++++++++++++-------------------------
> >>  1 file changed, 57 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/btf_encoder.c b/btf_encoder.c
> >> index a5fa04a..44f1905 100644
> >> --- a/btf_encoder.c
> >> +++ b/btf_encoder.c
> >> @@ -54,6 +54,8 @@ struct btf_encoder {
> >>  	struct gobuffer   percpu_secinfo;
> >>  	const char	  *filename;
> >>  	struct elf_symtab *symtab;
> >> +	uint32_t	  type_id_off;
> >> +	uint32_t	  unspecified_type;
> >>  	bool		  has_index_type,
> >>  			  need_index_type,
> >>  			  skip_encoding_vars,
> >> @@ -593,20 +595,20 @@ static int32_t btf_encoder__add_func_param(struct btf_encoder *encoder, const ch
> >>  	}
> >>  }
> >>  
> >> -static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
> >> +static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_type)
> >>  {
> >>  	if (tag_type == 0)
> >>  		return 0;
> >>  
> >> -	if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
> >> +	if (tag_type == encoder->unspecified_type) {
> >>  		// No provision for encoding this, turn it into void.
> >>  		return 0;
> >>  	}
> > 
> > Humm, are those two lines (above) really equivalent? IIRC I read that as
> > encoder->cu->unspecified_type.tag being zero means we still didn't set
> > it, not that it is void (zero), right?
> > 
> > So if we're passing a tag_type zero, void, we'll return 0, i.e. turn
> > into a void, so seems equivalent, try not to combine patches like this
> > in the future, i.e. I would expect, from a quick glance, to have:
> > 
> > -     if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
> > +     if (encoder->unspecified_type && tag_type == encoder->unspecified_type) {
> > 
> > I.e. just the removal of the indirection thru encoder->cu. Or am I
> > missing something here?
> >
> 
> No, I don't think you're missing anything. I should have separated
> out the changes that record encoder info such that we don't need to
> rely on the current CU; we need those because now we interact with
> functions potentially much later on, and the current CU can be
> different. Ideally that would have come before this patch
> refactoring function addition.

That would be great, I have another branch, 'alt_dwarf', that supports
.dwz files (alternate DWARF) support DW_TAG_partial_unit, etc that I got
confirmation working with both userspace code (openvswitch) as well with
opensuse's kernel that uses alternate DWARF (using the dwz tool).

There is also work on supporting C atomics (yeah, there are different
DWARF tags for that, like DW_TAG_const_type -> DW_TAG_pointer_type...)
so I need to test it more, there is also implications for encoding such
things in BTF, as some people would like, so I need to find time to test
it more, after we cut 1.25.

I mention this because there are merge problems with what were doing
here, so the more granular we get the patches in this series, the less
difficult it will be to merge that other work.
 
> I can rework the series to do that if you like? Patch 5 will

Please.

> need a bit of work too so that we can continue to support the

Yeah, I actually suggested that in another message :-)

> legacy behaviour, and we'll need an additional patch to support
> switching the inconsistent prototype handling on also.

great. Meanwhile I'll do tests with what we have so far as suggested by
Alexei, on bpf-next.

Thanks!

- Arnaldo
  
> > - Arnaldo
> > 
> >>  
> >> -	return type_id_off + tag_type;
> >> +	return encoder->type_id_off + tag_type;
> >>  }
> >>  
> >> -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, uint32_t type_id_off)
> >> +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype)
> >>  {
> >>  	struct btf *btf = encoder->btf;
> >>  	const struct btf_type *t;
> >> @@ -616,7 +618,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
> >>  
> >>  	/* add btf_type for func_proto */
> >>  	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> >> -	type_id = btf_encoder__tag_type(encoder, type_id_off, ftype->tag.type);
> >> +	type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
> >>  
> >>  	id = btf__add_func_proto(btf, type_id);
> >>  	if (id > 0) {
> >> @@ -634,7 +636,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
> >>  	ftype__for_each_parameter(ftype, param) {
> >>  		const char *name = parameter__name(param);
> >>  
> >> -		type_id = param->tag.type == 0 ? 0 : type_id_off + param->tag.type;
> >> +		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
> >>  		++param_idx;
> >>  		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
> >>  			return -1;
> >> @@ -762,6 +764,31 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
> >>  	return id;
> >>  }
> >>  
> >> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
> >> +{
> >> +	int btf_fnproto_id, btf_fn_id, tag_type_id;
> >> +	struct llvm_annotation *annot;
> >> +	const char *name;
> >> +
> >> +	btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
> >> +	name = function__name(fn);
> >> +	btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
> >> +	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
> >> +		printf("error: failed to encode function '%s'\n", function__name(fn));
> >> +		return -1;
> >> +	}
> >> +	list_for_each_entry(annot, &fn->annots, node) {
> >> +		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
> >> +							annot->component_idx);
> >> +		if (tag_type_id < 0) {
> >> +			fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
> >> +				annot->value, name, annot->component_idx);
> >> +			return -1;
> >> +		}
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >>  /*
> >>   * This corresponds to the same macro defined in
> >>   * include/linux/kallsyms.h
> >> @@ -859,22 +886,21 @@ static void dump_invalid_symbol(const char *msg, const char *sym,
> >>  	fprintf(stderr, "PAHOLE: Error: Use '--btf_encode_force' to ignore such symbols and force emit the btf.\n");
> >>  }
> >>  
> >> -static int tag__check_id_drift(const struct tag *tag,
> >> -			       uint32_t core_id, uint32_t btf_type_id,
> >> -			       uint32_t type_id_off)
> >> +static int tag__check_id_drift(struct btf_encoder *encoder, const struct tag *tag,
> >> +			       uint32_t core_id, uint32_t btf_type_id)
> >>  {
> >> -	if (btf_type_id != (core_id + type_id_off)) {
> >> +	if (btf_type_id != (core_id + encoder->type_id_off)) {
> >>  		fprintf(stderr,
> >>  			"%s: %s id drift, core_id: %u, btf_type_id: %u, type_id_off: %u\n",
> >>  			__func__, dwarf_tag_name(tag->tag),
> >> -			core_id, btf_type_id, type_id_off);
> >> +			core_id, btf_type_id, encoder->type_id_off);
> >>  		return -1;
> >>  	}
> >>  
> >>  	return 0;
> >>  }
> >>  
> >> -static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag, uint32_t type_id_off)
> >> +static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag)
> >>  {
> >>  	struct type *type = tag__type(tag);
> >>  	struct class_member *pos;
> >> @@ -896,7 +922,8 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
> >>  		 * is required.
> >>  		 */
> >>  		name = class_member__name(pos);
> >> -		if (btf_encoder__add_field(encoder, name, type_id_off + pos->tag.type, pos->bitfield_size, pos->bit_offset))
> >> +		if (btf_encoder__add_field(encoder, name, encoder->type_id_off + pos->tag.type,
> >> +					   pos->bitfield_size, pos->bit_offset))
> >>  			return -1;
> >>  	}
> >>  
> >> @@ -936,11 +963,11 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
> >>  	return type_id;
> >>  }
> >>  
> >> -static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag, uint32_t type_id_off,
> >> +static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
> >>  				   struct conf_load *conf_load)
> >>  {
> >>  	/* single out type 0 as it represents special type "void" */
> >> -	uint32_t ref_type_id = tag->type == 0 ? 0 : type_id_off + tag->type;
> >> +	uint32_t ref_type_id = tag->type == 0 ? 0 : encoder->type_id_off + tag->type;
> >>  	struct base_type *bt;
> >>  	const char *name;
> >>  
> >> @@ -970,7 +997,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
> >>  		if (tag__type(tag)->declaration)
> >>  			return btf_encoder__add_ref_type(encoder, BTF_KIND_FWD, 0, name, tag->tag == DW_TAG_union_type);
> >>  		else
> >> -			return btf_encoder__add_struct_type(encoder, tag, type_id_off);
> >> +			return btf_encoder__add_struct_type(encoder, tag);
> >>  	case DW_TAG_array_type:
> >>  		/* TODO: Encode one dimension at a time. */
> >>  		encoder->need_index_type = true;
> >> @@ -978,7 +1005,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
> >>  	case DW_TAG_enumeration_type:
> >>  		return btf_encoder__add_enum_type(encoder, tag, conf_load);
> >>  	case DW_TAG_subroutine_type:
> >> -		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
> >> +		return btf_encoder__add_func_proto(encoder, tag__ftype(tag));
> >>          case DW_TAG_unspecified_type:
> >>  		/* Just don't encode this for now, converting anything with this type to void (0) instead.
> >>  		 *
> >> @@ -1281,7 +1308,7 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
> >>  	return true;
> >>  }
> >>  
> >> -static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_t type_id_off)
> >> +static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
> >>  {
> >>  	struct cu *cu = encoder->cu;
> >>  	uint32_t core_id;
> >> @@ -1366,7 +1393,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
> >>  			continue;
> >>  		}
> >>  
> >> -		type = var->ip.tag.type + type_id_off;
> >> +		type = var->ip.tag.type + encoder->type_id_off;
> >>  		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
> >>  
> >>  		if (encoder->verbose) {
> >> @@ -1507,7 +1534,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
> >>  
> >>  int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
> >>  {
> >> -	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
> >>  	struct llvm_annotation *annot;
> >>  	int btf_type_id, tag_type_id, skipped_types = 0;
> >>  	uint32_t core_id;
> >> @@ -1516,21 +1542,24 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> >>  	int err = 0;
> >>  
> >>  	encoder->cu = cu;
> >> +	encoder->type_id_off = btf__type_cnt(encoder->btf) - 1;
> >> +	if (encoder->cu->unspecified_type.tag)
> >> +		encoder->unspecified_type = encoder->cu->unspecified_type.type;
> >>  
> >>  	if (!encoder->has_index_type) {
> >>  		/* cu__find_base_type_by_name() takes "type_id_t *id" */
> >>  		type_id_t id;
> >>  		if (cu__find_base_type_by_name(cu, "int", &id)) {
> >>  			encoder->has_index_type = true;
> >> -			encoder->array_index_id = type_id_off + id;
> >> +			encoder->array_index_id = encoder->type_id_off + id;
> >>  		} else {
> >>  			encoder->has_index_type = false;
> >> -			encoder->array_index_id = type_id_off + cu->types_table.nr_entries;
> >> +			encoder->array_index_id = encoder->type_id_off + cu->types_table.nr_entries;
> >>  		}
> >>  	}
> >>  
> >>  	cu__for_each_type(cu, core_id, pos) {
> >> -		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off, conf_load);
> >> +		btf_type_id = btf_encoder__encode_tag(encoder, pos, conf_load);
> >>  
> >>  		if (btf_type_id == 0) {
> >>  			++skipped_types;
> >> @@ -1538,7 +1567,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> >>  		}
> >>  
> >>  		if (btf_type_id < 0 ||
> >> -		    tag__check_id_drift(pos, core_id, btf_type_id + skipped_types, type_id_off)) {
> >> +		    tag__check_id_drift(encoder, pos, core_id, btf_type_id + skipped_types)) {
> >>  			err = -1;
> >>  			goto out;
> >>  		}
> >> @@ -1572,7 +1601,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> >>  			continue;
> >>  		}
> >>  
> >> -		btf_type_id = type_id_off + core_id;
> >> +		btf_type_id = encoder->type_id_off + core_id;
> >>  		ns = tag__namespace(pos);
> >>  		list_for_each_entry(annot, &ns->annots, node) {
> >>  			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_type_id, annot->component_idx);
> >> @@ -1585,8 +1614,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> >>  	}
> >>  
> >>  	cu__for_each_function(cu, core_id, fn) {
> >> -		int btf_fnproto_id, btf_fn_id;
> >> -		const char *name;
> >>  
> >>  		/*
> >>  		 * Skip functions that:
> >> @@ -1616,27 +1643,13 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> >>  				continue;
> >>  		}
> >>  
> >> -		btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto, type_id_off);
> >> -		name = function__name(fn);
> >> -		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
> >> -		if (btf_fnproto_id < 0 || btf_fn_id < 0) {
> >> -			err = -1;
> >> -			printf("error: failed to encode function '%s'\n", function__name(fn));
> >> +		err = btf_encoder__add_func(encoder, fn);
> >> +		if (err)
> >>  			goto out;
> >> -		}
> >> -
> >> -		list_for_each_entry(annot, &fn->annots, node) {
> >> -			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id, annot->component_idx);
> >> -			if (tag_type_id < 0) {
> >> -				fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
> >> -					annot->value, name, annot->component_idx);
> >> -				goto out;
> >> -			}
> >> -		}
> >>  	}
> >>  
> >>  	if (!encoder->skip_encoding_vars)
> >> -		err = btf_encoder__encode_cu_variables(encoder, type_id_off);
> >> +		err = btf_encoder__encode_cu_variables(encoder);
> >>  out:
> >>  	encoder->cu = NULL;
> >>  	return err;
> >> -- 
> >> 1.8.3.1
> >>
> > 

-- 

- Arnaldo
