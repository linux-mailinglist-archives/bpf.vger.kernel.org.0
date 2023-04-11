Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F06DDFEF
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjDKPuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKPuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 11:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F5B2723
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 08:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF8A60B6E
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 15:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81E1C433D2;
        Tue, 11 Apr 2023 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681228217;
        bh=Ay3kxMATDUPdpudhxOyBoikH7YhIQQKJbcJeOQgAzmM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NH6n3BczYw+pe0SQ+1XSX4hWJbfV4Zk/n0YyZeJtvSN0R7073GD6/EO5YQSZKDnxc
         KAkhrDWf9qY9bhmBNYGdpCLjo7Xyzk74/j/6SMN8wHAJA5kByT291LqgxjtFG2EB5v
         eJuY3u8Vl/rpKsSc/aZulqsq65YGgoqHO0Hoa2zYd1xSSWMy0ey65cC4Mok05X5NZt
         7qI4d2eAmWJo6swyBAFRGnz3Vwp6jh+Ku3JMTyVO/XUm7p3FJZ3aqKG+1jK8gTxbyq
         UNkWakjh8cuRqB66ntQOvWDSq+hWsY4A5JRIRrVkV3ZpcYbFEaIBzI4bKiJNp5QUjg
         9JU9pWAGoTA6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE43CE52441;
        Tue, 11 Apr 2023 15:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove extra whitespace in SPDX tag for
 syscall/helpers man pages
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168122821777.30854.16513524421054734358.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 15:50:17 +0000
References: <20230411144747.66734-1-quentin@isovalent.com>
In-Reply-To: <20230411144747.66734-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        alx@kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 11 Apr 2023 15:47:47 +0100 you wrote:
> From: Alejandro Colomar <alx@kernel.org>
> 
> There is an extra whitespace in the SPDX tag, before the license name,
> in the script for generating man pages for the bpf() syscall and the
> helpers. It has caused problems in Debian packaging, in the tool that
> autodetects licenses. Let's clean it up.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove extra whitespace in SPDX tag for syscall/helpers man pages
    https://git.kernel.org/bpf/bpf-next/c/eafa92152e2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


