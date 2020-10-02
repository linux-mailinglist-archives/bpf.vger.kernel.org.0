Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166352815C3
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbgJBOuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 10:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388230AbgJBOuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 10:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601650202;
        bh=pI0GIpl3stPcnW4N30d+y03PeNbhge3uW4RpN1+/s4c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iRHXpIC9OMZ8xpbREpIrVAdm0R8OMS52ebBuynjmZKthsh15AZOLbV/cp8oNvaGDA
         ymFrK6DwEuW3kqPtfEwHWeQPpV3RqyRQcmUm2q0i4MWVOQbI7XHR+gCYY4jk3y38/C
         dnwJQK8jT+FuQRGv1f3Jl/mcLFUBk7gSfqgKRAII=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: properly initialize linfo in
 sockmap_basic
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160165020267.24758.16856928754495909228.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Oct 2020 14:50:02 +0000
References: <20201002000451.1794044-1-sdf@google.com>
In-Reply-To: <20201002000451.1794044-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  1 Oct 2020 17:04:51 -0700 you wrote:
> When using -Werror=missing-braces, compiler complains about missing braces.
> Let's use use ={} initialization which should do the job:
> 
> tools/testing/selftests/bpf/prog_tests/sockmap_basic.c: In function 'test_sockmap_iter':
> tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:181:8: error: missing braces around initializer [-Werror=missing-braces]
>   union bpf_iter_link_info linfo = {0};
>         ^
> tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:181:8: error: (near initialization for 'linfo.map') [-Werror=missing-braces]
> tools/testing/selftests/bpf/prog_tests/sockmap_basic.c: At top level:
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: properly initialize linfo in sockmap_basic
    https://git.kernel.org/bpf/bpf-next/c/48ca6243c6ad

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


