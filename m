Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C661054F8EE
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382617AbiFQOKP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382707AbiFQOKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 10:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D253FDBB
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 07:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E3860F4E
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 14:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD9FC3411B;
        Fri, 17 Jun 2022 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655475013;
        bh=rDUL4UbUSNaK2ihdzru8eA6BCUV2dSrQMdVvC9bxR3w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o5kfdSbw3cPUGdclQUl6NWXnZpqTgAGBIh5/9MNm9BhQxzCO5/Hd6n7w+/TnLuVgV
         cZtwP5hZc5JsEMrI0mjgZ9p915BPlgTCJW3jPuLwcQVVdjva4/WXsvnFzbSV58oyrs
         GGkCpVNqo1ibq9xqGmTfNSYW/tYBrp6ynEgPvQeV3ppnNG0TMZ3Y7PNrQNXQoZiVDL
         vr+GjNa0sPFrmQQHRQFQAQ26UBvYqYpG8YR0UKaunuyIyN94Aj8jeLLqP1ZfcCXf0F
         zkJuW/1dFODOImBuMvQez8mVDaFgo/c9jpOfHhFGwRUv5ytrcS+Ho0IGhGqYlU9FsX
         99AAXgO8uxzWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 044C7FD99FF;
        Fri, 17 Jun 2022 14:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix non-static bpf_func_proto struct
 definitions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165547501301.23531.3092605776725231913.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 14:10:13 +0000
References: <20220616225407.1878436-1-joannelkoong@gmail.com>
In-Reply-To: <20220616225407.1878436-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
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

On Thu, 16 Jun 2022 15:54:07 -0700 you wrote:
> This patch does two things:
> 
> 1) Marks the dynptr bpf_func_proto structs that were added in [1]
> as static, as pointed out by the kernel test robot in [2].
> 
> 2) There are some bpf_func_proto structs marked as extern which can
> instead be statically defined.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix non-static bpf_func_proto struct definitions
    https://git.kernel.org/bpf/bpf-next/c/dc368e1c658e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


