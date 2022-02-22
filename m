Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D734BF0F4
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 05:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiBVEan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 23:30:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiBVEal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 23:30:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51017E084
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 20:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C6C61578
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 04:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A23ABC340F0;
        Tue, 22 Feb 2022 04:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645504210;
        bh=UtJWYT+uiR3z23SlHXgeMj9MP40qpKs5r5kYOemHUKI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uQzW5bQ6dxz0APh7rjpPKlMH5iaff/pB4vYLR9bsD7YNvZzoOF7aiqmgMWn7NxC9r
         uR1LEXcNuoKv4srVR9QZWKP6y01LRrrRmRNw9Wz3824BlvXgwkzqJaI9xMdMqVJrlE
         +wxzI+LKusIzwQ4aQroBMca10F7c+rF4OXJ2iSb+jo22bX3Att9lywlC16hvhCM7wM
         G0IvBAF0+AwAqD6CgdbvKsonj6O4Aao2K1bfyFNcWJq29DVyuBApolo06IJvExt2av
         azA5VvV6M4RS3nnS1tePnslC3L+LeWpIoeBV5HbPIHemMBD/C2oqgm5ek7JLjVDJ28
         NOmoLLl4LDxFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 832E4E5D07E;
        Tue, 22 Feb 2022 04:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for reg2btf_ids out of
 bounds access
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164550421053.27050.10055648012858227059.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Feb 2022 04:30:10 +0000
References: <20220220023138.2224652-1-memxor@gmail.com>
In-Reply-To: <20220220023138.2224652-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 20 Feb 2022 08:01:38 +0530 you wrote:
> This test tries to pass a PTR_TO_BTF_ID_OR_NULL to the release function,
> which would trigger a out of bounds access without the fix in commit
> 45ce4b4f9009 ("bpf: Fix crash due to out of bounds access into reg2btf_ids.")
> but after the fix, it should only index using base_type(reg->type),
> which should be less than __BPF_REG_TYPE_MAX, and also not permit any
> type flags to be set for the reg->type.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add test for reg2btf_ids out of bounds access
    https://git.kernel.org/bpf/bpf-next/c/13c6a37d409d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


