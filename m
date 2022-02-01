Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672794A6316
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 19:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiBASAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 13:00:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47222 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiBASAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 13:00:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFBB261408
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 18:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A428C340F0;
        Tue,  1 Feb 2022 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643738411;
        bh=sKU77e7D7oVRyejeyAj8qm0QpzuqFzoYKHQ80WU6lUY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JnN4UnrgZOrNzz1UtFhvnrPSdMQlpur8FqW6DdGNR9F8i8431i9AN8cQBHIdzMMsN
         1g1mM1pzTZdjb4JOeaCQAoyweRorEoBLeHPy8XiIUwlxbOEnGPWuAw8/BFlS7PhD+F
         nidyQzH2P0hRhPt/qFlcAyCehIzYRQmiWvtqyLwaDzP82YApRYklAG7vyQvngNf78f
         3E9jeBIkrRBHO/rHvVLcDNs+gLmIIUX8rEliFMDMzF8OTGYqJQjF8364QIH+4vceRa
         9oSfGLZNtv3SUjNTp6bIc7wn469HCTtNLpIk+alc2M/JwjSiggKN9/j8cXG8SXMeBP
         1bRUtwDTV25mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E69E8E5D07D;
        Tue,  1 Feb 2022 18:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/3] libbpf: deprecate xdp_cpumap,
 xdp_devmap and classifier sec definitions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164373841092.21178.15446692367658403571.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Feb 2022 18:00:10 +0000
References: <cover.1643727185.git.lorenzo@kernel.org>
In-Reply-To: <cover.1643727185.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        dsahern@kernel.org, brouer@redhat.com, toke@redhat.com,
        lorenzo.bianconi@redhat.com, andrii@kernel.org,
        john.fastabend@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  1 Feb 2022 15:58:07 +0100 you wrote:
> Deprecate xdp_cpumap, xdp_devmap and classifier sec definitions.
> Update cpumap/devmap samples and kselftests.
> 
> Changes since v2:
> - update warning log
> - split libbpf and samples/kselftests changes
> - deprecate classifier sec definition
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/3] libbpf: deprecate xdp_cpumap, xdp_devmap and classifier sec definitions
    https://git.kernel.org/bpf/bpf-next/c/4a4d4cee48e2
  - [v3,bpf-next,2/3] selftests/bpf: update cpumap/devmap sec_name
    https://git.kernel.org/bpf/bpf-next/c/439f0336566c
  - [v3,bpf-next,3/3] samples/bpf: update cpumap/devmap sec_name
    https://git.kernel.org/bpf/bpf-next/c/8bab53223340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


