Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCA544B9D
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiFIMUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245421AbiFIMUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 08:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3AC1E4BC7
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 05:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C958761821
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 12:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C88C3411B;
        Thu,  9 Jun 2022 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654777213;
        bh=LBx+6tw5V998JcIrxfnJRh5WND1lSEBwKSN0gCsbSVQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WfyReUkz19flBkp04U7RQGwZNDZd+2dPEx22bPy30ElygZc9GD4QKYAcXeGNG7HjX
         FttaLbpMJIBzhUtOM1qjlWtE+aIBjFxodKMMEzqSy7yHmWEWSXCgJu/gYHHnZetP5G
         KLRG/Lzm/RUibss5DyR20fOGr6Pg2pkgxnPgacqZdbMTzC8n/7LVHrzjQqeu1vQR1h
         W6LHh/5KJYQ+X3lLLqkhw1i/ZYvTczD4VJyO9cSNrXMEROpjefItrXIQNfnuB0lm56
         6x8JZI+2IQIzDgEHj/3XFxZkcabdw2xEyL5SUlRabOndXLgHE6gex3muaA+hMLyHuF
         Xe4i9qwJwvh0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CB03E737F0;
        Thu,  9 Jun 2022 12:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix uprobe symbol file offset calculation
 logic
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165477721311.18609.5520888533028654570.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Jun 2022 12:20:13 +0000
References: <20220606220143.3796908-1-andrii@kernel.org>
In-Reply-To: <20220606220143.3796908-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, rihams@fb.com, alan.maguire@oracle.com
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

On Mon, 6 Jun 2022 15:01:43 -0700 you wrote:
> Fix libbpf's bpf_program__attach_uprobe() logic of determining
> function's *file offset* (which is what kernel is actually expecting)
> when attaching uprobe/uretprobe by function name. Previously calculation
> was determining virtual address offset relative to base load address,
> which (offset) is not always the same as file offset (though very
> frequently it is which is why this went unnoticed for a while).
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix uprobe symbol file offset calculation logic
    https://git.kernel.org/bpf/bpf-next/c/fe92833524e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


