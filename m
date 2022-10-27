Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD060ED71
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 03:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiJ0BaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 21:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ0BaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 21:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0A792CF;
        Wed, 26 Oct 2022 18:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2921D62104;
        Thu, 27 Oct 2022 01:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FA13C433C1;
        Thu, 27 Oct 2022 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666834215;
        bh=DB++pazv5ozlsiKREdOHZcQWip34xtnYMkgDfscnfkU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KeINVIRrFlYgLPXfLhK8qp0r06gXlL7kTXmGOwViWNOtF6XT3Qg+CSde2frrJvjlp
         7NCEDbWb9JY+MWzRGKEzQTGhIsLaVdvkTAzwZL1505j3l+2VQThcl7qc1GGezu1hQT
         IuFsyaGiDjBXvNHyBZmlkuSWXQcUZpoIGSpRES0MsP9GNtfCbzx+mvLlFPQwV5sYR3
         FECYFhHocWnn7Jm1o7AFl2WB0SLCqvtCy1fQRZrT2AgLz5EAB9Ajy81aHK6JHzV62C
         G2UFE6Fub+fXujZqwsZKA99B2thJsDlAcibnGZF/medD5OIFTL7kItM3g9uhw61egM
         o7HM4b2PgqPaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FA6CE45192;
        Thu, 27 Oct 2022 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] bpftool: Fix spelling mistake "disasembler" ->
 "disassembler"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166683421532.6869.9193789922007917963.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Oct 2022 01:30:15 +0000
References: <20221026081645.3186878-1-colin.i.king@gmail.com>
In-Reply-To: <20221026081645.3186878-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 26 Oct 2022 09:16:45 +0100 you wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/bpf/bpftool/jit_disasm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] bpftool: Fix spelling mistake "disasembler" -> "disassembler"
    https://git.kernel.org/bpf/bpf-next/c/96f341a4751d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


