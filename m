Return-Path: <bpf+bounces-5474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8475B1F1
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FDB281EB9
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBA18B02;
	Thu, 20 Jul 2023 15:03:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C520171A9;
	Thu, 20 Jul 2023 15:03:03 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F126B0;
	Thu, 20 Jul 2023 08:02:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b743161832so13214401fa.1;
        Thu, 20 Jul 2023 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689865378; x=1690470178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iwzEoyLm10S3Hpwo7s1+/p3DH6qaQDiJ1Dt4nzHm3U=;
        b=M6VGA4B9hKsn+Q3vcSc/DQz32QVK8suqXoUymD7/7SrNmvX4+JwVCOGgIMGMAhPbH4
         s0Q3n8zhP9hIM5HMO9pjReVhIZmoh0BCwB7jfki2cKAjb+aJE4QGDalDQB4Upqtm9xz9
         l4DDjdYKJ1+hDBDExKCmAhdHcEg47ACCWj1Gx+cYuD0OmZ3tJ4Kx8p7D9VRb9/8pva7M
         HPOJrjsC1qFauzvDfpmKWwVUWPVTsncRVsELMdmxv2IkV6sO1imEAZn5R2Jz7pIy8PkR
         mNGTsQpciS3bMHU+ZIYj9++GdjVsyDeBAOPymHVG0pAEiy0Z738zbIy/NUJUBGO9q+kP
         pZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865378; x=1690470178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iwzEoyLm10S3Hpwo7s1+/p3DH6qaQDiJ1Dt4nzHm3U=;
        b=F20ng3+M3W02DzaO1t+KpSIq7yG8QrFIFXBViRNsr6B1BkAGoNmPY+dTA26h17N2W0
         uXYY5D0399yqyo/TL9TfpDEQU4GvMTc1JnLUzLy68hB/dDENXEf32EjZc4QEJDhCpWJ+
         gkZ46T9awu/FPCOUhMqilPmkYUEneiy+Ql8n8sh4qygzIz2yhN4fUnl8y7RivhMxGkwN
         vJKUKWU3hH959g3QXF6rYIpQvwOKxvAoVlPXNoyuVVVP83y7EIOhax0XH00V5Z/dI8yC
         Ll8QeoMt/nX0lHMnSXB0G1OU+b+kEiGVH2hSut0/JprrJmnEPlmr3Vn4u0O1YXzRjRF2
         jvvw==
X-Gm-Message-State: ABy/qLalxamGj48kYA72vG7Moc/0kdSYN61sBvMcTM0oSpOVt0mAKBdY
	sunBo4Zbmhw9z4WO+uo+aLt1bJkVj5K4zIT8LnYacWGF
X-Google-Smtp-Source: APBJJlFsE+rLgg3nYNr7Sa250Y+coJQosr6NPZXTCk8hBycbTefcfsyTVT7VfxhrV9Prnd3B7KGT49ARYcC6dZ4bj1Y=
X-Received: by 2002:a2e:9bd2:0:b0:2b6:9909:79bd with SMTP id
 w18-20020a2e9bd2000000b002b6990979bdmr2692635ljj.24.1689865377361; Thu, 20
 Jul 2023 08:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719175424.75717-1-alexei.starovoitov@gmail.com>
 <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org>
 <CANn89iKLtOcYyqytxH6zrR4P7MJ-t0FwSKL=Wt7UwYWdQeJ1KA@mail.gmail.com> <CANn89iJNxwWZEfThm_hJKhTRRq8akKN3boaLG1XAc_WuWDp8TQ@mail.gmail.com>
In-Reply-To: <CANn89iJNxwWZEfThm_hJKhTRRq8akKN3boaLG1XAc_WuWDp8TQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 20 Jul 2023 08:02:46 -0700
Message-ID: <CAADnVQ+Bt06mnBsx3VExDGWpO7bSFE1ja8RdCjpB4yOE3SbXAw@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-07-19
To: Eric Dumazet <edumazet@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 7:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 20, 2023 at 1:25=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Jul 20, 2023 at 1:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel=
.org> wrote:
> > >
> > > Hello:
> > >
> > > This pull request was applied to netdev/net-next.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:
> > >
> > > On Wed, 19 Jul 2023 10:54:24 -0700 you wrote:
> > > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > > >
> > > > The following pull-request contains BPF updates for your *net-next*=
 tree.
> > > >
> > > > We've added 45 non-merge commits during the last 3 day(s) which con=
tain
> > > > a total of 71 files changed, 7808 insertions(+), 592 deletions(-).
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - pull-request: bpf-next 2023-07-19
> > >     https://git.kernel.org/netdev/net-next/c/e93165d5e75d
> > >
> > > You are awesome, thank you!
> > > --
> > > Deet-doot-dot, I am a bot.
> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> > >
> > >
> >
> > "bpf: Add fd-based tcx multi-prog infra with link support" seems to
> > cause a bunch of syzbot reports.
> >
> > I am waiting a bit for more entropy before releasing them to the public=
.
>
> OK, syzbot found one repro for one of the reports, time to release it
> for investigations.

Thanks for the headsup.
That's an impressive speed for syzbot to track upstream so closely.
Does it do it for net-next only? Can it be taught to do the same for
bpf-next too?

