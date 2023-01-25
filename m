Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67F867BEA0
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjAYVei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjAYVeh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:34:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50075D914
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:34:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so18384182wru.13
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iPqZub1ckLcG09C/ymeebTPOcq3aAOsJ46vh+xGkv1s=;
        b=qPEBlKloLuMkGgk/LJn1kVN0r7JXHbuyHx1uxvHGiVpHqBWH6H3LfqYiAZJPLXxSee
         JmdNsIcXnXB1JUJ7r4FYtfVJB4ngDWwzaBGSP4Zng6+QNOBebxKK0F7+nAvKWciBGEG4
         2vQQiX9COuBql3mwDCLQnp8h/0XeTMX+CZdUPPPm+n2Uw+YzoB12VRaqNzfyCxIjhciF
         Yf1g8yMXmsPrbY+6zt0Qwg2WkfCkso2W3t7VfXVPpxDewdKRAyHPttQnj6BWp9F1FIjC
         K7w4hPHYv/DKV0enEB6bZ3ilh2XVt0T1E6+D36wHiGbzb4EEa+uqoaJRrZxWa6IY+uzf
         hIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPqZub1ckLcG09C/ymeebTPOcq3aAOsJ46vh+xGkv1s=;
        b=xgE0ZMudbZFIJ757gidUatPTAvCItEIMPUw59Xlv8R4qt7ylCcJwftQop3LXpe8PwY
         NL6SeZVcyIKquk7bRf/HGHO9M8ZwyPaARzGeu/aQuL5KNaG6q5RyjQAw1UUgrqu4lFF7
         jTqZHubEPlrcGErsWa6hqpI7bce38MajGWunvJanoKWzWsVFdoSYuFla8Cy8bc2eoxvL
         qTqmithuMSmLMSSaSwDIQDeVpgREJMeE5Tr5n4+HJ28zKm4/zlE4nIOtuCmr/3PtqBXP
         469xZPz/oox4JX7dqKTJuGPsbdfrokBN1mOgotopdsGrkMTRVO9/IoluUApiMM+LlyDw
         TPqw==
X-Gm-Message-State: AFqh2kpmDy34ossKkNiU6C4QTaVM3qvFQiTtuINMOyjx5/zOAXm6+T6y
        MbqGbDx0YhC3Bl7pd2CYNvorOVDDhP6klA==
X-Google-Smtp-Source: AMrXdXvH8iz2HNyg0bqti0ExN4c3xt8/n2JI1XpWQxU3n0NUiQLVanIvU36jw8UCGAyAO/LDFCbTaQ==
X-Received: by 2002:a5d:5256:0:b0:2be:3503:2dce with SMTP id k22-20020a5d5256000000b002be35032dcemr25084796wrc.35.1674682446906;
        Wed, 25 Jan 2023 13:34:06 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d6501000000b002bfb31bda06sm4193950wru.76.2023.01.25.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:34:06 -0800 (PST)
Message-ID: <f23eb6cfe20966d7b417f29ec782f78fa0ab93d5.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
        yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Date:   Wed, 25 Jan 2023 23:34:04 +0200
In-Reply-To: <3ca14d5e-5466-fb4e-b024-01ba33370372@oracle.com>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
         <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
         <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
         <3ca14d5e-5466-fb4e-b024-01ba33370372@oracle.com>
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

On Wed, 2023-01-25 at 18:28 +0000, Alan Maguire wrote:
> On 25/01/2023 17:47, Eduard Zingerman wrote:
> > On Tue, 2023-01-24 at 13:45 +0000, Alan Maguire wrote:
> > > Compilation generates DWARF at several stages, and often the
> > > later DWARF representations more accurately represent optimizations
> > > that have occurred during compilation.
> > >=20
> > > In particular, parameter representations can be spotted by their
> > > abstract origin references to the original parameter, but they
> > > often have more accurate location information.  In most cases,
> > > the parameter locations will match calling conventions, and be
> > > registers for the first 6 parameters on x86_64, first 8 on ARM64
> > > etc.  If the parameter is not a register when it should be however,
> > > it is likely passed via the stack or the compiler has used a
> > > constant representation instead.
> > >=20
> > > This change adds a field to parameters and their associated
> > > ftype to note if a parameter has been optimized out.  Having
> > > this information allows us to skip such functions, as their
> > > presence in CUs makes BTF encoding impossible.
> > >=20
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > ---
> > >  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++--
> > >  dwarves.h      |  4 +++-
> > >  2 files changed, 77 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > index 5a74035..0220f1d 100644
> > > --- a/dwarf_loader.c
> > > +++ b/dwarf_loader.c
> > > @@ -992,13 +992,67 @@ static struct class_member *class_member__new(D=
warf_Die *die, struct cu *cu,
> > >  	return member;
> > >  }
> > > =20
> > > -static struct parameter *parameter__new(Dwarf_Die *die, struct cu *c=
u, struct conf_load *conf)
> > > +/* How many function parameters are passed via registers?  Used belo=
w in
> > > + * determining if an argument has been optimized out or if it is sim=
ply
> > > + * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to =
0
> > > + * allows unsupported architectures to skip tagging optimized-out
> > > + * values.
> > > + */
> > > +#if defined(__x86_64__)
> > > +#define NR_REGISTER_PARAMS      6
> > > +#elif defined(__s390__)
> > > +#define NR_REGISTER_PARAMS	5
> > > +#elif defined(__aarch64__)
> > > +#define NR_REGISTER_PARAMS      8
> > > +#elif defined(__mips__)
> > > +#define NR_REGISTER_PARAMS	8
> > > +#elif defined(__powerpc__)
> > > +#define NR_REGISTER_PARAMS	8
> > > +#elif defined(__sparc__)
> > > +#define NR_REGISTER_PARAMS	6
> > > +#elif defined(__riscv) && __riscv_xlen =3D=3D 64
> > > +#define NR_REGISTER_PARAMS	8
> > > +#elif defined(__arc__)
> > > +#define NR_REGISTER_PARAMS	8
> > > +#else
> > > +#define NR_REGISTER_PARAMS      0
> > > +#endif
> > > +
> > > +static struct parameter *parameter__new(Dwarf_Die *die, struct cu *c=
u,
> > > +					struct conf_load *conf, int param_idx)
> > >  {
> > >  	struct parameter *parm =3D tag__alloc(cu, sizeof(*parm));
> > > =20
> > >  	if (parm !=3D NULL) {
> > > +		struct location loc;
> > > +
> > >  		tag__init(&parm->tag, cu, die);
> > >  		parm->name =3D attr_string(die, DW_AT_name, conf);
> > > +
> > > +		/* Parameters which use DW_AT_abstract_origin to point at
> > > +		 * the original parameter definition (with no name in the DIE)
> > > +		 * are the result of later DWARF generation during compilation
> > > +		 * so often better take into account if arguments were
> > > +		 * optimized out.
> > > +		 *
> > > +		 * By checking that locations for parameters that are expected
> > > +		 * to be passed as registers are actually passed as registers,
> > > +		 * we can spot optimized-out parameters.
> > > +		 */
> > > +		if (param_idx < NR_REGISTER_PARAMS && !parm->name &&
> > > +		    attr_location(die, &loc.expr, &loc.exprlen) =3D=3D 0 &&
> > > +		    loc.exprlen !=3D 0) {
> > > +			Dwarf_Op *expr =3D loc.expr;
> > > +
> > > +			switch (expr->atom) {
> > > +			case DW_OP_reg1 ... DW_OP_reg31:
> > > +			case DW_OP_breg0 ... DW_OP_breg31:
> > > +				break;
> > > +			default:
> > > +				parm->optimized =3D true;
> > > +				break;
> > > +			}
> > > +		}
> >=20
> > Hi Alan,
> >=20
> > I looked through the DWARF standard and found two relevant entries:
> >=20
> > > 4.1.4
> > >=20
> > > If no location attribute is present in a variable entry representing
> > > the definition of a variable (...), or if the location attribute is
> > > present but has an empty location description (...), the variable is
> > > assumed to exist in the source code but not in the executable program
> > > (but see number 10, below).
> >=20
> > This paragraph implies that parameter name presence or absence is
> > irrelevant, but I don't have any examples when parameter name is
> > present for a removed parameter.
> >=20
> > > 4.1.10
> > >=20
> > > A DW_AT_const_value attribute for an entry describing a variable or f=
ormal
> > > parameter whose value is constant and not represented by an object in=
 the
> > > address space of the program, or an entry describing a named constant=
. (Note
> > > that such an entry does not have a location attribute.)
> >=20
> > For this paragraph I have an example:
> >=20
> >     $ cat test.c
> >     __attribute__((noinline))
> >     static int f(int x, int y) {
> >         return x + y;
> >     }
> >    =20
> >     int main(int argc, char *argv[]) {
> >         return f(1, 2) + f(1, 3);
> >     }
> >    =20
> >     $ gcc --version | head -n1
> >     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
> >     $ gcc -O2 -g -c test.c -o test.o
> >    =20
> > The objdump shows that constant propagation removed the first
> > parameter of the function `f`:
> >=20
> >     $ llvm-objdump -d test.o=20
> >    =20
> >     test.o:	file format elf64-x86-64
> >    =20
> >     Disassembly of section .text:
> >    =20
> >     0000000000000000 <f.constprop.0>:
> >            0: 8d 47 01                     	leal	0x1(%rdi), %eax
> >            3: c3                           	retq
> >    =20
> >     Disassembly of section .text.startup:
> >    =20
> >     0000000000000000 <main>:
> >            0: f3 0f 1e fa                  	endbr64
> >            4: bf 02 00 00 00               	movl	$0x2, %edi
> >            9: e8 00 00 00 00               	callq	0xe <main+0xe>
> >            e: bf 03 00 00 00               	movl	$0x3, %edi
> >           13: 89 c2                        	movl	%eax, %edx
> >           15: e8 00 00 00 00               	callq	0x1a <main+0x1a>
> >           1a: 01 d0                        	addl	%edx, %eax
> >           1c: c3                           	retq
> >    =20
> > However, the information about this parameter is still present in the D=
WARF:
> >=20
> >     $ llvm-dwarfdump test.o
> >     ...
> >     0x000000c1:   DW_TAG_subprogram
> >                     DW_AT_name	("f")
> >                     DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
> >                     DW_AT_decl_line	(2)
> >                     DW_AT_decl_column	(0x0c)
> >                     DW_AT_prototyped	(true)
> >                     DW_AT_type	(0x000000a9 "int")
> >                     DW_AT_inline	(DW_INL_inlined)
> >                     DW_AT_sibling	(0x000000e1)
> >    =20
> >     0x000000d0:     DW_TAG_formal_parameter
> >                       DW_AT_name	("x")
> >                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
> >                       DW_AT_decl_line	(2)
> >                       DW_AT_decl_column	(0x12)
> >                       DW_AT_type	(0x000000a9 "int")
> >    =20
> >     0x000000d8:     DW_TAG_formal_parameter
> >                       DW_AT_name	("y")
> >                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
> >                       DW_AT_decl_line	(2)
> >                       DW_AT_decl_column	(0x19)
> >                       DW_AT_type	(0x000000a9 "int")
> >    =20
> >     0x000000e0:     NULL
> >    =20
> >     0x000000e1:   DW_TAG_subprogram
> >                     DW_AT_abstract_origin	(0x000000c1 "f")
> >                     DW_AT_low_pc	(0x0000000000000000)
> >                     DW_AT_high_pc	(0x0000000000000004)
> >                     DW_AT_frame_base	(DW_OP_call_frame_cfa)
> >                     DW_AT_call_all_calls	(true)
> >    =20
> >     0x000000f8:     DW_TAG_formal_parameter
> >                       DW_AT_abstract_origin	(0x000000d8 "y")
> >                       DW_AT_location	(DW_OP_reg5 RDI)
> >    =20
> >     0x000000ff:     DW_TAG_formal_parameter
> >                       DW_AT_abstract_origin	(0x000000d0 "x")
> >                       DW_AT_const_value	(0x01)
> >    =20
> >     0x00000105:     NULL
> >    =20
> > When I ask pahole with this patch-set applied to generate BTF I see
> > the following output:
> >=20
> >     $ pahole --verbose --btf_encode_detached=3Dtest.btf test.o
> >     btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
> >     Found 0 per-CPU variables!
> >     Found 2 functions!
> >     File test.o:
> >     [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
> >     [2] PTR (anon) type_id=3D3
> >     [3] PTR (anon) type_id=3D4
> >     [4] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED
> >     [5] FUNC_PROTO (anon) return=3D1 args=3D(1 argc, 2 argv)
> >     [6] FUNC main type_id=3D5
> >     matched function 'f' with 'f.constprop.0'
> >     added local function 'f'
> >     matched function 'f' with 'f.constprop.0'
> >     [7] FUNC_PROTO (anon) return=3D1 args=3D(1 x, 1 y)
> >     [8] FUNC f type_id=3D7
> >    =20
> > Meaning that function `f` had not been skipped.
> > A trivial modification overcomes this:
> >=20
> > 		if (param_idx < NR_REGISTER_PARAMS && !parm->name) {
> > 			if (attr_location(die, &loc.expr, &loc.exprlen) =3D=3D 0 &&
> > 			    loc.exprlen !=3D 0) {
> > 				Dwarf_Op *expr =3D loc.expr;
> >=20
> > 				switch (expr->atom) {
> > 				case DW_OP_reg1 ... DW_OP_reg31:
> > 				case DW_OP_breg0 ... DW_OP_breg31:
> > 					break;
> > 				default:
> > 					parm->optimized =3D true;
> > 					break;
> > 				}
> > 			} else if (dwarf_attr(die, DW_AT_const_value, &attr) !=3D NULL) {
> > 					parm->optimized =3D true;
> > 			}
> >=20
> > With it pahole seem to work as intended (if I understand the intention =
correctly):
> >=20
> >     $ pahole --verbose --btf_encode_detached=3Dtest.btf test.o
> >     btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
> >     Found 0 per-CPU variables!
> >     Found 2 functions!
> >     File test.o:
> >     [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
> >     [2] PTR (anon) type_id=3D3
> >     [3] PTR (anon) type_id=3D4
> >     [4] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED
> >     [5] FUNC_PROTO (anon) return=3D1 args=3D(1 argc, 2 argv)
> >     [6] FUNC main type_id=3D5
> >     matched function 'f' with 'f.constprop.0', has optimized-out parame=
ters
> >     added local function 'f', optimized-out params
> >     matched function 'f' with 'f.constprop.0', has optimized-out parame=
ters
> >     skipping addition of 'f' due to optimized-out parameters
> >=20
> > wdyt?
> >=20
>=20
> This is great, thanks Eduard! I can add an additional patch
> for the else clause code above, attributing that to you in v2 if
> you like?
>=20
> Alan
>=20

More on this topic. I tried the same example but with clang,
DWARF generated by clang differs significantly.

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
    $ clang --version | head -n1
    clang version 16.0.0 (https://github.com/llvm/llvm-project.git 50d4a1f7=
0e111cd41b1a94d95fd06b5691aa2643)
   =20
    $ clang -O2 -g -c test.c -o test.o

llvm-objdump shows that the first parameter is still optimized out:

    $ llvm-objdump -d test.o=20
   =20
    test.o:	file format elf64-x86-64
   =20
    Disassembly of section .text:
   =20
    0000000000000000 <main>:
           0: 53                           	pushq	%rbx
           1: bf 02 00 00 00               	movl	$0x2, %edi
           6: e8 15 00 00 00               	callq	0x20 <f>
           b: 89 c3                        	movl	%eax, %ebx
           d: bf 03 00 00 00               	movl	$0x3, %edi
          12: e8 09 00 00 00               	callq	0x20 <f>
          17: 01 d8                        	addl	%ebx, %eax
          19: 5b                           	popq	%rbx
          1a: c3                           	retq
          1b: 0f 1f 44 00 00               	nopl	(%rax,%rax)
   =20
    0000000000000020 <f>:
          20: 8d 47 01                     	leal	0x1(%rdi), %eax
          23: c3                           	retq

And here is the DWARF, note that formal parameter has both
`DW_AT_name` and `DW_AT_const_value` attributes:

    $ llvm-dwarfdump test.o
    ...
    0x00000061:   DW_TAG_subprogram
                    DW_AT_low_pc	(0x0000000000000020)
                    DW_AT_high_pc	(0x0000000000000024)
                    DW_AT_frame_base	(DW_OP_reg7 RSP)
                    DW_AT_call_all_calls	(true)
                    DW_AT_name	("f")
                    DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                    DW_AT_decl_line	(2)
                    DW_AT_prototyped	(true)
                    DW_AT_calling_convention	(DW_CC_nocall)
                    DW_AT_type	(0x00000085 "int")
   =20
    0x00000071:     DW_TAG_formal_parameter
                      DW_AT_const_value	(1)
                      DW_AT_name	("x")
                      DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                      DW_AT_decl_line	(2)
                      DW_AT_type	(0x00000085 "int")
   =20
    0x0000007a:     DW_TAG_formal_parameter
                      DW_AT_location	(DW_OP_reg5 RDI)
                      DW_AT_name	("y")
                      DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                      DW_AT_decl_line	(2)
                      DW_AT_type	(0x00000085 "int")
   =20
    0x00000084:     NULL
    ...

Given this DWARF layout pahole does not recognize `x` as optimized out:

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
    [7] FUNC_PROTO (anon) return=3D1 args=3D(1 x, 1 y)
    [8] FUNC f type_id=3D7

The way I read paragraph 4.1.4 mentioned before the tag `DW_AT_name`
should not be used to identify whether parameter is optimized out.
Unfortunately trivial modification of the condition in the
`parameter__new()` to remove the `!parm->name` check is not
sufficient. For some reason parameters `x` and `y` are not visited in
`ftype__recode_dwarf_types()` and thus `optimized_parms` field is not set.

Thanks,
Eduard



> > Thanks,
> > Eduard
> >=20
> > > =20
> > >  	return parm;
> > > @@ -1450,7 +1504,7 @@ static struct tag *die__create_new_parameter(Dw=
arf_Die *die,
> > >  					     struct cu *cu, struct conf_load *conf,
> > >  					     int param_idx)
> > >  {
> > > -	struct parameter *parm =3D parameter__new(die, cu, conf);
> > > +	struct parameter *parm =3D parameter__new(die, cu, conf, param_idx)=
;
> > > =20
> > >  	if (parm =3D=3D NULL)
> > >  		return NULL;
> > > @@ -2209,6 +2263,10 @@ static void ftype__recode_dwarf_types(struct t=
ag *tag, struct cu *cu)
> > >  			}
> > >  			pos->name =3D tag__parameter(dtype->tag)->name;
> > >  			pos->tag.type =3D dtype->tag->type;
> > > +			if (pos->optimized) {
> > > +				tag__parameter(dtype->tag)->optimized =3D pos->optimized;
> > > +				type->optimized_parms =3D 1;
> > > +			}
> > >  			continue;
> > >  		}
> > > =20
> > > @@ -2219,6 +2277,20 @@ static void ftype__recode_dwarf_types(struct t=
ag *tag, struct cu *cu)
> > >  		}
> > >  		pos->tag.type =3D dtype->small_id;
> > >  	}
> > > +	/* if parameters were optimized out, set flag for the ftype this
> > > +	 * function tag referred to via abstract origin.
> > > +	 */
> > > +	if (type->optimized_parms) {
> > > +		struct dwarf_tag *dtype =3D type->tag.priv;
> > > +		struct dwarf_tag *dftype;
> > > +
> > > +		dftype =3D dwarf_cu__find_tag_by_ref(dcu, &dtype->abstract_origin)=
;
> > > +		if (dftype && dftype->tag) {
> > > +			struct ftype *ftype =3D tag__ftype(dftype->tag);
> > > +
> > > +			ftype->optimized_parms =3D 1;
> > > +		}
> > > +	}
> > >  }
> > > =20
> > >  static void lexblock__recode_dwarf_types(struct lexblock *tag, struc=
t cu *cu)
> > > diff --git a/dwarves.h b/dwarves.h
> > > index 589588e..1ad1b3b 100644
> > > --- a/dwarves.h
> > > +++ b/dwarves.h
> > > @@ -808,6 +808,7 @@ size_t lexblock__fprintf(const struct lexblock *l=
exblock, const struct cu *cu,
> > >  struct parameter {
> > >  	struct tag tag;
> > >  	const char *name;
> > > +	bool optimized;
> > >  };
> > > =20
> > >  static inline struct parameter *tag__parameter(const struct tag *tag=
)
> > > @@ -827,7 +828,8 @@ struct ftype {
> > >  	struct tag	 tag;
> > >  	struct list_head parms;
> > >  	uint16_t	 nr_parms;
> > > -	uint8_t		 unspec_parms; /* just one bit is needed */
> > > +	uint8_t		 unspec_parms:1; /* just one bit is needed */
> > > +	uint8_t		 optimized_parms:1;
> > >  };
> > > =20
> > >  static inline struct ftype *tag__ftype(const struct tag *tag)
> >=20

