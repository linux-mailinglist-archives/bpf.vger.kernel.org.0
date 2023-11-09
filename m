Return-Path: <bpf+bounces-14653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40D7E7510
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C16DB21106
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2D38F9C;
	Thu,  9 Nov 2023 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+bhX/qJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969438DCB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 23:18:19 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D34231
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:18:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507bd644a96so1988823e87.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 15:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699571896; x=1700176696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGC8BENpRflTFkw+rZWBZ4sRq3GX3cYTKjKrle7a6Kk=;
        b=F+bhX/qJSApAZ94lVMELzyjFRglC0cBGAR6AJ0ZHbIdi+D0erGSznt75vuROCXMjlc
         r0OW2LSMgwYuJrDxtp3kpkjM4Vf5rEjl1BfzQRB5GY2JfRTgeZUUp2zbq5gn07wFlJoB
         YjClqJG01J2cbulEXZypCRJzE7AQQlhIay8kwEnRnKMCD+Y/nw1o3ex6VxURiY8r1Dsc
         0ZVQYWfmxWScaDn2etmugHsfAz1+xU1CGQEc/N658fl+x/XhfZoUb1hIdoJKE0JqHJv4
         pmyEVcP8B8++m/URj6w4urND9OBqmETZUDZauCsZdmyLiy3nsiOcjGxSTYUrKhDG8Jpj
         Ht/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699571896; x=1700176696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGC8BENpRflTFkw+rZWBZ4sRq3GX3cYTKjKrle7a6Kk=;
        b=KInAN9qh0Y1Rw9wh56OBWKHEH4MtDeVOlQSrQ8phAOpFC6kJ0Da/bLrj1pmwN8Ax5E
         IMyTgW1fB0rbtw/S3kVkCOA/HxcgXKSm9YXWIErNAf9zIdirphu5f8Ac3v7DZ9d9qFsF
         dXR4jqK9Skq1901QbDjf7SgwiQayWp2NMwqAE5YBK6cAL860xJenduIhOxjK4XBSlFTi
         Ui4AOw6egZGztM1/ESubEL2+6mE8Xh01dM3uokhKUnEIOIB0r7m6X2/8ujJupehqlhSO
         8mXupMlRVoCzTrGYQRlPVFobyCAM59OqzZWZkJPg00SnV+z7c3GHkdYNYKobt4C4N30e
         r0tg==
X-Gm-Message-State: AOJu0YygEBIZY70RcCHMB6sr9Ea998FLPiIYZJiRrRdqGFgSzEj9Anmt
	tppQaHQqBdKWQo4z+ljQ8B6GFcxvOxaZ6Dvl+SWRPeNM
X-Google-Smtp-Source: AGHT+IESJf7CnaRfpHnfq3S+2Pl9mEWBMVm0Q/Pc9pkxbund0sAIQsc2wc58DWtvpHyPqiwiRlcz2Z7PkTJTuhz96j8=
X-Received: by 2002:a19:c20c:0:b0:509:f45c:fae8 with SMTP id
 l12-20020a19c20c000000b00509f45cfae8mr700446lfc.18.1699571896247; Thu, 09 Nov
 2023 15:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-3-andrii@kernel.org>
 <3ff0d703846a10d2a84ae5086511793a2aba5c08.camel@gmail.com>
In-Reply-To: <3ff0d703846a10d2a84ae5086511793a2aba5c08.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 15:18:04 -0800
Message-ID: <CAEf4BzbDR9S-wQ6vH6Exvv04wU2VPGud=1-_p0v=gEy7Amo_xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: fix precision backtracking instruction iteration
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-11-08 at 15:11 -0800, Andrii Nakryiko wrote:
> > Fix an edge case in __mark_chain_precision() which prematurely stops
> > backtracking instructions in a state if it happens that state's first
> > and last instruction indexes are the same. This situations doesn't
> > necessarily mean that there were no instructions simulated in a state,
> > but rather that we starting from the instruction, jumped around a bit,
> > and then ended up at the same instruction before checkpointing or
> > marking precision.
> >
> > To distinguish between these two possible situations, we need to consul=
t
> > jump history. If it's empty or contain a single record "bridging" paren=
t
> > state and first instruction of processed state, then we indeed
> > backtracked all instructions in this state. But if history is not empty=
,
> > we are definitely not done yet.
> >
> > Move this logic inside get_prev_insn_idx() to contain it more nicely.
> > Use -ENOENT return code to denote "we are out of instructions"
> > situation.
> >
> > This bug was exposed by verifier_cfg.c's bounded_recursion subtest, onc=
e
>
> Note: verifier_cfg.c should be verifier_loops1.c

fixed

>
> > the next fix in this patch set is applied.
> >
> > Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Funny how nobody noticed this bug for so long, I looked at exactly
> this code today while going through your other patch-set and no alarm
> bells rang in my head.

tell me about it, I spent 3 hours with gdb and tons of extra verifier
logging before I found the issue

>
> I think that this case needs a dedicated test case that would check
> precision tracking log.

ok, will add

>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

