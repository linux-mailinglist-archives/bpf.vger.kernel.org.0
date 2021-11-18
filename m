Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF03D455C14
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 14:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhKRNEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 08:04:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244901AbhKRNDS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 08:03:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FA0661ACE;
        Thu, 18 Nov 2021 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637240418;
        bh=rPFIFMzNqj05EK7tG2aka+cq8uPNRJjC3b4OfyD6+w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+1BZ4J0qqOynj3igXIhSGEAdF5cLmba38W82Xnoi1BkRgilhKz8AD6rgDkHn4y0o
         PwQ6+1Fc+So6Wit/pS/V5klyjoZCFyiKFIXTyIVX3d1wfUXEfDiFwgHukLqxRnOGH+
         8SEY0+QHI85SOkfoBZDI04kV88S22ehi2zJ92Wga94UPiiX6rLqrM60QrR5MlP4IOU
         2/lkiBEUz/wb9CyMzlGym9GmJtRpDljOkrf/9ODOeg4u2jsSOhoCtFVfKJjdo8sDne
         RKII8poVu1IOTLHOk5OohnmnEEKRgCovAw5Pby4RRjcR5mT6R0uNqcjOb7Cw1HJfAp
         bR5jeS97ts50w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DB3F4088E; Thu, 18 Nov 2021 10:00:14 -0300 (-03)
Date:   Thu, 18 Nov 2021 10:00:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves 3/4] dwarf_loader: support btf_type_tag attribute
Message-ID: <YZZOXq0mL7YW5IhC@kernel.org>
References: <20211117202214.3268824-1-yhs@fb.com>
 <20211117202229.3270304-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117202229.3270304-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 17, 2021 at 12:22:29PM -0800, Yonghong Song escreveu:
> This patch implemented dwarf_loader support. If a pointer type
> contains DW_TAG_LLVM_annotation tags, a new type
> btf_type_tag_ptr_type will be created which will store
> the pointer tag itself and all DW_TAG_LLVM_annotation tags.
> During recoding stage, the type chain will be formed properly
> based on the above example.
> 
> An option "--skip_encoding_btf_type_tag" is added to disable
> this new functionality.
> 
>   [1] https://reviews.llvm.org/D111199
>   [2] https://reviews.llvm.org/D113222
>   [3] https://reviews.llvm.org/D113496

You forgot to add your S-o-B and to add this entry to
man-pages/pahole.1, I'm fixing both cases, bellow is a followup
patch, I'll add one as well for the recently added
--skip_encoding_btf_decl_tag.

- Arnaldo

commit 9c3101db76acf364607d90adb3052e34d81fa1bd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Nov 18 09:56:35 2021 -0300

    man pages: Add missing --skip_encoding_btf_type_tag entry
    
    In the past we saw the value of being able to disable specific features
    due to problems in in its implementation, allowing users to use a subset
    of functionality, without the problematic one.
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index edcf58b8ca5814a3..f9f64b67945b45cb 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -197,6 +197,10 @@ the debugging information.
 .B \-\-skip_encoding_btf_vars
 Do not encode VARs in BTF.
 
+.TP
+.B \-\-skip_encoding_btf_type_tag
+Do not encode type tags in BTF.
+
 .TP
 .B \-j, \-\-jobs=N
 Run N jobs in parallel. Defaults to number of online processors + 10% (like



> ---
>  dwarf_loader.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++--
>  dwarves.h      |  33 +++++++++++++-
>  pahole.c       |   8 ++++
>  3 files changed, 153 insertions(+), 4 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 1b07a62..5b2bebb 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1206,6 +1206,88 @@ static struct tag *die__create_new_tag(Dwarf_Die *die, struct cu *cu)
>  	return tag;
>  }
>  
> +static struct btf_type_tag_ptr_type *die__create_new_btf_type_tag_ptr_type(Dwarf_Die *die, struct cu *cu)
> +{
> +	struct btf_type_tag_ptr_type *tag;
> +
> +	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_ptr_type));
> +	if (tag == NULL)
> +		return NULL;
> +
> +	tag__init(&tag->tag, cu, die);
> +	tag->tag.has_btf_type_tag = true;
> +	INIT_LIST_HEAD(&tag->tags);
> +	return tag;
> +}
> +
> +static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *die, struct cu *cu,
> +								   struct conf_load *conf)
> +{
> +	struct btf_type_tag_type *tag;
> +
> +	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_type));
> +	if (tag == NULL)
> +		return NULL;
> +
> +	tag__init(&tag->tag, cu, die);
> +	tag->value = attr_string(die, DW_AT_const_value, conf);
> +	return tag;
> +}
> +
> +static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
> +					       struct conf_load *conf)
> +{
> +	struct btf_type_tag_ptr_type *tag = NULL;
> +	struct btf_type_tag_type *annot;
> +	Dwarf_Die *cdie, child;
> +	const char *name;
> +	uint32_t id;
> +
> +	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
> +	 * and return
> +	 */
> +	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
> +	    conf->skip_encoding_btf_type_tag)
> +		return tag__new(die, cu);
> +
> +	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
> +	cdie = &child;
> +	do {
> +		if (dwarf_tag(cdie) == DW_TAG_LLVM_annotation) {
> +			/* Only check btf_type_tag annotations */
> +			name = attr_string(cdie, DW_AT_name, conf);
> +			if (strcmp(name, "btf_type_tag") != 0)
> +				continue;
> +
> +			if (tag == NULL) {
> +				/* Create a btf_type_tag_ptr type. */
> +				tag = die__create_new_btf_type_tag_ptr_type(die, cu);
> +				if (!tag)
> +					return NULL;
> +			}
> +
> +			/* Create a btf_type_tag type for this annotation. */
> +			annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
> +			if (annot == NULL)
> +				return NULL;
> +
> +			if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> +				return NULL;
> +
> +			struct dwarf_tag *dtag = annot->tag.priv;
> +			dtag->small_id = id;
> +			cu__hash(cu, &annot->tag);
> +
> +			/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
> +			 * the tag->tags contains tag3 -> tag2 -> tag1.
> +			 */
> +			list_add(&annot->node, &tag->tags);
> +		}
> +	} while (dwarf_siblingof(cdie, cdie) == 0);
> +
> +	return tag ? &tag->tag : tag__new(die, cu);
> +}
> +
>  static struct tag *die__create_new_ptr_to_member_type(Dwarf_Die *die,
>  						      struct cu *cu)
>  {
> @@ -1903,12 +1985,13 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>  	case DW_TAG_const_type:
>  	case DW_TAG_imported_declaration:
>  	case DW_TAG_imported_module:
> -	case DW_TAG_pointer_type:
>  	case DW_TAG_reference_type:
>  	case DW_TAG_restrict_type:
>  	case DW_TAG_unspecified_type:
>  	case DW_TAG_volatile_type:
>  		tag = die__create_new_tag(die, cu);		break;
> +	case DW_TAG_pointer_type:
> +		tag = die__create_new_pointer_tag(die, cu, conf);	break;
>  	case DW_TAG_ptr_to_member_type:
>  		tag = die__create_new_ptr_to_member_type(die, cu); break;
>  	case DW_TAG_enumeration_type:
> @@ -2192,6 +2275,26 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
>  	}
>  }
>  
> +static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
> +					      uint32_t pointee_type)
> +{
> +	struct btf_type_tag_type *annot;
> +	struct dwarf_tag *annot_dtag;
> +	struct tag *prev_tag;
> +
> +	/* If tag->tags contains tag3 -> tag2 -> tag1, the final type chain
> +	 * looks like:
> +	 *   pointer -> tag3 -> tag2 -> tag1 -> pointee
> +	 */
> +	prev_tag = &tag->tag;
> +	list_for_each_entry(annot, &tag->tags, node) {
> +		annot_dtag = annot->tag.priv;
> +		prev_tag->type = annot_dtag->small_id;
> +		prev_tag = &annot->tag;
> +	}
> +	prev_tag->type = pointee_type;
> +}
> +
>  static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
>  {
>  	struct dwarf_tag *dtag = tag->priv;
> @@ -2301,7 +2404,10 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
>  	}
>  
>  	if (dtag->type.off == 0) {
> -		tag->type = 0; /* void */
> +		if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
> +			tag->type = 0; /* void */
> +		else
> +			dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), 0);
>  		return 0;
>  	}
>  
> @@ -2313,7 +2419,11 @@ check_type:
>  		return 0;
>  	}
>  out:
> -	tag->type = dtype->small_id;
> +	if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
> +		tag->type = dtype->small_id;
> +	else
> +		dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), dtype->small_id);
> +
>  	return 0;
>  }
>  
> diff --git a/dwarves.h b/dwarves.h
> index 0d3e204..4425d3c 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -63,6 +63,7 @@ struct conf_load {
>  	bool			ptr_table_stats;
>  	bool			skip_encoding_btf_decl_tag;
>  	bool			skip_missing;
> +	bool			skip_encoding_btf_type_tag;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> @@ -413,6 +414,7 @@ struct tag {
>  	uint16_t	 tag;
>  	bool		 visited;
>  	bool		 top_level;
> +	bool		 has_btf_type_tag;
>  	uint16_t	 recursivity_level;
>  	void		 *priv;
>  };
> @@ -533,7 +535,8 @@ static inline int tag__is_tag_type(const struct tag *tag)
>  	       tag->tag == DW_TAG_restrict_type ||
>  	       tag->tag == DW_TAG_subroutine_type ||
>  	       tag->tag == DW_TAG_unspecified_type ||
> -	       tag->tag == DW_TAG_volatile_type;
> +	       tag->tag == DW_TAG_volatile_type ||
> +	       tag->tag == DW_TAG_LLVM_annotation;
>  }
>  
>  static inline const char *tag__decl_file(const struct tag *tag,
> @@ -606,6 +609,34 @@ struct llvm_annotation {
>  	struct list_head	node;
>  };
>  
> +/** struct btf_type_tag_type - representing a btf_type_tag annotation
> + *
> + * @tag   - DW_TAG_LLVM_annotation tag
> + * @value - btf_type_tag value string
> + * @node  - list_head node
> + */
> +struct btf_type_tag_type {
> +	struct tag		tag;
> +	const char		*value;
> +	struct list_head	node;
> +};
> +
> +/** The struct btf_type_tag_ptr_type - type containing both pointer type and
> + *  its btf_type_tag annotations
> + *
> + * @tag  - pointer type tag
> + * @tags - btf_type_tag annotations for the pointer type
> + */
> +struct btf_type_tag_ptr_type {
> +	struct tag		tag;
> +	struct list_head 	tags;
> +};
> +
> +static inline struct btf_type_tag_ptr_type *tag__btf_type_tag_ptr(struct tag *tag)
> +{
> +	return (struct btf_type_tag_ptr_type *)tag;
> +}
> +
>  /** struct namespace - base class for enums, structs, unions, typedefs, etc
>   *
>   * @tags - class_member, enumerators, etc
> diff --git a/pahole.c b/pahole.c
> index 5fc1cca..f3a51cb 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1126,6 +1126,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_devel_stats	   330
>  #define ARGP_skip_encoding_btf_decl_tag 331
>  #define ARGP_skip_missing          332
> +#define ARGP_skip_encoding_btf_type_tag 333
>  
>  static const struct argp_option pahole__options[] = {
>  	{
> @@ -1506,6 +1507,11 @@ static const struct argp_option pahole__options[] = {
>  		.key  = ARGP_skip_missing,
>  		.doc = "skip missing types passed to -C rather than stop",
>  	},
> +	{
> +		.name = "skip_encoding_btf_type_tag",
> +		.key  = ARGP_skip_encoding_btf_type_tag,
> +		.doc  = "Do not encode TAGs in BTF."
> +	},
>  	{
>  		.name = NULL,
>  	}
> @@ -1658,6 +1664,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		conf_load.skip_encoding_btf_decl_tag = true;	break;
>  	case ARGP_skip_missing:
>  		conf_load.skip_missing = true;          break;
> +	case ARGP_skip_encoding_btf_type_tag:
> +		conf_load.skip_encoding_btf_type_tag = true;	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> -- 
> 2.30.2

-- 

- Arnaldo
