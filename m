Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769F158A2E6
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiHDVuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiHDVuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 17:50:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E54EBC85
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 14:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 128FDCE28BE
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 21:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28BEEC43470;
        Thu,  4 Aug 2022 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659649814;
        bh=T7Tx+SMJmfQ9MTGn84aFTyek2IMvpHZJ+zAYOxoxNq8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F50qsufXXwk7Dkro7jYUCb2JNP9g8MpFdo1UkEzuF5Tu9qndmCgZGLHxV3bDPic2r
         +0VzkJt2bRBghxIHU+wV3LvSMUCZWnmmpZP6V5wx6u4mW5Bl6UgB90bsC07G1cOoym
         E6Zi68igTzy2kk1z+onFPkfWHkgHS3XwLmcp9LxFjhBbgAJVHK55uvbmcQYdOkpKvY
         QEdyvpmB0r4OtpcYnWpjmH5dRSyDBKxgRzEAeOrbEyGdxcpgDWR+gxH8fNvJEMXezN
         gSTqrduRY1wRC4CJaHcwy9jRa0CJ0xTEhMQ/S4uuQ8yaLjxFStQWyjPhxV7vAQpGpQ
         Eqo/HccaSdZQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F3D5C43144;
        Thu,  4 Aug 2022 21:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpftool: Remove BPF_OBJ_NAME_LEN restriction when
 looking up bpf program by name
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165964981405.20332.11284599187562360198.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Aug 2022 21:50:14 +0000
References: <20220801132409.4147849-1-chantr4@gmail.com>
In-Reply-To: <20220801132409.4147849-1-chantr4@gmail.com>
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, quentin@isovalent.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  1 Aug 2022 06:24:09 -0700 you wrote:
> bpftool was limiting the length of names to BPF_OBJ_NAME_LEN in prog_parse
> fds.
> 
> Since commit b662000aff84 ("bpftool: Adding support for BTF program names")
> we can get the full program name from BTF.
> 
> This patch removes the restriction of name length when running `bpftool
> prog show name ${name}`.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpftool: Remove BPF_OBJ_NAME_LEN restriction when looking up bpf program by name
    https://git.kernel.org/bpf/bpf-next/c/d55dfe587bc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


