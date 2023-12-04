Return-Path: <bpf+bounces-16670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025C8042E5
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF58C2813D7
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415939FFE;
	Mon,  4 Dec 2023 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU09mGH/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91291FF
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:52:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1a5772b8a5so371135166b.1
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701733975; x=1702338775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKkvLFeALdssMzerNXn5j3sWAw/Ws2kEiIgO9bdxh3c=;
        b=cU09mGH/DXPJOlJBrGZTqrMbTBZS3s95gN29jn8TrL/ZUCY/8PyXugRRNxYPqdm5cR
         MLP5stcbFCQQMUWdQvluel8AzTO9ygsqwTkndJTEfHBlepMVfsUr4d6ze44OTgL1Dk7P
         i9mFCF9+1F2I985Z5KGCkSPsUhEejc+T6mpJTv3igkvqi3TXDFh2u/A++7QwbsBPS+TG
         8RrK5ul+opK098hQyMPZQdT/U4nS10DDnmUCqPoSXmgWDCRbZOSMDFXtBYqKc4Urz3PR
         VQEamQA1VGTfP50tRaVXw71lqnIoPNAg4buXWNeeaAWpiAzXwj3HrdhFZaUIYB3yISpw
         KSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733975; x=1702338775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKkvLFeALdssMzerNXn5j3sWAw/Ws2kEiIgO9bdxh3c=;
        b=raZCqJ97SAx+Jla2j5ScOyeDrsEbQzyVdxkbeiNbAOQWYSjnBh69Iep5JMHkYfQI14
         SszAZ6xJPR1HAxHNeuf38VhduByufBX+WPpxjy3pM5iwumSBzURgE9UsPelyNABEZ8KE
         Vw1mSJAOSatRDd+qPl94CofMzQMV5qXCq2udIiMsrsnTmc66JH54p7vj/TKu9Gk3spjM
         kPwlnA8pZiv9nqUIv09NPAKJwdJwMFrOXg1Uk7xTdOcHixDw/GH0cyOcpLJqFL+HABnG
         tN0CU+sBM8tRJJ8LJeChuFXlnaWCoN7d1YmEviLU8s+VXhMPsYMzA2VE1PKpEsAOY/fo
         Z3ZA==
X-Gm-Message-State: AOJu0YzgOTuUqUjct25zjsVV0cDKypouUPfS0rnb3TrrpxWUwMLRdO/b
	0FZNI+G1ne115qSS6lU9FJi1g1hZFAr7DxhjroY=
X-Google-Smtp-Source: AGHT+IEHQlo2JpFalAX0PyQFaR/4Lir6FlgJDTUxV9/yPq2Cq4g55ZkA63jpNJ53O2UaNv7iO6hLS9dP13hj3UzLI5o=
X-Received: by 2002:a17:906:33ce:b0:a19:a19b:78c2 with SMTP id
 w14-20020a17090633ce00b00a19a19b78c2mr3778007eja.133.1701733974663; Mon, 04
 Dec 2023 15:52:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org> <CAEf4BzaqWDNUyWzwSM6ZyZXcVuE10HZ6ryaZQ05wPY-0spb+aw@mail.gmail.com>
 <7de7f58a-5d98-4a72-892b-368559fdc581@linux.dev>
In-Reply-To: <7de7f58a-5d98-4a72-892b-368559fdc581@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 15:52:41 -0800
Message-ID: <CAEf4BzZJzzT_y-Yy=rKjX4mNceJSeGMdNwuc2+5doQAksXusjQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/10] Complete BPF verifier precision
 tracking support for register spills
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:02=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 12/4/23 5:32 PM, Andrii Nakryiko wrote:
> > On Mon, Dec 4, 2023 at 11:26=E2=80=AFAM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> >> Add support to BPF verifier to track and support register spill/fill t=
o/from
> >> stack regardless if it was done through read-only R10 register (which =
is the
> >> only form supported today), or through a general register after copyin=
g R10
> >> into it, while also potentially modifying offset.
> >>
> >> Once we add register this generic spill/fill support to precision
> >> backtracking, we can take advantage of it to stop doing eager STACK_ZE=
RO
> >> conversion on register spill. Instead we can rely on (im)precision of =
spilled
> >> const zero register to improve verifier state pruning efficiency. This
> >> situation of using const zero register to initialize stack slots is ve=
ry
> >> common with __builtin_memset() usage or just zero-initializing variabl=
es on
> >> the stack, and it causes unnecessary state duplication, as that STACK_=
ZERO
> >> knowledge is often not necessary for correctness, as those zero values=
 are
> >> never used in precise context. Thus, relying on register imprecision h=
elps
> >> tremendously, especially in real-world BPF programs.
> >>
> >> To make spilled const zero register behave completely equivalently to
> >> STACK_ZERO, we need to improve few other small pieces, which is done i=
n the
> >> second part of the patch set. See individual patches for details. Ther=
e are
> >> also two small bug fixes spotted during STACK_ZERO debugging.
> >>
> >> The patch set consists of logically three changes:
> >>    - patch #1 (and corresponding tests in patch #2) is fixing/impoving=
 precision
> >>      propagation for stack spills/fills. This can be landed as a stand=
-alone
> >>      improvement;
> >>    - patches #3 through #9 is improving verification scalability by ut=
ilizing
> >>      register (im)precision instead of eager STACK_ZERO. These changes=
 depend
> >>      on patch #1.
> >>    - patch #10 is a memory efficiency improvement to how instruction/j=
ump
> >>      history is tracked and maintained. It depends on patch #1, but is=
 not
> >>      strictly speaking required, even though I believe it's a good lon=
g-term
> >>      solution to have a path-dependent per-instruction information. Ki=
nd
> >>      of like a path-dependent counterpart to path-agnostic insn_aux ar=
ray.
> >>
> >> v2->v3:
> >>    - BPF_ST instruction workaround (Eduard);
> > ok, so I fixed this in the main partial_stack_load_preserves_zeros
> > test, but there is at least spill_subregs_preserve_stack_zero that
> > needs fixing as well. I'll audit all the tests thoroughly and will fix
> > all BPF_ST uses.
> >
> > Eduard or Yonghong, what's the Clang version that does support BPF_ST
> > instructions in inline asm? When would we be able to just assume those
> > instructions are supported?
>
> For inline asm, llvm18.
> For C->asm codegen, llvm18 + cpu=3Dv4.

Well, I think we'll have to wait for the official llvm18 release then,
before we can assume it in selftests. :(

>
> [...]
>

