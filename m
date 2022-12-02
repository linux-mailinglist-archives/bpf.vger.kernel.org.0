Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B704641000
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 22:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiLBVaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 16:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiLBVaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 16:30:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4B60B52;
        Fri,  2 Dec 2022 13:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFEF2B822BD;
        Fri,  2 Dec 2022 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84A07C433D6;
        Fri,  2 Dec 2022 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670016619;
        bh=nDPDgygeyz+PSAwztB144Wz/L86h8qovnsGSzx36rGs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=K1js8FYQR2oVve/fnWt4g35opHXJhUDLuExx3pH64rOEvkgEleTJiCRca2JEmk33V
         PFIV4djStGNE7X6d6pXf53bIQ63xtiMEFaRS3gsFTlzS3AymIr0eJPVw+q8Ih6qSIL
         GCnjk1iX9ktoLREaZ28KeDRB8RaKM+t1DDu1HXi8EduRnBpc98lsCmuuqhiTs+srDi
         atAwwOWmOu66DcGuw6umMPVuHYpfsRChktV9LCcPwNjCoF8KWRdtTNMBVLTdbml2JK
         V/KSecpUsPpvX9mx6NVOArx13/+lL34lNqOqn+5QGG+5FFiGAi1zl0shsQ/bq9rtPf
         YxZLUZD5PFRkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6774BE21EEF;
        Fri,  2 Dec 2022 21:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, docs: Correct the example of BPF_XOR
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167001661941.2078.7625325566074444761.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Dec 2022 21:30:19 +0000
References: <20221129134558.2757043-1-zhengyejian1@huawei.com>
In-Reply-To: <20221129134558.2757043-1-zhengyejian1@huawei.com>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
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

On Tue, 29 Nov 2022 21:45:58 +0800 you wrote:
> Refer to description of BPF_XOR, dst_reg should be used but not src_reg
> in the examples.
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  Documentation/bpf/instruction-set.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf] bpf, docs: Correct the example of BPF_XOR
    https://git.kernel.org/bpf/bpf-next/c/bc067cacb69c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


