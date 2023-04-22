Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0E6EBA09
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDVPkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDVPkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 11:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE6F1BD5
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 08:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBBE861314
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 15:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41C20C4339B;
        Sat, 22 Apr 2023 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682178018;
        bh=nSd5XSDNmf8Yl88brbw0Q5Qd67MS2TdRfz3m0eb1Wwc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BIpWIwDhNGsNyOgi3Y1orZ+qgK0pYBkd7iYZtdIJcesDDUhJhXH0XhSGYdLl9PDRN
         cv/rIKGxKGmRtMIhveiELdePYbA6mgTCHZxYulDrF0IF1hSIkGl3jmD4kaA01J4/6x
         26qKfISGduzZGts0/pAxi9tJWFl4w2GOQdyri0gG7Ie2ESYFNRrD7vBtGcmQSMbMXC
         rVf3UAy9MGr9QIo1aZuwHIPgUtn8c1pHk9eXb0CZUi+lstk1b+wW3Z/CHHufQsYVZ6
         o2bsPp6nO/yFVlKRZx1l0sVEF26ICJfzEv7X63UUmBiihI9gS94BYQOg8yq8cMZFW1
         wFhXTpEJnVTwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D0BE270DB;
        Sat, 22 Apr 2023 15:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: verifier/prevent_map_lookup converted
 to inline assembly
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168217801814.24118.265370270108324343.git-patchwork-notify@kernel.org>
Date:   Sat, 22 Apr 2023 15:40:18 +0000
References: <20230421204514.2450907-1-eddyz87@gmail.com>
In-Reply-To: <20230421204514.2450907-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Apr 2023 23:45:14 +0300 you wrote:
> Test verifier/prevent_map_lookup automatically converted to use inline assembly.
> 
> This was a part of a series [1] but could not be applied becuase
> another patch from a series had to be witheld.
> 
> [1] https://lore.kernel.org/bpf/20230421174234.2391278-1-eddyz87@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: verifier/prevent_map_lookup converted to inline assembly
    https://git.kernel.org/bpf/bpf-next/c/35150203e30b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


