Return-Path: <bpf+bounces-5473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DDC75B1C3
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A77281ED8
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB618AF9;
	Thu, 20 Jul 2023 14:53:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B018AE7
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 14:53:54 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B42EE
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 07:53:53 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so347711cf.0
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689864832; x=1690469632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpVfDd3TmC+58MrJZc4rMEANE9/cqkqPncrw/o/Hhys=;
        b=S/9JhYrjIyt04VHrEQ6P4doCapVUDdA8T+vST8TVP44C25C3h0Rn8kzoETVKiRMBpo
         Y+ZEc9J5hngor3G8OI/37eFKcZnZAzQp527H2DJGejq8R0yFF0rtL8AI7SQkzmlJmjzH
         dKY9kLUT0OKqLFhlPUeuG7UZWJTEnGuYAcgMq+xGsgGtVCp7bXGIpi1rODpRm1UJaTJN
         ystUmMZ8Xc+7/9VxdqZFPUV3q3/rLfWfZ7bwwBk9afoFzagGI0fPa0DiqEgIl3abpLO0
         93wxMY+ckCQFwa7BsWBOuieWXQqgEh2lUDx9W5Xn7XJk2/ZY1xKV1yThbYzbR1hRHzFq
         CDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864832; x=1690469632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpVfDd3TmC+58MrJZc4rMEANE9/cqkqPncrw/o/Hhys=;
        b=JnJOqQkFPrpCs5EpIkk3plZo22USy4mSci3hHGLHjmBUuy904kmUza+X2D1GRjJQO/
         eUhyjOs+VepgFlZbHu+gwVIwXj23huzAwttZ0Z3wPuKrQF/wbU2SRbLLjwwZmqcsvEd3
         VJbF03Y7zCO2weqeqxlK/5djBlDO2xBcYoPQlOQH3t5vfrqCd4Z4h0hRGY+8MmaDLlIs
         8uKjAoSb5niFwW5sE5m0Aqmnkpua6dhBRhGhLMq2mL5zCa/dFd0tpVVgH3cxW9y8y3BK
         FuIFieqLOSjUga3xHC6Iv9g9s0JQLGzkKK4ZSD+49e2+f+AFx2MnvXJ2hagK5/EioRcR
         AkuQ==
X-Gm-Message-State: ABy/qLbtzoDRfs+/yU05yy1a9BVC/dc1HfSlBwHHj904Ll+05PMcS2G+
	CwQAzAzB76Wxey8nwJGCP9u4MV32KOrfqyGZzcKczA==
X-Google-Smtp-Source: APBJJlFGuZzkHfCDJ8Wpn2Y9Fnl0Z15RKT+2mcFyhBHWJUldw8Z+I50LgUqDjNwuismUdAvHYugvg2dDvJnkiQk09bY=
X-Received: by 2002:a05:622a:48:b0:403:eeb9:a76 with SMTP id
 y8-20020a05622a004800b00403eeb90a76mr251043qtw.17.1689864832504; Thu, 20 Jul
 2023 07:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719175424.75717-1-alexei.starovoitov@gmail.com>
 <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org> <CANn89iKLtOcYyqytxH6zrR4P7MJ-t0FwSKL=Wt7UwYWdQeJ1KA@mail.gmail.com>
In-Reply-To: <CANn89iKLtOcYyqytxH6zrR4P7MJ-t0FwSKL=Wt7UwYWdQeJ1KA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 16:53:40 +0200
Message-ID: <CANn89iJNxwWZEfThm_hJKhTRRq8akKN3boaLG1XAc_WuWDp8TQ@mail.gmail.com>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 1:25=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 20, 2023 at 1:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This pull request was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Wed, 19 Jul 2023 10:54:24 -0700 you wrote:
> > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > >
> > > The following pull-request contains BPF updates for your *net-next* t=
ree.
> > >
> > > We've added 45 non-merge commits during the last 3 day(s) which conta=
in
> > > a total of 71 files changed, 7808 insertions(+), 592 deletions(-).
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - pull-request: bpf-next 2023-07-19
> >     https://git.kernel.org/netdev/net-next/c/e93165d5e75d
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
>
> "bpf: Add fd-based tcx multi-prog infra with link support" seems to
> cause a bunch of syzbot reports.
>
> I am waiting a bit for more entropy before releasing them to the public.

OK, syzbot found one repro for one of the reports, time to release it
for investigations.

