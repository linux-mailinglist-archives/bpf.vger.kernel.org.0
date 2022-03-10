Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4D4D5563
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiCJXbR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 18:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344714AbiCJXbP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 18:31:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF900100749;
        Thu, 10 Mar 2022 15:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E595B82956;
        Thu, 10 Mar 2022 23:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32DCAC340E8;
        Thu, 10 Mar 2022 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646955010;
        bh=Wb8uC7cQp3XhsQSQubVC9DLAt28O4wfQ0fnjwvRaFH8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kYoiAinVEtP6AsJVIeX/lH9tFjVnOgp3lQFIJPuZx56lIBzVj0fAb+woK8UcmbPUw
         HHUlzQ175G7ScIeFS3Iyw+Tu1L65KVMURV9hyAdPiqfc8Xj4oTFGNvLaZXyercxLz9
         /x7U/+aCYgME04wmYqdBbuIzbZmIyrWmveIfuWLoyBKoWJD7kEasYvwJdUYn6HlLyp
         7giB+eUynIM2SAtJ9iuOFtABVRvLSNjLkG5FrgHMHO/GyCIcFH+Av/ZGqcjxOo6nZf
         wvvfL93Eyj57nYXhWlQ8537JIur1g0qNjRXVd/W4fm/07K3MTeb8I+AKOspjcmJto8
         0/5b5Q14uftFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19FE4E5D087;
        Thu, 10 Mar 2022 23:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: ensure bytes_memlock json output is correct
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164695501010.21304.950456748637627330.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Mar 2022 23:30:10 +0000
References: <b6601087-0b11-33cc-904a-1133d1500a10@cloudflare.com>
In-Reply-To: <b6601087-0b11-33cc-904a-1133d1500a10@cloudflare.com>
To:     Chris Arges <carges@cloudflare.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        quentin@isovalent.com, ast@kernel.org, andrii@kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 10 Mar 2022 16:28:13 -0600 you wrote:
> >From 40107402b805c4eaca5ce7a0db66d10e9219f2bf Mon Sep 17 00:00:00 2001
> From: Chris J Arges <carges@cloudflare.com>
> Date: Wed, 9 Mar 2022 15:41:58 -0600
> Subject: [PATCH] bpftool: ensure bytes_memlock json output is correct
> 
> If a bpf map is created over 2^32 the memlock value as displayed in JSON
> format will be incorrect. Use atoll instead of atoi so that the correct
> number is displayed.
> 
> [...]

Here is the summary with links:
  - bpftool: ensure bytes_memlock json output is correct
    https://git.kernel.org/bpf/bpf-next/c/357b3cc3c046

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


