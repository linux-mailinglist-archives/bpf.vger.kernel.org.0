Return-Path: <bpf+bounces-37434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB60A955A06
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 00:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069901C20DD5
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74041422D2;
	Sat, 17 Aug 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBJMe6XA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5525634
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723933546; cv=none; b=GJEq7hgxgT2wxpwc8VzJCfigubYClCRpCxGM/7T4h4pMMzV50miA1jy9nNt3nmlLAcgRp1UB8qDvmoOkOtsuJ8fM3pBnMDiUvLfKyrF7Oqn4bN8XDog7X+W7yY9tMDgcZEsLTCgigc7tkHzB0rqfwIa7OfKqUut+QfLc6t+ajUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723933546; c=relaxed/simple;
	bh=lq64dS47gipegpTcdaUZ83ubqOSLA8ck47kBcb0xusY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/qb5Qt/yKpMLGkqudairs57XU30AfE7ysE2T9qB1zh6MjJwnAGg2ITdJYWmxrSgmA0ivS1Y3O60zvzswvc+/GM8VqPhshGO+2RDEuaRLqyjaLty1yg5pf6KruoG6vyucueKiP7k6Cg8umhalEeNSisfzvTZ51RSPwOW6MBZ/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBJMe6XA; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso3039559276.1
        for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723933543; x=1724538343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kegrryX1zWz9IHTL/2kduOv2FeE5Fl0Ut+lNEigHrQ=;
        b=DBJMe6XAu2dulUoIlZvdBHGssHI7W8g5dCTPsXTNKvcWzx2MSgez4qNAl/gnvfNi9g
         R8PjqiAWWEBB4azGbuaGEip5wOq0yROvoqP77cY9QMA/NulwTYSHjmu46D/kH9XopsAe
         xpt12ncLCpYWp7DbEr4c+saZqjtZXE7kf1GcAN8ry1+XwYP4CKcC4tjxGP6qOfv7AOjl
         yf5dVbKU7jdVzvHcmpIjaps1fNbmbYgJI06Fe6oq4FKUdC0BBrL0hKn/xQIvG5y+PRM0
         CqbHmbDrjNJSLTtBv2tqxBaMQAdzBBEd05EK+A+ZWspsWnEIedddPtIHsl7J2IcE6Ckr
         LbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723933543; x=1724538343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kegrryX1zWz9IHTL/2kduOv2FeE5Fl0Ut+lNEigHrQ=;
        b=pp4dPFASSFxGXmWBhBoatxaMi1nTRKZfNbvq/fb0jp47PdvirN+6dht90pTcJ0rvTA
         Phvv1QUE0yTmj51Fp19U2hv/uc2suCz9LZbOZLCh1gyCpVbBlnofzBOnnH457xJ0nkl+
         KMzRS1O7h8clJjf5xb36VQ/jV/zmCMsjR60zddgiBh8KEuStunDwb2H4UUdwk0hsAIZg
         K+vuxgmNsKknNvgLAtv2fawU7c8xjVC4HVkKMnraJuGhRYrquIbqa27oFhBj2sjMj+M0
         RNHPpMDonNOlVOJS7w0cCTV9yVyQfLU2O/LhQqHb9R13fWTjxYzkUNgzCTGszq9Ct8xf
         OnMw==
X-Gm-Message-State: AOJu0YzErLeC2jW6d6gl4rKMo/Q2bviJKpz0zTG6M1RxK1M0VburjG8G
	eqtXRfjxtCccCS0l6kLmZ2G9YfOVCkEnHVLwRPEt7XSdcCR0ZKUJuakccxAr0F2l5uTCM/LgDY9
	gNK56wSWLJhGLf1oj6UvJsNCwnAo=
X-Google-Smtp-Source: AGHT+IHZl6qVn4aL94x3N1I121jMh0jJ8/vwAzEo2eEacFquuNs5D0GH3++D5cgvcU23j/dDYHS/DKSRxcmoRSmexxA=
X-Received: by 2002:a05:6902:1608:b0:e02:b60c:3d2 with SMTP id
 3f1490d57ef6-e1180fe2795mr8287919276.50.1723933543181; Sat, 17 Aug 2024
 15:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813184943.3759630-1-martin.lau@linux.dev> <20240813184943.3759630-2-martin.lau@linux.dev>
In-Reply-To: <20240813184943.3759630-2-martin.lau@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 17 Aug 2024 15:25:32 -0700
Message-ID: <CAMB2axNnLv1V4GtzyUgjXubOQR3eyYjS8jopSFkoRmOhZsOQXw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Add gen_epilogue to bpf_verifier_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:49=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
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
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
> The .gen_epilogue will need 8 extra bytes in the stack to save
> the ctx pointer. It is now done after the check_max_stack_depth.
> The ctx pointer saving will need to be done earlier before
> check_max_stack_depth.
>
>  include/linux/bpf.h   |  2 ++
>  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b9425e410bcb..2de67bc497f4 100644
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

Hi Martin,

Thanks for working on this set! This patch looks good to me.

Thanks,
Amery

