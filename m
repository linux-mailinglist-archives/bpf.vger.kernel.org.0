Return-Path: <bpf+bounces-48877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF9A1158C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E0188ADA4
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239521A95D;
	Tue, 14 Jan 2025 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAFUUn67"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3E20AF6D;
	Tue, 14 Jan 2025 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898068; cv=none; b=PuORcrFIo9vPCwjXjuiqEn6aTe4spjhIdeRW40LF8r/wvLumneOeMZJl0VD3ZYTdJlpDyKR3We1mpn+4E/H58EF6dE7D1XBdu5RsmZhvdQzRbAGCNk3isg+N7R9WIDht8p+s+PKTVvOS/HQY1ZvBPVKlLACqmS8NZRHvC8s7GK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898068; c=relaxed/simple;
	bh=CQP3i3QB8oe/S7xyv3hPMbeo7D32peUudyJ2U0/td0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBUaxBj6fhFhAyxawy/6zxzFKwHS+pQ7nJyI7VMTxw89UXR5lRANhzq6c8Cxzqqx9CsxH2JC5MI4ybb7MbF4lctQlpI3l1rkxaUX76o8jblo3phSjHoEPdc6g6tzx1ttzvo5mQ1zfKTKpB3RbA9WUaK43rFjwh8ebZnJiCIQrgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAFUUn67; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso7650095a91.2;
        Tue, 14 Jan 2025 15:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736898066; x=1737502866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmD49jye9UJ2vROnNunI3Y0FqAxabDLTyoRYBe3Lc6M=;
        b=IAFUUn67bCPivEBh7UADJfleKUt5JQB7UifbtPukq5s3ZUS/SgWlko4CgY3FZNIDqe
         or0hww7fBVUld6Ixn2WIOnPCwnkqKzTj7YuPn7S+1Vz7L28gaWPppPhylIxEDBuT67YQ
         vb+qM9js9HFFieE8/DnQetoqAiKMOrC6m0LViODHtd57QrR2Axc17KG7zq6gHlyDmWMb
         Rhd0FLwjqSBGKUKf7iUEdw9q1qWPXduaH0uDwwZLotLw1YotV8C1i/2yfmKxzQeERzXl
         fF8Z1EJuFVImjTa/fWgogL7ux6GeU4gVQK0vOku0BCWsT9UpyOUbUs7MgkfwRJz98gvB
         vmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736898066; x=1737502866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmD49jye9UJ2vROnNunI3Y0FqAxabDLTyoRYBe3Lc6M=;
        b=tONlZDBmoxslEDUQgHJgzrt6GSBdvrJ8LVGSUJmJMKCA9TN9B+TqAgNILaBX2xYEDy
         eNrfwieVpRhd/Q6cbOjayTK4TcZSJv6IkmxLoIfElBpi0T8zH3xQbolYasG6hbLfS7Mh
         PXOlknc0+DF5uWiGglL5T4MHhLj1RGx1Y39/goIrVSRjwrQtiLPPiAPshc5ULOdMBKlW
         5wPgmF0iKfEplswi2kdsuNqohEyHLgAZO6we8PYGL6k+j+QGNdkRxki8UeV891gjJLxu
         jLFPu6o5EnXrxet3ok5virKlBE3RxGy9O7o92SqzCpnYjEyu7M4EGPOb/3K2OmMze/LM
         kLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx6S5npWYdcNhVGP1mw2qOKJ5yICvLrjZMWR1QicEOTdh4TxFmcmz4V+r1459EcO22swthUvgi8ECqW55v53+HnHN0Gwf6@vger.kernel.org, AJvYcCV1egKJSToK03Dnf0nLDylHxNsyYcneU8mjot/MwMEqtn+9cZO3o1WUF3OHo09bNIj1qbA=@vger.kernel.org, AJvYcCV7u6wkAaT0H1zxShoql2ud2ANnX+GeooTcknnxnCYDI8lgZRA47IUI2xiRmhdivAhrTaXw5fdOtR2viKnv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5EccUDqlPJuTlhfhb0MUy6R29gJJSptQNtOhUXEACHKScNOb4
	6bTixOjO9HVGyvxfFn9eMucfacunRm4d/ob0SAamhF+29VscC+s1HwYR5+bFKr6ROITdJj99AWY
	xf0t1OAwQVz60aQcg4/Cb4XVf8pc=
X-Gm-Gg: ASbGncsLH5CwnI/nIFD+d7+9jIoXY2pmSenaiRVsl/GgURhG4zcIu2H1nvXelY/eh1O
	9zEFw+WZo5+ZIvDda1PenySyra4gueSfe3rX3
X-Google-Smtp-Source: AGHT+IGxB6CBWo8c5JzL5e9t4fnNDKIcb/TpNxYbCEdy0b339aXPsh0GAqa0Db0q1UbPeqfOncP5EvphZzMnvFsZ1no=
X-Received: by 2002:a17:90b:51c4:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2f548f1d732mr37533992a91.28.1736898066286; Tue, 14 Jan 2025
 15:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108225140.3467654-1-song@kernel.org> <20250108225140.3467654-6-song@kernel.org>
 <CAEf4BzapTMSfv4afg8QnV-mX2nL8cKboXCTBwp-_cRk8ybKnQQ@mail.gmail.com> <B7F9964F-63F0-4ED6-A798-37407855675F@fb.com>
In-Reply-To: <B7F9964F-63F0-4ED6-A798-37407855675F@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 15:40:52 -0800
X-Gm-Features: AbW1kvam93kQbOr0TRiuD-JlqykPuI7JkSHpSDvQ9jDVq-QgMMWSndl-uwHUdVU
Message-ID: <CAEf4BzYfEAUsywfGLnnZ_wZC40icq6viYhgGywq8eKm9DMqSYA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	"paul@paul-moore.com" <paul@paul-moore.com>, "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, "memxor@gmail.com" <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 3:03=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Jan 14, 2025, at 2:37=E2=80=AFPM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:
> >
>
> [...]
>
> >>
> >>        if (bpf_dev_bound_kfunc_id(func_id)) {
> >>                xdp_kfunc =3D bpf_dev_bound_resolve_kfunc(prog, func_id=
);
> >> @@ -20833,22 +20836,6 @@ static void specialize_kfunc(struct bpf_verif=
ier_env *env,
> >>                }
> >>                /* fallback to default kfunc when not supported by netd=
ev */
> >>        }
> >> -
> >> -       if (offset)
> >> -               return;
> >> -
> >> -       if (func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb])=
 {
> >> -               seen_direct_write =3D env->seen_direct_write;
> >> -               is_rdonly =3D !may_access_direct_pkt_data(env, NULL, B=
PF_WRITE);
> >> -
> >> -               if (is_rdonly)
> >> -                       *addr =3D (unsigned long)bpf_dynptr_from_skb_r=
donly;
> >> -
> >> -               /* restore env->seen_direct_write to its original valu=
e, since
> >> -                * may_access_direct_pkt_data mutates it
> >> -                */
> >> -               env->seen_direct_write =3D seen_direct_write;
> >
> > is it safe to remove this special seen_direct_write part of logic?
>
> We need to save and restore seen_direct_write because
> may_access_direct_pkt_data() mutates it. If we do not call
> may_access_direct_pkt_data() here, as after this patch, we don't need to
> save and restore seen_direct_write.
>

ah, existing logic is quite convoluted (and that resolve_prog_type()
bit is another gotcha that's easy to miss), ok, so we used some
side-effecting function for simulating side effect-free check...

> >
> >> -       }
> >> }
> >>
> >> static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *=
insn_aux,
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 21131ec25f24..f12bcc1b21d1 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -12047,10 +12047,8 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struc=
t __sk_buff *s, struct sock *sk,
> >> #endif
> >> }
> >>
> >> -__bpf_kfunc_end_defs();
> >> -
> >> -int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> >> -                              struct bpf_dynptr *ptr__uninit)
> >> +__bpf_kfunc int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64=
 flags,
> >> +                                          struct bpf_dynptr *ptr__uni=
nit)
> >> {
> >>        struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)ptr__=
uninit;
> >>        int err;
> >> @@ -12064,10 +12062,16 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_b=
uff *skb, u64 flags,
> >>        return 0;
> >> }
>
> [...]
>
> >> +
> >> +static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 k=
func_id)
> >> +{
> >> +       if (kfunc_id !=3D bpf_dynptr_from_skb_list[0])
> >> +               return 0;
> >> +
> >> +       switch (resolve_prog_type(prog)) {
> >> +       /* Program types only with direct read access go here! */
> >> +       case BPF_PROG_TYPE_LWT_IN:
> >> +       case BPF_PROG_TYPE_LWT_OUT:
> >> +       case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> >> +       case BPF_PROG_TYPE_SK_REUSEPORT:
> >> +       case BPF_PROG_TYPE_FLOW_DISSECTOR:
> >> +       case BPF_PROG_TYPE_CGROUP_SKB:
> >> +               return bpf_dynptr_from_skb_list[1];
> >> +
> >> +       /* Program types with direct read + write access go here! */
> >> +       case BPF_PROG_TYPE_SCHED_CLS:
> >> +       case BPF_PROG_TYPE_SCHED_ACT:
> >> +       case BPF_PROG_TYPE_XDP:
> >> +       case BPF_PROG_TYPE_LWT_XMIT:
> >> +       case BPF_PROG_TYPE_SK_SKB:
> >> +       case BPF_PROG_TYPE_SK_MSG:
> >> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> >> +               return kfunc_id;
> >> +
> >> +       default:
> >> +               break;
> >> +       }
> >> +       return bpf_dynptr_from_skb_list[1];
> >> +}
> >
> > I'd personally prefer the approach we have with BPF helpers, where
> > each program type has a function that handles all helpers (identified
> > by its ID), and then we can use C code sharing to minimize duplication
> > of code.
>
> Different hooks of the same program type, especially struct_ops, may
> not have same access to different kfuncs. Therefore, I am not sure
> whether the approach with helpers can scale in the long term. At the
> moment, we use special_kfunc_[type|set|list] to handle special cases.
> But I am afraid this approach cannot work well with more struct_ops
> and kfuncs.
>

I think we had discussion in the similar vein at last LSF/MM/BPF.
struct_ops is sort of a "meta program type", I don't consider it to be
sufficient by itself. For struct_ops you need to know which exact
struct_ops callback is being considered (that's what would identify
"BPF program type" in the pre-struct_ops world).

But anyways, somehow BPF helpers approach worked across lots of
program types, not sure I see why it wouldn't work for kfuncs
(especially taking into account extending struct_ops with more
detailed "which struct_ops callback" bit).

> >
> > With this approach it seems like we'll have more duplication and we'll
> > need to repeat these program type-based large switches for various
> > small sets of kfuncs, no?
>
> The motivation is to make the verification of kfuncs more modular, so
> that each set of kfuncs handle their verification as much as possible.
>
> I think the code duplication here (bpf_kfunc_set_skb_remap) is not a
> common problem. And we can actually reduce duplication with some
> simple helpers.
>
> Does this make sense?

see above, I'm a bit skeptical, buf proof is in the pudding ;)

>
> Thanks,
> Song
>
>

