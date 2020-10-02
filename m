Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E5F281B24
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgJBSuD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 14:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbgJBSuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 14:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601664602;
        bh=omv6p2WfPJ1g4z0aJKds7xPt2hDx2R8a4p8nl91AGk8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LIp4wxwQlAd654B32RSLu7Oxlg0dB/0UKe8Mbmud0ZqOo5wheqB8yoVdy4M3HKLw6
         URMb1L9u/v7CWscuyt6IQg3/snby81IfNaiW43CLlr2Ve7Ov4XxWlPucuHgfuNM7fj
         krvdCny/nOxTWi+9xHT+jDzX3gUYiPimLX3qFs48=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Do not limit cb_flags when creating child sk
 from listen sk
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160166460282.17511.15563010625020001748.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Oct 2020 18:50:02 +0000
References: <20201002013442.2541568-1-kafai@fb.com>
In-Reply-To: <20201002013442.2541568-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 1 Oct 2020 18:34:42 -0700 you wrote:
> This set fixes an issue that the bpf_skops_init_child() unnecessarily
> limited the child sk from inheriting all bpf_sock_ops_cb_flags
> of the listen sk.  It also adds a test to check that.
> 
> Martin KaFai Lau (2):
>   bpf: tcp: Do not limit cb_flags when creating child sk from listen sk
>   bpf: selftest: Ensure the child sk inherited all bpf_sock_ops_cb_flags
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: tcp: Do not limit cb_flags when creating child sk from listen sk
    https://git.kernel.org/bpf/bpf-next/c/82f45c6c4a70
  - [bpf-next,2/2] bpf: selftest: Ensure the child sk inherited all bpf_sock_ops_cb_flags
    https://git.kernel.org/bpf/bpf-next/c/96d46c508506

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


