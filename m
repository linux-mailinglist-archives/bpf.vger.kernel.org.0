Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4633A4E1F06
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 03:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbiCUCbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 22:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiCUCbg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 22:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6BC57B11
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 19:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20F6760AC6
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 02:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79767C340F0;
        Mon, 21 Mar 2022 02:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647829810;
        bh=jn+ZS4MRrMe3on1CtY8bvqXksmATCd31tlGIKz6tUtg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IvRo6ttpIRFjB8sfiY4IcElQ/fD9rDmRC0wbP4RMejyr+bE0uMZSn70m8UHnOo776
         BeBXVT8c1XkuaM4TRxK3IVRXJ6G95hlX2XXJfK7tFtt0b9hKsjXmI0EfiBPT4dJ2ik
         spDE6Wvs+KNAJ/JYUqe1YcUcYneJg8rsc4T3T4iySW0v4y9wKJB9dftnOs7MxnYD9a
         zd3kGutOrfJiEZHzftINKTMdu0T6+lzd6JYuCJ/AOgSSKn7Qqzbzvwf3AI2unzdkDc
         LldiTn+DIvHeLUdFgAuOw3oNNVuVXIz5kH5HEihGb7HnC4tMX3iTDQoBrbMdtc+Ut0
         JmU6Zyx/FiyaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59704E6D402;
        Mon, 21 Mar 2022 02:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Check for NULL return from bpf_get_btf_vmlinux
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164782981036.13314.5384980131744260251.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Mar 2022 02:30:10 +0000
References: <20220320143003.589540-1-memxor@gmail.com>
In-Reply-To: <20220320143003.589540-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, oliver.sang@intel.com
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sun, 20 Mar 2022 20:00:03 +0530 you wrote:
> When CONFIG_DEBUG_INFO_BTF is disabled, bpf_get_btf_vmlinux can return a
> NULL pointer. Check for it in btf_get_module_btf to prevent a NULL pointer
> dereference.
> 
> While kernel test robot only complained about this specific case, let's
> also check for NULL in other call sites of bpf_get_btf_vmlinux.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Check for NULL return from bpf_get_btf_vmlinux
    https://git.kernel.org/bpf/bpf-next/c/7ada3787e91c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


