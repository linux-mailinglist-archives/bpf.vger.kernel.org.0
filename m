Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B8E6080DF
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJUVkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUVkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:40:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D7D4A35
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09A7EB82D6B
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DD2DC433C1;
        Fri, 21 Oct 2022 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666388416;
        bh=jvKItF5AmgqQstUPojPOeEYoFEPD7tlhA7bAqXAm8fQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cLW+nXjYyZMD86qlNep81L+IrpG7bs+kheMt0KuS/tIR+rFQ2+Pdax9uXKlVdaa5o
         swH1iedWlD5I9CEs3rvOZS93pGQw7ZJbhRruYW6Z10Ar9bZOFCFzPBOjkBw9Zp8CR+
         44BL/pcySXRuJbWyJLAlZWibZU3H7g6gI0voWtaZ3DLrrZyvIVT2e2azzMPdU1Iu62
         493F+WwUnadnOa2cRKzuXqVKHZAXYCvZ+1WftvOVfo30IQ37Bopvn9L3i+DJX5Mcbv
         PNUjGCT6c8rvOs1OaRJ/mBK849ZkO1Cmruf9uPsViR9IWRNaWU10p/P+7h3QMnEtIM
         XAvgG5FtFA/yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EF6EE270DF;
        Fri, 21 Oct 2022 21:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Set binary name to "bpftool" in help and
 version output
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166638841645.20449.6790734622117237392.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 21:40:16 +0000
References: <20221020100300.69328-1-quentin@isovalent.com>
In-Reply-To: <20221020100300.69328-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        vladimir.cunat@nic.cz
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 20 Oct 2022 11:03:00 +0100 you wrote:
> Commands "bpftool help" or "bpftool version" use argv[0] to display the
> name of the binary. While it is a convenient way to retrieve the string,
> it does not always produce the most readable output. For example,
> because of the way bpftool is currently packaged on Ubuntu (using a
> wrapper script), the command displays the absolute path for the binary:
> 
>     $ bpftool version | head -n 1
>     /usr/lib/linux-tools/5.15.0-50-generic/bpftool v5.15.60
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Set binary name to "bpftool" in help and version output
    https://git.kernel.org/bpf/bpf-next/c/7e5eb725cf0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


