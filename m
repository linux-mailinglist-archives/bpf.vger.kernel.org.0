Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD835232B5
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiEKMKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiEKMKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 08:10:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA7A66CB
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 05:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34F52B82272
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D34ACC34115;
        Wed, 11 May 2022 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652271012;
        bh=FJzp1tSf2nGbZV7YjJSEXC+qUm3LSl6sW+SOGKyodhM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uGmkHcfo7Y3Hgq6v+feA87Z4GH9UocoIKk9PjmHdb6LQQd6R/iBmQrX7kf2qqU87A
         +6vw9Wa942K7xBFMm82piIQKrcilyKwTqeQ4OLV3ZkbmQnpRCxSqqJgMor88cJ5PEh
         76IK+a0NgW2ePax+9IiLuxwwMZ7OfUvITHOufpg+3TznR9qP+7CgfKU4QRUu+JAVfE
         g9ANXffHwbXmE6djr+QvlbEjcnxw6hDYpak2FhRfUPLhorQTqVB6BnxtWafkW2rMuy
         AXWBokOIZ6C8Ft2qKLECdb5lNKMvGWFu4u0lHWCF5B0mRW7oK2EnulLD3W8uuwkf4H
         oyUby1Pdk5TJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA641F03930;
        Wed, 11 May 2022 12:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: clean up ringbuf size adjustment
 implementation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165227101275.728.1910675031499859933.git-patchwork-notify@kernel.org>
Date:   Wed, 11 May 2022 12:10:12 +0000
References: <20220510185159.754299-1-andrii@kernel.org>
In-Reply-To: <20220510185159.754299-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, nathan@kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 10 May 2022 11:51:59 -0700 you wrote:
> Drop unused iteration variable, move overflow prevention check into the
> for loop.
> 
> Fixes: 0087a681fa8c ("libbpf: Automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: clean up ringbuf size adjustment implementation
    https://git.kernel.org/bpf/bpf-next/c/5eefe17c7ae4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


