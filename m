Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD840BD7C
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 04:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhIOCB1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 22:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232749AbhIOCB0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 22:01:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD51C61247;
        Wed, 15 Sep 2021 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631671208;
        bh=yJDo5QHPK3Gh422st+6KYvGv86eSZJOMPep4D6tt/yU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n18BW/oSRBYGYGLueRLkET4e6M5JWg9w6tiQVwzifQoMPdRW3DatmP9EQgp5fozIr
         qq22waIQ6Xc2ukdmTfL9UFw7q25lgXKjOBrsxu1PdLiEU5cUfDM+yZMCbcPff+XKGJ
         STEKTAFp0OdgYc0r027VNWToOovMStWVpfe6JJWiARtxe2hGPq8bVLr0h5a3LkEDqH
         obxfurblKhqNEeLFkaZfz/8C4MUEQV8BP4t7MqMMV21P1e1E8KGoudUjnYJl/IZ8Q/
         frsK8rokEHJzmQwRknX5Ll4Z9a324UjpTILi7qu4gHxjncLWDgP4qq89tcubeHExjC
         79d29Et+bQGDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9AB9960970;
        Wed, 15 Sep 2021 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163167120862.9701.11912673154780736226.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Sep 2021 02:00:08 +0000
References: <20210914223004.244411-1-yhs@fb.com>
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 14 Sep 2021 15:30:04 -0700 you wrote:
> LLVM14 added support for a new C attribute ([1])
>   __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3], [4]).
> The attribute is intended to provide additional
> information for
>   - struct/union type or struct/union member
>   - static/global variables
>   - static/global function or function parameter.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/11] btf: change BTF_KIND_* macros to enums
    https://git.kernel.org/bpf/bpf-next/c/41ced4cd8802
  - [bpf-next,v3,02/11] bpf: support for new btf kind BTF_KIND_TAG
    https://git.kernel.org/bpf/bpf-next/c/b5ea834dde6b
  - [bpf-next,v3,03/11] libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
    https://git.kernel.org/bpf/bpf-next/c/30025e8bd80f
  - [bpf-next,v3,04/11] libbpf: add support for BTF_KIND_TAG
    https://git.kernel.org/bpf/bpf-next/c/5b84bd10363e
  - [bpf-next,v3,05/11] bpftool: add support for BTF_KIND_TAG
    https://git.kernel.org/bpf/bpf-next/c/5c07f2fec003
  - [bpf-next,v3,06/11] selftests/bpf: test libbpf API function btf__add_tag()
    https://git.kernel.org/bpf/bpf-next/c/71d29c2d47d1
  - [bpf-next,v3,07/11] selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
    https://git.kernel.org/bpf/bpf-next/c/3df3bd68d481
  - [bpf-next,v3,08/11] selftests/bpf: add BTF_KIND_TAG unit tests
    https://git.kernel.org/bpf/bpf-next/c/35baba7a832f
  - [bpf-next,v3,09/11] selftests/bpf: test BTF_KIND_TAG for deduplication
    https://git.kernel.org/bpf/bpf-next/c/ad526474aec1
  - [bpf-next,v3,10/11] selftests/bpf: add a test with a bpf program with btf_tag attributes
    https://git.kernel.org/bpf/bpf-next/c/c240ba287890
  - [bpf-next,v3,11/11] docs/bpf: add documentation for BTF_KIND_TAG
    https://git.kernel.org/bpf/bpf-next/c/48f5a6c41627

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


