Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B86CF00B
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjC2RAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjC2RAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 13:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DC59EA
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 10:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A580061DD0
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 17:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06E3BC433EF;
        Wed, 29 Mar 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680109219;
        bh=6DsPdjzgW7SFZeyKQdoAv2oPO8Fa0Y5hIW/Ct0l8DLs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kVV1VX2+QViYKLlM5ekWR5H2Q7/pBVmqFSMNXELPWEeCFNWb6EVE/Ht0suk21Uh2S
         Z2frczW9YCfxG2pvAySvnMi4PPHW0RQWjN3gpV9ZRJObnhzYUQ3gawYcTp8n2uqXXe
         OvJu4UJvDphRFAcMUEX9RZ7ZkuCWdpxuqlObFnGSUE6atw4QUfEcREK3oJwjsoPf1S
         SHguhLz+sWaRW63551sGa9QoAtM+WqHnzRgcve/j6yKrPtB+Hm/HYPdKz5ZdfFdnMn
         NJwExaxi5b5vlcdXqna/JAFIqaHZ7pKnux9onP9KbZYykpzN5VsdQotCqF09I9BfD3
         lJOdxDdtHGbrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6BA9E4F0DB;
        Wed, 29 Mar 2023 17:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: bpftool: json: fix backslash escape typo in jsonw_puts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168010921886.11984.9423876652769169602.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Mar 2023 17:00:18 +0000
References: <20230329073002.2026563-1-chantr4@gmail.com>
In-Reply-To: <20230329073002.2026563-1-chantr4@gmail.com>
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 29 Mar 2023 00:30:02 -0700 you wrote:
> This is essentially a backport of iproute2's
> commit ed54f76484b5 ("json: fix backslash escape typo in jsonw_puts")
> 
> Also added the stdio.h include in json_writer.h to be able to compile
> and run the json_writer test as used below).
> 
> Before this fix:
> 
> [...]

Here is the summary with links:
  - tools: bpftool: json: fix backslash escape typo in jsonw_puts
    https://git.kernel.org/bpf/bpf-next/c/d8d8b008629f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


