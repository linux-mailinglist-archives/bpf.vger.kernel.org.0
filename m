Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1481391E61
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 19:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEZRvl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 13:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhEZRvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 13:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7974A613D2;
        Wed, 26 May 2021 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622051409;
        bh=Y0LUjjNjscY5V6/0UWjL4cGelu1LSlenFBnmtBAnSEo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bSNUmo+T/8UisO92jWDhmAjw6tygop4/GQMRFHskjD/HA7845mhdV8Fr+zP1Ir4IS
         IizHPQ2rszqCkHKDwZUFNu8nNqLhUTEcXiGl1a9tlWZaO2mMpcqwxvM4x/UfQPdV0v
         IUTDHfE0i95+araH6Fuh9GYlh7gY9CfoX7fTD07BCEkKehl/Vt5MMvDv06Ya8CjFIZ
         jW3Pehb3Pt+2pLg+/PJGhdkfiLoZ7OkWh/8TN7mZDfDCgVSY6yrMjCAOi1Fd5hkAdh
         /dHdo52tq/O1dpbOfXvY3OeTh4nhFzhCT08Y2eC+tQtrcLJzLnG9uWzg4BO0P2Vqnj
         CXv0ji9DtwzFw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6E20B60A4F;
        Wed, 26 May 2021 17:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to
 bpf_helpers.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162205140944.32004.2498338287581777007.git-patchwork-notify@kernel.org>
Date:   Wed, 26 May 2021 17:50:09 +0000
References: <20210526164643.2881368-1-revest@chromium.org>
In-Reply-To: <20210526164643.2881368-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 26 May 2021 18:46:43 +0200 you wrote:
> These macros are convenient wrappers around the bpf_seq_printf and
> bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> targets low level tracing primitives. bpf_helpers.h is a better fit.
> 
> The __bpf_narg and __bpf_apply are needed in both files and provided
> twice. __bpf_empty isn't used anywhere and is removed from bpf_tracing.h
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/d6a6a55518c1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


