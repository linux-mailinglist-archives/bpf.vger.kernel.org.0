Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC467CF21
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjAZPCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 10:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZPCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 10:02:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076BE62273
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 07:02:39 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h24so3434723lfv.6
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t+74miiB9RKr04H49tPYJz56NRSxtaWdXWHLUCCNDUE=;
        b=jK44M9BdD7PD6ieEDC52s+WNM835sOLvh4T9jHC9mmr8gjaAiznN5cvJSVrHX5aH8k
         iwzKvVaCIIwhrZ0BWpXIduhvQxZgnUgdiNgzE9AyqZkNseAWF8sNRT+wuDPR+LJiisYG
         SbpefxJa2tgwg0zwWxt6skOlKqSp9J1ZJUfUnRs9GqnmWhIEqaINzOykrFqW7eBA1e4F
         q/qwTpp1SjD5U87kdmhfPfjFuSf0JxT7+4mE4ueYdbwf7J+Mr5Mvs9eHgIQtiYbXC7cV
         iw8i+bwrG861FClWVB977iMsSn1Ljzwqq/YJKc3ZfEFV7J0uyD3sQLRm9PhtLxoXr392
         9+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+74miiB9RKr04H49tPYJz56NRSxtaWdXWHLUCCNDUE=;
        b=PKjNjTzDN62CfHM4JCVxhyGKLfOLqpdyEF2Ijfyh2IqkMm6ha4TJSnQ8TPJITf5yaT
         gvTgtywTBN+q/B/DcG8QcsvNFS855UzWOBoyP/1Bs0o2CwGFUDwwy9oRJJ5yfUqecYca
         D7XLQ3hr1DjZ4O/BgSWmkVbfU1H5/6ug+Wpn+yKLzQPRCZE+cz2ArG3Z2ObabaPc8bWI
         oP7nM2LBe1yn0QCNexlnCelBJxiXVsJ6NnQ8Uagk6tc+RoRc4niKssfEEOhp/4b91zG9
         hnDnejcuV1MoL77+17t6NNswpKt6az+9wWpQpVUepJT+z6P2y7j+zTFwsoY0MsxrCBUj
         HlaA==
X-Gm-Message-State: AFqh2kqp7AEuja3R0ESHAB252Szr9MpE8GejPa3taCfo3yKqnOsyK75T
        PSgGxWBuDkr5+bft7vzkHYk=
X-Google-Smtp-Source: AMrXdXv3X09gs6Ue437mxnihkGKSaMXmpG5loa8eAPPgaPkESC2GdhV/Qwwz3dhX5qEI/PoaxwXqyw==
X-Received: by 2002:ac2:43a9:0:b0:4c0:2b07:e6e7 with SMTP id t9-20020ac243a9000000b004c02b07e6e7mr8859098lfl.58.1674745357110;
        Thu, 26 Jan 2023 07:02:37 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002bfae1398bbsm1545075wro.42.2023.01.26.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:02:36 -0800 (PST)
Message-ID: <3e2b7459c1237277d9c99747bd100846c760aa5a.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
        yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Date:   Thu, 26 Jan 2023 17:02:35 +0200
In-Reply-To: <2373c8fc-878f-d061-dc41-49a020438a2e@oracle.com>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
         <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
         <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
         <3ca14d5e-5466-fb4e-b024-01ba33370372@oracle.com>
         <f23eb6cfe20966d7b417f29ec782f78fa0ab93d5.camel@gmail.com>
         <530ea13a-5229-82a8-d976-b0bc141c3448@oracle.com>
         <bc50242da1ea8b3b3eafb62e880ed4a278492d2c.camel@gmail.com>
         <9ed96849303fbc3dee1da5dccac05bd11fb04789.camel@gmail.com>
         <2373c8fc-878f-d061-dc41-49a020438a2e@oracle.com>
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

On Thu, 2023-01-26 at 14:02 +0000, Alan Maguire wrote:
> On 26/01/2023 00:20, Eduard Zingerman wrote:
> > On Thu, 2023-01-26 at 01:42 +0200, Eduard Zingerman wrote:
> > > On Wed, 2023-01-25 at 22:52 +0000, Alan Maguire wrote:
> > > [...]
> > > >=20
> > > > Thanks for this - I tried it, and we spot the optimization once we =
update
> > > > die__create_new_parameter() as follows:
> > > >=20
> > > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > > index f96b6ff..605ad45 100644
> > > > --- a/dwarf_loader.c
> > > > +++ b/dwarf_loader.c
> > > > @@ -1529,6 +1530,8 @@ static struct tag *die__create_new_parameter(=
Dwarf_Die *di
> > > > =20
> > > >         if (ftype !=3D NULL) {
> > > >                 ftype__add_parameter(ftype, parm);
> > > > +               if (parm->optimized)
> > > > +                       ftype->optimized_parms =3D 1;
> > > >                 if (param_idx >=3D 0) {
> > > >                         if (add_child_llvm_annotations(die, param_i=
dx, conf, &(t
> > > >                                 return NULL;
> > > >=20
> > >=20
> > > Great, looks good.
> > >=20
> > > > With that change, I see:
> > > >=20
> > > > $ pahole --verbose --btf_encode_detached=3Dtest.btf test.o
> > > > btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
> > > > Found 0 per-CPU variables!
> > > > Found 2 functions!
> > > > File test.o:
> > > > [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
> > > > [2] PTR (anon) type_id=3D3
> > > > [3] PTR (anon) type_id=3D4
> > > > [4] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED
> > > > [5] FUNC_PROTO (anon) return=3D1 args=3D(1 argc, 2 argv)
> > > > [6] FUNC main type_id=3D5
> > > > added local function 'f', optimized-out params
> > > > skipping addition of 'f' due to optimized-out parameters
> > >=20
> > > Sorry, I have one more silly program.
> > >=20
> > > I talked to Yonghong today and we discussed if compiler can change a
> > > type of a function parameter as a result of some optimization.
> > > Consider the following example:
> > >=20
> > >     $ cat test.c
> > >     struct st {
> > >       int a;
> > >       int b;
> > >     };
> > >    =20
> > >     __attribute__((noinline))
> > >     static int f(struct st *s) {
> > >       return s->a + s->b;
> > >     }
> > >    =20
> > >     int main(int argc, char *argv[]) {
> > >       struct st s =3D {
> > >         .a =3D (long)argv[0],
> > >         .b =3D (long)argv[1]
> > >       };
> > >       return f(&s);
> > >     }
> > >=20
> > > When compiled by `clang` with -O3 the prototype of `f` is changed fro=
m
> > > `int f(struct *st)` to `int f(int, int)`:
> > >=20
> > >     $ clang -O3 -g -c test.c -o test.o && llvm-objdump -d test.o
> > >     ...
> > >     0000000000000000 <main>:
> > >            0: 8b 3e                        	movl	(%rsi), %edi
> > >            2: 8b 76 08                     	movl	0x8(%rsi), %esi
> > >            5: eb 09                        	jmp	0x10 <f>
> > >            7: 66 0f 1f 84 00 00 00 00 00   	nopw	(%rax,%rax)
> > >    =20
> > >     0000000000000010 <f>:
> > >           10: 8d 04 37                     	leal	(%rdi,%rsi), %eax
> > >           13: c3                           	retq
> > >    =20
> > > But generated DWARF hides this information:
> >=20
> > Actually, I'm not correct. The information is present because
> > `DW_AT_location` attribute is not present (just as 4.1.4 says).
> > So I think that the condition for optimized parameters detection has
> > to be adjusted one more time:
> >=20
> > 			has_location =3D attr_location(die, &loc.expr, &loc.exprlen) =3D=3D =
0;
> > 			has_const_value =3D dwarf_attr(die, DW_AT_const_value, &attr) !=3D N=
ULL;
> >=20
> > 			if (has_location && loc.exprlen !=3D 0) {
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
> > 			} else if (!has_location || has_const_value) {
> > 				parm->optimized =3D true;
> > 			}
> >=20
> > (But again, the parameter is marked as optimized but the function is
> >  not skipped in the final BTF, so either I applied our last change
> >  incorrectly or something additional should be done).
> > =20
> > wdyt?
>=20
> I've been digging into this a bit, and the issue here is that for=20
> gcc-generated DWARF at least, location info is often in the abstract=20
> origin parameter references, so we have to combine observations across
> abstract origin reference and original parameter to determine for sure
> if the parameter really is missing location information. In the
> case of this program there are no abstract origin references, so
> it's a bit more straightforward, but we have to handle both cases
> I think.

Is it safe it ignore DW_TAG_subprogram's with DW_AT_abstract_origin's
and thus avoid the combine logic?
The way I read standard it looks like DW_AT_abstract_origin is only
present for instances that undergo some optimization.

>=20
> I'll try and polish up a v2 series that incorporates this shortly;
> in testing it, it works on this case as desired I think:
>=20
> LLVM_OBJCOPY=3Dobjcopy pahole --verbose -J ~/src/isra2/test2.o
> btf_encoder__new: '/home/alan/src/isra2/test2.o' doesn't have '.data..per=
cpu' section
> Found 0 per-CPU variables!
> Found 13 functions!
> File /home/alan/src/isra2/test2.o:
> [1] INT long size=3D8 nr_bits=3D64 encoding=3DSIGNED
> [2] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
> [3] PTR (anon) type_id=3D4
> [4] PTR (anon) type_id=3D5
> [5] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED
> [6] STRUCT st size=3D8
> 	a type_id=3D2 bits_offset=3D0
> 	b type_id=3D2 bits_offset=3D32
> [7] PTR (anon) type_id=3D6
> [8] FUNC_PROTO (anon) return=3D2 args=3D(2 argc, 3 argv)
> [9] FUNC main type_id=3D8
> added local function 'f', optimized-out params
> skipping addition of 'f' due to optimized-out parameters
>=20
> Thanks!
>=20
> Alan
>=20
> >=20
> > >     $ llvm-dwarfdump test.o
> > >     ...
> > >     0x0000005c:   DW_TAG_subprogram
> > >                     DW_AT_low_pc	(0x0000000000000010)
> > >                     DW_AT_high_pc	(0x0000000000000014)
> > >                     DW_AT_frame_base	(DW_OP_reg7 RSP)
> > >                     DW_AT_call_all_calls	(true)
> > >                     DW_AT_name	("f")
> > >                     DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
> > >                     DW_AT_decl_line	(7)
> > >                     DW_AT_prototyped	(true)
> > >                     DW_AT_type	(0x00000074 "int")
> > >    =20
> > >     0x0000006b:     DW_TAG_formal_parameter
> > >                       DW_AT_name	("s")
> > >                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
> > >                       DW_AT_decl_line	(7)
> > >                       DW_AT_type	(0x0000009e "st *")
> > >    =20
> > >     0x00000073:     NULL
> > >     ...
> > >=20
> > > Is this important?
> > > (gcc does not do this for the particular example, but I don't know if
> > >  it could be tricked to under some conditions).
> > >=20
> > > Thanks,
> > > Eduard
> > >=20
> > > [...]
> >=20

