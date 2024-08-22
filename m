Return-Path: <bpf+bounces-37796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F995A8C0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CD91F21B06
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD354405;
	Thu, 22 Aug 2024 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gog8yK1b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595F171D2
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286194; cv=none; b=Mv/Es0OqrEk3MmsWVczzzJ2SMMPDKWz8AQs0PRYfeg6okN1VHWXv6sxPKkDxkfNrqd89AlvH6rmrUQlV7PX7nixRGV3+ll4btDsUIBhnRq51HL3R/1hT470XURS9F6ACt8cfsdYTS27pF6okkPsnHBu2G1wzARverL7CsSmhoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286194; c=relaxed/simple;
	bh=72m+6FRfeW1mkt/hIbAdnKDgwfjZMgVpk0K2hXhVXbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcWmUjeEnFBH+Z3/tG5N9AmWyEINdXYz2RwM6BXkwlaDsqVrpYVOlF+ZPtTw5KYxKIUcR8pzRWiHUSjHwHMWaOQQUS0imSjBSwX3+8jU1kIVVC6bJYMyqCoImnx0zzhGYapHvE4c7b2CDMZMOis/psc4tbq68OwMXDP0uqWGoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gog8yK1b; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371893dd249so64202f8f.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286191; x=1724890991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwWWE4znXMEyZrWYn/jaa5UomvENKSp6Iz+aifiMjns=;
        b=Gog8yK1bALKm/WMdLZpgtYPFzqHkOaTBtWtQFIMejFMkdTdLHNtbLWhPMWxAD4vdnB
         Gg7bJqTMlHIjaOsD4QGZrvjFYrU/ywbkZA96drLyEbg7SenaPVrU2yCOHiQdzYJv/RZc
         fF+5Oa0qA5AV4SLNUQhHS26ScOXCAzRIiSzG9BM/6jWFrnNQBQU3PEXD6/qS8zSsTMba
         2UAa/RedCIQSw1osebwTveWkg5O6UF7AdEXQofzbZPRMYZ4HRdpx9gVaJceE5PZKrAN2
         +0UQNJ66VLZ9KdG1rVOQ1zJRkyY7y0IKNxLrBj5/1tDWJ/rwme89rSI+Wqt6NIfpvMVn
         YtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286191; x=1724890991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwWWE4znXMEyZrWYn/jaa5UomvENKSp6Iz+aifiMjns=;
        b=DDfsA/BFxFTbwYwwsQ4SEd2ouJtDVQQm1iY8mkelzZcehWt89S+gtdhmCkIu1Ziq85
         faG4vTzzXaYvYeMCsew3E1iEhMOdTrf7A8fgimn1bvekFl99kJLDi3oGGAbpJSt+tBju
         GpgEqT2mySe/3Rec2BszIJsaPMBS/ZQNGH/SNT+RLyzbYKI22dnkNR2rjp3P5CSTgTK+
         aUWraIndcbp75pZ2UIcB4PLnCaQbDTpjcpePt3QkbRYkUbFyeo6trbFGkey9ZXvdgOHY
         mzVzZ+94of3Lp4d/lNcpfqoU6VEqEeaCzncIDxKVt4h3doPGvHU6SfAMURWcFNFKWv0z
         uTEw==
X-Gm-Message-State: AOJu0YzZ45x/4T65F5TIugIwBdDg0j9Zg4RgDq9Bv0mKmvR6GD7dMrcf
	vFdrzFpw5X+jmSvZZAKzUSrCq2T3m6mxu9nEvM7z7eeTw94qI9PaTsDsTc2yMEdrAaD58xkiY2K
	qXnTT8Tfya9tJQJi+9lsJRFNDHc0=
X-Google-Smtp-Source: AGHT+IHsFy3mgj02+MBFahaRArOsA8H1V3FAFh/LOA+frtVExjiWneA8WMpxxNm1z08dX6FpLcSOp2d5IBvBlqGhTb8=
X-Received: by 2002:a5d:6702:0:b0:371:8a70:b10e with SMTP id
 ffacd0b85a97d-372fd71f450mr2117540f8f.60.1724286191019; Wed, 21 Aug 2024
 17:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821233440.1855263-1-martin.lau@linux.dev> <20240821233440.1855263-2-martin.lau@linux.dev>
In-Reply-To: <20240821233440.1855263-2-martin.lau@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 17:22:59 -0700
Message-ID: <CAADnVQKgT_vJJfOnFdTa6Gpf8s+_D79DwtT8pNzxfw2H4aq1Fg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: Add gen_epilogue to bpf_verifier_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:35=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch adds a .gen_epilogue to the bpf_verifier_ops. It is similar
> to the existing .gen_prologue. Instead of allowing a subsystem
> to run code at the beginning of a bpf prog, it allows the subsystem
> to run code just before the bpf prog exit.
>
> One of the use case is to allow the upcoming bpf qdisc to ensure that
> the skb->dev is the same as the qdisc->dev_queue->dev. The bpf qdisc
> struct_ops implementation could either fix it up or drop the skb.
> Another use case could be in bpf_tcp_ca.c to enforce snd_cwnd
> has sane value (e.g. non zero).
>
> The epilogue can do the useful thing (like checking skb->dev) if it
> can access the bpf prog's ctx. Unlike prologue, r1 may not hold the
> ctx pointer. This patch saves the r1 in the stack if the .gen_epilogue
> has returned some instructions in the "epilogue_buf".
>
> The existing .gen_prologue is done in convert_ctx_accesses().
> The new .gen_epilogue is done in the convert_ctx_accesses() also.
> When it sees the (BPF_JMP | BPF_EXIT) instruction, it will be patched
> with the earlier generated "epilogue_buf". The epilogue patching is
> only done for the main prog.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  include/linux/bpf.h   |  2 ++
>  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f0192c173ed8..8ee9d87c332a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -974,6 +974,8 @@ struct bpf_verifier_ops {
>                                 struct bpf_insn_access_aux *info);
>         int (*gen_prologue)(struct bpf_insn *insn, bool direct_write,
>                             const struct bpf_prog *prog);
> +       int (*gen_epilogue)(struct bpf_insn *insn, const struct bpf_prog =
*prog,
> +                           s16 ctx_stack_off);
>         int (*gen_ld_abs)(const struct bpf_insn *orig,
>                           struct bpf_insn *insn_buf);
>         u32 (*convert_ctx_access)(enum bpf_access_type type,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3be12096cf..bbb655f0c7b5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19610,15 +19610,37 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct=
 bpf_verifier_env *env,
>   */
>  static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  {
> +       struct bpf_subprog_info *subprogs =3D env->subprog_info;
>         const struct bpf_verifier_ops *ops =3D env->ops;
> -       int i, cnt, size, ctx_field_size, delta =3D 0;
> +       int i, cnt, size, ctx_field_size, delta =3D 0, epilogue_cnt =3D 0=
;
>         const int insn_cnt =3D env->prog->len;
> -       struct bpf_insn insn_buf[16], *insn;
> +       struct bpf_insn insn_buf[16], epilogue_buf[16], *insn;

This is a noticeable stack increase.
Maybe let's move both to env?

>         u32 target_size, size_default, off;
>         struct bpf_prog *new_prog;
>         enum bpf_access_type type;
>         bool is_narrower_load;
>
> +       if (ops->gen_epilogue) {
> +               epilogue_cnt =3D ops->gen_epilogue(epilogue_buf, env->pro=
g,
> +                                                -(subprogs[0].stack_dept=
h + 8));
> +               if (epilogue_cnt >=3D ARRAY_SIZE(epilogue_buf)) {
> +                       verbose(env, "bpf verifier is misconfigured\n");
> +                       return -EINVAL;
> +               } else if (epilogue_cnt) {
> +                       /* Save the ARG_PTR_TO_CTX for the epilogue to us=
e */
> +                       cnt =3D 0;
> +                       subprogs[0].stack_depth +=3D 8;
> +                       insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_F=
P, BPF_REG_1,
> +                                                     -subprogs[0].stack_=
depth);
> +                       insn_buf[cnt++] =3D env->prog->insnsi[0];
> +                       new_prog =3D bpf_patch_insn_data(env, 0, insn_buf=
, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +                       env->prog =3D new_prog;
> +                       delta +=3D cnt - 1;

I suspect this is buggy.
See commit 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and
jump to the 1st insn.")

> +               }
> +       }
> +
>         if (ops->gen_prologue || env->seen_direct_write) {
>                 if (!ops->gen_prologue) {
>                         verbose(env, "bpf verifier is misconfigured\n");
> @@ -19671,6 +19693,13 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
>                         insn->code =3D BPF_STX | BPF_PROBE_ATOMIC | BPF_S=
IZE(insn->code);
>                         env->prog->aux->num_exentries++;
>                         continue;
> +               } else if (insn->code =3D=3D (BPF_JMP | BPF_EXIT) &&
> +                          epilogue_cnt &&
> +                          i + delta < subprogs[1].start) {
> +                       /* Generate epilogue for the main prog */
> +                       memcpy(insn_buf, epilogue_buf, sizeof(epilogue_bu=
f));
> +                       cnt =3D epilogue_cnt;
> +                       goto patch_insn_buf;

That's quite a bit of copy paste of epilogue if the program contains
multiple bpf_exit insns.
I think llvm generates it in such a way that often there is only
one bpf_exit. But gcc might be using bpf_exit liberally.

So let's patch it only once and replace other bpf_exit with jmp
to one patched place ?

That's pretty much what x86 JIT does when it converts bpf_exit.

>                 } else {
>                         continue;
>                 }
> @@ -19807,6 +19836,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
>                                                        insn->dst_reg, ins=
n->dst_reg,
>                                                        size * 8, 0);
>
> +patch_insn_buf:
>                 new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf=
, cnt);
>                 if (!new_prog)
>                         return -ENOMEM;
> --
> 2.43.5
>

