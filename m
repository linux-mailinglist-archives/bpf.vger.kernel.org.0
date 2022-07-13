Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BF572A54
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 02:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGMAkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 20:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiGMAkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 20:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1016EEB9
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 17:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13CC4B81C5C
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 00:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A00CCC341CA;
        Wed, 13 Jul 2022 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657672814;
        bh=D3EcJT8vt9EEx0/SxalKPmUzuGjy0cVf/4fI/knb/Pw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hDJDq9zAMWltiHDSK0Lp+ww6naNZYOc3NIVC1aVL37UjMqvCCt7QlYKUs5syvc2Y3
         G7qriZWb4tZjXtuxl3ftmJ04lNDSYltu4kcBoFyq7EZcLabfG3D6styFoUPX/50hFF
         E5jqm4xH362lMENYUB6WuMRtHRm1Gvx49mPGoAZlj8wU1fT8S8DAPAgIdTGubGyjkh
         92z9FhKr/aO6QEwYEk+R2VhsBRiTP5p+B6Dq4SYlLDUIU02TSZ1jV4FfiX5/L1d2+i
         RSXd+wKKtxJ5UPaGE2+UlwAEfc+jU2VbzwDtNYE6M5zAG7UFGdpwqcHzWf4OgUWgRC
         NnmNkvwcTdBwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 802A4E45227;
        Wed, 13 Jul 2022 00:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, x86: fix freeing of not-finalized bpf_prog_pack
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165767281452.22277.11387727025043528584.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Jul 2022 00:40:14 +0000
References: <20220706002612.4013790-1-song@kernel.org>
In-Reply-To: <20220706002612.4013790-1-song@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        ast@kernel.org, andrii@kernel.org,
        syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com,
        syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 5 Jul 2022 17:26:12 -0700 you wrote:
> syzbot reported a few issues with bpf_prog_pack [1], [2]. These are
> triggered when the program passed initial JIT in jit_subprogs(), but
> failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
> called before bpf_jit_binary_pack_finalize(), and the whole 2MB page is
> freed.
> 
> Fix this with a custom bpf_jit_free() for x86_64, which calls
> bpf_jit_binary_pack_finalize() if necessary. Also, with custom
> bpf_jit_free(), bpf_prog_aux->use_bpf_prog_pack is not needed any more,
> remove it.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, x86: fix freeing of not-finalized bpf_prog_pack
    https://git.kernel.org/bpf/bpf-next/c/1d5f82d9dd47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


