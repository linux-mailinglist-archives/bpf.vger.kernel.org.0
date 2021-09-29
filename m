Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9805B41CF94
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 01:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346951AbhI2XBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 19:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344976AbhI2XBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 19:01:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8421C61503;
        Wed, 29 Sep 2021 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632956407;
        bh=+wsyOZBfghuNaLspSvivWJRqQDpbhprKVDNYR4ljxc4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kIwpmNoJ/Up+MAY5WVDBnTbeYTQYJSxQslOUg0srJ0SY/Fh7djunEilP0Rl8q7fAc
         rYlVI7gk1KytmSPnwDroyDK4q0o/iPrFpAsylkcFAG93v6k7Cwzu4Pyu1k9/62bIiA
         HMnPs0A2wqdI8wQSUMApN1MYbtspEQ52IfER8cuRFhN7f0jB8xpXR2ApfHX6t5gT4G
         N0J6WXYIWkc3HzVvFmOtxZ+tY7Ynp9WMhlCKlEg06wsscb31/NriSwNmihzAB8P8EW
         k1uCUHE2osime/l7f90WPtUkPrfV/yZcNR/DdTrwVg6bBxRWz0xvycIT076wtkhT14
         XSUoXyI6CoSGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 718E660A59;
        Wed, 29 Sep 2021 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: properly ignore STT_SECTION symbols in
 legacy map definitions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163295640745.26180.7434864795119924642.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Sep 2021 23:00:07 +0000
References: <20210929213837.832449-1-toke@redhat.com>
In-Reply-To: <20210929213837.832449-1-toke@redhat.com>
To:     =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jbenc@redhat.com, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 29 Sep 2021 23:38:37 +0200 you wrote:
> The previous patch to ignore STT_SECTION symbols only added the ignore
> condition in one of them. This fails if there's more than one map
> definition in the 'maps' section, because the subsequent modulus check will
> fail, resulting in error messages like:
> 
> libbpf: elf: unable to determine legacy map definition size in ./xdpdump_xdp.o
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: properly ignore STT_SECTION symbols in legacy map definitions
    https://git.kernel.org/bpf/bpf-next/c/161ecd537948

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


