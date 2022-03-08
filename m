Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269F4D1B5D
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 16:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347752AbiCHPLK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiCHPLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 10:11:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6032A719
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 07:10:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A17A3B8198C
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 15:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46B11C340EF;
        Tue,  8 Mar 2022 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646752210;
        bh=xCtSExvWA8601cyn6IHTFr8VdeEWu+DsP+myP6Q+6eg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rcH28RkCJ7bYryQvvKefsB6mVV5n4dsCdsxdhHDqXn/9x6lHVNwFCz0CNBe+q6xwr
         McJXAIhrYPO8BJDfRu/fltKXEO25nkpcLTP/F5zA8vkeS6VyEK3fTtcJnPFcIASRmf
         cfYM1Eiufosq44FEy2tovMEYnrimL7G3iy9QIMrAbJ3FuPiezk7BdjQAw4pr/LmiJ1
         XVcnQfrwNiqCdVferBa1VvP2gIl94VNIaVqLp44NvH1/oRq6DfAXsR5xBRyuccfR/f
         wcqY6rLCtr4xartHL8JNzTnBfZe8hc4hvIGVCc9nMn2h4TT5/lQt0ih10GAMrAkf70
         hv9Y25Ob++D9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A800F0383A;
        Tue,  8 Mar 2022 15:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests: bpf: Make test_lwt_ip_encap more stable
 and faster
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164675221017.28766.15263486307826146656.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Mar 2022 15:10:10 +0000
References: <4987d549d48b4e316cd5b3936de69c8d4bc75a4f.1646305899.git.fmaurer@redhat.com>
In-Reply-To: <4987d549d48b4e316cd5b3936de69c8d4bc75a4f.1646305899.git.fmaurer@redhat.com>
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, posk@google.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu,  3 Mar 2022 12:15:26 +0100 you wrote:
> In test_lwt_ip_encap, the ingress IPv6 encap test failed from time to
> time. The failure occured when an IPv4 ping through the IPv6 GRE
> encapsulation did not receive a reply within the timeout. The IPv4 ping
> and the IPv6 ping in the test used different timeouts (1 sec for IPv4
> and 6 sec for IPv6), probably taking into account that IPv6 might need
> longer to successfully complete. However, when IPv4 pings (with the
> short timeout) are encapsulated into the IPv6 tunnel, the delays of IPv6
> apply.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests: bpf: Make test_lwt_ip_encap more stable and faster
    https://git.kernel.org/bpf/bpf-next/c/d23a8720327d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


