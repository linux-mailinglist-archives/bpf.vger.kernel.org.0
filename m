Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0024D4D58C4
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 04:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiCKDVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 22:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiCKDVP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 22:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7951A8057;
        Thu, 10 Mar 2022 19:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A486761274;
        Fri, 11 Mar 2022 03:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEDEBC340EE;
        Fri, 11 Mar 2022 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646968813;
        bh=gGmYQbRI5pcR1fAq//sQK1FgAHXuq9lDHXprS421ggw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ufq0Nkb1UySW/gJdWtmM9NYkzRh4aua/chnCk04EhcfCB4FnnnhP7nmAW5//UosCr
         Ro0TLrhUa4wpr2vKTQNRhNIi6WucFMfZ3lBUT6hmTxuzs7CGOgmV4yFWiP1ExUkfhi
         ZkQ7t8fcWVWLcvtupzQ4m5Upd2bgOw+5KS8NlikPQHEbphe17SewURbslvrzEYresm
         jd1I/FFSroV5j9U+gIacTZ7cQg6t5c65NQkp+Sv8iN6NxGnC5JCw8WoKWfr2G6Ibbs
         Ul3KIz4jHi63OjbVooJ/i/iRCsiLrPdoA7KdqSG/boI/oR1OAcK4j4m8tIXqwtlJxZ
         fYZL4/l+cqEBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C97D5E8DD5B;
        Fri, 11 Mar 2022 03:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] compiler_types: Refactor the use of btf_type_tag
 attribute.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164696881282.12219.14234738746999653224.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Mar 2022 03:20:12 +0000
References: <20220310211655.3173786-1-haoluo@google.com>
In-Reply-To: <20220310211655.3173786-1-haoluo@google.com>
To:     Hao Luo <haoluo@google.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 10 Mar 2022 13:16:55 -0800 you wrote:
> Previous patches have introduced the compiler attribute btf_type_tag for
> __user and __percpu. The availability of this attribute depends on
> some CONFIGs and compiler support. This patch refactors the use
> of btf_type_tag by introducing BTF_TYPE_TAG, which hides all the
> dependencies.
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [bpf-next] compiler_types: Refactor the use of btf_type_tag attribute.
    https://git.kernel.org/bpf/bpf-next/c/6789ab9668d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


