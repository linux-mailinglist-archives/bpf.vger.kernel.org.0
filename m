Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9D9561E08
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiF3Oep (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbiF3Oeb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 10:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B54882B
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 07:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F86622EF
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 14:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82736C341CC;
        Thu, 30 Jun 2022 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656598814;
        bh=zUHRdsmmSzFiR0jSbWET6AgBIVsQBcQani9kWaOzRVI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X3BZWCUWYcfCZYFolaV4piHYwi0f9aIExf4akvNrJtBp2NAanyq/ucako3nmipBYn
         GwB+AuSjv5UwsABHS2H04Khx9jn5Y7ti2Nt1E3t1G1tqeyCLFuO819U8Wg5e1mzl/T
         Jw0T+du+HrcBsNnHwIvhMeXG0uNfWlRA2i7cE9cHwRdOBbwIN48eofDFm6x+F/7dc1
         wDo15JFh83zn+wV6oUYMFiaZa05Zkj7JoL4qVgqHyeAYoZYgNE3vA7XbeMHKzKLVhK
         Xtfi0cx7huccbuK9kvnA4Ca5tPf6U3J4a13DScN7flMR5fMgllYDZtdV5GVZujN+O6
         UHuSu52XuzgEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66326E49FA0;
        Thu, 30 Jun 2022 14:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: remove attach_type_name forward declaration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165659881441.5783.17234494591426370818.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Jun 2022 14:20:14 +0000
References: <20220630093638.25916-1-tklauser@distanz.ch>
In-Reply-To: <20220630093638.25916-1-tklauser@distanz.ch>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     quentin@isovalent.com, bpf@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 30 Jun 2022 11:36:38 +0200 you wrote:
> The attach_type_name definition was removed in commit 1ba5ad36e00f
> ("bpftool: Use libbpf_bpf_attach_type_str"). Remove its forward
> declaration in main.h as well.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/bpf/bpftool/main.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [bpf-next] bpftool: remove attach_type_name forward declaration
    https://git.kernel.org/bpf/bpf-next/c/b0cbd6154a9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


