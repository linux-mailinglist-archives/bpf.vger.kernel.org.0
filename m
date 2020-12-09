Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603512D38D4
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgLICar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 21:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgLICar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 21:30:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607481006;
        bh=2VGJAdexmfW9zjpnTV1mJzTV6x8Q3WuHQuZxaP6vZMk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o1ZtjeV+WTXt2+mvK+67HiE10HA8qhU8ZvK188H2uQLaBJzUkltvp2JSqEFebYNan
         5QTlVGtfflBgcmuFzX4b2jbZ7julcumXUuY21enS+/lbqV0o77LJbNyK2seajzdBof
         Ll6WsI4hDZQPrEto8O7m6jRettJS0mR3UztR+EFLGTVBmv56WH7j8WcTl3JHy6UtbX
         2elrGosZPlKpzZ6yfCG5Xxj79kNT2FxKEevaDIdtq1S+9WezQXD/NIiqwxQJog0T0X
         zxKL0VjUzrid3TUMe/aHo7Qyv0JtzmTFPcvF/dk2j5EM6uaZ2TyGhIfz92+hiJXS15
         YtNe7258z6l2Q==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Only provide bpf_sock_from_file with
 CONFIG_NET
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160748100661.25606.9093135909734120756.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Dec 2020 02:30:06 +0000
References: <20201208173623.1136863-1-revest@chromium.org>
In-Reply-To: <20201208173623.1136863-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, rdunlap@infradead.org,
        kafai@fb.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue,  8 Dec 2020 18:36:23 +0100 you wrote:
> This moves the bpf_sock_from_file definition into net/core/filter.c
> which only gets compiled with CONFIG_NET and also moves the helper proto
> usage next to other tracing helpers that are conditional on CONFIG_NET.
> 
> This avoids
>   ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
>   bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> When compiling a kernel with BPF and without NET.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Only provide bpf_sock_from_file with CONFIG_NET
    https://git.kernel.org/bpf/bpf-next/c/b60da4955f53

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


