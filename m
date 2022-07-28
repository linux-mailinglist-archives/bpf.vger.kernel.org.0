Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFFE58489E
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 01:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiG1XUQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 19:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiG1XUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 19:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA47DEE3
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 16:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6988A61CB6
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 23:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADE81C433D6;
        Thu, 28 Jul 2022 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659050413;
        bh=CqMddByNbrX/am27CJsWRQuwpGuru33KhzQA0IFgOnE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZFA7bahmFnhNzJlReS10638WABIXZxwWAWPBG794GykRumZFDD6Wu75x7kfDt55jl
         qJlaQwwCIoi0niambqEV68gReTQSva0kvKTBv0J6k39ypAzoZxGCZcX2fmqeuYs46H
         mzrVsd3pX+rQaZt+f8qTuEuej2HvQT8iB9ocCD9h9QzVdipIZtxRcuSMOFvqGarvgJ
         RXsij+Xuph5U3SG4/qupA92uzMSJJRbNHoPlD33+Ih0ESNdzx5YqXDq07JE7LSp6vM
         C56UhMufQNrypJl2/0lIUUnfhzwkplln9mKn6TYOSJipqVjDiruc2pnX78vM5c4q3H
         QVcpVGvqipz3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93332C43142;
        Thu, 28 Jul 2022 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Support PPC in arch_specific_syscall_pfx
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165905041359.3277.15995978278460614122.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Jul 2022 23:20:13 +0000
References: <20220728222345.3125975-1-deso@posteo.net>
In-Reply-To: <20220728222345.3125975-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 28 Jul 2022 22:23:45 +0000 you wrote:
> Commit 708ac5bea0ce ("libbpf: add ksyscall/kretsyscall sections support
> for syscall kprobes") added the arch_specific_syscall_pfx() function,
> which returns a string representing the architecture in use. As it turns
> out this function is currently not aware of Power PC, where NULL is
> returned. That's being flagged by the libbpf CI system, which builds for
> ppc64le and the compiler sees a NULL pointer being passed in to a %s
> format string.
> With this change we add representations for two more architectures, for
> Power PC and Power PC 64, and also adjust the string format logic to
> handle NULL pointers gracefully, in an attempt to prevent similar issues
> with other architectures in the future.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Support PPC in arch_specific_syscall_pfx
    https://git.kernel.org/bpf/bpf-next/c/64893e83f916

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


