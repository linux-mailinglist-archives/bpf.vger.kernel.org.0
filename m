Return-Path: <bpf+bounces-65975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D1CB2BC95
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E012165488
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6430F812;
	Tue, 19 Aug 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwE9hyLx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997E1DEFD2
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594400; cv=none; b=tUZ8euJKV6C87GeCbqslbw8HTzel7tylaUJRax46tm006RuDunslne58z+xESelTrKzYbhRHUjZytbWFmrbJBfUmjrNCfBBzyIyXt9XXgIpEEUQoXVnRg5ETihAy+car/P+Slob1hatTECC9RiCh1ZgeOASPoqei45dbCL6kCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594400; c=relaxed/simple;
	bh=cz/9GTvBj9WEIjBElq6Usz4t/NABHId3D4ykDBBeQ6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTfKcoceAlyi60K7pQgOCWBnchFvbQHtcZh26Jcm2qM4g+HQwf9zOyuhuln1LB0hkanITgMvwt3oSpD3qU6k+gvf8NyC0hHrzIrdQvM4F31rIo1UkBoE1rXkSyUVJoVS1jo2+EaE+2a8gXjzX+/XcQv+Vv4zpSPgKSpbPt3FNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwE9hyLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C36C16AAE
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594397;
	bh=cz/9GTvBj9WEIjBElq6Usz4t/NABHId3D4ykDBBeQ6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SwE9hyLx8drPWr9YoV+jp3O4p6XXVGnHV1cC1rRFiOkGYimsoAeiSWRl2Y9kmWpOH
	 MSxDFDrnLlZN4B1o9BEo/9PMkflQdfNr4PtSdyu0cTDYvxD0tsTQEwjxr4AwL2H5oF
	 rfxFoPS9RqoqzmEWCBx7rSaib33XsnWY+WOfNsqSK0oCHN9F80+AGdjc/1DuKcKt2b
	 MsDRvK1PRKwKjIY1jNH3QHOgpIIoCndtP+JvvcRj4BFw7JFlhRGjYxtzjFbYzvdhYD
	 V+gwQK8VmucU2bfdGGQGWGOUIFUxlWLZj3He3piN2ZMB+FvKGdJfWPO2E7WeoQFrsh
	 5qpTeAVMI3EcQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-619ff42ad8eso3596639a12.3
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 02:06:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWG5UoY3R0SHARd1qRnzhltvjQa4nk3h4c6t52Gt/Me9je/YI3BRqVPMM/sbLc9aQwFGy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2msPGXREFwYPHlxDQE97Gmg6gRFskvYHhs0Ja3a8+JUT/g+9
	f4JlSp3zNAvSwTbaBMAbmBWNWlJbBNG/uXuxTvO6/IxBV6WXAXdmP4nruRHgYkP50iYhI6PjNKx
	CZ3mIX+6scp8D5l5QfPyii83/M4w3rzQ=
X-Google-Smtp-Source: AGHT+IHPDH4CM8c9ghdnY52oeNouL5sXBeIBZiZUfseAy4pTcxWshWDGcVyrWRU1hXUV/P243y1lYxcF4jDTGz88988=
X-Received: by 2002:a05:6402:42c3:b0:618:161c:6bf with SMTP id
 4fb4d7f45d1cf-61a7e72ffa1mr1445241a12.19.1755594396037; Tue, 19 Aug 2025
 02:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815082931.875216-1-jianghaoran@kylinos.cn> <720482db-17de-4831-b64a-0ae3fd7fa5a5@iogearbox.net>
In-Reply-To: <720482db-17de-4831-b64a-0ae3fd7fa5a5@iogearbox.net>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 19 Aug 2025 17:06:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5GxL159jSD1V6G7JZVXasESVFr02Jj=h+mYUU2374N6g@mail.gmail.com>
X-Gm-Features: Ac12FXwSpVqveFcgoJVDNQJOBGpUpjERIlW5CiAQGrP9HxYCEErpcoLyEQ7FORk
Message-ID: <CAAhV-H5GxL159jSD1V6G7JZVXasESVFr02Jj=h+mYUU2374N6g@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: BPF: Fix incorrect return pointer value in
 the eBPF program
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Haoran Jiang <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	kernel@xen0n.name, hengqi.chen@gmail.com, yangtiezhu@loongson.cn, 
	jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, ast@kernel.org, 
	Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:24=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/15/25 10:29 AM, Haoran Jiang wrote:
> > In some eBPF programs, the return value is a pointer.
> > When the kernel call an eBPF program (such as struct_ops),
> > it expects a 64-bit address to be returned, but instead a 32-bit value.
> >
> > Before applying this patch:
> > ./test_progs -a ns_bpf_qdisc
> > CPU 7 Unable to handle kernel paging request at virtual
> > address 0000000010440158.
> >
> > As shown in the following test case,
> > bpf_fifo_dequeue return value is a pointer.
> > progs/bpf_qdisc_fifo.c
> >
> > SEC("struct_ops/bpf_fifo_dequeue")
> > struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
> > {
> >       struct sk_buff *skb =3D NULL;
> >       ........
> >       skb =3D bpf_kptr_xchg(&skbn->skb, skb);
> >       ........
> >       return skb;
> > }
> >
> > kernel call bpf_fifo_dequeue=EF=BC=9A
> > net/sched/sch_generic.c
> >
> > static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
> >                                  int *packets)
> > {
> >       struct sk_buff *skb =3D NULL;
> >       ........
> >       skb =3D q->dequeue(q);
> >       .........
> > }
> > When accessing the skb, an address exception error will occur.
> > because the value returned by q->dequeue at this point is a 32-bit
> > address rather than a 64-bit address.
> >
> > After applying the patch=EF=BC=9A
> > ./test_progs -a ns_bpf_qdisc
> > Warning: sch_htb: quantum of class 10001 is small. Consider r2q change.
> > 213/1   ns_bpf_qdisc/fifo:OK
> > 213/2   ns_bpf_qdisc/fq:OK
> > 213/3   ns_bpf_qdisc/attach to mq:OK
> > 213/4   ns_bpf_qdisc/attach to non root:OK
> > 213/5   ns_bpf_qdisc/incompl_ops:OK
> > 213     ns_bpf_qdisc:OK
> > Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> > Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> > Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
>
> Huacai, are you routing the fix or want us to route via bpf tree?
I will take it, but I'm waiting Tiezhu's Ack now.

Huacai

>
> Thanks,
> Daniel

