Return-Path: <bpf+bounces-17309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB7B80B203
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 05:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C23B20B86
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 04:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B81386;
	Sat,  9 Dec 2023 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze8aVUeU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC5FC
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 20:25:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3332efd75c9so2557250f8f.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 20:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702095954; x=1702700754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtLh3s0JNsb4F+czlZFIdPA6Tdp9QIlxjmiMeDQQIbM=;
        b=Ze8aVUeUF3tXN88uOFJEvECyTcBqW7nM23KWX+HnNwC/tvHPrsyKwowR19bjBqn7ox
         dvL3iL6Tu7kB2GijhzlVYvegjUbLLGweKW3drlbzrj1UYxmyfU1E5ZaWfLg1R50xpxdw
         gL+Vmo8cFIub2a1Sp9/cl3ZV2Gqvj4KR4dFE99zk/8XlWa1bAewucA15tIiOcZ51XNr0
         hfxAGQdW0Pwqn8K5oZBJDvNptjx3qkk5NbQ3ZL6cfxZp+Lyrsq0zYASyOtkz52vrnZYT
         zzplM3Ef8agXICyTKRyhtQKO53psIgmt8gaCyoyZXXNM9ALhyYGmqRs/ViLMwN+MqEm9
         Vg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702095954; x=1702700754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtLh3s0JNsb4F+czlZFIdPA6Tdp9QIlxjmiMeDQQIbM=;
        b=KYGOZjqBNCbvO6peYw+0jVKqHzAq4uActigBg7A5PUIijMwqa29C9YnS3SlkUDvxQl
         bMyoTd6KmPbm0hhhXrqClcKPOU/C6yejP+7TmWCyCTn6zzhPX0IrGdQaTRj9033i+Mbl
         rWlWadugoeL2qvV6Z/zulZJ5QwKellRedagdrPaz5RbZa24hphUQRhSdldh2i6x2agy5
         aoIiBK98RGs3ZQDV6lkm8sNGf1A9xiyNy+D6iCoqJu4SjOJ+EhjbD7kGhkSDK8LVjtyB
         EjnVR3qDjFTdX/Rmek7UmtC3rcUTO6lQHh+j13KSpuROOb4/30qzC3bRVlD0ClUzlmR0
         VFbw==
X-Gm-Message-State: AOJu0YyRwyrYYTo8+8bT3hiES9Tr2iDokhKlIUyiuBsz0gYqYxGtqMyc
	Qp3wj2M9Ylso27eGfdfCwxiWvSPveRngsODOVK4=
X-Google-Smtp-Source: AGHT+IHDBbbMrlccf0EibMDLO3eDmePhJtmnRh0KYE+lTrivHHo+PAdyZkr3h0nRNdGrML2sECFqL/1Ad1UALFVriJQ=
X-Received: by 2002:adf:f04b:0:b0:333:3ca1:f867 with SMTP id
 t11-20020adff04b000000b003333ca1f867mr222207wro.77.1702095954089; Fri, 08 Dec
 2023 20:25:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141030.1478753-1-aspsk@isovalent.com> <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5> <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com> <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
In-Reply-To: <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 20:25:42 -0800
Message-ID: <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Anton Protopopov <aspsk@isovalent.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:15=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 12/8/23 8:05 PM, Alexei Starovoitov wrote:
> > On Fri, Dec 8, 2023 at 2:04=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> I feel like embedding some sort of ID inside the instruction is very..
> >> unusual, shall we say?
> > yeah. no magic numbers inside insns pls.
> >
> > I don't like JA_CFG name, since I read CFG as control flow graph,
> > while you probably meant CFG as configurable.
> > How about BPF_JA_OR_NOP ?
> > Then in combination with BPF_JMP or BPF_JMP32 modifier
> > the insn->off|imm will be used.
> > 1st bit in src_reg can indicate the default action: nop or jmp.
> > In asm it may look like asm("goto_or_nop +5")
>
> How does the C source code looks like in order to generate
> BPF_JA_OR_NOP insn? Any source examples?

It will be in inline asm only. The address of that insn will
be taken either via && or via asm (".long %l[label]").
From llvm pov both should go through the same relo creation logic. I hope :=
)

