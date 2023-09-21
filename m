Return-Path: <bpf+bounces-10551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBE7A9C63
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF03CB214DC
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782CD47C83;
	Thu, 21 Sep 2023 17:49:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726F47345
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:49:28 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306CC8921A
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:39:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3bd829b86so10466775ad.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695317980; x=1695922780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIXzKAbIPgAMdrr/J75OsSmRiX2G9h1FcDVG2HW/mLQ=;
        b=iO2Y5oySH6sW0hHFp6zm+navdmhCowhkSofRSYG2NgD3tNW2AW/vkY1NQ2QwpSvZI7
         Ss9kYu/fH9okU6icUJP6eowcobj3qFngeRf/yMTSrKvYc19rYnByNwhNRTPZA0l3Sujb
         FM2aMYZ4saupZFq3pf5XeGnNlPycaEvtpE+9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317980; x=1695922780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIXzKAbIPgAMdrr/J75OsSmRiX2G9h1FcDVG2HW/mLQ=;
        b=D9dOQJhU2Jrxw7CCKmrI7ZfpTvLnf9MpGmu9FNDZzruR97HT2aMiF/qmtoLuTwmR8k
         Wcrr2sKdeRlyrCGnRcAxtdi5qDkclYSGPyPO9z+XXT4vJMFLWeN42TGCfpMAVS1lqsSF
         8rbxuU3ThxDkj1+kID4173TAgR0k7y13B26k9GmPSoBF4zyQcH9G7cVdCfZ/IiLV++fF
         jJF2wVWujrvUW7JQnZPWCdqWYeCKdwYzd9f8TLDVskRG7clEUpvhqNnTR72iSIyBlKtm
         dmrMtAhswRg3lQ7Xgjg9JlKBBotWZfqcirU5MWUHKqwrTQQ9ki3wpDKx0DzdBRk7qDCX
         YFkA==
X-Gm-Message-State: AOJu0Yw68fBJb2UQuGLqOSeof4MiWptpxOHS+oh3Q/6FsMmaRjvpsRyi
	OlhtAs2bAeEJ6oAiu00Abk4+i7v0Z46Eht3JHcAm7+uXSZ+XQP4C
X-Google-Smtp-Source: AGHT+IH8st1497r6rxCXgCl3pJe3QM1DZ664ZKEGZ1MZUxwFv0+KKSPvrD5JRsVx54NDujq/bEjMth/wI66ferZXtQQ=
X-Received: by 2002:a05:6300:8081:b0:121:ca90:df01 with SMTP id
 ap1-20020a056300808100b00121ca90df01mr3796196pzc.40.1695290965950; Thu, 21
 Sep 2023 03:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230917150752.69612-1-xukuohai@huaweicloud.com>
 <CABRcYmJudpDA63a2Tk0=riQ0WEQFkHBBQqruDrUPM8Ws=+NtkQ@mail.gmail.com> <70dbf296-e525-ef96-b0fb-543f8e4c1226@huaweicloud.com>
In-Reply-To: <70dbf296-e525-ef96-b0fb-543f8e4c1226@huaweicloud.com>
From: Florent Revest <revest@chromium.org>
Date: Thu, 21 Sep 2023 12:09:14 +0200
Message-ID: <CABRcYmLtk8aQEzoUFw+j5Rdd-MXf-q+i7RHXZtu-skjRz11ZDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Support up to 12 function arguments
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Will Deacon <will@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 7:21=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
> On 9/21/2023 6:17 AM, Florent Revest wrote:
> > On Sun, Sep 17, 2023 at 5:09=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud=
.com> wrote:
> >> Due to bpf only supports function arguments up to 16 bytes, according =
to
> >> AAPCS64, starting from the first argument, each argument is first
> >> attempted to be loaded to 1 or 2 smallest registers from x0-x7, if the=
re
> >> are no enough registers to hold the entire argument, then all remainin=
g
> >> arguments starting from this one are pushed to the stack for passing.
> >
> > If I read the section 6.8.2 of the AAPCS64 correctly, there is a
> > corner case which I believe isn't covered by this logic.
> >
> > void f(u128 a, u128 b, u128, c, u64 d, u128 e, u64 f) {}
> > - a goes on x0 and x1
> > - b goes on x2 and x3
> > - c goes on x4 and x5
> > - d goes on x6
> > - e spills on the stack because it doesn't fit in the remaining regs
> > - f goes on x7
> >
>
> I guess you might have overlooked rule C.13 in AAPCS64. Non-floating type=
 arguments
> are copied to stack under rule C.15/C.17. However, C.13 is applied before=
 C.15/C.17,
> which means that NGRN is set to 8 before the stack is used. That is, all =
8 parameter
> arguments are used up and any remaining arguments can only be passed by t=
he stack.
>
> C.13    The NGRN is set to 8.
>
> C.14    The NSAA is rounded up to the larger of 8 or the Natural Alignmen=
t of the
>          argument=E2=80=99s type.
>
> C.15    If the argument is a composite type then the argument is copied t=
o memory
>          at the adjusted NSAA. The NSAA is incremented by the size of the=
 argument.
>          The argument has now been allocated.
>
> C.16    If the size of the argument is less than 8 bytes then the size of=
 the argument
>          is set to 8 bytes. The effect is as if the argument was copied t=
o the least
>          significant bits of a 64-bit register and the remaining bits fil=
led with
>          unspecified values.
>
> C.17    The argument is copied to memory at the adjusted NSAA. The NSAA i=
s incremented
>          by the size of the argument. The argument has now been allocated=
.
>
>
> And the following assembly code also shows 'e' and 'f' are passed by stac=
k.
>
> int func(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64=
_t f)
> {
>          return e =3D=3D 5 || f =3D=3D 7;
> }
>
> asseembly:
>
> func:
>          sub     sp, sp, #64
>          stp     x0, x1, [sp, 48]
>          stp     x2, x3, [sp, 32]
>          stp     x4, x5, [sp, 16]
>          str     x6, [sp, 8]
>          ldr     x0, [sp, 64] // ** load the low 8 bytes of e from SP + 6=
4 **
>          cmp     x0, 5
>          bne     .L27
>          ldr     x0, [sp, 72] // ** load the high 8 bytes of e from SP + =
72 **
>          cmp     x0, 0
>          beq     .L22
> .L27:
>          ldr     x0, [sp, 80] // ** load f from SP + 80 **
>          cmp     x0, 7
>          bne     .L24
> .L22:
>          mov     w0, 1
>          b       .L26
> .L24:
>          mov     w0, 0
> .L26:
>          add     sp, sp, 64
>          ret

Ah, that's great! :) It keeps things easy then. Thank you for the explanati=
on!

> Although the above case is fine, the current patch does not handle rule C=
.14 correctly.
> For example, for the following func, an 8-byte padding is inserted betwee=
n f and g by
> C.14 to align g to 16 bytes, but this patch mistakenly treats it as part =
of g.
>
> int func(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64=
_t f, __int128 g)
> {
> }
>
> Maybe we could fix it by adding argument alignment to struct btf_func_mod=
el, I'll
> give it a try.

Good catch!

> > Maybe it would be good to add something pathological like this to the
> > selftests ?
> >
>
> OK, will do

Just a thought on that topic, maybe it would be preferable to have a
new separate test for this ? Currently we have a test for 128b long
arguments and a test for many arguments, it's good to have these
separate because they are two dimensions of bpf architectural support:
if someone adds support for one xor the other feature to an arch, it's
good to see a test go green. Since that new test would cover both long
and many arguments, it should probably be a new test.

> >> -static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
> >> +struct arg_aux {
> >> +       /* how many args are passed through registers, the rest args a=
re
> >
> > the rest of the* args
> >
> >> +        * passed through stack
> >> +        */
> >> +       int args_in_reg;
> >
> > Maybe args_in_regs ? since args can go in multiple regs
> >
> >> +       /* how many registers used for passing arguments */
> >
> > are* used
> >
> >> +       int regs_for_arg;
> >
> > And here regs_for_args ? Since It's the number of registers used for al=
l args
> >
> >> +       /* how many stack slots used for arguments, each slot is 8 byt=
es */
> >
> > are* used
> >
> >> +       int stack_slots_for_arg;
> >
> > And here stack_slots_for_args, for the same reason as above?
> >
> >> +};
> >> +
> >> +static void calc_arg_aux(const struct btf_func_model *m,
> >> +                        struct arg_aux *a)
> >>   {
> >>          int i;
> >> +       int nregs;
> >> +       int slots;
> >> +       int stack_slots;
> >> +
> >> +       /* verifier ensures m->nr_args <=3D MAX_BPF_FUNC_ARGS */
> >> +       for (i =3D 0, nregs =3D 0; i < m->nr_args; i++) {
> >> +               slots =3D (m->arg_size[i] + 7) / 8;
> >> +               if (nregs + slots <=3D 8) /* passed through register ?=
 */
> >> +                       nregs +=3D slots;
> >> +               else
> >> +                       break;
> >> +       }
> >> +
> >> +       a->args_in_reg =3D i;
> >> +       a->regs_for_arg =3D nregs;
> >>
> >> -       for (i =3D 0; i < nregs; i++) {
> >> -               emit(A64_STR64I(i, A64_SP, args_off), ctx);
> >> -               args_off +=3D 8;
> >> +       /* the rest arguments are passed through stack */
> >> +       for (stack_slots =3D 0; i < m->nr_args; i++)
> >> +               stack_slots +=3D (m->arg_size[i] + 7) / 8;
> >> +
> >> +       a->stack_slots_for_arg =3D stack_slots;
> >> +}
> >> +
> >> +static void clear_garbage(struct jit_ctx *ctx, int reg, int effective=
_bytes)
> >> +{
> >> +       if (effective_bytes) {
> >> +               int garbage_bits =3D 64 - 8 * effective_bytes;
> >> +#ifdef CONFIG_CPU_BIG_ENDIAN
> >> +               /* garbage bits are at the right end */
> >> +               emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
> >> +               emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
> >> +#else
> >> +               /* garbage bits are at the left end */
> >> +               emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
> >> +               emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
> >> +#endif
> >>          }
> >>   }
> >>
> >> -static void restore_args(struct jit_ctx *ctx, int args_off, int nregs=
)
> >> +static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_o=
ff,
> >> +                     const struct btf_func_model *m,
> >> +                     const struct arg_aux *a,
> >> +                     bool for_call_origin)
> >>   {
> >>          int i;
> >> +       int reg;
> >> +       int doff;
> >> +       int soff;
> >> +       int slots;
> >> +       u8 tmp =3D bpf2a64[TMP_REG_1];
> >> +
> >> +       /* store argument registers to stack for call bpf, or restore =
argument
> >
> > to* call bpf or "for the bpf program"
> >
>
> Sorry for these incorrect words :(, all will be fixed in the next version=
, thanks!

No problem!

> >>   static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_=
image *im,
> >>                                struct bpf_tramp_links *tlinks, void *o=
rig_call,
> >> -                             int nregs, u32 flags)
> >> +                             const struct btf_func_model *m,
> >> +                             const struct arg_aux *a,
> >> +                             u32 flags)
> >>   {
> >>          int i;
> >>          int stack_size;
> >>          int retaddr_off;
> >>          int regs_off;
> >>          int retval_off;
> >> -       int args_off;
> >> +       int bargs_off;
> >>          int nregs_off;
> >>          int ip_off;
> >>          int run_ctx_off;
> >> +       int oargs_off;
> >> +       int nregs;
> >>          struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> >>          struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> >>          struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY=
_RETURN];
> >> @@ -1859,19 +1951,26 @@ static int prepare_trampoline(struct jit_ctx *=
ctx, struct bpf_tramp_image *im,
> >>           *
> >>           * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_OR=
IG or
> >>           *                                        BPF_TRAMP_F_RET_FEN=
TRY_RET
> >> -        *
> >>           *                  [ arg reg N         ]
> >>           *                  [ ...               ]
> >> -        * SP + args_off    [ arg reg 1         ]
> >> +        * SP + bargs_off   [ arg reg 1         ] for bpf
> >>           *
> >>           * SP + nregs_off   [ arg regs count    ]
> >>           *
> >>           * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG =
flag
> >>           *
> >>           * SP + run_ctx_off [ bpf_tramp_run_ctx ]
> >> +        *
> >> +        *                  [ stack arg N       ]
> >> +        *                  [ ...               ]
> >> +        * SP + oargs_off   [ stack arg 1       ] for original func
> >>           */
> >>
> >>          stack_size =3D 0;
> >> +       oargs_off =3D stack_size;
> >> +       if (flags & BPF_TRAMP_F_CALL_ORIG)
> >> +               stack_size +=3D 8 * a->stack_slots_for_arg;
> >> +
> >>          run_ctx_off =3D stack_size;
> >>          /* room for bpf_tramp_run_ctx */
> >>          stack_size +=3D round_up(sizeof(struct bpf_tramp_run_ctx), 8)=
;
> >> @@ -1885,9 +1984,10 @@ static int prepare_trampoline(struct jit_ctx *c=
tx, struct bpf_tramp_image *im,
> >>          /* room for args count */
> >>          stack_size +=3D 8;
> >>
> >> -       args_off =3D stack_size;
> >> +       bargs_off =3D stack_size;
> >>          /* room for args */
> >> -       stack_size +=3D nregs * 8;
> >> +       nregs =3D a->regs_for_arg + a->stack_slots_for_arg;
> >
> > Maybe this name no longer makes sense ?
>
> OK, I'll remove it

Ack

