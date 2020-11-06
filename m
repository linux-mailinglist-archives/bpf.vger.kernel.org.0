Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F792A9EFB
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 22:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgKFVVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 16:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFVVj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 16:21:39 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697698;
        bh=eYgXIrgiM7g1O99LNX0IImdvQnHUw3o5UfTypxA/6QM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=srr1r/gxE4+BjbyC0ad8VZ94DMlyqxxHX1J/yvrFH2WW7bHIDK/9uIKu203Ga4ZgX
         goeNgaf1zyywMlFxR9XUWRZCCZQEgLOI152SFToh/p8qxNa0KsP05DfLmx2ihX006F
         v/uWxYepLdfBGA4YfZYH7I89IR5Xq51CD1kj5EJw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Update verification logic for LSM programs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160469769850.21746.734806332257716938.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Nov 2020 21:21:38 +0000
References: <20201105230651.2621917-1-kpsingh@chromium.org>
In-Reply-To: <20201105230651.2621917-1-kpsingh@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu,  5 Nov 2020 23:06:51 +0000 you wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The current logic checks if the name of the BTF type passed in
> attach_btf_id starts with "bpf_lsm_", this is not sufficient as it also
> allows attachment to non-LSM hooks like the very function that performs
> this check, i.e. bpf_lsm_verify_prog.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Update verification logic for LSM programs
    https://git.kernel.org/bpf/bpf/c/6f64e4778300

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


