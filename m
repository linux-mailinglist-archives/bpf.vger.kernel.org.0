Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404F767B8CB
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjAYRrY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 12:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjAYRrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 12:47:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D8B77C
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 09:47:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k16so14366222wms.2
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eH8qRdXeHZNLzP9pQ7sk1Koa74P/ieP9nrGmNPyIMew=;
        b=kVrrfrNf/PILFwtanOCPInWjOcI0Ci4uZFyVTQLft2xBcswJdf+p/+hXBgBIssU1qW
         daIwdP5yDdt6HVehoHbYJ6Ihnl5WxApxbrdH1V8ZMcdDDwyWuQ7b5WO2nwPUxvJXJYGn
         L9IRVvl9FT8pLECzcfgHlWhlS0fldQ63csnPAy5k2IfX6cYRP6dWIm3HiXi9hNRO8Ho3
         d0LCgHzNdLQjZqHKXIjZ2v8K9L3nl9eNb2lRgiS0ot78izaSd+dupYYVh+285shiIlQi
         8yM/FkWOXbWm+lhcfohAv2+1/+BJyHzHAWkG+cXkXWHJN0/OIpi/C3TpKDJ0pC0A7crI
         jxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eH8qRdXeHZNLzP9pQ7sk1Koa74P/ieP9nrGmNPyIMew=;
        b=D0GcAgHUUri07ovAyuwInSM88ZnB5jbo/eBzlfkpp9HxO+fffD78KF2I56e9vyGy5e
         2NEPNoOmeJ6xagJ//ERVL1dTZ3DBrGTK3LbpFhOJw4UwfPOtVusEuqreVpeqHSJwM05q
         afD6dZLdJCRZlAYteb7PVIf+ftFvN8t76aLXYAiNbCQ/YG44PfhREDbW8/D4UfFfZ7lc
         mvq01JsBus+rMFeoodgi3D9XdG7ubDjG2DoDooD+zB3ZH6HvnCT9/iGl7JzYeocYMOAx
         l7tJ9rI1V9zelmBIs5l71HyXHAiQ/2jv36Pc8DGcOJ9f3tL3EOAhbb9Gwd2/x2x05Skb
         jN9g==
X-Gm-Message-State: AFqh2kqIjYlTQrHqxL9usiqKo3g53/+aKV2sRaaQS+4ek9+Uvxnl59vt
        BHqjzcbQsiqkGCpdEsKPV5U=
X-Google-Smtp-Source: AMrXdXveuQ7VkiNdZjsLqUB7S+j/jm8uFWaeknTAjq1/mCMSJyQIiH+tvY26+KG1dNQzW/WJYWDGFw==
X-Received: by 2002:a05:600c:b85:b0:3cf:ae53:9193 with SMTP id fl5-20020a05600c0b8500b003cfae539193mr32026859wmb.39.1674668839986;
        Wed, 25 Jan 2023 09:47:19 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y35-20020a05600c342300b003dc16d2afc9sm2418590wmp.10.2023.01.25.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:47:19 -0800 (PST)
Message-ID: <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
        yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Date:   Wed, 25 Jan 2023 19:47:18 +0200
In-Reply-To: <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
         <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-01-24 at 13:45 +0000, Alan Maguire wrote:
> Compilation generates DWARF at several stages, and often the
> later DWARF representations more accurately represent optimizations
> that have occurred during compilation.
>=20
> In particular, parameter representations can be spotted by their
> abstract origin references to the original parameter, but they
> often have more accurate location information.  In most cases,
> the parameter locations will match calling conventions, and be
> registers for the first 6 parameters on x86_64, first 8 on ARM64
> etc.  If the parameter is not a register when it should be however,
> it is likely passed via the stack or the compiler has used a
> constant representation instead.
>=20
> This change adds a field to parameters and their associated
> ftype to note if a parameter has been optimized out.  Having
> this information allows us to skip such functions, as their
> presence in CUs makes BTF encoding impossible.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  dwarves.h      |  4 +++-
>  2 files changed, 77 insertions(+), 3 deletions(-)
>=20
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 5a74035..0220f1d 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -992,13 +992,67 @@ static struct class_member *class_member__new(Dwarf=
_Die *die, struct cu *cu,
>  	return member;
>  }
> =20
> -static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, s=
truct conf_load *conf)
> +/* How many function parameters are passed via registers?  Used below in
> + * determining if an argument has been optimized out or if it is simply
> + * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
> + * allows unsupported architectures to skip tagging optimized-out
> + * values.
> + */
> +#if defined(__x86_64__)
> +#define NR_REGISTER_PARAMS      6
> +#elif defined(__s390__)
> +#define NR_REGISTER_PARAMS	5
> +#elif defined(__aarch64__)
> +#define NR_REGISTER_PARAMS      8
> +#elif defined(__mips__)
> +#define NR_REGISTER_PARAMS	8
> +#elif defined(__powerpc__)
> +#define NR_REGISTER_PARAMS	8
> +#elif defined(__sparc__)
> +#define NR_REGISTER_PARAMS	6
> +#elif defined(__riscv) && __riscv_xlen =3D=3D 64
> +#define NR_REGISTER_PARAMS	8
> +#elif defined(__arc__)
> +#define NR_REGISTER_PARAMS	8
> +#else
> +#define NR_REGISTER_PARAMS      0
> +#endif
> +
> +static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> +					struct conf_load *conf, int param_idx)
>  {
>  	struct parameter *parm =3D tag__alloc(cu, sizeof(*parm));
> =20
>  	if (parm !=3D NULL) {
> +		struct location loc;
> +
>  		tag__init(&parm->tag, cu, die);
>  		parm->name =3D attr_string(die, DW_AT_name, conf);
> +
> +		/* Parameters which use DW_AT_abstract_origin to point at
> +		 * the original parameter definition (with no name in the DIE)
> +		 * are the result of later DWARF generation during compilation
> +		 * so often better take into account if arguments were
> +		 * optimized out.
> +		 *
> +		 * By checking that locations for parameters that are expected
> +		 * to be passed as registers are actually passed as registers,
> +		 * we can spot optimized-out parameters.
> +		 */
> +		if (param_idx < NR_REGISTER_PARAMS && !parm->name &&
> +		    attr_location(die, &loc.expr, &loc.exprlen) =3D=3D 0 &&
> +		    loc.exprlen !=3D 0) {
> +			Dwarf_Op *expr =3D loc.expr;
> +
> +			switch (expr->atom) {
> +			case DW_OP_reg1 ... DW_OP_reg31:
> +			case DW_OP_breg0 ... DW_OP_breg31:
> +				break;
> +			default:
> +				parm->optimized =3D true;
> +				break;
> +			}
> +		}

Hi Alan,

I looked through the DWARF standard and found two relevant entries:

> 4.1.4
>=20
> If no location attribute is present in a variable entry representing
> the definition of a variable (...), or if the location attribute is
> present but has an empty location description (...), the variable is
> assumed to exist in the source code but not in the executable program
> (but see number 10, below).

This paragraph implies that parameter name presence or absence is
irrelevant, but I don't have any examples when parameter name is
present for a removed parameter.

> 4.1.10
>=20
> A DW_AT_const_value attribute for an entry describing a variable or forma=
l
> parameter whose value is constant and not represented by an object in the
> address space of the program, or an entry describing a named constant. (N=
ote
> that such an entry does not have a location attribute.)

For this paragraph I have an example:

    $ cat test.c
    __attribute__((noinline))
    static int f(int x, int y) {
        return x + y;
    }
   =20
    int main(int argc, char *argv[]) {
        return f(1, 2) + f(1, 3);
    }
   =20
    $ gcc --version | head -n1
    gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
    $ gcc -O2 -g -c test.c -o test.o
   =20
The objdump shows that constant propagation removed the first
parameter of the function `f`:

    $ llvm-objdump -d test.o=20
   =20
    test.o:	file format elf64-x86-64
   =20
    Disassembly of section .text:
   =20
    0000000000000000 <f.constprop.0>:
           0: 8d 47 01                     	leal	0x1(%rdi), %eax
           3: c3                           	retq
   =20
    Disassembly of section .text.startup:
   =20
    0000000000000000 <main>:
           0: f3 0f 1e fa                  	endbr64
           4: bf 02 00 00 00               	movl	$0x2, %edi
           9: e8 00 00 00 00               	callq	0xe <main+0xe>
           e: bf 03 00 00 00               	movl	$0x3, %edi
          13: 89 c2                        	movl	%eax, %edx
          15: e8 00 00 00 00               	callq	0x1a <main+0x1a>
          1a: 01 d0                        	addl	%edx, %eax
          1c: c3                           	retq
   =20
However, the information about this parameter is still present in the DWARF=
:

    $ llvm-dwarfdump test.o
    ...
    0x000000c1:   DW_TAG_subprogram
                    DW_AT_name	("f")
                    DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                    DW_AT_decl_line	(2)
                    DW_AT_decl_column	(0x0c)
                    DW_AT_prototyped	(true)
                    DW_AT_type	(0x000000a9 "int")
                    DW_AT_inline	(DW_INL_inlined)
                    DW_AT_sibling	(0x000000e1)
   =20
    0x000000d0:     DW_TAG_formal_parameter
                      DW_AT_name	("x")
                      DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                      DW_AT_decl_line	(2)
                      DW_AT_decl_column	(0x12)
                      DW_AT_type	(0x000000a9 "int")
   =20
    0x000000d8:     DW_TAG_formal_parameter
                      DW_AT_name	("y")
                      DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                      DW_AT_decl_line	(2)
                      DW_AT_decl_column	(0x19)
                      DW_AT_type	(0x000000a9 "int")
   =20
    0x000000e0:     NULL
   =20
    0x000000e1:   DW_TAG_subprogram
                    DW_AT_abstract_origin	(0x000000c1 "f")
                    DW_AT_low_pc	(0x0000000000000000)
                    DW_AT_high_pc	(0x0000000000000004)
                    DW_AT_frame_base	(DW_OP_call_frame_cfa)
                    DW_AT_call_all_calls	(true)
   =20
    0x000000f8:     DW_TAG_formal_parameter
                      DW_AT_abstract_origin	(0x000000d8 "y")
                      DW_AT_location	(DW_OP_reg5 RDI)
   =20
    0x000000ff:     DW_TAG_formal_parameter
                      DW_AT_abstract_origin	(0x000000d0 "x")
                      DW_AT_const_value	(0x01)
   =20
    0x00000105:     NULL
   =20
When I ask pahole with this patch-set applied to generate BTF I see
the following output:

    $ pahole --verbose --btf_encode_detached=3Dtest.btf test.o
    btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
    Found 0 per-CPU variables!
    Found 2 functions!
    File test.o:
    [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
    [2] PTR (anon) type_id=3D3
    [3] PTR (anon) type_id=3D4
    [4] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED
    [5] FUNC_PROTO (anon) return=3D1 args=3D(1 argc, 2 argv)
    [6] FUNC main type_id=3D5
    matched function 'f' with 'f.constprop.0'
    added local function 'f'
    matched function 'f' with 'f.constprop.0'
    [7] FUNC_PROTO (anon) return=3D1 args=3D(1 x, 1 y)
    [8] FUNC f type_id=3D7
   =20
Meaning that function `f` had not been skipped.
A trivial modification overcomes this:

		if (param_idx < NR_REGISTER_PARAMS && !parm->name) {
			if (attr_location(die, &loc.expr, &loc.exprlen) =3D=3D 0 &&
			    loc.exprlen !=3D 0) {
				Dwarf_Op *expr =3D loc.expr;

				switch (expr->atom) {
				case DW_OP_reg1 ... DW_OP_reg31:
				case DW_OP_breg0 ... DW_OP_breg31:
					break;
				default:
					parm->optimized =3D true;
					break;
				}
			} else if (dwarf_attr(die, DW_AT_const_value, &attr) !=3D NULL) {
					parm->optimized =3D true;
			}

With it pahole seem to work as intended (if I understand the intention corr=
ectly):

    $ pahole --verbose --btf_encode_detached=3Dtest.btf test.o
    btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
    Found 0 per-CPU variables!
    Found 2 functions!
    File test.o:
    [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
    [2] PTR (anon) type_id=3D3
    [3] PTR (anon) type_id=3D4
    [4] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED
    [5] FUNC_PROTO (anon) return=3D1 args=3D(1 argc, 2 argv)
    [6] FUNC main type_id=3D5
    matched function 'f' with 'f.constprop.0', has optimized-out parameters
    added local function 'f', optimized-out params
    matched function 'f' with 'f.constprop.0', has optimized-out parameters
    skipping addition of 'f' due to optimized-out parameters

wdyt?

Thanks,
Eduard

> =20
>  	return parm;
> @@ -1450,7 +1504,7 @@ static struct tag *die__create_new_parameter(Dwarf_=
Die *die,
>  					     struct cu *cu, struct conf_load *conf,
>  					     int param_idx)
>  {
> -	struct parameter *parm =3D parameter__new(die, cu, conf);
> +	struct parameter *parm =3D parameter__new(die, cu, conf, param_idx);
> =20
>  	if (parm =3D=3D NULL)
>  		return NULL;
> @@ -2209,6 +2263,10 @@ static void ftype__recode_dwarf_types(struct tag *=
tag, struct cu *cu)
>  			}
>  			pos->name =3D tag__parameter(dtype->tag)->name;
>  			pos->tag.type =3D dtype->tag->type;
> +			if (pos->optimized) {
> +				tag__parameter(dtype->tag)->optimized =3D pos->optimized;
> +				type->optimized_parms =3D 1;
> +			}
>  			continue;
>  		}
> =20
> @@ -2219,6 +2277,20 @@ static void ftype__recode_dwarf_types(struct tag *=
tag, struct cu *cu)
>  		}
>  		pos->tag.type =3D dtype->small_id;
>  	}
> +	/* if parameters were optimized out, set flag for the ftype this
> +	 * function tag referred to via abstract origin.
> +	 */
> +	if (type->optimized_parms) {
> +		struct dwarf_tag *dtype =3D type->tag.priv;
> +		struct dwarf_tag *dftype;
> +
> +		dftype =3D dwarf_cu__find_tag_by_ref(dcu, &dtype->abstract_origin);
> +		if (dftype && dftype->tag) {
> +			struct ftype *ftype =3D tag__ftype(dftype->tag);
> +
> +			ftype->optimized_parms =3D 1;
> +		}
> +	}
>  }
> =20
>  static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu=
 *cu)
> diff --git a/dwarves.h b/dwarves.h
> index 589588e..1ad1b3b 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -808,6 +808,7 @@ size_t lexblock__fprintf(const struct lexblock *lexbl=
ock, const struct cu *cu,
>  struct parameter {
>  	struct tag tag;
>  	const char *name;
> +	bool optimized;
>  };
> =20
>  static inline struct parameter *tag__parameter(const struct tag *tag)
> @@ -827,7 +828,8 @@ struct ftype {
>  	struct tag	 tag;
>  	struct list_head parms;
>  	uint16_t	 nr_parms;
> -	uint8_t		 unspec_parms; /* just one bit is needed */
> +	uint8_t		 unspec_parms:1; /* just one bit is needed */
> +	uint8_t		 optimized_parms:1;
>  };
> =20
>  static inline struct ftype *tag__ftype(const struct tag *tag)

