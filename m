Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8B68A88B
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 07:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjBDGUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Feb 2023 01:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDGUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Feb 2023 01:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A8761C5
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 22:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E76B82D0A
        for <bpf@vger.kernel.org>; Sat,  4 Feb 2023 06:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0B6AC4339B;
        Sat,  4 Feb 2023 06:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675491618;
        bh=N93u6+NOMIK88N6teA4tRaQaEG+fW83xdUF+glsSO08=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IilaHJE7TeXeKNltL+n8qKh0e8P3VLFsYaNz3sOZeDDQ1t3g5q42MKsiEYLkaY/cO
         T/NtXLaBGv4U9Z+5Fep1itNw8EGeyuO7LUIr4cXpaYz+TXJD/L8ZKEIpf20fIFQXp1
         0z424pBl8dwPkn4J+LlHTsDW1sXT37tODetYTqwJIxY5xWM2mR9xkt+3RivyfJ/0g3
         /Crasmgp4fQFiB8pReSq3u8mp9u7+jPW/GyOTsvcUPt1bd2gIts3sXzB5N2Bzd7RAj
         ar/1zZIvCt2rT3Kp8ecOv4NqVnW9JMyNZkJ7zwFIgqyDNYSBOAAMO1wfQusmpkxTVT
         tJh+Jox8I9GcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4FFDE270CA;
        Sat,  4 Feb 2023 06:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix typo in header for bpf_perf_prog_read_value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167549161786.12375.18239543604495686786.git-patchwork-notify@kernel.org>
Date:   Sat, 04 Feb 2023 06:20:17 +0000
References: <20230203121439.25884-1-dev@der-flo.net>
In-Reply-To: <20230203121439.25884-1-dev@der-flo.net>
To:     Florian Lehner <dev@der-flo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  3 Feb 2023 13:14:39 +0100 you wrote:
> Fix a simple typo in the documentation for bpf_perf_prog_read_value.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>  include/uapi/linux/bpf.h       | 2 +-
>  tools/include/uapi/linux/bpf.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - bpf: fix typo in header for bpf_perf_prog_read_value
    https://git.kernel.org/bpf/bpf-next/c/17c9b4e1a7d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


