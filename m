Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609C84968A3
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 01:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiAVAVC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 19:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiAVAVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 19:21:01 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235CCC06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 16:21:01 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id h30so8958169ila.12
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 16:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caWghlziGwnD6Fz2N0i9H9xPCom1QiCOQ2ZU4ivWROc=;
        b=dYaOXxusLMH+mFWtNyC64Bkknq2Q8FkzpLkFN1IHMbcQR6qe6cHGG6mkxXZgB777U7
         VzUGWiRxLLzfvuYXwS9vhd+wlsSgPg7b2pdK8lxy0niIJ1jKtEnxXtluvNShumFHvJyp
         qMl0KfcvB5jSW3fhlAGTE5mjPCMFybnIpW01lSwVCyxVnd2OBJqrg+wgJHZfpPWJ2dru
         7kZpRnsPlptN+ePaUkaXamFIIKtbcR4+knYOzqv/ZNLeTAPmV+i6Avkx5oiriziBzOuw
         iM0k6FUqMuBG/JWdV3ixU50XRo7AuGFLzibO9JdPGe719bIWE8h2Mbah4vx7WNuCu4Mz
         2U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caWghlziGwnD6Fz2N0i9H9xPCom1QiCOQ2ZU4ivWROc=;
        b=annzRnuGYZ0br7SkcOM6+OtTpBofxyZLC+61+gxjmgfIg2av76cuRIVfE/rlEqR21l
         cctxY8bpkUtxpWggiT4CNeOPfzhvKsv8pLdabznHPLJjgjgPXzNSDOhCEvAQVBEc4GOZ
         lAzM9EwdgOW0p1ae5XNJuopq+hHjqah7vVuCazkTY9/5Olw+Zmf1BSlBAG27WNtqcPzC
         Q1RbMf7NRSp5fXC1Zb69lHegc388tCgq1wea/NpcrljTiIyQTmtmDBI9v7WXv47lTRA3
         fMut5ggSxpW57Loe6JDQXfLeA7v8r6yqcIKcGQkNgxDbFyGK6ylRKUL6dJAZtipnQT0G
         PQxQ==
X-Gm-Message-State: AOAM533NbasVtiLtwA0Cy8Ak8HnMmqSoldp/ABru2n0PUhSiThtlVrfo
        yegWrT9Mkbzz7p+zuoktUgHLnEwSmUJBsb7bzbz8V6Zw
X-Google-Smtp-Source: ABdhPJy7ngYUzhHjzB7QbHMIOmgVecXWtl1+0s7xgT/RAQULasdJUft7gqb4d8LF7gt3gxmun2m5LYOlzLHmSKht/ls=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr3539183iln.98.1642810860514;
 Fri, 21 Jan 2022 16:21:00 -0800 (PST)
MIME-Version: 1.0
References: <551ee65533bb987a43f93d88eaf2368b416ccd32.1642518457.git.fmaurer@redhat.com>
 <164271840972.1166.16358307258129760252.git-patchwork-notify@kernel.org>
In-Reply-To: <164271840972.1166.16358307258129760252.git-patchwork-notify@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jan 2022 16:20:49 -0800
Message-ID: <CAEf4BzagVFiv0BS=OP3n7uuF0a9Fn8ZBZL04a-DXKip5453sgQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] selftests: bpf: Fix bind on used port
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Felix Maurer <fmaurer@redhat.com>, bpf <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 4:18 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:

Better late than never :)

>
> On Tue, 18 Jan 2022 16:11:56 +0100 you wrote:
> > The bind_perm BPF selftest failed when port 111/tcp was already in use
> > during the test. To fix this, the test now runs in its own network name
> > space.
> >
> > To use unshare, it is necessary to reorder the includes. The style of
> > the includes is adapted to be consistent with the other prog_tests.
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf,v2] selftests: bpf: Fix bind on used port
>     https://git.kernel.org/bpf/bpf-next/c/8c0be0631d81
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
