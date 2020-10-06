Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0872851E4
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgJFSuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 14:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgJFSuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 14:50:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602010204;
        bh=cLIuGeEAzcI9WmAEPb26o7c5PzKQXL+9/K5uxlTrUC0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=yPjioAbQStx/Q43o/0V8l/cAQ2cRHWF6Kdj6vrEcvpTbmL+xTQXEjZRDi+kpwE426
         WYvKzd65nmGwfWF5eIVB4wKyn5sYQhVAu9CumFjMzQEVVoqGBjRVnQ22jxwyTTfSzK
         fPMaW2OLPAXYUGH213LNH5ZhlYO/s+L90UbjztYQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpf,
 libbpf: use valid btf in bpf_program__set_attach_target
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160201020458.15578.2112471126147703627.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Oct 2020 18:50:04 +0000
References: <20201005224528.389097-1-lrizzo@google.com>
In-Reply-To: <20201005224528.389097-1-lrizzo@google.com>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     bpf@vger.kernel.org, echaudro@redhat.com, daniel@iogearbox.net,
        rizzo.unipi@gmail.com, andriin@fb.com, ppenkov@google.com,
        tommaso.burlon@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  5 Oct 2020 15:45:28 -0700 you wrote:
> bpf_program__set_attach_target(prog, fd, ...) will always fail when
> fd = 0 (attach to a kernel symbol) because obj->btf_vmlinux is NULL
> and there is no way to set it (at the moment btf_vmlinux is meant
> to be temporary storage for use in bpf_object__load_xattr()).
> 
> Fix this by using libbpf_find_vmlinux_btf_id().
> 
> [...]

Here is the summary with links:
  - [v3] bpf, libbpf: use valid btf in bpf_program__set_attach_target
    https://git.kernel.org/bpf/bpf-next/c/8cee9107e72c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


