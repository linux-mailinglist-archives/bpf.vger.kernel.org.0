Return-Path: <bpf+bounces-68868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA2B872CD
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4F01C87431
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508CF277C8B;
	Thu, 18 Sep 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc2OCpeh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB202222B4
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232043; cv=none; b=roUIyUbimnVRVjZ6quDUR7eW5ujUoPYhJr28uTgukKYNfKx5a9FJOdgQFqmJgRmYRzZ8wzqsRSEUnpv6i7JucU3Wbeg/BVSSksYQyeqEBcF/7cy7pagIw3IQOjX61VRET609gSRYYRsO9ptugJ/mIAbAorxGCbq0TCvLPH5ykgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232043; c=relaxed/simple;
	bh=+FO6/wjFq3GROZOiAkUkXegr9vP1qIhC5dTkqrljYoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgAxGwTweMekSXPR5N9Dmrs+Yw6wEvAOIb8XUNhRpmOhNH/KLBeJSoDWqMUTLmB13db1IoQtrERe0gtKjCcPIu86DOk5IOSI6pJGBuUGySvXlkEi+0DReNXlscaNu9aiIrO04ILGBGmrqhhfuSEdRuiX6m+7tljdor/9U2+LVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fc2OCpeh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7761578340dso2067734b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758232042; x=1758836842; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IhuodsNGru1u8IboCcSvpPmXNjgxme8YBdtZo/QYu6Y=;
        b=Fc2OCpehU36td9FXVXf4QAVV0pgwksqKpUg6G5gF8j/zQzvr5O/wu5/Tv+hPLUNQGp
         /iE9i3cZJtVQE32hwuN1R85DUQJ9ZYojRTCjbaPFNvCX6zQkppP4UCwHhGy/5MTyNrX+
         aG+iQf88UNxz/YW2rg4VFweSpnlc80ASTIt4fQS4DRARu7EonDiT/rGHl5Zhz5Tc94uF
         qiS9XIbowWT4TIAah40QR3rIEm8QXZ/JcFXG24OyYBv/VCzA3YsJVticDf+ypxICjOWY
         F9m6b/XRMYfTrpceNJ/8k7SWdHnxrYry0ePleoMq3A0w6/3FXWsTUMw5c0PX4d0QZN/s
         EUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232042; x=1758836842;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhuodsNGru1u8IboCcSvpPmXNjgxme8YBdtZo/QYu6Y=;
        b=L0hb8zBV8zA9xoEnl25L+spSx81znDDpcAr1f5EeWygZPwd3Am9YHGzcpsamjkyDJ+
         2uN0lQvJg06lxN631UgvEVuiS+LzgsG71ghXZoebEqbVd+YW7HHKeAdQOI3qtr9Z9Nq/
         OFAzxvVd1eV/4DV2UlJKd6Rz/2XmPQ7DGIMw/xOMzJhUuVpZQKEmiI/RHQNG5qw1ue0S
         QAb6hnbPsWa8J0dft9CgZtlr3sSV8ZwyoEiIDxoH7Ai83QzDkTvMvcipeHC0j5soR4D0
         mvV7quj3lyxAEbe71U76vXjANzoFxGqtD2bJfBBXOkT/yDNr9hQrD6ANOimpXYBkN2iI
         Mhyw==
X-Gm-Message-State: AOJu0YyMosNFmc0XOUc6YYJsGnm3SXqET00x5/KewH+zo6bXZPk2eBFg
	JYVQjeXL1UPAkMluf3PZ/chqpSlios0MxsqP6V43aMQmlYVNAZ/Wnruftr/qWxO6
X-Gm-Gg: ASbGncuqHrHNO31yAWc5RPC/kzyFnTnEHGXW6Hp9XHIE22PP6ed5aZ2dc78rh2yXq5C
	jAOeNOToO3EfSIuWB3JfP9WH+HiALatmq9IQQ4UxdjewQtKtJYVpIPbssVwEYZLbGk9hD9PcZCm
	6RfcvXtPRB/JEYJfhWRf8gV/KVP04rAR5eDnDxI6fxhpN/jWTc3wl3MzK0D/JbMjWvKFnxSBscT
	7tIQuRhudozd3/QF/RgIvXteEGjYk9D11uJsRJcKIVbKI3OL70BiICF5NVQxKrb2hwE24lEH1mU
	8kL/TwRj2if862EApRG/vYthzofeeyivwqXQJZUJkKty/DHTl//Dma8zTx6AjcV7hQvNkbq6iB4
	7CL8Bki0w3O0KDTlb3zlj81ciebelfoCAC5gRXA==
X-Google-Smtp-Source: AGHT+IGOudU4aNBcoYM4LwtTH4S0BzkF6lmP8tUhsjNgIGLDqOesZWlnwUT3C5igGeNqz5CNCs9n1Q==
X-Received: by 2002:a05:6a20:3c8e:b0:250:429b:9e56 with SMTP id adf61e73a8af0-2925ca2bd50mr1467370637.8.1758232041595;
        Thu, 18 Sep 2025 14:47:21 -0700 (PDT)
Received: from [192.168.28.36] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff43f495sm3121229a12.50.2025.09.18.14.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:47:21 -0700 (PDT)
Message-ID: <fc6c5494b076a70354b5f45f4e108bb109a092df.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce RCU protection for
 KF_RCU_PROTECTED
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Andrea Righi <arighi@nvidia.com>, Alexei
 Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo	 <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 18 Sep 2025 14:47:18 -0700
In-Reply-To: <CAP01T77Nmwq1ZYpk2rJGLmOZezSBFOa0n8zyZn2gdj3UcE7XvA@mail.gmail.com>
References: <20250917032755.4068726-1-memxor@gmail.com>
	 <20250917032755.4068726-2-memxor@gmail.com>
	 <412f49fa12de7c7f5d0461b56fd4e0b6882fa0ad.camel@gmail.com>
	 <CAP01T77Nmwq1ZYpk2rJGLmOZezSBFOa0n8zyZn2gdj3UcE7XvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 23:37 +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, 18 Sept 2025 at 23:00, Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > On Wed, 2025-09-17 at 03:27 +0000, Kumar Kartikeya Dwivedi wrote:
> > > Currently, KF_RCU_PROTECTED only applies to iterator APIs and that to=
o
> > > in a convoluted fashion: the presence of this flag on the kfunc is us=
ed
> > > to set MEM_RCU in iterator type, and the lack of RCU protection resul=
ts
> > > in an error only later, once next() or destroy() methods are invoked =
on
> > > the iterator. While there is no bug, this is certainly a bit
> > > unintuitive, and makes the enforcement of the flag iterator specific.
> > >=20
> > > In the interest of making this flag useful for other upcoming kfuncs,
> > > e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfun=
c
> > > in an RCU critical section in general.
> > >=20
> > > This would also mean that iterator APIs using KF_RCU_PROTECTED will
> > > error out earlier, instead of throwing an error for lack of RCU CS
> > > protection when next() or destroy() methods are invoked.
> > >=20
> > > In addition to this, if the kfuncs tagged KF_RCU_PROTECTED return a
> > > pointer value, ensure that this pointer value is only usable in an RC=
U
> > > critical section. There might be edge cases where the return value is
> > > special and doesn't need to imply MEM_RCU semantics, but in general, =
the
> > > assumption should hold for the majority of kfuncs, and we can revisit
> > > things if necessary later.
> > >=20
> > >   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.=
loehle@arm.com
> > >   [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvid=
ia.com
> > >=20
> > > Tested-by: Andrea Righi <arighi@nvidia.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > [...]
> >=20
> > > @@ -14037,6 +14045,8 @@ static int check_kfunc_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn,
> > >=20
> > >                       if (meta.func_id =3D=3D special_kfunc_list[KF_b=
pf_get_kmem_cache])
> > >                               regs[BPF_REG_0].type |=3D PTR_UNTRUSTED=
;
> > > +                     else if (is_kfunc_rcu_protected(&meta))
> > > +                             regs[BPF_REG_0].type |=3D MEM_RCU;
> > >=20
> > >                       if (is_iter_next_kfunc(&meta)) {
> > >                               struct bpf_reg_state *cur_iter;
> >=20
> > The code below this hunk looks as follows:
> >=20
> >                         if (is_iter_next_kfunc(&meta)) {
> >                                 struct bpf_reg_state *cur_iter;
> >=20
> >                                 cur_iter =3D get_iter_from_state(env->c=
ur_state, &meta);
> >=20
> >                                 if (cur_iter->type & MEM_RCU) /* KF_RCU=
_PROTECTED */
> >                                         regs[BPF_REG_0].type |=3D MEM_R=
CU;
> >                                 else
> >                                         regs[BPF_REG_0].type |=3D PTR_T=
RUSTED;
> >                         }
> >=20
> > Do we want to reduce it to:
> >=20
> >                         if (meta.func_id =3D=3D special_kfunc_list[KF_b=
pf_get_kmem_cache])
> >                                 regs[BPF_REG_0].type |=3D PTR_UNTRUSTED=
;
> >                         else if (is_kfunc_rcu_protected(&meta))
> >                                 regs[BPF_REG_0].type |=3D MEM_RCU;
> >                         else if (is_iter_next_kfunc(&meta))
> >                                 regs[BPF_REG_0].type |=3D PTR_TRUSTED;
>=20
> I thought so too but we cannot do this. Suppose that the RCU read lock
> is dropped and reacquired between new() and next(). Right now, we rely
> on MEM_RCU in iter->type stack object that gets invalidated properly.
> With such a change we'd lose the ability to track continued protection
> using RCU while the iterator is alive on the stack, and continue to
> mark returned pointers as MEM_RCU.

The change I suggest does not invalidate this mechanics.
The iterator is still marked with MEM_RCU and this mark is converted
to PTR_UNTRUSTED when RCU section exits.
The check for PTR_UNTRUSTED happens in process_iter_arg() called
from check_kfunc_args().

>=20
> >=20
> > And mark relevant iterator next (and destroy?) functions as KF_RCU_PROT=
ECTED?
> > (bpf_iter_css_next, bpf_iter_task_next, bpf_iter_scx_dsq_next).
> >=20
> > I ask, because setting |=3D MEM_RCU in two places of this if branch
> > looks a bit iffy.
> >=20
> > [...]

