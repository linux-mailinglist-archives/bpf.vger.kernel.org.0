Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D878B27D770
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgI2UAD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 16:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2UAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 16:00:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601409603;
        bh=fYOFldoxUzWAKcxWl9F5BkX4ObQ7PiB9xesULRwlhRc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MKNkbepbrFMmMwR7WmJrmliKhsz6yq04CIJVKkrhuzXORzjLhZ3Z7MywBu3ATTPBg
         hY/QweOKu1V/KNmwDFh7FOC88BsEaiO15dR1gxDma2tl1HUB/ax70+ve8ZgnHNVVGA
         EAsxkfYxcVA0DgJ5+Xw10LW9nuVWnBJZNChYdi10=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] libbpf: support loading/storing any BTF
 endianness
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160140960319.2316.3974170379855222063.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 20:00:03 +0000
References: <20200929043046.1324350-1-andriin@fb.com>
In-Reply-To: <20200929043046.1324350-1-andriin@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 21:30:43 -0700 you wrote:
> Add support for loading and storing BTF in either little- or big-endian
> integer encodings, regardless of host endianness. This allows users of libbpf
> to not care about endianness when they don't want to and transparently
> open/load BTF of any endianness. libbpf will preserve original endianness and
> will convert output raw data as necessary back to original endianness, if
> necessary. This allows tools like pahole to be ignorant to such issues during
> cross-compilation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: move and extend ASSERT_xxx() testing macros
    https://git.kernel.org/bpf/bpf-next/c/22ba36351631
  - [bpf-next,2/3] libbpf: support BTF loading and raw data output in both endianness
    https://git.kernel.org/bpf/bpf-next/c/3289959b97ca
  - [bpf-next,3/3] selftests/bpf: test BTF's handling of endianness
    https://git.kernel.org/bpf/bpf-next/c/ed9cf248b949

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


