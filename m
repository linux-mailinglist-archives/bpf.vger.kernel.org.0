Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02173E5533
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 10:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbhHJIaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 04:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234302AbhHJIa3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 04:30:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0286961058;
        Tue, 10 Aug 2021 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628584206;
        bh=s7qGZoGxwlW1Pnv8wElBXhFXuboDdAB5T3T7QBm57QQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QH31RIL3gorlHsKs9kTt5v+mGIFGE2APFY4k6+G4HeN2YjDd7qlwHX1iBJRAlNocn
         i14suKG0nGS2tUdpP7Afhpws7zyk/iMX/jQ090rrCd3i1/v6L+Lss6GMVyBbn+XPQy
         +mU0r9DljOnvTF7nidRWmMPifp+WEmK4mJps3kardScZEBnLW1gICLjjrAekMnyTk0
         NWGTafpTVALLPVxuVeDLt1eTiHf3dPYNRSwR6HyYc0Xg0Zbwtjb/S5x9dom7atj4zh
         54UnZo9wpiReLpDWRBoO72MKeYOfuPnf0FbcSF4Ute0qzqIxCCxCi8l4byBmIAwqat
         QdZRhMrnuq1TQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E9E4960A2A;
        Tue, 10 Aug 2021 08:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix potentially incorrect results with
 bpf_get_local_storage()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162858420595.6013.5030303091585103727.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Aug 2021 08:30:05 +0000
References: <20210810010413.1976277-1-yhs@fb.com>
In-Reply-To: <20210810010413.1976277-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, guro@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 9 Aug 2021 18:04:13 -0700 you wrote:
> Commit b910eaaaa4b8 ("bpf: Fix NULL pointer dereference in
> bpf_get_local_storage() helper") fixed a bug for bpf_get_local_storage()
> helper so different tasks won't mess up with each other's
> percpu local storage.
> 
> The percpu data contains 8 slots so it can hold up to 8 contexts
> (same or different tasks), for 8 different program runs,
> at the same time. This in general is sufficient. But our internal
> testing showed the following warning multiple times:
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix potentially incorrect results with bpf_get_local_storage()
    https://git.kernel.org/bpf/bpf/c/a2baf4e8bb0f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


