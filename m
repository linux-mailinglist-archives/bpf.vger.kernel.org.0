Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4854BBF7
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiFNUlJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbiFNUlI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 16:41:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E24EDCD
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 13:41:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q15so5292325wmj.2
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8NGtvySkiPSB+zn0JY0x0UuY41Ui727a0ykUUn2EYQ=;
        b=a/l4eCvdnakQS3KpCMyp32Xww3NIUpatJ18P3ccX7oxPe4vtciZZW/pfxTKoGM4esv
         neDFghgkurb9bKdbUYATC87VRXSFo+gxqj6MxI4RXB11BXFY83dtMZ4VJl8dKXqp/K0P
         V7HOgEprhYtSLylFL1B5iKgB7WO8j9ChWJoT6OGQVWtsvh7iSrjaVcxNbZxymS/uTHEq
         ofkfwP2twUd0MkiFGtbWS55wfhB4hjZxo36xbYYTnbuJtwcT1O5JJXDOLOzoE13ECrIe
         JHx1tJPfejv8wTLj/8zF6BbsMyXv6rVTN4XAo0f7S8weje2JTF66EvVZ3efUFLmFR8UA
         vQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8NGtvySkiPSB+zn0JY0x0UuY41Ui727a0ykUUn2EYQ=;
        b=PIx2mUdHiNjFY8AV8MmxNoYrqW0PFc6dFHM634ioD8DRhLIrG4tCMjyrMuWDTHWbbM
         U7Ylk0kmZWUjBuBCRLMmwX1eWn508VBmoHrLknby87qiyBxGEgcCnvCfMfXAvfgIKrmF
         Uc7wB6p7S/4QZyE06WLIhZvD8U9Lc/uNHs6R59W12Z6abk6vFEXKvPX1AwnvhxedusPL
         02z56RCyYzR2fIoKnpzDpRf90EzrfLqwSf/EsVOeYCc+RbpzQ6o8gJXfZHlZoShhBciB
         PPfJyky7rpUpS1ebL9kXa4U0wN0MLKnSSxjl73RxDMapRAcRyRDIKEipUiyuCQo5cj4E
         j1DA==
X-Gm-Message-State: AOAM532Iy9QkrEBXWiaObMBvwvIO9QQ4DD1rYvs21bFaAsbc6LxA82KZ
        62Hs3Jbdg6m36LccqoywrP+EdPhjWLWdJh/1hVnv8A==
X-Google-Smtp-Source: ABdhPJz9NxbqGM6h4fim/9xoBiOe4UqSz8OL19+6SNUUG//vvbGW4DrkCH1euw3E+LrqPd5WKgTHcFSclnjjbKKWecU=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr6112757wmk.115.1655239265112; Tue, 14
 Jun 2022 13:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220603055156.2830463-1-irogers@google.com> <165428101333.23591.13242354654538988127.git-patchwork-notify@kernel.org>
In-Reply-To: <165428101333.23591.13242354654538988127.git-patchwork-notify@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 13:40:53 -0700
Message-ID: <CAP-5=fWwKkj1HtAvOXxGxcrG99gpy8v4ReW_Jh7uumbQMiJYng@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Fix is_pow_of_2
To:     andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, netdev@vger.kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        chiyuze@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 3, 2022 at 11:30 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Thu,  2 Jun 2022 22:51:56 -0700 you wrote:
> > From: Yuze Chi <chiyuze@google.com>
> >
> > Move the correct definition from linker.c into libbpf_internal.h.
> >
> > Reported-by: Yuze Chi <chiyuze@google.com>
> > Signed-off-by: Yuze Chi <chiyuze@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > [...]
>
> Here is the summary with links:
>   - [v2] libbpf: Fix is_pow_of_2
>     https://git.kernel.org/bpf/bpf-next/c/f913ad6559e3
>
> You are awesome, thank you!

Will this patch get added to 5.19?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf/libbpf.c#n4948

Thanks,
Ian

> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
