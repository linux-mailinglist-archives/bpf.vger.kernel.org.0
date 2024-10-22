Return-Path: <bpf+bounces-42729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268719A9670
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B101F2320D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F3384A32;
	Tue, 22 Oct 2024 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO1IEdQs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0B12E1CA
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565629; cv=none; b=DOK+v3tZuFDUsff4h0J1vjWbeteWSjVDe+c0Wwe0Cp7EkQYI6d6esH2HxmSbDcK9At45hh5KhLP027JElWgkBHUtIu5dKbDGbYmNsp+YIPhoRphBTjN6OIHCzfqzv90F7hoD5KAWovATnA0VDLl2YAmCCdMB8/T0FvVlUz8f6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565629; c=relaxed/simple;
	bh=50wTD4ZBzlgVLwdWeVRCZuupOTH89Oo/SmrUaQ+A8GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXGVStQvPZ6/0hCC82Bq+oqyI8W6qsRu/pmbGaSTwacd3a3MMHNGkllucAnvxVm+rs7cnRxmx9BZaeamdLLgXee4hVhLOQ01cISNaVie6Brw1tU9JXWFc9l0wvVZs/Ti/VdzWGhdeEKoMQ62lT9MPIchB9/WKu27k4J+uSyg/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO1IEdQs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3414293f8f.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729565626; x=1730170426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+pKJ7banA9R+pJtpjDekFOOAC3E20pwJJ8UWVS1Xyk=;
        b=DO1IEdQs+WeYtKRuhjX8abTmej+OnuA88HLPsIhyfdwhZpLyMTu7v4hy+MiZW2hQBp
         GF09GdxnZzsXXolEF14xSSDzgLSakDCfR9ggaz8zWRXJFZJOVV14wNov2PdMahO6ofy/
         5T0B8rowOB3ASdkiUy3Nk8yQjjfGrNxvtOwqe+M5RWr9KJYBFO7qblYwh530dFpJmNgl
         pX0ptEYTLg2WPczyoKf4LYAcbKieHi6OfQTU9rP6sXm9hqUUUUF7qZvG29opskRKUJnT
         qU7qRXfMU1RyNCgze7Si/IxfEEwqQiSU7qmlj101fk0+9I+E56nd4X/xz0DG7Dj8Qs+U
         rvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729565626; x=1730170426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+pKJ7banA9R+pJtpjDekFOOAC3E20pwJJ8UWVS1Xyk=;
        b=xVKKM6lTqCWdOYujDNnCb4Gur3G2w2KfmLAJsSbYWENgFaXV5n0zrxRR1BjIrhDJDt
         TmBWCQbn0B8Rgko0H0OasLnGDE0tjxm3fkJEgOyrNCvCc2wrY/pRXJXsNkRwCICaraBy
         fp/BdPBW3G6nsFAcCnzGFVFhbLxr+wbwv2UjxsrQnA6o5z5ffIVMT7lIeRG49JrhdZ16
         LAJHmfZjXDR2tr55XE5arD/WaWnZlaFz4xWHHp+BMk9dMQgpNfiJAJTVJrwJqXYxNq1c
         jC4Mlz04wKSJIf0WV/4KgTYkzjcnZt6qf2armF0nkuk//gqBRDUzluXCMRxBPDDcYAJK
         NkaQ==
X-Gm-Message-State: AOJu0Yx0eFOBzLdYhkljwKolzbp4B5m5YvKgKAq4LdNrdn8PkWhjj0tH
	onZ3LyurEaydScCrN2pbDTveF4nqyi0k1Kp8KjvncAcWNK7aa1F66Vo2M80Wpx8vaW7hyXt47ap
	mQNGA0dcsiaQuJ+cvTzniWfGhZm4cML7F
X-Google-Smtp-Source: AGHT+IFFjKR5r3V+KB6V/Cu98M5xM2qEE1H/onuxDGRtWOGVEQEZMBbxms2+fqJASzohjTDwR0AqyQZtOKwxX0ceA6I=
X-Received: by 2002:a5d:694a:0:b0:378:e8cd:71fa with SMTP id
 ffacd0b85a97d-37eb488725fmr9257985f8f.39.1729565626094; Mon, 21 Oct 2024
 19:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020307.1766906-1-eddyz87@gmail.com> <CAADnVQKtR96Dricc=JiOi3VR9OeHjgT6xLOto9k_QcpPQNsKJw@mail.gmail.com>
 <1564924604e5e17af10beac6bd3263481a1723f0.camel@gmail.com>
In-Reply-To: <1564924604e5e17af10beac6bd3263481a1723f0.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 19:53:34 -0700
Message-ID: <CAADnVQJa8+tLnxpMWPVXO=moX+4tv3nTomang5=PAeLjVAe+ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is
 too long
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:27=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-10-21 at 19:18 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > >     0: r7 =3D *(u16 *)(r1 +0);"
> > >     1: r7 +=3D 0x1ab064b9;"
> > >     2: if r7 & 0x702000 goto 1b;
> > >     3: r7 &=3D 0x1ee60e;"
> > >     4: r7 +=3D r1;"
> > >     5: if r7 s> 0x37d2 goto +0;"
> > >     6: r0 =3D 0;"
> > >     7: exit;"
>
> [...]
>
> > > And observe verification log:
> > >
> > >     ...
> > >     is_state_visited: new checkpoint at 5, resetting env->jmps_proces=
sed
> > >     5: R1=3Dctx() R7=3Dctx(...)
> > >     5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=3Dctx(...)
> > >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> > >     7: (95) exit
> > >
> > >     from 5 to 6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> > >     6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> > >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> > >     7: (95) exit
> > >     is_state_visited: suppressing checkpoint at 1, 3 jmps processed, =
cur->jmp_history_cnt is 74
> > >
> > >     from 2 to 1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> > >     1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> > >     1: (07) r7 +=3D 447767737
> > >     is_state_visited: suppressing checkpoint at 2, 3 jmps processed, =
cur->jmp_history_cnt is 75
> > >     2: R7_w=3Dscalar(...)
> > >     2: (45) if r7 & 0x702000 goto pc-2
> > >     ... mark_precise 152 steps for r7 ...
> > >     2: R7_w=3Dscalar(...)
> > >     is_state_visited: suppressing checkpoint at 1, 4 jmps processed, =
cur->jmp_history_cnt is 75
> > >     1: (07) r7 +=3D 447767737
> > >     is_state_visited: suppressing checkpoint at 2, 4 jmps processed, =
cur->jmp_history_cnt is 76
> > >     2: R7_w=3Dscalar(...)
> > >     2: (45) if r7 & 0x702000 goto pc-2
> > >     ...
> > >     BPF program is too large. Processed 257 insn
> > >
> > > The log output shows that checkpoint at label (1) is never created,
> > > because it is suppressed by `skip_inf_loop_check` logic:
> > > a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
> > >    onto stack and proceeds to (3);
> > > b. At (5) checkpoint is created, and this resets
> > >    env->{jmps,insns}_processed.
> > > c. Verification proceeds and reaches `exit`;
> > > d. State saved at step (a) is popped from stack and is_state_visited(=
)
> > >    considers if checkpoint needs to be added, but because
> > >    env->{jmps,insns}_processed had been just reset at step (b)
> > >    the `skip_inf_loop_check` logic forces `add_new_state` to false.
> > > e. Verifier proceeds with current state, which slowly accumulates
> > >    more and more entries in the jump history.
> >
> > I'm still not sure why it grew to thousands of entries in jmp_history.
> > Looking at the above trace jmps_processed grows 1 to 1 with jmp_history=
_cnt.
> > Also cur->jmp_history_cnt is reset to zero at the same time as
> > jmps processed.
> > So in the above test 75 vs 4 difference came from jmp_history
> > entries that were there before the loop ?
>
>     0: r7 =3D *(u16 *)(r1 +0);"
>     1: r7 +=3D 0x1ab064b9;"
>     2: if r7 & 0x702000 goto 1b;
>     3: r7 &=3D 0x1ee60e;"
>     4: r7 +=3D r1;"
>     5: if r7 s> 0x37d2 goto +0;"
>     6: r0 =3D 0;"
>     7: exit;"
>
> - When 'if' at (2) is processed current state is copied (let's call
>   this copy C), copy is put to the stack for later processing,
>   it's jump history is not cleared.
> - Then current state proceeds verifying 3-5-6-7. At (5) checkpoint is
>   created and env->{jmps,insns}_processed are reset.
> - Then state C is popped from the stack, it goes back to (1) and then (2)=
,
>   at (2) a copy C1 is created but no checkpoint, as env->{jmps,insns}_pro=
cessed
>   do not meet thresholds. C1's jmp_history is one entry longer then C's.
> - Whole thing repeats until ENOMEM.

I see. Thanks for explaining.
So the bug is actually in reset logic of jmps/insns_processed
coupled with push/pop stack.
I think let's add cur->jmp_history_cnt < 40 check for now
and target bpf tree (assuming no veristat regressions),
but for bpf-next we probably need to follow up.
We can probably remove jmps_processed counter
and replace it with jmp_history_cnt.

Based on the above explanation insns_processed counter is
also bogus.

