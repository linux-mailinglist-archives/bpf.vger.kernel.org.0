Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5369A474E72
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 00:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbhLNXKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 18:10:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60378 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbhLNXKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 18:10:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B2486171F
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 23:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4113C34600;
        Tue, 14 Dec 2021 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639523410;
        bh=2tNshVfu3hsmn41uYSg5HUxR8qVF7udDJFc5cfD/Qnc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MxF2jhnQOJvMX73GUE0duFg6ZOa381kgoprQBVdaUoMh2mBQrv4fghP8QzK5bCC0y
         UIeRfJr5uhxDcfOBNwnPtHqa8b5qUzcvRhLprxwIlZtRXqBhJDlV0ykmkSpUs8bJq+
         ko5e1TpBN6a/2RJ7enwh/SCRsY1UMBL389e6z1GgS/+6kEMo2HrivLUE5PcZUSzBZD
         Gdf/ZKZn4PSdzDdynwFmt3LekPoshelz0YKzeB4bTEgYtyj1MtfK9tpiFuHtD08FfF
         a9cU4TbusYWedPPGmwtWKEUmlURovuTjGh4c+Fkepk0n0E3Umbkk0m7y07G8po9DH5
         sGLp5z7ydYJaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9766B609BA;
        Tue, 14 Dec 2021 23:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/4] Stop using bpf_object__find_program_by_title
 API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163952341061.23710.11952187546156032545.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Dec 2021 23:10:10 +0000
References: <20211214035931.1148209-1-kuifeng@fb.com>
In-Reply-To: <20211214035931.1148209-1-kuifeng@fb.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 13 Dec 2021 19:59:27 -0800 you wrote:
> bpf_object__find_program_by_title is going to be deprecated since
> v0.7.  Replace all use cases with bpf_object__find_program_by_name if
> possible, or use bpf_object__for_each_program to iterate over
> programs, matching section names.
> 
> V3 fixes a broken test case, fexit_bpf2bpf, in selftests/bpf, using
> bpf_obj__for_each_program API instead.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/4] selftests/bpf: Stop using bpf_object__find_program_by_title API.
    https://git.kernel.org/bpf/bpf-next/c/a393ea80a22a
  - [v4,bpf-next,2/4] samples/bpf: Stop using bpf_object__find_program_by_title API.
    https://git.kernel.org/bpf/bpf-next/c/7490d5926816
  - [v4,bpf-next,3/4] tools/perf: Stop using bpf_object__find_program_by_title API.
    https://git.kernel.org/bpf/bpf-next/c/b098f33692d7
  - [v4,bpf-next,4/4] libbpf: Mark bpf_object__find_program_by_title API deprecated.
    https://git.kernel.org/bpf/bpf-next/c/0da2596f343c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


