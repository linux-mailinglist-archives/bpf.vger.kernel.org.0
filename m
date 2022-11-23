Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B5636C7D
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiKWVkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiKWVkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:40:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A139735E;
        Wed, 23 Nov 2022 13:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11EACB82504;
        Wed, 23 Nov 2022 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B82BC433D7;
        Wed, 23 Nov 2022 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669239616;
        bh=XZ6qsb1C3ipvzO8jvbjytsG7EqMlcQZzlAxvCp5d05U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qLshlrY6dKmQhLHE6CsG3xtGyWkAlz1TC8kPltrjjB4XfVzQd9jP/FWZ3pCGINmp8
         HsLXHwhWlpAnLCPWtunsnLrZh3Q+4FaRLSJDKzmV6hzK6cI9He7viEWBYLVoppvUhQ
         X/Xu9PvX/w6q8IEOaUwluv50bGyrtTm1zuRgDnlEVJ3t1ZX2p0TuHkgYfHoME1L8c5
         X7pJUAsRK3KcKgCWMSXEB0d2DW3nquvHuPr66+UqRkEDUUFelP2DdvjaXeSwGHllDb
         ryn6l7DgIZSzzJCbjgMn4jBONieI7Yv9ZprMm/nLwCxob1EVHQAyHGZzOExIVUzIFw
         XqZKs60TtOpuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71D29C395C5;
        Wed, 23 Nov 2022 21:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6] docs/bpf: Add table of BPF program types to
 libbpf docs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166923961646.12268.7189632084415905671.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Nov 2022 21:40:16 +0000
References: <20221121121734.98329-1-donald.hunter@gmail.com>
In-Reply-To: <20221121121734.98329-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
        void@manifault.com, bagasdotme@gmail.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 21 Nov 2022 12:17:34 +0000 you wrote:
> Extend the libbpf documentation with a table of program types,
> attach points and ELF section names.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Acked-by: David Vernet <void@manifault.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6] docs/bpf: Add table of BPF program types to libbpf docs
    https://git.kernel.org/bpf/bpf-next/c/c742cb7c3ebd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


