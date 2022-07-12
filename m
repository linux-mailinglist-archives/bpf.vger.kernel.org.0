Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6075E57297D
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 00:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiGLWuP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 18:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGLWuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 18:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D1CA6E3;
        Tue, 12 Jul 2022 15:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D89EF616BF;
        Tue, 12 Jul 2022 22:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A5EAC341C0;
        Tue, 12 Jul 2022 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657666213;
        bh=Fw2HVl5pOOx14EuTz+/2ML5JWynn7CkeflqoQrb4fiI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sjS77mO/0R7Jmh1itiZeo1B52QQI8X9j3NAQl4yYs0sjCBEgBkR9KVIg2NRxEtJ9a
         YuRzxHnnnWSAVJKASs98F7SGBZBAhAWHqcr9SVmATkhxKMma4rGTKzQJRgoDhsIQAc
         eVHcZDzzgGIawAcgVmS/r7Run0EXaH8ED5Ehch+YLIPu6YIiDfzbnDm6CO57K28E9C
         vgLlwWUEuoJaaD7w9Tj4kXfPZF1gyFW86YUzr8IDGuASiqtVV1VTUYWKase5AwkM49
         vTP7yVBGT0MjKRSI3ay/HjiGC00E6tV9FRL6SakV8o/Pl4F2/y8nb9O7dJzvGhjTu/
         XacloXLzszbZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12239E45227;
        Tue, 12 Jul 2022 22:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: reparent bpf maps on memcg offlining
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165766621306.6916.10461037448631832100.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Jul 2022 22:50:13 +0000
References: <20220711162827.184743-1-roman.gushchin@linux.dev>
In-Reply-To: <20220711162827.184743-1-roman.gushchin@linux.dev>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     bpf@vger.kernel.org, shakeelb@google.com, ast@kernel.org,
        linux-kernel@vger.kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Jul 2022 09:28:27 -0700 you wrote:
> The memory consumed by a mpf map is always accounted to the memory
> cgroup of the process which created the map. The map can outlive
> the memory cgroup if it's used by processes in other cgroups or
> is pinned on bpffs. In this case the map pins the original cgroup
> in the dying state.
> 
> For other types of objects (slab objects, non-slab kernel allocations,
> percpu objects and recently LRU pages) there is a reparenting process
> implemented: on cgroup offlining charged objects are getting
> reassigned to the parent cgroup. Because all charges and statistics
> are fully recursive it's a fairly cheap operation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: reparent bpf maps on memcg offlining
    https://git.kernel.org/bpf/bpf-next/c/cbddef2759b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


