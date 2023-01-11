Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57A866512D
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 02:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjAKBkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 20:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjAKBkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 20:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7AFD2F1;
        Tue, 10 Jan 2023 17:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2028CB81A93;
        Wed, 11 Jan 2023 01:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADCC2C433F0;
        Wed, 11 Jan 2023 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673401215;
        bh=boBQbq7SfvcVRwpzl0eKShV5W3LhzCslmIq3ogYoLiM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r7ZReUMlD5AAiFDS4+FqGtEZqcmf4MAe0ulL8WXjU3HazpL5fhi1HLr5KrDYMpjPq
         Ba4uWfP9ZE9JjNPi6k6gcOe44iWHXmJcy91evniYOMiT0j560r3ywQS6Tp+d7Cc8Gg
         Le2t48vdTkDpyyYMT4IUtK6C/n3rJ7S95Xdm0xkEvWS7BZcQi+0LhaNFkskRVfU0hK
         16dQpjSAZAcpUPD0yJr8GQcY5u5zsy8FVXGSVbqnOiYcpAOjmAi5ckyBOH5a2vb1q3
         DVQlLGyquDPr1mPdjsPQWMeKA/NM03Cw+slLYsK6+dq3KOmGAPFzKInPjP+BpJAg1w
         FrJ44+euZWXyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92BFEE4D026;
        Wed, 11 Jan 2023 01:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: btf: limit logging of ignored BTF mismatches
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167340121559.21440.10650818438262209592.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 01:40:15 +0000
References: <20230107025331.3240536-1-connoro@google.com>
In-Reply-To: <20230107025331.3240536-1-connoro@google.com>
To:     Connor O'Brien <connoro@google.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat,  7 Jan 2023 02:53:31 +0000 you wrote:
> Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
> mismatches are expected and module loading should proceed
> anyway. Logging with pr_warn() on every one of these "benign"
> mismatches creates unnecessary noise when many such modules are
> loaded. Instead, handle this case with a single log warning that BTF
> info may be unavailable.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: btf: limit logging of ignored BTF mismatches
    https://git.kernel.org/bpf/bpf-next/c/9cb61e50bf6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


