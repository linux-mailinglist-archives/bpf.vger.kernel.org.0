Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB26E0E28
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 15:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDMNKp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjDMNKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 09:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AA9777;
        Thu, 13 Apr 2023 06:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 393F963E21;
        Thu, 13 Apr 2023 13:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B9A9C4339C;
        Thu, 13 Apr 2023 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681391418;
        bh=VRdNvEhQ2YYjxC/bhA0mvVDte9A1SQRW0KWjuKXsgU0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aJauSIHiOKitsZ0Q9tgqlHnvubqG0i03do2BBXTl9USJSLz7LKEdfet8cK5KrLCLG
         mjSX4AALm7/hm9EYm5oXTehFB12so5FbQLUiQmNF2/vBHcJi09/xbS1MqOLk4gMFbm
         5v6QE4Yy0+XJg/qt2dH/vcxWprqDCxFaUtuB5fK6jSuTj6FUfslzO7/ZgPDRp9eqFu
         TBKjeJsAKC4jNrdeS7ZQjPK0xMJg9edjDnmrvMKKTUXnsMD0hDYUoDlWvmlVr9qtY3
         Am9zCBBBX05HL04IKpI94e1hUDHcu1JQRQIC26hRrLipdJtHNYtbkvHClcwhMvzq6s
         4k2OVhTd8zh3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FB45E52443;
        Thu, 13 Apr 2023 13:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf:fix fout leak
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168139141851.617.9362232032892854655.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 13:10:18 +0000
References: <20230411084349.1999628-1-zenghao@kylinos.cn>
In-Reply-To: <20230411084349.1999628-1-zenghao@kylinos.cn>
To:     Hao Zeng <zenghao@kylinos.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 11 Apr 2023 16:43:49 +0800 you wrote:
> Fix fout fopen but not fclose
> 
> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> ---
>  samples/bpf/hbm.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - samples/bpf:fix fout leak
    https://git.kernel.org/bpf/bpf-next/c/23acb14af191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


