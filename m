Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5FD6B571D
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 01:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCKAxX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 19:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCKAxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 19:53:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44826146F1A
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 16:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A0961D7F
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 00:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E707C4339C;
        Sat, 11 Mar 2023 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678495818;
        bh=4Sb8gMDP1pkkmrFMoK4DMipF0lo+Z4hvXgk5lCnJL3k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fpGWwPNnPCT7VfbntpPdNRMhNtHlq2aSn4yIwPh+esLzEmfReA9rE0pgQiN3BoT1a
         nit/j2sLzWHkMdkANVRmMqKikfKTtDKSWKxc7iBD8q8gvx19qxqbLWvAN1vOzPojlJ
         iytVikzo6BJwBOPgtB00XVd1dsn1irrnUbRyuu9o8itwRbAmAP0LYx8usT5igPZvDZ
         OgaZqtNhlb3h0uSjE1uT9NUh3jG/ILmDr272FfyEfWR8t6Gf/ZOx9wIxg/QiBTl9ZH
         Kbl6x7M1dJVxn/n+wKk7MucK04luI3Z3fp6bJEhSBUVFF38ALNFD8zOKj8Vs+Zyp5i
         wJGtjzsXY4NkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66730E21EEB;
        Sat, 11 Mar 2023 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Support stashing local kptrs with
 bpf_kptr_xchg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167849581841.26321.14560380151655803188.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Mar 2023 00:50:18 +0000
References: <20230310230743.2320707-1-davemarchevsky@fb.com>
In-Reply-To: <20230310230743.2320707-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
        tj@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Mar 2023 15:07:40 -0800 you wrote:
> Local kptrs are kptrs allocated via bpf_obj_new with a type specified in program
> BTF. A BPF program which creates a local kptr has exclusive control of the
> lifetime of the kptr, and, prior to terminating, must:
> 
>   * free the kptr via bpf_obj_drop
>   * If the kptr is a {list,rbtree} node, add the node to a {list, rbtree},
>     thereby passing control of the lifetime to the collection
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpf: Support __kptr to local kptrs
    https://git.kernel.org/bpf/bpf-next/c/c8e187540914
  - [v2,bpf-next,2/3] bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg
    https://git.kernel.org/bpf/bpf-next/c/738c96d5e2e3
  - [v2,bpf-next,3/3] selftests/bpf: Add local kptr stashing test
    https://git.kernel.org/bpf/bpf-next/c/5d8d6634cccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


