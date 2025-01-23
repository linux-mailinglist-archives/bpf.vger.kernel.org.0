Return-Path: <bpf+bounces-49601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C075DA1AA83
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDCD7A5152
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715771ADC9C;
	Thu, 23 Jan 2025 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mInsmFGP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6791ADC90;
	Thu, 23 Jan 2025 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661296; cv=none; b=eoqaNn5u0GtCGRhmEPUAO+p/RDFG94Rhy4mp1h5jj7UBjy5edBSm4cPJ/Jo5vUYSqHRrlunHBE6M6+hqeVRbGL9dfLeC3z4aUTxD/MQEU4WF7lPiRymr1/h2M2UOGq7OqWNYXBrNH6oSVt9jbKA7y99B9P/JwZh8azzOQQyscFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661296; c=relaxed/simple;
	bh=Bjl1jQvhzUuwZLTQMuDb8CiuTF4GdcydCN8OFsoboyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwrIF6LnqoKXJbzezhp2hLAOYw2ND5yDgzdkSl05X+cDn+ScN9uMMykHRQk/qETwRkjiR6c8/QiZhholOyADVr0hgkOEByy+M0f6rmnf8ZeBTRrHw2VWkqA0eJgc8NMaQJqGCyQ47l/OftZdzDqB3pg53jClQpusajNSQUr2ll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mInsmFGP; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e549dd7201cso2474386276.0;
        Thu, 23 Jan 2025 11:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661293; x=1738266093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9JKk2g2n4RajhRZ8hBTm51RbMbUFYtO3JAoB+JrWZ0=;
        b=mInsmFGPFkT1G4yONWTa8PfGO3avr02kT+1MuZT5b/Vf/fLKEwxwpZSp37p8xsfwJd
         CNvuVy65QI+Eo4UOMoE4WV3GAzOMogrM4nU8QOLwg0piy2DS9sBOu4KUuFZc7rdGBW4A
         dBvcsoFH16C+QxRPLPHBf11D0QU+hQi+l9f9LUhGLERmAK+eVk+D0uBgWbteHEWd4zQj
         upJeXBqm8lvsDvP9UbJQTn/59GAZt+8iJULSBesdlbXCVW6nzH6Q/QVLE49+VOEwYD3y
         KNnSUYA3GaOHHYZh11VvDmO4A/4kf/R6t/XUywVb2KilT01RIGvDPoqeDbH4pjTmJkcL
         Ax+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661293; x=1738266093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9JKk2g2n4RajhRZ8hBTm51RbMbUFYtO3JAoB+JrWZ0=;
        b=XEScd6n8AS6Yf6Z+VbYpigN9lO7rrbrLtC7MQ3ex/aleH3+INTgstd0I55qUwKS9Sb
         OhmpzQqdqQsKokfm+AaqJGAM4xpauvkBXsI5GjMAfaDM+t0zBpHaCWKOX97xwgXZit2g
         5JpVeTnh2JvlkLXzylCXGKsvMGfo1c1IwrO9GORXOvj8xaJku5x3auj2kFv9013kmHvu
         1hqv6YwWCfnadILJmmz/ZeM0BlpCLrfBsegYP+XFURRHySO8Zkox+N/vl4oXpoRkOe+x
         FMXVR+3ZYEwPPilxqiS1PpKFmU0naUAdil2lRsFReUILKOy3aTDvFDL8ny+TiT1AUbuq
         cd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDhSMA7I6JR7ySI4B6WuFQo8u8yZQn1oeup+fT36eOiaB9Ej1kfkESQtdaUdC+JJc7x8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaH0/8CjlmRrfTv4wRiBcw2XiZX47RUGJ38Qbyi5GKA47Aq7uH
	kVKuxuK/lMAOcKYhUZJ20/l7vIUoba22pXWO9gkxhESFI0LlzDmVM6GYVLgIrz65QiGxmIK0BVN
	xnYPnDY4Hi7M104Q6pJ0cl9vGQqQ=
X-Gm-Gg: ASbGnctztVQL1OWeAgrnw1x0Cg/RPrbW2FEuOZkUbhjDFYzTQmnKwjxjEiK4zB25o3w
	oBF2iAcG4zayn35g7WwPH07IKCpUt9GBrQDddIZ/tEJM0iW8PIv+p63zyv/t4IQ==
X-Google-Smtp-Source: AGHT+IGfj0HO/WuIbNXXYyvmJ941amTp3hCmzyDEHKTX0TFEIhNbAurUyFTuvdzBh/PJ6ax/wz0iHTqKSRefHrFwaSQ=
X-Received: by 2002:a05:6902:1581:b0:e58:33ce:87a1 with SMTP id
 3f1490d57ef6-e5833ce8892mr2078445276.24.1737661293138; Thu, 23 Jan 2025
 11:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-2-amery.hung@gmail.com> <ce15f61de21a4415d00d2e52c2eedc63564093c8.camel@gmail.com>
In-Reply-To: <ce15f61de21a4415d00d2e52c2eedc63564093c8.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jan 2025 11:41:22 -0800
X-Gm-Features: AWEUYZl8OucAG5Bobcp2FKy1Q_eECLlHpzydjWUvrjHGd2-MrNzgh9Cw0m8EAfQ
Message-ID: <CAMB2axPoBXnrFE0iRT8rAs8txi0jabcb5ctGoFz85-HyDSpghQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/14] bpf: Support getting referenced kptr
 from struct_ops argument
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, 
	amery.hung@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-12-20 at 11:55 -0800, Amery Hung wrote:
> > From: Amery Hung <amery.hung@bytedance.com>
> >
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
>
> Hi Amery,
>
> Sorry, for joining so late in the review process.
> Decided to take a look at verifier related changes.
> Overall the patch looks good to me,
> but I dislike the part allocating parameter ids.
>
> [...]
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 28246c59e12e..c2f4f84e539d 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6682,6 +6682,7 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >                       info->reg_type =3D ctx_arg_info->reg_type;
> >                       info->btf =3D ctx_arg_info->btf ? : btf_vmlinux;
> >                       info->btf_id =3D ctx_arg_info->btf_id;
> > +                     info->ref_obj_id =3D ctx_arg_info->refcounted ? +=
+nr_ref_args : 0;
> >                       return true;
> >               }
> >       }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f27274e933e5..26305571e377 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [...]
>
> > @@ -22161,6 +22182,16 @@ static int do_check_common(struct bpf_verifier=
_env *env, int subprog)
> >               mark_reg_known_zero(env, regs, BPF_REG_1);
> >       }
> >
> > +     /* Acquire references for struct_ops program arguments tagged wit=
h "__ref".
> > +      * These should be the earliest references acquired. btf_ctx_acce=
ss() will
> > +      * assume the ref_obj_id of the n-th __ref-tagged argument to be =
n.
> > +      */
> > +     if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) =
{
> > +             for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; i++)
> > +                     if (env->prog->aux->ctx_arg_info[i].refcounted)
> > +                             acquire_reference(env, 0);
> > +     }
> > +
> >       ret =3D do_check(env);
> >  out:
> >       /* check for NULL is necessary, since cur_state can be freed insi=
de
>
> I think it would be cleaner if:
> - each program would own it's instance of 'env->prog->aux->ctx_arg_info';
> - ref_obj_id field would be added to 'struct bpf_ctx_arg_aux';
> - parameter ids would be allocated in do_check_common(), but without
>   reliance on being first to allocate.

This is very similar to what v1 is doing but I missed the first part.
Replacing assignments of prog->aux->ctx_arg_info with deep copy should
make ctx_arg_info a per-program thing. I agree with you that creating
this assumption of ref_obj_id is unnecessary and I will change it.

https://lore.kernel.org/bpf/20241213232958.2388301-1-amery.hung@bytedance.c=
om/

Thanks,
Amery

>
> Or add some rigour to this thing and e.g. make env->id_gen signed
> and declare an enum of special ids like:
>
>   enum special_ids {
>         STRUCT_OPS_CTX_PARAM_0 =3D -1,
>         STRUCT_OPS_CTX_PARAM_1 =3D -2,
>         STRUCT_OPS_CTX_PARAM_2 =3D -3,
>         ...
>   }
>
> and update the loop above as:
>
>         if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) =
{
>                 for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; i++)
>                         if (env->prog->aux->ctx_arg_info[i].refcounted)
>                 /* imagined function that acquires an id with specific va=
lue */
>                                 acquire_special_reference(env, 0, STRUCT_=
OPS_CTX_PARAM_0 - i /* desired id */);
>         }
>
> wdyt?
>

