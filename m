Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54B9509295
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 00:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354105AbiDTWXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 18:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353886AbiDTWXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 18:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CE2AC79
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 15:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4674861A01
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 22:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D04DC385A8;
        Wed, 20 Apr 2022 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650493211;
        bh=WWaeOVV8bVCCKvQwL52GnIGw8bJwlHMNv7JATzMA6ME=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pt2m7DUXZVEtaGfzW0lCG3xNmg/Vq0YI+XuBS1YNQTxmxL+QdWOKwRx3ZZwaZ4sAi
         NnFEbjArL84VaNV4zmVVamtIaIWFEWbPC1zfzy6z2tAQVJwt9pGFqYSt7OwXcqt3iT
         ISHBRi2pzo8JzNPZqWKimQkMq878w/fe13vNTQQBK6YpDYBzPSwEzOPqjBgicXSgyU
         4GakSlo6sSR/b4ssw/xsuyuuUe+wmELaAHyyl9TrpJljdQVTlA6EYhPvb+lZSMxGk5
         +XzLo+NFjbfBYyRbOMyaXmK37mRb0PLtHeaDcFAt9E/r/jZJq4KWEp1xX5ADtCVVUa
         A4wEkLHkeC/MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FD97E8DBD4;
        Wed, 20 Apr 2022 22:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/3] Add error returns to two API functions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165049321152.7547.10986845932513270415.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 22:20:11 +0000
References: <20220420161226.86803-1-grantseltzer@gmail.com>
In-Reply-To: <20220420161226.86803-1-grantseltzer@gmail.com>
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, song@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 20 Apr 2022 12:12:24 -0400 you wrote:
> From: Grant Seltzer <grantseltzer@gmail.com>
> 
> This adds an error return to the following API functions:
> 
> - bpf_program__set_expected_attach_type()
> - bpf_program__set_type()
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] Add error returns to two API functions
    https://git.kernel.org/bpf/bpf-next/c/d9a51c964771
  - [bpf-next,v4,2/3] Update API functions usage to check error
    https://git.kernel.org/bpf/bpf-next/c/042b971bd9a3
  - [bpf-next,v4,3/3] Add documentation to API functions
    https://git.kernel.org/bpf/bpf-next/c/e1a34e19ea96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


