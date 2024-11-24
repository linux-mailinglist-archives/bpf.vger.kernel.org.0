Return-Path: <bpf+bounces-45518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276439D6CB3
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 06:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D438281583
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 05:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B1154444;
	Sun, 24 Nov 2024 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noqp2u9i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153AEAD0;
	Sun, 24 Nov 2024 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732426408; cv=none; b=H7VvU0OTzbHu5Fco865WtaKhmA6sBO/UKyFBJXO8QoLf6/jWU/u0B7lrN3C1znzXwTbpezZK8a5jShoYr4t5fwwbZHMSBadwLGCa5q1Ali3NCHvq+uWSENLOwjGlZjH3FhLDscJGoFdLC5NZMqyWrRmGgEuwfL+L1KImo7lBrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732426408; c=relaxed/simple;
	bh=SnJLsAztLM66kXlbc2WRGislA8b9y3o3WrkLh68XyPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsFzKAErgw3vsUdlZp8Dz3P5HtzBXDu8Pq6up6p2sCGmX6iqMkV5dZP1BOihyWQjNk4mA+cnFmGsICblvcnUr4T1sIUW0UFwJY/2KvplJTPec3YD5kcsZ0AspxsULpnoeWoZ/AzpxoryehR4i1nEB8d5ZLbos3GW+hRHPO3+X0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noqp2u9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA4DC4CED6;
	Sun, 24 Nov 2024 05:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732426408;
	bh=SnJLsAztLM66kXlbc2WRGislA8b9y3o3WrkLh68XyPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=noqp2u9iz0h5w1MH4ahHr4Y//93aDWCLGzUr5w7zRKiwlLRlDCk1+kiYUa1+fP3oP
	 5+0o2XqflFpIFum/WS1gBMdm4e+mPWRxgHk6ivOsA/Hv9XGSNu/h8pq8rnYDV14DTH
	 nv6wHbkqbj1b0sl7JZPB/cT0pfQhm9M9BupN6eYVma6xz0/5ELZMhXn7dOzuvzq9rW
	 5jxQlwm2Aanyp5dt4aruriCevfYZMS3KqRLxkkJsropchTxQAiVV0SMryExfkt+W39
	 itH3Ip37HFe0g2PO3xaYtlZZgKFVhte1/T7XWFD8Q92M3S085F7Tai8Ets2s2ACCoW
	 TfbKVBGYyuJjA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfd3a7e377so4520863a12.2;
        Sat, 23 Nov 2024 21:33:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7XzJWuRy7bFqNSuIKME3UO4Fu50G8q4gmJHdcYpYyBzrvW9GDcrPkz6Mgw7XQv+IN8TKMO8IxU0eueh6+@vger.kernel.org, AJvYcCX9JNp8hE+qK1nCjj5Gesl53jntzrLR5VX34SMXEa9za9CrygFuFHe5DpEDVoUXESOnPWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2w41xtPp3mb5xZZ58+FAZzG7XhQwlQqrYWwf0g6NMsCNqGEcI
	lFUAb8Jw6CdJl8IIqcoo5aQHtMqQ6FIfHFrzUIfoAhkJxa+6Bu90dxKlntcJeBtryVIJ8OMj94i
	gSoZuv/R+bcwjNUu8MgSoeyP0kmg=
X-Google-Smtp-Source: AGHT+IGFsDXhUvcgiamPXOXgC2+BiHJ3X4VHU0HBkvo39oIJvZZcacknU/rYHXzL0iJ53xOKrp1PMQ3ABpXAa3O+nAo=
X-Received: by 2002:a17:906:cc11:b0:a9a:a5c:e23b with SMTP id
 a640c23a62f3a-aa509e7bb6amr761146866b.58.1732426406981; Sat, 23 Nov 2024
 21:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119065230.19157-1-yangtiezhu@loongson.cn>
 <673fd322ce3ac_1118208b3@john.notmuch> <4f6c74e0-dd22-8460-96fa-f408291a3ef8@loongson.cn>
 <6741fb6c516cc_c6be20839@john.notmuch>
In-Reply-To: <6741fb6c516cc_c6be20839@john.notmuch>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 24 Nov 2024 13:33:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7rBeS1n8vR7nyzU7_buf+3JQNNWxiTw5Grx5Rh-eUzXA@mail.gmail.com>
Message-ID: <CAAhV-H7rBeS1n8vR7nyzU7_buf+3JQNNWxiTw5Grx5Rh-eUzXA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Sign-extend return values
To: John Fastabend <john.fastabend@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Sat, Nov 23, 2024 at 11:57=E2=80=AFPM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Tiezhu Yang wrote:
> > On 11/22/2024 08:41 AM, John Fastabend wrote:
> > > Tiezhu Yang wrote:
> > >> (1) Description of Problem:
> > >>
> > >> When testing BPF JIT with the latest compiler toolchains on LoongArc=
h,
> > >> there exist some strange failed test cases, dmesg shows something li=
ke
> > >> this:
> > >>
> > >>   # dmesg -t | grep FAIL | head -1
> > >>   ... ret -3 !=3D -3 (0xfffffffd !=3D 0xfffffffd)FAIL ...
> >
> > ...
> >
> > >>
> > >> (5) Final Solution:
> > >>
> > >> Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
> > >> outside BPF land). Because libbpf currently defines the return value
> > >> of an ebpf program as a 32-bit unsigned integer, just use addi.w to
> > >> extend bit 31 into bits 63 through 32 of a5 to a0. This is similar
> > >> with commit 2f1b0d3d7331 ("riscv, bpf: Sign-extend return values").
> > >>
> > >> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> > >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > >> ---
> > >>  arch/loongarch/net/bpf_jit.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_j=
it.c
> > >> index 7dbefd4ba210..dd350cba1252 100644
> > >> --- a/arch/loongarch/net/bpf_jit.c
> > >> +++ b/arch/loongarch/net/bpf_jit.c
> > >> @@ -179,7 +179,7 @@ static void __build_epilogue(struct jit_ctx *ctx=
, bool is_tail_call)
> > >>
> > >>    if (!is_tail_call) {
> > >>            /* Set return value */
> > >> -          move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> > >> +          emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0]=
, 0);
> > >
> > > Not overly familiar with this JIT but just to check this wont be used
> > > for BPF 2 BPF calls correct?
> >
> > I am not sure I understand your comment correctly, but with and without
> > this patch, the LoongArch JIT uses a5 as a dedicated register for BPF
> > return values, a5 is kept as zero-extended for bpf2bpf, just make a0
> > (which is used outside BPF land) as sign-extend, all of the test cases
> > in test_bpf.ko passed with "echo 1 > /proc/sys/net/core/bpf_jit_enable"=
.
> >
> > Thanks,
> > Tiezhu
> >
>
> Got it.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>

