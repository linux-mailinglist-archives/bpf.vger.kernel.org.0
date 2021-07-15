Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC93CAD79
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhGOUDh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 16:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345429AbhGOUC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 16:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 748B8613C0;
        Thu, 15 Jul 2021 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626379204;
        bh=KrLFzKFOZz3VaHbC6B6yKvSwlh0cLjJbTlKfnMuTMx8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EljIP0yahN4XVHUmVD2OD+svznArYXqGs265edRnjVSh6muep0K4f9QsE2kVumYC7
         IPSKAOpJahtaNrkiPijUd/+PK5MPnFnw3MxfxlVtsOQhUwFmMa6f6XE/yUBz9Cp43C
         m+ujcH5umLXsose020gTHC8a05DPUSDoJ/dwNAAz7moL1w5aFqRruHNf+HGvqRAZnn
         vdZOAV6i4kkZiEkVy1HylXMHty5xDQ02dD2C2XYcBIZ3mSHtFro97femHFb/Ag4bYG
         zRY3+2VcS98n37b0LYFLVTQffPQ8UO8W70VisYvv57WpCCKv7ZCAMkjFuIIeTZg9+H
         1rux/f/B/TNmw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 66AC660A0C;
        Thu, 15 Jul 2021 20:00:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: remove unused variable in tc_tunnel
 prog
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162637920441.30208.1753966899172918428.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jul 2021 20:00:04 +0000
References: <20210713102719.8890-1-tklauser@distanz.ch>
In-Reply-To: <20210713102719.8890-1-tklauser@distanz.ch>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, willemb@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 13 Jul 2021 12:27:19 +0200 you wrote:
> The variable buf is unused since commit 005edd16562b ("selftests/bpf:
> convert bpf tunnel test to BPF_ADJ_ROOM_MAC"). Remove it to fix the
> following warning:
> 
>     test_tc_tunnel.c:531:7: warning: unused variable 'buf' [-Wunused-variable]
> 
> Fixes: 005edd16562b ("selftests/bpf: convert bpf tunnel test to BPF_ADJ_ROOM_MAC")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: remove unused variable in tc_tunnel prog
    https://git.kernel.org/bpf/bpf-next/c/de587d564f95

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


