Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35824560A12
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiF2TM2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiF2TM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 15:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C843336D;
        Wed, 29 Jun 2022 12:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2357B62050;
        Wed, 29 Jun 2022 19:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A9EC34114;
        Wed, 29 Jun 2022 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656529943;
        bh=5G/hI0r9kAXykKMYLMaZqIqvBl+YSlULsUrcIgVQ78U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4cP/ByRZz/MuqDQtD2VCoKCrUuyoZwFgkc+V6U9zI3cglmiTqYZEYhQZMIuCDThC
         Mzu7wxk1StZ4T3HSTxuKUaYmn39Ft1+QoVn9qFcNj66PoaiqWzdUNsYOioxhBLInE/
         V7VUiOdp8vuFdjKBErsdf+ctCy0JlNgImED++UTvnaSCpQVDvcuTsobv0RAk01W+BW
         z3DJg1DE6Seuiwc0lV49mWAxV/nqhFqa09TcB66D34gy4Ri/v/kR63pVFFHRbI+BRW
         F7kYsOE7OCJnep4zzpHRy1lDoaNaVvQNKC+ygn530t07T0ZiYI9RuOBquZiVxEvk1z
         +RYktsWSE3l2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C08BD4096F; Wed, 29 Jun 2022 16:12:19 -0300 (-03)
Date:   Wed, 29 Jun 2022 16:12:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 2/2] btf: Support BTF_KIND_ENUM64
Message-ID: <YrykE1zgKXvKaAgx@kernel.org>
References: <20220629071213.3178592-1-yhs@fb.com>
 <20220629071224.3180594-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629071224.3180594-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 29, 2022 at 12:12:24AM -0700, Yonghong Song escreveu:
> BTF_KIND_ENUM64 is supported with latest libbpf, which
> supports 64-bit enum values. Latest libbpf also supports
> signedness for enum values. Add enum64 support in
> dwarf-to-btf conversion.
> 
> The following is an example of new encoding which covers
> signed/unsigned enum64/enum variations.

So, testing this with torvalds/master I'm getting:

FAILED: load BTF from vmlinux: Invalid argument
make[1]: *** [/var/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
make[1]: *** Deleting file 'vmlinux'
make[1]: Leaving directory '/var/home/acme/git/build/v5.19-rc4+'
make: *** [Makefile:219: __sub-make] Error 2

real	8m12.396s
user	183m18.009s
sys	44m27.085s
⬢[acme@toolbox linux]$ find . -name "*.c" | xargs grep "load BTF from vmlinux"
⬢[acme@toolbox linux]$ find . -name "*.c" | xargs grep "load BTF from"
./tools/bpf/bpftool/btf.c:			p_err("failed to load BTF from %s: %s",
./tools/bpf/resolve_btfids/main.c:		pr_err("FAILED: load BTF from %s: %s\n",
./tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:		  "Failed to load BTF from btf_data.o\n"))
⬢[acme@toolbox linux]$ vim ./tools/bpf/resolve_btfids/main.c

Which is:

        btf = btf__parse_split(obj->btf ?: obj->path, base_btf);
        err = libbpf_get_error(btf);
        if (err) {
                pr_err("FAILED: load BTF from %s: %s\n",
                        obj->btf ?: obj->path, strerror(-err));
                goto out;
        }

I.e. tools/lib/bpf in torvalds/master doesn´t support BTF_KIND_ENUM64,
right? So to build it with a new pahole one needs to ask for
--skip_encoding_btf_enum64? How to do this automagically? I.e. its a
matter of checking if the in-kernel libbpf has support for it and if not
use --skip_encoding_btf_enum64?

I'm now going to try with bpf-next/master

- Arnaldo
 
>   $cat t.c
>   enum { /* signed, enum64 */
>     A = -1,
>     B = 0xffffffff,
>   } g1;
>   enum { /* unsigned, enum64 */
>     C = 1,
>     D = 0xfffffffff,
>   } g2;
>   enum { /* signed, enum */
>     E = -1,
>     F = 0xfffffff,
>   } g3;
>   enum { /* unsigned, enum */
>     G = 1,
>     H = 0xfffffff,
>   } g4;
>   $ clang -g -c t.c
>   $ pahole -JV t.o
>   btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>   Found 0 per-CPU variables!
>   File t.o:
>   [1] ENUM64 (anon) size=8
>           A val=-1
>           B val=4294967295
>   [2] INT long size=8 nr_bits=64 encoding=SIGNED
>   [3] ENUM64 (anon) size=8
>           C val=1
>           D val=68719476735
>   [4] INT unsigned long size=8 nr_bits=64 encoding=(none)
>   [5] ENUM (anon) size=4
>           E val=-1
>           F val=268435455
>   [6] INT int size=4 nr_bits=32 encoding=SIGNED
>   [7] ENUM (anon) size=4
>           G val=1
>           H val=268435455
>   [8] INT unsigned int size=4 nr_bits=32 encoding=(none)
> 
> With the flag to skip enum64 encoding,
> 
>   $ pahole -JV t.o --skip_encoding_btf_enum64
>   btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>   Found 0 per-CPU variables!
>   File t.o:
>   [1] ENUM (anon) size=8
>         A val=4294967295
>         B val=4294967295
>   [2] INT long size=8 nr_bits=64 encoding=SIGNED
>   [3] ENUM (anon) size=8
>         C val=1
>         D val=4294967295
>   [4] INT unsigned long size=8 nr_bits=64 encoding=(none)
>   [5] ENUM (anon) size=4
>         E val=4294967295
>         F val=268435455
>   [6] INT int size=4 nr_bits=32 encoding=SIGNED
>   [7] ENUM (anon) size=4
>         G val=1
>         H val=268435455
>   [8] INT unsigned int size=4 nr_bits=32 encoding=(none)
> 
> In the above btf encoding without enum64, all enum types
> with the same type size as the corresponding enum64. All these
> enum types have unsigned type (kflag = 0) which is required
> before kernel enum64 support.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  btf_encoder.c     | 67 +++++++++++++++++++++++++++++++++++------------
>  btf_encoder.h     |  2 +-
>  dwarf_loader.c    | 12 +++++++++
>  dwarves.h         |  4 ++-
>  dwarves_fprintf.c |  6 ++++-
>  pahole.c          | 10 ++++++-
>  6 files changed, 80 insertions(+), 21 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9e708e4..daa8e3b 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -144,6 +144,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_FLOAT]        = "FLOAT",
>  	[BTF_KIND_DECL_TAG]     = "DECL_TAG",
>  	[BTF_KIND_TYPE_TAG]     = "TYPE_TAG",
> +	[BTF_KIND_ENUM64]	= "ENUM64",
>  };
>  
>  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> @@ -490,34 +491,64 @@ static int32_t btf_encoder__add_struct(struct btf_encoder *encoder, uint8_t kind
>  	return id;
>  }
>  
> -static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const char *name, uint32_t bit_size)
> +static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const char *name, struct type *etype,
> +				     struct conf_load *conf_load)
>  {
>  	struct btf *btf = encoder->btf;
>  	const struct btf_type *t;
>  	int32_t id, size;
> +	bool is_enum32;
>  
> -	size = BITS_ROUNDUP_BYTES(bit_size);
> -	id = btf__add_enum(btf, name, size);
> +	size = BITS_ROUNDUP_BYTES(etype->size);
> +	is_enum32 = size <= 4 || conf_load->skip_encoding_btf_enum64;
> +	if (is_enum32)
> +		id = btf__add_enum(btf, name, size);
> +	else
> +		id = btf__add_enum64(btf, name, size, etype->is_signed_enum);
>  	if (id > 0) {
>  		t = btf__type_by_id(btf, id);
>  		btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
>  	} else {
> -		btf__log_err(btf, BTF_KIND_ENUM, name, true,
> +		btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, true,
>  			      "size=%u Error emitting BTF type", size);
>  	}
>  	return id;
>  }
>  
> -static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const char *name, int32_t value)
> +static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const char *name, int64_t value,
> +				     struct type *etype, struct conf_load *conf_load)
>  {
> -	int err = btf__add_enum_value(encoder->btf, name, value);
> +	const char *fmt_str;
> +	int err;
> +
> +	/* If enum64 is not allowed, generate enum32 with unsigned int value. In enum64-supported
> +	 * libbpf library, btf__add_enum_value() will set the kflag (sign bit) in common_type
> +	 * if the value is negative.
> +	 */
> +	if (conf_load->skip_encoding_btf_enum64)
> +		err = btf__add_enum_value(encoder->btf, name, (uint32_t)value);
> +	else if (etype->size > 32)
> +		err = btf__add_enum64_value(encoder->btf, name, value);
> +	else
> +		err = btf__add_enum_value(encoder->btf, name, value);
>  
>  	if (!err) {
> -		if (encoder->verbose)
> -			printf("\t%s val=%d\n", name, value);
> +		if (encoder->verbose) {
> +			if (conf_load->skip_encoding_btf_enum64) {
> +				printf("\t%s val=%u\n", name, (uint32_t)value);
> +			} else {
> +				fmt_str = etype->is_signed_enum ? "\t%s val=%lld\n" : "\t%s val=%llu\n";
> +				printf(fmt_str, name, (unsigned long long)value);
> +			}
> +		}
>  	} else {
> -		fprintf(stderr, "\t%s val=%d Error emitting BTF enum value\n",
> -			name, value);
> +		if (conf_load->skip_encoding_btf_enum64) {
> +			fprintf(stderr, "\t%s val=%u Error emitting BTF enum value\n", name, (uint32_t)value);
> +		} else {
> +			fmt_str = etype->is_signed_enum ? "\t%s val=%lld Error emitting BTF enum value\n"
> +							: "\t%s val=%llu Error emitting BTF enum value\n";
> +			fprintf(stderr, fmt_str, name, (unsigned long long)value);
> +		}
>  	}
>  	return err;
>  }
> @@ -844,27 +875,29 @@ static uint32_t array_type__nelems(struct tag *tag)
>  	return nelem;
>  }
>  
> -static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct tag *tag)
> +static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct tag *tag,
> +					  struct conf_load *conf_load)
>  {
>  	struct type *etype = tag__type(tag);
>  	struct enumerator *pos;
>  	const char *name = type__name(etype);
>  	int32_t type_id;
>  
> -	type_id = btf_encoder__add_enum(encoder, name, etype->size);
> +	type_id = btf_encoder__add_enum(encoder, name, etype, conf_load);
>  	if (type_id < 0)
>  		return type_id;
>  
>  	type__for_each_enumerator(etype, pos) {
>  		name = enumerator__name(pos);
> -		if (btf_encoder__add_enum_val(encoder, name, pos->value))
> +		if (btf_encoder__add_enum_val(encoder, name, pos->value, etype, conf_load))
>  			return -1;
>  	}
>  
>  	return type_id;
>  }
>  
> -static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag, uint32_t type_id_off)
> +static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag, uint32_t type_id_off,
> +				   struct conf_load *conf_load)
>  {
>  	/* single out type 0 as it represents special type "void" */
>  	uint32_t ref_type_id = tag->type == 0 ? 0 : type_id_off + tag->type;
> @@ -903,7 +936,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>  		encoder->need_index_type = true;
>  		return btf_encoder__add_array(encoder, ref_type_id, encoder->array_index_id, array_type__nelems(tag));
>  	case DW_TAG_enumeration_type:
> -		return btf_encoder__add_enum_type(encoder, tag);
> +		return btf_encoder__add_enum_type(encoder, tag, conf_load);
>  	case DW_TAG_subroutine_type:
>  		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
>  	default:
> @@ -1422,7 +1455,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	free(encoder);
>  }
>  
> -int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
> +int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
>  {
>  	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
>  	struct llvm_annotation *annot;
> @@ -1446,7 +1479,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>  	}
>  
>  	cu__for_each_type(cu, core_id, pos) {
> -		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off);
> +		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off, conf_load);
>  
>  		if (btf_type_id < 0 ||
>  		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
> diff --git a/btf_encoder.h b/btf_encoder.h
> index 339fae2..a65120c 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -21,7 +21,7 @@ void btf_encoder__delete(struct btf_encoder *encoder);
>  
>  int btf_encoder__encode(struct btf_encoder *encoder);
>  
> -int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu);
> +int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load);
>  
>  void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder);
>  
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index a0d964b..4767602 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -632,6 +632,18 @@ static void type__init(struct type *type, Dwarf_Die *die, struct cu *cu, struct
>  	type->resized		 = 0;
>  	type->nr_members	 = 0;
>  	type->nr_static_members	 = 0;
> +	type->is_signed_enum	 = 0;
> +
> +	Dwarf_Attribute attr;
> +	if (dwarf_attr(die, DW_AT_type, &attr) != NULL) {
> +		Dwarf_Die type_die;
> +		if (dwarf_formref_die(&attr, &type_die) != NULL) {
> +			uint64_t encoding = attr_numeric(&type_die, DW_AT_encoding);
> +
> +			if (encoding == DW_ATE_signed || encoding == DW_ATE_signed_char)
> +				type->is_signed_enum = 1;
> +		}
> +	}
>  }
>  
>  static struct type *type__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> diff --git a/dwarves.h b/dwarves.h
> index 4d0e4b6..bec9f08 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -65,6 +65,7 @@ struct conf_load {
>  	bool			skip_encoding_btf_decl_tag;
>  	bool			skip_missing;
>  	bool			skip_encoding_btf_type_tag;
> +	bool			skip_encoding_btf_enum64;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> @@ -1046,6 +1047,7 @@ struct type {
>  	uint8_t		 definition_emitted:1;
>  	uint8_t		 fwd_decl_emitted:1;
>  	uint8_t		 resized:1;
> +	uint8_t		 is_signed_enum:1;
>  };
>  
>  void __type__init(struct type *type);
> @@ -1365,7 +1367,7 @@ static inline struct string_type *tag__string_type(const struct tag *tag)
>  struct enumerator {
>  	struct tag	 tag;
>  	const char	 *name;
> -	uint32_t	 value;
> +	uint64_t	 value;
>  	struct tag_cu	 type_enum; // To cache the type_enum searches
>  };
>  
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 2cec584..ce64c79 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -437,7 +437,11 @@ size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *co
>  	type__for_each_enumerator(type, pos) {
>  		printed += fprintf(fp, "%.*s\t%-*s = ", indent, tabs,
>  				   max_entry_name_len, enumerator__name(pos));
> -		printed += fprintf(fp, conf->hex_fmt ?  "%#x" : "%u", pos->value);
> +		if (conf->hex_fmt)
> +			printed += fprintf(fp, "%#llx", (unsigned long long)pos->value);
> +		else
> +			printed += fprintf(fp, type->is_signed_enum ?  "%lld" : "%llu",
> +					   (unsigned long long)pos->value);
>  		printed += fprintf(fp, ",\n");
>  	}
>  
> diff --git a/pahole.c b/pahole.c
> index 78caa08..e87d9a4 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1220,6 +1220,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_compile		   334
>  #define ARGP_languages		   335
>  #define ARGP_languages_exclude	   336
> +#define ARGP_skip_encoding_btf_enum64 337
>  
>  static const struct argp_option pahole__options[] = {
>  	{
> @@ -1622,6 +1623,11 @@ static const struct argp_option pahole__options[] = {
>  		.arg  = "LANGUAGES",
>  		.doc  = "Don't consider compilation units written in these languages"
>  	},
> +	{
> +		.name = "skip_encoding_btf_enum64",
> +		.key  = ARGP_skip_encoding_btf_enum64,
> +		.doc  = "Do not encode ENUM64sin BTF."
> +	},
>  	{
>  		.name = NULL,
>  	}
> @@ -1787,6 +1793,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		/* fallthru */
>  	case ARGP_languages:
>  		languages.str = arg;			break;
> +	case ARGP_skip_encoding_btf_enum64:
> +		conf_load.skip_encoding_btf_enum64 = true;	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> @@ -3067,7 +3075,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>  			encoder = btf_encoder;
>  		}
>  
> -		if (btf_encoder__encode_cu(encoder, cu)) {
> +		if (btf_encoder__encode_cu(encoder, cu, conf_load)) {
>  			fprintf(stderr, "Encountered error while encoding BTF.\n");
>  			exit(1);
>  		}
> -- 
> 2.30.2

-- 

- Arnaldo
