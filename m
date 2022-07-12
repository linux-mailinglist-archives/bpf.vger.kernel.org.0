Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096E8572967
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGLWkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 18:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGLWkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 18:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFF4C8EBF;
        Tue, 12 Jul 2022 15:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 266B36171A;
        Tue, 12 Jul 2022 22:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B7F4C3411E;
        Tue, 12 Jul 2022 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657665613;
        bh=kd/QSA21RebkuuWfF2r55X8nDkz5oUzRzXKtOYa6eh4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lGdNTVzfgZSIZlAzoLRBmXw/6OCsg/bE+2BxAtYZD3XXuedUS1oOrBFjAmE0IXHX8
         n95F6QrcoAldL8H0R6/YeQGNdx0E4avislepoOQE3Sz8mamtz8YL66UQqf6oGAck1Q
         TrSStLUau7ebG2rPBMQ3S1R/TnnHlfsOu9slba4XJc+zueDkF/iRYoZ10ZlahyO6aW
         sXS7zbaPMSyJ4GK42fV2+J/7LjwEdMM/YfCqTiZQ6kLiShDO1EZqfl3cv2pkmAP5X2
         Z+A+Wu8Vr8nCWwSHIXUHWVYtQfiCznp+8FcWMDSkEg4AVXtCS2J2ftMgHGb69CMCxP
         iqCe9ZjB1Nl1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F636E45225;
        Tue, 12 Jul 2022 22:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/2] bpf: add a ksym BPF iterator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165766561331.1577.12047199920533136622.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Jul 2022 22:40:13 +0000
References: <1657629105-7812-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1657629105-7812-1-git-send-email-alan.maguire@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Jul 2022 13:31:43 +0100 you wrote:
> a ksym BPF iterator would be useful as it would allow more flexible
> interactions with kernel symbols than are currently supported; it could
> for example create more efficient map representations for lookup,
> speed up symbol resolution etc.
> 
> The idea was initially discussed here [1].
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/2] bpf: add a ksym BPF iterator
    https://git.kernel.org/bpf/bpf-next/c/647cafa22349
  - [v6,bpf-next,2/2] selftests/bpf: add a ksym iter subtest
    https://git.kernel.org/bpf/bpf-next/c/a9d2fae89fa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


