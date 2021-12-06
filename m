Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D06046AA75
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349328AbhLFVdl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 16:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349317AbhLFVdk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 16:33:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C159C061746;
        Mon,  6 Dec 2021 13:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 554D2B81084;
        Mon,  6 Dec 2021 21:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 268B8C341C6;
        Mon,  6 Dec 2021 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638826209;
        bh=l6EqB4tWLXHsVu/KgPT2x9K4jyLEy+OU6QSlkB+uiH8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QgPNwb3LcZf7VEkbq3sA6caSw3xqbd0SzJeozFLSI6BzlevXbWetl349oSMQzNVkI
         oiV/LaX6zN51lKird83hM15OX3DxVtg8UChkXt/0p/ICS9ELdFb0SBUmXpEzVEZlB5
         5BgFv8H9G1tuWPQorB5eJ4XF10HZcpq6Bm3EkuKezQuCgH0JfDk+2PT6HnlhLtl9QS
         MowwTKBWwdC7+P8yvSASMGNaBue/kN9AA+VwFyAyPmQC5TjmNLzflaBZiGVzNx7Fhk
         eWqr0utobJMrEbdSNYs4z5eBwCoyn3j7cdHwA6xeG5Hh+4Y34JRF0a/dYZTjqNifxx
         EHRPgX90xvarw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0A2C260A53;
        Mon,  6 Dec 2021 21:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix trivial typo
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163882620903.30029.10274059333775684418.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Dec 2021 21:30:09 +0000
References: <1638755236-3851199-1-git-send-email-hxseverything@gmail.com>
In-Reply-To: <1638755236-3851199-1-git-send-email-hxseverything@gmail.com>
To:     huangxuesen <hxseverything@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, huangxuesen@kuaishou.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  6 Dec 2021 09:47:16 +0800 you wrote:
> From: huangxuesen <huangxuesen@kuaishou.com>
> 
> Fix typo in comment from 'bpf_skeleton_map' to 'bpf_map_skeleton'
> and from 'bpf_skeleton_prog' to 'bpf_prog_skeleton'.
> 
> Signed-off-by: huangxuesen <huangxuesen@kuaishou.com>
> 
> [...]

Here is the summary with links:
  - libbpf: Fix trivial typo
    https://git.kernel.org/bpf/bpf-next/c/222c98c79790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


