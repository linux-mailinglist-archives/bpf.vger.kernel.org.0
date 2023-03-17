Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3B6BE9D7
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 14:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCQNKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQNKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 09:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35CB422E;
        Fri, 17 Mar 2023 06:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D090CB825A1;
        Fri, 17 Mar 2023 13:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58EBBC433D2;
        Fri, 17 Mar 2023 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679058618;
        bh=MY5xwCuO4flwLvgyGZo2hVL1JS4/6IAEeIaj2lW+TLA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r5JPuxWTnbrQQf0D1VHn5t0LLdXzNSYE/WcMNVIaeGVxhz7YQ17YqpxAnnq8lJbiZ
         FtNR4iaDoiOIJMIYHTX2ipzN6mQGTPyLilGIJB+UpW1Pn6/bpdHdVJ8MM06hmUbIyY
         hM6I6MMjGegKdvEr2QRhztzqRJkoPEO5TGP+0fsKHAeG7mEV8jIb5ODw2PnWN5alGH
         MKRmGPQyyr7UP8olpuMwNsZBXD65tihm6BCrtH5Oq3UsRSTFK1R2v4zehjVCRjrL2j
         GGA5SxQFXdW/0vqEMkOrPB6OTSp6tXhNLaCgeHGKQG3uZY65xQYnoAn14O8JnfYvi1
         Zr0ADZukA68ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D0E5E66CBF;
        Fri, 17 Mar 2023 13:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 docs: Use internal linking for link to netdev subsystem doc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167905861818.22019.13807434741181931132.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Mar 2023 13:10:18 +0000
References: <20230314074449.23620-1-bagasdotme@gmail.com>
In-Reply-To: <20230314074449.23620-1-bagasdotme@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        corbet@lwn.net, void@manifault.com, davem@davemloft.net,
        me@tobin.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 14 Mar 2023 14:44:49 +0700 you wrote:
> Commit d56b0c461d19da ("bpf, docs: Fix link to netdev-FAQ target")
> attempts to fix linking problem to undefined "netdev-FAQ" label
> introduced in 287f4fa99a5281 ("docs: Update references to netdev-FAQ")
> by changing internal cross reference to netdev subsystem documentation
> (Documentation/process/maintainer-netdev.rst) to external one at
> docs.kernel.org. However, the linking problem is still not
> resolved, as the generated link points to non-existent netdev-FAQ
> section of the external doc, which when clicked, will instead going to
> the top of the doc.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, docs: Use internal linking for link to netdev subsystem doc
    https://git.kernel.org/bpf/bpf-next/c/0f10f647f455

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


