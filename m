Return-Path: <bpf+bounces-73764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E91C38B8A
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990D91A23629
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324C22E3E9;
	Thu,  6 Nov 2025 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v882wvdl"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C7221FC6
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393243; cv=none; b=Fj8mlWcSZYJoRpZtr2kXvgKlDKGZSPdkxOKxcckaxYpnyA8BKHtuoYE/nz6hI8CNpdnHFsGZFBuWqTzWzJsUQjx0v3BJTIfBqaJ4K0aEVVRB6M1JLzPXPPC+PsLkKOKBOubec8JEPFDntBycdpNRiDR+EGgnCxtHNYAB2DQIImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393243; c=relaxed/simple;
	bh=8b+UCgStWllzqynScECGPtzxKYbbSqfZQ01uvObfyrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZnBiizr1Neim4GTVtZSlGwnn26ZO0EwAIFh1K/YM5V9IqZWLmlVDaXGJDJKCzF+2dX6LHQrgTY5Bc1NGRTFMKzv5T1KksC5Yw3kKDo26h+XAa7g7z9Vw/MxCjDH2miLQjB+P2ueR3QPLiXGroQ3VdzQV3VSRcYCX7BLFaF8YhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v882wvdl; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762393228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npw2S3cvAdwFUuQPq4ZcThlfeG5y4r/hL2rPLz9b8+4=;
	b=v882wvdlMaCVqDaZo+M5SfeeApykJWjCwO5HrMGcak0Qfqowf7ww+1efAU5o5Wu9WtgSeT
	qLu1QYJXV7AznarJtH8xl8Yi9sRmg1Zl9wqCF51xGV6p+1hSkjtbCtkflSsAHYp+9glKkB
	cvTxI7GGAIm16gnhsnfI2ynxZri+Dzc=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Date: Thu, 06 Nov 2025 09:40:15 +0800
Message-ID: <5053516.31r3eYUQgx@7950hx>
In-Reply-To:
 <CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com>
References:
 <20251104104913.689439-1-dongml2@chinatelecom.cn> <1986305.taCxCBeP46@7950hx>
 <CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/6 07:31, Alexei Starovoitov wrote:
> On Tue, Nov 4, 2025 at 11:47=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2025/11/5 15:13, Menglong Dong wrote:
> > > On 2025/11/5 10:12, Alexei Starovoitov wrote:
> > > > On Tue, Nov 4, 2025 at 5:30=E2=80=AFPM Menglong Dong <menglong.dong=
@linux.dev> wrote:
> > > > >
> > > > > On 2025/11/5 02:56, Alexei Starovoitov wrote:
> > > > > > On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <menglong8=
=2Edong@gmail.com> wrote:
> > > > > > >
> > > > > > > In origin call case, we skip the "rip" directly before we ret=
urn, which
> > > > > > > break the RSB, as we have twice "call", but only once "ret".
> > > > > >
> > > > > > RSB meaning return stack buffer?
> > > > > >
> > > > > > and by "breaks RSB" you mean it makes the cpu less efficient?
> > > > >
> > > > > Yeah, I mean it makes the cpu less efficient. The RSB is used
> > > > > for the branch predicting, and it will push the "rip" to its hard=
ware
> > > > > stack on "call", and pop it from the stack on "ret". In the origin
> > > > > call case, there are twice "call" but once "ret", will break its
> > > > > balance.
> > > >
> > > > Yes. I'm aware, but your "mov [rbp + 8], rax" screws it up as well,
> > > > since RSB has to be updated/invalidated by this store.
> > > > The behavior depends on the microarchitecture, of course.
> > > > I think:
> > > > add rsp, 8
> > > > ret
> > > > will only screw up the return prediction, but won't invalidate RSB.
> > > >
> > > > > Similar things happen in "return_to_handler" in ftrace_64.S,
> > > > > which has once "call", but twice "ret". And it pretend a "call"
> > > > > to make it balance.
> > > >
> > > > This makes more sense to me. Let's try that approach instead
> > > > of messing with the return address on stack?
> > >
> > > The way here is similar to the "return_to_handler". For the ftrace,
> > > the origin stack before the "ret" of the traced function is:
> > >
> > >     POS:
> > >     rip   ---> return_to_handler
> > >
> > > And the exit of the traced function will jump to return_to_handler.
> > > In return_to_handler, it will query the real "rip" of the traced func=
tion
> > > and the it call a internal function:
> > >
> > >     call .Ldo_rop
> > >
> > > And the stack now is:
> > >
> > >     POS:
> > >     rip   ----> the address after "call .Ldo_rop", which is a "int3"
> > >
> > > in the .Ldo_rop, it will modify the rip to the real rip to make
> > > it like this:
> > >
> > >     POS:
> > >     rip   ---> real rip
> > >
> > > And it return. Take the target function "foo" for example, the logic
> > > of it is:
> > >
> > >     call foo -> call ftrace_caller -> return ftrace_caller ->
> > >     return return_to_handler -> call Ldo_rop -> return foo
> > >
> > > As you can see, the call and return address for ".Ldo_rop" is
> > > also messed up. So I think it works here too. Compared with
> > > a messed "return address", a missed return maybe have
> > > better influence?
> > >
> > > And the whole logic for us is:
> > >
> > >     call foo -> call trampoline -> call origin ->
> > >     return origin -> return POS -> return foo
> >
> > The "return POS" will miss the RSB, but the later return
> > will hit it.
> >
> > The origin logic is:
> >
> >      call foo -> call trampoline -> call origin ->
> >      return origin -> return foo
> >
> > The "return foo" and all the later return will miss the RBS.
> >
> > Hmm......Not sure if I understand it correctly.
>=20
> Here another idea...
> hack tr->func.ftrace_managed =3D false temporarily
> and use BPF_MOD_JUMP in bpf_arch_text_poke()
> when installing trampoline with fexit progs.
> and also do:
> @@ -3437,10 +3437,6 @@ static int __arch_prepare_bpf_trampoline(struct
> bpf_tramp_image *im, void *rw_im
>=20
>         emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
>         EMIT1(0xC9); /* leave */
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> -               /* skip our return address and return to parent */
> -               EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
> -       }
>         emit_return(&prog, image + (prog - (u8 *)rw_image));
>=20
> Then RSB is perfectly matched without messing up the stack
> and/or extra calls.
> If it works and performance is good the next step is to
> teach ftrace to emit jmp or call in *_ftrace_direct()

Good idea. I saw the "return_to_handler" used "JMP_NOSPEC", and
the jmp is converted to the "fake call" to be nice to IBT in this commit:

e52fc2cf3f66 ("x86/ibt,ftrace: Make function-graph play nice")

It's not indirect branch in our case, but let me do more testing to
see if there are any unexpected effect if we use "jmp" here.

Thanks!
Menglong Dong

>=20





