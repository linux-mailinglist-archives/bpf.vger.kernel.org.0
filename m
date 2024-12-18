Return-Path: <bpf+bounces-47258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07B9F6C3B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805E77A1CBD
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD761FA241;
	Wed, 18 Dec 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXGpUF8C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B81FA140;
	Wed, 18 Dec 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542427; cv=none; b=GFNRl8Donev7lYReyNWhNG0vKDR4k7lcPg4uka6WvaCfUJgQWqc0vCL5V+YBgO/RJEmqQAhbjinRWCa4qJ5Sqm4oo+gMzmGPgfb0ybOO1p9d89Xdv2fr2msK9E4CuDqpV3GaaxO3jekP/WGv64nTL7nevsZM44LvHxbumFN7Ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542427; c=relaxed/simple;
	bh=3N+cuewldFaJKRwJl9DNy16Th5B6NVeY4HuuOriBNSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw/1m57IlkBrYnE7cHBjDhF4oma4i0kVkls9DSo7OetMCZg1Or0lXb3I5UGW9vYOZBj/tf5uw1eaCiJBuKAL/raIFo36FeSLtLB3+kU1pUjZaBss+K69VW6UfEXbPtUAzlRmlCvgFLK3iaFPnw0r+/bvW59DTfzDptkiAWPx99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXGpUF8C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43623f0c574so47834785e9.2;
        Wed, 18 Dec 2024 09:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734542423; x=1735147223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXO/e2KAjZixwNQ1SDIaI26qLFA4hGy8FrCAqG7q2F4=;
        b=aXGpUF8CblDagvRvFJ9BcRGy4ZBooFNTBF9eNXR5XSCUL4t83rOacgz0p0kp5jv901
         EObs6jRa9szeOaKhOYuW3hv+v4sowagvcY9aEvXkM4z+Ax9gT/h9Wq94eYFmKF/radSK
         HYOTscXh59dXCGyt4UtHh5Oc1ipGgDgnpPmSlTny1qx4gkxlfwszyHXU1aTY4Jmjb1mN
         qYATbe6hDgvW3tIo0GzY/wmfbWZv6uKB0JrawXr0bQWKxy6AMftmxmQh+KqDzbRxSJdI
         Vu/nJIlir40c3yYoozNw2or1Hs3A3ckNxEKlOJSspOqvO0uclC5cdm2pXy8ULZUW5c9c
         L0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734542423; x=1735147223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXO/e2KAjZixwNQ1SDIaI26qLFA4hGy8FrCAqG7q2F4=;
        b=aYjQrx4PbJNtX2Z3y9U1FAQFEdFLif9QsksU+vhjoDSVj55hP+7wsFh6VzEZgtScMD
         nsMFUnidRlhJw9YrpXIawvtPajR1rHE9OORHJGYqms0kNZuA9/VByhzNwn+XLs1KCzxM
         IriRDartrmZE6acYsLOBRjkST1mL15cxs8DtSyHWzWB/bs8/V/UDBu3PVpXMhtNfpnqW
         INJ0j2+i1fxOrO5fbcRfD0HlEueb7T6Lqbu+TUYjwuCOihKliUJzuNa8q01Rd85HAS5Y
         h5nd6zb8s5PQG8v4bm09YIFE1oqbXyXxh/KfILJSMnYRw+vNuv/U5nc6ciGffkOkAIw5
         B4xg==
X-Forwarded-Encrypted: i=1; AJvYcCVt7P7I4qLE0OIWcMRXaZn6sKO4/s3DqeLHx77k/2em0WoLpZUSHS61kQqqE6UCWfMv5mSOnOq1@vger.kernel.org, AJvYcCWMQyYn0xjHXe/nTJPGfP/RnbQrGbwoio0wCqRIMRQXrWO/iMe0Z3Uv/EldM14v6OmTFbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRcNnNAjEGg7tGgHJJP2EKKk4rPsv5iJrrR1dZhFRWrQAqeCz
	WRT5wHjaHSB6+iW3l603OhZfYdzLEvFqeM2QgP7oigNosm2BLpVEB2FZMgFPT6I+dZQKaNwXajD
	baEUbX1Vp6B+H9nveoyfs8Rh9iPI=
X-Gm-Gg: ASbGncvkwAvTJFCqFS3dX4EJ3itrd2/CN9uCN6VPq4HmFzepX/gUhWdFWs8sV77g+FP
	ydOnF3ht/G69awtbU50raFd0UfJeudiFkjw0A6w==
X-Google-Smtp-Source: AGHT+IEZtz80/SAqak4uXM6RR6jbMoBVQtuTGPssYnYovnpsnugN8JjM2szOqXBQkoPvj//QRcT4AYY2PhbpDwq+wvI=
X-Received: by 2002:a5d:6d8e:0:b0:385:e1a8:e2a1 with SMTP id
 ffacd0b85a97d-388e4d6bbb1mr3569735f8f.3.1734542422778; Wed, 18 Dec 2024
 09:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-2-amery.hung@bytedance.com> <65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
 <CAADnVQ+LsEyADkSc7cNXkz=p5z-iNEoKRm25VpthCDAYe=0BVw@mail.gmail.com> <CAMB2axMQ9iFv4XjH3X3QLozudpga=DPSYEgzt3thtMOjYnrv7g@mail.gmail.com>
In-Reply-To: <CAMB2axMQ9iFv4XjH3X3QLozudpga=DPSYEgzt3thtMOjYnrv7g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 09:20:11 -0800
Message-ID: <CAADnVQL0JegqqCGCYE18o33CQrtnRWnH_g5GUgDZXJ2phHKDMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Support getting referenced kptr
 from struct_ops argument
To: Amery Hung <ameryhung@gmail.com>
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

On Wed, Dec 18, 2024 at 8:09=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Tue, Dec 17, 2024 at 5:24=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 4:58=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 12/13/24 3:29 PM, Amery Hung wrote:
> > > > Allows struct_ops programs to acqurie referenced kptrs from argumen=
ts
> > > > by directly reading the argument.
> > > >
> > > > The verifier will acquire a reference for struct_ops a argument tag=
ged
> > > > with "__ref" in the stub function in the beginning of the main prog=
ram.
> > > > The user will be able to access the referenced kptr directly by rea=
ding
> > > > the context as long as it has not been released by the program.
> > > >
> > > > This new mechanism to acquire referenced kptr (compared to the exis=
ting
> > > > "kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic r=
easons.
> > > > In the first use case, Qdisc_ops, an skb is passed to .enqueue in t=
he
> > > > first argument. This mechanism provides a natural way for users to =
get a
> > > > referenced kptr in the .enqueue struct_ops programs and makes sure =
that a
> > > > qdisc will always enqueue or drop the skb.
> > > >
> > > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > > ---
> > > >   include/linux/bpf.h         |  3 +++
> > > >   kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
> > > >   kernel/bpf/btf.c            |  1 +
> > > >   kernel/bpf/verifier.c       | 35 ++++++++++++++++++++++++++++++++=
---
> > > >   4 files changed, 56 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 1b84613b10ac..72bf941d1daf 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -968,6 +968,7 @@ struct bpf_insn_access_aux {
> > > >               struct {
> > > >                       struct btf *btf;
> > > >                       u32 btf_id;
> > > > +                     u32 ref_obj_id;
> > > >               };
> > > >       };
> > > >       struct bpf_verifier_log *log; /* for verbose logs */
> > > > @@ -1480,6 +1481,8 @@ struct bpf_ctx_arg_aux {
> > > >       enum bpf_reg_type reg_type;
> > > >       struct btf *btf;
> > > >       u32 btf_id;
> > > > +     u32 ref_obj_id;
> > > > +     bool refcounted;
> > > >   };
> > > >
> > > >   struct btf_mod_pair {
> > > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_op=
s.c
> > > > index fda3dd2ee984..6e7795744f6a 100644
> > > > --- a/kernel/bpf/bpf_struct_ops.c
> > > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > > @@ -145,6 +145,7 @@ void bpf_struct_ops_image_free(void *image)
> > > >   }
> > > >
> > > >   #define MAYBE_NULL_SUFFIX "__nullable"
> > > > +#define REFCOUNTED_SUFFIX "__ref"
> > > >   #define MAX_STUB_NAME 128
> > > >
> > > >   /* Return the type info of a stub function, if it exists.
> > > > @@ -206,9 +207,11 @@ static int prepare_arg_info(struct btf *btf,
> > > >                           struct bpf_struct_ops_arg_info *arg_info)
> > > >   {
> > > >       const struct btf_type *stub_func_proto, *pointed_type;
> > > > +     bool is_nullable =3D false, is_refcounted =3D false;
> > > >       const struct btf_param *stub_args, *args;
> > > >       struct bpf_ctx_arg_aux *info, *info_buf;
> > > >       u32 nargs, arg_no, info_cnt =3D 0;
> > > > +     const char *suffix;
> > > >       u32 arg_btf_id;
> > > >       int offset;
> > > >
> > > > @@ -240,12 +243,19 @@ static int prepare_arg_info(struct btf *btf,
> > > >       info =3D info_buf;
> > > >       for (arg_no =3D 0; arg_no < nargs; arg_no++) {
> > > >               /* Skip arguments that is not suffixed with
> > > > -              * "__nullable".
> > > > +              * "__nullable or __ref".
> > > >                */
> > > > -             if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> > > > -                                         MAYBE_NULL_SUFFIX))
> > > > +             is_nullable =3D btf_param_match_suffix(btf, &stub_arg=
s[arg_no],
> > > > +                                                  MAYBE_NULL_SUFFI=
X);
> > > > +             is_refcounted =3D btf_param_match_suffix(btf, &stub_a=
rgs[arg_no],
> > > > +                                                    REFCOUNTED_SUF=
FIX);
> > > > +             if (!is_nullable && !is_refcounted)
> > > >                       continue;
> > > >
> > > > +             if (is_nullable)
> > > > +                     suffix =3D MAYBE_NULL_SUFFIX;
> > > > +             else if (is_refcounted)
> > > > +                     suffix =3D REFCOUNTED_SUFFIX;
> > > >               /* Should be a pointer to struct */
> > > >               pointed_type =3D btf_type_resolve_ptr(btf,
> > > >                                                   args[arg_no].type=
,
> > > > @@ -253,7 +263,7 @@ static int prepare_arg_info(struct btf *btf,
> > > >               if (!pointed_type ||
> > > >                   !btf_type_is_struct(pointed_type)) {
> > > >                       pr_warn("stub function %s__%s has %s tagging =
to an unsupported type\n",
> > > > -                             st_ops_name, member_name, MAYBE_NULL_=
SUFFIX);
> > > > +                             st_ops_name, member_name, suffix);
> > > >                       goto err_out;
> > > >               }
> > > >
> > > > @@ -271,11 +281,15 @@ static int prepare_arg_info(struct btf *btf,
> > > >               }
> > > >
> > > >               /* Fill the information of the new argument */
> > > > -             info->reg_type =3D
> > > > -                     PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> > > >               info->btf_id =3D arg_btf_id;
> > > >               info->btf =3D btf;
> > > >               info->offset =3D offset;
> > > > +             if (is_nullable) {
> > > > +                     info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_I=
D | PTR_MAYBE_NULL;
> > > > +             } else if (is_refcounted) {
> > > > +                     info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_I=
D;
> > > > +                     info->refcounted =3D true;
> > > > +             }
> > > >
> > > >               info++;
> > > >               info_cnt++;
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index e7a59e6462a9..a05ccf9ee032 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -6580,6 +6580,7 @@ bool btf_ctx_access(int off, int size, enum b=
pf_access_type type,
> > > >                       info->reg_type =3D ctx_arg_info->reg_type;
> > > >                       info->btf =3D ctx_arg_info->btf ? : btf_vmlin=
ux;
> > > >                       info->btf_id =3D ctx_arg_info->btf_id;
> > > > +                     info->ref_obj_id =3D ctx_arg_info->ref_obj_id=
;
> > > >                       return true;
> > > >               }
> > > >       }
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 9f5de8d4fbd0..69753096075f 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -1402,6 +1402,17 @@ static int release_reference_state(struct bp=
f_func_state *state, int ptr_id)
> > > >       return -EINVAL;
> > > >   }
> > > >
> > > > +static bool find_reference_state(struct bpf_func_state *state, int=
 ptr_id)
> > > > +{
> > > > +     int i;
> > > > +
> > > > +     for (i =3D 0; i < state->acquired_refs; i++)
> > > > +             if (state->refs[i].id =3D=3D ptr_id)
> > > > +                     return true;
> > > > +
> > > > +     return false;
> > > > +}
> > > > +
> > > >   static int release_lock_state(struct bpf_func_state *state, int t=
ype, int id, void *ptr)
> > > >   {
> > > >       int i, last_idx;
> > > > @@ -5798,7 +5809,8 @@ static int check_packet_access(struct bpf_ver=
ifier_env *env, u32 regno, int off,
> > > >   /* check access to 'struct bpf_context' fields.  Supports fixed o=
ffsets only */
> > > >   static int check_ctx_access(struct bpf_verifier_env *env, int ins=
n_idx, int off, int size,
> > > >                           enum bpf_access_type t, enum bpf_reg_type=
 *reg_type,
> > > > -                         struct btf **btf, u32 *btf_id, bool *is_r=
etval, bool is_ldsx)
> > > > +                         struct btf **btf, u32 *btf_id, bool *is_r=
etval, bool is_ldsx,
> > > > +                         u32 *ref_obj_id)
> > > >   {
> > > >       struct bpf_insn_access_aux info =3D {
> > > >               .reg_type =3D *reg_type,
> > > > @@ -5820,8 +5832,16 @@ static int check_ctx_access(struct bpf_verif=
ier_env *env, int insn_idx, int off,
> > > >               *is_retval =3D info.is_retval;
> > > >
> > > >               if (base_type(*reg_type) =3D=3D PTR_TO_BTF_ID) {
> > > > +                     if (info.ref_obj_id &&
> > > > +                         !find_reference_state(cur_func(env), info=
.ref_obj_id)) {
> > > > +                             verbose(env, "invalid bpf_context acc=
ess off=3D%d. Reference may already be released\n",
> > > > +                                     off);
> > > > +                             return -EACCES;
> > > > +                     }
> > > > +
> > > >                       *btf =3D info.btf;
> > > >                       *btf_id =3D info.btf_id;
> > > > +                     *ref_obj_id =3D info.ref_obj_id;
> > > >               } else {
> > > >                       env->insn_aux_data[insn_idx].ctx_field_size =
=3D info.ctx_field_size;
> > > >               }
> > > > @@ -7135,7 +7155,7 @@ static int check_mem_access(struct bpf_verifi=
er_env *env, int insn_idx, u32 regn
> > > >               struct bpf_retval_range range;
> > > >               enum bpf_reg_type reg_type =3D SCALAR_VALUE;
> > > >               struct btf *btf =3D NULL;
> > > > -             u32 btf_id =3D 0;
> > > > +             u32 btf_id =3D 0, ref_obj_id =3D 0;
> > > >
> > > >               if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
> > > >                   is_pointer_value(env, value_regno)) {
> > > > @@ -7148,7 +7168,7 @@ static int check_mem_access(struct bpf_verifi=
er_env *env, int insn_idx, u32 regn
> > > >                       return err;
> > > >
> > > >               err =3D check_ctx_access(env, insn_idx, off, size, t,=
 &reg_type, &btf,
> > > > -                                    &btf_id, &is_retval, is_ldsx);
> > > > +                                    &btf_id, &is_retval, is_ldsx, =
&ref_obj_id);
> > > >               if (err)
> > > >                       verbose_linfo(env, insn_idx, "; ");
> > > >               if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) =
{
> > > > @@ -7179,6 +7199,7 @@ static int check_mem_access(struct bpf_verifi=
er_env *env, int insn_idx, u32 regn
> > > >                               if (base_type(reg_type) =3D=3D PTR_TO=
_BTF_ID) {
> > > >                                       regs[value_regno].btf =3D btf=
;
> > > >                                       regs[value_regno].btf_id =3D =
btf_id;
> > > > +                                     regs[value_regno].ref_obj_id =
=3D ref_obj_id;
> > > >                               }
> > > >                       }
> > > >                       regs[value_regno].type =3D reg_type;
> > > > @@ -21662,6 +21683,7 @@ static int do_check_common(struct bpf_verif=
ier_env *env, int subprog)
> > > >   {
> > > >       bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
> > > >       struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
> > > > +     struct bpf_ctx_arg_aux *ctx_arg_info;
> > > >       struct bpf_verifier_state *state;
> > > >       struct bpf_reg_state *regs;
> > > >       int ret, i;
> > > > @@ -21769,6 +21791,13 @@ static int do_check_common(struct bpf_veri=
fier_env *env, int subprog)
> > > >               mark_reg_known_zero(env, regs, BPF_REG_1);
> > > >       }
> > > >
> > > > +     if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_O=
PS) {
> > > > +             ctx_arg_info =3D (struct bpf_ctx_arg_aux *)env->prog-=
>aux->ctx_arg_info;
> > > > +             for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; =
i++)
> > > > +                     if (ctx_arg_info[i].refcounted)
> > > > +                             ctx_arg_info[i].ref_obj_id =3D acquir=
e_reference_state(env, 0);
> > >
> > > There is a conflict in the bpf-next/master. acquire_reference_state h=
as been
> > > refactored in commit 769b0f1c8214. From looking at the net/sched/sch_=
*.c
> > > changes, they should not have conflict with the net-next/main. I woul=
d suggest
> > > to rebase this set on bpf-next/master.
> > >
> > > At the first glance, the ref_obj_id assignment looks racy because ctx=
_arg_info
> > > is shared by different bpf progs that may be verified in parallel. Af=
ter another
> > > thought, this should be fine because it should always end up having t=
he same
> > > ref_obj_id for the same arg-no, right? Not sure if UBSAN can understa=
nd this
> > > without using the READ/WRITE_ONCE. but adding READ/WRITE_ONCE when us=
ing
> > > ref_obj_id will be quite puzzling when reading the verifier code. Any=
 better idea?
> >
> > ctx_arg_info is kinda read-only from the verifier pov.
> > bpf_ctx_arg_aux->btf_id is populated before the main verifier loop.
> > While ref_obj_id is a dynamic property.
> > It doesn't really fit in bpf_ctx_arg_aux.
> > It probably needs to be another struct type that is allocated
> > and populated once with acquire_reference() when the main verifier loop
> > is happening.
> > do_check_common() maybe too early?
> > Looks like it's anyway a reference that is ok to leak per patch 3 ?
> >
> > It seems the main goal is to pass ref_obj_id-like argument into bpf pro=
g
> > and make sure that prog doesn't call KF_RELEASE kfunc on it twice,
> > but leaking is ok?
> > Maybe it needs a different type. Other than REF_TYPE_PTR.
> >
>
> The main goal of this patch is to get a unique ref_obj_id to the skb
> arg in a .enqueue call. Therefore, we acquire that one and only
> ref_obj_id for __ref arg early in do_check_common() and do not change
> it afterward. Later in the main loop, the liviness is tracked in the
> reference states. This feels kind of read-only? Besides, since we
> acquire the ref automatically, it forces the user to do something with
> the ref ptr (in qdisc's case, .enqueue needs to either drop or enqueue
> it).
>
> I try to break down the requirements from bpf qdisc (1. only a unique
> reference to the skb in .enqueue; 2. users must enqueue or drop the
> skb in .enqueue; 3. dequeue a single skb) into two orthogonal patches
> 1 and 3. so whether this reference can leak or not can be independent.
> Taking a step back, maybe we can encapsulate them all in one semantic
> (a new kind of REF like you suggest), but I am not sure if that'd be
> too specific and then less useful to others.

Makes sense to keep the same ref type then.
I misread patch 3 comment
"leak referenced kptr through return value"
as just "leak referenced kptr".
Probably better to use a different term than "leak".
The ref_obj_id is kept valid through the prog.
It's returned from the prog back to the kernel. Not really leaking.

