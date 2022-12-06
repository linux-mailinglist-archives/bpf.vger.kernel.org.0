Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B43644D13
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 21:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLFUNG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 15:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLFUMs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 15:12:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159546653;
        Tue,  6 Dec 2022 12:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21113B81A2B;
        Tue,  6 Dec 2022 20:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1A05C433B5;
        Tue,  6 Dec 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670357415;
        bh=7x50CScDOIJMnBGxmUQtcorCJJNWjKUzQHyCRXqOD+U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qA5J1RQoZ840quVQ2lEJGT4rrd3vFVaJUnU2gdMH3j5HFMd8fXY2y/PKQYakSjZHT
         TYTl2+X29P9e9X2GpfHhhc5EqVopyXAbDzRs5Wyn3W87tJ52N5swya4TnxW2+jQKz6
         a06WN5u3lEY4auzlF19qF6o5GNnyEc8OLUnwsa/eBr7N8NFda+5iB9Ll9jqEkxUTMF
         KG7uv3IILFR6bNAkm3cf+e7vP4bxagoPW0xeupHrNvwCx8/ECAEEcmWQvkUD0M/NV+
         SHsWwbga1DZkodxLewjo7ZEnqwf+VcfxqVQPtqjh0Oouz+bsVmj5iF6PGJyIIIYFQr
         nje956gak3aBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAFFBE56AA0;
        Tue,  6 Dec 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] riscv,
 bpf: Emit fixed-length instructions for BPF_PSEUDO_FUNC
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167035741569.3897.9540113126251004476.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Dec 2022 20:10:15 +0000
References: <20221206091410.1584784-1-pulehui@huaweicloud.com>
In-Reply-To: <20221206091410.1584784-1-pulehui@huaweicloud.com>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, pulehui@huawei.com
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

On Tue,  6 Dec 2022 17:14:10 +0800 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> For BPF_PSEUDO_FUNC instruction, verifier will refill imm with
> correct addresses of bpf_calls and then run last pass of JIT.
> Since the emit_imm of RV64 is variable-length, which will emit
> appropriate length instructions accorroding to the imm, it may
> broke ctx->offset, and lead to unpredictable problem, such as
> inaccurate jump. So let's fix it with fixed-length instructions.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] riscv, bpf: Emit fixed-length instructions for BPF_PSEUDO_FUNC
    https://git.kernel.org/bpf/bpf-next/c/b54b6003612a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


