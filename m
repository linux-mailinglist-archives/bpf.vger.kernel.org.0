Return-Path: <bpf+bounces-74059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF998C4658C
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2AB3BC434
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8230BBA5;
	Mon, 10 Nov 2025 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/swysKd"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59759309DC0
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775050; cv=none; b=S+wj63WFNLjFgeqTrdWi/2cGDk3gIUUTeO/FSf78iQ1Vqe35MBpT9MDmGHImqBq8sIEv8Hgg3pUTytwczpjp8HVj2L2oJgIP7SuWQF6EtkDK2hHr5y/hvDAAwFZ/80A8eH/ikISJ+EyrBvXY19YUCJt8p/qLnTduxb9w1ucoMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775050; c=relaxed/simple;
	bh=xWfcsybnbo7UjFAaPYX+npyNBSLMNc5Bg/Ml39RrJtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWY4GV7UXITdP2kMKzyCp41EeSTZZ+El7f9CqY1XxAYnHkJCblDnpWcerOsW9VA9N4s8agJfZAOoTQNss7vG+bc8i1Lj/9KhtopJHNgljsEhq3J8veD/CdigLnNWvClPJE0gFrX7sxRbbNQcn3WNbX2bVAcEc1Gt+Tr/Z6HAarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/swysKd; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762775035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuKsG4Jk61M2ECo6srctORcvKOJg3Vp/W9Bx6gZdzsw=;
	b=O/swysKdnBbI+CzTc4MgeSho7tQxhhih+Bnzb3qlm57yqOlYt80LoNh7cdzFFCnsjkQ2by
	U6zkqyoNtv09Yrnqmfrvq88322QRUEioNlub040+8SaZTr9XLjXr3v6t6l3t1cqmhjlG+3
	JPgKTWPiLjmehL/U5Tn4vC2nkiIS0I8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, sjenning@redhat.com
Cc: Peter Zijlstra <peterz@infradead.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Date: Mon, 10 Nov 2025 19:43:25 +0800
Message-ID: <13884259.uLZWGnKmhe@7950hx>
In-Reply-To:
 <CAADnVQ+tUO_BJV8w1aPLiY50p7F+uk0GCWFgH0k5zLQBqAif1g@mail.gmail.com>
References:
 <20251104104913.689439-1-dongml2@chinatelecom.cn> <2388519.ElGaqSPkdT@7950hx>
 <CAADnVQ+tUO_BJV8w1aPLiY50p7F+uk0GCWFgH0k5zLQBqAif1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/6 10:56, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 6:49=E2=80=AFPM Menglong Dong <menglong.dong@linux=
=2Edev> wrote:
> >
> > On 2025/11/6 09:40, Menglong Dong wrote:
> > > On 2025/11/6 07:31, Alexei Starovoitov wrote:
> > > > On Tue, Nov 4, 2025 at 11:47=E2=80=AFPM Menglong Dong <menglong.don=
g@linux.dev> wrote:
[......]
> > > >
> > > > Here another idea...
> > > > hack tr->func.ftrace_managed =3D false temporarily
> > > > and use BPF_MOD_JUMP in bpf_arch_text_poke()
> > > > when installing trampoline with fexit progs.
> > > > and also do:
> > > > @@ -3437,10 +3437,6 @@ static int __arch_prepare_bpf_trampoline(str=
uct
> > > > bpf_tramp_image *im, void *rw_im
> > > >
> > > >         emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
> > > >         EMIT1(0xC9); /* leave */
> > > > -       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > > > -               /* skip our return address and return to parent */
> > > > -               EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
> > > > -       }
> > > >         emit_return(&prog, image + (prog - (u8 *)rw_image));
> > > >
> > > > Then RSB is perfectly matched without messing up the stack
> > > > and/or extra calls.
> > > > If it works and performance is good the next step is to
> > > > teach ftrace to emit jmp or call in *_ftrace_direct()
> >
> > After the modification, the performance of fexit increase from
> > 76M/s to 137M/s, awesome!
>=20
> Nice! much better than double 'ret' :)
> _ftrace_direct() next?

Hi, all

Do you think if it is worth to implement the livepatch with
bpf trampoline by introduce the CONFIG_LIVEPATCH_BPF?
It's easy to achieve it, I have a POC for it, and the performance
of the livepatch increase from 99M/s to 200M/s according to
my bench testing.

The results above is tested with return-trunk disabled. With the
return-trunk enabled, the performance decrease from 58M/s to
52M/s. The main performance improvement comes from the RSB,
and the return-trunk will always break the RSB, which makes it has
no improvement. The calling to per-cpu-ref get and put make
the bpf trampoline based livepatch has a worse performance
than ftrace based.

Thanks!
Menglong Dong

>=20





