Return-Path: <bpf+bounces-5440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F575ACEF
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93451C2131E
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3F17756;
	Thu, 20 Jul 2023 11:26:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DE17747
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:26:11 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEC7269A
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 04:26:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40540a8a3bbso228361cf.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689852368; x=1690457168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2MQuw8Dxgx9roDvjU2BN2mY103293qsRDuml6/qqIQ=;
        b=jPMEoPysjbHqWgLXcHDSEXQDIHkF3VfRD39krR/lmEk++0stlV4zN6H59jOpxWKYXq
         ep+EmnY7Zk3cJ9WWk6KK/0qoqYMgEFmQ9XykC1MXjUmASsKFGt3HxLrkyjnxMJdgOwo0
         MjIsZPKBmt+2DPErkXmHMrvyuN10vEq38bL0MBxs4N/+RAGkAQ/Ql74UJveZXkWyWG2U
         pb/TlntTA5NGxU2CBq/+KsFnhyvMwVzFU28aDTEAZEmkgo2asB0Dttt/AJz55BW2YFkU
         tceAq3Mfi5GMB8umambkr/CVoAAYVj09j72gPiz840JFJVGLTG4RGBaBVFOWBSearRwV
         79Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689852368; x=1690457168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2MQuw8Dxgx9roDvjU2BN2mY103293qsRDuml6/qqIQ=;
        b=AwO9aQYM4jTnAcTwIyxcP8nHn12PuVB7d77m7MtSIvpdMXvJZLjzyLCxN8YI9gLdTK
         9ioXTFlO+LZFCVfR2SlPVcgUQFHZhker7yDmOSV+XravhIvOB4FPUn3zoReIvONCEp2K
         WO8bjlIHG8wSQTTiyqwgguBMX8kAAai2hy/v04ArkzeAx9elx2o8/4RE6a7ngD4fPpIi
         8IJ8tkvdOA//lktswlYY3DzOt6APoA5ieIurUbNR/dDSEyELGCSkzyPPpaoZ3M5bsomF
         cq3p5PEtG0RytOdL0SR9FkxomNKyhcgDLkf42Q89glOPKcOuwuX9VfbL2anZsXzhXjS8
         ahKQ==
X-Gm-Message-State: ABy/qLZPsB9y9PoCA1JzJeEsA+aO7DonlMgPPzypaQ3z2ZFQmdHHkPmP
	dp3frRW/wrXzkFADB76Zfz9KZXp9fVuVS4SfQ3+euw==
X-Google-Smtp-Source: APBJJlFUUUF0CJwIRK7aVYOKXyc90+vnfOJ/rVwe6i4oWGffAtXVNtER7F4inW8FsyhFjYPXpQBHZR2EWwqFfA6aIiM=
X-Received: by 2002:a05:622a:1756:b0:403:eb3c:37af with SMTP id
 l22-20020a05622a175600b00403eb3c37afmr274138qtk.26.1689852368426; Thu, 20 Jul
 2023 04:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719175424.75717-1-alexei.starovoitov@gmail.com> <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org>
In-Reply-To: <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 13:25:57 +0200
Message-ID: <CANn89iKLtOcYyqytxH6zrR4P7MJ-t0FwSKL=Wt7UwYWdQeJ1KA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-07-19
To: patchwork-bot+netdevbpf@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 1:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This pull request was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed, 19 Jul 2023 10:54:24 -0700 you wrote:
> > Hi David, hi Jakub, hi Paolo, hi Eric,
> >
> > The following pull-request contains BPF updates for your *net-next* tre=
e.
> >
> > We've added 45 non-merge commits during the last 3 day(s) which contain
> > a total of 71 files changed, 7808 insertions(+), 592 deletions(-).
> >
> > [...]
>
> Here is the summary with links:
>   - pull-request: bpf-next 2023-07-19
>     https://git.kernel.org/netdev/net-next/c/e93165d5e75d
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

"bpf: Add fd-based tcx multi-prog infra with link support" seems to
cause a bunch of syzbot reports.

I am waiting a bit for more entropy before releasing them to the public.

