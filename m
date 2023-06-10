Return-Path: <bpf+bounces-2305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2533872A966
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 08:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4801281ACD
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4133C0A;
	Sat, 10 Jun 2023 06:33:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689981878
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 06:33:20 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE03AB4;
	Fri,  9 Jun 2023 23:33:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso2511915276.3;
        Fri, 09 Jun 2023 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686378798; x=1688970798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/F0Vah8N+QvY3J04Di/69DwoA3Mn3TYiSlRJU8Vays=;
        b=h5dXy7q/vwzHCGvnY+ahzn0yh2uYLl7RomJJnCdslluO6ukWEQoilGgSFc4jLagc2H
         fMdxXfCmnPmGKVj7o3g2+DFN1dZJgZXioMIyLsdoMx5JGPFo1GQA9cQH8wVI5ZuHlAUE
         FqY/0MUM/0j0hWYkPEipxBtwbhaShupqOKKkBkVgS1hR3i7ifGEC4Am/KNXJZp5L/gdS
         4qlrCVpD0pQNHSlpiWzxy67+pOEjyJZKNVM21jTKm8mR83HJXNrBOE1KzyRq1oIn6Z1A
         RGR5xEiDHE5SZvxQP6snnQyLr76h7RVrHW5p0mqE6XzFlNNJ8K7cjgbpU0bTH+qeHpOJ
         wBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686378798; x=1688970798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/F0Vah8N+QvY3J04Di/69DwoA3Mn3TYiSlRJU8Vays=;
        b=DlU2gCfYcODZotZuNb9jLRexxeaKZE02OSwr7clPf5xFlNe+4xDxF5mxa8olYNoS3d
         BebmMrG+mqkWaFjvw1svIzeaSPlibm48ywyCTVexaIdlMc4OBm8IiHk2LbtwKdaRgVHh
         h/y5nUKn9ve2V+tts/yoQfHvZbp6HpoULuZaFlPnnQJ1MuiKjAQvXf/c43H1Qu+JC5U3
         78axQZAod+yntUuTAGO6AqRDKo8JO7N0qKTSbdQn0BgSNkYmI42GEs4qYiwDiZ+rXGHr
         bJUBm+ib+tyz2yewFtVj8EAaSHT+3HaRdTXe3WoGxc88eECer1N4Q9hwPs7DHSBtRJpZ
         MN+g==
X-Gm-Message-State: AC+VfDygJGs3WrDNlMGhEzz34yCiBPrmMdJ6gV6736VhhEAYYFJw8Yv/
	SON9Se+VsDG8kyrK0STf8S+i1gKiz+/QQWJJglw=
X-Google-Smtp-Source: ACHHUZ7UTIcjHeUoYVTNKehwYw1ru4t89jzOfwLmNnyfMAoxGKE+rBYEuLrhLc64gFaU1JiNVrDWHijF+uUZm/RIics=
X-Received: by 2002:a81:9294:0:b0:565:d3f9:209e with SMTP id
 j142-20020a819294000000b00565d3f9209emr3327032ywg.34.1686378797584; Fri, 09
 Jun 2023 23:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609095653.1406173-1-imagedong@tencent.com>
 <20230609095653.1406173-3-imagedong@tencent.com> <6c195897-e2c5-f0b8-45b4-83a0e9b71bf8@meta.com>
In-Reply-To: <6c195897-e2c5-f0b8-45b4-83a0e9b71bf8@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Jun 2023 14:33:06 +0800
Message-ID: <CADxym3Ypiy12atzPpxVL0t_SRdmo9yfxwPdcHgA0V3Z13WNhFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf, x86: clean garbage value in the
 stack of trampoline
To: Yonghong Song <yhs@meta.com>
Cc: andrii.nakryiko@gmail.com, alan.maguire@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 11:20=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > There are garbage values in upper bytes when we store the arguments
> > into stack in save_regs() if the size of the argument less then 8.
> >
> > As we already reserve 8 byte for the arguments in regs and stack,
> > it is ok to store/restore the regs in BPF_DW size. Then, the garbage
> > values in upper bytes will be cleaned.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v4:
> > - clean grabage value when argument count is 7
> > ---
> >   arch/x86/net/bpf_jit_comp.c | 45 ++++++++++++++++++++++++++----------=
-
> >   1 file changed, 32 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index a767e13c8c85..f6f51a5d14db 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1857,6 +1857,28 @@ st:                    if (is_imm8(insn->off))
> >       return proglen;
> >   }
> >
> > +static inline void clean_garbage(u8 **pprog, int nr_regs, int stack_si=
ze,
> > +                              int arg_size)
> > +{
> > +     u8 *prog;
> > +
> > +     /* clean potential garbage values in upper 32-bit. 'stack_size'
> > +      * here is the offset of the 7th argument on-stack.
>
> Here, we have a huge assumption that if only 7 registers, compiler might
> just allocate a 8-byte stack space and write the value to it. If the
> type of the value is <=3D 32bit, a 32bit store will be on the stack.
> So in this case, the upper 32bit needs to be cleared.
> If the number of arguments (in terms of number of registers) is more
> than 7, the extra arguments will be 'pushed' to the stack, so there
> is no garbage. This could be true. But please add enough details
> here so people knows why we special case this particular instance.
>

Yeah, this indeed is a huge assumption. I'll add more
comments here to help others understand this case.

Thanks!
Menglong Dong

> > +      */
> > +     if (nr_regs =3D=3D 7 && arg_size <=3D 4) {
> > +             int off =3D -(stack_size - 4);
> > +
> > +             prog =3D *pprog;
> > +             /* mov DWORD PTR [rbp + off], 0 */
> > +             if (!is_imm8(off))
> > +                     EMIT2_off32(0xC7, 0x85, off);
> > +             else
> > +                     EMIT3(0xC7, 0x45, off);
> > +             EMIT(0, 4);
> > +             *pprog =3D prog;
> > +     }
> > +}
> > +
> >   static void save_regs(const struct btf_func_model *m, u8 **prog, int =
nr_regs,
> >                     int stack_size)
> >   {
> > @@ -1878,8 +1900,7 @@ static void save_regs(const struct btf_func_model=
 *m, u8 **prog, int nr_regs,
> >
> >               if (i <=3D 5) {
> >                       /* copy function arguments from regs into stack *=
/
> > -                     emit_stx(prog, bytes_to_bpf_size(arg_size),
> > -                              BPF_REG_FP,
> > +                     emit_stx(prog, BPF_DW, BPF_REG_FP,
> >                                i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> >                                -(stack_size - i * 8));
> >               } else {
> > @@ -1893,17 +1914,16 @@ static void save_regs(const struct btf_func_mod=
el *m, u8 **prog, int nr_regs,
> >                        *   8(return addr of the caller)
> >                        * which means: rbp + 24
> >                        */
> > -                     emit_ldx(prog, bytes_to_bpf_size(arg_size),
> > -                              BPF_REG_0, BPF_REG_FP,
> > +                     emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
> >                                (i - 6) * 8 + 0x18);
> > -                     emit_stx(prog, bytes_to_bpf_size(arg_size),
> > -                              BPF_REG_FP,
> > -                              BPF_REG_0,
> > +                     emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
> >                                -(stack_size - i * 8));
> >               }
> >
> >               j =3D next_same_struct ? j : j + 1;
> >       }
> > +
> > +     clean_garbage(prog, nr_regs, stack_size - 6 * 8, arg_size);
> >   }
> >
> >   static void restore_regs(const struct btf_func_model *m, u8 **prog, i=
nt nr_regs,
> > @@ -1925,7 +1945,7 @@ static void restore_regs(const struct btf_func_mo=
del *m, u8 **prog, int nr_regs,
> >                       next_same_struct =3D !next_same_struct;
> >               }
> >
> > -             emit_ldx(prog, bytes_to_bpf_size(arg_size),
> > +             emit_ldx(prog, BPF_DW,
> >                        i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
> >                        BPF_REG_FP,
> >                        -(stack_size - i * 8));
> > @@ -1956,17 +1976,16 @@ static void prepare_origin_stack(const struct b=
tf_func_model *m, u8 **prog,
> >               }
> >
> >               if (i > 5) {
> > -                     emit_ldx(prog, bytes_to_bpf_size(arg_size),
> > -                              BPF_REG_0, BPF_REG_FP,
> > +                     emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
> >                                (i - 6) * 8 + 0x18);
> > -                     emit_stx(prog, bytes_to_bpf_size(arg_size),
> > -                              BPF_REG_FP,
> > -                              BPF_REG_0,
> > +                     emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
> >                                -(stack_size - (i - 6) * 8));
> >               }
> >
> >               j =3D next_same_struct ? j : j + 1;
> >       }
> > +
> > +     clean_garbage(prog, nr_regs, stack_size, arg_size);
> >   }
> >
> >   static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog=
,

