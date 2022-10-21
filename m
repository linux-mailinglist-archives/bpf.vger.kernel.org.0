Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357266080F2
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJUVuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJUVuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB245E52C2
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 791E4B82D70
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10B36C433D7;
        Fri, 21 Oct 2022 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666389017;
        bh=9R9I9l5cjuvgVSg9jg3TY2dQ/CynNAVdIJCCdY6UuUM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ExBWUWKpbLKMFS8her4AI26j4HCfYmvCBrhkfG8noiihvl3KhFaEF9SgTQmxUWk+W
         1euUY+KX0uUKd0eoXNPN1xVredSoZyZ8SYSROtboL6hnyeucsAb7FSHnSD7FGZWyTQ
         wQzDkYtNVqpV1AEMIYsU8a/zk3dE8bRAfI989VAs/tklF286u7WR9O7S7zUzNo1xNP
         pjod1zQfuXFSZerOdkyx0yv2CG4dp5Mojkrx5QLOQ6t02viYVlGAt4SEGoJQSYDQ4D
         j7/cnnhnsYDlNgyE6lTWhpnjKVZ2ljjb2/wq0hD1iiKJC2NnA8k5VSU8/C1dkZiizt
         +q2mDpbpD9muw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8475E270DF;
        Fri, 21 Oct 2022 21:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Add "bootstrap" feature to version output
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166638901694.27641.3547797661599408874.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 21:50:16 +0000
References: <20221020100332.69563-1-quentin@isovalent.com>
In-Reply-To: <20221020100332.69563-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 20 Oct 2022 11:03:32 +0100 you wrote:
> Along with the version number, "bpftool version" displays a list of
> features that were selected at compilation time for bpftool. It would be
> useful to indicate in that list whether a binary is a bootstrap version
> of bpftool. Given that an increasing number of components rely on
> bootstrap versions for generating skeletons, this could help understand
> what a binary is capable of if it has been copied outside of the usual
> "bootstrap" directory.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Add "bootstrap" feature to version output
    https://git.kernel.org/bpf/bpf-next/c/2c76238eaddd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


