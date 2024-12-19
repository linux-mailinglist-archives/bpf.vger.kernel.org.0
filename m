Return-Path: <bpf+bounces-47345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B75459F837F
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 19:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA25188AEE6
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD481A3A94;
	Thu, 19 Dec 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjrNiPb/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EEE35948;
	Thu, 19 Dec 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633809; cv=none; b=RxDZmGtTediU2p6IEV51w+sN2narbW3F6xF5R53gs1qXxp6cUkeYyhT6sijPK72HH5u9MVxY01WW61kJkgyI2oASRnFIRnnIgPwKNt1OLraK+cmdCL7zj53vnPWdyK6WVWZRO1nn++FP8FmDtQ0risAXaklhUEcWjopIFzC7dSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633809; c=relaxed/simple;
	bh=lHTFtaNNPatnUk8CXSIOSIa8vLjlwn5AnbQv0NjHSbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBIzxVUjhv8EnWq+q0dwIQwqy7wc9z86VP1t46JNJhdFQvus/I7iVblNvyAbt1sVEWQx948LuxDBdgVw2EUjOVQUq6maZEiotYSVv5B879Uc08qV2V5ONjelHA4FfnCKqX5BTQzUrRxJWD31x+8DadARFnOPv1H7EH5MaLg6U5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjrNiPb/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso8479865e9.1;
        Thu, 19 Dec 2024 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734633806; x=1735238606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cs1m9CvWqyvi6yQ4/SQ5yqgxwkjQiptUazVPaSJ5dk=;
        b=KjrNiPb/3QLUIR/qaaiFuCdZVgTdPTNInZnOLsGL5iYb9YwTumnO4wtRlo43UV6hcM
         9w+oWT2NZKBj3Q4Ewuqc2S8VceKXZZH4WqUs5x0r/LjL41L0mLIvS4XxI6Tb07P1pfiv
         GCXQple7sZ/Z7pAvKcmA+Jf85JrPcs2O01arDMZAFY0bcBHLOEtltR+Hd54YXorDkoMA
         WsVdfKzCxRGGXHbywCZkuNTsxiZHUdSKdkvNTc0HEtP25cWkEIId4Fo10sX+CcDb3iG3
         zeYeQboFOpuqUt+S8c5b/uogQvhs9h3kGduBohjYFqlfl/JcXq7fxWSGK63X88xbFMKC
         u+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734633806; x=1735238606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Cs1m9CvWqyvi6yQ4/SQ5yqgxwkjQiptUazVPaSJ5dk=;
        b=q2TlIx444K7VOF9zCAZffnEVW2qHWKhWeR9t58t3EjspeULiMOh+VRjdIvNMdPEn3/
         Vu50RGTkua6CoCxnm9lFjA/63ea89F9igoiJiR9pkZmB3KqHPqvGO1PuN4ykc2S/ptOv
         Y35dwSRXL4eQpR+cCyUmpZVHUG3AUHimFJU3w+BzzywUXEGkwfd36a0RlamblC7cRS4W
         bkae7q/E9i9OBBRee9Hy07a7qC/47/uZl2Y3LoM/WtuUO+LS2FX1zjekkzcWNMBLdAyJ
         kCKpRxaeYLgQLnrkyI3qd19OKPF9GQoPoVAelUNjWyBOFaU2ipIL/DhkyG5IXebLX973
         ff6g==
X-Forwarded-Encrypted: i=1; AJvYcCWJc384TCwScNbTF4uFgsu9aPQBp8m2gxPRYKGlFtrfy/J57DFMSDJ5lA+2GglqLiV+wk/QAwvGztHFrYrX@vger.kernel.org, AJvYcCWm5XcL0nAfZjtR+dhZpn0iiz3QninEefqB2XZ6squM+le2M4oBlmPQHQe0wcdVzbwRvks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8de2qdc1qfgQIe3B/zcvCYCPc1YK/K3JOfj0sr1CisxnVHIE
	PYzvgZdkKnNZUWDTH/3lpebPzJ2zUtXOiBND+R6K5bJc2whCLkJfxMXWmLZemhnWo1LG15kRWW2
	sRYdQF+QKtmC28bB2SU8fTvnL2Xs=
X-Gm-Gg: ASbGnctSsmCFtBo9AMJM94lW9OnXQFE3h3GrcOZaSAKWpzSpPBVrhxRKtWl9MJTB5R5
	icaEI2TftRHgvaG/n3Qg+QJdLwF4mmEo5esDhxbsb
X-Google-Smtp-Source: AGHT+IFLBSKmQtMLvAI8EiYs43gbjhD/hV/2cwTFj+rana8iMK8LMUahumnot6Dmi+7boiFCuZRlqZsyoFxWtKaTJwU=
X-Received: by 2002:a05:600c:4f8a:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-43666466558mr3213495e9.12.1734633805776; Thu, 19 Dec 2024
 10:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218092149.42339-1-wuyun.abel@bytedance.com>
 <eb9d4609-970e-4760-af94-8e48cca7ec23@linux.dev> <9c53734d-9185-46b7-b07d-bf24ac06e688@bytedance.com>
 <8ae5a9ec-33b1-4228-bde1-f155fd639c84@linux.dev>
In-Reply-To: <8ae5a9ec-33b1-4228-bde1-f155fd639c84@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Dec 2024 10:43:13 -0800
Message-ID: <CAADnVQ+pYevQ9QsRB-oLu1ONtzZ31J=3ANqB+aFLLiU4VcGgNA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix deadlock when freeing cgroup storage
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Abel Wu <wuyun.abel@bytedance.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Vernet <void@manifault.com>, 
	"open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 10:39=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
>
> On 12/19/24 4:38 AM, Abel Wu wrote:
> > Hi Yonghong,
> >
> > On 12/19/24 10:45 AM, Yonghong Song Wrote:
> >>
> >>
> >>
> >> On 12/18/24 1:21 AM, Abel Wu wrote:
> >>> The following commit
> >>> bc235cdb423a ("bpf: Prevent deadlock from recursive
> >>> bpf_task_storage_[get|delete]")
> >>> first introduced deadlock prevention for fentry/fexit programs
> >>> attaching
> >>> on bpf_task_storage helpers. That commit also employed the logic in m=
ap
> >>> free path in its v6 version.
> >>>
> >>> Later bpf_cgrp_storage was first introduced in
> >>> c4bcfb38a95e ("bpf: Implement cgroup storage available to
> >>> non-cgroup-attached bpf progs")
> >>> which faces the same issue as bpf_task_storage, instead of its busy
> >>> counter, NULL was passed to bpf_local_storage_map_free() which opened
> >>> a window to cause deadlock:
> >>>
> >>>     <TASK>
> >>>     _raw_spin_lock_irqsave+0x3d/0x50
> >>>     bpf_local_storage_update+0xd1/0x460
> >>>     bpf_cgrp_storage_get+0x109/0x130
> >>>     bpf_prog_72026450ec387477_cgrp_ptr+0x38/0x5e
> >>>     bpf_trace_run1+0x84/0x100
> >>>     cgroup_storage_ptr+0x4c/0x60
> >>>     bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
> >>>     bpf_selem_unlink_storage+0x6f/0x110
> >>>     bpf_local_storage_map_free+0xa2/0x110
> >>>     bpf_map_free_deferred+0x5b/0x90
> >>>     process_one_work+0x17c/0x390
> >>>     worker_thread+0x251/0x360
> >>>     kthread+0xd2/0x100
> >>>     ret_from_fork+0x34/0x50
> >>>     ret_from_fork_asm+0x1a/0x30
> >>>     </TASK>
> >>>
> >>>     [ Since the verifier treats 'void *' as scalar which
> >>>       prevents me from getting a pointer to 'struct cgroup *',
> >>>       I added a raw tracepoint in cgroup_storage_ptr() to
> >>>       help reproducing this issue. ]
> >>>
> >>> Although it is tricky to reproduce, the risk of deadlock exists and
> >>> worthy of a fix, by passing its busy counter to the free procedure so
> >>> it can be properly incremented before storage/smap locking.
> >>
> >> The above stack trace and explanation does not show that we will have
> >> a potential dead lock here. You mentioned that it is tricky to
> >> reproduce,
> >> does it mean that you have done some analysis or coding to reproduce i=
t?
> >> Could you share the details on why you think we may have deadlock here=
?
> >
> > The stack is A-A deadlocked: cgroup_storage_ptr() is called with
> > storage->lock held, while the bpf_prog attaching on this function
> > also tries to acquire the same lock by calling bpf_cgrp_storage_get()
> > thus leading to a AA deadlock.
> >
> > The tricky part is, instead of attaching on cgroup_storage_ptr()
> > directly, I added a tracepoint inside it to hook:
> >
> > ------
> > diff --git a/kernel/bpf/bpf_cgrp_storage.c
> > b/kernel/bpf/bpf_cgrp_storage.c
> > index 20f05de92e9c..679209d4f88f 100644
> > --- a/kernel/bpf/bpf_cgrp_storage.c
> > +++ b/kernel/bpf/bpf_cgrp_storage.c
> > @@ -40,6 +40,8 @@ static struct bpf_local_storage __rcu
> > **cgroup_storage_ptr(void *owner)
> >  {
> >         struct cgroup *cg =3D owner;
> >
> > +       trace_cgroup_ptr(cg);
> > +
> >         return &cg->bpf_cgrp_storage;
> >  }
> >
> > ------
> >
> > The reason doing so is that typecasting from 'void *owner' to
> > 'struct cgroup *' will be rejected by the verifier. But there
> > could be other ways to obtain a pointer to the @owner cgroup
> > too, making the deadlock possible.
>
> I checked the callstack and what you described indeed the case.
> In function bpf_selem_unlink_storage(), local_storage->lock is
> held before calling bpf_selem_unlink_storage_nolock/cgroup_storage_ptr.
> If there is a fentry/tracepoint on the cgroup_storage_ptr and then we cou=
ld
> have a deadlock as you described in the above.
>
> As you mentioned, it is tricky to reproduce. fentry on cgroup_storage_ptr
> does not work due to func signature:
>    struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
> Even say we support 'void *' for fentry and we do bpf_rdonly_cast()
> to cast 'void *owner' to 'struct cgroup *owner', and owner cannot be
> passed to helper/kfunc.
>
> Your fix looks good but it would be great to have a reproducer.
> One possibility is to find a function which can be fentried within
> local_storage->lock. If you know the cgroup id, in bpf program you
> can use bpf_cgroup_from_id() to get a trusted cgroup ptr from the id.
> and then you can use that cgroup ptr to do bpf_cgrp_storage_get() etc.
> which should be able to triger deadlock. Could you give a try?

I'd rather mark a set of functions as notrace to avoid this situation
or add:
CFLAGS_REMOVE_bpf_cgrp_storage.o =3D $(CC_FLAGS_FTRACE)

