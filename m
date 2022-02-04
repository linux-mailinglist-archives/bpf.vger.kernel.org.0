Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3704AA03E
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiBDTkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 14:40:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47240 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiBDTkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 14:40:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56E76CE223E;
        Fri,  4 Feb 2022 19:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93276C340EB;
        Fri,  4 Feb 2022 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644003608;
        bh=9qfZzVg17+0zHsBBjelWLlxfLLBlRWQoKqn8lLWN2lA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tRVNSkC8iIf9DhleNKya8hTSjN8l3TfMQkJb1pxyzPwQmcO6fUuyqBcGIMk6Uiswu
         smwCMJ+R9PeE38tHuWLRcRqusArIQoQpgU7NWRddGPs2apBZxhoz8mkLNQhO5Nlhuk
         1OZxxXtrJ1qe6GZWYuslj3Sx1kCIfosVd/Sr5v4gZ4oQOHz4O51oQxXkDqCcGQ2Jrd
         iHexdNPI4DxnJVQZWPXTiGw3ewliz9c+zMabDEs2INJC0dBdBUZugFOhPcGDW9+fN1
         ql3Ah8yrAqyrhZ2rr5lEO8QlWd6eKrr5nxjGABA+f+LaOi88w8RcaPynUK9mws7m3N
         CjDIseh8ngxFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78AFFC6D4EA;
        Fri,  4 Feb 2022 19:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] limit bpf_core_types_are_compat recursion
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164400360849.5213.7518261706290398971.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Feb 2022 19:40:08 +0000
References: <20220204005519.60361-1-mcroce@linux.microsoft.com>
In-Reply-To: <20220204005519.60361-1-mcroce@linux.microsoft.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, andrii@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Feb 2022 01:55:17 +0100 you wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> As formerly discussed on the BPF mailing list:
> https://lore.kernel.org/bpf/CAADnVQJDax2j0-7uyqdqFEnpB57om_z+Cqmi1O2QyLpHqkVKwA@mail.gmail.com/
> 
> changes from v2:
> test the bpf_core_type_exists() return value, and check that the recursion
> limit is enforced.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: limit bpf_core_types_are_compat() recursion
    https://git.kernel.org/bpf/bpf-next/c/e70e13e7d4ab
  - [bpf-next,v3,2/2] selftests/bpf: test maximum recursion depth for bpf_core_types_are_compat()
    https://git.kernel.org/bpf/bpf-next/c/976a38e05a49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


