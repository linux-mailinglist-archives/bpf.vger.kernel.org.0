Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3132027DD3F
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 02:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgI3AKD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 20:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI3AKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 20:10:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601424602;
        bh=pJrHXYBW1b53KUxhiwNMDjVEH0eeD/wVll629WgA/Io=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MIRshXfyTRozwArUep2ZgyeX0xIUcHA1ULGAG7P/A+xh+onzVK1gZ2Hl4ze/j6eqx
         I6Tr/lTpuPD+3V4DsMr7NQW8TAVyCTYH1x65awX8JL3PT8d+vW9E/g3ghP6lqPBxHV
         Tkx89cXI1B32SmMTtGlAj/KCvxErznRF5igJJWzE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/3] libbpf: fix uninitialized variable in
 btf_parse_type_sec
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160142460276.27126.353578483703494160.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Sep 2020 00:10:02 +0000
References: <20200929220604.833631-1-andriin@fb.com>
In-Reply-To: <20200929220604.833631-1-andriin@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 15:06:02 -0700 you wrote:
> Fix obvious unitialized variable use that wasn't reported by compiler. libbpf
> Makefile changes to catch such errors are added separately.
> 
> Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,1/3] libbpf: fix uninitialized variable in btf_parse_type_sec
    https://git.kernel.org/bpf/bpf-next/c/33433913459a
  - [bpf-next,2/3] libbpf: compile libbpf under -O2 level by default and catch extra warnings
    https://git.kernel.org/bpf/bpf-next/c/0a62291d697f
  - [bpf-next,3/3] libbpf: compile in PIC mode only for shared library case
    https://git.kernel.org/bpf/bpf-next/c/b0efc216f577

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


