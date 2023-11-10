Return-Path: <bpf+bounces-14733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D37E7979
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9887028110A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7A1C3C;
	Fri, 10 Nov 2023 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kThfW9yg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7F15C5
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:38:01 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CE7A80
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:37:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso286219966b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699598278; x=1700203078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC/RlszxyI6uDDo6/wmcg+lcNhrkypBot9VfYayJkVk=;
        b=kThfW9ygLnARVy04h4XlhUH+SQ8PTxlop1FjTkjXaAl5jBYrFm2ut4yXihdNv7fEJS
         bPJU+q6K3pSPW9MJ1blXCr9v8UJKOdYxR7xJqSF5Fs49ti4/6Q5aXfvhZaw53gfMNUxx
         04oW+80Wv7BVZTNDv8Lo7pP1vQef3Vxx4zrLlp9C1dJzSmemIGU3Oo7101FdUVnFEPqq
         i/e1vYqoVq/BdufcSjbu9ekr0foRpVW9IEtP+ozA1HUODqggJDvxNHNUUfMxpf2D/4x1
         JnM0/UuON+IioZAWlhBCF+cRx91wWy5KKJS2DL/VXB+yUazzUJZzQZ8gk0XblpawQ4sp
         50WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598278; x=1700203078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC/RlszxyI6uDDo6/wmcg+lcNhrkypBot9VfYayJkVk=;
        b=t5t0Cvk0ILwfQhxrkShEfNRebWy/ggCQSH+TWePrnVaRQrfc3xbdMD0Kp2ChtrJg8H
         T1Qu2xPHQdwQJ2ZAh7aPumdKQ760vvnCw9DB/8QMm+wJgb8EG+GAajBCRMMnw/+txynd
         04U3DnlqyEEC4qCaO62ELMSo0DOc21cdIipEtqGmZP4pTx6h0/Kl7mb8gTgXcQwDGMqr
         tK6hOVu80Mg/gSU/fkYYSewv1kltoj3iFTtRxwpWOr/ie+qmDUn3uzJj/zo7SR8RNBuO
         my29nwVzyYWQUkTwCJuK6/yKd9/shPUUMPQh2RvI8hCWH7x9mdG8G2hDeaSw84fFwVQD
         VBww==
X-Gm-Message-State: AOJu0Yz6+ycNe2eJXfAbt6yZWtgbwiuZuWjUu/6Uuy4T0LFbGyjILo2b
	4wgivq77MJ9vQefLkqtaiGYOkzouPGMIbP26EqXFZdL1nuU=
X-Google-Smtp-Source: AGHT+IHFNJPv9BuHN0ggmGQn7lvwv6Qn5pwn5pDtTYELr5i2xSMTnPYRHNGVLN1P1nIwHJ0MjgT7VNXkoY307NBsuyU=
X-Received: by 2002:a17:907:9704:b0:9d3:f436:6806 with SMTP id
 jg4-20020a170907970400b009d3f4366806mr5781538ejc.47.1699594400605; Thu, 09
 Nov 2023 21:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-4-andrii@kernel.org>
 <CAADnVQKQ5TGGwGuaO0eghhnLRFZOVgLE7Hume8uPAvbo-AwA5g@mail.gmail.com>
 <CAEf4BzbVz9kPFSn4=3k+UOEanwQVeaNjOpRh_3pYLFRnbe3vkQ@mail.gmail.com>
 <CAADnVQL6UrCKQw1WYbOh1GPhMR5cB3F7_An6-vSBK5Y-2=5tzw@mail.gmail.com> <CAEf4BzYbF-qXtRkiJg28N4u97NZrDyb8nYmEaAEO0SW19rRrJQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYbF-qXtRkiJg28N4u97NZrDyb8nYmEaAEO0SW19rRrJQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 21:33:09 -0800
Message-ID: <CAEf4Bzat73bSVb3_0iY83+zhY9+zO_9yhkBxK4WZn8zAFTbs0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in
 privileged mode
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:31=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 8:08=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 7:41=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Nov 9, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Nov 8, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko <andrii@kern=
el.org> wrote:
> > > > >
> > > > >
> > > > > @@ -15622,11 +15619,11 @@ static int visit_insn(int t, struct bpf=
_verifier_env *env)
> > > > >                 /* conditional jump with two edges */
> > > > >                 mark_prune_point(env, t);
> > > > >
> > > > > -               ret =3D push_insn(t, t + 1, FALLTHROUGH, env, tru=
e);
> > > > > +               ret =3D push_insn(t, t + 1, FALLTHROUGH | CONDITI=
ONAL, env);
> > > > >                 if (ret)
> > > > >                         return ret;
> > > > >
> > > > > -               return push_insn(t, t + insn->off + 1, BRANCH, en=
v, true);
> > > > > +               return push_insn(t, t + insn->off + 1, BRANCH | C=
ONDITIONAL, env);
> > > >
> > > > If I'm reading this correctly, after the first conditional jmp
> > > > both fallthrough and branch become sticky with the CONDITIONAL flag=
.
> > > > So all processing after first 'if a =3D=3D b' insn is running
> > > > with loop_ok=3D=3Dtrue.
> > > > If so, all this complexity is not worth it. Let's just remove 'loop=
_ok' flag.
> > >
> > > So you mean just always assume loop_ok, right?
> >
> > yes.
> > Since not detecting the loop early only adds more cycles later
> > that states_maybe_looping() should catch quickly enough.
> >
> > > >
> > > > Also
> > > > if (ret) return ret;
> > > > in the above looks like an existing bug.
> > > > It probably should be if (ret < 0) return ret;
> > >
> > > yeah, probably should be error-handling case
> >
> > I thought that refactoring
> > commit 59e2e27d227a ("bpf: Refactor check_cfg to use a structured loop.=
")
> > is responsible...
> > but it looks to be an older bug.
>
> No, I think it was indeed 59e2e27d227a that changed this. Previously we h=
ad
>
> if (ret =3D=3D 1)
>    ...
> if (ret < 0)
>    goto err;
> /* ret =3D=3D 0 */
>
> I'll add the fix on top of another fix.

I take it back:

Summary: 748 PASSED, 0 SKIPPED, 43 FAILED

I'm not touching this. Some other time, or maybe someone else.

