Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4144067B88D
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjAYRaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 12:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjAYRaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 12:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884162006B;
        Wed, 25 Jan 2023 09:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E3BB81B54;
        Wed, 25 Jan 2023 17:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E693DC4339B;
        Wed, 25 Jan 2023 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674667817;
        bh=xFfZ/wlQiMSSLDumbVmp038tztLwpQ9suVw9G/i7sbA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=atVqVTf1Qp5KWxnWHWJ9MsGOpj4b5RKNR0DwbOI+zYqLUoOT9yrXLa/0SCzJPLwZR
         iO3M6lkQq8KufONvkdfk57nC7K8OZN0OkXaCF9zDs+TZeXTA12siMRpLFaZ7W5LQMM
         MH8WY2T9CGMKwgO4K8rj6mITxSFZQ5wbI2zyWFEP76pLQJxgdprmfIJezxDwCWbjqD
         rgvZ3XtH+SDi4wXBFBLakX4wnmNSgIZENxwKwu8ZkMJqwrdy/vXGf2qBnhA5smTgMG
         ljtXme6wIscpPma7dsACylxqfGXOqkLdGXIl4vaXDCJPQCV7iii3z8plARN00c/10u
         eqrGLSABaT34g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C819FF83ED0;
        Wed, 25 Jan 2023 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] tools/resolve_btfids: Install subcmd headers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167466781681.13690.9875840754457766562.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 17:30:16 +0000
References: <20230124064324.672022-1-irogers@google.com>
In-Reply-To: <20230124064324.672022-1-irogers@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, connoro@google.com,
        nathan@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 23 Jan 2023 22:43:23 -0800 you wrote:
> Previously tools/lib/subcmd was added to the include path, switch to
> installing the headers and then including from that directory. This
> avoids dependencies on headers internal to tools/lib/subcmd. Add the
> missing subcmd directory to the affected #include.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> [...]

Here is the summary with links:
  - [v4,1/2] tools/resolve_btfids: Install subcmd headers
    https://git.kernel.org/bpf/bpf-next/c/af03299d8536
  - [v4,2/2] tools/resolve_btfids: Alter how HOSTCC is forced
    https://git.kernel.org/bpf/bpf-next/c/13e07691a16f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


