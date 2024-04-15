Return-Path: <bpf+bounces-26857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4C8A5A07
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3161C2124F
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B615572E;
	Mon, 15 Apr 2024 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dDX0pBUr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB63154C02
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206455; cv=none; b=WLdRLUH69jI+ivLcbjVv1jkMf9NrDbSCAId2jvNRcGN2mLawq1MSBKyMsOwcJnav8iEQM3R42aZadPoRBlJn7gKyxurXZ3io0OCuXeu3b8+WI6PGpcEVDFvmrW9fZ79w4L9S0PHFy/1U7MVW3Ie3TZ7g/5cs+/e1BamzEl0IAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206455; c=relaxed/simple;
	bh=KbXImj/lEi6BVsCzjjZpNLCtZtSZ5+ezh8/zj35cE/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjEp6koaqnpoXWT5uemysKiddL1BUiDdoyZMMuOjm+k6BG+2BWYURmkWLoB6jGctMeYq8evjyGYwyZq1awBv58/Z1sN/b1UUz2e6eZNkoB6TuKWIDLtHt9Mdw/Fx1R5Ps7D94NPMbn2c7WHIEVqHs6B+3V/7M4V9xHhYpRWv7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dDX0pBUr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61acfd3fd3fso14890027b3.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1713206452; x=1713811252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjRCBK5JMLNlFOWsOaXHq7Ony/dWmdFPQuPtnw6QEco=;
        b=dDX0pBUrl8F/bbNGDVWYYNeDx2C+zT73pYLG0dJAtH7dPpKzW1WKd0ahANGXnVn8uL
         +nfu52qf59SOecd7E/RfaoO9BaEoPpTJv9liChoNDxP4NaxOVfdg61EB0MwH55fFe1d3
         ObeWu7p4XoFMO65cOGJewBZGFKxqxAGo5HG3toM6zLboaJqU3nUpuu0rQXOD5uNLUEYH
         mWp63PgLFlkXpbkxrbaqkUy63m/UaccsT1q92SoXBozJWXC/NX/i68COY1ymClfTrQn/
         ncgk/KqBlC1fU67pURStKsYnvpdt0J4NuL8JyALcZ/ODo1apzFOH+cEbqOyGlFYDKJ/g
         oapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713206452; x=1713811252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjRCBK5JMLNlFOWsOaXHq7Ony/dWmdFPQuPtnw6QEco=;
        b=ch4Vp1ykkuEKQVxxhEmLKMrvDEFUmCBXhwgfWUKWtO9SSr4nJ2n/4CDBR0dLqkc7lu
         HKmF6Gb19to1Ek1ZtSEEYWO9jO7yltvg7E7/lI8PJYykxtQYaXZm8y1OinTjgFZKR5QY
         Lw4697VcjV5tKGTg+db88hBMVetwjWH4imoXAIOjwWp+WO4v7VN87kJLAKAeEQKZkL/8
         FltlcMI7KjWHIfmND9bVoW1PeNsEIkuOmtZA14VFKrQnE98JZ1Pkr3CQwHg0tzZA7kgM
         kK1EUi649KgXQ3aH+mTCBn5GyZjoco1aeQeUNQY0oqY3iBEeLowLsai931WWO3IY/Zh6
         nW0g==
X-Gm-Message-State: AOJu0Ywvdda8thA83zzgLW0rsB/Aps0UnN/KW/1RBCNuonSI1OpJ5fSh
	JfQ3GJcrciezu1hevZbXeCSjHpLsUE+oQDkfSs9kQQi1Wt9jwJe0I7e+nSsXL+/Mym7dDFbx409
	8ki9W5ZfnUh1PMQ2UawM+YzDCIAL2MmYwlyLdy8NnK2sWA2lw
X-Google-Smtp-Source: AGHT+IHYwF2QDIPPGH9DsXJ9kqTM3FIZjKNNK13+qvfKuo0pO8FZPMJxbFxZCN/0BIVtrdoZnB9M/ESo1x4RjOg642I=
X-Received: by 2002:a81:5281:0:b0:618:ce10:2fcd with SMTP id
 g123-20020a815281000000b00618ce102fcdmr6566718ywb.26.1713206451984; Mon, 15
 Apr 2024 11:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
 <25703ec0-f985-4d5f-8bfa-0c070da5b570@huaweicloud.com> <CABWYdi0BQHB1_COkcSnr_JxDMJipHPbv3=FKOKqD5qED-j37Pg@mail.gmail.com>
In-Reply-To: <CABWYdi0BQHB1_COkcSnr_JxDMJipHPbv3=FKOKqD5qED-j37Pg@mail.gmail.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Mon, 15 Apr 2024 11:40:41 -0700
Message-ID: <CABWYdi1_VXneXYTmww31C5VKZXOH7t_rVbAC+6BVVbOv=iL2aw@mail.gmail.com>
Subject: Re: Incorrect BPF stats accounting for fentry on arm64
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:46=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> On Thu, Apr 11, 2024 at 7:30=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.c=
om> wrote:
> >
> > On 4/12/2024 2:09 AM, Ivan Babrou wrote:
> > > Hello,
> > >
> > > We're seeing incorrect data for bpf runtime stats on arm64. Here's an=
 example:
> > >
> > > $ sudo bpftool prog show id 693110
> > > 693110: tracing  name __tcp_retransmit_skb  tag e37be2fbe8be4726  gpl
> > > run_time_ns 2493581964213176 run_cnt 1133532 recursion_misses 1
> > >      loaded_at 2024-04-10T22:33:09+0000  uid 62727
> > >      xlated 312B  jited 344B  memlock 4096B  map_ids 8550445,8550441
> > >      btf_id 8726522
> > >      pids prometheus-ebpf(2224907)
> > >
> > > According to bpftool, this program reported 66555800ns of runtime at
> > > one point and then it jumped to 2493581675247416ns just 53s later whe=
n
> > > we looked at it again. This is happening only on arm64 nodes in our
> > > fleet on both v6.1.82 and v6.6.25.
> > >
> > > We have two services that are involved:
> > >
> > > * ebpf_exporter attaches bpf programs to the kernel and exports
> > > prometheus metrics and opentelementry traces driven by its probes
> > > * bpf_stats_exporter runs bpftool every 53s to capture bpf runtime me=
trics
> > >
> > > The problematic fentry is attached to __tcp_retransmit_skb, but an
> > > identical one is also attached to tcp_send_loss_probe, which does not
> > > exhibit the same issue:
> > >
> > > SEC("fentry/__tcp_retransmit_skb")
> > > int BPF_PROG(__tcp_retransmit_skb, struct sock *sk)
> > > {
> > >    return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_retransmi=
t_skb);
> > > }
> > >
> > > SEC("fentry/tcp_send_loss_probe")
> > > int BPF_PROG(tcp_send_loss_probe, struct sock *sk)
> > > {
> > >    return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_send_loss=
_probe);
> > > }
> > >
> > > In handle_sk we do a map lookup and an optional ringbuf push. There i=
s
> > > no sleeping (I don't think it's even allowed on v6.1). It's
> > > interesting that it only happens for the retransmit, but not for the
> > > loss probe.
> > >
> > > The issue manifests some time after we restart ebpf_exporter and
> > > reattach the probes. It doesn't happen immediately, as we need to
> > > capture metrics 53s apart to produce a visible spike in metrics.
> > >
> > > There is no corresponding spike in execution count, only in execution=
 time.
> > >
> > > It doesn't happen deterministically. Some ebpf_exporter restarts show
> > > it, some don't.
> > >
> > > It doesn't keep happening after ebpf_exporter restart. It happens onc=
e
> > > and that's it.
> > >
> > > Maybe recursion_misses plays a role here? We see none for
> > > tcp_send_loss_probe. We do see some for inet_sk_error_report
> > > tracepoint, but it doesn't spike like __tcp_retransmit_skb does.
> > >
> > > The biggest smoking gun is that it only happens on arm64.
> > >
> > > I'm happy to try out patches to figure this one out.
> > >
> >
> > I guess the issue is caused by the not setting of x20 register
> > when __bpf_prog_enter(prog) returns zero.
>
> Yes, I think this is it. Your patch makes it match x86_64 and it seems lo=
gical.
>
> I'm building a kernel with it to put it into production to make sure.

I let it simmer over the weekend. The issue kept happening on the
control group, but the test group was fine. Please proceed with this
patch.

> > The following patch may help:
> >
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -1905,15 +1905,15 @@ static void invoke_bpf_prog(struct jit_ctx *ctx=
, struct bpf_tramp_link *l,
> >
> >          emit_call(enter_prog, ctx);
> >
> > +       /* save return value to callee saved register x20 */
> > +       emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
> > +
> >          /* if (__bpf_prog_enter(prog) =3D=3D 0)
> >           *         goto skip_exec_of_prog;
> >           */
> >          branch =3D ctx->image + ctx->idx;
> >          emit(A64_NOP, ctx);
> >
> > -       /* save return value to callee saved register x20 */
> > -       emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
> > -
> >          emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
> >          if (!p->jited)
> >                  emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx)=
;
> >

