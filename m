Return-Path: <bpf+bounces-5331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6313759A5B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAE228194C
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5963D3A4;
	Wed, 19 Jul 2023 16:00:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799933D394
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 16:00:11 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69810D4
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:00:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40371070eb7so660201cf.1
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689782408; x=1692374408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8fQrip6ZCQv+crVqK+Ca0JlBUmMKK8X4eJLkIDZxl8=;
        b=z5GUJtPBpKab/cl5zzrDdHaULMUlNdQZJYmrK3ElAD+YjK5NeZmjB/JXBD1FeDngbN
         9hB71uuBL/MEqCzFu8h3XX/xqbMlpgmjxZTznLrq1JVsTk+JPg94AWoOzF7FCYq5PT1v
         a2PhE0ncQBS9RlpG/ovt2WgyOAGyVok6FwSFFBhZ212rEtsP7thqmuNsQe8QDYb4pjGx
         FuZmfxxvKUliP9m7o2BYNZ3nKHrPpHXP9741SoqtAfSbLbvQY3NNMT0TF4075MqUqhGR
         I5q9NEYlGnUX3yD+pMddQQvkNWfKpfDV+3L2LylqqODg34miiyb33H0ssVQDQWDiPfX8
         cK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782408; x=1692374408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8fQrip6ZCQv+crVqK+Ca0JlBUmMKK8X4eJLkIDZxl8=;
        b=RZ0/bSUN5/MtwOSGB6nF1T3FMB1TUMkjEiidXnbB/NwFozVtIV7mCqeOkc2c7MuzoB
         9/fROfIjNuCbwahY2yJOeR/cJjilkG/q79fNhZnwEqGeiekkYlkuroqEj8QeKWXHmvrr
         lSCqyYoWTrXLBJjhIxNM9OlWKsVatSpCJAyzVMPV/edg4yvJxt5y/5yzJrY29k1FPP1h
         PtECugTzn68LI+VJtXrc7r2Nk6yq2RcMnMXKI7VpBkPoOj2cbquwdtVKOawH5Mh+xl9D
         o8DNHWSYwL1bXeuOq7/eVDEnUh5Q65D3OizmxVcskGpoZavkhn64jlkkEhLn7cQmA6xw
         htEQ==
X-Gm-Message-State: ABy/qLaeG3Y7+cf1QFCyqtgYTMWyekBuzi5L2F+Io+bQ/sarLIZS9tML
	ZCKehTDaIVEaUFMXCgJ2CVPGjstVGQLFI6+LB7xVKA==
X-Google-Smtp-Source: APBJJlHMBJVJIOyQBjKsutmdRF6axfEBtZ/ZjI+ba46V1yiKxIDlpkIqpSGuPKxOfpOwJKPdA428uQzGLJYPOoUWxRY=
X-Received: by 2002:a05:622a:289:b0:3f8:5b2:aef5 with SMTP id
 z9-20020a05622a028900b003f805b2aef5mr555276qtw.29.1689782408465; Wed, 19 Jul
 2023 09:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713060718.388258-1-yhs@fb.com> <20230713060734.390551-1-yhs@fb.com>
 <5b1f7cd2a995882a05fcfdef78bb1390794c2603.camel@gmail.com>
 <356fc6bf-77cb-abbc-f7cf-3d2678ffa83b@meta.com> <40a3d3842ee4fc3323bca7112dd832486b7bed4f.camel@gmail.com>
In-Reply-To: <40a3d3842ee4fc3323bca7112dd832486b7bed4f.camel@gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Wed, 19 Jul 2023 08:59:54 -0700
Message-ID: <CAFP8O3+2dTqatr_of4faH2a9r2dm3e3MatFfXT2-JsYMJqOQ=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Support new sign-extension mov insns
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 5:53=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-07-18 at 18:17 -0700, Yonghong Song wrote:
> [...]
> > > > > +static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, =
u32 dst_reg,
> > > > > +                          u32 src_reg)
> > > > > +{
> > > > > +       u8 *prog =3D *pprog;
> > > > > +
> > > > > +       if (is64) {
> > > > > +               /* movs[b,w,l]q dst, src */
> > > > > +               if (num_bits =3D=3D 8)
> > > > > +                       EMIT4(add_2mod(0x48, src_reg, dst_reg), 0=
x0f, 0xbe,
> > > > > +                             add_2reg(0xC0, src_reg, dst_reg));
> > > > > +               else if (num_bits =3D=3D 16)
> > > > > +                       EMIT4(add_2mod(0x48, src_reg, dst_reg), 0=
x0f, 0xbf,
> > > > > +                             add_2reg(0xC0, src_reg, dst_reg));
> > > > > +               else if (num_bits =3D=3D 32)
> > > > > +                       EMIT3(add_2mod(0x48, src_reg, dst_reg), 0=
x63,
> > > > > +                             add_2reg(0xC0, src_reg, dst_reg));
> > > > > +       } else {
> > > > > +               /* movs[b,w]l dst, src */
> > > > > +               if (num_bits =3D=3D 8) {
> > > > > +                       EMIT4(add_2mod(0x40, src_reg, dst_reg), 0=
x0f, 0xbe,
> > > > > +                             add_2reg(0xC0, src_reg, dst_reg));
> > >
> > > Nit: As far as I understand 4-126 Vol. 2B of [1]
> > >       the 0x40 prefix (REX prefix) is optional here
> > >       (same as implemented below for num_bits =3D=3D 16).
> >
> > I think 0x40 prefix at least neededif register is from R8 - R15?
>
> Yes, please see below.
>
> > I use this website to do asm/disasm experiments and did
> > try various combinations with first 8 and later 8 registers
> > and it seems correct results are generated.
>
> It seems all roads lead to that web-site, I used it as well :)
> Today I learned that the following could be used:
>
>   echo 'movsx rax,ax' | as -o /dev/null -aln -msyntax=3Dintel -mnaked-reg
>
> Which opens a road to scripting experiments.

This internal tool from llvm-project may also be useful:)

llvm-mc -triple=3Dx86_64 -show-inst -x86-asm-syntax=3Dintel
-output-asm-variant=3D1 <<< 'movsx rax, ax'

> > >
> > > [1] https://cdrdv2.intel.com/v1/dl/getContent/671200
> > >
> > >
> > > > > +               } else if (num_bits =3D=3D 16) {
> > > > > +                       if (is_ereg(dst_reg) || is_ereg(src_reg))
> > > > > +                               EMIT1(add_2mod(0x40, src_reg, dst=
_reg));
> > > > > +                       EMIT3(add_2mod(0x0f, src_reg, dst_reg), 0=
xbf,
> > >
> > > Nit: Basing on the same manual I don't understand why
> > >       add_2mod(0x0f, src_reg, dst_reg) is used, '0xf' should suffice
> > >       (but I tried it both ways and it works...).
> >
> >  From the above online assembler website.
> >
> > But I will check the doc to see whether it can be simplified.
>
> I tried all combinations of r0..r9 for 64/32-bit destinations,
> 32/16/8 sources [1]:
> - 0x40 based prefix is generated if any of the following is true:
>   - dst is 64 bit
>   - dst is ereg
>   - src is ereg
>   - dst is 32-bit and src is 'sil' (part of 'rsi', used for r2)
>     (!) This one is surprising and web-site shows the same results.
>         For example `movsx eax,sil` is encoded as `40 0F BE C6`,
>         disassembling `0F BE C6` (w/o prefix) gives `movsx eax,dh`.
> - opcodes:
>   - 63      64-bit dst, 32-bit src
>   - 0F BF   64-bit dst, 16-bit src
>   - 0F BE   64-bit dst,  8-bit src
>   - 0F BF   32-bit dst, 16-bit src (same as 64-bit dst)
>   - 0F BE   32-bit dst,  8-bit src (same as 64-bit dst)
>
> Script is at [2] (it is not particularly interesting, but in case if
> you want to tweak it).
>
> [1] https://gist.github.com/eddyz87/94b35fd89f023c43dd2480e196b28ea1
> [2] https://gist.github.com/eddyz87/60991379c547df11d30fa91901862227
>
> > > > > +                             add_2reg(0xC0, src_reg, dst_reg));
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       *pprog =3D prog;
> > > > > +}
> [...]



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

