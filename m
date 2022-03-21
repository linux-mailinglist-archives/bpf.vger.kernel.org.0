Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316914E1EEF
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 03:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbiCUCBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 22:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiCUCBk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 22:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795611262B
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 19:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C8B1B80FAC
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 02:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6887C340F0;
        Mon, 21 Mar 2022 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647828010;
        bh=1/q67SumEUmWtGI/2n6XN9N7TdnJ4ZGajwj6IzMzPDs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zj4zLAeLLCftQsiFY81IkcbxWtR7nggrkzbk16BtKTw/+lhidCsRLToiTT+rRX1+C
         y6ZYbR+hPPqkVf2883S1oAqj2Qa6zaHQlYZQhDRifcZYVXrHLRpH1JcQaotzksavyf
         G+tYCo+HvJ3vAz8In0sc4E3biYgCVZ0F7W1WFxfW3V7Uf1deA5AgyFjW6GnGZB0TSx
         JLaLaN01AUpnx1YFBwH5wi6Rt13a1x2+pNBOqznqqyDtxdz9bm3Y7V49en4Gpk8+Do
         Y1O4xXYSpR2LriTW8SmPjRyhtVv1S5SFPB1nrkr4XHA6nRPjduwFW7gCzBXI5SqjPb
         UR63MHS6hTBZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A503F03846;
        Mon, 21 Mar 2022 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: avoid NULL deref when initializing map BTF
 info
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164782801062.32327.3357486469827182558.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Mar 2022 02:00:10 +0000
References: <20220320001911.3640917-1-andrii@kernel.org>
In-Reply-To: <20220320001911.3640917-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sat, 19 Mar 2022 17:19:11 -0700 you wrote:
> If BPF object doesn't have an BTF info, don't attempt to search for BTF
> types describing BPF map key or value layout.
> 
> Fixes: 262cfb74ffda ("libbpf: Init btf_{key,value}_type_id on internal map open")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [bpf-next] libbpf: avoid NULL deref when initializing map BTF info
    https://git.kernel.org/bpf/bpf-next/c/a8fee96202e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


