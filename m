Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78E281E5E
	for <lists+bpf@lfdr.de>; Sat,  3 Oct 2020 00:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBWaE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 18:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 18:30:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601677803;
        bh=NhXDSu17HUgau68592gDgn3Pg4c6kyKbwvZiBeJTZLc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JKDJDcj3B0IBZK+hc1QvA/YdMDE8mU/JfrZbBzxm0nVxq9VXFf689kbffPhVVmdYa
         5AQrih7EwDRCgvd61BhiC6PG62IqRKHA2HRpSRLtpoFnFuBBzZM/PPClF1Mh/xO8ub
         +BRiELDNcX2sOgdGsQnzyIChI3+iFrFaBIBXnV/E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next PATCH v2 0/2] Add skb_adjust_room() for SK_SKB
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160167780367.26044.61096032487233912.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Oct 2020 22:30:03 +0000
References: <160160094764.7052.2711632803258461907.stgit@john-Precision-5820-Tower>
In-Reply-To: <160160094764.7052.2711632803258461907.stgit@john-Precision-5820-Tower>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 01 Oct 2020 18:09:34 -0700 you wrote:
> This implements the helper skb_adjust_room() for BPF_SKS_SK_STREAM_VERDICT
> programs so we can push/pop headers from the data on recieve. One use
> case is to pop TLS headers off kTLS packets.
> 
> The first patch implements the helper and the second updates test_sockmap
> to use it removing some case handling we had to do earlier to account for
> the TLS headers in the kTLS tests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf, sockmap: add skb_adjust_room to pop bytes off ingress payload
    https://git.kernel.org/bpf/bpf-next/c/18ebe16d1049
  - [bpf-next,v2,2/2] bpf, sockmap: update selftests to use skb_adjust_room
    https://git.kernel.org/bpf/bpf-next/c/91274ca53518

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


