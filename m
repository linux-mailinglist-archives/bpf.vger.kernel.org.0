Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7F531D94
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiEWVUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiEWVUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAF8E1BF;
        Mon, 23 May 2022 14:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 417D1614F3;
        Mon, 23 May 2022 21:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9675EC385AA;
        Mon, 23 May 2022 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653340811;
        bh=KpVOl6sTTTMSdwMKeBQ+rNG6QFT8GvV9wqoXCWKC1kk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eC8P8PEp53dbFijkViM2qWXeK78rMsvnAO0hU2RBBD2Ra1HQRn36xyEc2UF1KC6Bp
         5h6rNjFqoG49w9qIHXM9erZTPLycpSmJtST4D0xooyPV7/v2rQe2JKdALtOQYEBO4s
         GB9UjIu9kI2tWI9l6uHyf9ZvjFlkPbM3ZMfPl6ACaYy2X7bqYQTQ+z7f+jJiOppRKa
         yk2u1Dgt6Flexs2nN8qxAi0JHaSq5BP/IqNsnwliChGmVrvos8bQEt605WjvDp9PSv
         H6bWojryU3Um7u3imUYdv5UflyeLNCkX9i+sw4OVz3dy+93pMwenrEFNACGqq8keyU
         b/MNyDMlrSUoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71AA5F03935;
        Mon, 23 May 2022 21:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165334081146.9921.11212774683009494244.git-patchwork-notify@kernel.org>
Date:   Mon, 23 May 2022 21:20:11 +0000
References: <20220520235758.1858153-1-song@kernel.org>
In-Reply-To: <20220520235758.1858153-1-song@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 20 May 2022 16:57:50 -0700 you wrote:
> Changes v3 => v4:
> 1. Shorten CC list on 4/8, so it is not dropped by the mail list.
> 
> Changes v2 => v3:
> 1. Fix issues reported by kernel test robot <lkp@intel.com>.
> 
> Changes v1 => v2:
> 1. Add WARN to set_vm_flush_reset_perms() on huge pages. (Rick Edgecombe)
> 2. Simplify select_bpf_prog_pack_size. (Rick Edgecombe)
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/8] bpf: fill new bpf_prog_pack with illegal instructions
    https://git.kernel.org/bpf/bpf-next/c/d88bb5eed04c
  - [v4,bpf-next,2/8] x86/alternative: introduce text_poke_set
    https://git.kernel.org/bpf/bpf-next/c/aadd1b678ebe
  - [v4,bpf-next,3/8] bpf: introduce bpf_arch_text_invalidate for bpf_prog_pack
    https://git.kernel.org/bpf/bpf-next/c/fe736565efb7
  - [v4,bpf-next,4/8] module: introduce module_alloc_huge
    (no matching commit)
  - [v4,bpf-next,5/8] bpf: use module_alloc_huge for bpf_prog_pack
    (no matching commit)
  - [v4,bpf-next,6/8] vmalloc: WARN for set_vm_flush_reset_perms() on huge pages
    (no matching commit)
  - [v4,bpf-next,7/8] vmalloc: introduce huge_vmalloc_supported
    (no matching commit)
  - [v4,bpf-next,8/8] bpf: simplify select_bpf_prog_pack_size
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


