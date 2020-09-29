Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D393827D619
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgI2SuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 14:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2SuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 14:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601405403;
        bh=1OIj71sbFXFWX5SDCssTTC2j0glkf1aVYEwC/FmMTes=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=owUg3yY5FwNj8l2OFOOSAjm+MqvW/IK4lA45FkRFesiRknI4Bivyvd5CUrz/RJTBO
         fE/EbnjWp5lE5wqnviXiv5OnIYiS/TExFbF+jWCfpgzxaA4Vlob7M1bFVbOvTURZzP
         Y/0Lv7QERw6gOtruDqigJMx87tSTnqbMMn+XH7IQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests: Make sure all 'skel' variables are
 declared static
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160140540306.1138.5551553445909097134.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 18:50:03 +0000
References: <20200929123026.46751-1-toke@redhat.com>
In-Reply-To: <20200929123026.46751-1-toke@redhat.com>
To:     =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 14:30:26 +0200 you wrote:
> If programs in prog_tests using skeletons declare the 'skel' variable as
> global but not static, that will lead to linker errors on the final link of
> the prog_tests binary due to duplicate symbols. Fix a few instances of this.
> 
> Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel and global variables")
> Fixes: 9a856cae2217 ("bpf: selftest: Add test_btf_skc_cls_ingress")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests: Make sure all 'skel' variables are declared static
    https://git.kernel.org/bpf/bpf-next/c/f970cbcdcdb5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


