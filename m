Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF07641FC0
	for <lists+bpf@lfdr.de>; Sun,  4 Dec 2022 22:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLDVKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 16:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLDVKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 16:10:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16F108B
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 13:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 836CDB80C80
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 21:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37437C433D7;
        Sun,  4 Dec 2022 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670188215;
        bh=9xz42ExORZasQybCWRJBsOQS//Wh+6iI4n15WOkz+Y0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MSusDasaJh7yXaPnosh8bSyTQ1Q/RDQ7oJGYbGQH6HilzVEkGZfh4t/No1xkunxzR
         8TQNgL0K124WI7zU8AwPNhtWvLQCknfrLO9DNK5HatsGPvlv7MnxfoYtLToapXPBoq
         S3ZuroPthVkXhWZ2y6WsyNede/iPKA4d0BW94ulXHh2G3pjFe4w0v4p6c/sOI5jFKw
         yQ+0ctMRDzUjn6bRj5Pz/J0qRM+Q0irruFEnVm41Bfgpqojs6kBZWGUWqU7B3NHmPF
         jJWytiJOBnEUQTzpCFMpoNS1edNuPCdtnAW8ZY722mgXF2LQuDsB+6DQuS1FG+oXWB
         mB7MffRLs7aPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 186B4E21EF9;
        Sun,  4 Dec 2022 21:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Do not mark certain LSM hook arguments as
 trusted
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167018821509.25291.16569465712983933478.git-patchwork-notify@kernel.org>
Date:   Sun, 04 Dec 2022 21:10:15 +0000
References: <20221203204954.2043348-1-yhs@fb.com>
In-Reply-To: <20221203204954.2043348-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 3 Dec 2022 12:49:54 -0800 you wrote:
> Martin mentioned that the verifier cannot assume arguments from
> LSM hook sk_alloc_security being trusted since after the hook
> is called, the sk ref_count is set to 1. This will overwrite
> the ref_count changed by the bpf program and may cause ref_count
> underflow later on.
> 
> I then further checked some other hooks. For example,
> for bpf_lsm_file_alloc() hook in fs/file_table.c,
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Do not mark certain LSM hook arguments as trusted
    https://git.kernel.org/bpf/bpf-next/c/c0c852dd1876

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


