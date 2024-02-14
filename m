Return-Path: <bpf+bounces-22038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E05985571F
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 00:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225C6B26A4B
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6EC1419B5;
	Wed, 14 Feb 2024 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ytmsQa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32613DB90
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952616; cv=none; b=V+hDmiBu2DKMvqfB6IbCqlbynMEb4lJbF/k9tmzbkew3FCrW+yMO73S4K60on8TMt73ntVZJcV3DYrSJfEm3OyoJiYa7a5NsoreFnRItS47jRyw9MhaILAnCNwebLnJ0ox4H3M5W5PRiPcB+iXANuV5JYf2RoohLsBSNKEu1C8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952616; c=relaxed/simple;
	bh=KW+j5odgQuaXeYXyptUHgKBbzh6bV1ieB1xe957iW0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk3PX0fGerZOkM5+NSM6SSL2lvZ9m+HwCRJ7NjkgGdWypnKjC6DeE/dps4p/B8uAVi/T3dZWcr55a5GZFHjFItDkD/bIPUemsVeqfbDdheA3mQek3jV3rJcTlRTrxECbQtjdM53Kcm4TBxtP5xyc4ommPT1BCmplVW3Vc9KCNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+ytmsQa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so90910f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952612; x=1708557412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjOyJV1dbBaznI3qMs9e4Zg02vzVwxdPSugvt//oIXw=;
        b=L+ytmsQap/BmjEOVuS66gLj7K4dLfvGexH+pgI7j7mmu1YOKGWAxcbdOr7fUac0d9C
         iAEl5cw2brBjx3OwlPxgnCzTnVoTfyiqt+jV19Tp+RR5Kafzx83T1la5PU+YGKaPBLgG
         ucDfRIi+f7+eUoVFsVJ2LVkvrP5xTRZd44o7YtBSepkmMXITWPF2/nZhL/+I5Dd9Z2zA
         k7HKdXD1oQYTFJv1r68Devef5d+PgWmv/EwYiQTnJ0BvFLjWghcULnOQMvXHKMwfVdZq
         BIn7Bf6tHAiFycLe0+LgIz4mRyK/xGh3cCy9fCNCgSoAm6ZdV2r0M/XaQxBVI/uiDurq
         bwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952612; x=1708557412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjOyJV1dbBaznI3qMs9e4Zg02vzVwxdPSugvt//oIXw=;
        b=rZnqP8Kkm6nTIizxEINx6VBayhHHCw8WJH2R2zu+7q2bs+vtuqTN170cvyzgbGtcRt
         XgWWqTcAaSDkEeXJWFmHQdKSdrYZ0x3pYi8WSjGZY9cbs1zk/R8R+84TzfKlyQDpq1IT
         EQ0sCyeNvzu8kNsa6D0ElO8euwv0R1fZgY2kdocJhSd01Qdl/3rTigIwTmcBTbMCuhxl
         cx01HkJ66GMQKWzT4g47Xscb6DzRfZqUuVNsz96J5uTCunVLa1xdrpsnGnOyB7TsUjb4
         zP5NMJSuTQBhEDxICPEydz+5CeVUNL0aYyCQd6M1klSDRvX8Si+vCql20Mv2meYtRRRB
         yfOA==
X-Gm-Message-State: AOJu0YyUIYm5ikpDKHrbFM1K395vu3j4QNID0AtbrCoxl8EtHJK6CAN0
	OUfqK07qzO5RC6Wg872HbjdJ4sRXInlyfD46JINZb/4dC77GrWsU5z6B0xhPsJJLVmGdiRKXFHp
	RHQ9YZa2Pwagci8cIFzvCwS9EdMs=
X-Google-Smtp-Source: AGHT+IFcHPyPS1v/R118H03hNER8jp1pYmhONAbdQbRiP0D+6NjIDKD6QfKxs3jYNTzNTH5mceJwVU/bff4/pzg+3pM=
X-Received: by 2002:a5d:430d:0:b0:33b:65b3:e51b with SMTP id
 h13-20020a5d430d000000b0033b65b3e51bmr63327wrq.48.1707952612379; Wed, 14 Feb
 2024 15:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com> <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
In-Reply-To: <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Feb 2024 15:16:41 -0800
Message-ID: <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:47=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 2024/1/5 12:15, Alexei Starovoitov wrote:
> > On Thu, Jan 4, 2024 at 6:23=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com>=
 wrote:
> >>
> >>
> >
> > Other alternatives?
>
> I've finish the POC of an alternative, which passed all tailcall
> selftests including these tailcall hierarchy ones.
>
> In this alternative, I use a new bpf_prog_run_ctx to wrap the original
> ctx and the tcc_ptr, then get the tcc_ptr and recover the original ctx
> in JIT.
>
> Then, to avoid breaking runtime with tailcall on other arch, I add an
> arch-related check bpf_jit_supports_tail_call_cnt_ptr() to determin
> whether to use bpf_prog_run_ctx.
>
> Here's the diff:
>
>  diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4065bdcc5b2a4..56cea2676863e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -259,7 +259,7 @@ struct jit_context {
>  /* Number of bytes emit_patch() needs to generate instructions */
>  #define X86_PATCH_SIZE         5
>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET   (16 + ENDBR_INSN_SIZE)
>
>  static void push_r12(u8 **pprog)
>  {
> @@ -407,21 +407,19 @@ static void emit_prologue(u8 **pprog, u32
> stack_depth, bool ebpf_from_cbpf,
>         emit_nops(&prog, X86_PATCH_SIZE);
>         if (!ebpf_from_cbpf) {
>                 if (tail_call_reachable && !is_subprog) {
> -                       /* When it's the entry of the whole tailcall cont=
ext,
> -                        * zeroing rax means initialising tail_call_cnt.
> -                        */
> -                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
> -                       EMIT1(0x50);             /* push rax */
> -                       /* Make rax as ptr that points to tail_call_cnt. =
*/
> -                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
> -                       EMIT1_off32(0xE8, 2);    /* call main prog */
> -                       EMIT1(0x59);             /* pop rcx, get rid of t=
ail_call_cnt */
> -                       EMIT1(0xC3);             /* ret */
> +                       /* Make rax as tcc_ptr. */
> +                       EMIT4(0x48, 0x8B, 0x47, 0x08); /* mov rax, qword =
ptr [rdi + 8] */
>                 } else {
> -                       /* Keep the same instruction size. */
> -                       emit_nops(&prog, 13);
> +                       /* Keep the same instruction layout. */
> +                       emit_nops(&prog, 4);
>                 }
>         }
> +       if (!is_subprog)
> +               /* Recover the original ctx. */
> +               EMIT3(0x48, 0x8B, 0x3F); /* mov rdi, qword ptr [rdi] */
> +       else
> +               /* Keep the same instruction layout. */
> +               emit_nops(&prog, 3);
>         /* Exception callback receives FP as third parameter */
>         if (is_exception_cb) {
>                 EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
> @@ -3152,6 +3150,12 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>         return true;
>  }
>
> +/* Indicate the JIT backend supports tail call count pointer in
> tailcall context. */
> +bool bpf_jit_supports_tail_call_cnt_ptr(void)
> +{
> +       return true;
> +}
> +
>  void bpf_jit_free(struct bpf_prog *prog)
>  {
>         if (prog->jited) {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7671530d6e4e0..fea4326c27d31 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1919,6 +1919,11 @@ int bpf_prog_array_copy(struct bpf_prog_array
> *old_array,
>                         u64 bpf_cookie,
>                         struct bpf_prog_array **new_array);
>
> +struct bpf_prog_run_ctx {
> +       const void *ctx;
> +       u32 *tail_call_cnt;
> +};
> +
>  struct bpf_run_ctx {};
>
>  struct bpf_cg_run_ctx {
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 68fb6c8142fec..c1c035c44b4ab 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -629,6 +629,10 @@ typedef unsigned int (*bpf_dispatcher_fn)(const
> void *ctx,
>                                           unsigned int (*bpf_func)(const =
void *,
>                                                                    const =
struct bpf_insn *));
>
> +static __always_inline u32 __bpf_prog_run_dfunc(const struct bpf_prog
> *prog,
> +                                               const void *ctx,
> +                                               bpf_dispatcher_fn dfunc);
> +
>  static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
>                                           const void *ctx,
>                                           bpf_dispatcher_fn dfunc)
> @@ -641,14 +645,14 @@ static __always_inline u32 __bpf_prog_run(const
> struct bpf_prog *prog,
>                 u64 start =3D sched_clock();
>                 unsigned long flags;
>
> -               ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
> +               ret =3D __bpf_prog_run_dfunc(prog, ctx, dfunc);
>                 stats =3D this_cpu_ptr(prog->stats);
>                 flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
>                 u64_stats_inc(&stats->cnt);
>                 u64_stats_add(&stats->nsecs, sched_clock() - start);
>                 u64_stats_update_end_irqrestore(&stats->syncp, flags);
>         } else {
> -               ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
> +               ret =3D __bpf_prog_run_dfunc(prog, ctx, dfunc);
>         }
>         return ret;
>  }
> @@ -952,12 +956,31 @@ struct bpf_prog *bpf_int_jit_compile(struct
> bpf_prog *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
>  bool bpf_jit_needs_zext(void);
>  bool bpf_jit_supports_subprog_tailcalls(void);
> +bool bpf_jit_supports_tail_call_cnt_ptr(void);
>  bool bpf_jit_supports_kfunc_call(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_jit_supports_exceptions(void);
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64
> sp, u64 bp), void *cookie);
>  bool bpf_helper_changes_pkt_data(void *func);
>
> +static __always_inline u32 __bpf_prog_run_dfunc(const struct bpf_prog
> *prog,
> +                                               const void *ctx,
> +                                               bpf_dispatcher_fn dfunc)
> +{
> +       struct bpf_prog_run_ctx run_ctx =3D {};
> +       u32 ret, tcc =3D 0;
> +
> +       run_ctx.ctx =3D ctx;
> +       run_ctx.tail_call_cnt =3D &tcc;
> +
> +       if (bpf_jit_supports_tail_call_cnt_ptr() && prog->jited)
> +               ret =3D dfunc(&run_ctx, prog->insnsi, prog->bpf_func);
> +       else
> +               ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);

This is no good either.
We cannot introduce two extra run-time checks before calling every bpf prog=
.
The solution must be overhead free for common cases.

Can we switch to percpu tail_call_cnt instead of on stack and %rax tricks ?

If that won't work, then we'd have to disable tail_calls from subprogs
in the verifier.

