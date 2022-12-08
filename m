Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E28647561
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 19:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLHSKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 13:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHSKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 13:10:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0F52145;
        Thu,  8 Dec 2022 10:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F55A6202D;
        Thu,  8 Dec 2022 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90258C433D2;
        Thu,  8 Dec 2022 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670523015;
        bh=HMf5psgvdkU17cKci+7/ka5MOFIb0JGThR3ibASYt5g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pJDOzaLzH/gp2hjfRDvlaf0okWJ1qEUGJQRfUL+WaSXj3deB+NYEFE8wz46OtT8x3
         blg+DqFRUSPaTXpmGf3ApraCZA6tqwQBYZJ5pso3ySW8LT2ZnDxa9VWwS+uWsQUkn5
         lIMbH2Oxn6qzvlV2O5ThDVyKU9zmG9+FLZa+1b4X5lO/KWNf26aXmZh1lwIBNONd/d
         nPlyifazHB4RCrNL937HGv/Yo5URMSNWpoipeZ0mjzrcuq4OfSsqIkGi0k44/N4rkp
         nxTk6Sg+hg94+E2EZSe66DOM9V2qs/vCosbwGzia10sewN7mJdQB9jTOX+F67qczcB
         oJLJOkoBXh5qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75468C41606;
        Thu,  8 Dec 2022 18:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix comment error in fixup_kfunc_call function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167052301547.11439.6292070510258498438.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Dec 2022 18:10:15 +0000
References: <20221208013724.257848-1-yangjihong1@huawei.com>
In-Reply-To: <20221208013724.257848-1-yangjihong1@huawei.com>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 8 Dec 2022 09:37:24 +0800 you wrote:
> insn->imm for kfunc is the relative address of __bpf_call_base,
> instead of __bpf_base_call, Fix the comment error.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] bpf: Fix comment error in fixup_kfunc_call function
    https://git.kernel.org/bpf/bpf-next/c/c2cc0ce72a5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


