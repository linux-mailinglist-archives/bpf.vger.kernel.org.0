Return-Path: <bpf+bounces-17935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583DA813FA2
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2741C22035
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4947F809;
	Fri, 15 Dec 2023 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyWkoS2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2177FC;
	Fri, 15 Dec 2023 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c317723a8so2236745e9.3;
        Thu, 14 Dec 2023 18:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702606622; x=1703211422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK9ZqvhW0YIqb3VALjkInZWNafqN/1JnCqtVoacc+0g=;
        b=XyWkoS2q4hU1kmLTNp3I6cO7ypu3RlYiN9Fs4pZg0uAoFqgHU3nYIIxWPxd7uh/WdN
         jI4wB6PlPKCxviVmfimNYRG+LdO+OlbOyGCmXu+pLZCMB+47ZlA6qJIBStsyVLkOwoCP
         4AJy6z+lir4yImWzru915cPqPxh3oX4najUJSMScsRCvnkNIT6TMVG5lIuOH/SvTXvjt
         +csxxvtl7rvaVEHkHKV8kmW3w3m9ry5lXJdNYCBgDzgXLA0HmZTlvlt7YuXIFGRa6iUJ
         fcv+Y59IvlC4sQB2mWIF7ytCmcaJTRzJMnHcBiGraMKQn9hfTJ2kqogzukPERvRCKHhA
         l0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702606622; x=1703211422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK9ZqvhW0YIqb3VALjkInZWNafqN/1JnCqtVoacc+0g=;
        b=Niz31dm6+qt3heS9F1z78GNAa4q9KMO+HUpIWdtilR+kTNKAOX8DpSX0Wr97QAjmqO
         W1O/fmDA1OvCmPtsqSq8LzlXNQ14szY484wfTw86BFC0C2hSdRnbyhlhvt283g8ZXsy6
         cnd/qEniLLTFg1ngPdMbc8xmLcSmNWaZ+KYcKX19kFpvOMhq4zCNzlXUfm1ppBBW1IEh
         M4ymo/C+5F6aTBKTlBlVzVoEcuLZC8fc5QcbLIzxXpyFKyykQxMZ7crinxUeTSlD6YPa
         7dYsMODQKCu3gcT9SUN9IKXff/YZEO+iIoj9RpCxf72E50EmI+AiJWRC4MGZbfNrhxrC
         i07A==
X-Gm-Message-State: AOJu0YxHkTpxI6ZuFvXk8eZXsUjDA3wXZX/4xamV5rxRJsYNpAp147fe
	5heVodTPKOJUUwn8cOtJVWWhZfsFKeYs7Tp3qQA=
X-Google-Smtp-Source: AGHT+IH+gNIkyMzIajJb4aTb9bkzSCH3dtGGEAxPG+1vniTQlhB914m7KSyQUB28yPBL1uN07DbzD1oRR8Q/1mc2Xcg=
X-Received: by 2002:a05:600c:1827:b0:40c:3828:b8cb with SMTP id
 n39-20020a05600c182700b0040c3828b8cbmr5248460wmp.101.1702606622346; Thu, 14
 Dec 2023 18:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com> <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
 <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com> <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
In-Reply-To: <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 18:16:50 -0800
Message-ID: <CAADnVQ+RVT1pO1hTzMawdkfc9B0xAxas2XmSk6+_EiqX9Xy9Ug@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hao Sun <sunhao.th@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-12-15 at 02:49 +0200, Eduard Zingerman wrote:
> > On Thu, 2023-12-14 at 16:06 -0800, Andrii Nakryiko wrote:
> > [...]
> > > If you agree with the analysis, we can start discussing what's the
> > > best way to fix this.
> >
> > Ok, yeap, I agree with you.
> > Backtracker marks both registers in 'if' statement if one of them is
> > tracked, but r8 is not marked at block entry and we miss r0.
>
> The brute-force solution is to keep a special mask for each
> conditional jump in jump history. In this mask, mark all registers and
> stack slots that gained range because of find_equal_scalars() executed
> for this conditional jump. Use this mask to extend precise registers set.
> However, such mask would be prohibitively large: (10+64)*8 bits.
>
> ---
>
> Here is an option that would fix the test in question, but I'm not
> sure if it covers all cases:
> 1. At the last instruction of each state (first instruction to be
>    backtracked) we know the set of IDs that should be tracked for
>    precision, as currently marked by mark_precise_scalar_ids().
> 2. In jump history we can record IDs for src and dst registers when new
>    entry is pushed.
> 3. While backtracking 'if' statement, if one of the recorded IDs is in
>    the set identified at (1), add src/dst regs to precise registers set.
>
> E.g. for the test-case at hand:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
>   1: (bf) r7 =3D r0                       ; R0=3Dscalar(id=3D1) R7_w=3Dsc=
alar(id=3D1)
>   2: (bf) r8 =3D r0                       ; R0=3Dscalar(id=3D1) R8_w=3Dsc=
alar(id=3D1)
>   3: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
>   --- checkpoint #1 r7.id =3D 1, r8.id =3D 1 ---
>   4: (25) if r0 > 0x1 goto pc+0         ; R0=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D1,...)
>   --- checkpoint #2 r7.id =3D 1, r8.id =3D 1 ---
>   5: (3d) if r8 >=3D r0 goto pc+3         ; R0=3D1 R8=3D0 | record r8.id=
=3D1 in jump history
>   6: (0f) r8 +=3D r8                      ; R8=3D0

can we detect that any register link is broken and force checkpoint here?

>   --- checkpoint #3 r7.id =3D 1, r8.id =3D 0 ---
>   7: (15) if r7 =3D=3D 0x0 goto pc+1

