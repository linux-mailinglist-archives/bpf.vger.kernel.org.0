Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668A632B322
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhCCDp6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383201AbhCBKvV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 05:51:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BE36264F07;
        Tue,  2 Mar 2021 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614682206;
        bh=IlJOZdR4Q7DoOfmy8THM07k5CUa+bGFGWeCKZPWA0MI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kgQz12sINnn8J6JcWG27ORgxmNtbLV51dvKSlFBXNC58CiH8RRIBbiNDVHTZ+Pbx2
         x4tlc20jPo7sdR3cpb2YKgnpEJKC18z658/aVW+jybtDoX5Ws2iYCZrAOLFQZWB7YA
         WdstzemMAIlyJV+W+lcRe/tiAjCMowcNVsOrx+S4muT3Ho9ILJatxb8XCnyb92Cm3k
         Bk3nQzswT3zkE3LwMmgHU6OQXc55YIjZ9NCYBiczfCE6eqxAN0Mrua1tS4UDVP4OdN
         rapAwKUbVyViDzuReQmB+bVf+1/gD6dWL3D7VAiIOSXw2nNPNRYJQ38fUQJDnBopWW
         2gwE6eshFU1xw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B070F60192;
        Tue,  2 Mar 2021 10:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: selftests: test_verifier: mask bpf_csum_diff() return
 value to 16 bits
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161468220671.25431.2892545906043923234.git-patchwork-notify@kernel.org>
Date:   Tue, 02 Mar 2021 10:50:06 +0000
References: <20210228103017.320240-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210228103017.320240-1-yauheni.kaliuta@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, toke@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Sun, 28 Feb 2021 12:30:17 +0200 you wrote:
> The verifier test labelled "valid read map access into a read-only array
> 2" calls the bpf_csum_diff() helper and checks its return value.
> However, architecture implementations of csum_partial() (which is what
> the helper uses) differ in whether they fold the return value to 16 bit
> or not. For example, x86 version has:
> 
> 	if (unlikely(odd)) {
> 		result = from32to16(result);
> 		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> 	}
> 
> [...]

Here is the summary with links:
  - bpf: selftests: test_verifier: mask bpf_csum_diff() return value to 16 bits
    https://git.kernel.org/bpf/bpf/c/cf14da96aa18

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


