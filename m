Return-Path: <bpf+bounces-41037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD380991355
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D64B220D6
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1BB155300;
	Fri,  4 Oct 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUh6INGL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615ED153838;
	Fri,  4 Oct 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086230; cv=none; b=c+BKw7LoJ7DCo4mcvcnGxcD63pXFgPihG6/j2YuVBWwUp0PNkH4jPwWo5xF74G7sd8a0NQFh0h9mvapu9IOvISLRvYjhu9rIVjs9AZ1KP6AliUjPEyQxwehC9o1qEtueLG4b4UhxagmVAZr0cj5ILo/3dS41QyYqqO9cEVXdiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086230; c=relaxed/simple;
	bh=4hUROC6DIqthBNdPrjAkuLOYME9aDS8/AsLjsPBVw98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2EKIh86R5DIFfxziw1OEfpVG6U5SS1Ee4fgyIE44sqXrbM5IRzygZWjN59V8QXwkYcFjduiXABbaix0AEXOiWW/i3p/vmliLs78rTOvLFCW2WPBGWC3Wag5BE3I7+gtsdU6HrNHIKrqM03121f/khNlToOr5fOPBLxcw/KlWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUh6INGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27976C4CED8;
	Fri,  4 Oct 2024 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728086230;
	bh=4hUROC6DIqthBNdPrjAkuLOYME9aDS8/AsLjsPBVw98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gUh6INGLLnvy7dBIymE9edcFKxmbRQqM8wMFskO2/RDmWX8yDEFNfcCjcNh6uh3nY
	 Zt4Rc066ej2w6ySG6CdkKFzEdGGLWqeCxtfIQQJCWdUDbSbZq010e9BJwHTVvaU770
	 b7BskwNywhXAgGuN8PQ5b3cO5FolUJd7/jCPoE0PZFwRjhmMkyiUJxJL8mtq5U4yUP
	 hovFXCfJTL2Y3mNxEqpDYdSCjTEQSatOk8LOP0gKnI6c9e+cmKr7nWfIaXFkomUgnp
	 hPhFd4pBxdAPo9oe9zRLpuzcdkicjAaSig1Koey5oTwsNscC3kMkG+GwVt6baEpYOB
	 HtkYlYbu+reDw==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a344f92143so11715355ab.2;
        Fri, 04 Oct 2024 16:57:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2FWXlC6gdH10uZyr5qFiuiBv+fLPrgRxQk5At9kqyjHQDy/7jv9aTuQVbqYcwHECwQkqcov8KIJ7Xqvv5@vger.kernel.org, AJvYcCXUCYNdqNIL6vep/wEKdjyQGDYABEjutkuHJPcX6j/5vfk26Z/nB96k8o3T1lFppyUFPXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+d5gB4Ha4g4KE2owTSK6vj/fd97QRrO5kXWzzlheb9XQodUxx
	dOdsN8HGWB5WB7heB6shm9qt56wNTTDp4U2t0+CpAdHM6BYF9jTy7wgrBoXFsIO4KVJc8kJBweK
	xQ2tjkmYKQd8MqRQLd86cD2yxxPY=
X-Google-Smtp-Source: AGHT+IFcsGHVrHHVnjJ64LBTXNmEoO3SYFvavCZqFJHGHWwaRA2sGiCLcet+688mt3P53rIGxuvTLw01D3IM/zCyNlw=
X-Received: by 2002:a05:6e02:1fcd:b0:39f:558a:e404 with SMTP id
 e9e14a558f8ab-3a3759780bemr46249655ab.4.1728086229441; Fri, 04 Oct 2024
 16:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com> <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
 <ZwBk8i23odCe7qVK@google.com> <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>
 <CAADnVQK0VQXvxqxm6WudyeLao1L+jMTvmUauciBc8_vcLcR=vQ@mail.gmail.com>
In-Reply-To: <CAADnVQK0VQXvxqxm6WudyeLao1L+jMTvmUauciBc8_vcLcR=vQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 16:56:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6gB5PaNDQ5x20oRXUtgf7KPNTQpN_WLvtYm=-7CLhn-g@mail.gmail.com>
Message-ID: <CAPhsuW6gB5PaNDQ5x20oRXUtgf7KPNTQpN_WLvtYm=-7CLhn-g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm <linux-mm@kvack.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> > diff --git i/kernel/bpf/helpers.c w/kernel/bpf/helpers.c
> > index 3709fb142881..7311a26ecb01 100644
> > --- i/kernel/bpf/helpers.c
> > +++ w/kernel/bpf/helpers.c
> > @@ -3090,7 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW=
)
> >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > -BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL | KF_TRUSTED_ARGS
> > | KF_RCU_PROTECTED)
>
> I don't think KF_TRUSTED_ARGS approach would fit here.
> Namhyung's use case is tracing. The 'addr' will be some potentially
> arbitrary address from somewhere. The chance to see a trusted pointer
> is probably very low in such a tracing use case.

I thought the primary use case was to trace lock contention, for
example, queued_spin_lock_slowpath(). Of course, a more
general solution is better.

>
> The verifier change can mainly be the following:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7d9b38ffd220..e09eb108e956 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12834,6 +12834,9 @@ static int check_kfunc_call(struct
> bpf_verifier_env *env, struct bpf_insn *insn,
>                         regs[BPF_REG_0].type =3D PTR_TO_BTF_ID;
>                         regs[BPF_REG_0].btf_id =3D ptr_type_id;
>
> +                       if (meta.func_id =3D=3D
> special_kfunc_list[KF_get_kmem_cache])
> +                               regs[BPF_REG_0].type |=3D PTR_UNTRUSTED;
> +
>                         if (is_iter_next_kfunc(&meta)) {
>                                 struct bpf_reg_state *cur_iter;

This is easier than I thought.

Thanks,
Song

> The returned 'struct kmem_cache *' won't be refcnt-ed (acquired).
> It will be readonly via ptr_to_btf_id logic.
> s->flags;
> s->size;
> s->offset;
> access will be allowed but the verifier will sanitize them
> with an inlined version of probe_read_kernel.
> Even KF_RET_NULL can be dropped.

