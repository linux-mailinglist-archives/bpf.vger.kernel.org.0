Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257F93DAEC3
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 00:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhG2WUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 18:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhG2WUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 18:20:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 59DD460F48;
        Thu, 29 Jul 2021 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627597205;
        bh=nG+l9OEET1pV2TdpvbpOG8zcqbcFehtOTynkOojxwb4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nZo+O8Bc8y24speSCGbPvzpa43ZrM/3G/a77GQKlrQoPaGig66zBmhYu/cipdVo0D
         O0YudYElxje8evBrWr5tDdri04vPzLnpaYEJv2bCebFrMi9e0jcZtwNJKtRuEA4FqP
         +2HCDzfz/gIOa+SGHQQOZ0/HTySS2l/SZuGsUFqoTxS3qZaHjEtSUZzzzPii3SqlRT
         FCRQfmc467qAUdkaPCJnHiMqFWY+iLU7W0tywQvXghFxEBcJHHaflmpdOvxZGfu11r
         qrpl6B5qjGIC/uXGoYyH3+wB9OepjPaBwAbW3JjYj5Jek0fthFLPOSuh9TeSQ//khM
         K6oKsCKCwyAmw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4C37360A59;
        Thu, 29 Jul 2021 22:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: emit better log message if bpf_iter ctx arg
 btf_id == 0
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162759720530.8376.15393042457580535660.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jul 2021 22:20:05 +0000
References: <20210728183025.1461750-1-yhs@fb.com>
In-Reply-To: <20210728183025.1461750-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 28 Jul 2021 11:30:25 -0700 you wrote:
> To avoid kernel build failure due to some missing .BTF-ids referenced
> functions/types, the patch ([1]) tries to fill btf_id 0 for
> these types.
> 
> In bpf verifier, for percpu variable and helper returning btf_id cases,
> verifier already emitted proper warning with something like
>   verbose(env, "Helper has invalid btf_id in R%d\n", regno);
>   verbose(env, "invalid return type %d of func %s#%d\n",
>           fn->ret_type, func_id_name(func_id), func_id);
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: emit better log message if bpf_iter ctx arg btf_id == 0
    https://git.kernel.org/bpf/bpf-next/c/d36216429ff3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


