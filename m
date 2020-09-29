Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4927D820
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgI2UaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 16:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbgI2UaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601411404;
        bh=3P8xu0CHk2Iil4N5ZNoYcavu8mfRsPbR7l0s2ZOPNSo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=wWjO7MAFjjvcC9FcXlYOg/ippPn+nf5XbyCpSDuKxTn6Alov/pe3QcS4DHtTdcCio
         aP6N+qSH42yIWuS1lytNPBqW/CbL7w/KUY1xyzSZQTRIIvBQcGBNR19QgqBw+q68vl
         1ENB+eJIdKNclowYf1Mjd8rlQCEMWsn/dKWHi0Tw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 0/7] bpf: Support multi-attach for freplace
 programs
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160141140475.17638.6390134024039116341.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 20:30:04 +0000
References: <160138354947.48470.11523413403103182788.stgit@toke.dk>
In-Reply-To: <160138354947.48470.11523413403103182788.stgit@toke.dk>
To:     =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 14:45:49 +0200 you wrote:
> This series adds support attaching freplace BPF programs to multiple targets.
> This is needed to support incremental attachment of multiple XDP programs using
> the libxdp dispatcher model.
> 
> Patch 1 moves prog_aux->linked_prog and the trampoline to be embedded in
> bpf_tracing_link on attach, and freed by the link release logic, and introduces
> a mutex to protect the writing of the pointers in prog->aux.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/7] bpf: move prog->aux->linked_prog and trampoline into bpf_link on attach
    https://git.kernel.org/bpf/bpf-next/c/3aac1ead5eb6
  - [bpf-next,v10,2/7] bpf: support attaching freplace programs to multiple attach points
    https://git.kernel.org/bpf/bpf-next/c/4a1e7c0c63e0
  - [bpf-next,v10,3/7] bpf: Fix context type resolving for extension programs
    https://git.kernel.org/bpf/bpf-next/c/43bc2874e779
  - [bpf-next,v10,4/7] libbpf: add support for freplace attachment in bpf_link_create
    https://git.kernel.org/bpf/bpf-next/c/a535909142bf
  - [bpf-next,v10,5/7] selftests: add test for multiple attachments of freplace program
    https://git.kernel.org/bpf/bpf-next/c/f6429476c201
  - [bpf-next,v10,6/7] selftests/bpf: Adding test for arg dereference in extension trace
    https://git.kernel.org/bpf/bpf-next/c/17d3f3867576
  - [bpf-next,v10,7/7] selftests: Add selftest for disallowing modify_return attachment to freplace
    https://git.kernel.org/bpf/bpf-next/c/bee4b7e6268b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


