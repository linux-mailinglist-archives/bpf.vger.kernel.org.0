Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4647524176
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349622AbiELAUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 20:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348217AbiELAUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 20:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E616608C
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 17:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F75CB826A6
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44F83C34115;
        Thu, 12 May 2022 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652314813;
        bh=RLRYi0a6wglrCotp7Wp9NrZKiRXUv8j3476zTwodThE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rCXsclBMDhjYgrJ/MPtq6t2GZpRVrbJqnge09+BfawId1m3fMLEdPEBBTpD4KIo2v
         92IT4+Cnj/QHDHGqKsRiGfLrbD8HToTJl3cAiWjXLvsONRAqKrBzGZdgp0z6tADIhU
         tyBfPvzCZl9283rRWKsfvFnxoCye0iuObaEaE8L998FZxpBxhjUCjxWYX+n7yI/nJO
         Aq3kh9zx9gmC/kS/LczYCHr3VbtrnshOiVLPceb6gduQy3QYdaloj2gudv+0jselei
         CjBZh0G4w9wRoyya1V7EXrvtchqPgEUuE3sfznFCuKSmYqcDNRB3IaUOmlHGmSXc14
         C4mtGK3bljoXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2659FE8DBDA;
        Thu, 12 May 2022 00:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Follow ups for kptr series
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165231481315.29941.17197172445442138372.git-patchwork-notify@kernel.org>
Date:   Thu, 12 May 2022 00:20:13 +0000
References: <20220511194654.765705-1-memxor@gmail.com>
In-Reply-To: <20220511194654.765705-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 May 2022 01:16:50 +0530 you wrote:
> Fix a build time warning, and address comments from Alexei on the merged
> version [0].
> 
>   [0]: https://lore.kernel.org/bpf/20220424214901.2743946-1-memxor@gmail.com
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: Fix sparse warning for bpf_kptr_xchg_proto
    https://git.kernel.org/bpf/bpf-next/c/5b74c690e1c5
  - [bpf-next,v2,2/4] bpf: Prepare prog_test_struct kfuncs for runtime tests
    https://git.kernel.org/bpf/bpf-next/c/5cdccadcac26
  - [bpf-next,v2,3/4] selftests/bpf: Add negative C tests for kptrs
    https://git.kernel.org/bpf/bpf-next/c/04accf794bb2
  - [bpf-next,v2,4/4] selftests/bpf: Add tests for kptr_ref refcounting
    https://git.kernel.org/bpf/bpf-next/c/0ef6740e9777

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


