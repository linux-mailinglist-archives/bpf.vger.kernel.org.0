Return-Path: <bpf+bounces-14695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0747E782F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FD52814C1
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7FE1841;
	Fri, 10 Nov 2023 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmbT+hAT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFED1847
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:41:54 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AF44BD
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:41:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so2623940a12.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 19:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699587712; x=1700192512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llNVANaNWDgCQD4rcQsnV3xQur7xvj1PdcRuJFniftY=;
        b=BmbT+hATmsyDqS9TwBISAGy2PBwlf7YaIqSTF03qpctYYPNnAJltEYtIZhqR1Hms8G
         eOMumP605ge6TdficRnAl3XutijckYgTSLDAGGU6hZ3o7sLhQd9ySKHD6VEEX/qBq093
         R99MDGAw8gf/YhDz87Lb81y05fzkiZ/CHbE6GdU5ndsXNY/BIWUodoIF5wfTx5EEFRQi
         tO2tmiQtSUVGoWoRsfrRxIqTDgGJCOBL9fZreYcDpH7GwRfuSjTQkRHPxtWETG5PgreJ
         pK0CtqbOg2+qHZChsKDJKwZuwkWtP94LXHIeK3Mt6q/tObWUVayvmkPlXS+8KJROXp2k
         v45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699587712; x=1700192512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llNVANaNWDgCQD4rcQsnV3xQur7xvj1PdcRuJFniftY=;
        b=p7G9/MiRPLoteuVcBtydesEtcEF40oheflzA6jcdQQG65KkXM06rzvV+WyqjlEtMMm
         +NSJw7a9mtF1xuR6MRnOwE1cLAv3R39bpanfTVmbfXAvbhWIWCNLvlZBEHQmVSKMQwaP
         L3GBN64pna2uT2txTF9KpdeSgznJ4LNR+pz+1wwrISdj7R/zoGRFYDW5Z0IV6XHfX6/n
         ZGtamozCMUk2WY2UEzk4SWqF3G8pnQC1PtbeR3vCew+K7bLYjDPhSkZVEhIvIL654N63
         qh2mYjaDI3g9o9GVr2SZcaGzurp3NQ9uCj2r7kvBBPaiUTLvsMl/S6JqRyLF8Osbga/P
         Qh1g==
X-Gm-Message-State: AOJu0YwKYSmUIbAyUFDQC3XQ3HlRiTs5+7eeqa9zc+yn/UU7Gg/fs9XH
	EzZiukfzEZQYnZsqJ75DUh6+YhGySSzqu6U12IA=
X-Google-Smtp-Source: AGHT+IE3SsLzOX9SgpCAZtrEGxC5J8KbZwSn2LgiXoScB5ixN3rtpVAWqlRya4GjtzBi/ELJRlZU7WuQQ5mNq8VrAiM=
X-Received: by 2002:a17:906:4f12:b0:9e6:4156:af4e with SMTP id
 t18-20020a1709064f1200b009e64156af4emr196388eju.22.1699587712369; Thu, 09 Nov
 2023 19:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-4-andrii@kernel.org>
 <CAADnVQKQ5TGGwGuaO0eghhnLRFZOVgLE7Hume8uPAvbo-AwA5g@mail.gmail.com>
In-Reply-To: <CAADnVQKQ5TGGwGuaO0eghhnLRFZOVgLE7Hume8uPAvbo-AwA5g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 19:41:41 -0800
Message-ID: <CAEf4BzbVz9kPFSn4=3k+UOEanwQVeaNjOpRh_3pYLFRnbe3vkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in
 privileged mode
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 8, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> >
> > @@ -15622,11 +15619,11 @@ static int visit_insn(int t, struct bpf_verif=
ier_env *env)
> >                 /* conditional jump with two edges */
> >                 mark_prune_point(env, t);
> >
> > -               ret =3D push_insn(t, t + 1, FALLTHROUGH, env, true);
> > +               ret =3D push_insn(t, t + 1, FALLTHROUGH | CONDITIONAL, =
env);
> >                 if (ret)
> >                         return ret;
> >
> > -               return push_insn(t, t + insn->off + 1, BRANCH, env, tru=
e);
> > +               return push_insn(t, t + insn->off + 1, BRANCH | CONDITI=
ONAL, env);
>
> If I'm reading this correctly, after the first conditional jmp
> both fallthrough and branch become sticky with the CONDITIONAL flag.
> So all processing after first 'if a =3D=3D b' insn is running
> with loop_ok=3D=3Dtrue.
> If so, all this complexity is not worth it. Let's just remove 'loop_ok' f=
lag.

So you mean just always assume loop_ok, right?

>
> Also
> if (ret) return ret;
> in the above looks like an existing bug.
> It probably should be if (ret < 0) return ret;

yeah, probably should be error-handling case

> Otherwise it's probably possible to craft a prog where fallthrough
> is explored and in such case the branch target will be ignored.
> Not a safety issue, since the verifier will walk that path anyway,
> but a bug in check_cfg nevertheless.

