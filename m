Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0A3D0388
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhGTUWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 16:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237057AbhGTUJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 16:09:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 41B7661019;
        Tue, 20 Jul 2021 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626814204;
        bh=M9uUzsQ2UTlCRLJwsxVtBim/kYlQZ60UMENNYvxDABU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QgWA9Iflu5IUm/oSQmFoVzsmmJddlK25lKPOpu0Vo1irE5EN/Z+VKGYT8STeX28Sk
         tk4jR0SJnJFUnp8GASWOT1/6AzTZvn1e/SiUl/HtixOrBYldQ/XcjKU5PHItRb4uFR
         QENB9XdrMeg/jSwRGKxFaCv3ra3mXggdOJj08GyDUt8e9sRRmdDj9xKsIxCeNxAlik
         zETQX+zKN8uSasMNBoK4DD6Py7Ph4ujVp0eQgmoysNTHiK0SEjmdcY5vvQ5Ns4SemZ
         LwwuqfNnWu2vF3mklkzl1GUClZLoQSTuTDtcOh4I6iQEZXYIiaYf8RYILNjk/tpoek
         wC1ytcmv42Axw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 353E660A5C;
        Tue, 20 Jul 2021 20:50:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests,
 bpf: test_tc_tunnel.sh nc: cannot use -p and -l
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162681420421.13265.230797140769537525.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jul 2021 20:50:04 +0000
References: <20210719223022.66681-1-vincent.mc.li@gmail.com>
In-Reply-To: <20210719223022.66681-1-vincent.mc.li@gmail.com>
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 19 Jul 2021 15:30:22 -0700 you wrote:
> When run test_tc_tunnel.sh, it complains following error
> 
> ipip
> encap 192.168.1.1 to 192.168.1.2, type ipip, mac none len 100
> test basic connectivity
> nc: cannot use -p and -l
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests, bpf: test_tc_tunnel.sh nc: cannot use -p and -l
    https://git.kernel.org/bpf/bpf-next/c/875fc315dbc3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


