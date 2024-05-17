Return-Path: <bpf+bounces-29896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7038C7F83
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C981B21F5C
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1EC1392;
	Fri, 17 May 2024 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIj8X0eR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349A811;
	Fri, 17 May 2024 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908977; cv=none; b=AAha9Xw4MInRZapyv4jIodab9237SqUMdGt49YIuv2o3yQ20r9jnOdoRWxlXr+rKiS/hkSBT8RXOUwmMGXzI8t3ttE7+xrgrMRLZTHw48IlJk/Z9vpud1lO9ot0O3Lv17bLPwMkPvAROd7LJiPSnglao3+sxNouWcdHZ4SZorBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908977; c=relaxed/simple;
	bh=9aRJlhvfe5dXEBJ4Bt6tYW0tkx/RS6q5J92KeTMuyPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5HR39YxWtTjQZINHHyTIF6Jm5yQl7sQSgSxtBgpWHbSCFY1e9+K892ZFApjcFqEPBrd/Be2tiBsWAtAg+6tsPVg21Nq2wWHmCHaLDl6CbCHpKon1g73kt0JhYx7fRYHnrLqd/YYsV4t06/jOFniTQ6V6u/TUiiK9Q+hyNObmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIj8X0eR; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de5ea7edb90so8885958276.1;
        Thu, 16 May 2024 18:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715908974; x=1716513774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpjM0etctK/x5I99JtJ2MDtuj1cMUoI/qj5wNmIveeg=;
        b=PIj8X0eR5UV3HhMPWnSWcsQMsHeVxS6d/N1INtdXXnBThSMde2u2zPm5y/YTqBT5Ru
         TY8HmegBwuJ0i6a8VFD087E4/um135txqk3K3G+4NbTDPXtm4sDBDKRXfYrXq/d9M0BW
         EtmdUKCgh9GNjb+P2o+jsUNdt541KIBVGiX4BVWV45QB/qM6jFG5IIAYM6ueDqchkYMR
         QSr5FhsPdK6R5aBt84yc6WFV69EJFN+JfagGkDCQLRmBFsqAzCZobxarsYN9JQRjoitN
         Gh7qb1Wp/FT3t048B4fR7uGty9mJpjLPY1nR9VcgE9IS6oFa/HkVw6huJmNBxms8qvoL
         sScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715908974; x=1716513774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpjM0etctK/x5I99JtJ2MDtuj1cMUoI/qj5wNmIveeg=;
        b=W38S2Znje+uR8pBpioMxvNHc5KNiliGOs5Cp+zQhKdZnPs9Gx3hYHzeEOVpszyZ6PX
         /33JpMW1/RW7i3KeZjpEC8fkdLGDp8OgGy8xoZvYXBbko+4uVwSIO6gHXw4Rq+xBjXyi
         aGSQwyDEq4xMhfEcVYbgyzJMuJ8EqINZZrIyl4OoovPzxAg60+lm9usHTrHqcanrgv9G
         BxJ6jkWfMDX2BEUqQlUQniIoGWaM349/mQEfJFr0P/dga8TQKyMz+o2/mKoaBxT4vc4M
         X1t88HadD1R0px5v7EtAd2aSqDZtmtT5CM0pjcGNWLubGxeGvxqFDIfjVNMee+BwMIqp
         9W8g==
X-Forwarded-Encrypted: i=1; AJvYcCWqK2AoNst6LN5OyFfUb6neW1hF+GVJhIlL60Qno752PxM0y3+/Iyg2sL6vzxDHus/uQSAXVHq7oxDGlhheaG/89qp4
X-Gm-Message-State: AOJu0YwffJeJV800SX9WeubwRN3+o7l+mJk7CtTBUwCl0DmiML9hg+b8
	pQxlxvs+Bb7rAsNDB0HV/xUv5futm9cOLR4q7zyRMaXvDKSX4R1BgRJ+ha2HvtlrLWVSi8vCgZb
	MLj5sIAOvPXoinlcG7ULQ+ZeA3us=
X-Google-Smtp-Source: AGHT+IEsZhuWzEkioGNXJnX0/oLi0pY7maNRhwHdsz/CT/6kEUP6sv/ravHt9AWNBjk62s9D3gzUypb2D0eH5r49yAc=
X-Received: by 2002:a25:810e:0:b0:dc7:4067:9f85 with SMTP id
 3f1490d57ef6-dee4f37edf1mr19731846276.58.1715908974272; Thu, 16 May 2024
 18:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-2-amery.hung@bytedance.com> <CAP01T74iSVPnRsAbdNfzXYYS7GsdCSgp3QiaPSzex6d+3J5AAA@mail.gmail.com>
 <CAMB2axP1C1wVRsq2uDGW0r6-OM8yWvZ9LB0WwEtuSAYsU2T0fg@mail.gmail.com> <CAP01T74mQPMktHJiPoZ7z-UfFCRoxOexpBe_X2v3rLpE5A+WEA@mail.gmail.com>
In-Reply-To: <CAP01T74mQPMktHJiPoZ7z-UfFCRoxOexpBe_X2v3rLpE5A+WEA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 May 2024 18:22:43 -0700
Message-ID: <CAMB2axOho5uoWv6NSJSydtA+Y0OytpaMnqP38aaVaeaG-qdv7A@mail.gmail.com>
Subject: Re: [RFC PATCH v8 01/20] bpf: Support passing referenced kptr to
 struct_ops programs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:24=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 17 May 2024 at 02:17, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > On Thu, May 16, 2024 at 4:59=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 10 May 2024 at 21:24, Amery Hung <ameryhung@gmail.com> wrote:
> > > >
> > > > This patch supports struct_ops programs that acqurie referenced kpt=
rs
> > > > throguh arguments. In Qdisc_ops, an skb is passed to ".enqueue" in =
the
> > > > first argument. The qdisc becomes the sole owner of the skb and mus=
t
> > > > enqueue or drop the skb. This matches the referenced kptr semantic
> > > > in bpf. However, the existing practice of acquiring a referenced kp=
tr via
> > > > a kfunc with KF_ACQUIRE does not play well in this case. Calling kf=
uncs
> > > > repeatedly allows the user to acquire multiple references, while th=
ere
> > > > should be only one reference to a unique skb in a qdisc.
> > > >
> > > > The solutioin is to make a struct_ops program automatically acquire=
 a
> > > > referenced kptr through a tagged argument in the stub function. Whe=
n
> > > > tagged with "__ref_acquired" (suggestion for a better name?), an
> > > > reference kptr (ref_obj_id > 0) will be acquired automatically when
> > > > entering the program. In addition, only the first read to the argue=
ment
> > > > is allowed and it will yeild a referenced kptr.
> > > >
> > > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > > ---
> > > >  include/linux/bpf.h         |  3 +++
> > > >  kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++----
> > > >  kernel/bpf/btf.c            | 10 +++++++++-
> > > >  kernel/bpf/verifier.c       | 16 +++++++++++++---
> > > >  4 files changed, 38 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 9c6a7b8ff963..6aabca1581fe 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -914,6 +914,7 @@ struct bpf_insn_access_aux {
> > > >                 struct {
> > > >                         struct btf *btf;
> > > >                         u32 btf_id;
> > > > +                       u32 ref_obj_id;
> > > >                 };
> > > >         };
> > > >         struct bpf_verifier_log *log; /* for verbose logs */
> > > > @@ -1416,6 +1417,8 @@ struct bpf_ctx_arg_aux {
> > > >         enum bpf_reg_type reg_type;
> > > >         struct btf *btf;
> > > >         u32 btf_id;
> > > > +       u32 ref_obj_id;
> > > > +       bool ref_acquired;
> > > >  };
> > > >
> > > >  struct btf_mod_pair {
> > > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_op=
s.c
> > > > index 86c7884abaf8..bca8e5936846 100644
> > > > --- a/kernel/bpf/bpf_struct_ops.c
> > > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > > @@ -143,6 +143,7 @@ void bpf_struct_ops_image_free(void *image)
> > > >  }
> > > >
> > > >  #define MAYBE_NULL_SUFFIX "__nullable"
> > > > +#define REF_ACQUIRED_SUFFIX "__ref_acquired"
> > > >  #define MAX_STUB_NAME 128
> > > >
> > > >  /* Return the type info of a stub function, if it exists.
> > > > @@ -204,6 +205,7 @@ static int prepare_arg_info(struct btf *btf,
> > > >                             struct bpf_struct_ops_arg_info *arg_inf=
o)
> > > >  {
> > > >         const struct btf_type *stub_func_proto, *pointed_type;
> > > > +       bool is_nullable =3D false, is_ref_acquired =3D false;
> > > >         const struct btf_param *stub_args, *args;
> > > >         struct bpf_ctx_arg_aux *info, *info_buf;
> > > >         u32 nargs, arg_no, info_cnt =3D 0;
> > > > @@ -240,8 +242,11 @@ static int prepare_arg_info(struct btf *btf,
> > > >                 /* Skip arguments that is not suffixed with
> > > >                  * "__nullable".
> > > >                  */
> > > > -               if (!btf_param_match_suffix(btf, &stub_args[arg_no]=
,
> > > > -                                           MAYBE_NULL_SUFFIX))
> > > > +               is_nullable =3D btf_param_match_suffix(btf, &stub_a=
rgs[arg_no],
> > > > +                                                    MAYBE_NULL_SUF=
FIX);
> > > > +               is_ref_acquired =3D btf_param_match_suffix(btf, &st=
ub_args[arg_no],
> > > > +                                                      REF_ACQUIRED=
_SUFFIX);
> > > > +               if (!(is_nullable || is_ref_acquired))
> > > >                         continue;
> > > >
> > > >                 /* Should be a pointer to struct */
> > > > @@ -269,11 +274,15 @@ static int prepare_arg_info(struct btf *btf,
> > > >                 }
> > > >
> > > >                 /* Fill the information of the new argument */
> > > > -               info->reg_type =3D
> > > > -                       PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NUL=
L;
> > > >                 info->btf_id =3D arg_btf_id;
> > > >                 info->btf =3D btf;
> > > >                 info->offset =3D offset;
> > > > +               if (is_nullable) {
> > > > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF=
_ID | PTR_MAYBE_NULL;
> > > > +               } else if (is_ref_acquired) {
> > > > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF=
_ID;
> > > > +                       info->ref_acquired =3D true;
> > > > +               }
> > > >
> > > >                 info++;
> > > >                 info_cnt++;
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 8c95392214ed..e462fb4a4598 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -6316,7 +6316,8 @@ bool btf_ctx_access(int off, int size, enum b=
pf_access_type type,
> > > >
> > > >         /* this is a pointer to another type */
> > > >         for (i =3D 0; i < prog->aux->ctx_arg_info_size; i++) {
> > > > -               const struct bpf_ctx_arg_aux *ctx_arg_info =3D &pro=
g->aux->ctx_arg_info[i];
> > > > +               struct bpf_ctx_arg_aux *ctx_arg_info =3D
> > > > +                       (struct bpf_ctx_arg_aux *)&prog->aux->ctx_a=
rg_info[i];
> > > >
> > > >                 if (ctx_arg_info->offset =3D=3D off) {
> > > >                         if (!ctx_arg_info->btf_id) {
> > > > @@ -6324,9 +6325,16 @@ bool btf_ctx_access(int off, int size, enum =
bpf_access_type type,
> > > >                                 return false;
> > > >                         }
> > > >
> > > > +                       if (ctx_arg_info->ref_acquired && !ctx_arg_=
info->ref_obj_id) {
> > > > +                               bpf_log(log, "cannot acquire a refe=
rence to context argument offset %u\n", off);
> > > > +                               return false;
> > > > +                       }
> > > > +
> > > >                         info->reg_type =3D ctx_arg_info->reg_type;
> > > >                         info->btf =3D ctx_arg_info->btf ? : btf_vml=
inux;
> > > >                         info->btf_id =3D ctx_arg_info->btf_id;
> > > > +                       info->ref_obj_id =3D ctx_arg_info->ref_obj_=
id;
> > > > +                       ctx_arg_info->ref_obj_id =3D 0;
> > > >                         return true;
> > >
> > > I think this is fragile. What if the compiler produces two independen=
t
> > > paths in the program which read the skb pointer once?
> > > Technically, the program is still reading the skb pointer once at run=
time.
> > > Then you will reset ref_obj_id to 0 when exploring one, and assign as
> > > 0 in the other one, causing errors.
> > > ctx_arg_info appears to be global for the program.
> > >
> > > I think the better way would be to check if ref_obj_id is still part
> > > of the reference state.
> > > If the ref_obj_id has already been dropped from reference_state, then
> > > any loads should get ref_obj_id =3D 0.
> > > That would happen when dropping or enqueueing the skb into qdisc,
> > > which would (I presume) do release_reference_state(ref_obj_id).
> > > Otherwise, all of them can share the same ref_obj_id. You won't have
> > > to implement "can only read once" logic,
> > > and when you enqueue stuff in the qdisc, all identical copies produce=
d
> > > from different load instructions will be invalidated.
> > > Same ref_obj_id =3D=3D unique ownership of the same object.
> > > You can already have multiple copies through rX =3D rY, multiple ctx
> > > loads of skb will produce a similar verifier state.
> > >
> > > So, on entry, assign ctx_arg_info->ref_obj_id uniquely, then on each =
load:
> > > if reference_state.find(ctx_arg_info->ref_obj_id) =3D=3D true; then
> > > info->ref_obj_id =3D ctx_arg_info->ref_obj_id; else info->ref_obj_id =
=3D
> > > 0;
> > >
> > > Let me know if I missed something.
> >
> > You are right. The current approach will falsely reject valid programs,
> > and your suggestion makes sense.
>
> Also, I wonder whether when ref_obj_id has been released, we should
> mark the loaded register as unknown scalar, vs skb with ref_obj_id =3D
> 0?
> Otherwise right now it will take PTR_TO_BTF_ID | PTR_TRUSTED as
> reg_type, and I think verifier will permit reads even if ref_obj_id =3D
> 0.

If reference_state.find(ctx_arg_info->ref_obj_id) =3D=3D false, I think we
should just return false from btf_ctx_access and reject the program
right away.

> This will surely be bad once skb is dropped/enqueued, since the
> program should no longer be able to read such memory.
>
> >
> > Thanks,
> > Amery

