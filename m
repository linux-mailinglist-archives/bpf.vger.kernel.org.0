Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0144AE371
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381547AbiBHWWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386998AbiBHVkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 16:40:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B5C0612B8;
        Tue,  8 Feb 2022 13:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DD4161638;
        Tue,  8 Feb 2022 21:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 851FEC340EE;
        Tue,  8 Feb 2022 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644356408;
        bh=H7c2nk0Uo1AfUDbhAwMbIB5dfEpZKr1ih26waXCPdkw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ta0MhK4FEzO/B+Zhb+wFo9bUMnuqfTnbiFGIZEanjltQXJMI6HooCfrkX7J0o2dOZ
         FLgt83qPS7pHq0YuRio1H+YQ5ijSECBmucIJfHRkTMUNbaVIYyJ6QJvzaiSwl4QuuU
         R1t8J+AIMMIa8jbOxOXYqRTZrwj9kqhy/Q9QIw9QEzUK1OhNhAtv34gqUDfBfPjmHA
         ol3uWiSS5GCdaoysBiolKAG7IYMazBFiRUpbARAMiopuMmINz9uZFQhhUj6Mhh7AGb
         L7Kjm7qiB3l5zR/sQrKL63jOAd5i5+AsADx0itB3jY+6WIKgfgMXcAym76/BMJzuF1
         Xqmh1sIYVUipg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E43DE5D084;
        Tue,  8 Feb 2022 21:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix signedness bug in btf_dump_array_data()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164435640844.13285.18161344073556869381.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Feb 2022 21:40:08 +0000
References: <20220208071552.GB10495@kili>
In-Reply-To: <20220208071552.GB10495@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ast@kernel.org, alan.maguire@oracle.com, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 8 Feb 2022 10:15:52 +0300 you wrote:
> The btf__resolve_size() function returns negative error codes so
> "elem_size" must be signed for the error handling to work.
> 
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  tools/lib/bpf/btf_dump.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - libbpf: Fix signedness bug in btf_dump_array_data()
    https://git.kernel.org/bpf/bpf-next/c/4172843ed4a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


