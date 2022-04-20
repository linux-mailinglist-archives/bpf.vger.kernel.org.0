Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A33507DDE
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 03:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348145AbiDTBC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 21:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbiDTBC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 21:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427331EECE
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 18:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC69C61481
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 01:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 233F6C385AA;
        Wed, 20 Apr 2022 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650416412;
        bh=RjfgZtRBtVsGEVVvHCtrNYukohlE+AAUgjJ/b1cDpls=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LcV04C4zEVO5XdlqywV/EC0KD2dXSZxYJ8nqUNfoKGhFgz4caKhG+0T3Rk5l0jg7b
         W6143zmxVopqPi80g57mnVuXsbBOx0D7LBrUaOQVCuUNX6g/r8ZdFLq4g4+czG59Sd
         Aci05rJ6pqVF5CB90qxIVylcaERHsPDO5j8WQUpPBYNrAmSvV/RIStyEGwXqOWNkZa
         lM+ugFK5HKK+9WI/Z4KDpT23c0XAACvkhs7Yc3aMuoi5daq2eJUECp5yC0FU0/yeu0
         9Z67cL5BgH9tQOumMwXJGXtkhyGLfWdJB0PPIRc94tN3Ob+Ldq8zhc+Qoic2WnuxS2
         jRq4jX6rdoLUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0D03E8DBDA;
        Wed, 20 Apr 2022 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] Ensure type tags are always ordered first in
 BTF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165041641191.4464.2434468387244993266.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 01:00:11 +0000
References: <20220419164608.1990559-1-memxor@gmail.com>
In-Reply-To: <20220419164608.1990559-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Apr 2022 22:16:06 +0530 you wrote:
> When iterating over modifiers, ensure that type tags can only occur at head of
> the chain, and don't occur later, such that checking for them once in the start
> tells us there are no more type tags in later modifiers. Clang already ensures
> to emit such BTF, but user can craft their own BTF which violates such
> assumptions if relied upon in the kernel.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Ensure type tags precede modifiers in BTF
    https://git.kernel.org/bpf/bpf-next/c/eb596b090558
  - [bpf-next,v3,2/2] selftests/bpf: Add tests for type tag order validation
    https://git.kernel.org/bpf/bpf-next/c/24fe983abe01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


