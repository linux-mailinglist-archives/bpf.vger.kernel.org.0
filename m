Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550FE632E4E
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 22:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKUVAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 16:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUVAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 16:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41976CC142
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 13:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D30866147A
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BED2C433C1;
        Mon, 21 Nov 2022 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669064416;
        bh=LEmczhYwKFc3yd6L3h1dGxSmGAYfBuJu/YFu62cvfhA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nRhSkMIuEebiWw+Egw9TzL+fvxvK3hpg7kJMSpiCc46snpdF/VHnzB2uQsKCdtPsG
         DF9IhzR7gSskvGQQKMNMxv2xB+d2xld9cEGwHHK806MQXsWdL4q88wW8Kj6d5+bkG0
         OVgy8srdhR/3mU/pFIklhle+VGBVWyY6nJS2yMsGwslKoAEqOb36GVllltk+/jzRwM
         uazPNTAWjiiR9Bbet9YMoan259hl8pByZHsmiozV2hb9BnSCoTWReo0p9JRQk1Gjv+
         X4IM8B/0xZX4eF180Vp58l/6zn6ymv9+GPra67vRZT6tbnyEHGR37/I5VnzUln5otr
         ZLO0W3heOIniQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C353E29F3E;
        Mon, 21 Nov 2022 21:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Move skb->len == 0 checks into
 __bpf_redirect
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166906441604.30065.754596253753413287.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Nov 2022 21:00:16 +0000
References: <20221121180340.1983627-1-sdf@google.com>
In-Reply-To: <20221121180340.1983627-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 21 Nov 2022 10:03:39 -0800 you wrote:
> To avoid potentially breaking existing users.
> 
> Both mac/no-mac cases have to be amended; mac_header >= network_header
> is not enough (verified with a new test, see next patch).
> 
> Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_len")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Move skb->len == 0 checks into __bpf_redirect
    https://git.kernel.org/bpf/bpf-next/c/114039b34201
  - [bpf-next,v2,2/2] selftests/bpf: Make sure zero-len skbs aren't redirectable
    https://git.kernel.org/bpf/bpf-next/c/68f8e3d4b916

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


