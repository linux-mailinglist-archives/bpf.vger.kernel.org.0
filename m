Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5C606D58
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 04:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJUCAz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 22:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJUCAw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 22:00:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7DCEE093;
        Thu, 20 Oct 2022 19:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46EE661D85;
        Fri, 21 Oct 2022 02:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A942CC433D7;
        Fri, 21 Oct 2022 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666317616;
        bh=Xqu1nVukrV3f390m3ZaHgtue4hwlBbqSFcX3dBYmRyQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lxXO5z2DWS79CZ12hTV41SnraPxEvl1VxrbRdN8YdapNdG4u6NSFzluXPDpKwQFxL
         mHZS6HxZP75j1TnHd5FShmPPRnb2QMhAJHbuJBXysvfLqSdbdMHS2iNlM6yF2z1TAI
         v5zHK4k70udYfng/KUkAb/9LX9Cof379W2xmJLawZHcQdVmWGmddEkzvI1b5GWCYU8
         QT4KqPlk6e1ev2C3ZssNpla+XBt2cKE/Xf912dBufqLtvaAjAf+jFtPnQhW0dGpQlD
         Pp/ZfM9GXGjsBn/j87upAoqtxBWfGSotYAYYLww0y7DtgXGhz9/BMLmoi111p3Gmwv
         jX30+2C//PRRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E5ACE270E5;
        Fri, 21 Oct 2022 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf,
 docs: Reformat BPF maps page to be more readable
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166631761657.21240.15027158981960483313.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 02:00:16 +0000
References: <20221012152715.25073-1-donald.hunter@gmail.com>
In-Reply-To: <20221012152715.25073-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 12 Oct 2022 16:27:15 +0100 you wrote:
> Add a more complete introduction, with links to man pages.
> Move toctree of map types above usage notes.
> Format usage notes to improve readability.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/maps.rst | 101 ++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 36 deletions(-)

Here is the summary with links:
  - [bpf-next,v1] bpf, docs: Reformat BPF maps page to be more readable
    https://git.kernel.org/bpf/bpf-next/c/fb73a20ebe15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


