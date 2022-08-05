Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1058AF27
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 19:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiHERuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbiHERuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 13:50:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A87E25
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 10:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3419B80CF3
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 17:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43C15C433C1;
        Fri,  5 Aug 2022 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659721813;
        bh=zTyJYuRzK2Np+6/R47Vm1hn6PM2K3usBApWXEry8PMk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r7VBVFmGPzYHPXTifClDOkcaNb5A6aH87pQBlVuSWrYTm0TlWaR1BAgztuvvLvPKh
         n1h1LufHHzVzk2Mm1dFbQEkl6WActzc9o9UR45nDXaQSthgAUt9ag9kcwRfqRTkMxW
         +EJDUv3lTzttM8GVtGErjvTYumlvvFLxs9Yyj4SIj9FxjFSIdEi1vnx8Gzc5oP+bYn
         cQJVRuCnI4KSy7ec1R25ISwY6FUvLK1iA51EYmmgV8YAKHnbzWOGZa85JPMwpNVZWP
         IqlyJtEn7W/4RTuMNXuTGK7fT5bp9VyMtOApnofXRhpEdhXAo+647VgKzH+JPuN4yn
         AfV+hxw4iVHaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 184CBC43142;
        Fri,  5 Aug 2022 17:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Cleanup ftrace hash in bpf_trampoline_put
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165972181309.19052.14802194886738557831.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Aug 2022 17:50:13 +0000
References: <20220802135651.1794015-1-jolsa@kernel.org>
In-Reply-To: <20220802135651.1794015-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com, rostedt@goodmis.org
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

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  2 Aug 2022 15:56:51 +0200 you wrote:
> We need to release possible hash from trampoline fops object
> before removing it, otherwise we leak it.
> 
> Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/trampoline.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] bpf: Cleanup ftrace hash in bpf_trampoline_put
    https://git.kernel.org/bpf/bpf/c/62d468e5e100

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


