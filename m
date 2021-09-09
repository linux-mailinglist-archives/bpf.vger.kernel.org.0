Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA15405F01
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 23:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhIIVlQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 17:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhIIVlQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 17:41:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0FE3261132;
        Thu,  9 Sep 2021 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631223606;
        bh=TtPJ3bJvDZINoBUOF0+zeEsYbyXFQQEJUsnpLR49FGI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W610Zmii3bI7BFSxPutr4eWCdIkxLipPZfX/nMdrA77tT0XOWFa8OYpAPctssE+bR
         knTxiwVpmnx8i2a/wDdsJu2ZjsYCu5qvAtdnT+C1obj1uRbNJPqcyVf1X+yjVaOXRd
         vPtH/q7YBFMg5fOlkcKlsaKGjd/lHawivoNGqoZOYli7WRlbO1170wP2+3x+eeixhd
         2fRZU3cVW17CmRFYtmokSF+qi/49v4NzuCfNcEhMby0mDo3Bn6BXpQeOMxfOvhkVDD
         QhZwfWokywPpjPjYhtuVnM/nYaH0ODPIAszKmZKkots/H+VeD16M4n6+a61mmZ2zP+
         imq5GiOB0cksg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EF37F60978;
        Thu,  9 Sep 2021 21:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for
 scheduling API deprecations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163122360597.812.14073978093076549835.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Sep 2021 21:40:05 +0000
References: <20210908213226.1871016-1-andrii@kernel.org>
In-Reply-To: <20210908213226.1871016-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 8 Sep 2021 14:32:26 -0700 you wrote:
> From: Quentin Monnet <quentin@isovalent.com>
> 
> Introduce a macro LIBBPF_DEPRECATED_SINCE(major, minor, message) to prepare
> the deprecation of two API functions. This macro marks functions as deprecated
> when libbpf's version reaches the values passed as an argument.
> 
> As part of this change libbpf_version.h header is added with recorded major
> (LIBBPF_MAJOR_VERSION) and minor (LIBBPF_MINOR_VERSION) libbpf version macros.
> They are now part of libbpf public API and can be relied upon by user code.
> libbpf_version.h is installed system-wide along other libbpf public headers.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for scheduling API deprecations
    https://git.kernel.org/bpf/bpf-next/c/0b46b7550560

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


