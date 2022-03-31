Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994EF4ED1D0
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 04:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiCaCmB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 22:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCaCmA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 22:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4ED3ADD
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 19:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 863DD60B2F
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 02:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6278C340F0;
        Thu, 31 Mar 2022 02:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648694410;
        bh=XLIeBz7J5/JFC7tjJpo2EvzStz7XJLNPRBpQSFSZBUU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ur5oq085kg46LE0gePMJj+jTYFb8zAe7esNMmiVnB2Nj3CyCTdJkIHwlxC6QO/QVf
         I93NH6C1eJHBqod75ldVpHbmnxqv/hVllayDKV7yUA9EY45OvTitnZL5XVfm5+xB3M
         mLHvbs1rEbvo/gXB7WOaNIyNioffbQRj5o2PDmCq5mCq1f5bEIQjyapFwY7Vq0s1fP
         h4qtWkZGA10s6tKQyQ2sP3avgvr5Cy9/uFHgeWKV674ViFyfx8Y99bdxJrGvaQjtxQ
         3tZe3QjPwrLw4aAN72dwmc8plk7ae6Kvp/U6hjJYsgecSyZVevBDUlW4TuQ1qnEDi3
         1MKGie5dL7egQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9990F0384A;
        Thu, 31 Mar 2022 02:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Resolve to prog->aux->dst_prog->type only for
 BPF_PROG_TYPE_EXT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164869441075.29895.10529987783959321042.git-patchwork-notify@kernel.org>
Date:   Thu, 31 Mar 2022 02:40:10 +0000
References: <20220330011456.2984509-1-kafai@fb.com>
In-Reply-To: <20220330011456.2984509-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Mar 2022 18:14:56 -0700 you wrote:
> The commit 7e40781cc8b7 ("bpf: verifier: Use target program's type for access verifications")
> fixes the verifier checking for BPF_PROG_TYPE_EXT (extension)
> prog such that the verifier looks for things based
> on the target prog type that it is extending instead of
> the BPF_PROG_TYPE_EXT itself.
> 
> The current resolve_prog_type() returns the target prog type.
> It checks for nullness on prog->aux->dst_prog.  However,
> when loading a BPF_PROG_TYPE_TRACING prog and it is tracing another
> bpf prog instead of a kernel function, prog->aux->dst_prog is not
> NULL also.  In this case, the verifier should still verify as the
> BPF_PROG_TYPE_TRACING type instead of the traced prog type in
> prog->aux->dst_prog->type.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT
    https://git.kernel.org/bpf/bpf/c/4a9c7bbe2ed4
  - [bpf,2/2] bpf: selftests: Test fentry tracing a struct_ops program
    https://git.kernel.org/bpf/bpf/c/0a210af6d0a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


