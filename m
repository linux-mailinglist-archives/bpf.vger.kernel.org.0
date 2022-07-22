Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0949957E42D
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiGVQKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiGVQKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3912AF9
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98A74B8296C
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 16:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41A0BC341CA;
        Fri, 22 Jul 2022 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658506213;
        bh=g7NoW9RkJjVElPX9fhT38rJdszbamPMF6I0cSskzYQA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RIHBoCTLWGeWv8koYE7v8VMV5pCOw6iNp6BjJbh/yCNSHLpBYlOqSpo8Q29/Nh0hm
         5oqhmlvJFB05/SKMVNno0tM4TxKo6WyXx8aufXyttBk54eFA1Y+KvzPk83SZ8fj9eo
         /si5jjmm2k1lEnMXvFGGT9Yl9rophWGPG2T80BWN7kSNWTxxAu0CcoikYOFDuhRqDb
         m7ZcOhJ0sMjN+CaH0452l763Mil1Em7IyI2reW/rXE8BYfHupBOEa1deijBY7kU8K3
         F8fAbmL76O0zBkdJBdDiyV4emcqU1P3ABtMxZnYhhscwhRohckQwmSDiIhXrvSOhUC
         JoYJHGjt7eF3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F902E451B3;
        Fri, 22 Jul 2022 16:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix build error in case of
 !CONFIG_DEBUG_INFO_BTF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165850621312.4113.2075596582687623102.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 16:10:13 +0000
References: <20220722113605.6513-1-memxor@gmail.com>
In-Reply-To: <20220722113605.6513-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, lkp@intel.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 Jul 2022 13:36:05 +0200 you wrote:
> BTF_ID_FLAGS macro needs to be able to take 0 or 1 args, so make it a
> variable argument. BTF_SET8_END is incorrect, it should just be empty.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: ab21d6063c01 ("bpf: Introduce 8-byte BTF set")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix build error in case of !CONFIG_DEBUG_INFO_BTF
    https://git.kernel.org/bpf/bpf-next/c/e42341437586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


