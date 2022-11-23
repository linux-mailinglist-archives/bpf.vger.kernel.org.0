Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CAB636C97
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiKWVuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiKWVuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DB391DC;
        Wed, 23 Nov 2022 13:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7EAF61EF6;
        Wed, 23 Nov 2022 21:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19DC9C433D7;
        Wed, 23 Nov 2022 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669240216;
        bh=3IvjOhpLwY8E04jMOjqOKEJf+tfwBXK+QgyiSFSrKas=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aRPYjaB1L/sCTFvU54rf+OYNjQ7FOqaFSNst2LtGe74CptT1AUoSv5S0j5p3dsBGO
         dRu57ok4qXizsugtrWttVSHnbAbmd5jxfkWWltBwTRa6QSKhAMRE2Am7IDNFhNnq6R
         an5uB0Ot0Bw6jJlZ5yNDCkpuZlvqis2HZ+Cv3+79RIxEPLT4b78C4+i6RcCTo5yrFU
         8osy5Hx9NMCcypfLm+1zi76I8K6DUFn6RTkevAl7m8YfCrRCQNDOOS3QXfHXGATGrb
         qH68PSvR4KxK30PfTOd++VkosgBT8YP2bAcjBmS7v7H4QwZCNgoSQSdJWDFFqX2obn
         BXPYPke2HUbIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0388C395C5;
        Wed, 23 Nov 2022 21:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] docs: fix sphinx warnings for cpu+dev maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166924021591.18548.16235386943960699108.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Nov 2022 21:50:15 +0000
References: <20221123092321.88558-1-mtahhan@redhat.com>
In-Reply-To: <20221123092321.88558-1-mtahhan@redhat.com>
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, akiyks@gmail.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 23 Nov 2022 09:23:19 +0000 you wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Sphinx version >=3.1 warns about duplicate function declarations in the
> CPUMAP and DEVMAP documentation. This is because the function name is the
> same for Kernel and User space BPF progs but the parameters and return types
> they take is what differs. This patch moves from using the ``c:function::``
> directive to using the ``code-block:: c`` directive. The patches also fix
> the indentation for the text associated with the "new" code block delcarations.
> The missing support of c:namespace-push:: and c:namespace-pop:: directives by
> helper scripts for kernel documentation prevents using the ``c:function::``
> directive with proper namespacing.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] docs: fix sphinx warnings for cpumap
    (no matching commit)
  - [bpf-next,v3,2/2] docs: fix sphinx warnings for devmap
    https://git.kernel.org/bpf/bpf-next/c/c645eee4d35b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


