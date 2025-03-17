Return-Path: <bpf+bounces-54235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A292DA65E4F
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 20:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4EB420A6B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB11EB5D6;
	Mon, 17 Mar 2025 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW1QUi6q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D21C6FF7;
	Mon, 17 Mar 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240659; cv=none; b=Pjp3e9TA0/voUgg4PT2Bk1VoJepILMm9kwNnyeBcDyb/8jy9dBCr/QuTgLx0uPV1b7eaCbqdW3R0Y0Q40aMlLp1qnBUsqkDql//MaTfzQNeSZsQNyoh8X4WswcP4P0171ueR/0BHk/oNwpQz0leMoyVJHM5+wZjXaHN1bXOZ5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240659; c=relaxed/simple;
	bh=f2vuE+nTrayzhhqMMZKQ8JSb0fGRCq89tyb6ucXEec8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qgi3xme66FFSeImz6vz0bOBBym19dqc8mEu5uXuiG8Kn8fnhGs6IiOaO4kP+ByOo6SilJJIlm0zCaHAO0Neix+1CJy9JKOyFpO1jLJKaPqBk+OR/RB7Q/rxPypplvj6N0eMXr+eNX9EkO1loLA6sRuwVofR/MnLVMP5twxijJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW1QUi6q; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fedf6aaed2so43052897b3.0;
        Mon, 17 Mar 2025 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742240655; x=1742845455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2mdqqe5PIecBodd6/2WI/jBOXfRtlmQjfSn4HBReDY=;
        b=dW1QUi6qlqPUFN83pyu8ugsOVPVB1zzHvQoErBFGP5t6lYrNvGt6e1gjo433NwAo/W
         ceBxu0u6cDPdNUZX9XgJQFq34QvfY3z+9gcu57ufI5Znx9DYEK3IRkPZg/k3myemr20B
         rboaeiANYwDFwgurLVGpTd0JJ9/pmV1lDwBDJhfx3fg9sVygprWstH87Mazp7Qux6az5
         PCD10T3Y+j9LWKM99Ii2sZB/qg0Lj/2khGw//SyWFKDw8clKD+/b3Yyo6+XwmgYzE12a
         s1QM01QAgjEfxzuBbG7mGOlN11lTe66t4srVSt5+D37qZl7Wv/2X/aHCjSRc3CG6W4rJ
         6+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742240655; x=1742845455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2mdqqe5PIecBodd6/2WI/jBOXfRtlmQjfSn4HBReDY=;
        b=FIq99ilJj7Aiao7pBA+DpWC7+v6kqJnoeECG23yFMCqns01JbHS9T0j4c001izJ8Lg
         jqmeruc6hqLCTxb3h3oKSzr03HSOvoqnmahdKXbYYhQIlsig4HocsLlT/4Sc0SGQ9OZT
         GK0kMUeNWIXD46/CdiA+THF0FxjZbSS87wcgrxOEpR03R2Aj6B168a7RRXZvkh2CGXvQ
         CE0LPnIbES4wPbwCQMbUmMn1UMvRHdcwKUO0R6O6J4z4djWktNuzGl31Z5HVa4UooEsd
         ro49V5SnbUwrrdCXSidL10wL9U49XyoowXgaIR05wsizeTKUn0Z5O19s9HzCGAoqwf4b
         uhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyren7LmcSOUzndOynd+nyQd6dMgPXHpk6UuoIIkXI/FVVqd3PMzEri+FewJuCDwtyTEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjmb9Gp/hn9MuhsN5H00hq/uhFYQcQgz2JCBZNg5HZ3RZsIVvo
	wdvOF1fIZnMFWJfFcpCKQySekJ+rWPIJqSxxPhYlPAmbr3ap2nsKJf/AwI5rRTK7WXys9tnwVOx
	fItFagqfnRya14sbuFPTMtN7LqnY=
X-Gm-Gg: ASbGnctfm8qfxBQYA+XCb/20MHxvOKJxLCS6ZfgFArVd3G/fLu3egtT454AYflgbqML
	ksOhP7eluZYduzGsQDZ5mSwd5nj5/MYXqkJWFC/8NDWUGVKqTzabAnfG/EZMz1eDV5FTx/ZzBTq
	XHyLUz0PXLVgEt0pypFRppEgpPBbGhuM2LQzc0
X-Google-Smtp-Source: AGHT+IFYUj5KmocqF1Ytx0Co9xELeTU2Rkf0A3qLWZKMaQDcYr0zvQjFvahxg+hDIcZ65eRmi+EykVRo8eftiDzJidk=
X-Received: by 2002:a81:fe0c:0:b0:6f9:5a36:577d with SMTP id
 00721157ae682-6fff2f4792cmr9728807b3.9.1742240655591; Mon, 17 Mar 2025
 12:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-5-ameryhung@gmail.com>
 <CAADnVQ+ayU=H0gzFdh5Yfx=Aya4PXUJYvQoOXb+4=wsgmnnDQQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+ayU=H0gzFdh5Yfx=Aya4PXUJYvQoOXb+4=wsgmnnDQQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 17 Mar 2025 12:44:04 -0700
X-Gm-Features: AQ5f1Jr0xnJwXbZzk8hoxIu2f7Q_5E9c-1L_nswiqKAVM2XmlXF3xKDiqXkwvOA
Message-ID: <CAMB2axOufMapSm2hgpCjRj9sC0K0iUtj9es2zFEA26F3SYY5Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 04/13] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <stfomichev@gmail.com>, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	Peilin Ye <yepeilin.cs@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:14=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 13, 2025 at 12:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > From: Amery Hung <amery.hung@bytedance.com>
> >
> > Add basic kfuncs for working on skb in qdisc.
> >
> > Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> > a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> > in .enqueue where a to_free skb list is available from kernel to defer
> > the release. bpf_kfree_skb() should be used elsewhere. It is also used
> > in bpf_obj_free_fields() when cleaning up skb in maps and collections.
> >
> > bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> > to build flow-based queueing algorithms.
> >
> > Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb=
().
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  include/linux/bpf.h         |  1 +
> >  kernel/bpf/bpf_struct_ops.c |  2 +
> >  net/sched/bpf_qdisc.c       | 93 ++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 463e922cb0f5..d3b0c4ccaebf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1826,6 +1826,7 @@ struct bpf_struct_ops {
> >         void *cfi_stubs;
> >         struct module *owner;
> >         const char *name;
> > +       const struct btf_type *type;
> >         struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS=
];
> >  };
>
> there is an alternative to this...
>
> > +static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > +{
> > +       if (bpf_Qdisc_ops.type !=3D btf_type_by_id(prog->aux->attach_bt=
f,
> > +                                                prog->aux->attach_btf_=
id))
> > +               return 0;
> > +
> > +       /* Skip the check when prog->attach_func_name is not yet availa=
ble
> > +        * during check_cfg().
> > +        */
> > +       if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id) ||
> > +           !prog->aux->attach_func_name)
> > +               return 0;
> > +
> > +       if (bpf_struct_ops_prog_moff(prog) =3D=3D offsetof(struct Qdisc=
_ops, enqueue)) {
> > +               if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc=
_id))
> > +                       return 0;
> > +       }
>
> Instead of logic in this patch and patch 2,
> I think it's cleaner to do:
> https://lore.kernel.org/all/AM6PR03MB50804BE76B752350307B6B4C99C22@AM6PR0=
3MB5080.eurprd03.prod.outlook.com/
>
> then in this patch it will be
>
> if (prog->aux->st_ops !=3D &bpf_Qdisc_ops)
>
> and instead of unchecked array accesses in bpf_struct_ops_prog_moff()
> it will be prog->aux->attach_st_ops_member_off
>
> Also see flag based approach in Juntong's patch 3+4.
> imo it looks cleaner (more extensible with more checks per st_ops hook)
> than offsetof() approach above.

Thanks for the pointer! I will drop patch 2 and adopt the flag-based
kfunc filter.

