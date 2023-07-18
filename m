Return-Path: <bpf+bounces-5191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01ED75886F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18B01C20E50
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB717AAC;
	Tue, 18 Jul 2023 22:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C601772E
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 22:29:30 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B91998
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 15:29:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b74209fb60so94120431fa.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689719361; x=1692311361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0me5IkvGW37WaQfqqfhV8YpOrg1Oc3bcDBcpwbCz9E=;
        b=ZU58NWFZoMeTqb18TgXFqCFVMM83gi0H+6AP+HwLT9YPkDiu1HyLRpK8Crc1SbBiWf
         wJaNeJl1oY4ogn6alpPuXOJ8QjYWR9qpjQKmGlStDEmS3zpT9HTRlBQu5j3NmH1TSeAb
         grOBjSqGxHyImy26E7up5bUFIogXYs1VPu+pDH/pu42vuuwqzOrtJairKZiaHuvZ2P2M
         iHjZ42NqU4qLb8EyYUYnw+ahs218glD8dWP7XNW354F2+2UwlIB5vrM3tFtKYlxJAlYg
         75ZoDW5GstFlPIjRuZSlRPN2cq3KDkmfnETrSZuXbulAe8cYQe0awt2UeFcpoaJ0mL7B
         pBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689719361; x=1692311361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0me5IkvGW37WaQfqqfhV8YpOrg1Oc3bcDBcpwbCz9E=;
        b=ZfkH4xLwPAVh4y2gSbQGJqupLoiPsNthZuwGVgEA/2yEyUipnR+Okw6hvScEJn0Lm1
         Getxc07ZfD/ic0JkG1V/KCdeyMFDw2p0yEJJZV1CErXEp+z+1z+Jf3ewFEIfYhPw25BP
         2MbyT15lxgXo7vv+pzjpC8fuJlywKYGvhpGd3/MPUhRq/xcTzfB8lWW/zDw8lvRj4PFn
         Us1KQBsXmLLO7VPt/406ff7IbK8gngMm52cnPCQM8uuwzUBQf7qBBmFbzp4NjVV1M0tp
         gJEgPl9RF/J6dXaEux0gSfCXpTQKDgWals95IA5g6kF02N9zHzICS9pc17GzZfwn9oDE
         WeqQ==
X-Gm-Message-State: ABy/qLbAAl2+NMgtiWWrhGHTLXa9rF5ISXtZTwHE+MgStI5ZCfd2Zel+
	MqDtGJWE303DnlEQfY7EOzbSHnxyexSBSnjMxSA=
X-Google-Smtp-Source: APBJJlHi/RHjD2atG0e+J1PMf1IgQhOE7UnfjRkkLZBahHoWpPT6vZ9o7NTsFwAheucaAzzX1V4P+Mc6szy6xZD6bn8=
X-Received: by 2002:a2e:8013:0:b0:2b9:563b:7e3a with SMTP id
 j19-20020a2e8013000000b002b9563b7e3amr492258ljg.32.1689719361168; Tue, 18 Jul
 2023 15:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717161530.1238-1-memxor@gmail.com> <20230717161530.1238-3-memxor@gmail.com>
In-Reply-To: <20230717161530.1238-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 15:29:09 -0700
Message-ID: <CAADnVQLwz2uo-OfwJ1S8BLUG2RPM47RDuoGxw5Wmo1bPHtvE-g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/3] bpf: Repeat check_max_stack_depth for async callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 9:15=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> While the check_max_stack_depth function explores call chains emanating
> from the main prog, which is typically enough to cover all possible call
> chains, it doesn't explore those rooted at async callbacks unless the
> async callback will have been directly called, since unlike non-async
> callbacks it skips their instruction exploration as they don't
> contribute to stack depth.
>
> It could be the case that the async callback leads to a callchain which
> exceeds the stack depth, but this is never reachable while only
> exploring the entry point from main subprog. Hence, repeat the check for
> the main subprog *and* all async callbacks marked by the symbolic
> execution pass of the verifier, as execution of the program may begin at
> any of them.
>
> Consider functions with following stack depths:
> main: 256
> async: 256
> foo: 256
>
> main:
>     rX =3D async
>     bpf_timer_set_callback(...)
>
> async:
>     foo()
>
> Here, async is not descended as it does not contribute to stack depth of
> main (since it is referenced using bpf_pseudo_func and not
> bpf_pseudo_call). However, when async is invoked asynchronously, it will
> end up breaching the MAX_BPF_STACK limit by calling foo.
>
> Hence, in addition to main, we also need to explore call chains
> beginning at all async callback subprogs in a program.
>
> Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.=
")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Applied. Thanks

