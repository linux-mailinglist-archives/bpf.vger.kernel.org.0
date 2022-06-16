Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8B54EC1F
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379080AbiFPVHv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379144AbiFPVHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 17:07:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BEBDEED
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 14:07:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1457457wms.3
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDMBC2uTyxc9TPqLmLiHDJqJa928rge4eTwck2J/9uM=;
        b=lc9M109acw0E9Tk/CWR0AyJ+g+BS+b0Reuq7NJOGkRAHgfyUWBum8lGu6eiXjZLQzv
         R/9FTuA9ep0kBGKZ2Uvg3Nhb17QU2fa7daR7UViBL+D2I1krHJdBFoSw++hnQnNrvrsh
         LtbXyZ4gWU6RlAs6Gx4p+nvma7XjI2RSEN9JTEdF8AnOBj5Eiy2LlK8ZPyiXoejvWdCo
         vNVfDZkrzydF9qOVKMdx8JNAn71QrUWVNvuySZHoPxVx/ATKQS8jviHZbC66k9SiavRp
         Xh4Y3edBuxSjYxqmjPYD37+WQf8rNDloVGzYoXsxyO857iUD28Uhg+NNP0zfA3LW+3zE
         8ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDMBC2uTyxc9TPqLmLiHDJqJa928rge4eTwck2J/9uM=;
        b=RpbbNHgkwEYN9CATN80fcVeHM1OM6wMSLnhSIYYZpOrO5BYyPwVMviYTjjusIhnaOU
         wcoWttsoepRe0KT9kuKi1nyyk+YiFHWIvP0+4dfIdlJbfShcePNNEnSFRdxKxTW0Zryz
         PUYA70/cxiyK/ZDBWPWUdvAbd6ERr0+tlMIFfzEtAMPDF8bsAhwV/mbDkbXy7D8oeN2X
         TpctV4InCsXOzuVyrhXGOTgYIKBHjFAY4fsfhz66ZtrSV6qsI8z74aURCRHdcjseALPJ
         hQVvWClCMm/9pWxHz17yDLp8lJfcy1no3Fa8+5fCWPb+0nHOBlOX1HXTwrHEnn9hwHDN
         qEZA==
X-Gm-Message-State: AOAM532s+zXzIkBu1Ff8sxGYvGhIP4lJHH0bBVpXCX/O/AVGwgFpwEwd
        stJQJ0CTQMIff7sP1v7YE7DRdFtEOHqj8o0EhxIZoA==
X-Google-Smtp-Source: ABdhPJyRRizb4gVeyKzgCb6DKuEQzZg/aSSJcQ3OvUMxYRuZMuoa3UQyqOTmfH2045gbZ5xAWDkYnrWMfpYxTVY+m80=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr17371381wmk.115.1655413653567; Thu, 16
 Jun 2022 14:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220603055156.2830463-1-irogers@google.com> <165428101333.23591.13242354654538988127.git-patchwork-notify@kernel.org>
 <CAP-5=fWwKkj1HtAvOXxGxcrG99gpy8v4ReW_Jh7uumbQMiJYng@mail.gmail.com> <CAEf4BzYYcnu1PHoudKnvpjPJAszgu3TFSbNe=E6vctgh9JLkTg@mail.gmail.com>
In-Reply-To: <CAEf4BzYYcnu1PHoudKnvpjPJAszgu3TFSbNe=E6vctgh9JLkTg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Jun 2022 14:07:21 -0700
Message-ID: <CAP-5=fUANeeEHyCrynbJRrE4cU0BNrWYXN2G=MikjZS0cTJ1ZA@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Fix is_pow_of_2
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Networking <netdev@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Yuze Chi <chiyuze@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 16, 2022 at 2:00 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 14, 2022 at 1:41 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Jun 3, 2022 at 11:30 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
> > >
> > > Hello:
> > >
> > > This patch was applied to bpf/bpf-next.git (master)
> > > by Andrii Nakryiko <andrii@kernel.org>:
> > >
> > > On Thu,  2 Jun 2022 22:51:56 -0700 you wrote:
> > > > From: Yuze Chi <chiyuze@google.com>
> > > >
> > > > Move the correct definition from linker.c into libbpf_internal.h.
> > > >
> > > > Reported-by: Yuze Chi <chiyuze@google.com>
> > > > Signed-off-by: Yuze Chi <chiyuze@google.com>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [v2] libbpf: Fix is_pow_of_2
> > >     https://git.kernel.org/bpf/bpf-next/c/f913ad6559e3
> > >
> > > You are awesome, thank you!
> >
> > Will this patch get added to 5.19?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf/libbpf.c#n4948
> >
>
> I've applied it to bpf-next, so as it stands right now - no. Do you
> need this for perf?

Nope. We carry it as a patch against 5.19 in Google and was surprised
to see I didn't need to drop the patch.  Our internal code had
encountered the bug, hence needing the fix. I'd expect others could
encounter it, but I'm unaware of an issue with it and perf.

Thanks,
Ian

> > Thanks,
> > Ian
> >
> > > --
> > > Deet-doot-dot, I am a bot.
> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> > >
> > >
