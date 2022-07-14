Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6564C5744BA
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 08:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiGNGAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGNGAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 02:00:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81651AF3C;
        Wed, 13 Jul 2022 23:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79B62B82389;
        Thu, 14 Jul 2022 06:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCC8DC34115;
        Thu, 14 Jul 2022 06:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657778413;
        bh=2bpDyAZGlWx8XeLEUwm0hM/UOHB/dG6A4q/TSs2rE08=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PgE7vnB91UgRp6AIlGWI2N/TpUulLg9QQhUMfz5nyEVZXaEVMInErBr5ic99812NQ
         UR5yyJd5PyzEa+m731Ya2RfbZ6rdXU/5WoSaerfziXSMPhH0wK+OuVPqete2EuZkrS
         1xqcZhNzXIy0EhArjSg1pFooROxTooNrxmsezUtfaexBOlt0Jw3pxcNFc9wCYsJDxz
         2adMfm4w53i//YgKBZWAizphhAwx849+oF5Ucd8crcCvr25e9yV2ngjJONX8V5RRlX
         czFf5Z906pCJekoJ1RiirFd76ZuWHhqXqZiRU6xvdZmHsdLJTCEa2eCERg9KDaFPdb
         WKsUT6TN6p7oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A77FEE45227;
        Thu, 14 Jul 2022 06:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: fix the name of a reused map
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165777841368.17899.18317064610062383863.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Jul 2022 06:00:13 +0000
References: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
To:     Anquan Wu <leiqi96@hotmail.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Jul 2022 11:15:40 +0800 you wrote:
> BPF map name is limited to BPF_OBJ_NAME_LEN.
> A map name is defined as being longer than BPF_OBJ_NAME_LEN,
> it will be truncated to BPF_OBJ_NAME_LEN when a userspace program
> calls libbpf to create the map. A pinned map also generates a path
> in the /sys. If the previous program wanted to reuse the map，
> it can not get bpf_map by name, because the name of the map is only
> partially the same as the name which get from pinned path.
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: fix the name of a reused map
    https://git.kernel.org/bpf/bpf-next/c/bf3f00378524

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


