Return-Path: <bpf+bounces-47256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF359F6B9E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA001890E70
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124221F891F;
	Wed, 18 Dec 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKgCYADd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8073597A;
	Wed, 18 Dec 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541065; cv=none; b=hYgR4K+LEB/gIX/JWPo6bL75ir2J61icxn8QCILXGPonCm5Rh28WQm+N768/NKHHDsVPfncNG71u0uTxe39zk3ytRWXkOA2JtRdz8raWtSgd6HESyVDSLXJ2BlRPM1yOVGgltYGb5ScWYrINe3Sgr4twz7pB/SIjIcLmV2stryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541065; c=relaxed/simple;
	bh=aUzLcvB9geGmPbPgUzoZulDEPZvM8m64efh+McmXyzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDAAqdVK7ETZg6etvgkUHZrZKNycJKIk6uL69J+Ka740TawtTp1G7RipIwGvIk/o+USVsDCAHaSxl2srNPYXvgv6/MM/sxLeg2A13sUvsOpMTQbTGg8ttjlLRvtL6EGuiNS6FjUVn6afYTxZq1ZTm74KK2FKNkL5iJfv52Mk7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKgCYADd; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f3d31808e3so7026287b3.3;
        Wed, 18 Dec 2024 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734541063; x=1735145863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/uvgBRNK/TgQMPLkxxDOC9d3RFwEW5+99Qz0ixoI7M=;
        b=ZKgCYADdeZWGKf/EIn6zR4g/l9s+O0R51G0buiN3a5XMdEeLel/SjBjdW84UcyZcQT
         ybq643FXbp0fwY7qxV1oeHFtkiK5TovLYwIhXUCHELlvErUZpchJ25LEw+l2ZKCin169
         YjtdJWlq3N85RlY6HvtArzon+oIbLMphot1IPXWqDmzddkeZhkv7MVzWDt0+TVMwwqhC
         H1nxBPgKg4kUXnc7e5+j/An+Zfi4A/ORBW/PZcoxPolPlVZXnRyM1mBbdTITNzr48j7Z
         hDRjtWMHTVcLYlN0Qjl+7ujC6owgdQdmxwUg9U2KhzUJ6Ilxxj82DkoBlutlytQMOaUZ
         0SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734541063; x=1735145863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/uvgBRNK/TgQMPLkxxDOC9d3RFwEW5+99Qz0ixoI7M=;
        b=Pe06Av5ngE6TA/NUxn80XU5Vjc78X40pT0LQ9iU0YIFDI/E0Rpil5XXpv/4C1G3XoU
         UwqM5NbLYtHd0ocdSTnLO3by16IZrAIFUZr+ooTf0eKf2Pb1ZoWhtQ1Wr5L2PZsvAxqN
         Pb1cIC8XuhgvbiVrXDl7qr72ITeVH1VpKaBCeRBYKVCR9nKs9q+WvsoEEJNjLhGab/om
         VHVMoJO1leXx5uFwXFj25DdPEvWlxbZ+Fq4SSkoekYN99f5OCD+x7VFRsMcwab57DErU
         VgG23oHREmUHv2PrOuG2hFRfznpg2SZFyiY7rGvmPsAcH2TzdI0cIvEA2FjwDJyoOKJY
         P2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUzj+rlS9gC2LaFbnnZ1wSUH99F+UT/OZ9aiE6FohcliXHtR36JzegeRktrys9fZNUd8gHnJpkf@vger.kernel.org, AJvYcCXMttnr2EcA/bYEBDARUntSiv9HY+gIfNXi3D2wu79yxkAA2uHL03/G7cZP7HNAomhYBjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJqExl462UMUW0uYyGWUMVMNR92WB5xdkPmm/eWvFaXlu8GeT
	qVFUGvR6JAz4u/0cPESge9YyjNodpALor+urk+RR7KTumdFFBu9bBem9XderjYUfU2eiTv0Mbxt
	rpOeEi23e44R7wc6n3ooXd4OVq3c=
X-Gm-Gg: ASbGncsnDZSIYTLtfbYlVx11UUz2dgitvaQd+TwUBJiS475k9W7NmBB8WwMQ+m0EDL2
	qy2Lhd6etq1sx9YZ2PQ/pf5xNodmXWaiheGG9RBE=
X-Google-Smtp-Source: AGHT+IFTYoFeQw4LGqAoHywDgTmPxzdT3Of38YFQt0Uw+IgJqUs3SzlDUldS0ESpheOI3E2CndVjfGuDx4U3LPxb3YE=
X-Received: by 2002:a05:690c:6210:b0:6ef:4a57:fc7c with SMTP id
 00721157ae682-6f3d0f2bbbfmr29852327b3.16.1734541062657; Wed, 18 Dec 2024
 08:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-2-amery.hung@bytedance.com> <65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
In-Reply-To: <65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 18 Dec 2024 08:57:31 -0800
Message-ID: <CAMB2axOPhr4fMa0J+u_V4TauohzUTwEex6HMwtgdoa8pqT0Mgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Support getting referenced kptr
 from struct_ops argument
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 3:29 PM, Amery Hung wrote:
> > Allows struct_ops programs to acqurie referenced kptrs from arguments
> > by directly reading the argument.
> >
> > The verifier will acquire a reference for struct_ops a argument tagged
> > with "__ref" in the stub function in the beginning of the main program.
> > The user will be able to access the referenced kptr directly by reading
> > the context as long as it has not been released by the program.
> >
> > This new mechanism to acquire referenced kptr (compared to the existing
> > "kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic reaso=
ns.
> > In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
> > first argument. This mechanism provides a natural way for users to get =
a
> > referenced kptr in the .enqueue struct_ops programs and makes sure that=
 a
> > qdisc will always enqueue or drop the skb.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   include/linux/bpf.h         |  3 +++
> >   kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
> >   kernel/bpf/btf.c            |  1 +
> >   kernel/bpf/verifier.c       | 35 ++++++++++++++++++++++++++++++++---
> >   4 files changed, 56 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 1b84613b10ac..72bf941d1daf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -968,6 +968,7 @@ struct bpf_insn_access_aux {
> >               struct {
> >                       struct btf *btf;
> >                       u32 btf_id;
> > +                     u32 ref_obj_id;
> >               };
> >       };
> >       struct bpf_verifier_log *log; /* for verbose logs */
> > @@ -1480,6 +1481,8 @@ struct bpf_ctx_arg_aux {
> >       enum bpf_reg_type reg_type;
> >       struct btf *btf;
> >       u32 btf_id;
> > +     u32 ref_obj_id;
> > +     bool refcounted;
> >   };
> >
> >   struct btf_mod_pair {
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index fda3dd2ee984..6e7795744f6a 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -145,6 +145,7 @@ void bpf_struct_ops_image_free(void *image)
> >   }
> >
> >   #define MAYBE_NULL_SUFFIX "__nullable"
> > +#define REFCOUNTED_SUFFIX "__ref"
> >   #define MAX_STUB_NAME 128
> >
> >   /* Return the type info of a stub function, if it exists.
> > @@ -206,9 +207,11 @@ static int prepare_arg_info(struct btf *btf,
> >                           struct bpf_struct_ops_arg_info *arg_info)
> >   {
> >       const struct btf_type *stub_func_proto, *pointed_type;
> > +     bool is_nullable =3D false, is_refcounted =3D false;
> >       const struct btf_param *stub_args, *args;
> >       struct bpf_ctx_arg_aux *info, *info_buf;
> >       u32 nargs, arg_no, info_cnt =3D 0;
> > +     const char *suffix;
> >       u32 arg_btf_id;
> >       int offset;
> >
> > @@ -240,12 +243,19 @@ static int prepare_arg_info(struct btf *btf,
> >       info =3D info_buf;
> >       for (arg_no =3D 0; arg_no < nargs; arg_no++) {
> >               /* Skip arguments that is not suffixed with
> > -              * "__nullable".
> > +              * "__nullable or __ref".
> >                */
> > -             if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> > -                                         MAYBE_NULL_SUFFIX))
> > +             is_nullable =3D btf_param_match_suffix(btf, &stub_args[ar=
g_no],
> > +                                                  MAYBE_NULL_SUFFIX);
> > +             is_refcounted =3D btf_param_match_suffix(btf, &stub_args[=
arg_no],
> > +                                                    REFCOUNTED_SUFFIX)=
;
> > +             if (!is_nullable && !is_refcounted)
> >                       continue;
> >
> > +             if (is_nullable)
> > +                     suffix =3D MAYBE_NULL_SUFFIX;
> > +             else if (is_refcounted)
> > +                     suffix =3D REFCOUNTED_SUFFIX;
> >               /* Should be a pointer to struct */
> >               pointed_type =3D btf_type_resolve_ptr(btf,
> >                                                   args[arg_no].type,
> > @@ -253,7 +263,7 @@ static int prepare_arg_info(struct btf *btf,
> >               if (!pointed_type ||
> >                   !btf_type_is_struct(pointed_type)) {
> >                       pr_warn("stub function %s__%s has %s tagging to a=
n unsupported type\n",
> > -                             st_ops_name, member_name, MAYBE_NULL_SUFF=
IX);
> > +                             st_ops_name, member_name, suffix);
> >                       goto err_out;
> >               }
> >
> > @@ -271,11 +281,15 @@ static int prepare_arg_info(struct btf *btf,
> >               }
> >
> >               /* Fill the information of the new argument */
> > -             info->reg_type =3D
> > -                     PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> >               info->btf_id =3D arg_btf_id;
> >               info->btf =3D btf;
> >               info->offset =3D offset;
> > +             if (is_nullable) {
> > +                     info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID | =
PTR_MAYBE_NULL;
> > +             } else if (is_refcounted) {
> > +                     info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID;
> > +                     info->refcounted =3D true;
> > +             }
> >
> >               info++;
> >               info_cnt++;
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index e7a59e6462a9..a05ccf9ee032 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6580,6 +6580,7 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >                       info->reg_type =3D ctx_arg_info->reg_type;
> >                       info->btf =3D ctx_arg_info->btf ? : btf_vmlinux;
> >                       info->btf_id =3D ctx_arg_info->btf_id;
> > +                     info->ref_obj_id =3D ctx_arg_info->ref_obj_id;
> >                       return true;
> >               }
> >       }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9f5de8d4fbd0..69753096075f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1402,6 +1402,17 @@ static int release_reference_state(struct bpf_fu=
nc_state *state, int ptr_id)
> >       return -EINVAL;
> >   }
> >
> > +static bool find_reference_state(struct bpf_func_state *state, int ptr=
_id)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < state->acquired_refs; i++)
> > +             if (state->refs[i].id =3D=3D ptr_id)
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +
> >   static int release_lock_state(struct bpf_func_state *state, int type,=
 int id, void *ptr)
> >   {
> >       int i, last_idx;
> > @@ -5798,7 +5809,8 @@ static int check_packet_access(struct bpf_verifie=
r_env *env, u32 regno, int off,
> >   /* check access to 'struct bpf_context' fields.  Supports fixed offse=
ts only */
> >   static int check_ctx_access(struct bpf_verifier_env *env, int insn_id=
x, int off, int size,
> >                           enum bpf_access_type t, enum bpf_reg_type *re=
g_type,
> > -                         struct btf **btf, u32 *btf_id, bool *is_retva=
l, bool is_ldsx)
> > +                         struct btf **btf, u32 *btf_id, bool *is_retva=
l, bool is_ldsx,
> > +                         u32 *ref_obj_id)
> >   {
> >       struct bpf_insn_access_aux info =3D {
> >               .reg_type =3D *reg_type,
> > @@ -5820,8 +5832,16 @@ static int check_ctx_access(struct bpf_verifier_=
env *env, int insn_idx, int off,
> >               *is_retval =3D info.is_retval;
> >
> >               if (base_type(*reg_type) =3D=3D PTR_TO_BTF_ID) {
> > +                     if (info.ref_obj_id &&
> > +                         !find_reference_state(cur_func(env), info.ref=
_obj_id)) {
> > +                             verbose(env, "invalid bpf_context access =
off=3D%d. Reference may already be released\n",
> > +                                     off);
> > +                             return -EACCES;
> > +                     }
> > +
> >                       *btf =3D info.btf;
> >                       *btf_id =3D info.btf_id;
> > +                     *ref_obj_id =3D info.ref_obj_id;
> >               } else {
> >                       env->insn_aux_data[insn_idx].ctx_field_size =3D i=
nfo.ctx_field_size;
> >               }
> > @@ -7135,7 +7155,7 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
> >               struct bpf_retval_range range;
> >               enum bpf_reg_type reg_type =3D SCALAR_VALUE;
> >               struct btf *btf =3D NULL;
> > -             u32 btf_id =3D 0;
> > +             u32 btf_id =3D 0, ref_obj_id =3D 0;
> >
> >               if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
> >                   is_pointer_value(env, value_regno)) {
> > @@ -7148,7 +7168,7 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
> >                       return err;
> >
> >               err =3D check_ctx_access(env, insn_idx, off, size, t, &re=
g_type, &btf,
> > -                                    &btf_id, &is_retval, is_ldsx);
> > +                                    &btf_id, &is_retval, is_ldsx, &ref=
_obj_id);
> >               if (err)
> >                       verbose_linfo(env, insn_idx, "; ");
> >               if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
> > @@ -7179,6 +7199,7 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
> >                               if (base_type(reg_type) =3D=3D PTR_TO_BTF=
_ID) {
> >                                       regs[value_regno].btf =3D btf;
> >                                       regs[value_regno].btf_id =3D btf_=
id;
> > +                                     regs[value_regno].ref_obj_id =3D =
ref_obj_id;
> >                               }
> >                       }
> >                       regs[value_regno].type =3D reg_type;
> > @@ -21662,6 +21683,7 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
> >   {
> >       bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
> >       struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
> > +     struct bpf_ctx_arg_aux *ctx_arg_info;
> >       struct bpf_verifier_state *state;
> >       struct bpf_reg_state *regs;
> >       int ret, i;
> > @@ -21769,6 +21791,13 @@ static int do_check_common(struct bpf_verifier=
_env *env, int subprog)
> >               mark_reg_known_zero(env, regs, BPF_REG_1);
> >       }
> >
> > +     if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) =
{
> > +             ctx_arg_info =3D (struct bpf_ctx_arg_aux *)env->prog->aux=
->ctx_arg_info;
> > +             for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; i++)
> > +                     if (ctx_arg_info[i].refcounted)
> > +                             ctx_arg_info[i].ref_obj_id =3D acquire_re=
ference_state(env, 0);
>
> There is a conflict in the bpf-next/master. acquire_reference_state has b=
een
> refactored in commit 769b0f1c8214. From looking at the net/sched/sch_*.c
> changes, they should not have conflict with the net-next/main. I would su=
ggest
> to rebase this set on bpf-next/master.
>

Thanks, I have rebased it and will send a new version.

> At the first glance, the ref_obj_id assignment looks racy because ctx_arg=
_info
> is shared by different bpf progs that may be verified in parallel. After =
another
> thought, this should be fine because it should always end up having the s=
ame
> ref_obj_id for the same arg-no, right? Not sure if UBSAN can understand t=
his
> without using the READ/WRITE_ONCE. but adding READ/WRITE_ONCE when using
> ref_obj_id will be quite puzzling when reading the verifier code. Any bet=
ter idea?
>

It looks like ref_obj_id cannot be reused (id always comes from
++env->id_gen), and these will be the earliest references to acquire.
So, maybe we can assume the ref_obj_id without needing to store it in
ctx_arg_info? E.g., the first __ref argument's ref_obj_id is always 1.

> Other than the subprog, afaik, the bpf prog triggered by the bpf_tail_cal=
l can
> also take the 'u64 *ctx' array. May be disallow using tailcall in all ops=
 in the
> bpf qdisc. env->subprog_info[i].has_tail_call has already tracked whether=
 the
> tail_call is used.
>
> > +     }
> > +
> >       ret =3D do_check(env);
> >   out:
> >       /* check for NULL is necessary, since cur_state can be freed insi=
de
>

