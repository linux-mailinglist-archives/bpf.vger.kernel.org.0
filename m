Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFCA4BA428
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 16:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiBQPU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 10:20:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiBQPUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 10:20:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826FB2B048E
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 07:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 970B161E96
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 15:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF9F9C340E9;
        Thu, 17 Feb 2022 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645111210;
        bh=XUI7yfPTsjzoI8S8ylrY/qsdiK8nDILfH9MP6+mx3z8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UIGtRaIfjjWLntwmvndgphZ8aP4lvHtOT/Pql/+AJ0JjO11mo4XJePCOD5lDgeHpl
         01iRmATtMlSpNlGp+JVvTouCkqBjb2K1Gyx1cP0QLM01OMZ+qE7hpy1gDxPwT5MzsH
         fsIUlnbISq1oamuSns/bwDUXRhnpP4YN18VVxDDaULpplnJX7okwIiUDjNTmwtcjeA
         hgsse8fyFVlKrL9Nlua1SKVfj6LylS/Y1Q6A3NCiIrc13PDWdvjzxiKaVgMU9JzUGm
         xW8uKZe2kZxXHg/vVqMof/ZSvS9qFj49PMnCuyw01RP2BBGJFLdCIB+eUxBhyev61+
         xN3Yn5vAtlzWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D76B3E6D447;
        Thu, 17 Feb 2022 15:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix memleak in libbpf_netlink_recv()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164511120987.26506.14311462283937671604.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Feb 2022 15:20:09 +0000
References: <20220217073958.276959-1-andrii@kernel.org>
In-Reply-To: <20220217073958.276959-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, toke@redhat.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 16 Feb 2022 23:39:58 -0800 you wrote:
> Ensure that libbpf_netlink_recv() frees dynamically allocated buffer in
> all code paths.
> 
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> Fixes: 9c3de619e13e ("libbpf: Use dynamically allocated buffer when receiving netlink messages")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix memleak in libbpf_netlink_recv()
    https://git.kernel.org/bpf/bpf-next/c/1b8c924a0593

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


