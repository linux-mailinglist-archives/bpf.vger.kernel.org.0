Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553E457658A
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiGORAQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiGORAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 13:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1444748C81;
        Fri, 15 Jul 2022 10:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9842062221;
        Fri, 15 Jul 2022 17:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03EACC3411E;
        Fri, 15 Jul 2022 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657904414;
        bh=59SMOYcIxex69oPIZWV3vb2UlzKW91XVO+5IKX3eiYk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FZ3JgAIwIPbqZ//HdqSydyrv4FNlea8VsZwbukMKnpTs+gq6F/eepKi7cSOCmNDgd
         72QpndIxueiIU3iVewTl6FApGP5ARUN04+2vtHORuMoVa0NRIQKkF7G5lJLhM74vpv
         IhEg4YAXJ6GPi0YPgoRBOPfl6fHVYLnAX4UNRgJ1Gnk9bImui1xIPTcib8YY0TuChg
         lR3C+hI2fIhxKGo09Bg4WEvTl6l35GRa/vOGiaru5kNoXomUj3tP11ZhvGkSAQBegm
         33MD27Gn20YGujKuR5HqXl5E7YAw9NHNlf6/KscqP30ojWUELEX62QZVTkigyPmYNZ
         v3ZPJoDvYML5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCCE2E45230;
        Fri, 15 Jul 2022 17:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix check against plain integer v 'NULL'
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165790441390.797.4433680438081515423.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jul 2022 17:00:13 +0000
References: <20220714100322.260467-1-ben.dooks@sifive.com>
In-Reply-To: <20220714100322.260467-1-ben.dooks@sifive.com>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        sudip.mukherjee@sifive.com, jude.onyenegecha@sifive.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 14 Jul 2022 11:03:22 +0100 you wrote:
> When checking with sparse, btf_show_type_value() is causing a
> warning about checking integer vs NULL when the macro is passed
> a pointer, due to the 'value != 0' check. Stop sparse complaining
> about any type-casting by adding a cast to the typeof(value).
> 
> This fixes the following sparse warnings:
> 
> [...]

Here is the summary with links:
  - bpf: fix check against plain integer v 'NULL'
    https://git.kernel.org/bpf/bpf-next/c/a2a5580fcbf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


