Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242B0654A77
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 02:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLWBaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 20:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLWBaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 20:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CA322511;
        Thu, 22 Dec 2022 17:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 127B0B8203C;
        Fri, 23 Dec 2022 01:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E340C433F0;
        Fri, 23 Dec 2022 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671759016;
        bh=LJZEwfI1JgwPEsho1j2ySkfxAvLOQoT7ecFLj00fago=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n133581tHDBx8eSPfewaDcW6/g1eICp3yL/0ZAb97NLT6YfKkrJpWwXSOUR/fMi26
         ZMIH1tKcByCyvGKdCmBQoTkizv7ZpiyIEQWO0D4G3az8vQ+er4ax+VDSbsAsRxc0UR
         1X05DDuH4U/qP8ZMDbe0STpxRrDLbCU7NL3H5OAE1EYVKJ+uxHp0Jjg3BEhTuRfsBi
         XUGt0j4IORe28gmNnNtezG3zmuFiU/WC3sho86tI+ZdqoYOhhMXw23EVY4cyFXNsQB
         0bbyogIrOzO5YI8kqK1mSfTrupla0Wmh8GFhxIkTsEB+ZDeoTsY27h2w1380Aygtoc
         wfebWKf9PntXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 636F8C5C7C4;
        Fri, 23 Dec 2022 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: fix nullness propagation for reg to reg
 comparisons
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167175901640.23708.9195599350391396868.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Dec 2022 01:30:16 +0000
References: <20221222024414.29539-1-sunhao.th@gmail.com>
In-Reply-To: <20221222024414.29539-1-sunhao.th@gmail.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
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

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 22 Dec 2022 10:44:13 +0800 you wrote:
> After befae75856ab, the verifier would propagate null information after
> JEQ/JNE, e.g., if two pointers, one is maybe_null and the other is not,
> the former would be marked as non-null in eq path. However, as comment
> "PTR_TO_BTF_ID points to a kernel struct that does not need to be null
> checked by the BPF program ... The verifier must keep this in mind and
> can make no assumptions about null or non-null when doing branch ...".
> If one pointer is maybe_null and the other is PTR_TO_BTF, the former is
> incorrectly marked non-null. The following BPF prog can trigger a
> null-ptr-deref, also see this report for more details[1]:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: fix nullness propagation for reg to reg comparisons
    https://git.kernel.org/bpf/bpf/c/8374bfd5a3c9
  - [bpf-next,v3,2/2] selftests/bpf: check null propagation only neither reg is PTR_TO_BTF_ID
    https://git.kernel.org/bpf/bpf/c/cedebd74cf38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


