Return-Path: <bpf+bounces-14696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5647E7833
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF3A1C20D27
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7B1848;
	Fri, 10 Nov 2023 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAG2PPOq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D41841
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:43:29 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C884681
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:43:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a29c7eefso2016958e87.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 19:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699587807; x=1700192607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+rSz2IrRrGaqVGIg+rFuItamCUFiD7agjn84BQaPYs=;
        b=bAG2PPOqOI0U6J4NNrFl/SkGZYy474nXzNa1dJTbpakjljJtUqmemUOU0f9iQVzwWe
         dNG4vhBYERJHXgjfjD/uPleQceJpK08askCtdKMSO8+0XtgiYmkA5yOUeZu1F7l2Ucx3
         Nbbo4dxE2IjQUWUhumt6sMsxsqHwVemRNJkwW+zSW9r/BNcJqnaoeIpNTX7yZC5tWqRd
         1jBV2AKqqXeOrZd147oKHq9AcJp/lAVFHxmxXjxdNU/Zit5SIEWMvrZUUUD2W638H9cR
         WO0dAfnSHfxZFiM4q021FM/vAur1rofHixUeWwD+i6kX4VVNYzW2KdWidLRgfc9JkTai
         DsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699587807; x=1700192607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+rSz2IrRrGaqVGIg+rFuItamCUFiD7agjn84BQaPYs=;
        b=Co7DX4OzEjmgcDSQPo3M1AH/EOSFvGgFGo7XJdqdWALfyOZMd7ET1kc3Umlds7Tv6P
         wCAIhlVrIns3oIIiF7v2auHObmLXekHK6VZHOlOwE+SQDGiDFnmn9CEcObweHOb8ISh2
         weAgF4nl3Da4/9ihqF9XoMcwBfSFHMj+xEdPGXmiW3NHS54KzcyRhvL/1Lek+CjWJ98u
         r0yrNHBogJChJZm4RFsd74V1AwEUlefsp/4asZZYehhWmT5pBfz97GSKDlwuNil7lRQU
         vKFTqq8MRLKVn4Y65ur/ZJjW9u7cO2PCn0OpVAZ58dF4lF7Gy8XxkWs+Dbw8S0fnv6GO
         7F6g==
X-Gm-Message-State: AOJu0YwRKLc/i1NEdeQMgGHd6VRCHuR/8rU4gD5iYuNCD3e0xb6t+T5L
	M1mcYfO90SoQPlWrFtXBMlMqWK23WDqwnEAuwkeYhKGm
X-Google-Smtp-Source: AGHT+IFgCLu0pc5EP25rL3yBy0TZSEThB/eGGdZ3EF2PyykIoyefDZsRQ6q64jb4t8FIvZRBUcA2SaO5ZpgvzWrkmL8=
X-Received: by 2002:a05:6512:25b:b0:503:36cb:5436 with SMTP id
 b27-20020a056512025b00b0050336cb5436mr2928634lfo.9.1699587806953; Thu, 09 Nov
 2023 19:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110002638.4168352-1-andrii@kernel.org> <20231110002638.4168352-4-andrii@kernel.org>
 <CAADnVQ+KtueBdD=8DazMhM3Xz0+YpLVW1-5-N4ZFiBOzji4vbg@mail.gmail.com>
In-Reply-To: <CAADnVQ+KtueBdD=8DazMhM3Xz0+YpLVW1-5-N4ZFiBOzji4vbg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 19:43:15 -0800
Message-ID: <CAEf4Bza1nxvLcBORkV+bKbKCz=f1jhRYM=PPaJxXDfQ7rmfJvA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] selftests/bpf: add edge case backtracking
 logic test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 5:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 4:26=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Add a dedicated selftests to try to set up conditions to have a state
> > with same first and last instruction index, but it actually is a loop
> > 3->4->1->2->3. This confuses mark_chain_precision() if verifier doesn't
> > take into account jump history.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/progs/verifier_precision.c  | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/t=
ools/testing/selftests/bpf/progs/verifier_precision.c
> > index 193c0f8272d0..6b564d4c0986 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> > @@ -91,3 +91,43 @@ __naked int bpf_end_bswap(void)
> >  }
> >
> >  #endif /* v4 instruction */
> > +
> > +SEC("?raw_tp")
> > +__success __log_level(2)
> > +/*
> > + * Without the bug fix there will be no history between "last_idx 3 fi=
rst_idx 3"
> > + * and "parent state regs=3D" lines. "R0_w=3D6" parts are here to help=
 anchor
> > + * expected log messages to the one specific mark_chain_precision oper=
ation.
> > + *
> > + * This is quite fragile: if verifier checkpointing heuristic changes,=
 this
> > + * might need adjusting.
>
> Hmm, but that what
> __flag(BPF_F_TEST_STATE_FREQ)
> supposed to address.

When I was analysing and crafting the test I for some reason assumed I
need to have a jump inside the state that won't trigger state
checkpoint. But I think that's not necessary, just doing conditional
jump and jumping back an instruction or two should do. With that yes,
TEST_STATE_FREQ should be a better way to do this.

>
> > + */
> > +__msg("2: (07) r0 +=3D 1                       ; R0_w=3D6")
> > +__msg("3: (35) if r0 >=3D 0xa goto pc+1")
> > +__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
> > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 2: (07) r0 +=3D=
 1")
> > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 1: (07) r0 +=3D=
 1")
> > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 4: (05) goto pc=
-4")
> > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (35) if r0 >=
=3D 0xa goto pc+1")
> > +__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=3DP=
4")
> > +__msg("3: R0_w=3D6")
> > +__naked int state_loop_first_last_equal(void)
> > +{
> > +       asm volatile (
> > +               "r0 =3D 0;"
> > +       "l0_%=3D:"
> > +               "r0 +=3D 1;"
> > +               "r0 +=3D 1;"
>
> That's why you had two ++ ?
> Add state_freq and remove one of them?

