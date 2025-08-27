Return-Path: <bpf+bounces-66642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1D8B37FB1
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DC216C21C
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A834A301;
	Wed, 27 Aug 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5hdkaV6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA42D2485;
	Wed, 27 Aug 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289909; cv=none; b=rW24C60RHgUWo7lJsQNroKL23VvMH0QFVMZlyxdq1OgPN7+EBBM4lgiQVntt6kOOKIMq7hbLoiy7tl/w30XIB2/axhEKET75NRA+t7prrV9Q2FF+RZ3bLJ1w/kmRyMp+uWSfEamjWDnlrsU4iOfrb1LePOJmortTRp1+qCBmEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289909; c=relaxed/simple;
	bh=6FzlqskmpU4mqgsOXMFz/wgzjeVlAW4PBLT2lq24aV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlV4BYkxeFcTpByc1jTxRzC1yLAOY0xvRv83n2lCo0vEU+GrzsX31tZCZ6x+TWRQOXZG1sEBNwG98i8ITmudRTpTaRbNk9EmxDkf5F4V1T+OZpoZGRxI9MB4C1xZuxDum9zOSockFy5XaazeUAsSy2LrQECse7IDonGvGW6Uu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5hdkaV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B5AC4AF09;
	Wed, 27 Aug 2025 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756289909;
	bh=6FzlqskmpU4mqgsOXMFz/wgzjeVlAW4PBLT2lq24aV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M5hdkaV6NdbcRgLMTdZNGtKkBXlDzUaESLeMZ3UhOp2Lu/Eb0eDmH9DxvQDERmD8d
	 dtg061BoVzk20FeEZOnpFcC8GsXs9FG0Ypc97u7EKCQYyqQpg89MG3RInCZUAgZ6Tl
	 4QS+GTYWtFzE0laGDd2Vc0aoU8JL1sbVRu2ynic6fYmCGgJM+S0wMvGxWhA5SBQoTI
	 DJv0i0ugeEtFH7IMPF0nQzozL1UiUPYta68OfIq1TKnmI5OiosllEU7wDkz52/norF
	 SmKPFOQmjlZw7SdJGmn2ocSfchl0m2Sxfv/3PTI4SFSPkI+9rkApLntyGCWYPnQ+IY
	 NqGcgP6jKuerg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cb9f6dbe7so641815a12.0;
        Wed, 27 Aug 2025 03:18:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2akWTwVVsaNFbLMQwUQ7oGJ8TynEDACjgDd7lp1edNTOqkJy6n+/LOm0A561qTEzWdyHwUBA02Yk67kUt@vger.kernel.org, AJvYcCXPlqOzM+DvvtivQmledf0dVqcABqJ6lhmfP/wgYekIajN9cERIgyIio6cE+WyG5IlBEjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3GsTBYzCYLovO80ErHAvViMklo7xfW3EFTB/7lfbCFUKxSU/
	N1SJPPKLNGPaMRm+HjE+9b8/1K1HIPnl4dP6v+N8I3EbvL3vfkWIZ0yAQ30qbi7La/BRM0WqcvP
	NNRj3/1rNUcs6ZFzLMy+p5Al8BzdD/8g=
X-Google-Smtp-Source: AGHT+IFDaHJmXdP3CC1Di8LlIhQV097JtkfPqlF8wrrAryeIiXdqAtfMWhdoQiulQi8pOLJWyHP8mPXfB1Tn/2IkwCk=
X-Received: by 2002:a05:6402:2792:b0:61c:bfa7:5d0 with SMTP id
 4fb4d7f45d1cf-61cbfa706c9mr119825a12.30.1756289908044; Wed, 27 Aug 2025
 03:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826064906.10683-1-yangtiezhu@loongson.cn> <CAEyhmHQJcCvy2TPv7nwT87yS6y698WrECwd+xA9RjsCVmrVXvw@mail.gmail.com>
In-Reply-To: <CAEyhmHQJcCvy2TPv7nwT87yS6y698WrECwd+xA9RjsCVmrVXvw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 27 Aug 2025 18:18:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5SCuXERUBbC5D+k1pjf-Pmf33LOQXL=aUP-E-DgO6+qg@mail.gmail.com>
X-Gm-Features: Ac12FXw1WWwPsT1YP9ZG06PGkyzJXhLdasQwDqY8XKTWfUUAYVafM9Q29pau5cA
Message-ID: <CAAhV-H5SCuXERUBbC5D+k1pjf-Pmf33LOQXL=aUP-E-DgO6+qg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Optimize sign-extention mov instructions
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, bpf@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Wed, Aug 27, 2025 at 9:27=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> On Tue, Aug 26, 2025 at 2:49=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > For 8-bit and 16-bit sign-extention mov instructions, it can use the na=
tive
> > instructions ext.w.b and ext.w.h directly, no need to use the temporary=
 t1
> > register, just remove the redundant operations.
> >
> > Here are the test results:
> >
> >   # modprobe test_bpf test_range=3D81,84
> >   # dmesg -t | tail -5
> >   test_bpf: #81 ALU_MOVSX | BPF_B jited:1 5 PASS
> >   test_bpf: #82 ALU_MOVSX | BPF_H jited:1 5 PASS
> >   test_bpf: #83 ALU64_MOVSX | BPF_B jited:1 5 PASS
> >   test_bpf: #84 ALU64_MOVSX | BPF_H jited:1 5 PASS
> >   test_bpf: Summary: 4 PASSED, 0 FAILED, [4/4 JIT'ed]
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index abfdb6bb5c38..7072db18c6cd 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -527,13 +527,11 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >                         emit_zext_32(ctx, dst, is32);
> >                         break;
> >                 case 8:
> > -                       move_reg(ctx, t1, src);
> > -                       emit_insn(ctx, extwb, dst, t1);
> > +                       emit_insn(ctx, extwb, dst, src);
> >                         emit_zext_32(ctx, dst, is32);
> >                         break;
> >                 case 16:
> > -                       move_reg(ctx, t1, src);
> > -                       emit_insn(ctx, extwh, dst, t1);
> > +                       emit_insn(ctx, extwh, dst, src);
> >                         emit_zext_32(ctx, dst, is32);
> >                         break;
> >                 case 32:
> > --
>
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> > 2.42.0
> >

