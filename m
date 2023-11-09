Return-Path: <bpf+bounces-14655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD617E7520
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6331C20D7A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A1E38DC3;
	Thu,  9 Nov 2023 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOTByu49"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36FD38DEB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 23:28:41 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2074420F
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:28:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so2456268a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 15:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699572519; x=1700177319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip51T9nATIEc/MdCNJR5+sanOgcry7VFiamNTR/lY/0=;
        b=VOTByu498lDcii6xY04YkU2IjTm4A7TSIeQgy+y+0HhjA+BA7eI+9Xh3qJPeusGsae
         SgMPgM9lWS4ZVMV2B5eKLBZrABVVTmqOkG/rXMIslhG5BagbFKMVMIRYQnZvEpbbcm3B
         LFe1TdSekFK7EpEfWbpcObj4QRJh2HOAYEIVaBFWgXiDidUU7QWxos4dT6hXqYH6oNUR
         b4EoKp4H0cg4vho3xiok8FXVCPtomNnkSxT1ffAeQPJ/JfOZTHif6wQVCrjadDcFz7dq
         4B7eWMn0qPBxb0FI7dJtmu5DXTg5Exh12TAAgcJXUYJ1X+xda4+QJbVYSUxj3oMHfyb8
         Hzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572519; x=1700177319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ip51T9nATIEc/MdCNJR5+sanOgcry7VFiamNTR/lY/0=;
        b=TQwjHEAB53ETcG1Y6y43PhRR4Yu1m9xt/E5CH7ENMaCOmD3A0PQCzpmCOAiKS/Ih4n
         1/A30c61Moetq2rNl36COY5HjHAyC5ombcnH7D923MZuSL9YQIEuxqTWqtvgDHb4TpwA
         DLhTHxSrdJkBHLhBuKEjUz4LWq4CYsoypbMy+1GP6TaN037TM3mPSudMAhC0hKR5qX4X
         kdMMf2UNDFkHAtaGmiJMz8EdfeQ5tak2Yv9tyjEYv/EXK7ksoY/PQtfh9/M3fcD7Z2T2
         3fXGyWv3GJgW5dWX/kCA5MWK+DcKOA40APJNfWZj9vNWKKmFOhxr9QtIQ3emcFFL2KKK
         AfBw==
X-Gm-Message-State: AOJu0Yy2G6JTfgMgoCscWtPXN8xPGHKNZXz1JXXfW4QT/BdSmdH/DTfx
	pZMO9wuwiECmMxWXXvceF0EGrCoeW8eIDQcneTI=
X-Google-Smtp-Source: AGHT+IE9w5pbatNLsHBkjwXj02XfxotejS0Z9SrHiDvJBoslYVJ+GKlTovo3DIPTK1inJVSHrPBizx67zr/EqA4/ilY=
X-Received: by 2002:a50:c302:0:b0:544:b880:b316 with SMTP id
 a2-20020a50c302000000b00544b880b316mr4843349edb.30.1699572519320; Thu, 09 Nov
 2023 15:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-3-andrii@kernel.org>
 <3ff0d703846a10d2a84ae5086511793a2aba5c08.camel@gmail.com> <CAEf4BzbDR9S-wQ6vH6Exvv04wU2VPGud=1-_p0v=gEy7Amo_xw@mail.gmail.com>
In-Reply-To: <CAEf4BzbDR9S-wQ6vH6Exvv04wU2VPGud=1-_p0v=gEy7Amo_xw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 15:28:27 -0800
Message-ID: <CAEf4BzbK1B-mQxS5dH98MjmMMWjVUvzyrwHi5qWNBtPJs384kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: fix precision backtracking instruction iteration
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 3:18=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 9:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Wed, 2023-11-08 at 15:11 -0800, Andrii Nakryiko wrote:
> > > Fix an edge case in __mark_chain_precision() which prematurely stops
> > > backtracking instructions in a state if it happens that state's first
> > > and last instruction indexes are the same. This situations doesn't
> > > necessarily mean that there were no instructions simulated in a state=
,
> > > but rather that we starting from the instruction, jumped around a bit=
,
> > > and then ended up at the same instruction before checkpointing or
> > > marking precision.
> > >
> > > To distinguish between these two possible situations, we need to cons=
ult
> > > jump history. If it's empty or contain a single record "bridging" par=
ent
> > > state and first instruction of processed state, then we indeed
> > > backtracked all instructions in this state. But if history is not emp=
ty,
> > > we are definitely not done yet.
> > >
> > > Move this logic inside get_prev_insn_idx() to contain it more nicely.
> > > Use -ENOENT return code to denote "we are out of instructions"
> > > situation.
> > >
> > > This bug was exposed by verifier_cfg.c's bounded_recursion subtest, o=
nce
> >
> > Note: verifier_cfg.c should be verifier_loops1.c
>
> fixed
>
> >
> > > the next fix in this patch set is applied.
> > >
> > > Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Funny how nobody noticed this bug for so long, I looked at exactly
> > this code today while going through your other patch-set and no alarm
> > bells rang in my head.
>
> tell me about it, I spent 3 hours with gdb and tons of extra verifier
> logging before I found the issue
>
> >
> > I think that this case needs a dedicated test case that would check
> > precision tracking log.
>
> ok, will add
>

But I will say that it would be much better if verifier/precise.c was
converted to embedded assembly... Let's see if we can somehow
negotiate completing test_verifier conversion? ;)

> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>

