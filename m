Return-Path: <bpf+bounces-28454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D68B9E1E
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606EA1C235D3
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BCC15CD68;
	Thu,  2 May 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxfbb9xQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560615991E;
	Thu,  2 May 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665820; cv=none; b=bzHdhpDqRilOGKp5NhwLEZzFeJki/QlmzRjsGTSPaeyC8JkRv3X4V2w9cznq7SRiMC0MqrIsQ81Q5DzDOf4Yat0xhUZriZ7phFhkpDp49hhdGi2i+ceUSgSDYgOaqWyQg7XKHsrdoCQ9m1vSjIL7CAFl2bQ/qxtf4IBCQQfn+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665820; c=relaxed/simple;
	bh=S7/7O0n+vUyUk5xX4mp2yNkpzOYG4Xh+uIZv4+lFL18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2NdRhDGGaCyl8whYyhx+jLCJ1k9e5Lj/Cm6UkVki7kzrG+dNYulh+bsfSP8M2TYGfuT3w4f4QNih5XfxuquihDaZsjdYojDqN5zW9tMhGLgFeRhRC9sPAe5KD40EO8aPbzuNTEAa4gnjnXD6pDKO8QW2HoxdYSEnxpivHT8XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxfbb9xQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-61be599ab77so125544a12.1;
        Thu, 02 May 2024 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714665819; x=1715270619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAQxuUgTDSs7P51keSTZK2/Vp77QRp7hznvGymhP8aw=;
        b=kxfbb9xQROUE2hDwlOxKg7B+9/Mr2B8MWgb1Ufn1GZGjhRg4AwBU4jWp1vXddZGuYu
         o8yQyvPErCRp37z5TGksK4YmyURqHUaEEtAVbmAjR355s6Hc1JSnajTLtuI7x++T+/p+
         QhgEQk3AcFDlcCz3Iq6O6uIbs3Akfghps9rFl2w3df89eMr754ukX3PPS0v5UAhqZsWU
         /QJtPlEqmJCHjNL2dlMPz1a9ajn+SqdPDdH1aatgLftJiMFNX0HP/xN0Oz3ZnHTbBpxb
         /b0Vzyit7+ufaYbMBhkfPdURVIcLo/hI3tdhiq0nHmjlOpf4wI8cfZ2hI18pR5TT2Z6J
         6wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665819; x=1715270619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAQxuUgTDSs7P51keSTZK2/Vp77QRp7hznvGymhP8aw=;
        b=NGD/xCQ21Ykx2NZj+Rti9ISi3W/dAfu8odM+CbYL0T5GELNY5GRfancqxkfaemqtmg
         odnRjhGBtc7LcrK2VwRd89/jyvFu8ZjqVB4hhmIKX9yxOoZ0DV+11E2+1Vqa7ZBe8hd8
         ulhT9Dvn5AJWhy4Mg4TTy9PWZTZyra5F3aF/CwFqJ5hTl1RK8ZgzXQRDiLNcIb3kDUoB
         Sf30NbNqQ96n58NuU9OImvpJ1W9sRLlcLvzBeQ5TzQ9BlYBVplUdzhlX32P4AwTOV5QX
         JOvyubQezTZyrZHlw6I+Ui9fjQ1OOv18Q8zkBUnvBx5m0O56r/P5LoRE6BZkuXqkRhWO
         4kQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3s6qZAkRvXdwWQ4pYkV5p+fNhYM3LUFy43D1su54PzQdLIKS9EX7I7v7ZePZjYh7n1VJBAQq7D8q7furqdVqX2gGuh3sF8nDblFNhO706MUVS1bTP+AkoakEko3vbkO70
X-Gm-Message-State: AOJu0Yz3SnsHm9nYyebd4DhTIOcPezTloDQC4eSnKdTQ432H341wn1y6
	yitXmDY/AYfbo0ZEoDPQvX43KjyfpIrELTIRAtGcaXsaJzoVLbCltFGDMMvmzB/V/QrPNFLAxGU
	zJVjP+u9FgMfuf1qOYORT6qfPQnw=
X-Google-Smtp-Source: AGHT+IEBwiLi8Ts2gfPfvH/pwb6ep1VySneCkF0yDEYPJ5kxpKt4+M5rbi68A5q1GE15OILzhKjzLax6wr3vdOUwREU=
X-Received: by 2002:a17:90a:6fc4:b0:2b3:28df:91e1 with SMTP id
 e62-20020a17090a6fc400b002b328df91e1mr205916pjk.10.1714665818449; Thu, 02 May
 2024 09:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430175834.33152-1-puranjay@kernel.org> <20240430175834.33152-3-puranjay@kernel.org>
 <CAEf4Bzb4FYVNjuoghCcDxLgQCOT9Mb=nbjgNktqDarPHkOsuog@mail.gmail.com> <mb61pcyq45p6j.fsf@kernel.org>
In-Reply-To: <mb61pcyq45p6j.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 May 2024 09:03:26 -0700
Message-ID: <CAEf4Bza5ZRhX51oK-rVwoHnoy7mMn1EMW5P+cczZp3arcHdeyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] riscv, bpf: inline bpf_get_smp_processor_id()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 6:16=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Tue, Apr 30, 2024 at 10:59=E2=80=AFAM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
> >>
> >> Inline the calls to bpf_get_smp_processor_id() in the riscv bpf jit.
> >>
> >> RISCV saves the pointer to the CPU's task_struct in the TP (thread
> >> pointer) register. This makes it trivial to get the CPU's processor id=
.
> >> As thread_info is the first member of task_struct, we can read the
> >> processor id from TP + offsetof(struct thread_info, cpu).
> >>
> >>           RISCV64 JIT output for `call bpf_get_smp_processor_id`
> >>           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>                 Before                           After
> >>                --------                         -------
> >>
> >>          auipc   t1,0x848c                  ld    a5,32(tp)
> >>          jalr    604(t1)
> >>          mv      a5,a0
> >>
> >
> > Nice, great find! Would you be able to do similar inlining for x86-64
> > as well? Disassembling bpf_get_smp_processor_id for x86-64 shows this:
> >
> > Dump of assembler code for function bpf_get_smp_processor_id:
> >    0xffffffff810f91a0 <+0>:     0f 1f 44 00 00  nopl   0x0(%rax,%rax,1)
> >    0xffffffff810f91a5 <+5>:     65 8b 05 60 79 f3 7e    mov
> > %gs:0x7ef37960(%rip),%eax        # 0x30b0c <pcpu_hot+12>
> >    0xffffffff810f91ac <+12>:    48 98   cltq
> >    0xffffffff810f91ae <+14>:    c3      ret
> > End of assembler dump.
> > We should be able to do the same in x86-64 BPF JIT. (it's actually how
> > I started initially, I had a dedicated instruction reading per-cpu
> > memory, but ended up with more general "calculate per-cpu address").
>
> I feel in x86-64's case JIT can not do a (much) better job compared to th=
e
> current approach in the verifier.

This direct memory read (using gs segment) ought to be a bit faster
than calculating offset and then doing memory dereference, but yes,
the difference won't be as big as you got with RISC-V and ARM64. Ok,
never mind, we can always benchmark and add that later, no big deal.

>
> On RISC-V and ARM64, JIT was able to do it better because both of these
> architectures save a pointer to the task struct in a special CPU
> register. As x86-64 doesn't have enough extra registers, it uses a
> percpu variable to store task struct, thread_info, and the cpu
> number.
>
> P.S. - While doing this for BPF, I realized that ARM64 kernel code is
> also not optimal as it is using the percpu variable and is not reading
> the CPU register directly. So, I sent a patch[1] to fix it in the kernel
> and get rid of the per-cpu variable in ARM64.
>
>
> [1] https://lore.kernel.org/all/20240502123449.2690-2-puranjay@kernel.org=
/
>
> > Anyways, great work, a small nit below.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks,
> Puranjay

