Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3856C287
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiGHWkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGHWkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29D13B471
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 15:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A51AAB829E4
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 22:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41D4AC341C0;
        Fri,  8 Jul 2022 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657320013;
        bh=xGQUJQuKUsDoNKNcc4ZDb7AJQ2xWn536Y9YZDz238qI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qsUjA39pJJgwwkavzMaVV1mFibAsVGzmLAeBsaEnPyjA0mjgqtv9Te7hhcUHgyL6X
         SSfG5A2PKQ/Mn5eQw01HtT3T3PmRJHp8I4AzMhanepfy6NbbtfJdpnuhicuqTVnIEt
         0+oa0pP+MSB2Y4cBTfTaVl3VaCMlDAM2h7ixs9oPhNFru1FaicjCYAdo68zMxEF+Qr
         fBKzod5c3kiXvzXxgy0LMeyZ7TCKvboj2KndI7g08gC6A5GjGp97OsCub/D3qOpoS/
         5zsTFNrhl+fs6ygwkuuNeS9Q+wtGOXUkfAlNbOd8jOLiSGyMn1iB3S4I4yvnZwaJc7
         4DJUbVAaO2geQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 286C5E45BDD;
        Fri,  8 Jul 2022 22:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Correctly propagate errors up from
 bpf_core_composites_match
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165732001316.11874.6116655644375245818.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Jul 2022 22:40:13 +0000
References: <20220707211931.3415440-1-deso@posteo.net>
In-Reply-To: <20220707211931.3415440-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu,  7 Jul 2022 21:19:31 +0000 you wrote:
> This change addresses a comment made earlier [0] about a missing return
> of an error when __bpf_core_types_match is invoked from
> bpf_core_composites_match, which could have let to us erroneously
> ignoring errors.
> 
> Regarding the typedef name check pointed out in the same context, it is
> not actually an issue, because callers of the function perform a name
> check for the root type anyway. To make that more obvious, let's add
> comments to the function (similar to what we have for
> bpf_core_types_are_compat, which is called in pretty much the same
> context).
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Correctly propagate errors up from bpf_core_composites_match
    https://git.kernel.org/bpf/bpf-next/c/06cd4e9d5d96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


