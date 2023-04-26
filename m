Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224756EF9F5
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjDZSUZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjDZSUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 14:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23983CA
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372F260D2C
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 18:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E406C433D2;
        Wed, 26 Apr 2023 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682533223;
        bh=igS+UJrLnFMDAPj2INb0+JBFYL/hAfruiOha77+EtTg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pRXTgN6cU/kTiNpHwBlNZSwn1bLYpb0jO+KqiFHNo+bYoQl56vDiXboB30KNU6Tk+
         E/rILL3smI/zIR5PdAkl31HVmT6W3vilXYkWV1XXJmCIKkpaThF5O0pHoOdsImr3zC
         w4o3o5cNf79+nKC1mMcymN/Bw8O5DA/5VHa1BNRnmlub34SWKAt4p+FCWW4fniXA+q
         cwcGuYTC1BDH6ve1OdmQ6vSLD/7m0LoDKg+v/jH+clQ5UtnpQSU9N8L2fHd7wFGkE2
         qC7eQ5spIV+2UDa9PyLZ39baOq3X/DMWXhmKCQcvwKUrBYzvy7E0owbTAFay8YMoYb
         BFSJVJPph1D5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A471E5FFC9;
        Wed, 26 Apr 2023 18:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/5] Dynptr helpers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168253322356.27666.5904288983945706497.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Apr 2023 18:20:23 +0000
References: <20230420071414.570108-1-joannelkoong@gmail.com>
In-Reply-To: <20230420071414.570108-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 20 Apr 2023 00:14:09 -0700 you wrote:
> This patchset is the 3rd in the dynptr series. The 1st (dynptr
> fundamentals) can be found here [0] and the second (skb + xdp dynptrs)
> can be found here [1].
> 
> This patchset adds the following helpers for interacting with
> dynptrs:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/5] bpf: Add bpf_dynptr_adjust
    https://git.kernel.org/bpf/bpf-next/c/a18ce61a6c1f
  - [v2,bpf-next,2/5] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
    https://git.kernel.org/bpf/bpf-next/c/8365e486d6b1
  - [v2,bpf-next,3/5] bpf: Add bpf_dynptr_size
    https://git.kernel.org/bpf/bpf-next/c/8acc1b16a56f
  - [v2,bpf-next,4/5] bpf: Add bpf_dynptr_clone
    https://git.kernel.org/bpf/bpf-next/c/cdb12a71426d
  - [v2,bpf-next,5/5] selftests/bpf: add tests for dynptr convenience helpers
    https://git.kernel.org/bpf/bpf-next/c/a63fcb5ba776

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


