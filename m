Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B850D4F0D34
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 02:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351547AbiDDAWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 20:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347200AbiDDAWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 20:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373522BC9
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 17:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA6A60FEC
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 00:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF4E9C34111;
        Mon,  4 Apr 2022 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649031610;
        bh=1dk6FUH31uvcq9NYe144vAn+iErMrX0eBwQwk4njBWk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YQHxq7YSchtkeSxhFseE0umYWzLFSlpBL9Ni29qEB1HOdbHz+Zv1OntbEPfO/FcW2
         b6eHLD+Nid0gfKzZiYnFeMV8fnRICcT7GXSJInF5pAKXZGx7cXWk6c/0Ie3Tp8P/ji
         Lptf+BvRbbHb6pNCnqyEDd5OtE/cODd068yscgy3KEGwUqAzBvFp2la/6XXZ56SpnI
         XFq8kT2DdOEmDlxz15BG/qZNhz7TkRf8jWJcyio8Gcc2uDl29l5dvzpZSbbOgPm0gA
         aZP4huoCDOr8dFiu8s4ddnOlaHwTnWlFfIUomZRFAAqvvxG1T1+0Rnj+oLx1AUjw9f
         l4crPhlyPIa8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5634E4A6CB;
        Mon,  4 Apr 2022 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] samples: bpf: convert xdp_router_ipv4 to XDP
 samples helper
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164903161073.20476.13881234000608512214.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 00:20:10 +0000
References: <7f4d98ee2c13c04d5eb924eebf79ced32fee8418.1647414711.git.lorenzo@kernel.org>
In-Reply-To: <7f4d98ee2c13c04d5eb924eebf79ced32fee8418.1647414711.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, andrii@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 16 Mar 2022 08:13:23 +0100 you wrote:
> Rely on the libbpf skeleton facility and other utilities provided by XDP
> sample helpers in xdp_router_ipv4 sample.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - add missing LIBBPF_STRICT_ALL flag in xdp_router_ipv4_user.c
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] samples: bpf: convert xdp_router_ipv4 to XDP samples helper
    https://git.kernel.org/bpf/bpf-next/c/85bf1f51691c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


