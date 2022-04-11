Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67204FB240
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 05:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244518AbiDKDWb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Apr 2022 23:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244503AbiDKDW0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Apr 2022 23:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8D319C3B
        for <bpf@vger.kernel.org>; Sun, 10 Apr 2022 20:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4472D6119F
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 03:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 966E5C385A1;
        Mon, 11 Apr 2022 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649647212;
        bh=DiVFO1a7EloJvrxmaF7LDtYS0w82Jb5XviAOSoFSw60=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DR4gw9DnNR8nTOZE2rWI1mL9odUWIX7m18XzcKIlOrX3C/kGkqUQxYOhAK8ke6ekK
         OTbqqh8Y8rKhPgQXbi8VUjlzH0YO/71B0Wmmh7IJVSlcPzH7424K9zCB3YlKYDZTse
         +dDTRCEsT+ZeE+YB3+YtamsvZsdsp8ZeysVnanp4GNhcG58UDF2x9xohZi9lJvtpPi
         4ip90EH+ddf7EUBt3AU9E8d08+coSFvY4Qhvw4UymZwLibRmbQKzchK9nu8yLDhEN5
         QwgLHpN/En0UhGNNG2H6naTzdmKtZRY3eyFvkOw/h2hiTfsSp5NEIrdJHsEO5qNuK7
         PUxOTi4UEE5ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77476E85D90;
        Mon, 11 Apr 2022 03:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Improve by-name subtest selection
 logic in prog_tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164964721248.11578.15349522791359121624.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 03:20:12 +0000
References: <20220409001750.529930-1-mykolal@fb.com>
In-Reply-To: <20220409001750.529930-1-mykolal@fb.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 8 Apr 2022 17:17:49 -0700 you wrote:
> Improve subtest selection logic when using -t/-a/-d parameters.
> In particular, more than one subtest can be specified or a
> combination of tests / subtests.
> 
> -a send_signal -d send_signal/send_signal_nmi* - runs send_signal
> test without nmi tests
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: Improve by-name subtest selection logic in prog_tests
    https://git.kernel.org/bpf/bpf-next/c/61ddff373ffa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


