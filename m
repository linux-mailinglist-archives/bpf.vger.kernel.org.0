Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3631064C257
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 03:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiLNCnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 21:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiLNCnq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 21:43:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41978559E
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:43:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so5683485pjj.2
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3zpX62kQveyNiO1OeyJ4tAWYrKdI77Jk/E75RXvoys=;
        b=0jeSheK30XGJEY2/8YVZb5H42sPDzyWChJv0LM5DXGQkr4Rp1tcJYsSYcwhaeHaws5
         13r/iVQG2//SX9o8YqZmdqMz4vnF7EVFbHuI2t0+noHned9FfCDXaMIHgHFFQthwDw6g
         nyzZqYHCrdaZW15mjKnhYr7BxncWpncnJ570HtD3Rn1euKPAxBUxeIHLhg+GpJAB8xxa
         G9wO/TWuK6fKHURvUyXokt/S1QAjKThkNqCxr/2nwd4eRKBNyBmU2o8mhpoOBi67ZThv
         tmekbr0XJowvGgDjDYyzPsqzAoKPHyxEvn2QAbV65V/QUBE9lUmrlThE1GlVS12k8R87
         1L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3zpX62kQveyNiO1OeyJ4tAWYrKdI77Jk/E75RXvoys=;
        b=JOKvtObAIMra6j1UgirRlF18Lqt9ebqsuT0g9yvmbqrTj2hPFuDISrkyFI6GrRoZko
         u3mOp+kvRyy0cQ34cQmnWnVlXP7Rf5mt/zto3FqK1FtcAQylHh1fsk7V64EVQrzsmFyQ
         bjHnnE0+4dZ794fFqrU3uxC+ThRT/bi0Mj2CoDoS7eC8VLbcL3ubLJb9rdPdGAKNwC9c
         c5m4qxZANQ8kUyEqICv1rbm1bn/RccMFd0ewN8x1OwSx3oQ6PmSA5QqSjms3lHGoORea
         2NgmJN8cHbv2FJwprGHmFW1wNiIbUdpHAROuF8Zx0lmF3JEoYpGtpitKaUXdoWULEpxq
         lAZA==
X-Gm-Message-State: AFqh2kowCXh4Lz3tR96KmX42FvTp2xkxrBNb7Jml5PEAuyI98soDhyaN
        JUxnNx35mlNPl+psbzxrI5wfSI+UZX2K9OBzjqrY
X-Google-Smtp-Source: AMrXdXsAFqasEGUKk60MS2TQ0dx9fzOfbpL9oe4Ce2NTauHwaDuuWdH3Aa3wRVZtRYkllfhLAVvVDdYUy6Xfi1rkrsI=
X-Received: by 2002:a17:90a:1912:b0:219:8ee5:8dc0 with SMTP id
 18-20020a17090a191200b002198ee58dc0mr98556pjg.72.1670985824675; Tue, 13 Dec
 2022 18:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com> <167098009860.3547.3800457811769489703.git-patchwork-notify@kernel.org>
In-Reply-To: <167098009860.3547.3800457811769489703.git-patchwork-notify@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Dec 2022 21:43:33 -0500
Message-ID: <CAHC9VhSv66DPsJ+5ewmHQ68D3uFh76TpNC9kGXcns_rV-tbaig@mail.gmail.com>
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 8:08 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (master)
> by Paul Moore <paul@paul-moore.com>:
>
> On Fri,  9 Dec 2022 09:29:35 +0100 you wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > The fs_context_parse_param hook already has a description, which seems the
> > right one according to the code.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > [...]
>
> Here is the summary with links:
>   - [1/2] lsm: Fix description of fs_context_parse_param
>     https://git.kernel.org/netdev/net/c/577cc1434e4c
>   - [2/2] doc: Fix fs_context_parse_param description in mount_api.rst
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

It looks like the bot has a few screws loose as this went up to Linus
via the LSM tree :)

-- 
paul-moore.com
