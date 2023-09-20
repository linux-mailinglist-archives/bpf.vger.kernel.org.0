Return-Path: <bpf+bounces-10498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 959DB7A8F29
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 00:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C02B209D7
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237341211;
	Wed, 20 Sep 2023 22:18:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1A41A94
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 22:18:08 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A3C9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:18:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c43b4b02c1so2165585ad.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695248285; x=1695853085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzE5MGyAdBWJQHLcYC3zn4+ufeHTXDK14Q+8Dg0PLKs=;
        b=YXIe7V8gqFrrUZc31RdmUrUbjbNlMWwlz0GfSOnLwqjvFMBPdXQ+8w+vzKj16AQ1PF
         roDm57gzHokR6nF9PSXWWa7DIBj7p0c0mU032WwtyWJnySA+0jatGuRsPzlNe/eaii0S
         LIrB5dJjahQLTdEtYc0N5V8RzBflIWMkSvoq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695248285; x=1695853085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzE5MGyAdBWJQHLcYC3zn4+ufeHTXDK14Q+8Dg0PLKs=;
        b=fBUF3LIJVuZVxR3JVxUpPOLReEn40YLjfkTU5eW38SasTVFyynRSVetIn3DjZ5ddB1
         9jiTn3W2QDO+ytfVyUC+XRuj6rH+KoWhVBfu7T4KnETc/04yDTvO1oKRM3/6TAlR/anc
         dYhbdVF71GSXdKkhVEvmngNa0doelzJ+5bJhxKdMHrzr0CzuGjeyp6c0waHsPQOggpln
         bDYFA29jhRFinln62jFLkBNnHkQZvCqmT2Nqc45g78+8XONF/xdfv72ejUnBicRp+RfM
         ULvBcSAuZpfyawXeYMHWMIUcMWjWWkO0E5d9YkwIJ+Gqs0WdRehEfjJn6zat7fDjRpmE
         QLyA==
X-Gm-Message-State: AOJu0YwLjP/p2fQhmAR/oXdlz8fTGtj1jaHE124tMJC5J6h1mxEZLdGl
	hQsx8uuiZCVnKGfM9ESce6R4TPxKHTE1ZF8yED7Svg==
X-Google-Smtp-Source: AGHT+IEaGZmatFbXMqSeseSFfg4F4Cx/hZoySeIaQE/eai/ejFXVZWt8BGBwL/RgaPCxAQSZjYxd+NHrsnhv6Yc1VMQ=
X-Received: by 2002:a17:90a:950c:b0:276:757d:8c89 with SMTP id
 t12-20020a17090a950c00b00276757d8c89mr3736389pjo.44.1695248285340; Wed, 20
 Sep 2023 15:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230917150752.69612-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230917150752.69612-1-xukuohai@huaweicloud.com>
From: Florent Revest <revest@chromium.org>
Date: Thu, 21 Sep 2023 00:17:54 +0200
Message-ID: <CABRcYmJudpDA63a2Tk0=riQ0WEQFkHBBQqruDrUPM8Ws=+NtkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Support up to 12 function arguments
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Will Deacon <will@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 5:09=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Currently arm64 bpf trampoline supports up to 8 function arguments.
> According to the statistics from commit
> 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING"),
> there are about 200 functions accept 9 to 12 arguments, so adding support
> for up to 12 function arguments.

Thank you Xu, this will be a nice addition! :)

> Due to bpf only supports function arguments up to 16 bytes, according to
> AAPCS64, starting from the first argument, each argument is first
> attempted to be loaded to 1 or 2 smallest registers from x0-x7, if there
> are no enough registers to hold the entire argument, then all remaining
> arguments starting from this one are pushed to the stack for passing.

If I read the section 6.8.2 of the AAPCS64 correctly, there is a
corner case which I believe isn't covered by this logic.

void f(u128 a, u128 b, u128, c, u64 d, u128 e, u64 f) {}
- a goes on x0 and x1
- b goes on x2 and x3
- c goes on x4 and x5
- d goes on x6
- e spills on the stack because it doesn't fit in the remaining regs
- f goes on x7

Maybe it would be good to add something pathological like this to the
selftests ?

Otherwise I only have minor nitpicks.

> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c                | 171 ++++++++++++++-----
>  tools/testing/selftests/bpf/DENYLIST.aarch64 |   2 -
>  2 files changed, 131 insertions(+), 42 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 7d4af64e3982..a0cf526b07ea 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1705,7 +1705,7 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  }
>
>  static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *=
l,
> -                           int args_off, int retval_off, int run_ctx_off=
,
> +                           int bargs_off, int retval_off, int run_ctx_of=
f,
>                             bool save_ret)
>  {
>         __le32 *branch;
> @@ -1747,7 +1747,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, st=
ruct bpf_tramp_link *l,
>         /* save return value to callee saved register x20 */
>         emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
>
> -       emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
> +       emit(A64_ADD_I(1, A64_R(0), A64_SP, bargs_off), ctx);
>         if (!p->jited)
>                 emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
>
> @@ -1772,7 +1772,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, st=
ruct bpf_tramp_link *l,
>  }
>
>  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_lin=
ks *tl,
> -                              int args_off, int retval_off, int run_ctx_=
off,
> +                              int bargs_off, int retval_off, int run_ctx=
_off,
>                                __le32 **branches)
>  {
>         int i;
> @@ -1782,7 +1782,7 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx,=
 struct bpf_tramp_links *tl,
>          */
>         emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
>         for (i =3D 0; i < tl->nr_links; i++) {
> -               invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
> +               invoke_bpf_prog(ctx, tl->links[i], bargs_off, retval_off,
>                                 run_ctx_off, true);
>                 /* if (*(u64 *)(sp + retval_off) !=3D  0)
>                  *      goto do_fexit;
> @@ -1796,23 +1796,111 @@ static void invoke_bpf_mod_ret(struct jit_ctx *c=
tx, struct bpf_tramp_links *tl,
>         }
>  }
>
> -static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
> +struct arg_aux {
> +       /* how many args are passed through registers, the rest args are

the rest of the* args

> +        * passed through stack
> +        */
> +       int args_in_reg;

Maybe args_in_regs ? since args can go in multiple regs

> +       /* how many registers used for passing arguments */

are* used

> +       int regs_for_arg;

And here regs_for_args ? Since It's the number of registers used for all ar=
gs

> +       /* how many stack slots used for arguments, each slot is 8 bytes =
*/

are* used

> +       int stack_slots_for_arg;

And here stack_slots_for_args, for the same reason as above?

> +};
> +
> +static void calc_arg_aux(const struct btf_func_model *m,
> +                        struct arg_aux *a)
>  {
>         int i;
> +       int nregs;
> +       int slots;
> +       int stack_slots;
> +
> +       /* verifier ensures m->nr_args <=3D MAX_BPF_FUNC_ARGS */
> +       for (i =3D 0, nregs =3D 0; i < m->nr_args; i++) {
> +               slots =3D (m->arg_size[i] + 7) / 8;
> +               if (nregs + slots <=3D 8) /* passed through register ? */
> +                       nregs +=3D slots;
> +               else
> +                       break;
> +       }
> +
> +       a->args_in_reg =3D i;
> +       a->regs_for_arg =3D nregs;
>
> -       for (i =3D 0; i < nregs; i++) {
> -               emit(A64_STR64I(i, A64_SP, args_off), ctx);
> -               args_off +=3D 8;
> +       /* the rest arguments are passed through stack */
> +       for (stack_slots =3D 0; i < m->nr_args; i++)
> +               stack_slots +=3D (m->arg_size[i] + 7) / 8;
> +
> +       a->stack_slots_for_arg =3D stack_slots;
> +}
> +
> +static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_by=
tes)
> +{
> +       if (effective_bytes) {
> +               int garbage_bits =3D 64 - 8 * effective_bytes;
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +               /* garbage bits are at the right end */
> +               emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
> +               emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
> +#else
> +               /* garbage bits are at the left end */
> +               emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
> +               emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
> +#endif
>         }
>  }
>
> -static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
> +static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
> +                     const struct btf_func_model *m,
> +                     const struct arg_aux *a,
> +                     bool for_call_origin)
>  {
>         int i;
> +       int reg;
> +       int doff;
> +       int soff;
> +       int slots;
> +       u8 tmp =3D bpf2a64[TMP_REG_1];
> +
> +       /* store argument registers to stack for call bpf, or restore arg=
ument

to* call bpf or "for the bpf program"

> +        * registers from stack for the original function
> +        */
> +       for (reg =3D 0; reg < a->regs_for_arg; reg++) {
> +               emit(for_call_origin ?
> +                    A64_LDR64I(reg, A64_SP, bargs_off) :
> +                    A64_STR64I(reg, A64_SP, bargs_off),
> +                    ctx);
> +               bargs_off +=3D 8;
> +       }
>
> -       for (i =3D 0; i < nregs; i++) {
> -               emit(A64_LDR64I(i, A64_SP, args_off), ctx);
> -               args_off +=3D 8;
> +       soff =3D 32; /* on stack arguments start from FP + 32 */
> +       doff =3D (for_call_origin ? oargs_off : bargs_off);
> +
> +       /* save on stack arguments */
> +       for (i =3D a->args_in_reg; i < m->nr_args; i++) {
> +               slots =3D (m->arg_size[i] + 7) / 8;
> +               /* verifier ensures arg_size <=3D 16, so slots equals 1 o=
r 2 */
> +               while (slots-- > 0) {
> +                       emit(A64_LDR64I(tmp, A64_FP, soff), ctx);
> +                       /* if there is unused space in the last slot, cle=
ar
> +                        * the garbage contained in the space.
> +                        */
> +                       if (slots =3D=3D 0 && !for_call_origin)
> +                               clear_garbage(ctx, tmp, m->arg_size[i] % =
8);
> +                       emit(A64_STR64I(tmp, A64_SP, doff), ctx);
> +                       soff +=3D 8;
> +                       doff +=3D 8;
> +               }
> +       }
> +}
> +
> +static void restore_args(struct jit_ctx *ctx, int bargs_off, int nregs)
> +{
> +       int reg;
> +
> +       for (reg =3D 0; reg < nregs; reg++) {
> +               emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
> +               bargs_off +=3D 8;
>         }
>  }
>
> @@ -1829,17 +1917,21 @@ static void restore_args(struct jit_ctx *ctx, int=
 args_off, int nregs)
>   */
>  static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_imag=
e *im,
>                               struct bpf_tramp_links *tlinks, void *orig_=
call,
> -                             int nregs, u32 flags)
> +                             const struct btf_func_model *m,
> +                             const struct arg_aux *a,
> +                             u32 flags)
>  {
>         int i;
>         int stack_size;
>         int retaddr_off;
>         int regs_off;
>         int retval_off;
> -       int args_off;
> +       int bargs_off;
>         int nregs_off;
>         int ip_off;
>         int run_ctx_off;
> +       int oargs_off;
> +       int nregs;
>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
> @@ -1859,19 +1951,26 @@ static int prepare_trampoline(struct jit_ctx *ctx=
, struct bpf_tramp_image *im,
>          *
>          * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG o=
r
>          *                                        BPF_TRAMP_F_RET_FENTRY_=
RET
> -        *
>          *                  [ arg reg N         ]
>          *                  [ ...               ]
> -        * SP + args_off    [ arg reg 1         ]
> +        * SP + bargs_off   [ arg reg 1         ] for bpf
>          *
>          * SP + nregs_off   [ arg regs count    ]
>          *
>          * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
>          *
>          * SP + run_ctx_off [ bpf_tramp_run_ctx ]
> +        *
> +        *                  [ stack arg N       ]
> +        *                  [ ...               ]
> +        * SP + oargs_off   [ stack arg 1       ] for original func
>          */
>
>         stack_size =3D 0;
> +       oargs_off =3D stack_size;
> +       if (flags & BPF_TRAMP_F_CALL_ORIG)
> +               stack_size +=3D 8 * a->stack_slots_for_arg;
> +
>         run_ctx_off =3D stack_size;
>         /* room for bpf_tramp_run_ctx */
>         stack_size +=3D round_up(sizeof(struct bpf_tramp_run_ctx), 8);
> @@ -1885,9 +1984,10 @@ static int prepare_trampoline(struct jit_ctx *ctx,=
 struct bpf_tramp_image *im,
>         /* room for args count */
>         stack_size +=3D 8;
>
> -       args_off =3D stack_size;
> +       bargs_off =3D stack_size;
>         /* room for args */
> -       stack_size +=3D nregs * 8;
> +       nregs =3D a->regs_for_arg + a->stack_slots_for_arg;

Maybe this name no longer makes sense ?

