Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C5E474591
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 15:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhLNOuK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 09:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhLNOuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 09:50:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D35C061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 06:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A891F61367
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 14:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C47C34601;
        Tue, 14 Dec 2021 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639493409;
        bh=uFiUahuGhv8D12j+UBrBqAePDfy8CE8xtV71b9l3vo8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bHPOlg5RlTsITP46Cka8UKYl7njvs1EL5ywZwlxeGWOG0UKOhRTcfJxPKzOcC0lmP
         tM6b5n945fnqV5No4gL8ZpkyBCE2jMYV5oXs3XVl/3nKDPbx+ybns9ZjdvVAHOwbSl
         MLfIrWCc9b5b7Y3nUFvSSbG2ANdFfhw0N2ahCEns/UxirP1k1W3SPh8hKjDtEXNwIB
         HRC6BvpMCnKHa59B+/slJGObnVhEnbAQyHnZYa5U3FTaWcEtaKY4KNjh1sUZeG5jUA
         vbKweh1xuamxQQla9IcXODvYhiUvmA/jiYgA7HfMGRh6MoRF0jQlUXuA4LdOLAVQYx
         pGkGPC5VdY/ZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E875B609F5;
        Tue, 14 Dec 2021 14:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: add sane strncpy alternative and use it
 internally
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163949340894.7160.7599467135949464597.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Dec 2021 14:50:08 +0000
References: <20211211004043.2374068-1-andrii@kernel.org>
In-Reply-To: <20211211004043.2374068-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, emmanuel.deloget@eho.link
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 10 Dec 2021 16:40:43 -0800 you wrote:
> strncpy() has a notoriously error-prone semantics which makes GCC
> complain about it a lot (and quite often completely completely falsely
> at that). Instead of pleasing GCC all the time (-Wno-stringop-truncation
> is unfortunately only supported by GCC, so it's a bit too messy to just
> enable it in Makefile), add libbpf-internal libbpf_strlcpy() helper
> which follows what FreeBSD's strlcpy() does and what most people would
> expect from strncpy(): copies up to N-1 first bytes from source string
> into destination string and ensures zero-termination afterwards.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: add sane strncpy alternative and use it internally
    https://git.kernel.org/bpf/bpf-next/c/9fc205b413b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


