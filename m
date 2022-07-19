Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3171057A5BE
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiGSRuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiGSRuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF159B1E3;
        Tue, 19 Jul 2022 10:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3853D616B6;
        Tue, 19 Jul 2022 17:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B083C341CF;
        Tue, 19 Jul 2022 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658253015;
        bh=cwATQ5g4AMTZbXU7RJf3KiRr+SxCwcB9oYtyOLP3Re8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n2IXd4nU2tKxjaLtUVu55bLizcpDSWa015I1nEvKE5RP06UWPOtWdN2tkHs12MDL7
         ZjZy68i/eOXKCZtQ/8gloCtjt84PjAl6OZ6s0vQZFcsdrP0dk52FS30ORB9H0/9gvP
         IJWt4EgCcj6aZ2T+8P7rJNpdxsijwDOa6LiWd84kEpGaCkbP3EyZlLkp7Y6QaVp8rz
         fV8TD8nkkV4loz3JHYSF3JE3x2BTMqhRlGoKTGo5yhI2rvDsG5sVsdCHri0yYKdj/a
         s1Eb1PHYrd38MbZS97P8kf5YzOWCWfupxdX5AOqjO4NmHBo0jnnkfV1BpDQlGmeEGe
         xNPc5fW/sRtfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F99EE451BC;
        Tue, 19 Jul 2022 17:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: fix an snprintf() overflow check
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165825301519.17492.3463610945842886021.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 17:50:15 +0000
References: <YtZ+oAySqIhFl6/J@kili>
In-Reply-To: <YtZ+oAySqIhFl6/J@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Jul 2022 12:51:28 +0300 you wrote:
> The snprintf() function returns the number of bytes it *would* have
> copied if there were enough space.  So it can return > the
> sizeof(gen->attach_target).
> 
> Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [...]

Here is the summary with links:
  - libbpf: fix an snprintf() overflow check
    https://git.kernel.org/bpf/bpf-next/c/b77ffb30cfc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


