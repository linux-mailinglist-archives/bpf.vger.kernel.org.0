Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81DE27D5C9
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgI2SaD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 14:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2SaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 14:30:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601404202;
        bh=zH9MrFY2h7oPmhsbKlTafGpw28e1E3Fet4pfAw4q8b8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XQuy60XHuZ8zDtv2TDKYE6mIfFv9LjBAvxFSWHCN0aa3bjix925lJ2tQiqqiO0pwI
         lf82zRFeCJVkJ51ciXvwNofvbAEzFa9GqOSFnfCr8yUZ50fncxp8ov3gd4KonUeo0D
         UmlRK9BNkBWRz5+Ff6ElnaYqbf3IdBJuXdAquX3E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: fix a documentation mistake in xsk_queue.h
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160140420260.22687.15249708539681867546.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 18:30:02 +0000
References: <20200928082344.17110-1-ciara.loftus@intel.com>
In-Reply-To: <20200928082344.17110-1-ciara.loftus@intel.com>
To:     Ciara Loftus <ciara.loftus@intel.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 08:23:44 +0000 you wrote:
> After 'peeking' the ring, the consumer, not the producer, reads the data.
> Fix this mistake in the comments.
> 
> Fixes: 15d8c9162ced ("xsk: Add function naming comments and reorder functions")
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  net/xdp/xsk_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - xsk: fix a documentation mistake in xsk_queue.h
    https://git.kernel.org/bpf/bpf-next/c/f1fc8ece6c07

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


