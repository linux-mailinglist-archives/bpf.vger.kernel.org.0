Return-Path: <bpf+bounces-13812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076CA7DE520
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 18:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FEEFB21095
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D915E88;
	Wed,  1 Nov 2023 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv0jDrKX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE1107B6
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:13:43 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ADDFD
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 10:13:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c41e95efcbso2892966b.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698858817; x=1699463617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWhCJWx1kcaWP2f8G3BjSs0mfzm76Xsa4l9LUxcDVY8=;
        b=Hv0jDrKXqnl3inQTVgy6OahnBKuliYnKgnxuY8UnFDbaDbG3N7DdBV/8a4TnY5NHI0
         fDd9V8S1GUafH4jXje+zxCCpUjy/cbsxi88O3GrqlhGeT5GNRBU6yQ5J1mbqouU64YOj
         9SGe5/x/baVBcA1+RvD6M0Kpud6ROu/gga2Vd/1XwRcR1kYaUs44OEFTiqDm/QLQsDde
         WRkaXzrZIg+CJbkyigMLsL+emwcUCbSBN5LpZNSW7Ms85f0kO2XcyQJnZGdZwwAyibuJ
         DcF0cFsha4TyytHzFZJJVBtKWSXdSuWRyifYznwJXXlK2NLb+FxwNV1RRCWdFS1YDXDB
         H40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858817; x=1699463617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWhCJWx1kcaWP2f8G3BjSs0mfzm76Xsa4l9LUxcDVY8=;
        b=PlCXi4dUkswenHyD8dh+XAq7AlMXjU7Ue5/LkLJRRTgMfYqP3I07pzZ5tqHa9BaJHw
         JfX82C167gOFtllSwXCHX2DhwSolfxWoesjcgssDNpwj4haWTgmhlMBwR9xcDJJtpqG8
         EWja+zkqp8eXF56rCbeJCIdHAGoCqpkpF5PS9lYo4DH25yb7X5oEaRIi5WQkffU+F51m
         0lU12VJ9CL8E8qVwSgexK2WvK4YJNsACVYFQAdzJ0NrZVzqXiLjHxVtSBxiPKIypYQTk
         eN/hiGJlxfg2baZoZUAnKXalpRWdNLdXK89OPtX+kQJ+Ot7uYUtN6IwUsZAtskC90thE
         ObeQ==
X-Gm-Message-State: AOJu0YwEJf+lbv1Tu7/N+xHKQUpl6I3zRNdFTN4ras4Ywet0uFWyjWEL
	pSqKQ1rbpZXlxlUsMKJeO2qgC1IAvpzCDztXpmA=
X-Google-Smtp-Source: AGHT+IH4YI7qoHIKKFFq3NA+F0C/C7UW4EOhcAgpSo6bYqctMluItvR4gKNGPlpqHGmluNb3nWNfozDy7xfj/V8ZQ2g=
X-Received: by 2002:a17:907:3e1d:b0:9d3:52e:a641 with SMTP id
 hp29-20020a1709073e1d00b009d3052ea641mr2810157ejc.8.1698858817409; Wed, 01
 Nov 2023 10:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231030175513.4zy3ubkpse2f6gqz@MacBook-Pro-49.local>
 <CAEf4BzZyLwO_ZppGObkY=4aXZEGE+k+tTtJug7MP63DffoxrYA@mail.gmail.com> <ZUJGkRGnw+qI15Pv@Mem>
In-Reply-To: <ZUJGkRGnw+qI15Pv@Mem>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 10:13:26 -0700
Message-ID: <CAEf4BzavMQ9kqjVWhasdOMweZKuvwfmthzfz8i38kLwp6jd8SA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing improvements
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Paul Chaignon <paul@isovalent.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 5:37=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.c=
om> wrote:
>
> On Mon, Oct 30, 2023 at 10:19:01PM -0700, Andrii Nakryiko wrote:
> > On Mon, Oct 30, 2023 at 10:55=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Oct 27, 2023 at 11:13:23AM -0700, Andrii Nakryiko wrote:
> > > >
> > > > Note, this is not unique to <range> vs <range> logic. Just recently=
 ([0])
> > > > a related issue was reported for existing verifier logic. This patc=
h set does
> > > > fix that issues as well, as pointed out on the mailing list.
> > > >
> > > >   [0] https://lore.kernel.org/bpf/CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6X=
ELnE7VeoUWgKf3cpig@mail.gmail.com/
> > >
> > > Quick comment regarding shift out of bound issue.
> > > I think this patch set makes Hao Sun's repro not working, but I don't=
 think
> > > the range vs range improvement fixes the underlying issue.
> >
> > Correct, yes, I think adjust_reg_min_max_vals() might still need some f=
ixing.
> >
> > > Currently we do:
> > > if (umax_val >=3D insn_bitness)
> > >   mark_reg_unknown
> > > else
> > >   here were use src_reg->u32_max_value or src_reg->umax_value
> > > I suspect the insn_bitness check is buggy and it's still possible to =
hit UBSAN splat with
> > > out of bounds shift. Just need to try harder.
> > > if w8 < 0xffffffff goto +2;
> > > if r8 !=3D r6 goto +1;
> > > w0 >>=3D w8;
> > > won't be enough anymore.
> >
> > Agreed, but I felt that fixing adjust_reg_min_max_vals() is out of
> > scope for this already large patch set. If someone can take a deeper
> > look into reg bounds for arithmetic operations, it would be great.
> >
> > On the other hand, one of those academic papers claimed to verify
> > soundness of verifier's reg bounds, so I wonder why they missed this?
>
> AFAICS, it should have been able to detect this bug. Equation (3) from
> [1, page 10] encodes the soundness condition for conditional jumps and
> the implementation definitely covers BPF_JEQ/JNE and the logic in
> check_cond_jmp_op. So either there's a bug in the implementation or I'm
> missing something about how it works. Let me cc two of the paper's
> authors :)
>
> Hari, Srinivas: Hao Sun recently discovered a bug in the range analysis
> logic of the verifier, when comparing two unknown scalars with
> non-overlapping ranges. See [2] for Eduard Zingerman's explanation. It
> seems to have existed for a while. Any idea why Agni didn't uncover it?
>
> 1 - https://harishankarv.github.io/assets/files/agni-cav23.pdf
> 2 - https://lore.kernel.org/bpf/8731196c9a847ff35073a2034662d3306cea805f.=
camel@gmail.com/
>
> > cc Paul, maybe he can clarify (and also, Paul, please try to run all
> > that formal verification machinery against this patch set, thanks!)
>
> I tried it yesterday but am running into what looks like a bug in the
> LLVM IR to SMT conversion. Probably not something I can fix myself
> quickly so I'll need help from Hari & co.
>
> That said, even without your patchset, I'm running into another issue
> where the formal verification takes several times longer (up to weeks
> /o\) since v6.4.
>

That's unfortunate. If you figure this out, I'd still be interested in
doing an extra check. Meanwhile I'm working on doing more sanity
checks in the kernel (and inevitably having to debug and fix issues,
still working on this).

