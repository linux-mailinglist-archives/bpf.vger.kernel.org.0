Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C225BB382
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIPUaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIPUaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 16:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956E28E07
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 13:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD59B62D92
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 20:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 284A9C433D6;
        Fri, 16 Sep 2022 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663360215;
        bh=a6wxuhoxfPN78SogqJb3/fsiFnhfhj9mRYg275Cfel8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fV7q8vV/oIjxz1UMs0VcctzcmUqiIx/GOom173cxo3Z4vEIBfRifKUcAyarK0DvSG
         Z2t9wyCD1g0zAyb1nzbwsiuWpLnNo18hjMZif1O/SL5VwHdxB2KhmArCPeF8kz/MsI
         c0PM/GLf37MfyEZ+oy1vZfZKiUOwiUyh2Cxv3E/6gcQyX8WoVGKEGd6ff4MK+C58sD
         ct+hkfxvnpOZIIHVHA6DKGwZprUFh2hd8eUokq/8Zrx/Da+VSTedH/gA7Dyo4co0lr
         wO815NpmyNdGhLScLpB26zctDvuh/YAPQNhRRYq/u36l2a7NXG8ncpn5p99vTDsnjT
         G+dfoZE22GdDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBEE5C73FFD;
        Fri, 16 Sep 2022 20:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/2] bpf,ftrace: bpf dispatcher function fix
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166336021495.32062.787079947932700503.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Sep 2022 20:30:14 +0000
References: <20220903131154.420467-1-jolsa@kernel.org>
In-Reply-To: <20220903131154.420467-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com, peterz@infradead.org,
        tglx@linutronix.de, bjorn@kernel.org, rostedt@goodmis.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat,  3 Sep 2022 15:11:52 +0200 you wrote:
> hi,
> as discussed [1] sending fix that moves bpf dispatcher function of out
> ftrace locations together with Peter's HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> dependency change.
> 
> v3 changes:
>   - using notrace and adding it also for all archs [Peter]
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/2] ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
    https://git.kernel.org/bpf/bpf-next/c/9440155ccb94
  - [PATCHv3,bpf-next,2/2] bpf: Move bpf_dispatcher function out of ftrace locations
    https://git.kernel.org/bpf/bpf-next/c/ceea991a019c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


