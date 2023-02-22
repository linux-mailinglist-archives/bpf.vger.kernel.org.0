Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C943769FDA1
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjBVVUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBVVUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A032CD8
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 13:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F45614F1
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 21:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAB5AC4339E;
        Wed, 22 Feb 2023 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677100817;
        bh=ML+4B1Miuh2nuX9JzjgVXq99cixHlmuza6vrih+g6Fw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oOj/oGAQEex3MfYMsP04VCExd2EnTTSWCkI90I6po2+J80NL6Nh/34V4z3QdBTQ9v
         4nJklGJFHqUtLrtWOJb5lIJd2+tu8NG6/Z9Hb5YRM8T/sMUfeGhnpXl3ZocqYDfhZX
         1Go4PJNe/vtBO3WuDQvtv+1iDcWrFh881WM9GXp6jP5tWyvfAKE/JSsyxWQi1BboO/
         h8TM5lR4HgibgqxN6sRt6nPh74SSJuwtU9vCaDmQngbWDBdBgGfxqjJYqElKC3jeob
         /QtVlL7x8MYbhf1VZd+fOsRaqLrFe+PQTR+Qqbg8phhjLpQooLJBEHGW6BFI5Z7Pc7
         qIR0GsNHi67oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 949A7C43157;
        Wed, 22 Feb 2023 21:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Check for helper calls in check_subprogs()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167710081760.15608.16183342834199081723.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 21:20:17 +0000
References: <20230220163756.753713-1-iii@linux.ibm.com>
In-Reply-To: <20230220163756.753713-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, jolsa@kernel.org, sdf@google.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Feb 2023 17:37:56 +0100 you wrote:
> The condition src_reg != BPF_PSEUDO_CALL && imm == BPF_FUNC_tail_call
> may be satisfied by a kfunc call. This would lead to unnecessarily
> setting has_tail_call. Use src_reg == 0 instead.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Check for helper calls in check_subprogs()
    https://git.kernel.org/bpf/bpf-next/c/df2ccc180a2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


