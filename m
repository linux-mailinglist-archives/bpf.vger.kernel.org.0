Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5C436DD1
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUXC3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUXC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 19:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 37ABE6128E;
        Thu, 21 Oct 2021 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634857208;
        bh=a8heU3rIMz9hNCOA3Dry75E1KQH2YsmIrkkeu32AiwI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q2Zr5QKc1PtkjW7THLK9FMlGp24O1xzIVa0mRcrTRm15ojCmOLXuyqjsmbz6en6rR
         nDkVnQDwa/mq8Ccup4i+AONLPKl3qJN6pIWMrtxlWZ0rFpxqnr31UtkEDvUP4nA1yZ
         iiPUFnxPT0pGJ0IwHe2OiqLIq8P4upqndGHTAULNUC4xRz9qj1a4qniBpxDe1h3pdx
         2Mk46YlyIaA3MHaqQNDAAoxVPPTjz3lC+P+mWh29fOk+19oupKIH8n6gQPWF+w+8P8
         I+IqJozDpnXNlvnmldRCu8AjrhUKf8mqN8kyOyw+wlqHftB9SBBR6qZd2e60IBVIf4
         VtIq5hqkI6e7w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1EB4460A47;
        Thu, 21 Oct 2021 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/1] btf_dump fixes for s390
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163485720812.7837.765648053386811756.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Oct 2021 23:00:08 +0000
References: <20211021104658.624944-1-iii@linux.ibm.com>
In-Reply-To: <20211021104658.624944-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 21 Oct 2021 12:46:57 +0200 you wrote:
> v2: https://lore.kernel.org/bpf/20211013160902.428340-1-iii@linux.ibm.com/
> v2 -> v3:
> - Drop committed patches.
> - Handle potential division by zero when using btf__align_of(). Use
>   btf__align_of() in btf_dump_ptr_data() instead of the direct ptr_sz
>   access: although it's slightly slower, the result is the same and the
>   resulting code is more uniform.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/1] libbpf: Fix ptr_is_aligned() usages
    https://git.kernel.org/bpf/bpf-next/c/632f96d2652e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


