Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA0857A452
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiGSQuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiGSQuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 12:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E35649B6A
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 09:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C0961A59
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7D19C341CE;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658249415;
        bh=L4VsuKywMnZFtMiAgDdT3jUhiMjWGDbK+yybrCSa4JI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f4rSb1uhtGh4Dn+e276SHtL5NaBe9f5HYMNkmo1ugY3ekPCh15jFfCMkCOxspZySL
         6T/HyMtM5He+lN0t1q7NmnYKs5yomJcrPNbCoOkRxl4X1vu3SmN74MlEFnXLxbSnOo
         ddcylwrNCdlUpXNknrv3Cz5j+RbfTi+9PNMvJURC25ZFTWGV2tRlAivaWRFn3cBu5+
         iQJNQ9uvcAS8dIch12yX2r8TdqbyC8m8BzVSlnwlxDg5P9R26vSL1bz8HBhm1vOVqT
         Fgy385qUheY6UbsBQ8jyAnc/87pyZnXLbMik/tndrbHgU7O2kdDgjpo2iayituhGLC
         TsJtv9FFYAVEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9CE5E451BB;
        Tue, 19 Jul 2022 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] BPF array map fixes and improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165824941568.16633.17775134783985730826.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 16:50:15 +0000
References: <20220715053146.1291891-1-andrii@kernel.org>
In-Reply-To: <20220715053146.1291891-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 14 Jul 2022 22:31:42 -0700 you wrote:
> Fix 32-bit overflow in value pointer calculations in BPF array map. And then
> raise obsolete limit on array map value size. Add selftest making sure this is
> working as intended.
> 
> v1->v2:
>   - fix broken patch #1 (no mask_index use in helper, as stated in commit
>     message; and add missing semicolon).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] bpf: fix potential 32-bit overflow when accessing ARRAY map element
    https://git.kernel.org/bpf/bpf-next/c/87ac0d600943
  - [v2,bpf-next,2/4] bpf: make uniform use of array->elem_size everywhere in arraymap.c
    https://git.kernel.org/bpf/bpf-next/c/d937bc3449fa
  - [v2,bpf-next,3/4] bpf: remove obsolete KMALLOC_MAX_SIZE restriction on array map value size
    https://git.kernel.org/bpf/bpf-next/c/63b8ce77b15e
  - [v2,bpf-next,4/4] selftests/bpf: validate .bss section bigger than 8MB is possible now
    https://git.kernel.org/bpf/bpf-next/c/243164612005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


