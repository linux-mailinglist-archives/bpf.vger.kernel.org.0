Return-Path: <bpf+bounces-47254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B561A9F6AC0
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4CE16931B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6511F03DA;
	Wed, 18 Dec 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0QKUYQf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66F1C5CD5;
	Wed, 18 Dec 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538177; cv=none; b=bhFbLPxIRIaC0cGpjW+RYmsG2AbmNNoFvxHbhOqgf5wNKnRIRJsqz27vNAHboAm3ci4Ktw/CLxLvbLqy6my4NydzsjCskGd4aQ/4ffzZB71XkLUhIs6D+m4qPhhxulm50Z6IB6rxLEqP4RNOwEIXXUsOfimni5+bGIappEIZ/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538177; c=relaxed/simple;
	bh=wJKhgisNkZTltomnjaZsxVp9WKwa2Y6vdNsuAiTYLrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMTAGqnyF3v1vTFpsM1bU5NEiEiBZ1wNC6NnD2PMSRuXFR1dx7GKQuLD8S9b3kBJUVX8jVeO6/4P+xjyhLyPFMOZHbbvPs2n6mWYxBpG0j3Rv0+Zuc4bYBq9Exv9ZFYck2PQVnZEs6+/w1VV50/VKOVu0TAL51Qlj/1qKUhii5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0QKUYQf; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f29aa612fbso27754057b3.0;
        Wed, 18 Dec 2024 08:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734538174; x=1735142974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih+NhiJ0JxA6swkLXuDpY8nDVKOZU80Ab9fCRzKelCI=;
        b=X0QKUYQfJRernTBh3SgAw2+VxYlxQQZi/x/x2jXkW4sgIxhoYAPzCe3x3+ymenKxW6
         rhm3UqA+rLf6lRXouh+kEeCDTJ2dra79k79akiXu+6e+P6iB7Qs1LpYVADbXXchNEP7Y
         zKjOd5WbMBD3BZUxs1yxwHy5Y0l9ICeZJ63rLXI43TFvxjEpW/aWrv2SgYi5/2nx01EJ
         mQG5zkBbW1sJkniRP+OLA1Rxq/fVi3Ep23Xa4qTV087YA1YeJ9begZNbYV6813HAVrs0
         Nl4Bx0jUAfcsFPaovzBC8ktriGb/yjIixkfuDxz6WYEga1HRnie3hNZgjxoOYUX+qWoH
         vQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734538174; x=1735142974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ih+NhiJ0JxA6swkLXuDpY8nDVKOZU80Ab9fCRzKelCI=;
        b=sZB/r21qFmqzXCq+FkQAnwmiWreRorcTKHVeuxSkfDTKXCqNzug18r4agi8RsROrdr
         I8WxzkJQ4PhMdVDXck5GYfQqjz98ap2NrljdwwJderWL+JJVBRxfK7+UV+Cc6DitU+OC
         qJ8z+oX7TnQYh1vZYok1y/Aiz7FrOwrwG9bHcnvhG7I96cAO4CV820rJ/JCbzBNgCM1B
         AfA327JB64frzob/9be7wNXG7pW4uc6tvP1oLBihzwCn8sj6q4W0XC60xjFh0t2xliq6
         rRDWjws3dKzO5DJNxYEl/YiXkfYQ4ZIOR3qvOjIM9+E8RuRvBPIhqcvbdE+syzRiwpIF
         7H7w==
X-Forwarded-Encrypted: i=1; AJvYcCWMe2CqFKaJ/MqtkE0+kCs+5LB2v69iFVLVXPnThlTZ1RSrO+Cudd5wcGdK9oo6m5WDnveCU+8Q@vger.kernel.org, AJvYcCWRnnDYu5ZeflDLgwTiiG1DiseRaCfcfDvvhAm8rFTQNMy8pPy4vVznolJlAOEazeefLU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzssUnucZpmjz8koSy7G12OgFHWMGYltz+QwtWHcbWy8Mbi6kb
	W8Q29TkjYn8E38eH2icp+r+S+XupBwQSWWNwHz5h1J6nJNZzawoJFSKe4yWNc9/esRyJ5OSh9DQ
	b1DGbMLWdFvI8KQSfpS00tFFb5UM=
X-Gm-Gg: ASbGnctQV18QLmgaMdEGABTKNO3r/NR2OyrNeJA45He0izjQe3fhUQwNADvKDJP8JJh
	Z1zyUD/DdDpRDlaFJ4CDQvyvmPws8TUhb7mbdRwM=
X-Google-Smtp-Source: AGHT+IEV9ECTG06SwUj2E58GtfdA5Mw3cC5dKh3RafmjwxdEHFejVW6/Pw+EMizPnWxpSzzI6w79yK8vdwNyNxXOg88=
X-Received: by 2002:a05:690c:3504:b0:6ef:7f89:d906 with SMTP id
 00721157ae682-6f3d2697292mr26914787b3.33.1734538174429; Wed, 18 Dec 2024
 08:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-2-amery.hung@bytedance.com> <65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
 <CAADnVQ+LsEyADkSc7cNXkz=p5z-iNEoKRm25VpthCDAYe=0BVw@mail.gmail.com>
In-Reply-To: <CAADnVQ+LsEyADkSc7cNXkz=p5z-iNEoKRm25VpthCDAYe=0BVw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 18 Dec 2024 08:09:23 -0800
Message-ID: <CAMB2axMQ9iFv4XjH3X3QLozudpga=DPSYEgzt3thtMOjYnrv7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Support getting referenced kptr
 from struct_ops argument
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Amery Hung <amery.hung@bytedance.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	Cong Wang <xiyou.wangcong@gmail.com>, Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 5:24=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 17, 2024 at 4:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 12/13/24 3:29 PM, Amery Hung wrote:
> > > Allows struct_ops programs to acqurie referenced kptrs from arguments
> > > by directly reading the argument.
> > >
> > > The verifier will acquire a reference for struct_ops a argument tagge=
d
> > > with "__ref" in the stub function in the beginning of the main progra=
m.
> > > The user will be able to access the referenced kptr directly by readi=
ng
> > > the context as long as it has not been released by the program.
> > >
> > > This new mechanism to acquire referenced kptr (compared to the existi=
ng
> > > "kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic rea=
sons.
> > > In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
> > > first argument. This mechanism provides a natural way for users to ge=
t a
> > > referenced kptr in the .enqueue struct_ops programs and makes sure th=
at a
> > > qdisc will always enqueue or drop the skb.
> > >
> > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > ---
> > >   include/linux/bpf.h         |  3 +++
> > >   kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
> > >   kernel/bpf/btf.c            |  1 +
> > >   kernel/bpf/verifier.c       | 35 ++++++++++++++++++++++++++++++++--=
-
> > >   4 files changed, 56 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 1b84613b10ac..72bf941d1daf 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -968,6 +968,7 @@ struct bpf_insn_access_aux {
> > >               struct {
> > >                       struct btf *btf;
> > >                       u32 btf_id;
> > > +                     u32 ref_obj_id;
> > >               };
> > >       };
> > >       struct bpf_verifier_log *log; /* for verbose logs */
> > > @@ -1480,6 +1481,8 @@ struct bpf_ctx_arg_aux {
> > >       enum bpf_reg_type reg_type;
> > >       struct btf *btf;
> > >       u32 btf_id;
> > > +     u32 ref_obj_id;
> > > +     bool refcounted;
> > >   };
> > >
> > >   struct btf_mod_pair {
> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.=
c
> > > index fda3dd2ee984..6e7795744f6a 100644
> > > --- a/kernel/bpf/bpf_struct_ops.c
> > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > @@ -145,6 +145,7 @@ void bpf_struct_ops_image_free(void *image)
> > >   }
> > >
> > >   #define MAYBE_NULL_SUFFIX "__nullable"
> > > +#define REFCOUNTED_SUFFIX "__ref"
> > >   #define MAX_STUB_NAME 128
> > >
> > >   /* Return the type info of a stub function, if it exists.
> > > @@ -206,9 +207,11 @@ static int prepare_arg_info(struct btf *btf,
> > >                           struct bpf_struct_ops_arg_info *arg_info)
> > >   {
> > >       const struct btf_type *stub_func_proto, *pointed_type;
> > > +     bool is_nullable =3D false, is_refcounted =3D false;
> > >       const struct btf_param *stub_args, *args;
> > >       struct bpf_ctx_arg_aux *info, *info_buf;
> > >       u32 nargs, arg_no, info_cnt =3D 0;
> > > +     const char *suffix;
> > >       u32 arg_btf_id;
> > >       int offset;
> > >
> > > @@ -240,12 +243,19 @@ static int prepare_arg_info(struct btf *btf,
> > >       info =3D info_buf;
> > >       for (arg_no =3D 0; arg_no < nargs; arg_no++) {
> > >               /* Skip arguments that is not suffixed with
> > > -              * "__nullable".
> > > +              * "__nullable or __ref".
> > >                */
> > > -             if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> > > -                                         MAYBE_NULL_SUFFIX))
> > > +             is_nullable =3D btf_param_match_suffix(btf, &stub_args[=
arg_no],
> > > +                                                  MAYBE_NULL_SUFFIX)=
;
> > > +             is_refcounted =3D btf_param_match_suffix(btf, &stub_arg=
s[arg_no],
> > > +                                                    REFCOUNTED_SUFFI=
X);
> > > +             if (!is_nullable && !is_refcounted)
> > >                       continue;
> > >
> > > +             if (is_nullable)
> > > +                     suffix =3D MAYBE_NULL_SUFFIX;
> > > +             else if (is_refcounted)
> > > +                     suffix =3D REFCOUNTED_SUFFIX;
> > >               /* Should be a pointer to struct */
> > >               pointed_type =3D btf_type_resolve_ptr(btf,
> > >                                                   args[arg_no].type,
> > > @@ -253,7 +263,7 @@ static int prepare_arg_info(struct btf *btf,
> > >               if (!pointed_type ||
> > >                   !btf_type_is_struct(pointed_type)) {
> > >                       pr_warn("stub function %s__%s has %s tagging to=
 an unsupported type\n",
> > > -                             st_ops_name, member_name, MAYBE_NULL_SU=
FFIX);
> > > +                             st_ops_name, member_name, suffix);
> > >                       goto err_out;
> > >               }
> > >
> > > @@ -271,11 +281,15 @@ static int prepare_arg_info(struct btf *btf,
> > >               }
> > >
> > >               /* Fill the information of the new argument */
> > > -             info->reg_type =3D
> > > -                     PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> > >               info->btf_id =3D arg_btf_id;
> > >               info->btf =3D btf;
> > >               info->offset =3D offset;
> > > +             if (is_nullable) {
> > > +                     info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID =
| PTR_MAYBE_NULL;
> > > +             } else if (is_refcounted) {
> > > +                     info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID;
> > > +                     info->refcounted =3D true;
> > > +             }
> > >
> > >               info++;
> > >               info_cnt++;
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index e7a59e6462a9..a05ccf9ee032 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6580,6 +6580,7 @@ bool btf_ctx_access(int off, int size, enum bpf=
_access_type type,
> > >                       info->reg_type =3D ctx_arg_info->reg_type;
> > >                       info->btf =3D ctx_arg_info->btf ? : btf_vmlinux=
;
> > >                       info->btf_id =3D ctx_arg_info->btf_id;
> > > +                     info->ref_obj_id =3D ctx_arg_info->ref_obj_id;
> > >                       return true;
> > >               }
> > >       }
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 9f5de8d4fbd0..69753096075f 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1402,6 +1402,17 @@ static int release_reference_state(struct bpf_=
func_state *state, int ptr_id)
> > >       return -EINVAL;
> > >   }
> > >
> > > +static bool find_reference_state(struct bpf_func_state *state, int p=
tr_id)
> > > +{
> > > +     int i;
> > > +
> > > +     for (i =3D 0; i < state->acquired_refs; i++)
> > > +             if (state->refs[i].id =3D=3D ptr_id)
> > > +                     return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > >   static int release_lock_state(struct bpf_func_state *state, int typ=
e, int id, void *ptr)
> > >   {
> > >       int i, last_idx;
> > > @@ -5798,7 +5809,8 @@ static int check_packet_access(struct bpf_verif=
ier_env *env, u32 regno, int off,
> > >   /* check access to 'struct bpf_context' fields.  Supports fixed off=
sets only */
> > >   static int check_ctx_access(struct bpf_verifier_env *env, int insn_=
idx, int off, int size,
> > >                           enum bpf_access_type t, enum bpf_reg_type *=
reg_type,
> > > -                         struct btf **btf, u32 *btf_id, bool *is_ret=
val, bool is_ldsx)
> > > +                         struct btf **btf, u32 *btf_id, bool *is_ret=
val, bool is_ldsx,
> > > +                         u32 *ref_obj_id)
> > >   {
> > >       struct bpf_insn_access_aux info =3D {
> > >               .reg_type =3D *reg_type,
> > > @@ -5820,8 +5832,16 @@ static int check_ctx_access(struct bpf_verifie=
r_env *env, int insn_idx, int off,
> > >               *is_retval =3D info.is_retval;
> > >
> > >               if (base_type(*reg_type) =3D=3D PTR_TO_BTF_ID) {
> > > +                     if (info.ref_obj_id &&
> > > +                         !find_reference_state(cur_func(env), info.r=
ef_obj_id)) {
> > > +                             verbose(env, "invalid bpf_context acces=
s off=3D%d. Reference may already be released\n",
> > > +                                     off);
> > > +                             return -EACCES;
> > > +                     }
> > > +
> > >                       *btf =3D info.btf;
> > >                       *btf_id =3D info.btf_id;
> > > +                     *ref_obj_id =3D info.ref_obj_id;
> > >               } else {
> > >                       env->insn_aux_data[insn_idx].ctx_field_size =3D=
 info.ctx_field_size;
> > >               }
> > > @@ -7135,7 +7155,7 @@ static int check_mem_access(struct bpf_verifier=
_env *env, int insn_idx, u32 regn
> > >               struct bpf_retval_range range;
> > >               enum bpf_reg_type reg_type =3D SCALAR_VALUE;
> > >               struct btf *btf =3D NULL;
> > > -             u32 btf_id =3D 0;
> > > +             u32 btf_id =3D 0, ref_obj_id =3D 0;
> > >
> > >               if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
> > >                   is_pointer_value(env, value_regno)) {
> > > @@ -7148,7 +7168,7 @@ static int check_mem_access(struct bpf_verifier=
_env *env, int insn_idx, u32 regn
> > >                       return err;
> > >
> > >               err =3D check_ctx_access(env, insn_idx, off, size, t, &=
reg_type, &btf,
> > > -                                    &btf_id, &is_retval, is_ldsx);
> > > +                                    &btf_id, &is_retval, is_ldsx, &r=
ef_obj_id);
> > >               if (err)
> > >                       verbose_linfo(env, insn_idx, "; ");
> > >               if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
> > > @@ -7179,6 +7199,7 @@ static int check_mem_access(struct bpf_verifier=
_env *env, int insn_idx, u32 regn
> > >                               if (base_type(reg_type) =3D=3D PTR_TO_B=
TF_ID) {
> > >                                       regs[value_regno].btf =3D btf;
> > >                                       regs[value_regno].btf_id =3D bt=
f_id;
> > > +                                     regs[value_regno].ref_obj_id =
=3D ref_obj_id;
> > >                               }
> > >                       }
> > >                       regs[value_regno].type =3D reg_type;
> > > @@ -21662,6 +21683,7 @@ static int do_check_common(struct bpf_verifie=
r_env *env, int subprog)
> > >   {
> > >       bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
> > >       struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
> > > +     struct bpf_ctx_arg_aux *ctx_arg_info;
> > >       struct bpf_verifier_state *state;
> > >       struct bpf_reg_state *regs;
> > >       int ret, i;
> > > @@ -21769,6 +21791,13 @@ static int do_check_common(struct bpf_verifi=
er_env *env, int subprog)
> > >               mark_reg_known_zero(env, regs, BPF_REG_1);
> > >       }
> > >
> > > +     if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS=
) {
> > > +             ctx_arg_info =3D (struct bpf_ctx_arg_aux *)env->prog->a=
ux->ctx_arg_info;
> > > +             for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; i+=
+)
> > > +                     if (ctx_arg_info[i].refcounted)
> > > +                             ctx_arg_info[i].ref_obj_id =3D acquire_=
reference_state(env, 0);
> >
> > There is a conflict in the bpf-next/master. acquire_reference_state has=
 been
> > refactored in commit 769b0f1c8214. From looking at the net/sched/sch_*.=
c
> > changes, they should not have conflict with the net-next/main. I would =
suggest
> > to rebase this set on bpf-next/master.
> >
> > At the first glance, the ref_obj_id assignment looks racy because ctx_a=
rg_info
> > is shared by different bpf progs that may be verified in parallel. Afte=
r another
> > thought, this should be fine because it should always end up having the=
 same
> > ref_obj_id for the same arg-no, right? Not sure if UBSAN can understand=
 this
> > without using the READ/WRITE_ONCE. but adding READ/WRITE_ONCE when usin=
g
> > ref_obj_id will be quite puzzling when reading the verifier code. Any b=
etter idea?
>
> ctx_arg_info is kinda read-only from the verifier pov.
> bpf_ctx_arg_aux->btf_id is populated before the main verifier loop.
> While ref_obj_id is a dynamic property.
> It doesn't really fit in bpf_ctx_arg_aux.
> It probably needs to be another struct type that is allocated
> and populated once with acquire_reference() when the main verifier loop
> is happening.
> do_check_common() maybe too early?
> Looks like it's anyway a reference that is ok to leak per patch 3 ?
>
> It seems the main goal is to pass ref_obj_id-like argument into bpf prog
> and make sure that prog doesn't call KF_RELEASE kfunc on it twice,
> but leaking is ok?
> Maybe it needs a different type. Other than REF_TYPE_PTR.
>

The main goal of this patch is to get a unique ref_obj_id to the skb
arg in a .enqueue call. Therefore, we acquire that one and only
ref_obj_id for __ref arg early in do_check_common() and do not change
it afterward. Later in the main loop, the liviness is tracked in the
reference states. This feels kind of read-only? Besides, since we
acquire the ref automatically, it forces the user to do something with
the ref ptr (in qdisc's case, .enqueue needs to either drop or enqueue
it).

I try to break down the requirements from bpf qdisc (1. only a unique
reference to the skb in .enqueue; 2. users must enqueue or drop the
skb in .enqueue; 3. dequeue a single skb) into two orthogonal patches
1 and 3. so whether this reference can leak or not can be independent.
Taking a step back, maybe we can encapsulate them all in one semantic
(a new kind of REF like you suggest), but I am not sure if that'd be
too specific and then less useful to others.

> > Other than the subprog, afaik, the bpf prog triggered by the bpf_tail_c=
all can
> > also take the 'u64 *ctx' array. May be disallow using tailcall in all o=
ps in the
> > bpf qdisc. env->subprog_info[i].has_tail_call has already tracked wheth=
er the
> > tail_call is used.
>
> +1. Just disallow tail_call.

Got it. Also, thanks Martin for pointing it out.

