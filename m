Return-Path: <bpf+bounces-17433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B180DA95
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E241F1C216F6
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D14F524BD;
	Mon, 11 Dec 2023 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4ODy+Os"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3409B
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:09:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3335397607dso5455109f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702321752; x=1702926552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/lc4HMpq98kucR5uqvamjrVU33nMccQN3znljsg+tI=;
        b=m4ODy+OsHysOTERNcCUTmB/RhdhBsLEnvhVkSOT9UHbMpOwM+yqzhuy5fOJxi3EboF
         nnakR2TKCikiYGBgkbLWDpXNEnzRiNpYKkiZH8+5w0F7kjnCLlTChowfFvPVKNa5TspO
         feFr2WuX7+wXbnO7YlMVUGMDOHXcqL5/YnOWBzM5nu7H1L8wx2XaxoTyMI+8ecfwUDEI
         HzyM6YxYBgJh2s5dHybR6tMcOjYJQO/B/FS27xCAx/omGsFlTQtRjUf8tVXtNr5Mi8+0
         zWica3persX18PsJCELiwf8Mk2etax8nfNKxbEeZL6Urc8pFt86cs0z5ODxoXwLbBytB
         I8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321752; x=1702926552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/lc4HMpq98kucR5uqvamjrVU33nMccQN3znljsg+tI=;
        b=Kyf7+OuPsh2VwBTajn/bHya7Y4l4ZXdkVTyJI68kpgODiHUkuuSTc6Z0W2DaF8ol1/
         KOO2qe8I5J40UmmASiCzvXeV+OUTneVJdcP+lRMpP8looao+FajWuPEjzUoX+RWve8a8
         eUN0AFe+eDENfjSsStwjG8Ecqnt4zCsU9RAhKaPUpGcvf/Hlmc/uwTxDdG4L42zdrDTd
         PjxUp2yIJnOuRlvb2fXDBS/kmS90ihpBIv1rLIuIt0X7bQmgMYslTDEXHYuYKVCep4F+
         LqyhuCqGPrDQdDsqvQp+UvSuhE1tlfdiXXZPoNW0YCrbKnFUBVfwanOpd+x6O+Cysocz
         npaQ==
X-Gm-Message-State: AOJu0Ywvl0xOpAppEGRCk3zNlBFB8Se5Q8i8b5xsYg6vDEwsqr1uqwt8
	a8+NYRGpMqijGiDAlqexgVEo0GkBv1bL01FLRZg=
X-Google-Smtp-Source: AGHT+IFn3tTo+HlUuFs4pAUt2Yg99jlJ0ismZf50Vgq0A38cCXeqX+NPNolemdvzJS0pf5wfD6SDvMV9rPmAsrnM+P4=
X-Received: by 2002:a05:6000:44:b0:333:3c19:d3d2 with SMTP id
 k4-20020a056000004400b003333c19d3d2mr2340168wrx.31.1702321751681; Mon, 11 Dec
 2023 11:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141030.1478753-7-aspsk@isovalent.com> <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5> <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev> <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev> <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev> <ZXdHc7xoAVf1g4a9@zh-lab-node-5>
In-Reply-To: <ZXdHc7xoAVf1g4a9@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Dec 2023 11:08:59 -0800
Message-ID: <CAADnVQLvduKOxNWgruC0TUOzxVVg-Bp8RButfN9nWgQ_DdCC2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 9:34=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
>
> This looks for me that two bits aren't enough, and the third is
> required, as the second bit seems to be overloaded:
>
>   * bit 1 indicates that this is a "JA_MAYBE"
>   * bit 2 indicates a jump or nop (i.e., the current state)
>
> However, we also need another bit which indicates what to do with the
> instruction when we issue [an abstract] command
>
>   flip_branch_on_or_off(branch, 0/1)
>
> Without this information (and in the absense of external meta-data on
> how to patch the branch) we can't determine what a given (BPF, not
> jitted) program currently does. For example, if we issue
>
>   flip_branch_on_or_off(branch, 0)
>
> then we can't reflect this in the xlated program by setting the second
> bit to jmp/off. Again, JITted program is fine, but it will be
> desynchronized from xlated in term of logic (some instructions will be
> mapped as NOP -> x86_JUMP, others as NOP -> x86_NOP).

Not following the need for the 3rd bit.
The 2nd bit is not only the initial state, but the current state too.

when user space does static_branch_enable it will set the 2nd bit to 1
(if it wasn't set) and will text_poke_bp the code.
xlated will be always in sync with JITed.
No ambiguity.

An annoying part is that bpf insn stream is read only, so we cannot
really write that 2nd bit. We can virtually write it.
Seeing nop or jmp in JITed code would mean the bit is 0 or 1.
So xlated dump will report it.

Separately the kernel doesn't have static_branch_switch/flip command.
It's only enable or disable. I think it's better to keep it the same way.

