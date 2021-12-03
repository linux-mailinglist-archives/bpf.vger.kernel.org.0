Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E8467DCF
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353243AbhLCTNg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbhLCTNf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:13:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D261C061751;
        Fri,  3 Dec 2021 11:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A2ED62C68;
        Fri,  3 Dec 2021 19:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C5B0C53FD0;
        Fri,  3 Dec 2021 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638558609;
        bh=60mi6p08U2wbwvB97Xgf4RVXwcC9c+P0q4JsuFDiPOI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uQZ/0KBBwOlmv3heoNYQUyaiMcNeBzGSS7RGwLrUa1wvnnZZQ6T1aiotEpZc9+H1z
         suTSmGKxpgS0c6XVGVxaalBJmrlSSeOStYBqFjdMzEM6uEaV7mDiaiERaCljh6lClu
         y4ZeXl8bU86S0Tlh1qM71hMLRLoJ42fEBPac2QnYi8LwMmxeQwBlOG69sUpBZ0dwu6
         xIWcpHtOouVmuoukYE96Ve65pWnv8OAvBZnBZ7lis61qy71Izg3SQMHOwLTAYKOLk2
         iFIkS8YvN30sqDOF+sQImtsnqnMxvHc1VQ8rHRM/6ZRUBTOBloBH7A1DsAO4wP+3JL
         fMwQadF7d2iGQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 76F2C60A95;
        Fri,  3 Dec 2021 19:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] treewide: add missing includes masked by cgroup -> bpf
 dependency
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163855860948.24022.9001786774413649159.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Dec 2021 19:10:09 +0000
References: <20211202203400.1208663-1-kuba@kernel.org>
In-Reply-To: <20211202203400.1208663-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, kw@linux.com, peter.chen@kernel.org,
        sj@kernel.org, jani.nikula@intel.com, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@canonical.com, mani@kernel.org,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        gregkh@linuxfoundation.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        akpm@linux-foundation.org, thomas.hellstrom@linux.intel.com,
        matthew.auld@intel.com, colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Dec 2021 12:34:00 -0800 you wrote:
> cgroup.h (therefore swap.h, therefore half of the universe)
> includes bpf.h which in turn includes module.h and slab.h.
> Since we're about to get rid of that dependency we need
> to clean things up.
> 
> v2: drop the cpu.h include from cacheinfo.h, it's not necessary
> and it makes riscv sensitive to ordering of include files.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] treewide: add missing includes masked by cgroup -> bpf dependency
    https://git.kernel.org/bpf/bpf/c/8581fd402a0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


