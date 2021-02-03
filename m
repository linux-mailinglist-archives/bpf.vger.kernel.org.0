Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCDE30E426
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhBCUks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhBCUkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:40:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E97CA64F78;
        Wed,  3 Feb 2021 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612384807;
        bh=bz4sOyMtVkNskXyMxp6RuJLe5H1gv1Qj2cu0tS5PWvI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YBCJv+Qz5/unKHx6zvSm5kFDhV3ZOSsrDWdBwiWSVV1vJPiMZGuczR4n10ld/+KTG
         2ksRYwxmzPg1JltEH3q+434DtNxeHu+OBnc0CXOpPLjbeOITyyf/YAv8+EAB94pFIt
         r6Qc9Fkp/WL2mZ717OPb8LTrH/5bPBs9iuF56fwn3/7KLvIG4fuWbikzF2PA5PV4qJ
         5YEI/sPQP7evLEmm6hXcj3yFim8IbhmfxPQsNWtn8nXrygyF8TWsHl8wNZnljCHErK
         4QaLFA56X2aLH4ocRAe6CKCZEhYc7NeyCFeyu64pIp3ouhqdWjMFmQgf+JQCgtZUyN
         955MN2z3eMLkg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E1B99609E5;
        Wed,  3 Feb 2021 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Unbreak BPF_PROG_TYPE_KPROBE when kprobe is called
 via do_int3
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161238480692.15219.4387858440834485652.git-patchwork-notify@kernel.org>
Date:   Wed, 03 Feb 2021 20:40:06 +0000
References: <20210203070636.70926-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210203070636.70926-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, nborisov@suse.com,
        peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Tue,  2 Feb 2021 23:06:36 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> converted do_int3 handler to be "NMI-like".
> That made old if (in_nmi()) check abort execution of bpf programs
> attached to kprobe when kprobe is firing via int3
> (For example when kprobe is placed in the middle of the function).
> Remove the check to restore user visible behavior.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Unbreak BPF_PROG_TYPE_KPROBE when kprobe is called via do_int3
    https://git.kernel.org/bpf/bpf/c/548f1191d86c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


