Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD94DA50B
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiCOWLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCOWLX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:11:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1831DE5
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F1CB612F0
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D85E2C340F4;
        Tue, 15 Mar 2022 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647382209;
        bh=WQZnqjYjCEG2fLD/GcqDnUHbFMF8hejIB6ZLfg25D+Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PN3psbZYq4Xv5gksV6Ws9teBIbuMvLksbzdZfVryt0fDWOBAD0XJd4Yk3JYjvnCDO
         hek+wzLEqZsRhwRuQsSmvDK0YAah7FOFt8ZumWc/r+WuvvAlQfshnoxup9rYF9lcNv
         12dYWUoj0HwkHVKFcbRuyjLTewIjTfQ2RoMxsFbPrWZMCL8VgNVFIYY+2TeJnh8FIL
         w6G37ebVAcv2+q6hO/mGnYYlJ23wtv/HeCNrvawGLSsAkffL1Vy3EHCM8fcxVbmTeY
         rLoeZ+7A+01IIL493gtMfTEwFiEtJLPahFy9K8b/x2lO+LWc9+didSGVgcEPIZLx53
         95O5CEwiTi2yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B107DE6BBCA;
        Tue, 15 Mar 2022 22:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164738220972.10122.15428582260020075303.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Mar 2022 22:10:09 +0000
References: <20220309163112.24141-1-9erthalion6@gmail.com>
In-Reply-To: <20220309163112.24141-1-9erthalion6@gmail.com>
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Mar 2022 17:31:12 +0100 you wrote:
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6] bpftool: Add bpf_cookie to link output
    https://git.kernel.org/bpf/bpf-next/c/cbdaf71f7e65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


