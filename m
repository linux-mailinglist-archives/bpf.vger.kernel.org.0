Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A525B58D013
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 00:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiHHWUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiHHWUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 18:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA0E33
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 15:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4C4560FEA
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 22:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 032D1C433C1;
        Mon,  8 Aug 2022 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659997214;
        bh=2vvJFbDR66qcfo1sBOxoemLH6tYJo7xmI80h5iD+weg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mMkseeOAA0C2nm8Gp0YaUmAOIucesqijnjfuuetMHZMFGY3W0l3SaUZ0Uamsq0dMe
         mkq7aCopqMf3/kFmMIoXK+BjTQdGZZLfK3o2wFKptGqw+WegMm8AEGexcqc7zIJwWQ
         r0pmH1ddQils4THv2kKI6Ynv/JVErLt/HH0FKTLA/lmUbv5tnsPV1K9uy4OCbFw0qQ
         w9mdiVd7f6XeGVJQn9Rs8J7BeG9qPSaLhJT3pqqOUQI0v9haQrGY6ry8aRm/vPYvPw
         9TWTCUp4dqeMnUp2/hnSfo1WW3nE7taWp9uM3+qVjS89qWM7vYJeCUME7Zd6M5GlLp
         win+Agt/NB12g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA4A4C43143;
        Mon,  8 Aug 2022 22:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Do not require executable permission for
 shared libraries
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165999721388.22650.2294143579863029518.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 22:20:13 +0000
References: <20220806102021.3867130-1-hengqi.chen@gmail.com>
In-Reply-To: <20220806102021.3867130-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, goro@fastly.com
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  6 Aug 2022 18:20:21 +0800 you wrote:
> Currently, resolve_full_path() requires executable permission for both
> programs and shared libraries. This causes failures on distos like Debian
> since the shared libraries are not installed executable ([0]). Let's remove
> executable permission check for shared libraries.
> 
>   [0]: https://www.debian.org/doc/debian-policy/
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Do not require executable permission for shared libraries
    https://git.kernel.org/bpf/bpf-next/c/9e32084ef1c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


