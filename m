Return-Path: <bpf+bounces-14736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD127E798A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A461F20D4A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A5C612F;
	Fri, 10 Nov 2023 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfhtXxlA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B16AB1
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:50:46 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429237DB2
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:50:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4084095722aso12437865e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699599044; x=1700203844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZHuvUfB341M+H6FjgJN1Y0zwu++vQj5qy8NSqIBE+w=;
        b=ZfhtXxlAsujQSuEiuT1vDbS3gH1UcpAhOIuqzp+XM90F8jhR5c+1VmCi9Al0UkiTRo
         dnkC5nwBjgoFyg2jAqltEO2QH6IL9FCiL31gqkOZg9Kl7LExRVnm7+e+h2to0v3YbWhl
         l1kxxmNAU9cVWOVJVu3BOBDrphhU6pWqTXSfZIqMwarHxhyAdtWOncP6w9x0TcIGfK/5
         oqldLm1d8Zx8I4QM3N1BkpybhMkHpwl1wMfZ4/KYAKnBO7LphutCxoNrQ19zBi0vd5XH
         zpQC4I/g16tVWGlvRyX8+lQMT5/WJ6TFHKf9zouFZOExxlCMB/e2dz6W6YktWkGdCyYJ
         0TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699599044; x=1700203844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZHuvUfB341M+H6FjgJN1Y0zwu++vQj5qy8NSqIBE+w=;
        b=ERy2rQEIf2fHo3Lo5A+2iUgCo1EZhv1K0UrrEMaf4xV7o+SIdiLOmdnCG7rFB76TnK
         1StBvGG44mGbxzS2i6/ZbVIHprlhvjd24KonSO+VZc2UfZbg5HchQRNXCH4s9WWcvu5e
         B0EdgDsLu9UxIXaTiNd0cj+l3WZ+jE8lpAp5rTaeFu/u+k6Gteh1yCjGucbzTsSdtSTV
         nPUtUgljxuK70xoy4mdK5ccq/H5kUc5mIZ3sepdSkbr6DekIGiic2KI8cP2Cs1R5Qah2
         P7Vq+nVPhdTJvbhctVh8vgjwWDSihIV9K6bCwYk/2sV1DhkiK0NIt+NWcH3xIhkR1u62
         8GtA==
X-Gm-Message-State: AOJu0YyaDEuxZrZ2tuY/YijFdk8N9efKZYgMrJMZJ2YLFzbWGjhwOyVd
	wQZA+XXkViwl/cvlG9YzKcKRR/Xu03UEbGQ5rVISrqnd
X-Google-Smtp-Source: AGHT+IGVY2HhXif6tKS9FTJqXkgjbVdQGs8NlYZtJ4foK0X3X0PeIcnTE5NLwfe9doRM8IlzJ6TSPtl0NZEJWi9JHrA=
X-Received: by 2002:a17:907:7295:b0:9d5:ecf9:e6b8 with SMTP id
 dt21-20020a170907729500b009d5ecf9e6b8mr6180973ejc.12.1699589129686; Thu, 09
 Nov 2023 20:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110002638.4168352-1-andrii@kernel.org> <20231110002638.4168352-4-andrii@kernel.org>
 <CAADnVQ+KtueBdD=8DazMhM3Xz0+YpLVW1-5-N4ZFiBOzji4vbg@mail.gmail.com> <CAEf4Bza1nxvLcBORkV+bKbKCz=f1jhRYM=PPaJxXDfQ7rmfJvA@mail.gmail.com>
In-Reply-To: <CAEf4Bza1nxvLcBORkV+bKbKCz=f1jhRYM=PPaJxXDfQ7rmfJvA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 20:05:18 -0800
Message-ID: <CAEf4BzZFc6t5KCdCH4zYA1jp9UgRWHsEKgfMjVcc72qgH-FHXQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] selftests/bpf: add edge case backtracking
 logic test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:43=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 5:34=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 4:26=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > Add a dedicated selftests to try to set up conditions to have a state
> > > with same first and last instruction index, but it actually is a loop
> > > 3->4->1->2->3. This confuses mark_chain_precision() if verifier doesn=
't
> > > take into account jump history.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../selftests/bpf/progs/verifier_precision.c  | 40 +++++++++++++++++=
++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b=
/tools/testing/selftests/bpf/progs/verifier_precision.c
> > > index 193c0f8272d0..6b564d4c0986 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> > > @@ -91,3 +91,43 @@ __naked int bpf_end_bswap(void)
> > >  }
> > >
> > >  #endif /* v4 instruction */
> > > +
> > > +SEC("?raw_tp")
> > > +__success __log_level(2)
> > > +/*
> > > + * Without the bug fix there will be no history between "last_idx 3 =
first_idx 3"
> > > + * and "parent state regs=3D" lines. "R0_w=3D6" parts are here to he=
lp anchor
> > > + * expected log messages to the one specific mark_chain_precision op=
eration.
> > > + *
> > > + * This is quite fragile: if verifier checkpointing heuristic change=
s, this
> > > + * might need adjusting.
> >
> > Hmm, but that what
> > __flag(BPF_F_TEST_STATE_FREQ)
> > supposed to address.
>
> When I was analysing and crafting the test I for some reason assumed I
> need to have a jump inside the state that won't trigger state
> checkpoint. But I think that's not necessary, just doing conditional
> jump and jumping back an instruction or two should do. With that yes,
> TEST_STATE_FREQ should be a better way to do this.

Ah, ok, TEST_STATE_FREQ won't work. It triggers state checkpointing
both at conditional jump instruction and on its target, because target
is prune point.

So I think this test has to be the way it is.

>
> >
> > > + */
> > > +__msg("2: (07) r0 +=3D 1                       ; R0_w=3D6")
> > > +__msg("3: (35) if r0 >=3D 0xa goto pc+1")
> > > +__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
> > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 2: (07) r0 +=
=3D 1")
> > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 1: (07) r0 +=
=3D 1")
> > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 4: (05) goto =
pc-4")
> > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (35) if r0=
 >=3D 0xa goto pc+1")
> > > +__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=
=3DP4")
> > > +__msg("3: R0_w=3D6")
> > > +__naked int state_loop_first_last_equal(void)
> > > +{
> > > +       asm volatile (
> > > +               "r0 =3D 0;"
> > > +       "l0_%=3D:"
> > > +               "r0 +=3D 1;"
> > > +               "r0 +=3D 1;"
> >
> > That's why you had two ++ ?
> > Add state_freq and remove one of them?

