Return-Path: <bpf+bounces-5340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C3759BA0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493051C210B9
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E01FB34;
	Wed, 19 Jul 2023 16:57:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37817F6
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 16:57:22 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A2B6
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:57:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b8392076c9so93546871fa.1
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689785839; x=1692377839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yLpUfGcNVTy5sX2sXPqFputfyU0ncnFPIJVuNku63TI=;
        b=J4GpvifulI2T1uwAh2MgSiji/ChcaIYFaYmzlECxCulWeuG25TaU4zqmsMIZQ+QuGn
         wis7GOU6b4jkaxbhDMLIJ9Zv7/528VdsqXpAeeSrFFxPo9Jm1qxMLQV27mn/1YtlR6sO
         5XuYCNtgbl0zMhzcSpapnn/tzwHMjWemxSe5FrDvvjL31CHo15iHNqd3g1oA7n5g1EFv
         GqeQGrUHJUDbqztydVV2UD2R4CYsUrzxPdJT/8z2mJX+iesByMq2hEAL3gHObmX6zRrj
         Dc+Jlncv4V+CmuFnuAAcwsWGANQAgFbB4gKLwlESoZ2j62pADzhUxPCwf4r6zqtq2F6q
         ev3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785839; x=1692377839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLpUfGcNVTy5sX2sXPqFputfyU0ncnFPIJVuNku63TI=;
        b=EvnRl3BfVOc/mpONZU0b5s+5gIAuFQ1gocVan3KHWFyOSoW6fty0Ie5e91+LId05NK
         qlZyeWxCytVWqFxm9s7BonKKaOu4mKz4IBG0CSRLnAloLU9bXCPM8XvIDOhTWJYMGI3a
         rA8rGU6Vz7HseHfBBqmxU7+T7CcSAAv+xdm1rWx9Vjabx++19EKFEZ5g4EHA3OdxN3ij
         OESgM0ugaRSFmdAIYgH04X2o43jjD0F5Klqdcz8CzAHzWAdL/q2HvFq0CBr6oHcQfvSa
         DgUK4TIW+gyajDrRAIsZxI+4U7W4dwwA0dl92UVh5+GmyL9IeW8V40wBo0C1Fslq2q26
         sUeA==
X-Gm-Message-State: ABy/qLYD/1K3A8WS1HUFyzy8TGFtm9EeybSc9AcaRAkn/4B5hO7Yh6mh
	xJPg3H5Egjf6coeTTP33WLA=
X-Google-Smtp-Source: APBJJlGoyuwgM8PZITnyMANtA64XxRpTmjxPJoErGEHGIGkcVla4/AwfuyIZxnri2TyPMK7MiYUxUQ==
X-Received: by 2002:a2e:9159:0:b0:2b4:7f66:8c92 with SMTP id q25-20020a2e9159000000b002b47f668c92mr402421ljg.31.1689785838456;
        Wed, 19 Jul 2023 09:57:18 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s13-20020a2e83cd000000b002b47a15a2eesm1140569ljh.45.2023.07.19.09.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:57:18 -0700 (PDT)
Message-ID: <f865243714e683d35d61221a778658ea4be745ae.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Support new sign-extension mov
 insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Fangrui Song <maskray@google.com>, Yonghong Song <yhs@meta.com>, 
	Yonghong Song
	 <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 19 Jul 2023 19:57:16 +0300
In-Reply-To: <CAFP8O3+2dTqatr_of4faH2a9r2dm3e3MatFfXT2-JsYMJqOQ=A@mail.gmail.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060734.390551-1-yhs@fb.com>
	 <5b1f7cd2a995882a05fcfdef78bb1390794c2603.camel@gmail.com>
	 <356fc6bf-77cb-abbc-f7cf-3d2678ffa83b@meta.com>
	 <40a3d3842ee4fc3323bca7112dd832486b7bed4f.camel@gmail.com>
	 <CAFP8O3+2dTqatr_of4faH2a9r2dm3e3MatFfXT2-JsYMJqOQ=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-19 at 08:59 -0700, Fangrui Song wrote:
> On Wed, Jul 19, 2023 at 5:53=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2023-07-18 at 18:17 -0700, Yonghong Song wrote:
> > [...]
> > > > > > +static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64=
, u32 dst_reg,
> > > > > > +                          u32 src_reg)
> > > > > > +{
> > > > > > +       u8 *prog =3D *pprog;
> > > > > > +
> > > > > > +       if (is64) {
> > > > > > +               /* movs[b,w,l]q dst, src */
> > > > > > +               if (num_bits =3D=3D 8)
> > > > > > +                       EMIT4(add_2mod(0x48, src_reg, dst_reg),=
 0x0f, 0xbe,
> > > > > > +                             add_2reg(0xC0, src_reg, dst_reg))=
;
> > > > > > +               else if (num_bits =3D=3D 16)
> > > > > > +                       EMIT4(add_2mod(0x48, src_reg, dst_reg),=
 0x0f, 0xbf,
> > > > > > +                             add_2reg(0xC0, src_reg, dst_reg))=
;
> > > > > > +               else if (num_bits =3D=3D 32)
> > > > > > +                       EMIT3(add_2mod(0x48, src_reg, dst_reg),=
 0x63,
> > > > > > +                             add_2reg(0xC0, src_reg, dst_reg))=
;
> > > > > > +       } else {
> > > > > > +               /* movs[b,w]l dst, src */
> > > > > > +               if (num_bits =3D=3D 8) {
> > > > > > +                       EMIT4(add_2mod(0x40, src_reg, dst_reg),=
 0x0f, 0xbe,
> > > > > > +                             add_2reg(0xC0, src_reg, dst_reg))=
;
> > > >=20
> > > > Nit: As far as I understand 4-126 Vol. 2B of [1]
> > > >       the 0x40 prefix (REX prefix) is optional here
> > > >       (same as implemented below for num_bits =3D=3D 16).
> > >=20
> > > I think 0x40 prefix at least neededif register is from R8 - R15?
> >=20
> > Yes, please see below.
> >=20
> > > I use this website to do asm/disasm experiments and did
> > > try various combinations with first 8 and later 8 registers
> > > and it seems correct results are generated.
> >=20
> > It seems all roads lead to that web-site, I used it as well :)
> > Today I learned that the following could be used:
> >=20
> >   echo 'movsx rax,ax' | as -o /dev/null -aln -msyntax=3Dintel -mnaked-r=
eg
> >=20
> > Which opens a road to scripting experiments.
>=20
> This internal tool from llvm-project may also be useful:)
>=20
> llvm-mc -triple=3Dx86_64 -show-inst -x86-asm-syntax=3Dintel
> -output-asm-variant=3D1 <<< 'movsx rax, ax'

Thank you, this works (with -show-encoding).

>=20
> > > >=20
> > > > [1] https://cdrdv2.intel.com/v1/dl/getContent/671200
> > > >=20
> > > >=20
> > > > > > +               } else if (num_bits =3D=3D 16) {
> > > > > > +                       if (is_ereg(dst_reg) || is_ereg(src_reg=
))
> > > > > > +                               EMIT1(add_2mod(0x40, src_reg, d=
st_reg));
> > > > > > +                       EMIT3(add_2mod(0x0f, src_reg, dst_reg),=
 0xbf,
> > > >=20
> > > > Nit: Basing on the same manual I don't understand why
> > > >       add_2mod(0x0f, src_reg, dst_reg) is used, '0xf' should suffic=
e
> > > >       (but I tried it both ways and it works...).
> > >=20
> > >  From the above online assembler website.
> > >=20
> > > But I will check the doc to see whether it can be simplified.
> >=20
> > I tried all combinations of r0..r9 for 64/32-bit destinations,
> > 32/16/8 sources [1]:
> > - 0x40 based prefix is generated if any of the following is true:
> >   - dst is 64 bit
> >   - dst is ereg
> >   - src is ereg
> >   - dst is 32-bit and src is 'sil' (part of 'rsi', used for r2)
> >     (!) This one is surprising and web-site shows the same results.
> >         For example `movsx eax,sil` is encoded as `40 0F BE C6`,
> >         disassembling `0F BE C6` (w/o prefix) gives `movsx eax,dh`.

I think I found the place in the manual that explains situation:

  3.7.2.1 Register Operands in 64-Bit Mode
  Register operands in 64-bit mode can be any of the following:
  - ...
  - 8-bit general-purpose registers: AL, BL, CL, DL, SIL, DIL, SPL, BPL,
    and R8B-R15B are available using REX prefixes;
    AL, BL, CL, DL, AH, BH, CH, DH are available without using REX prefixes=
.
  - ...

Vol. 1, page 3-21
https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-=
32-architectures-software-developer-vol-1-manual.pdf

> > - opcodes:
> >   - 63      64-bit dst, 32-bit src
> >   - 0F BF   64-bit dst, 16-bit src
> >   - 0F BE   64-bit dst,  8-bit src
> >   - 0F BF   32-bit dst, 16-bit src (same as 64-bit dst)
> >   - 0F BE   32-bit dst,  8-bit src (same as 64-bit dst)
> >=20
> > Script is at [2] (it is not particularly interesting, but in case if
> > you want to tweak it).
> >=20
> > [1] https://gist.github.com/eddyz87/94b35fd89f023c43dd2480e196b28ea1
> > [2] https://gist.github.com/eddyz87/60991379c547df11d30fa91901862227
> >=20
> > > > > > +                             add_2reg(0xC0, src_reg, dst_reg))=
;
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > > +       *pprog =3D prog;
> > > > > > +}
> > [...]
>=20
>=20
>=20


