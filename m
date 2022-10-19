Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F202604FCD
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJSSkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJSSkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF51735BB
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A933B825B9
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3D82C433D7;
        Wed, 19 Oct 2022 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666204818;
        bh=buYo4dHhbNimnYik07562vR624YeZq4Pj0aMTkKFzns=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GalKdjZifgqZckbN01d+5NADbVN2zwv4VkmIBdZJf/OdAodwwgwlWjXMsUEnF63Iy
         MugjXqry2EdpuRKelROjErrzHrAlexw73/spVZwz/EtMbS/qu0Ne/YPzFfNbsSxPai
         dIVaHQh9eFaAhWUsBBGi78HdQTyMGkre2I3AAYIzEOY+I7KybQPjOfO2ARu3ZTrilE
         03pmN/o3MemyAh4hfYy+Hr4F2doHry84KTn47i7mGSqZKNf7bvbU6t5yi883kTfFkV
         TFoy/U58arq8pDubdeJIpllPonmEUWZADi1HbYrpieZhIbIlaHeJDDATQgBbTbopWZ
         C3a7thUZff8Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DFBEE4D00A;
        Wed, 19 Oct 2022 18:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] samples/bpf: Fix typos in README
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166620481856.29956.13364279029934739551.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 18:40:18 +0000
References: <20221018163231.1926462-1-deso@posteo.net>
In-Reply-To: <20221018163231.1926462-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com,
        void@manifault.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 18 Oct 2022 16:32:31 +0000 you wrote:
> This change fixes some typos found in the BPF samples README file.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> Acked-by: David Vernet <void@manifault.com>
> ---
>  samples/bpf/README.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next,v2] samples/bpf: Fix typos in README
    https://git.kernel.org/bpf/bpf-next/c/2c4d72d66b54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


