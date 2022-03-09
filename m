Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3544D26E3
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 05:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiCIBvM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 20:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiCIBvL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 20:51:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A87D1092
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 17:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61A65CE1C1C
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 01:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89A38C340EE;
        Wed,  9 Mar 2022 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646790610;
        bh=el6kkE6pj8kZ91DLFtmF5w/PMgT2Jidlj3+vukmFr2o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=baGQ0/OYOaK0c4iBc8iytH7Pjz5o617Ogq9drjoeDXMDcXoT+yWb3kSJPypOd4GKE
         svWdVaBITpoDSMEQNjPT7Hiatsvw2J6EUAM8Vw0rXfLGJZk74EpFFZeUw0JIv5A4F/
         YB1l6LM/nWMJBf8R63YSfNZLd5JFm8FLAVuxl8JxZxhLFKkQGLJwXfkVgLHwI6kLME
         I7az6+riZdVsqKTL7Q4NsV9ZXX3O5qGR+Y5TScMcKJIP0SS9zt8151VP9ssgMsQRrE
         kIp6Zf40FeRnowilO7KdHhemLaovYzI/V2YNnzg7ozc4CNC53Gdxv8vcSesDXQyWyv
         AFEO5q4SJ2l4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68DF9E7BB08;
        Wed,  9 Mar 2022 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/3] BPF test_progs tests improvement
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164679061042.16054.7847681903762449527.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Mar 2022 01:50:10 +0000
References: <20220308200449.1757478-1-mykolal@fb.com>
In-Reply-To: <20220308200449.1757478-1-mykolal@fb.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 8 Mar 2022 12:04:46 -0800 you wrote:
> First patch reduces the sample_freq to 1000 to ensure test will
> work even when kernel.perf_event_max_sample_rate was reduced to 1000.
> 
> Patches for send_signal and find_vma tune the test implementation to
> make sure needed thread is scheduled. Also, both tests will finish as
> soon as possible after the test condition is met.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/3] Improve perf related BPF tests (sample_freq issue)
    https://git.kernel.org/bpf/bpf-next/c/d4b540544499
  - [v4,bpf-next,2/3] Improve send_signal BPF test stability
    https://git.kernel.org/bpf/bpf-next/c/1fd49864127c
  - [v4,bpf-next,3/3] Improve stability of find_vma BPF test
    https://git.kernel.org/bpf/bpf-next/c/ba83af059153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


