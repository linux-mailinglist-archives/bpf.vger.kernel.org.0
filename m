Return-Path: <bpf+bounces-29890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38908C7F28
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1231C21655
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 00:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FAC63E;
	Fri, 17 May 2024 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJr6NR7+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1B4A0F;
	Fri, 17 May 2024 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905458; cv=none; b=F2VsLaSF4yCo066HgNatVkKDE9/25buo9MgzefJgsHM0FQXpaFvuCsWY8LF7tAROZXji1N78NTeKnJlUYQngOt7dmMqVEZPL7xIa53LH2NQFTigUD2gJMwvtY2gcZuEl2h8hoGKwI19AMkxq4j6cyeezq4qDteTLsV6VE2gdk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905458; c=relaxed/simple;
	bh=m8GNM27Kp3f+aok4cNSQAzkt6VYs1F9UMOE7H/mCzDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qapMrQxueqIVN2pHSQotE68jTh66L2oxDuTsznYcKIxDP4zpA4DywYoq7LpxhuxOmswKrhvcjAUCpN+G2zmv5oLjzGr8zylk4Yq4FoVGiV3/sbTh40B5Hy6pAGn/Dv8uOtbsdo3oXDEFONV9XTAsDQ9K4YbgEBy5ie3BDgfKNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJr6NR7+; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso710071fa.0;
        Thu, 16 May 2024 17:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715905455; x=1716510255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VISbYzFniYzs5dXFBlVFa4T0YCB3lGTKJzy0kC0XcF4=;
        b=GJr6NR7+YuDorWylrlZcbwdPsxp+kgXd5lwF0X7QinnMB3uKyHxrsgIIvBdB3cseoR
         j9taMv17rXPrHzpvLrjxNLtt+nHnfz5fZY85mUqdyeAmNQ2nz0BqgUV8ZfF8NyOdbM78
         ITcG+6KO9yHuUSHzqLInD20KsySJflFN31xmT8F+l0kSHsPryUwauikTspMUw6RVaK1r
         cD+Q7sA0FDCnAcZYsv+5T8OpjlxODonTUL8FSwYq3+ZfrI9HvBya7EhTMMtsy2DsAx9s
         9FtHopcs06LlSgZnfQ0dgWxUi8HrA9P56pUb1FLxTowfd8DZ1RkxnxV59eXXthbu3j6f
         sFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715905455; x=1716510255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VISbYzFniYzs5dXFBlVFa4T0YCB3lGTKJzy0kC0XcF4=;
        b=ce8yVuVcZMrm2ud1DHXtwOLrnN1haClnNl5g8hMrcdRebzt9OL6g6sdzlcFEXhItiO
         3ne8HXjGrvDGDCfM/9RjFMRIs1sNQ3dYf0OdBs1yLwjusS6q7Lhu7Xmyu1wQGCzGCCe6
         RZTeIky7fyNHGJpDR8+wQUDNPmZiq3Eo9iCkE61CzZhH0eHQzq8JFf2jNNQpQ6jrOtvv
         Lr0UQcpfvhAwFleUU7kFXNNJi1Icz6ip0qkopVq9CXnvz391z8EvRmlhbAEt7H0QchCs
         h2YCrC2HAmUTwoBDqDxBzA7h9rgXk2vYT7Cv4DihPlZJsMI7l4zMNHHBodry+D16rV9i
         d1lg==
X-Forwarded-Encrypted: i=1; AJvYcCXE9zFwpqn1rdoLUo+2K/2Dm+gsjr8CAFrkdOWwX7ZLAPjwJ9hif407BEdnGd7hntRc87hu5vShBGe7wN98frYx9jdm
X-Gm-Message-State: AOJu0YxecJbWrmEGcejBF215Hm1Jc8XnLkwzyH8C/vXa6bwMBuBaU0XS
	XkZ7umiCr/u6APaCswMLd6ZIzzxJJU9WyexbB5MMzuxzIMD6R6qbU6GqKis39V/Gt+C9FM40QHq
	TkLOZQhnP6E+BCyn6KQbs0hap+f0=
X-Google-Smtp-Source: AGHT+IFLkit7JE4VjBdvgaRtL4gPkpw+MYKl+BTVWjP0QTia4ZeXBqS83ojRPUGSM3QURFZtxHjcSKuJIc9GsLwYzIM=
X-Received: by 2002:a2e:984b:0:b0:2e0:3ad2:b371 with SMTP id
 38308e7fff4ca-2e51fe5875dmr159830181fa.25.1715905454383; Thu, 16 May 2024
 17:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-2-amery.hung@bytedance.com> <CAP01T74iSVPnRsAbdNfzXYYS7GsdCSgp3QiaPSzex6d+3J5AAA@mail.gmail.com>
 <CAMB2axP1C1wVRsq2uDGW0r6-OM8yWvZ9LB0WwEtuSAYsU2T0fg@mail.gmail.com>
In-Reply-To: <CAMB2axP1C1wVRsq2uDGW0r6-OM8yWvZ9LB0WwEtuSAYsU2T0fg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 17 May 2024 02:23:37 +0200
Message-ID: <CAP01T74mQPMktHJiPoZ7z-UfFCRoxOexpBe_X2v3rLpE5A+WEA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 01/20] bpf: Support passing referenced kptr to
 struct_ops programs
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 at 02:17, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Thu, May 16, 2024 at 4:59=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 10 May 2024 at 21:24, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > This patch supports struct_ops programs that acqurie referenced kptrs
> > > throguh arguments. In Qdisc_ops, an skb is passed to ".enqueue" in th=
e
> > > first argument. The qdisc becomes the sole owner of the skb and must
> > > enqueue or drop the skb. This matches the referenced kptr semantic
> > > in bpf. However, the existing practice of acquiring a referenced kptr=
 via
> > > a kfunc with KF_ACQUIRE does not play well in this case. Calling kfun=
cs
> > > repeatedly allows the user to acquire multiple references, while ther=
e
> > > should be only one reference to a unique skb in a qdisc.
> > >
> > > The solutioin is to make a struct_ops program automatically acquire a
> > > referenced kptr through a tagged argument in the stub function. When
> > > tagged with "__ref_acquired" (suggestion for a better name?), an
> > > reference kptr (ref_obj_id > 0) will be acquired automatically when
> > > entering the program. In addition, only the first read to the argueme=
nt
> > > is allowed and it will yeild a referenced kptr.
> > >
> > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > ---
> > >  include/linux/bpf.h         |  3 +++
> > >  kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++----
> > >  kernel/bpf/btf.c            | 10 +++++++++-
> > >  kernel/bpf/verifier.c       | 16 +++++++++++++---
> > >  4 files changed, 38 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 9c6a7b8ff963..6aabca1581fe 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -914,6 +914,7 @@ struct bpf_insn_access_aux {
> > >                 struct {
> > >                         struct btf *btf;
> > >                         u32 btf_id;
> > > +                       u32 ref_obj_id;
> > >                 };
> > >         };
> > >         struct bpf_verifier_log *log; /* for verbose logs */
> > > @@ -1416,6 +1417,8 @@ struct bpf_ctx_arg_aux {
> > >         enum bpf_reg_type reg_type;
> > >         struct btf *btf;
> > >         u32 btf_id;
> > > +       u32 ref_obj_id;
> > > +       bool ref_acquired;
> > >  };
> > >
> > >  struct btf_mod_pair {
> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.=
c
> > > index 86c7884abaf8..bca8e5936846 100644
> > > --- a/kernel/bpf/bpf_struct_ops.c
> > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > @@ -143,6 +143,7 @@ void bpf_struct_ops_image_free(void *image)
> > >  }
> > >
> > >  #define MAYBE_NULL_SUFFIX "__nullable"
> > > +#define REF_ACQUIRED_SUFFIX "__ref_acquired"
> > >  #define MAX_STUB_NAME 128
> > >
> > >  /* Return the type info of a stub function, if it exists.
> > > @@ -204,6 +205,7 @@ static int prepare_arg_info(struct btf *btf,
> > >                             struct bpf_struct_ops_arg_info *arg_info)
> > >  {
> > >         const struct btf_type *stub_func_proto, *pointed_type;
> > > +       bool is_nullable =3D false, is_ref_acquired =3D false;
> > >         const struct btf_param *stub_args, *args;
> > >         struct bpf_ctx_arg_aux *info, *info_buf;
> > >         u32 nargs, arg_no, info_cnt =3D 0;
> > > @@ -240,8 +242,11 @@ static int prepare_arg_info(struct btf *btf,
> > >                 /* Skip arguments that is not suffixed with
> > >                  * "__nullable".
> > >                  */
> > > -               if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> > > -                                           MAYBE_NULL_SUFFIX))
> > > +               is_nullable =3D btf_param_match_suffix(btf, &stub_arg=
s[arg_no],
> > > +                                                    MAYBE_NULL_SUFFI=
X);
> > > +               is_ref_acquired =3D btf_param_match_suffix(btf, &stub=
_args[arg_no],
> > > +                                                      REF_ACQUIRED_S=
UFFIX);
> > > +               if (!(is_nullable || is_ref_acquired))
> > >                         continue;
> > >
> > >                 /* Should be a pointer to struct */
> > > @@ -269,11 +274,15 @@ static int prepare_arg_info(struct btf *btf,
> > >                 }
> > >
> > >                 /* Fill the information of the new argument */
> > > -               info->reg_type =3D
> > > -                       PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> > >                 info->btf_id =3D arg_btf_id;
> > >                 info->btf =3D btf;
> > >                 info->offset =3D offset;
> > > +               if (is_nullable) {
> > > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_I=
D | PTR_MAYBE_NULL;
> > > +               } else if (is_ref_acquired) {
> > > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_I=
D;
> > > +                       info->ref_acquired =3D true;
> > > +               }
> > >
> > >                 info++;
> > >                 info_cnt++;
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 8c95392214ed..e462fb4a4598 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6316,7 +6316,8 @@ bool btf_ctx_access(int off, int size, enum bpf=
_access_type type,
> > >
> > >         /* this is a pointer to another type */
> > >         for (i =3D 0; i < prog->aux->ctx_arg_info_size; i++) {
> > > -               const struct bpf_ctx_arg_aux *ctx_arg_info =3D &prog-=
>aux->ctx_arg_info[i];
> > > +               struct bpf_ctx_arg_aux *ctx_arg_info =3D
> > > +                       (struct bpf_ctx_arg_aux *)&prog->aux->ctx_arg=
_info[i];
> > >
> > >                 if (ctx_arg_info->offset =3D=3D off) {
> > >                         if (!ctx_arg_info->btf_id) {
> > > @@ -6324,9 +6325,16 @@ bool btf_ctx_access(int off, int size, enum bp=
f_access_type type,
> > >                                 return false;
> > >                         }
> > >
> > > +                       if (ctx_arg_info->ref_acquired && !ctx_arg_in=
fo->ref_obj_id) {
> > > +                               bpf_log(log, "cannot acquire a refere=
nce to context argument offset %u\n", off);
> > > +                               return false;
> > > +                       }
> > > +
> > >                         info->reg_type =3D ctx_arg_info->reg_type;
> > >                         info->btf =3D ctx_arg_info->btf ? : btf_vmlin=
ux;
> > >                         info->btf_id =3D ctx_arg_info->btf_id;
> > > +                       info->ref_obj_id =3D ctx_arg_info->ref_obj_id=
;
> > > +                       ctx_arg_info->ref_obj_id =3D 0;
> > >                         return true;
> >
> > I think this is fragile. What if the compiler produces two independent
> > paths in the program which read the skb pointer once?
> > Technically, the program is still reading the skb pointer once at runti=
me.
> > Then you will reset ref_obj_id to 0 when exploring one, and assign as
> > 0 in the other one, causing errors.
> > ctx_arg_info appears to be global for the program.
> >
> > I think the better way would be to check if ref_obj_id is still part
> > of the reference state.
> > If the ref_obj_id has already been dropped from reference_state, then
> > any loads should get ref_obj_id =3D 0.
> > That would happen when dropping or enqueueing the skb into qdisc,
> > which would (I presume) do release_reference_state(ref_obj_id).
> > Otherwise, all of them can share the same ref_obj_id. You won't have
> > to implement "can only read once" logic,
> > and when you enqueue stuff in the qdisc, all identical copies produced
> > from different load instructions will be invalidated.
> > Same ref_obj_id =3D=3D unique ownership of the same object.
> > You can already have multiple copies through rX =3D rY, multiple ctx
> > loads of skb will produce a similar verifier state.
> >
> > So, on entry, assign ctx_arg_info->ref_obj_id uniquely, then on each lo=
ad:
> > if reference_state.find(ctx_arg_info->ref_obj_id) =3D=3D true; then
> > info->ref_obj_id =3D ctx_arg_info->ref_obj_id; else info->ref_obj_id =
=3D
> > 0;
> >
> > Let me know if I missed something.
>
> You are right. The current approach will falsely reject valid programs,
> and your suggestion makes sense.

Also, I wonder whether when ref_obj_id has been released, we should
mark the loaded register as unknown scalar, vs skb with ref_obj_id =3D
0?
Otherwise right now it will take PTR_TO_BTF_ID | PTR_TRUSTED as
reg_type, and I think verifier will permit reads even if ref_obj_id =3D
0.
This will surely be bad once skb is dropped/enqueued, since the
program should no longer be able to read such memory.

>
> Thanks,
> Amery

