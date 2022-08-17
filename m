Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB515979A6
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiHQWaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 18:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiHQWaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 18:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69DA0619
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 15:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A8A61646
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 22:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3643C433D7;
        Wed, 17 Aug 2022 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660775414;
        bh=UbsvbUYULPwRBbo7oKx9lONUu9KjIy5HGbKaUqJwc1M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ujuLP1NZOVyUawizpAirbJan/Xra7PbxAUZb8rNTgQfiAN8R8JdYi/k9/nTT0Y5/d
         DVOzne7WOnU3rZ8S7i4fGCpZPPHqPmZX9m2wP8nhE/rAnXIGr+Vclra2pcLa9VHupM
         VGz9lp56em6rVmuIxn7I/xMzNhGIzzbE95CZfcjbSSfsc+yzgd8wae80b7z+ifpcJf
         8Yft5mZSgrRAc3ewyns4j/nrfu4+CcauHmI3NE3aaS+ccAD7KOTKB8oUMfVsXN/Hjv
         M4JOProf4KCjAjA99hj8Jem4wxLMwHq+GAcTpKbG25l0vUumF8gYe7xqS2kbqWA291
         /BzSUia4LaUiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B61AFE2A053;
        Wed, 17 Aug 2022 22:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Restrict bpf_sys_bpf to CAP_PERFMON
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166077541474.7079.5119695287194972054.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Aug 2022 22:30:14 +0000
References: <20220816205517.682470-1-zhuyifei@google.com>
In-Reply-To: <20220816205517.682470-1-zhuyifei@google.com>
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     bpf@vger.kernel.org, alexei.starovoitov@gmail.com,
        jinghao7@illinois.edu, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, song@kernel.org, sdf@google.com, jdz@google.com,
        jannh@google.com, mvle@us.ibm.com, zohar@linux.ibm.com,
        tyxu.uiuc@gmail.com, security@kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 16 Aug 2022 20:55:16 +0000 you wrote:
> The verifier cannot perform sufficient validation of any pointers
> passed into bpf_attr and treats them as integers rather than pointers.
> The helper will then read from arbitrary pointers passed into it.
> Restrict the helper to CAP_PERFMON since the security model in
> BPF of arbitrary kernel read is CAP_BPF + CAP_PERFMON.
> 
> Fixes: af2ac3e13e45 ("bpf: Prepare bpf syscall to be used from kernel and user space.")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Restrict bpf_sys_bpf to CAP_PERFMON
    https://git.kernel.org/bpf/bpf/c/14b20b784f59
  - [bpf,2/2] bpf: Add WARN_ON for recursive prog_run invocation
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


