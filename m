Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06486EB179
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDUSUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDUSUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 14:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE413E
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 11:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B98063C6B
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E064AC433D2;
        Fri, 21 Apr 2023 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682101220;
        bh=aYvFmp7DXLuA/ozHwTlVs722tHaQSJMWL27jU5QXyVQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n8D9ZIgA+Ke/0tyDo1xJtv5I4tulescjOjYKGJ+kp7YNaUIqAv0xlkTiJ1dbSOU+E
         I6swJf+vqZ4s3TN+dLaTe1ty7wryhjr0kbVNhMiQmUB4fxQFC9BgrYAaZxlxZcj88S
         vwsSVeFmPBmNp0hEJgPcCSGLGN2Y9H9x9v7/1VfrjTNQmFjZuxyUzuvYA4EiZcwM1m
         EP5yVkuvPerizTVXigyfMWE+IObkIcX54dvH45cSzNSqT1/mYoBJ+eDKtogK4fSo/9
         KfixOLRvMTNTYcVTUwQIUGnjN3o3nR6aM7tLGxqZjFXvS3xhyL5Y6Bvh8g0MNGLsEU
         VFXUNQOo8dwUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C030AE270DB;
        Fri, 21 Apr 2023 18:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Register struct_ops with a link.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168210121978.28314.15375823140972222895.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Apr 2023 18:20:19 +0000
References: <20230420002822.345222-1-kuifeng@meta.com>
In-Reply-To: <20230420002822.345222-1-kuifeng@meta.com>
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, quentin@isovalent.com, kuifeng@meta.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Apr 2023 17:28:21 -0700 you wrote:
> You can include an optional path after specifying the object name for the
> 'struct_ops register' subcommand.
> 
> Since the commit 226bc6ae6405 ("Merge branch 'Transit between BPF TCP
> congestion controls.'") has been accepted, it is now possible to create a
> link for a struct_ops. This can be done by defining a struct_ops in
> SEC(".struct_ops.link") to make libbpf returns a real link. If we don't pin
> the links before leaving bpftool, they will disappear. To instruct bpftool
> to pin the links in a directory with the names of the maps, we need to
> provide the path of that directory.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpftool: Register struct_ops with a link.
    https://git.kernel.org/bpf/bpf-next/c/0232b7889786
  - [bpf-next,v3,2/2] bpftool: Update doc to explain struct_ops register subcommand.
    https://git.kernel.org/bpf/bpf-next/c/45cea721ea36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


