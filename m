Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2505262B2E4
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 06:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiKPFlE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 00:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiKPFkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 00:40:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEF3C6E6;
        Tue, 15 Nov 2022 21:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 093D5B81BE8;
        Wed, 16 Nov 2022 05:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A48D3C433D7;
        Wed, 16 Nov 2022 05:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668577215;
        bh=xzp73soH9qhxMMprTJUUEmiRXnNqGTejgKHr/P4shEY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pt7Y6zRzNt7yrW5SuzWvyKrQdZyTErOocX0WPhpMNYANKQw95u6Ah4Z5U1lEmxlR3
         Lcprsn2uHXjycz1jf7CXwEKe1p1TnwVouQoFr8lS0qVpU7p+/p2KidQnA1uhiCb999
         X1eu+WOWr+dk+3nKn6uBV1OIxXIpUcCqQ5yUemFP5sjlubBQ5/zWc5ZaNyP6mHsF79
         w3PdW6W7KjOAWzJlZOIw4sAf7TOIDxHT+DLhd8OBsiKHQLq/j6I3zRQLNYTQBtqQbA
         MiA/0KsyaKz15uSsrTXynEy5ZudKq9Co1f/9aOnL5maxgM7A9G98s34bquuwspZh3j
         dHYGIvC3dP/+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82122C395F6;
        Wed, 16 Nov 2022 05:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] docs/bpf: Fix sample code in MAP_TYPE_ARRAY docs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166857721552.26805.16201329385041554291.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Nov 2022 05:40:15 +0000
References: <20221115095910.86407-1-donald.hunter@gmail.com>
In-Reply-To: <20221115095910.86407-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, andrii@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, corbet@lwn.net
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
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 15 Nov 2022 09:59:10 +0000 you wrote:
> Remove mistaken & from code example in MAP_TYPE_ARRAY docs
> 
> Fixes: 1cfa97b30c5a ("bpf, docs: Document BPF_MAP_TYPE_ARRAY")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/map_array.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,v1] docs/bpf: Fix sample code in MAP_TYPE_ARRAY docs
    https://git.kernel.org/bpf/bpf-next/c/e0eb60829a6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


