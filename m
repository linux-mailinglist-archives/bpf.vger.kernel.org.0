Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076634B92B0
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiBPVAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 16:00:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiBPVAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 16:00:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEAB202051
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 13:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E0DB61AE4
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 21:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 774F4C340ED;
        Wed, 16 Feb 2022 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645045210;
        bh=KodnlechNI29GfFteZiHfiKWqUGYxegN3+hDMlUy1x8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AVuujSaHCvoBXXda3PRTBCrFaKBwhQQy1lqE6PGE7lkl8de0aBO6jy1h3hUM9hdRU
         O2UTu9VjNFm0c5jQ34ozJTfozK0S0TsITZwHuDxbYESon1tTSqu9SERqFqeb53+bDx
         CCUebDKCJlMV5kI6Sg82NmHqzdQDX41DuFhjsdB2nGACTq1BP0bMnvcMIV43a6IU3P
         ywP3uzNLEqh4j3jcUe1qJQIppZi60kqp3UnozvkzglguxS0emZuHtNeRc+t3Lif5Ek
         aZLg0/3nI/O4Wzey3X2+/3hEcBg+rEErq9xwRchPIbc8v2XvdfSyljPmOdWiMyVwxM
         uq87sBdZdFkug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60FD5E6BB3D;
        Wed, 16 Feb 2022 21:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] Fix crash due to OOB access when reg->type >
 __BPF_REG_TYPE_MAX
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164504521039.12370.15641284147899994265.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Feb 2022 21:00:10 +0000
References: <20220216201943.624869-1-memxor@gmail.com>
In-Reply-To: <20220216201943.624869-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, haoluo@google.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 17 Feb 2022 01:49:43 +0530 you wrote:
> When commit e6ac2450d6de ("bpf: Support bpf program calling kernel
> function") added kfunc support, it defined reg2btf_ids as a cheap way to
> translate the verifier reg type to the appropriate btf_vmlinux BTF ID,
> however commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with
> PTR_TO_XXX | PTR_MAYBE_NULL") moved the __BPF_REG_TYPE_MAX from the last
> member of bpf_reg_type enum to after the base register types, and
> defined other variants using type flag composition. However, now, the
> direct usage of reg->type to index into reg2btf_ids may no longer fall
> into __BPF_REG_TYPE_MAX range, and hence lead to out of bounds access
> and kernel crash on dereference of bad pointer.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] Fix crash due to OOB access when reg->type > __BPF_REG_TYPE_MAX
    https://git.kernel.org/bpf/bpf/c/45ce4b4f9009

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


