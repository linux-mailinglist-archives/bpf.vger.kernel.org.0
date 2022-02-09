Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3F4AF308
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 14:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiBINkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 08:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiBINkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 08:40:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22316C0613CA
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 05:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E41B8218F
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 13:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FEC5C340EE;
        Wed,  9 Feb 2022 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644414009;
        bh=n+HL9+jZvYBRHAsCY8gwDT6AXyIzHHCUVLPVlE+4vgU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iMW53uqb6yd72kHNbKLbXY0b4EP/3CZsSr0YMhDo/+33244p3RPhLKdSaoNebgH+K
         3gFHNWbRD9dgv8OeY10thpgQ03SRFK9vlD7VakCrG6y/jwSuSs45Od8sMyZqd27r3y
         wW0zvljL/u7DB2j7uzkTgy+f+VmWq5A4CKAQgGXCFtrPrcl233VZJJlxmHLZjTNvVT
         SnKu/3xWXvAj9Nu5IPUNC+kEh5rmHUAf1QV5rj5t7+SW9HJDHRtfsWc5+/s6QxOmQC
         5E+2LA/hY3M3VD8w5VbTEdIv8uDTtlz7l3uro8lpTIVGcpA3Sh/qUJ6+m3VP+h5Awl
         oE+p/XI6OanmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CE7EE6D458;
        Wed,  9 Feb 2022 13:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix compilation warning due to mismatched
 printf format
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164441400904.27404.210375468260181416.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Feb 2022 13:40:09 +0000
References: <20220209063909.1268319-1-andrii@kernel.org>
In-Reply-To: <20220209063909.1268319-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 8 Feb 2022 22:39:09 -0800 you wrote:
> On ppc64le architecture __s64 is long int and requires %ld. Cast to
> ssize_t and use %zd to avoid architecture-specific specifiers.
> 
> Fixes: 4172843ed4a3 ("libbpf: Fix signedness bug in btf_dump_array_data()")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf_dump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: fix compilation warning due to mismatched printf format
    https://git.kernel.org/bpf/bpf-next/c/dc37dc617fab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


