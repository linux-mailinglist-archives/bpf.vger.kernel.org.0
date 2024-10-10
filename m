Return-Path: <bpf+bounces-41656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D3B9994FC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470EE284DEB
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC41E2839;
	Thu, 10 Oct 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYPMB3ln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF41E5738
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598433; cv=none; b=cRkviRTG+NxHPpqiCwji2/8bg1+KfDcLI+ZhBVUskXOsh3AlOeudEulwbNUC7Dt3IMgnZh/QF8g4HAq/21gmOH4EbyTMQ0EQTuAOLOA7m4wODVaGzBWRzQf+St0h4E+3a0BZg6S9wJROqWgpXx/kiJIJd2C5JtLH0TOu/1U1FaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598433; c=relaxed/simple;
	bh=Wu9m633zC4jyM3QlNh/2F8UpQ+iIjPatyqBPm4ZLneM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZTplJcWsQrPm9CFsj89QLUKpe3MUqk8hp23et2mcPeN4JxUSADl/FHv1ELcQhv0Hn79gndW9TH3RRAWvIG7awxl6YBnvvnhPoJSx3IjRyf8wlSpBLWVvt8QcRlJ2Mj9StOYwSJYu0fkNLm1oxlKqIYYYQQusfueVPAyM7INYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYPMB3ln; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db54269325so1188568a12.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728598431; x=1729203231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh6ri99ZreLUFET8Rb4vFCzd0yPtRSsUUDkNeJYfGJg=;
        b=IYPMB3ln9uQ7cKTAE/S3y7mVsg7HcNoM9WPStj2vqQChkNMcpHlOe0buWgUZnj8AL/
         LBJkPj1jRm98Bih6eGlzvcIMHoKMbpOCsEZn6sO/bU3rrLVBKf85L+wswy4ReP4XsGNc
         3pu4C2pXeNr7BygAnVmpY/s7CChSCTfIGRbc0rp++iwbLnWS8v9jR3FA7Ccd/uMr94+Y
         Twaz+JRpXLhtEAohDJOdaFwxlnWaxs6bkkBpgaLVVXt6wCwzCmN0x20jgIFxvT1xkBxB
         cgcNocmmU6chinXiTxVvh4yBPDu46o/zBGlnZMqL7iY0AoDjhxiGVttyaOlzzUSNcNN7
         B5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598431; x=1729203231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh6ri99ZreLUFET8Rb4vFCzd0yPtRSsUUDkNeJYfGJg=;
        b=XOfmghSJiBLQAv5mW2vPtvsTi+xPv1/eBZZ7EvcJFC0WrFmme31tpWSDpkQyhDrgJ+
         g75/JVVHEHYIJxYvMqolt4AzISjdA21J2O1a/P0WEPUTCss3rfdoO2fshbElB6y0Wwae
         2Y889Cnu1aHSUq2lDLKfae+k8ygRvDDpgHYa8+V0h6mi812HZAKliZbtOX9OkZO7t4GQ
         qiBZq3DWcciYqvsCJhJP9Pe1PU/4D/MilLtN3U6D79Vk7cuoYz8l3ukRKpa/mHvYehZl
         eWVgn9lisQkW1V9d/YR+5YK9GPE5Fuu66VAfJdPzPPSq0yqUPuLEa142lRPInPewY0MZ
         UqWg==
X-Forwarded-Encrypted: i=1; AJvYcCVLMtXdwzMbFiTZeaI+nxYETpSELzPad4DMDPaDsM0YIkHDAUDgA48YBuhvB36D8mPhZEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzptK/d2wylL2sDeLT0h1ymaPuAmwdQz+CuELB0RRVUTu90O4UK
	ecJgl7Owxpil6Ob5ksa1IaRTAY94hZPbipk80FSAh5uKoJhBiahm2+wtCHDx1lXJCPBd4jUUXD4
	GAJxWokFNjOdylsdjYxgiCqbhLJ3jDuUe
X-Google-Smtp-Source: AGHT+IH9k5i7/EutuhNRyvrE3tPZCn8LTeRliiOJFmMZF9D//x/Ou2uNFAlpgvtfsZaSXo1k5HZjBOuIwmQb+gNik/g=
X-Received: by 2002:a17:90b:2304:b0:2e2:d181:6809 with SMTP id
 98e67ed59e1d1-2e2f0ea9db9mr828764a91.39.1728598431271; Thu, 10 Oct 2024
 15:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009021254.2805446-1-eddyz87@gmail.com> <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
 <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
In-Reply-To: <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 15:13:38 -0700
Message-ID: <CAEf4BzZf1qr-ukaSHkv=pgCfEN5LQER7b4EovUM-TVtdwgJrZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop back-edges
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 9, 2024 at 12:41=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Tue, 2024-10-08 at 19:12 -0700, Eduard Zingerman wrote:
> > > In [1] syzbot reported an interesting BPF program.
> > > Verification for this program takes a very long time.
> > >
> > > [1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@goog=
le.com/
> > >
> > > The program could be simplified to the following snippet:
> > >
> > >     /* Program type is kprobe */
> > >        r7 =3D *(u16 *)(r1 +0);
> > >     1: r7 +=3D 0x1ab064b9;
> > >        if r7 & 0x702000 goto 1b;
> > >        r7 &=3D 0x1ee60e;
> > >        r7 +=3D r1;
> > >        if r7 s> 0x37d2 goto +0;
> > >        r0 =3D 0;
> > >        exit;
> >
> > Answering a few questions from off-list discussion with Alexei.
> > The test is not specific for jset instruction, e.g. the following
> > program exhibits similar behaviour:
> >
> > SEC("kprobe")
> > __failure __log_level(4)
> > __msg("BPF program is too large.")
> > __naked void short_loop1(void)
> > {
> >         asm volatile (
> >         "   r7 =3D *(u16 *)(r1 +0);"
> >         "   r8 =3D *(u64 *)(r1 +16);"
> >         "1: r7 +=3D 0x1ab064b9;"
> >         "if r7 < r8 goto 1b;"
> >         "   r7 &=3D 0x1ee60e;"
> >         "   r7 +=3D r1;"
> >         "   if r7 s> 0x37d2 goto +0;"
> >         "   r0 =3D 0;"
> >         "   exit;"
> >         ::: __clobber_all);
> > }
> >
> > > The snippet exhibits the following behaviour depending on
> > > BPF_COMPLEXITY_LIMIT_INSNS:
> > > - at 1,000,000 verification does not finish in 15 minutes;
> > > - at 100,000 verification finishes in 15 seconds;
> > > - at 100 it is possible to get some verifier log.
> >
> > Still investigating why running time change is non-linear.
> >
> > [...]
> >
> > > This patch forcibly enables checkpoints for each loop back-edge.
> > > This helps with the programs in question, as verification of both
> > > syzbot program and reduced snippet finishes in ~2.5 sec.
> >
> > There is the following code in is_state_visited():
> >
> >                         ...
> >                         /* if the verifier is processing a loop, avoid =
adding new state
> >                          * too often, since different loop iterations h=
ave distinct
> >                          * states and may not help future pruning.
> >                          * This threshold shouldn't be too low to make =
sure that
> >                          * a loop with large bound will be rejected qui=
ckly.
> >                          * The most abusive loop will be:
> >                          * r1 +=3D 1
> >                          * if r1 < 1000000 goto pc-2
> >                          * 1M insn_procssed limit / 100 =3D=3D 10k peak=
 states.
> >                          * This threshold shouldn't be too high either,=
 since states
> >                          * at the end of the loop are likely to be usef=
ul in pruning.
> >                          */
> > skip_inf_loop_check:
> >                         if (!env->test_state_freq &&
> >                             env->jmps_processed - env->prev_jmps_proces=
sed < 20 &&
> >                             env->insn_processed - env->prev_insn_proces=
sed < 100)
> >                                 add_new_state =3D false;
> >                         goto miss;
> >                         ...
> >
> > Which runs into a direct contradiction with what I do in this patch,
> > so either I need to change the patch or this fragment needs adjustment.
>
> Yeah. It's not saving all states exactly to avoid:
> loop3.bpf.o                 while_true
> +350359 (+106.88%)       +0 (+0.00%)  +101448 (+1049.86%)
>
> 100k states is a lot of memory. It might cause OOMs.
>
> pyperf600 improvement is certainly nice though.
>
> It feels it's better to adjust above heuristic 20 && 100 instead
> of forcing save state everywhere.
>
> Something should be done about:
>           71.25%        [k] __mark_chain_precision
>           24.81%        [k] bt_sync_linked_regs
> as well.
> The algorithm there needs some tweaks.

If we were to store bpf_jmp_history_entry for each instruction (and we
can do that efficiently, memory-wise, I had the patch), and then for
each instruction we maintained a list of "input" regs/slots and
corresponding "output" regs/slots as we simulate each instruction
forward, I think __mark_chain_precision would be much simpler and thus
faster. We'd basically just walk backwards instruction by instruction,
check if any of the output regs/slots need to be precise (few bitmasks
intersection), and if yes, set all input regs/slots as "need
precision", and just continue forward.

I think it's actually a simpler approach and should be faster. Simpler
because it's easy to tell inputs/outputs while doing forward
instruction processing. Faster because __mark_chain_precision would
only do very simple operation without lots of branching and checks.

We are already halfway there, tbh, with the linked registers and
insn_stack_access_flags() (i.e., information that we couldn't
re-derive in the backwards pass). So maybe we should bite the bullet
and go all in?

P.S. And just in general, there is a certain appeal to always having a
complete history up to any current point in time. Feels like this
would be useful in the future for some extra optimizations or checks.

>
> pw-bot: cr

