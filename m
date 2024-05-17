Return-Path: <bpf+bounces-29889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD58C7F1D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7E71F22841
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 00:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FC399;
	Fri, 17 May 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSE/+vl/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754E1849;
	Fri, 17 May 2024 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905070; cv=none; b=KtE/wjSz5mMRulmDq2sBiJEte9vbOlH7zP0YM22RZ2boyA/wTpoPqBqzILR7lwtnNWZlmTLuDw82K2zpF3hP1WJjOTB9k0CmUxmEplb0xwbRshN1lCJJfGFvzIE1DGYWd5Sq3zMOHCtAtHCf5sVxgcDDlR7aBGsbisabr9jwEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905070; c=relaxed/simple;
	bh=OTZTa+2GHWdcUNburiBVCcgaliMdfgVeVb9u2x0MgcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKIcxZVioiBT50fhmEJ3txlT4T9uKEMAuP5g8b4B7m3lK4wuv+tVVBGIEeaGjJ9ZEvG1V0nalFwgnv9Vy5Zc/7QzyXXNcPVHYsIJbUXNmL39W3guHBub0X0tqeOOyM72Yypk9zRb46wVV8klwJbBl2bnLRSOLyIRBm01lyoezbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSE/+vl/; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc236729a2bso8592698276.0;
        Thu, 16 May 2024 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715905067; x=1716509867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx0cEfnjKK729qCgRmUuaUcZ+ZWaqUOH+kGWP79NkFc=;
        b=GSE/+vl/HKKrFMsG+r9Pd1h1B4sTVnJpXXjSQY6Ic5gwCJKfWq8Gjz1WykXnAOaIz1
         vBf5k05bQGZB9FGyfT3AmG5srgfHrNib9bPRdXv0P6+U0lP1Hcud5hJijb4kb3rafw1Y
         KdLWxRoKgWkIUW7OqOa+fRB39xmuB3Fgl11hNxywR/zF1PklygwI7omD/GN34KMm2fsf
         THrLUnQFCjqFwaxVJ1p+/KBP9wyuRjO6gDu+fe3unQxDGnwDZduKdJr2EII7/dWKctd6
         C0rUvhBuGNZq9tWJblCe/ga+U/I/F4jdzAUd51C2QdunOvu+j+JSJihmV6X8oPW2XP8j
         gF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715905067; x=1716509867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx0cEfnjKK729qCgRmUuaUcZ+ZWaqUOH+kGWP79NkFc=;
        b=eEqIp9PPHYQs5LjwIdtwMBZvJdGUaBdLNyznfhQxT2we5I4hiBTXvzn+/RqzzpOQJY
         m/gNgbi522YPYvqHFaQzloMSiQ33l8HYWjTjHb3QdSiDu2DUE0v/0L67l3ITdRfq2joJ
         7ELC0o8AGL9l9iHD7WSKHL6uzeNrXhkrakEFouwgUlfO1uyta9uQceiDwrDTfFDbrtdU
         ewYJsWbLP3wfJKf+ZkKBT5SpqIt6irzVhoZg3LhMZ2LcyvxRrxslgqWigoLM4Cjmqiml
         0eTY/HjKUNEj1XeEFEOPTk+mLP64LasQUnTrC0ppAeI0kGYsUVDnUWW24OoTy+18ExT+
         64Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUEM7lWKtnwFOTYRZPcHPnMtfNhadG7AeVfE2cPOppMd+z+CM1lbh9OyClePpFhLrLneJYriqYXgtxQfw3Eq4I6vsZi
X-Gm-Message-State: AOJu0Yw3naXtPzbVhW34U+2/P8QVcAAMXQP8vHc+2hMvuzInOzNgCFUt
	EpZG78jb6RJaxBrpU43NzbWhnX8seEGlS2swduO1EwwkNg9UPfEtcLZ1KKsDnVg9n6aUKFo6oLa
	5BS/+WP+NX2/Fq6aF41oPci4A1aE=
X-Google-Smtp-Source: AGHT+IE9JNg+0L4PtFX6i2OZNCJOE/ni/x5Mux2c1915ncdDVzAV0GnWW+u1q1BX6/uFDMLrcpu9FGw7IBqsszFfJp4=
X-Received: by 2002:a25:be51:0:b0:dda:a7e5:e4f0 with SMTP id
 3f1490d57ef6-dee4f38704cmr19526282276.61.1715905067339; Thu, 16 May 2024
 17:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-2-amery.hung@bytedance.com> <CAP01T74iSVPnRsAbdNfzXYYS7GsdCSgp3QiaPSzex6d+3J5AAA@mail.gmail.com>
In-Reply-To: <CAP01T74iSVPnRsAbdNfzXYYS7GsdCSgp3QiaPSzex6d+3J5AAA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 May 2024 17:17:36 -0700
Message-ID: <CAMB2axP1C1wVRsq2uDGW0r6-OM8yWvZ9LB0WwEtuSAYsU2T0fg@mail.gmail.com>
Subject: Re: [RFC PATCH v8 01/20] bpf: Support passing referenced kptr to
 struct_ops programs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:59=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 10 May 2024 at 21:24, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > This patch supports struct_ops programs that acqurie referenced kptrs
> > throguh arguments. In Qdisc_ops, an skb is passed to ".enqueue" in the
> > first argument. The qdisc becomes the sole owner of the skb and must
> > enqueue or drop the skb. This matches the referenced kptr semantic
> > in bpf. However, the existing practice of acquiring a referenced kptr v=
ia
> > a kfunc with KF_ACQUIRE does not play well in this case. Calling kfuncs
> > repeatedly allows the user to acquire multiple references, while there
> > should be only one reference to a unique skb in a qdisc.
> >
> > The solutioin is to make a struct_ops program automatically acquire a
> > referenced kptr through a tagged argument in the stub function. When
> > tagged with "__ref_acquired" (suggestion for a better name?), an
> > reference kptr (ref_obj_id > 0) will be acquired automatically when
> > entering the program. In addition, only the first read to the arguement
> > is allowed and it will yeild a referenced kptr.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  include/linux/bpf.h         |  3 +++
> >  kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++----
> >  kernel/bpf/btf.c            | 10 +++++++++-
> >  kernel/bpf/verifier.c       | 16 +++++++++++++---
> >  4 files changed, 38 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9c6a7b8ff963..6aabca1581fe 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -914,6 +914,7 @@ struct bpf_insn_access_aux {
> >                 struct {
> >                         struct btf *btf;
> >                         u32 btf_id;
> > +                       u32 ref_obj_id;
> >                 };
> >         };
> >         struct bpf_verifier_log *log; /* for verbose logs */
> > @@ -1416,6 +1417,8 @@ struct bpf_ctx_arg_aux {
> >         enum bpf_reg_type reg_type;
> >         struct btf *btf;
> >         u32 btf_id;
> > +       u32 ref_obj_id;
> > +       bool ref_acquired;
> >  };
> >
> >  struct btf_mod_pair {
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index 86c7884abaf8..bca8e5936846 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -143,6 +143,7 @@ void bpf_struct_ops_image_free(void *image)
> >  }
> >
> >  #define MAYBE_NULL_SUFFIX "__nullable"
> > +#define REF_ACQUIRED_SUFFIX "__ref_acquired"
> >  #define MAX_STUB_NAME 128
> >
> >  /* Return the type info of a stub function, if it exists.
> > @@ -204,6 +205,7 @@ static int prepare_arg_info(struct btf *btf,
> >                             struct bpf_struct_ops_arg_info *arg_info)
> >  {
> >         const struct btf_type *stub_func_proto, *pointed_type;
> > +       bool is_nullable =3D false, is_ref_acquired =3D false;
> >         const struct btf_param *stub_args, *args;
> >         struct bpf_ctx_arg_aux *info, *info_buf;
> >         u32 nargs, arg_no, info_cnt =3D 0;
> > @@ -240,8 +242,11 @@ static int prepare_arg_info(struct btf *btf,
> >                 /* Skip arguments that is not suffixed with
> >                  * "__nullable".
> >                  */
> > -               if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> > -                                           MAYBE_NULL_SUFFIX))
> > +               is_nullable =3D btf_param_match_suffix(btf, &stub_args[=
arg_no],
> > +                                                    MAYBE_NULL_SUFFIX)=
;
> > +               is_ref_acquired =3D btf_param_match_suffix(btf, &stub_a=
rgs[arg_no],
> > +                                                      REF_ACQUIRED_SUF=
FIX);
> > +               if (!(is_nullable || is_ref_acquired))
> >                         continue;
> >
> >                 /* Should be a pointer to struct */
> > @@ -269,11 +274,15 @@ static int prepare_arg_info(struct btf *btf,
> >                 }
> >
> >                 /* Fill the information of the new argument */
> > -               info->reg_type =3D
> > -                       PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> >                 info->btf_id =3D arg_btf_id;
> >                 info->btf =3D btf;
> >                 info->offset =3D offset;
> > +               if (is_nullable) {
> > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID =
| PTR_MAYBE_NULL;
> > +               } else if (is_ref_acquired) {
> > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID;
> > +                       info->ref_acquired =3D true;
> > +               }
> >
> >                 info++;
> >                 info_cnt++;
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 8c95392214ed..e462fb4a4598 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6316,7 +6316,8 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >
> >         /* this is a pointer to another type */
> >         for (i =3D 0; i < prog->aux->ctx_arg_info_size; i++) {
> > -               const struct bpf_ctx_arg_aux *ctx_arg_info =3D &prog->a=
ux->ctx_arg_info[i];
> > +               struct bpf_ctx_arg_aux *ctx_arg_info =3D
> > +                       (struct bpf_ctx_arg_aux *)&prog->aux->ctx_arg_i=
nfo[i];
> >
> >                 if (ctx_arg_info->offset =3D=3D off) {
> >                         if (!ctx_arg_info->btf_id) {
> > @@ -6324,9 +6325,16 @@ bool btf_ctx_access(int off, int size, enum bpf_=
access_type type,
> >                                 return false;
> >                         }
> >
> > +                       if (ctx_arg_info->ref_acquired && !ctx_arg_info=
->ref_obj_id) {
> > +                               bpf_log(log, "cannot acquire a referenc=
e to context argument offset %u\n", off);
> > +                               return false;
> > +                       }
> > +
> >                         info->reg_type =3D ctx_arg_info->reg_type;
> >                         info->btf =3D ctx_arg_info->btf ? : btf_vmlinux=
;
> >                         info->btf_id =3D ctx_arg_info->btf_id;
> > +                       info->ref_obj_id =3D ctx_arg_info->ref_obj_id;
> > +                       ctx_arg_info->ref_obj_id =3D 0;
> >                         return true;
>
> I think this is fragile. What if the compiler produces two independent
> paths in the program which read the skb pointer once?
> Technically, the program is still reading the skb pointer once at runtime=
.
> Then you will reset ref_obj_id to 0 when exploring one, and assign as
> 0 in the other one, causing errors.
> ctx_arg_info appears to be global for the program.
>
> I think the better way would be to check if ref_obj_id is still part
> of the reference state.
> If the ref_obj_id has already been dropped from reference_state, then
> any loads should get ref_obj_id =3D 0.
> That would happen when dropping or enqueueing the skb into qdisc,
> which would (I presume) do release_reference_state(ref_obj_id).
> Otherwise, all of them can share the same ref_obj_id. You won't have
> to implement "can only read once" logic,
> and when you enqueue stuff in the qdisc, all identical copies produced
> from different load instructions will be invalidated.
> Same ref_obj_id =3D=3D unique ownership of the same object.
> You can already have multiple copies through rX =3D rY, multiple ctx
> loads of skb will produce a similar verifier state.
>
> So, on entry, assign ctx_arg_info->ref_obj_id uniquely, then on each load=
:
> if reference_state.find(ctx_arg_info->ref_obj_id) =3D=3D true; then
> info->ref_obj_id =3D ctx_arg_info->ref_obj_id; else info->ref_obj_id =3D
> 0;
>
> Let me know if I missed something.

You are right. The current approach will falsely reject valid programs,
and your suggestion makes sense.

Thanks,
Amery

