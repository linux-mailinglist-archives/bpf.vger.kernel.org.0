Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6144B477DC0
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 21:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhLPUnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 15:43:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43488 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhLPUnX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 15:43:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB6EEB82631
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 20:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3CF1C36AE7;
        Thu, 16 Dec 2021 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639687401;
        bh=Ffn1uskKTLZIXsm76v2OZ4EiQXQofeT7LZXWC6FLx0g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LOr6DS2wLMy3gOvPD/FI6i4N9xRAMHTGSelZCjiGzbCqADkz4HdyGCpufTtNWteMM
         1k+rLWUm8DBBFvjlJPyl9+uVl9ocjuuQqDG4KDWB69uR294/hMb6g3NKnSHb1wCDgj
         YNP1F48978FQB4EBr8Sx2miWprfrojZX70groTAA05qxiMizbClO/3vIW1Bq/ngHzF
         x132MmX1LdnVOezagGqzKdcHzGNWXIlacH9Kq+QPiNbzZgoscHv7PoV0+meWRAQZbU
         5z9K8AAuJnwtFi/HldRuTJ/q19JukyIekGwieCWcjBgSf/ZVDZjiPbGAqP5Mc65q3/
         almyGj5NMmIXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8417960A3C;
        Thu, 16 Dec 2021 20:43:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: selftests: Fix racing issue in btf_skc_cls_ingress
 test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163968740153.12846.4113118887819711158.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Dec 2021 20:43:21 +0000
References: <20211216191630.466151-1-kafai@fb.com>
In-Reply-To: <20211216191630.466151-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 16 Dec 2021 11:16:30 -0800 you wrote:
> The libbpf CI reported occasional failure in btf_skc_cls_ingress:
> 
> test_syncookie:FAIL:Unexpected syncookie states gen_cookie:80326634 recv_cookie:0
> bpf prog error at line 97
> 
> "error at line 97" means the bpf prog cannot find the listening socket
> when the final ack is received.  It then skipped processing
> the syncookie in the final ack which then led to "recv_cookie:0".
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: selftests: Fix racing issue in btf_skc_cls_ingress test
    https://git.kernel.org/bpf/bpf/c/c2fcbf81c332

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


