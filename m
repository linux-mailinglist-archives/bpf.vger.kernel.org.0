Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A333574405
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 06:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiGNE64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiGNE6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 00:58:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17B205CC;
        Wed, 13 Jul 2022 21:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 114C4B82377;
        Thu, 14 Jul 2022 04:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11DADC34115;
        Thu, 14 Jul 2022 04:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657774213;
        bh=m7PhMhDaB+rsIpWOHAt562bNIHAgmxiuIBDn9m701Gw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gPprn9ThbFA/wgJNmd7Zx2hz3lpMYT3qAsMFlWE9ZBZqhR3mGc2B1mUd6tvmlFZIy
         /sekCqEXqCko5Ut6mvGYA+NTCbWrPdPUh6rC9z/jKAhGwk7OvTaXYi4LByXdNMIlHa
         nMAKk28itHcjwXtG0FjHoi6uD3rNqSK/8heaCMewwY3BRedC6B4KVbAx1YXcBmEo9y
         XNB0EgmKN2Ophu1Y4M1dZX0Nko5hggOQ+tOtv6SPCgErdufdb9Pgw5G0mHsAG/nD98
         GDZ2vioNJ77HwrLIc3AXSeI0xcHi0JHt9ZA+3FPCOjF5HyqizMgOl2UOPCr3fbfUJr
         CPCEyRjOFc1vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8E6EE45225;
        Thu, 14 Jul 2022 04:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples: bpf: Replace sizeof(arr)/sizeof(arr[0]) with
 ARRAY_SIZE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165777421294.18735.2142546131843554603.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Jul 2022 04:50:12 +0000
References: <20220712072302.13761-1-xiaolinkui@kylinos.cn>
In-Reply-To: <20220712072302.13761-1-xiaolinkui@kylinos.cn>
To:     xiaolinkui <xiaolinkui@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Jul 2022 15:23:02 +0800 you wrote:
> From: Linkui Xiao<xiaolinkui@kylinos.cn>
> 
> The ARRAY_SIZE macro is more compact and more formal in linux source.
> 
> Signed-off-by: Linkui Xiao<xiaolinkui@kylinos.cn>
> ---
>  samples/bpf/fds_example.c          | 3 ++-
>  samples/bpf/sock_example.c         | 3 ++-
>  samples/bpf/test_cgrp2_attach.c    | 3 ++-
>  samples/bpf/test_lru_dist.c        | 2 +-
>  samples/bpf/test_map_in_map_user.c | 4 +++-
>  samples/bpf/tracex5_user.c         | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)

Here is the summary with links:
  - samples: bpf: Replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE
    https://git.kernel.org/bpf/bpf-next/c/b1fc28b33886

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


