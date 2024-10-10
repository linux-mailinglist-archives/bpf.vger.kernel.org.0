Return-Path: <bpf+bounces-41514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9A9979FB
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A515B284896
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252A219E4;
	Thu, 10 Oct 2024 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm9zFTEA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53E2207A
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522547; cv=none; b=AFWiPtb5C1LPeAHvMszustDWL30i9Jx2O2Dq8gqVl8JGjVwwC7Q0RhBNCla48HD66bptjPLcP5U2O8Wn58+jc2R3ZhVDy01KZBudNIkKH8iB54tH9bPJlRrZ9OiR0KaN6ZnHkUA6auflhqaDGrNgx+tunW22PksPtt73p+/+vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522547; c=relaxed/simple;
	bh=QQrx/bsE4xYg0plGczX8Ka+HniwpTrlXMxn5GMuVCNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+LmUIMRsKCQGs79Xy14pfYLY8IdPmicW6CcIpkhahoLU1pdIHa+NCAUUrnOPylbyGh61erLVDS5gTszqtUkOYFh8VZrArDh6GylLuSiI56buteezNCoElvSzzoUlRW9jImokeknmMuyRwcOoL6FVCOCV7cYmPBggZRcYE80DUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm9zFTEA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so116848f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 18:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728522544; x=1729127344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjpAza320b5AcsY5QBOif8ei1C8KmmNBNLlJBZE2Z74=;
        b=Fm9zFTEAUXQ3NvGUNp1KcM+BBSvYfrmW0mgEWYYfH189O9frU48rwpQedj72y2gi5Y
         nRVSJ032uWO/7IQAkuPFreo5z0ogEe/ovZV6aQD31e9pTe4Myj/f4nLVwQNcAS3SL3LL
         5ZEq8qiQDxI1jvk3ezisQxwq19rO7v9yJnb+MIBlniojkCZYia5yL6KShAB88s0Folrh
         yZP7Q014vKBA1qrEtY9MUC2hCnHUP7ceFYao4dYQmSKpGhLfCmmGVnozoo+Ue/YYbzzr
         92efZPu+5T4v6GZuL7ogLzyKazJOiEmbD16227vUAabGd7mTxYuTfdJ6gPk8PHOIDwmf
         Ibmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728522544; x=1729127344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjpAza320b5AcsY5QBOif8ei1C8KmmNBNLlJBZE2Z74=;
        b=WzU0BExxAqwxotO7bMsmks2tWZvwI0N1vro1xpHKpxlY2f6c9QqH6wd/M9fY3oC23c
         djFJ3rr+CcOJS51Ucn5JIvAEWHU2nFXqyutkKI1kxh2eGRz7jaGoPbg3ZyXnF9q6iuQn
         vY7VnxVUf+y/2KHr0RAGW7fBUjNKCSw86UTL6WGVaWCmQQqx/h+m2uBuV6cNYZuApLbV
         MwMkzlp5kiTYze2NKNGWmOOmJbiVrlr4FpidA9oXna6ft/lbv97Hn5l2TI2+IsNCcTr7
         l5X4imkrFXiQNhawVr53OdhcMyUqDjTADeF+EjpKFPmUDekvmZaihVlI12gLX8LugR6Q
         eqBw==
X-Gm-Message-State: AOJu0YwgoeHtfSRfVnm29L9dJ/pX0ppTDwf9LT+C0lxHd0NkP3XRNFml
	wSCESh8e4coxAa6hT/k488uOEtzB3ntu3FU2QGsyBCjep0d2osnjCfurbOOTQI4fJghJdO3Rwzy
	tvuw2iXrmJQlAFkT7qtfEXEywSGk=
X-Google-Smtp-Source: AGHT+IHFOkRUEoWUyfSVGG97qSx3OcJJVp7Gjbip06yiVmu8s2WR7XWT7QBH8GuewAXUh6th+bM7hjvSqQTZlylufts=
X-Received: by 2002:adf:a412:0:b0:371:8319:4dcc with SMTP id
 ffacd0b85a97d-37d47e93e3amr1127651f8f.2.1728522544257; Wed, 09 Oct 2024
 18:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009021254.2805446-1-eddyz87@gmail.com> <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
In-Reply-To: <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 18:08:53 -0700
Message-ID: <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop back-edges
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:41=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-10-08 at 19:12 -0700, Eduard Zingerman wrote:
> > In [1] syzbot reported an interesting BPF program.
> > Verification for this program takes a very long time.
> >
> > [1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google=
.com/
> >
> > The program could be simplified to the following snippet:
> >
> >     /* Program type is kprobe */
> >        r7 =3D *(u16 *)(r1 +0);
> >     1: r7 +=3D 0x1ab064b9;
> >        if r7 & 0x702000 goto 1b;
> >        r7 &=3D 0x1ee60e;
> >        r7 +=3D r1;
> >        if r7 s> 0x37d2 goto +0;
> >        r0 =3D 0;
> >        exit;
>
> Answering a few questions from off-list discussion with Alexei.
> The test is not specific for jset instruction, e.g. the following
> program exhibits similar behaviour:
>
> SEC("kprobe")
> __failure __log_level(4)
> __msg("BPF program is too large.")
> __naked void short_loop1(void)
> {
>         asm volatile (
>         "   r7 =3D *(u16 *)(r1 +0);"
>         "   r8 =3D *(u64 *)(r1 +16);"
>         "1: r7 +=3D 0x1ab064b9;"
>         "if r7 < r8 goto 1b;"
>         "   r7 &=3D 0x1ee60e;"
>         "   r7 +=3D r1;"
>         "   if r7 s> 0x37d2 goto +0;"
>         "   r0 =3D 0;"
>         "   exit;"
>         ::: __clobber_all);
> }
>
> > The snippet exhibits the following behaviour depending on
> > BPF_COMPLEXITY_LIMIT_INSNS:
> > - at 1,000,000 verification does not finish in 15 minutes;
> > - at 100,000 verification finishes in 15 seconds;
> > - at 100 it is possible to get some verifier log.
>
> Still investigating why running time change is non-linear.
>
> [...]
>
> > This patch forcibly enables checkpoints for each loop back-edge.
> > This helps with the programs in question, as verification of both
> > syzbot program and reduced snippet finishes in ~2.5 sec.
>
> There is the following code in is_state_visited():
>
>                         ...
>                         /* if the verifier is processing a loop, avoid ad=
ding new state
>                          * too often, since different loop iterations hav=
e distinct
>                          * states and may not help future pruning.
>                          * This threshold shouldn't be too low to make su=
re that
>                          * a loop with large bound will be rejected quick=
ly.
>                          * The most abusive loop will be:
>                          * r1 +=3D 1
>                          * if r1 < 1000000 goto pc-2
>                          * 1M insn_procssed limit / 100 =3D=3D 10k peak s=
tates.
>                          * This threshold shouldn't be too high either, s=
ince states
>                          * at the end of the loop are likely to be useful=
 in pruning.
>                          */
> skip_inf_loop_check:
>                         if (!env->test_state_freq &&
>                             env->jmps_processed - env->prev_jmps_processe=
d < 20 &&
>                             env->insn_processed - env->prev_insn_processe=
d < 100)
>                                 add_new_state =3D false;
>                         goto miss;
>                         ...
>
> Which runs into a direct contradiction with what I do in this patch,
> so either I need to change the patch or this fragment needs adjustment.

Yeah. It's not saving all states exactly to avoid:
loop3.bpf.o                 while_true
+350359 (+106.88%)       +0 (+0.00%)  +101448 (+1049.86%)

100k states is a lot of memory. It might cause OOMs.

pyperf600 improvement is certainly nice though.

It feels it's better to adjust above heuristic 20 && 100 instead
of forcing save state everywhere.

Something should be done about:
          71.25%        [k] __mark_chain_precision
          24.81%        [k] bt_sync_linked_regs
as well.
The algorithm there needs some tweaks.

pw-bot: cr

