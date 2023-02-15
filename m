Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8C69851B
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBOUA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBOUAZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 15:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB193F1
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 12:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659AAB823AF
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 20:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03D83C4339B;
        Wed, 15 Feb 2023 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676491219;
        bh=OIyaot3Kx3cBDmU3csNPn4XUOwKIUevt4tqmt27oQE4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UauP2ZSFRB9PsW9yNPHjrOngoGAT5NHs6VEniOAe8FC9xOzIiHiHWUso87KX3CwvS
         5CqMCtKivmsMz/StTSXmNB2QYiOE4eXa9njIzJPn0BBgjvgzrq+fXw8DsecOf7s6mf
         /4ppk9ShRhdhhCOP0YjCVobc5NYu5qen46fis9Xh/wqXx4KYhew3jd9lYUXC7B0O0G
         700TDKzqsjWO3GPj78SE7YpGHgIu4G44WTzCKApESiqA16/wrIhhXOvlkdM9UvCF8d
         mUCl0aUGx/MrwvxIaXlhXK9m1XLV+a6zcKWtwRNXcF1IZ1by/ZDfeRylXnGlBx8dZG
         XKd4AzV4x8VtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D99F3C41677;
        Wed, 15 Feb 2023 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Improvements for BPF_ST tracking by verifier 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167649121888.9140.10210626676733422817.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 20:00:18 +0000
References: <20230214232030.1502829-1-eddyz87@gmail.com>
In-Reply-To: <20230214232030.1502829-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, jose.marchesi@oracle.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Feb 2023 01:20:26 +0200 you wrote:
> This patch-set is a part of preparation work for -mcpu=v4 option for
> BPF C compiler (discussed in [1]). Among other things -mcpu=v4 should
> enable generation of BPF_ST instruction by the compiler.
> 
> - Patches #1,2 adjust verifier to track values of constants written to
>   stack using BPF_ST. Currently these are tracked imprecisely, unlike
>   the writes using BPF_STX, e.g.:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: track immediate values written to stack by BPF_ST instruction
    https://git.kernel.org/bpf/bpf-next/c/ecdf985d7615
  - [bpf-next,v2,2/4] selftests/bpf: check if verifier tracks constants spilled by BPF_ST_MEM
    https://git.kernel.org/bpf/bpf-next/c/1a24af65bb5f
  - [bpf-next,v2,3/4] bpf: BPF_ST with variable offset should preserve STACK_ZERO marks
    https://git.kernel.org/bpf/bpf-next/c/31ff2135121c
  - [bpf-next,v2,4/4] selftests/bpf: check if BPF_ST with variable offset preserves STACK_ZERO
    https://git.kernel.org/bpf/bpf-next/c/2a33c5a25ef4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


