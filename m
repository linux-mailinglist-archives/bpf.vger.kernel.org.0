Return-Path: <bpf+bounces-2824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1EB734A06
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 04:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14781280F93
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 02:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5FD187D;
	Mon, 19 Jun 2023 02:17:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA6139C
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 02:17:30 +0000 (UTC)
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5201AA;
	Sun, 18 Jun 2023 19:17:29 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-570282233ceso24172687b3.1;
        Sun, 18 Jun 2023 19:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141048; x=1689733048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttO0u+Z6WQYWJ1cn7SJJo6s1imUQP7dQUUPthXcpsAs=;
        b=BczPpn1kwG8lBWrpS2jzFxsp3nY4roQKzMUvAL6qmKJhkjIbk6enoHdy2IsbasY4sw
         XQ/VLEJlXU6xnHbEuUUIT1uExtB4LpeTfmH2bAkB5oUaenRwqdIeRRHW00e2Gr68j3Ap
         Jsks8DSrEx/GgLrxN8eJroes4yk3dfHiYdpYB9JgvZf8PLzP1DYo+v5NmOXBnAx8bSUw
         gN7MewUzeb//mbbJzmxZl8Wgw8XD+b9nD3m3Y9dy96Xb1Q9f/9FuaPebVH+Ui00ZEq/n
         k3yV+BNmJiKGVg6DgJFkrG7S6rhK1WqrdH5M+RVWzlBcRuHRocOMFk2g2erfckKPKiSc
         mTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141048; x=1689733048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttO0u+Z6WQYWJ1cn7SJJo6s1imUQP7dQUUPthXcpsAs=;
        b=Z2WXShPVWabqimGgUbPw8mGp6ozikvF/DxfFPZoWLUQri6g1N+U29NFNYRyRYUROzt
         NM9RWIALOiJyIe4f3HXUzGDrp4k3p4Vzle060B+fxELckMjKPA+vGDkVHERSYtsEfapN
         qy7/PDKgG72P4Am1UHZaoC8qR9EQf8na5JUvgQoNBX9Iuonmtdxv2NXlpkxks0qHDlXZ
         P17OJx+0x9he5wktWVizsFhE4gR+yB/LpYTKBydh2phxobSQ+7yyDg61VGVFyiAaI2NC
         KT7g0yru8eOoMg9f633Kw4IROwiZzsI6lGEDnxpalfr1dHKKttWV6geFXvEKQO0vcdsG
         Y36w==
X-Gm-Message-State: AC+VfDwAgrqsW+tD4UJO35q7ewg4wzC+AsHjlVtT7G4ZghzzKDqIq1Bt
	SAPNJ3K7NSoPnicantCHXEM66liijspZQGGVzVU=
X-Google-Smtp-Source: ACHHUZ7rZNxAznSbMOxw5yyxIaX1bWX3kTvQT3ojDNAi9nivDJwLHO5ELWr47EFg/X6cjESwcY86Tm59IbRKV+BXnaE=
X-Received: by 2002:a25:2593:0:b0:bc6:a82a:a24d with SMTP id
 l141-20020a252593000000b00bc6a82aa24dmr3377053ybl.53.1687141048363; Sun, 18
 Jun 2023 19:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-2-imagedong@tencent.com> <12ff965a-12d7-e7f4-a577-5e645d4ff6c0@meta.com>
In-Reply-To: <12ff965a-12d7-e7f4-a577-5e645d4ff6c0@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 19 Jun 2023 10:17:17 +0800
Message-ID: <CADxym3ZSvctkAu7gjeWFh1aJtTt89smoBPsPQ1xXZ2V8isygZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf, x86: clean garbage values when store
 args from regs into stack
To: Yonghong Song <yhs@meta.com>
Cc: alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 6:52=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/12/23 7:52 PM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > There are garbage values in upper bytes when we store the arguments
> > into stack in save_regs() if the size of the argument less then 8.
> >
> > As we already reserve 8 byte for the arguments in regs and stack,
> > it is ok to store/restore the regs in BPF_DW size. Then, the garbage
> > values in upper bytes will be cleaned.
>
> Please make it clear that there are no bugs in the existing code
> since for each argument, a type case will happen like
>      (parameter_type)ctx[stack_slot]
> where ctx[] is an u64 type array. The compiler will generate
> correct code to do type casting so garbage value will not impact
> the final result. But indeed, uniformly
> do save/restore with BPF_DW size can simplify code.
>

Yeah, this is to prepare for the next commit and no bugs
in the existing code. I'll make it clear in the commit log in
the next version.

Thanks!
Menglong Dong

> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   arch/x86/net/bpf_jit_comp.c | 35 ++++++-----------------------------
> >   1 file changed, 6 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 1056bbf55b17..a407fbbffecd 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1860,57 +1860,34 @@ st:                   if (is_imm8(insn->off))
> >   static void save_regs(const struct btf_func_model *m, u8 **prog, int =
nr_regs,
> >                     int stack_size)
> >   {
> > -     int i, j, arg_size;
> > -     bool next_same_struct =3D false;
> > +     int i;
> >
> >       /* Store function arguments to stack.
> >        * For a function that accepts two pointers the sequence will be:
> >        * mov QWORD PTR [rbp-0x10],rdi
> >        * mov QWORD PTR [rbp-0x8],rsi
> >        */
> > -     for (i =3D 0, j =3D 0; i < min(nr_regs, 6); i++) {
> > -             /* The arg_size is at most 16 bytes, enforced by the veri=
fier. */
> > -             arg_size =3D m->arg_size[j];
> > -             if (arg_size > 8) {
> > -                     arg_size =3D 8;
> > -                     next_same_struct =3D !next_same_struct;
> > -             }
> > -
> > -             emit_stx(prog, bytes_to_bpf_size(arg_size),
> > -                      BPF_REG_FP,
> > +     for (i =3D 0; i < min(nr_regs, 6); i++)
> > +             emit_stx(prog, BPF_DW, BPF_REG_FP,
> >                        i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> >                        -(stack_size - i * 8));
> > -
> > -             j =3D next_same_struct ? j : j + 1;
> > -     }
> >   }
> >
> [...]

