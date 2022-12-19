Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35376514A6
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 22:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiLSVKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 16:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiLSVKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 16:10:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8191275B
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 13:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AE661173
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 21:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BCCC433F1;
        Mon, 19 Dec 2022 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671484218;
        bh=kuJtGyiYbInrORsuykAMHSs56ddFLwKcJ+kJspGRwf8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VvU43/Nz/7dvBCYStaD4LIA2kyZ1kzEtfoZjz4wPhKAw+m/Ey+OB8zl0JR4XzsYx8
         6071AfAlOe2TYuHfcSYAwPsqX4hFWBx37FzRnnK94wnZOFbdzthytFhNhUX86iAMGf
         Uy1ST3dlD5ux+s6g+KxHtzi+MR0itS4PwCAirosRBYPG9Xub0btOmIp1bG7s/uqhSZ
         qu3W6jQXvneXrwNkDqqMnNMLK0/9pBF2WxxNFdUdO+Ml22SvR1WWJW0v38wGmRMBPf
         22X+iYxPA4B4oXbCCPfZ+ATqZklQYsy8leUNppbazrSamfWEQlacF40pKfqimjvavd
         euXguYUQUUG1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E4EEC00445;
        Mon, 19 Dec 2022 21:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Define sock security related BTF IDs under
 CONFIG_SECURITY_NETWORK
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167148421831.25912.620774133126350112.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Dec 2022 21:10:18 +0000
References: <20221217062144.2507222-1-houtao@huaweicloud.com>
In-Reply-To: <20221217062144.2507222-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
        song@kernel.org, haoluo@google.com, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, houtao1@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 17 Dec 2022 14:21:44 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> There are warnings reported from resolve_btfids when building vmlinux
> with CONFIG_SECURITY_NETWORK disabled:
> 
>   WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_free_security
>   WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_alloc_security
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Define sock security related BTF IDs under CONFIG_SECURITY_NETWORK
    https://git.kernel.org/bpf/bpf/c/cc074822465d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


