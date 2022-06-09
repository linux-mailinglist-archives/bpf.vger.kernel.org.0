Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8A544B5C
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbiFIMKP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 08:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiFIMKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 08:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC011265226
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 05:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CE47615C7
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 12:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE152C341C0;
        Thu,  9 Jun 2022 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654776612;
        bh=ZRnKmqgbZIH88lyZI+bE8XLsegzarvxIWLntuCr14f0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k5HMssAktRmsrB27mj+LNyOi0ll4OJy7ljcM7AGC8UztW10sYhvHcliZfEpzg2qzf
         17tsloUbyEX4lYeUxp9ADyeVuJQkDnGYMn9kUjq5AfWrjBeP52BHzUBqzZAQI3nbrl
         PpHyZ/K9zMC08lzhoYTCaEQbNNUTLG+H+4grCXUw0jdBL7VeWZh+vXGz4DAezLJKsc
         42V0vM6YU23EfrdAHToBoxRQ/ZuEtnXAFou5SvE9NM9apujgA4GnJCXjnE9bciUH6O
         +bulUUfG7ewyEj+ep48z9Hv8f4wrj2WH6gjS8qhAaWQj7nUPJSTlAwfsD2Sev3TylY
         GF0n1YYqKjreA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B13A9E737E8;
        Thu,  9 Jun 2022 12:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: Fix bootstrapping during a cross compilation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165477661272.11342.13015777410417612477.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Jun 2022 12:10:12 +0000
References: <8d297f0c-cfd0-ef6f-3970-6dddb3d9a87a@synopsys.com>
In-Reply-To: <8d297f0c-cfd0-ef6f-3970-6dddb3d9a87a@synopsys.com>
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Cc:     bpf@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 8 Jun 2022 14:29:28 +0000 you wrote:
> This change adjusts the Makefile to use "HOSTAR" as the archive tool
> to keep the sanity of the build process for the bootstrap part in
> check. For the rationale, please continue reading.
> 
> When cross compiling bpftool with buildroot, it leads to an invocation
> like:
> 
> [...]

Here is the summary with links:
  - bpftool: Fix bootstrapping during a cross compilation
    https://git.kernel.org/bpf/bpf-next/c/0b817059a883

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


