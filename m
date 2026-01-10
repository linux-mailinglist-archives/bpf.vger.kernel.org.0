Return-Path: <bpf+bounces-78445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9722D0CE05
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 04:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 309083012EA4
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADE257821;
	Sat, 10 Jan 2026 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPPsMkkU"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F32135B8
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768016469; cv=none; b=beiqrz+ZHEYiSIo8A+7t6MldlZhqa8/UBimlqtGCg0iLgSB/x46KWJbJCdNLo/4/dhIM6lNTo/r7TpUytgBlK+v2VI+cFSpGhjq/nE1d3pEdqIR/6kLziSPSTzv8nvLSL5b2932HdyRIUUz9gAam1tOOoK0IlcFKdWCLmAI0nOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768016469; c=relaxed/simple;
	bh=JVxVb23sXUov+716rIr+xlZVWmJ/DHEGP/0PemsgZ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RADjVY/4s7RLoRcuycEcW7/t2sJlAFRb00Akgq+qlNme6F+5kZ61cFquIn+ZlL6LUanDRWxvw8jOBO/0ZBPC9zibuBby4d+UL39q1LqIwbVVPTGj0lxJPBWPPDUq3G0xz9srzi4kJVYTJTAZOrdDNlEZujBr7g9/yoCIBzaktSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPPsMkkU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768016456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=az6dRvvu+knJTaqIBy2vbsedGP1eSuAz0pkWOXUEOs8=;
	b=qPPsMkkULTYPYrJrq3ipPK35kpAaUhDPHV5nP2nlH0uY8oAZq8F9siZ84dEMzSrMIjbCw0
	gVNnE9fxTa2Tv6UicZt7vjI3Z3ktVb7p5Oyfy3NzuIi5HWyISHiZfJLtPoCqRqvqaJwAIs
	q/plvplOVh7xVJgIgs33N2HnPnEVFks=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v8 06/11] bpf,x86: introduce emit_st_r0_imm64() for
 trampoline
Date: Sat, 10 Jan 2026 11:40:29 +0800
Message-ID: <1950001.tdWV9SEqCh@7950hx>
In-Reply-To:
 <CAADnVQKUZsEvv64Y-U-hzCY-wc1iTfXTjhFhqG6Nq4fDsu_HsQ@mail.gmail.com>
References:
 <20260108022450.88086-1-dongml2@chinatelecom.cn>
 <20260108022450.88086-7-dongml2@chinatelecom.cn>
 <CAADnVQKUZsEvv64Y-U-hzCY-wc1iTfXTjhFhqG6Nq4fDsu_HsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/10 10:45, Alexei Starovoitov wrote:
> On Wed, Jan 7, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > Introduce the helper emit_st_r0_imm64(), which is used to store a imm64=
 to
> > the stack with the help of r0.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index e3b1c4b1d550..a87304161d45 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u3=
2 dst_reg, int off, int imm)
> >         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
> >  }
> >
> > +static void emit_st_r0_imm64(u8 **pprog, u64 value, int off)
> > +{
> > +       /* mov rax, value
> > +        * mov QWORD PTR [rbp - off], rax
> > +        */
> > +       emit_mov_imm64(pprog, BPF_REG_0, value >> 32, (u32) value);
> > +       emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -off);
> > +}
>=20
> The name is cryptic.
> How about emit_store_stack_imm64(pprog, stack_off, imm64) ?
> or emit_mov_stack_imm64.

emit_store_stack_imm64() sounds fine. I'll use it in the next version.

Thanks!
Menglong Dong

>=20
>=20





