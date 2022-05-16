Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216E35292A9
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 23:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiEPVJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349213AbiEPVIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 17:08:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36590213
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 13:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC490B81662
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 20:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC19C34116;
        Mon, 16 May 2022 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652734212;
        bh=waTm6HxxDeXHYals0sIZH9fcaTU2cSySso6vz2Wm5bc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OIzVhAMTcDARiC0KWZduSFn0zN4NwU8ynQndxhbdAix1HPRwDG3/RW9IZa2Y1GJDz
         /sa4ZqRzTfxYOatB+FZsZP+fRSK5XZtAMBcGNR65z0NjZoxprcQRkstl+hcU6xjZyE
         r1sbGtlcTeNDjWhgLtUlwZUGFtwBEWhqopYWh5Nvsw22EFtss9x8nSS2Exk9EuxNHS
         HKQa382fv0Hv398Xg2UMmqvKvOEJS6g7wJ4DgtBuVGdMtYfukEuwUox7JOO+elpvYn
         joow1XnZ8WtvLWRAPBpLxXuGsBdjCr3hJp0GtcfcfOfJBfFJ92w/4iX75+Z1j4hqSn
         Oqy3Vhp1Qw/fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FB55E8DBBF;
        Mon, 16 May 2022 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix memory leak in attach_tp for target-less
 tracepoint program
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165273421231.18505.12010272072291099949.git-patchwork-notify@kernel.org>
Date:   Mon, 16 May 2022 20:50:12 +0000
References: <20220516184547.3204674-1-andrii@kernel.org>
In-Reply-To: <20220516184547.3204674-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 16 May 2022 11:45:47 -0700 you wrote:
> Fix sec_name memory leak if user defines target-less SEC("tp").
> 
> Fixes: 9af8efc45eb1 ("libbpf: Allow "incomplete" basic tracing SEC() definitions")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next] libbpf: fix memory leak in attach_tp for target-less tracepoint program
    https://git.kernel.org/bpf/bpf-next/c/ac6a65868a5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


