Return-Path: <bpf+bounces-77999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA26CF9EDB
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2771F316CEF9
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91FF35CB6B;
	Tue,  6 Jan 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYkM+Y3e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577D2D1F4E
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721623; cv=none; b=oGuD6TTEwFZz719yCr+cy8JO3MFl4cs4Yz+sM8rkjsU+Ch6cLW4yIwn4pKmSdC45ZGp6gdP+bImEiprsF9/vFGimuCUJIkjD4QIOcSUZgmq0dAOtgnpRfl46Gj818w3/79w4tHChUMMykcyC4z3T3H6gZEPNZySqd788yX1qXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721623; c=relaxed/simple;
	bh=LzKfxHjX021Rxx+qaw878w7fZbqLwVrvpIS9AwzUcK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3n1Osb8BizuYzUBPN8Y8INtwXVHq43ENtOSiRYRCDe7q3qt2qLecRXmRe8UCEPXVvXwaYdK9q++uNVj9A9tHXVnxgnVwhR+Z+GOpwkb21XZLYVsRdx9LxQ+i3f2Q0yQrUZST5dw0i2sKfPh852JxqXjM+SBPKWBAl5OXOIAzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYkM+Y3e; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fc7892214so14884377b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767721621; x=1768326421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv2VrgKte6EWJ3FJ6GQEY33foa+IgMPhHq/ka7xvnq0=;
        b=bYkM+Y3e2J7Gjc8hmeLzdBU7Jb632MqCXWD33vHGFJDETlPMdrO96VDUge34GqqsDU
         qMIVibPLo7qPv4wIHrRdI3aIW7pGLYdDnjvcVyi9H+W3i92SvGnLPLGcn1I54AWu5b6Q
         qA0X9cTYwG+Pb8bgO0NjoUsozmtELEXNn6HVErPsBwzkzmxGSFAsy3iEi+kLrIqMV7m8
         u46A7rLGJe9IEzTE6+JWfmJJRZaF5l1eEFBQ+MG3bqoM2OwKgIbtHPWqH9nroMdyqJ5Q
         f8rbiFXn8MBqP/s3fiBy6C+PDd8P79Hxzo6eN5/MM4GbUWGzXPZhC8mMpQrgClYRzgx0
         FQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767721621; x=1768326421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sv2VrgKte6EWJ3FJ6GQEY33foa+IgMPhHq/ka7xvnq0=;
        b=OfQTvN/eYKMyzVBETMpf2ZE/WvqPwE2YcAm7nJJpXHthG/2RyQLevKMwuVSoBx6HVp
         oasBh2jIfR2KWHyIAA/5JbIrTZ06122Rspycq2D1Cw6r4LdZ6fmFsenz50C06jJEyCGl
         Gnv43F4DBmvhPA5JihCHW+rO15dPiiZjCThfwG+gM4UCEVPmkDMe6faESO6Y6d0D55IS
         5ylnWeYwDUEZRWq+skqpurmFfWmMJ/Merzt66hbwLuRB+bvmDLYpJR+cMS4wkZb82F4C
         g6KJSeM3f3jGo02M5EENz3sm7rO/Eq/UAXeu1PYjhAElJsCyQLQ+4XhOlf2w3bX8V7Q7
         RMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCOBzStrL5k49153tmHifFoKTj5LmouZDSm3ywhRg2X3D5msYuy0kTPIYcUeittc59q6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiol4AVGqsIP10ObfqhoqSDmKfRRQs0HnRvs6Q3S1OS6FUH09
	5chaAltKiHxkSdS3EMQA4EywxChuioj0Au7pYRyMrYzYBamvsE2BqC5MpCteOCY3qrrJWLvnF9P
	DWDf126UtE/PQ1mA1lR2nZgAZ10n3+KY=
X-Gm-Gg: AY/fxX4ZU+krGISGGFAhx8vcviAfRZYSV5tlJUphmTyr+tpUmi55+84NKRGbTjdkuXk
	x8cO3x1m3lESo5/YyxmHyQsCZRChBTaXoNFYt94ullMXwGDGY5l5Caft6Dabrl2/eh8UkAAjfjW
	yQcUl8TeBo+GnF6Yia8zg9A/2v0/Zh4mfYewKVk2k4FLtiLurZGebiZmC1XIWxu6MAo7vXxbQDO
	P/w2hms/WsVaxbPQVv1JrrBDaKoLk37AcXn1G4MTXd4svVRduXefyNLPuIp5A95TUr1KrEd
X-Google-Smtp-Source: AGHT+IERToY74CI7cXx/KiVYNfIBtr5nmAjqCE4NqRO3Ki/CRNEGFkp2dh8zFJhv1rlECfgmHAhJSgACaxxTE4dpgoQ=
X-Received: by 2002:a05:690e:b8e:b0:63f:a228:1859 with SMTP id
 956f58d0204a3-6470c86845dmr2505982d50.38.1767721620672; Tue, 06 Jan 2026
 09:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
 <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev> <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
 <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev> <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
 <CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com> <877btu8wz2.fsf@cloudflare.com>
In-Reply-To: <877btu8wz2.fsf@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Jan 2026 09:46:49 -0800
X-Gm-Features: AQt7F2pVAO8XtXX10DUe6F66fyGvQEPlQzlAGBMU0yOXV1BoNv6h0nbWs4BgUcQ
Message-ID: <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:36=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Mon, Jan 05, 2026 at 06:04 PM -08, Alexei Starovoitov wrote:
> > On Mon, Jan 5, 2026 at 3:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >>
> >> >
> >> > >
> >> > > I guess we can mark such emitted call in insn_aux_data as finalize=
d
> >> > > and get_func_proto() isn't needed.
> >> >
> >> > It is a good idea.
> >> >
> >>
> >> Hmm, insn_aux_data has to be marked in gen_{pro,epi}logue since this
> >> is the only place we know whether the call needs fixup or not. However
> >> insn_aux_data is not available yet in gen_{pro,epi}logue because we
> >> haven't resized insn_aux_data.
> >>
> >> Can we do some hack based on the fact that calls emitted by
> >> BPF_EMIT_CALL() are finalized while calls emitted by BPF_RAW_INSN()
> >> most likely are not?
> >> Let BPF_EMIT_CALL() mark the call insn as finalized temporarily (e.g.,
> >> .off =3D 1). Then, when do_misc_fixups() encounters it just reset off =
to
> >> 0 and don't call get_func_proto().
> >
> > marking inside insn via off=3D1 or whatever is an option,
> > but once we remove BPF_CALL_KFUNC from gen_prologue we can
> > delete add_kfunc_in_insns() altogether and replace it with
> > a similar loop that does
> > if (bpf_helper_call()) mark insn_aux_data.
> >
> > That would be a nice benefit, since add_kfunc_call() from there
> > was always a bit odd, since we're adding kfuncs early before the main
> > verifier pass and after, because of gen_prologue.
>
> Thanks for all the pointers.
>
> I understood we're looking for something like this:
>
> ---8<---
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b32ddf0f0ab3..9ccd56c04a45 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
>         bool non_sleepable; /* helper/kfunc may be called from non-sleepa=
ble context */
>         bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>         bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with pro=
g percpu alloc */
> +       bool finalized_call; /* call holds function offset relative to __=
bpf_base_call */
>         u8 alu_state; /* used in combination with alu_limit */
>         /* true if STX or LDX instruction is a part of a spill/fill
>          * pattern for a bpf_fastcall call.
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1ca5c5e895ee..cc737d103cdd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21806,6 +21806,14 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
>                         env->prog =3D new_prog;
>                         delta +=3D cnt - 1;
>
> +                       /* gen_prologue emits function calls with target =
address
> +                        * relative to __bpf_call_base. Skip patch_call_i=
mm fixup.
> +                        */
> +                       for (i =3D 0; i < cnt - 1; i++) {
> +                               if (bpf_helper_call(&env->prog->insnsi[i]=
))
> +                                       env->insn_aux_data[i].finalized_c=
all =3D true;
> +                       }
> +
>                         ret =3D add_kfunc_in_insns(env, insn_buf, cnt - 1=
);

And then we can get rid of this function as there is no use case for
having a new kfunc in gen_{pro,epi}logue.

>                         if (ret < 0)
>                                 return ret;
> @@ -23412,6 +23420,9 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         goto next_insn;
>                 }
>  patch_call_imm:
> +               if (env->insn_aux_data[i + delta].finalized_call)
> +                       goto next_insn;
> +
>                 fn =3D env->ops->get_func_proto(insn->imm, env->prog);
>                 /* all functions that have prototype and verifier allowed
>                  * programs to call them, must be real in-kernel function=
s
> @@ -23423,6 +23434,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         return -EFAULT;
>                 }
>                 insn->imm =3D fn->func - __bpf_call_base;
> +               env->insn_aux_data[i + delta].finalized_call =3D true;
>  next_insn:
>                 if (subprogs[cur_subprog + 1].start =3D=3D i + delta + 1)=
 {
>                         subprogs[cur_subprog].stack_depth +=3D stack_dept=
h_extra;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f5bc6a505e1..53993c2c492d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *in=
sn_buf, u32 pkt_access_flags,
>         /* ret =3D bpf_skb_pull_data(skb, 0); */
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>         *insn++ =3D BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
> -       *insn++ =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> -                              BPF_FUNC_skb_pull_data);

This is why I was suggesting setting off =3D 1 in BPF_EMIT_CALL to mark
a call as finalized. So that we can continue to support using
BPF_RAW_INSN to emit a helper call in prologue and epilogue.

> +       *insn++ =3D BPF_EMIT_CALL(bpf_skb_pull_data);
>         /* if (!ret)
>          *      goto restore;
>          * return TC_ACT_SHOT;
> @@ -9135,11 +9134,8 @@ static int bpf_gen_ld_abs(const struct bpf_insn *o=
rig,
>         return insn - insn_buf;
>  }
>
> -__bpf_kfunc_start_defs();
> -
> -__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> +static void bpf_skb_meta_realign(struct sk_buff *skb)
>  {
> -       struct sk_buff *skb =3D (typeof(skb))skb_;
>         u8 *meta_end =3D skb_metadata_end(skb);
>         u8 meta_len =3D skb_metadata_len(skb);
>         u8 *meta;
> @@ -9161,14 +9157,6 @@ __bpf_kfunc void bpf_skb_meta_realign(struct __sk_=
buff *skb_)
>         bpf_compute_data_pointers(skb);
>  }
>
> -__bpf_kfunc_end_defs();
> -
> -BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> -BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> -BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> -
> -BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
> -
>  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access=
_flags,
>                                const struct bpf_prog *prog)
>  {
> @@ -9182,8 +9170,10 @@ static int tc_cls_act_prologue(struct bpf_insn *in=
sn_buf, u32 pkt_access_flags,
>                  * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
>                  * r1 =3D r6;
>                  */
> +               BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
> +                                         (void (*)(struct sk_buff *skb))=
NULL));
>                 *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> -               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0]=
);
> +               *insn++ =3D BPF_EMIT_CALL(bpf_skb_meta_realign);
>                 *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
>         }
>         cnt =3D bpf_unclone_prologue(insn, pkt_access_flags, prog, TC_ACT=
_SHOT);

