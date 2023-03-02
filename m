Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4015B6A7838
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 01:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCBAKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 19:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCBAKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 19:10:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D702311DF;
        Wed,  1 Mar 2023 16:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A9DA614F1;
        Thu,  2 Mar 2023 00:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66D83C4339B;
        Thu,  2 Mar 2023 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677715817;
        bh=/KZu7Xbm0gvacVMiG2ePS5ncksSUI7Fd/RGGQsjPEj4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RxqgF/YryoV1uznKSvz5+rHIEkHIfCnWGKb1pSQwHz4FvlE5TXaCuGIMHPdG68Cji
         Dgh3fkk/Ar9dnoFpxrP2TB4TCZzH1iY+GWTKox9FD6DbAbQ6lJ7j5er/cVCfZgN+91
         jAWLWXtA9USiPNHaEykHOLM9mSl5Z/F6qPbw7q3yfelb9dVnAWXWKYz8ky5TWLmLT+
         NStKq7xzkXXJUye4x+30Fss1eMmmmU4WiePedWNQFTtc9G9nV2l4x7pjr6rqpGq3eU
         4tb7PWLFhF86JLUhkSNiIxMiV4Y40uwNAGfVxF22+h2wlIdS+VV3t2xwjo6/HJnD1H
         7UF9ots64pDmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48D5DC395EC;
        Thu,  2 Mar 2023 00:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix doxygen comments for dynptr slice
 kfuncs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167771581729.5276.2981278847430408937.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Mar 2023 00:10:17 +0000
References: <20230301194910.602738-1-void@manifault.com>
In-Reply-To: <20230301194910.602738-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  1 Mar 2023 13:49:09 -0600 you wrote:
> In commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and
> bpf_dynptr_slice_rdwr"), the bpf_dynptr_slice() and
> bpf_dynptr_slice_rdwr() kfuncs were added to BPF. These kfuncs included
> doxygen headers, but unfortunately those headers are not properly
> formatted according to [0], and causes the following warnings during the
> docs build:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix doxygen comments for dynptr slice kfuncs
    https://git.kernel.org/bpf/bpf-next/c/7ce60b110eec
  - [bpf-next,2/2] bpf, docs: Fix __uninit kfunc doc section
    https://git.kernel.org/bpf/bpf-next/c/db52b587c67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


