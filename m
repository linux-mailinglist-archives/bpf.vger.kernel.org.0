Return-Path: <bpf+bounces-38831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D32196A839
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F65B1C24607
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803531AB6DB;
	Tue,  3 Sep 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpRwHd3M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58006188912
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394781; cv=none; b=l0TWN6cv8HVTcEBnbybet2CWRqWY+BJOCSsOLBZv2QQ1nhUyDZcX8ymq8/WVXqPWQyj9AuDVaj1SXHrMVOAN5P1MqqhWc0RdkRRPHP6mNx69KTSXlU3Vf5pyH20EZeELfMTi9BpBdz+wuREtU60mqcR8SsAJEKBqBt4cPTbI3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394781; c=relaxed/simple;
	bh=Rbd+W/FgGsuHkZvkj5gO0Kvuo566Y4eURP8AGJXkw8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxjtvn3oX7aPmFnVUWYDyfR/WI0tvRJvdQllB7UyBFzibWT8OgSWYo9VvrL3paZGUa+RHS12myaP0HHMrwnuPA28GEjy+06LqmNBx+cRY3fQh9GxHKdARZVeUglNMEuKBs3ewUp9tM0YpXxOHwmj1/iQwbMeh8P2IbUfEcUCJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpRwHd3M; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c84dcc64so1923949f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725394777; x=1725999577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dxhImONyEM0H234+MymixAwq0xEenMCNxBhOMsSgdI=;
        b=CpRwHd3M8fWVhHAxiMNnqBUpjc0DkSp8Cs1GMwMVDUMm5cFWIA9+lwf0dckP4mn21E
         8ZIdAhB76S+v1LpqdUHKKouMckj+70UgZB7vtkVLF04ri4AnIjsgbmxw5vEQZTjNyhh/
         s+1VIzKYYGHLYeVMjOI8dy92s9z00GtAKTDlEQi4kviiMRaFRN5QDulSwOH+Qi2JlL9y
         T4di0pnCLMcdZahkeyF4uhVrVxniMrC7Ql6acXe+3oCwAjqtJS0ChCVyOYflPSCXHRLe
         lKbahfU5PBeO5un8IrpbUKCJwEs70vEvJQwzsGeDOmHQ/HkdvRVWPDJQZLBavGRkJTGl
         aNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725394777; x=1725999577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dxhImONyEM0H234+MymixAwq0xEenMCNxBhOMsSgdI=;
        b=H6gw8bUJGEGfOQ9dtidrQtvsb2mUhCrpene0wf4h0ByH3YWO9secjKFNSNCPTwH0X4
         XVcvJCvMaLZGDstaul1+8tiExMlBWBYPTNUlABiMo+wMv4WLNkMPhbkyJlp2k4Dh5TzU
         8iQ1SVe2vclGxUbPlV0KWtU+OmQ7EwnlMvJNscYitKjMtfWNSdGRiDvm8n18qtN4fJ0f
         hzcFdzSUrMGW4xeEr+tFZJ/8BH1Y+wUDtvA+YyzuuniSsdXf+hyG+wmkrh95re64nUB5
         qpUJzJEoZu0MAbH76oKoXOSWiL4goPgsYVAs1UpHjBEVXlNpPBqHSS9MFGV7RGmzdH8u
         w+yA==
X-Forwarded-Encrypted: i=1; AJvYcCU5q/txCxkGr2hBkuBMCPT+ObBCbNYdf2JYzi0INgF7TSKcD7DdrokE6JRppySjqqJ5wPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrL82JWHdBm7IafHRi2+NEAnmRSxkrb7srOxwvIil9PhAX3NQ
	iJPXJX1drs/P8GCf32zgVsbq2eY8PWS88RH8+yYH/TwPDF/hkAy6CUG13y2wo+WQqANbiVQoab+
	Uc5VAKvnLmjWHs4P5G7vYSSTLzww=
X-Google-Smtp-Source: AGHT+IHfaGCHHIORswC8G3UaqgzslVa+TRs2sFR6eps9zQik1JQ6bgqG10pnAEK5tq/tcok5Bj0PR4et4DT94x3ntp8=
X-Received: by 2002:adf:f608:0:b0:374:c05f:2313 with SMTP id
 ffacd0b85a97d-374c05f2775mr8345323f8f.45.1725394777137; Tue, 03 Sep 2024
 13:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725016029.git.vmalik@redhat.com> <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
 <3adea7f7-0e8d-4114-ba04-356cdf9d20d1@redhat.com>
In-Reply-To: <3adea7f7-0e8d-4114-ba04-356cdf9d20d1@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Sep 2024 13:19:26 -0700
Message-ID: <CAADnVQLmo0sOCuF598nL_xoowMDwTEXzjHareG1xiWGPLM77qA@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
To: Viktor Malik <vmalik@redhat.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 10:57=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 9/2/24 19:01, Alan Maguire wrote:
> > On 02/09/2024 07:58, Viktor Malik wrote:
> >> TL;DR
> >>
> >> This adds libbpf support for creating multiple BPF programs having the
> >> same instructions using symbol aliases.
> >>
> >> Context
> >> =3D=3D=3D=3D=3D=3D=3D
> >>
> >> bpftrace has so-called "wildcarded" probes which allow to attach the
> >> same program to multple different attach points. For k(u)probes, this =
is
> >> easy to do as we can leverage k(u)probe_multi, however, other program
> >> types (fentry/fexit, tracepoints) don't have such features.
> >>
> >> Currently, what bpftrace does is that it creates a copy of the program
> >> for each attach point. This naturally results in a lot of redundant co=
de
> >> in the produced BPF object.
> >>
> >> Proposal
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> One way to address this problem would be to use *symbol aliases*. In
> >> short, they allow to have multiple symbol table entries for the same
> >> address. In bpftrace, we would create them using llvm::GlobalAlias. In
> >> C, it can be achieved using compiler __attribute__((alias(...))):
> >>
> >>     int BPF_PROG(prog)
> >>     {
> >>         [...]
> >>     }
> >>     int prog_alias() __attribute__((alias("prog")));
> >>
> >> When calling bpf_object__open, libbpf is currently able to discover al=
l
> >> the programs and internally does a separate copy of the instructions f=
or
> >> each aliased program. What libbpf cannot do, is perform relocations b/=
c
> >> it assumes that each instruction belongs to a single program only. The
> >> second patch of this series changes relocation collection such that it
> >> records relocations for each aliased program. With that, bpftrace can
> >> emit just one copy of the full program and an alias for each target
> >> attach point.
> >>
> >> For example, considering the following bpftrace script collecting the
> >> number of hits of each VFS function using fentry over a one second
> >> period:
> >>
> >>     $ bpftrace -e 'kfunc:vfs_* { @[func] =3D count() } i:s:1 { exit() =
}'
> >>     [...]
> >>
> >> this change will allow to reduce the size of the in-memory BPF object
> >> that bpftrace generates from 60K to 9K.
> >>
> >> For reference, the bpftrace PoC is in [1].
> >>
> >> The advantage of this change is that for BPF objects without aliases, =
it
> >> doesn't introduce any overhead.
> >>
> >
> > A few high-level questions - apologies in advance if I'm missing the
> > point here.
> >
> > Could bpftrace use program linking to solve this issue instead? So we'd
> > have separate progs for the various attach points associated with vfs_*
> > functions, but they would all call the same global function. That
> > _should_ reduce the memory footprint of the object I think - or are
> > there issues with doing that?
>
> That's a good suggestion, thanks! We added subprograms to bpftrace only
> relatively recently so I didn't really think about this option. I'll
> definitely give it a try as it could be even more efficient.
>
> > I also wonder if aliasing helps memory
> > footprint fully, especially if we end up with separate copies of the
> > program for relocation purposes; won't we have separate copies in-kerne=
l
> > then too? So I _think_ the memory utilization you're concerned about is
> > not what's running in the kernel, but the BPF object representation in
> > bpftrace; is that right?
>
> Yes, that is correct. libbpf will create a copy of the program for each
> symbol in PROGBITS section that it discovers (including aliases) and the
> copies will be loaded into kernel.
>
> It's mainly the footprint of the BPF object produced by bpftrace that I
> was concerned about. (The reason is that we work on ahead-of-time
> compilation so it will directly affect the size of the pre-compiled
> binaries). But the above solution using global subprograms should reduce
> the in-kernel footprint, too, so I'll try to add it and see if it would
> work for bpftrace.

I think it's a half solution, since prog will be duplicated anyway and
loaded multiple times into the kernel.

I think it's better to revive this patch sets:

v1:
https://lore.kernel.org/bpf/20240220035105.34626-1-dongmenglong.8@bytedance=
.com/

v2:
https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglong.8@bytedan=
ce.com/

Unfortunately it went off rails, because we went deep into trying
to save bpf trampoline memory too.

I think it can still land.
We can load fentry program once and attach it in multiple places
with many bpf links.
That is still worth doing.

I think it should solve retsnoop and bpftrace use cases.
Not perfect, since there will be many trampolines, but still an improvement=
.

