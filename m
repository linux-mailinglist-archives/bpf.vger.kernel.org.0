Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51B35AB258
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiIBN47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiIBN4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 09:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413985F9A3
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 06:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFB3620BD
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 13:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 260BFC43470;
        Fri,  2 Sep 2022 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662125415;
        bh=IGY+W2ex9PE5eB3W6TZ9UFvtM+euQB26qM+2a08CbO0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eUydsMBpy6vtJ5Y1pNO/TrClsi+z8z6jQLvNbT9lea5h1l3AdSIgsKvxzvFNJzRWl
         UPYBwLy/tu1zykSl5HfLHVqYmUsYLW7oKYh1rpHg7a6xT2oTo6DqckSeNDtXbn+t5B
         C8KaM4mDR0vX0lyIXEGZx4Z8IdrewWBXAtRNeTFK6Uv17YhQ+CWzxy6veSCScYpJIi
         XRJSWbQ8f1c3CP3ol9htr7D33JCcJpl5eNI7g/MR9q66jtAfisZslVTjWumReezhLI
         9YNOG4Q8COdiNM8zPtiwf2I7eAJiVT5fFxVOvY9RCRz4dMGdZBkJ9AfV9ObpQco8lR
         yqWZz2Ju0Ajhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BD40E924D6;
        Fri,  2 Sep 2022 13:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Support getting tunnel flags
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166212541503.23395.14569680525940531567.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Sep 2022 13:30:15 +0000
References: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
In-Reply-To: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, shmulik.ladkani@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 31 Aug 2022 17:40:09 +0300 you wrote:
> Existing 'bpf_skb_get_tunnel_key' extracts various tunnel parameters
> (id, ttl, tos, local and remote) but does not expose ip_tunnel_info's
> tun_flags to the bpf program.
> 
> It makes sense to expose tun_flags to the bpf program.
> 
> Assume for example multiple GRE tunnels maintained on a single GRE
> interface in collect_md mode. The program expects origins to initiate
> over GRE, however different origins use different GRE characteristics
> (e.g. some prefer to use GRE checksum, some do not; some pass a GRE key,
> some do not, etc..).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Support getting tunnel flags
    https://git.kernel.org/bpf/bpf-next/c/44c51472bef8
  - [bpf-next,2/2] selftests/bpf: Amend test_tunnel to exercise BPF_F_TUNINFO_FLAGS
    https://git.kernel.org/bpf/bpf-next/c/8cc61b7a6416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


