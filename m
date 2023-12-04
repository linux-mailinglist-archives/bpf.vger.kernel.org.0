Return-Path: <bpf+bounces-16651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710DE8041BA
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF871C20C28
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142736B15;
	Mon,  4 Dec 2023 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Rdn8NZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970FA1
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 14:32:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3331752d2b9so3783863f8f.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 14:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701729169; x=1702333969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/jAeDFKwrjPRn8dh27zol5V1+RirID9c+/vbKKjrpg=;
        b=V9Rdn8NZU54Dyt7/vkfbRkwyywfdJcvaMFVHiw4v329uKjwC0i8B6SvWm86lmJyoIA
         /QD4OMJGqR9rYFqhXWlJNnKXfiDiZoZHYSj1Vu6WAo8IJ0OwWTaUtlAuIAolQ9sWRev9
         BD9ZlG3qNM3wqS1TzuOrtVGeH2MtZecn3KShlh8d2OVLQqIiQTazXf66Hm82JBYwUYz/
         6mx1b6Dt7L2ewiFneSoP/00aKSOzaHeTJPVSthDyzXDwryaoLelSYfSnFyoCULzRcojb
         s3wY6cDv2Obnya6nkupffxoJ52Kf1kZ3KNMn1ifMd6HMIYXmyySDcMHw5IwfoReFvqAs
         48Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701729169; x=1702333969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/jAeDFKwrjPRn8dh27zol5V1+RirID9c+/vbKKjrpg=;
        b=Q674aRDTvc9IE93ajnDo2+IFDLoE+pSD+iMAcdecvi3t3ZQGVEigccm8yury88nQlp
         OZsluDzYv1brptFek3J7IM7VVXH/+GeFyq8tfdFOWcRAfjORjwkAGwZuJTD+xmqMalWX
         1eOjRyDKnhSZW/jfXOIqarU42iMxPGWshD24AyiI97N04nOf+p3QnTlKyMIIeQi4Pgy2
         DtNt3+WYqMswiSwq9F+Pye9cwjk8rwnJOZHoxDnWFg/RW/xS0aITNVD7Km6ujd+2Mqk7
         czOYCgWV13ksHa9MQo+PcXg2kxdUEQdT8yHxNTmDJolgOG62SBUgG/Cu/KIi2ntyRrQM
         Ummg==
X-Gm-Message-State: AOJu0YxS1GS6R+XGgvnNgEH+oqeUGK/2gNYnw0ZLivEFhTUGOkLE7lZU
	wWNC9zPLnxcpOKrm8mJlEtC7bQc1KJ3xqEWr+nA=
X-Google-Smtp-Source: AGHT+IE8uEjt3bgeZU06aymzRSB/f+ydQr5HXLsK8PCFiglongkV/7Vv6rqX52o124YEEBJH5eO8HFg+xK/1Js9a8n0=
X-Received: by 2002:adf:f9c7:0:b0:333:39f6:b3d0 with SMTP id
 w7-20020adff9c7000000b0033339f6b3d0mr2666164wrr.114.1701729168955; Mon, 04
 Dec 2023 14:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org>
In-Reply-To: <20231204192601.2672497-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 14:32:37 -0800
Message-ID: <CAEf4BzaqWDNUyWzwSM6ZyZXcVuE10HZ6ryaZQ05wPY-0spb+aw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/10] Complete BPF verifier precision
 tracking support for register spills
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:26=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add support to BPF verifier to track and support register spill/fill to/f=
rom
> stack regardless if it was done through read-only R10 register (which is =
the
> only form supported today), or through a general register after copying R=
10
> into it, while also potentially modifying offset.
>
> Once we add register this generic spill/fill support to precision
> backtracking, we can take advantage of it to stop doing eager STACK_ZERO
> conversion on register spill. Instead we can rely on (im)precision of spi=
lled
> const zero register to improve verifier state pruning efficiency. This
> situation of using const zero register to initialize stack slots is very
> common with __builtin_memset() usage or just zero-initializing variables =
on
> the stack, and it causes unnecessary state duplication, as that STACK_ZER=
O
> knowledge is often not necessary for correctness, as those zero values ar=
e
> never used in precise context. Thus, relying on register imprecision help=
s
> tremendously, especially in real-world BPF programs.
>
> To make spilled const zero register behave completely equivalently to
> STACK_ZERO, we need to improve few other small pieces, which is done in t=
he
> second part of the patch set. See individual patches for details. There a=
re
> also two small bug fixes spotted during STACK_ZERO debugging.
>
> The patch set consists of logically three changes:
>   - patch #1 (and corresponding tests in patch #2) is fixing/impoving pre=
cision
>     propagation for stack spills/fills. This can be landed as a stand-alo=
ne
>     improvement;
>   - patches #3 through #9 is improving verification scalability by utiliz=
ing
>     register (im)precision instead of eager STACK_ZERO. These changes dep=
end
>     on patch #1.
>   - patch #10 is a memory efficiency improvement to how instruction/jump
>     history is tracked and maintained. It depends on patch #1, but is not
>     strictly speaking required, even though I believe it's a good long-te=
rm
>     solution to have a path-dependent per-instruction information. Kind
>     of like a path-dependent counterpart to path-agnostic insn_aux array.
>
> v2->v3:
>   - BPF_ST instruction workaround (Eduard);

ok, so I fixed this in the main partial_stack_load_preserves_zeros
test, but there is at least spill_subregs_preserve_stack_zero that
needs fixing as well. I'll audit all the tests thoroughly and will fix
all BPF_ST uses.

Eduard or Yonghong, what's the Clang version that does support BPF_ST
instructions in inline asm? When would we be able to just assume those
instructions are supported?

>   - force dereference in added tests to catch problems (Eduard);
>   - some commit message massaging (Alexei);
> v1->v2:
>   - clean ups, WARN_ONCE(), insn_flags helpers added (Eduard);
>   - added more selftests for STACK_ZERO/STACK_MISC cases (Eduard);
>   - a bit more detailed explanation of effect of avoiding STACK_ZERO in f=
avor
>     of register spill in patch #8 commit (Alexei);
>   - global shared instruction history refactoring moved to be the last pa=
tch
>     in the series to make it easier to revert it, if applied (Alexei).
>
> Andrii Nakryiko (10):
>   bpf: support non-r10 register spill/fill to/from stack in precision
>     tracking
>   selftests/bpf: add stack access precision test
>   bpf: fix check for attempt to corrupt spilled pointer
>   bpf: preserve STACK_ZERO slots on partial reg spills
>   selftests/bpf: validate STACK_ZERO is preserved on subreg spill
>   bpf: preserve constant zero when doing partial register restore
>   selftests/bpf: validate zero preservation for sub-slot loads
>   bpf: track aligned STACK_ZERO cases as imprecise spilled registers
>   selftests/bpf: validate precision logic in
>     partial_stack_load_preserves_zeros
>   bpf: use common instruction history across all states
>
>  include/linux/bpf_verifier.h                  |  42 ++-
>  kernel/bpf/verifier.c                         | 297 +++++++++++-------
>  .../selftests/bpf/progs/verifier_spill_fill.c | 124 ++++++++
>  .../bpf/progs/verifier_subprog_precision.c    |  87 ++++-
>  .../testing/selftests/bpf/verifier/precise.c  |  38 ++-
>  5 files changed, 435 insertions(+), 153 deletions(-)
>
> --
> 2.34.1
>

