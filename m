Return-Path: <bpf+bounces-29898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9405F8C7FBB
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 04:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6061F21DFA
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660561C3D;
	Fri, 17 May 2024 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdylU0nP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B917D2;
	Fri, 17 May 2024 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911250; cv=none; b=Au44YpFI2zZgCIHIebPoQSqjBg1sm4g0M27g9pbgpEXUY3/Fwg20tHjm5PEOXjlI8NFqsL+xVLlrX/QP7P7oyHZTIUwGs774TlGBm8nM9jxAwlJxXkZOx8fFrRENvWiwcLfcTPy8Fls6HeEw97fwU7lLdLdEtWkSje49Wu5Fdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911250; c=relaxed/simple;
	bh=6O7EsyByF7AQUdY0sJST9zhchb45YYH+do6TJLgdJqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s553qZvJWT6NtGCCzojpGeIpfkkNXm2C5RsyxUPeAlR+u9IY9eVexqlGaK/wwd1fQGSRFyEU8vD1QKxRUM9kTi1pK8RkEHYcLQNlFHB7czW0g3Rbk1egco5vzvzfHNYzUR0XXN2PbJTzx09/vkgnCBpRhf+nJm+8rXvQDJa50ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdylU0nP; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso123988e87.0;
        Thu, 16 May 2024 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715911246; x=1716516046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXf5bOQTREnlmvETyGl7T4t7yZZljEPRi8h67r6MYSc=;
        b=jdylU0nPr88jls4EkrpnAjEi4xWHOifcYy00fD6Ag9a7FaUg9MB7/cMSVZqzs9cIy8
         AZGrPpAfqEnqnfSvE02MQHzK8UAYeUOVVG+ktbLeJ5rg0XOca3v8ct8y+FcP0eoR8KHY
         E7tjUbVqjoFrJ1uYKXDge6txYLlNOmkCFwMPLc3gvedenDKhmtdlnQRlj6r6JQXol65g
         n9q9SrQ59xTZ9LgBtFIEzRBQXsKLjld5PUbtSKlO2iNdfKm40uQzZzdtmrgKW8eoWbDT
         zCxAWJXNUo30q+JcayGuHnPVUaf6FldRsNmXputocQCyuNnFT5TpfQcxBGEhUxmWMp+g
         TQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715911246; x=1716516046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXf5bOQTREnlmvETyGl7T4t7yZZljEPRi8h67r6MYSc=;
        b=XOM16nbSMFooJ9nKahpp1hpp+8N0kdxoMxGddRMn4pc59B+NnPZfr5hzKY4gYej8Jm
         VF4lhsTBCwQATdMMV51BEO1QYlQJFnN+liMi8c2JlFawbAfFeJxVKXlI9yvwU9+8Ghe9
         4w9NrQyIR5rRT3Lu/0i3iJPkP+M6IUZfOmUmdBM5koH66ufiFlBC1YpPOBOefTDXc8Wz
         hQlNYsa+dMZIn9A4JMOyO2PSxdGN48Yx1rOPoQ0yWWoiyiWS8WyVJTvvgKJIv0+dke83
         gX3VOlOfbjEPHNuG+5KXAce4ft+9BCiOK32G5cqheLr3uC4twq38V8JCExbC/emDrv/1
         2Ggg==
X-Forwarded-Encrypted: i=1; AJvYcCWKiopPOBpA92YdFrNpL7HLVBJqAkvVotMqCoG7OIkIXLZjFhs/9XnlEK5lxwW95Im5lr3ajD7CqsJPrKUeaQ0rkEQL
X-Gm-Message-State: AOJu0Yxti2N9bRyhxdVNL1Wn1vmYWh9GkxDTGz9VMrz+iNpRSLYyDaxQ
	5lmt0hud/uZaZxv+BsYkHQDH/OSWBTtYhG1l2DQ+VYj6fFTl3R4JVme0qnrpZnMj+4oQp8pLk1L
	McoXokqmB04SrtYDxwnaRkCkk/Rg=
X-Google-Smtp-Source: AGHT+IFzSSppO253rIFFAkQWT6qfadqp/5OC/oIkVJUmC69j1/pCOA/YoGXEmUsCgKd+7VbLJWgPJ2TY6/R5hadVwxE=
X-Received: by 2002:a05:6512:3605:b0:51f:b781:729d with SMTP id
 2adb3069b0e04-5220fd7acf5mr11045154e87.38.1715911245800; Thu, 16 May 2024
 19:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-2-amery.hung@bytedance.com> <CAP01T74iSVPnRsAbdNfzXYYS7GsdCSgp3QiaPSzex6d+3J5AAA@mail.gmail.com>
 <CAMB2axP1C1wVRsq2uDGW0r6-OM8yWvZ9LB0WwEtuSAYsU2T0fg@mail.gmail.com>
 <CAP01T74mQPMktHJiPoZ7z-UfFCRoxOexpBe_X2v3rLpE5A+WEA@mail.gmail.com> <CAMB2axOho5uoWv6NSJSydtA+Y0OytpaMnqP38aaVaeaG-qdv7A@mail.gmail.com>
In-Reply-To: <CAMB2axOho5uoWv6NSJSydtA+Y0OytpaMnqP38aaVaeaG-qdv7A@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 17 May 2024 04:00:08 +0200
Message-ID: <CAP01T77A9h8Roi6hnonQbtxcfthR9Jar8810swBS=qkdPnazGw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 01/20] bpf: Support passing referenced kptr to
 struct_ops programs
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 at 03:22, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Thu, May 16, 2024 at 5:24=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 17 May 2024 at 02:17, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > On Thu, May 16, 2024 at 4:59=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Fri, 10 May 2024 at 21:24, Amery Hung <ameryhung@gmail.com> wrot=
e:
> > > > >
> > > > > This patch supports struct_ops programs that acqurie referenced k=
ptrs
> > > > > throguh arguments. In Qdisc_ops, an skb is passed to ".enqueue" i=
n the
> > > > > first argument. The qdisc becomes the sole owner of the skb and m=
ust
> > > > > enqueue or drop the skb. This matches the referenced kptr semanti=
c
> > > > > in bpf. However, the existing practice of acquiring a referenced =
kptr via
> > > > > a kfunc with KF_ACQUIRE does not play well in this case. Calling =
kfuncs
> > > > > repeatedly allows the user to acquire multiple references, while =
there
> > > > > should be only one reference to a unique skb in a qdisc.
> > > > >
> > > > > The solutioin is to make a struct_ops program automatically acqui=
re a
> > > > > referenced kptr through a tagged argument in the stub function. W=
hen
> > > > > tagged with "__ref_acquired" (suggestion for a better name?), an
> > > > > reference kptr (ref_obj_id > 0) will be acquired automatically wh=
en
> > > > > entering the program. In addition, only the first read to the arg=
uement
> > > > > is allowed and it will yeild a referenced kptr.
> > > > >
> > > > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > > > ---
> > > > >  include/linux/bpf.h         |  3 +++
> > > > >  kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++----
> > > > >  kernel/bpf/btf.c            | 10 +++++++++-
> > > > >  kernel/bpf/verifier.c       | 16 +++++++++++++---
> > > > >  4 files changed, 38 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 9c6a7b8ff963..6aabca1581fe 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -914,6 +914,7 @@ struct bpf_insn_access_aux {
> > > > >                 struct {
> > > > >                         struct btf *btf;
> > > > >                         u32 btf_id;
> > > > > +                       u32 ref_obj_id;
> > > > >                 };
> > > > >         };
> > > > >         struct bpf_verifier_log *log; /* for verbose logs */
> > > > > @@ -1416,6 +1417,8 @@ struct bpf_ctx_arg_aux {
> > > > >         enum bpf_reg_type reg_type;
> > > > >         struct btf *btf;
> > > > >         u32 btf_id;
> > > > > +       u32 ref_obj_id;
> > > > > +       bool ref_acquired;
> > > > >  };
> > > > >
> > > > >  struct btf_mod_pair {
> > > > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_=
ops.c
> > > > > index 86c7884abaf8..bca8e5936846 100644
> > > > > --- a/kernel/bpf/bpf_struct_ops.c
> > > > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > > > @@ -143,6 +143,7 @@ void bpf_struct_ops_image_free(void *image)
> > > > >  }
> > > > >
> > > > >  #define MAYBE_NULL_SUFFIX "__nullable"
> > > > > +#define REF_ACQUIRED_SUFFIX "__ref_acquired"
> > > > >  #define MAX_STUB_NAME 128
> > > > >
> > > > >  /* Return the type info of a stub function, if it exists.
> > > > > @@ -204,6 +205,7 @@ static int prepare_arg_info(struct btf *btf,
> > > > >                             struct bpf_struct_ops_arg_info *arg_i=
nfo)
> > > > >  {
> > > > >         const struct btf_type *stub_func_proto, *pointed_type;
> > > > > +       bool is_nullable =3D false, is_ref_acquired =3D false;
> > > > >         const struct btf_param *stub_args, *args;
> > > > >         struct bpf_ctx_arg_aux *info, *info_buf;
> > > > >         u32 nargs, arg_no, info_cnt =3D 0;
> > > > > @@ -240,8 +242,11 @@ static int prepare_arg_info(struct btf *btf,
> > > > >                 /* Skip arguments that is not suffixed with
> > > > >                  * "__nullable".
> > > > >                  */
> > > > > -               if (!btf_param_match_suffix(btf, &stub_args[arg_n=
o],
> > > > > -                                           MAYBE_NULL_SUFFIX))
> > > > > +               is_nullable =3D btf_param_match_suffix(btf, &stub=
_args[arg_no],
> > > > > +                                                    MAYBE_NULL_S=
UFFIX);
> > > > > +               is_ref_acquired =3D btf_param_match_suffix(btf, &=
stub_args[arg_no],
> > > > > +                                                      REF_ACQUIR=
ED_SUFFIX);
> > > > > +               if (!(is_nullable || is_ref_acquired))
> > > > >                         continue;
> > > > >
> > > > >                 /* Should be a pointer to struct */
> > > > > @@ -269,11 +274,15 @@ static int prepare_arg_info(struct btf *btf=
,
> > > > >                 }
> > > > >
> > > > >                 /* Fill the information of the new argument */
> > > > > -               info->reg_type =3D
> > > > > -                       PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_N=
ULL;
> > > > >                 info->btf_id =3D arg_btf_id;
> > > > >                 info->btf =3D btf;
> > > > >                 info->offset =3D offset;
> > > > > +               if (is_nullable) {
> > > > > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_B=
TF_ID | PTR_MAYBE_NULL;
> > > > > +               } else if (is_ref_acquired) {
> > > > > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_B=
TF_ID;
> > > > > +                       info->ref_acquired =3D true;
> > > > > +               }
> > > > >
> > > > >                 info++;
> > > > >                 info_cnt++;
> > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > index 8c95392214ed..e462fb4a4598 100644
> > > > > --- a/kernel/bpf/btf.c
> > > > > +++ b/kernel/bpf/btf.c
> > > > > @@ -6316,7 +6316,8 @@ bool btf_ctx_access(int off, int size, enum=
 bpf_access_type type,
> > > > >
> > > > >         /* this is a pointer to another type */
> > > > >         for (i =3D 0; i < prog->aux->ctx_arg_info_size; i++) {
> > > > > -               const struct bpf_ctx_arg_aux *ctx_arg_info =3D &p=
rog->aux->ctx_arg_info[i];
> > > > > +               struct bpf_ctx_arg_aux *ctx_arg_info =3D
> > > > > +                       (struct bpf_ctx_arg_aux *)&prog->aux->ctx=
_arg_info[i];
> > > > >
> > > > >                 if (ctx_arg_info->offset =3D=3D off) {
> > > > >                         if (!ctx_arg_info->btf_id) {
> > > > > @@ -6324,9 +6325,16 @@ bool btf_ctx_access(int off, int size, enu=
m bpf_access_type type,
> > > > >                                 return false;
> > > > >                         }
> > > > >
> > > > > +                       if (ctx_arg_info->ref_acquired && !ctx_ar=
g_info->ref_obj_id) {
> > > > > +                               bpf_log(log, "cannot acquire a re=
ference to context argument offset %u\n", off);
> > > > > +                               return false;
> > > > > +                       }
> > > > > +
> > > > >                         info->reg_type =3D ctx_arg_info->reg_type=
;
> > > > >                         info->btf =3D ctx_arg_info->btf ? : btf_v=
mlinux;
> > > > >                         info->btf_id =3D ctx_arg_info->btf_id;
> > > > > +                       info->ref_obj_id =3D ctx_arg_info->ref_ob=
j_id;
> > > > > +                       ctx_arg_info->ref_obj_id =3D 0;
> > > > >                         return true;
> > > >
> > > > I think this is fragile. What if the compiler produces two independ=
ent
> > > > paths in the program which read the skb pointer once?
> > > > Technically, the program is still reading the skb pointer once at r=
untime.
> > > > Then you will reset ref_obj_id to 0 when exploring one, and assign =
as
> > > > 0 in the other one, causing errors.
> > > > ctx_arg_info appears to be global for the program.
> > > >
> > > > I think the better way would be to check if ref_obj_id is still par=
t
> > > > of the reference state.
> > > > If the ref_obj_id has already been dropped from reference_state, th=
en
> > > > any loads should get ref_obj_id =3D 0.
> > > > That would happen when dropping or enqueueing the skb into qdisc,
> > > > which would (I presume) do release_reference_state(ref_obj_id).
> > > > Otherwise, all of them can share the same ref_obj_id. You won't hav=
e
> > > > to implement "can only read once" logic,
> > > > and when you enqueue stuff in the qdisc, all identical copies produ=
ced
> > > > from different load instructions will be invalidated.
> > > > Same ref_obj_id =3D=3D unique ownership of the same object.
> > > > You can already have multiple copies through rX =3D rY, multiple ct=
x
> > > > loads of skb will produce a similar verifier state.
> > > >
> > > > So, on entry, assign ctx_arg_info->ref_obj_id uniquely, then on eac=
h load:
> > > > if reference_state.find(ctx_arg_info->ref_obj_id) =3D=3D true; then
> > > > info->ref_obj_id =3D ctx_arg_info->ref_obj_id; else info->ref_obj_i=
d =3D
> > > > 0;
> > > >
> > > > Let me know if I missed something.
> > >
> > > You are right. The current approach will falsely reject valid program=
s,
> > > and your suggestion makes sense.
> >
> > Also, I wonder whether when ref_obj_id has been released, we should
> > mark the loaded register as unknown scalar, vs skb with ref_obj_id =3D
> > 0?
> > Otherwise right now it will take PTR_TO_BTF_ID | PTR_TRUSTED as
> > reg_type, and I think verifier will permit reads even if ref_obj_id =3D
> > 0.
>
> If reference_state.find(ctx_arg_info->ref_obj_id) =3D=3D false, I think w=
e
> should just return false from btf_ctx_access and reject the program
> right away.
>

Hm, yeah, that could be another option as well.
Might be better than returning a scalar and confusing people on usage later=
.

