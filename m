Return-Path: <bpf+bounces-14735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D877E7982
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FAC2817E2
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED11FAB;
	Fri, 10 Nov 2023 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePD0k6H/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7B63BC
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:45:57 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15AA7D95
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:45:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso2389330e87.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699598754; x=1700203554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+/47ypaQ7iy++mSetffFvL9xB84wT+XjQE6n2YN7Rw=;
        b=ePD0k6H/M5wrNNvPe5eQV2ft7KQl/3qamaOwCByxpG32M2U+PPvRbaW7PmgpA9P8xp
         /SRqGa3PpQJjt8Qa2ZHc/lyRqrmNTrOkCbrLH5ye0C345GaoH4t7unCxir6ITHceJGSY
         vL1B6mB1NQqvQSOJP56fHYXys2KyHTIICnqBlc7ofM/vLxBJdWtyDzVBrX9oa+5CLCeN
         FrnmhyaaKr0bXGksEmG9tv5bFN6XsdDmMg4fpZTKUh2E7GXeHjtNREdQdJTNHFP4Kh99
         FbTGijc/BJTh03y3o0sUYl0iZzwgwFk53f0bQSI7ZbDy4V9MPFgiA6/SmqTDPuvQgK6f
         ZoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598754; x=1700203554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+/47ypaQ7iy++mSetffFvL9xB84wT+XjQE6n2YN7Rw=;
        b=wlN+vcfSqxXkEpYfmdDhf+2uvDb3rKKwEYpELP0An0A0PLgg7CVm7bbc8hpYEKCC4g
         4tgDgcJt9MPI1NF4wMU+HRW+ZkWs5DJw2dUfytQI/HNg3tb6p+YKSS/PnwTb8ztJG1KZ
         5q7uy7J6lbx/O4WAq7h/5X/Y8bPZzARhDCv3GIX5oDrLFU2xi7DHAUe7CQMKB4tKewlT
         gNCH32RSjJzMQ37vtaXgxCgZN+fJADybOS14ob9E6yW68vvuSIn57ZA3fm2dYQd6sqIL
         MUbiWH/uiEYb/75MRkR8zeM8XV8IOZ8Oug++UYM65s5iwJhSh5UCpLrAsjzjigOsgy+w
         IVIA==
X-Gm-Message-State: AOJu0YxAB+ud/ydTCyZb8f9ZjZlKYW1cN3PXq2wzu14HIRHBYOO06x0u
	gmxFM6bq1F+kqSXv17rWu37kth18XyM7+1ZWpH+aGEOKDj4=
X-Google-Smtp-Source: AGHT+IGiteOzpFk9kWrmoZF0GIe388goGUyl4zCe+NZtvyrhXLtBe2eS5FHqpSL02/6ROyzPFUnTrT/V4cFeaM5qluM=
X-Received: by 2002:a17:907:3e1c:b0:9b2:c583:cd71 with SMTP id
 hp28-20020a1709073e1c00b009b2c583cd71mr6410424ejc.50.1699594329103; Thu, 09
 Nov 2023 21:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-4-andrii@kernel.org>
 <CAADnVQKQ5TGGwGuaO0eghhnLRFZOVgLE7Hume8uPAvbo-AwA5g@mail.gmail.com>
 <CAEf4BzbVz9kPFSn4=3k+UOEanwQVeaNjOpRh_3pYLFRnbe3vkQ@mail.gmail.com> <CAADnVQL6UrCKQw1WYbOh1GPhMR5cB3F7_An6-vSBK5Y-2=5tzw@mail.gmail.com>
In-Reply-To: <CAADnVQL6UrCKQw1WYbOh1GPhMR5cB3F7_An6-vSBK5Y-2=5tzw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 21:31:57 -0800
Message-ID: <CAEf4BzYbF-qXtRkiJg28N4u97NZrDyb8nYmEaAEO0SW19rRrJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in
 privileged mode
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 8:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 7:41=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Nov 8, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > >
> > > >
> > > > @@ -15622,11 +15619,11 @@ static int visit_insn(int t, struct bpf_v=
erifier_env *env)
> > > >                 /* conditional jump with two edges */
> > > >                 mark_prune_point(env, t);
> > > >
> > > > -               ret =3D push_insn(t, t + 1, FALLTHROUGH, env, true)=
;
> > > > +               ret =3D push_insn(t, t + 1, FALLTHROUGH | CONDITION=
AL, env);
> > > >                 if (ret)
> > > >                         return ret;
> > > >
> > > > -               return push_insn(t, t + insn->off + 1, BRANCH, env,=
 true);
> > > > +               return push_insn(t, t + insn->off + 1, BRANCH | CON=
DITIONAL, env);
> > >
> > > If I'm reading this correctly, after the first conditional jmp
> > > both fallthrough and branch become sticky with the CONDITIONAL flag.
> > > So all processing after first 'if a =3D=3D b' insn is running
> > > with loop_ok=3D=3Dtrue.
> > > If so, all this complexity is not worth it. Let's just remove 'loop_o=
k' flag.
> >
> > So you mean just always assume loop_ok, right?
>
> yes.
> Since not detecting the loop early only adds more cycles later
> that states_maybe_looping() should catch quickly enough.
>
> > >
> > > Also
> > > if (ret) return ret;
> > > in the above looks like an existing bug.
> > > It probably should be if (ret < 0) return ret;
> >
> > yeah, probably should be error-handling case
>
> I thought that refactoring
> commit 59e2e27d227a ("bpf: Refactor check_cfg to use a structured loop.")
> is responsible...
> but it looks to be an older bug.

No, I think it was indeed 59e2e27d227a that changed this. Previously we had

if (ret =3D=3D 1)
   ...
if (ret < 0)
   goto err;
/* ret =3D=3D 0 */

I'll add the fix on top of another fix.

