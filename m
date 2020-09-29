Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57A627CA96
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbgI2MUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 08:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732466AbgI2MUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 08:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382008;
        bh=ANsfuM/+BwWGVElXRbF96h6FPeH00yJfEEGLmK7eMa8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E8MPHVezDvcUFwlFuayIgOB6n2JX4UQpuxBS1nuc+6tsKcRHobbKBtJQNOMuxRypQ
         MtN5CkTFuNDVUK/ymFD06OudD/dspHcgUh2YPHEvJ5ABb45Vu3xSsXAZy8b4nyyUOS
         9jy5tLTjfy6Rus7jqliUaX+G8I+cvO/hl4dTVe0Y=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/3] libbpf: BTF writer APIs
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160138200845.26741.8137394671987492282.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 12:20:08 +0000
References: <20200929020533.711288-1-andriin@fb.com>
In-Reply-To: <20200929020533.711288-1-andriin@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 19:05:29 -0700 you wrote:
> This patch set introduces a new set of BTF APIs to libbpf that allow to
> conveniently produce BTF types and strings. These APIs will allow libbpf to do
> more intrusive modifications of program's BTF (by rewriting it, at least as of
> right now), which is necessary for the upcoming libbpf static linking. But
> they are complete and generic, so can be adopted by anyone who has a need to
> produce BTF type information.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/3] libbpf: add BTF writing APIs
    https://git.kernel.org/bpf/bpf-next/c/4a3b33f8579a
  - [v3,bpf-next,2/3] libbpf: add btf__str_by_offset() as a more generic variant of name_by_offset
    https://git.kernel.org/bpf/bpf-next/c/f86ed050bcee
  - [v3,bpf-next,3/3] selftests/bpf: test BTF writing APIs
    https://git.kernel.org/bpf/bpf-next/c/9141f75a3279

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


