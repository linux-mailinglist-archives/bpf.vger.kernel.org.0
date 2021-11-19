Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589DA45726E
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 17:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhKSQNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 11:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236254AbhKSQNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 11:13:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 35A7061B1E;
        Fri, 19 Nov 2021 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637338209;
        bh=wuOUrKo/0di+/m4e+5yxpdWb3cb116QGLa57zTJMCXg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SJ32QyKco+0oIkCdbCYg8TcuKIzLS+NChNclry7VWgxAdVznqZ0AJYKHY2r1INDgs
         UOarfKi/iSAvpYz+FqvXDnJb9sl7/0ArtRwMPBawkM8U7HMdDiyttQ0hTkv+tSjkmm
         G+/g8w+AraQ5sItm9Ykz7pFA05sVxCf1PYAP2+UJTA4tO7k5IA33Mr8KB/ze2XPs59
         g+StU4nVg+9LNeP26djBsiB7MbYFAATg7DJLCtGz+m/EmXB100/KiYN9oNt3uJ90nn
         5omBuNKbt4eYEMRpGvDP35X6cRSMX3Z0HGfvuUK675e/W5dnrupbnc4X8QZJM1vmpO
         UdcJTkKSX4mZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 22CFB60979;
        Fri, 19 Nov 2021 16:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163733820913.382.2673548319147264667.git-patchwork-notify@kernel.org>
Date:   Fri, 19 Nov 2021 16:10:09 +0000
References: <20211117194114.347675-1-andrii@kernel.org>
In-Reply-To: <20211117194114.347675-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, jolsa@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 17 Nov 2021 11:41:13 -0800 you wrote:
> According to [0], compilers sometimes might produce duplicate DWARF
> definitions for exactly the same struct/union within the same
> compilation unit (CU). We've had similar issues with identical arrays
> and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> same for struct/union by ensuring that two structs/unions are exactly
> the same, down to the integer values of field referenced type IDs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: accommodate DWARF/compiler bug with duplicated structs
    https://git.kernel.org/bpf/bpf-next/c/efdd3eb8015e
  - [bpf-next,2/2] selftests/bpf: add btf_dedup case with duplicated structs within CU
    https://git.kernel.org/bpf/bpf-next/c/9a49afe6f5a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


