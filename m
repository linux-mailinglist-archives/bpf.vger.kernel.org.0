Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846184A58E1
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 10:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiBAJAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 04:00:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33630 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBAJAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 04:00:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FCB614DC
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 09:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 797FEC340ED;
        Tue,  1 Feb 2022 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643706009;
        bh=vBVeQQW/PVWtPa9sl9N0z6OdvQfyHklY2IuBcNl7fPw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b5MGiv0F7lHRoE5EBjVUCj/2W3hqsDnH/QpUWIXusAo1IpdFQebfY9cW06BkyhR55
         uCjD4+tUyTf6+qLDJHgrdrsICbxqZoE2hrcNzhTpchXwK+r99ZM9SV4pm5N7Xr3aej
         D/GriV21FTaq9pDJ+zM5+qXS64lmrV9BncyBQaX+iwdmgIggMsJMtj2+Zqv6OePgJE
         sZVhMqDGhSTP7J548P9iNjgGnY/cmXxerlzE3hImitbAt3gD2cR68bzOxKV5GeJhlQ
         q30JtR4Q+hsXs0rjNs3WSiJHGx1ZBWBn4H/YSV/j7N/UICVQqLhKhIM2FDYh4mX0ay
         YMx70FD6A8yAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6208CE6BB38;
        Tue,  1 Feb 2022 09:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: deprecate btf_ext rec_size APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164370600939.27452.6958793527629660929.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Feb 2022 09:00:09 +0000
References: <20220201014610.3522985-1-davemarchevsky@fb.com>
In-Reply-To: <20220201014610.3522985-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 31 Jan 2022 17:46:10 -0800 you wrote:
> btf_ext__{func,line}_info_rec_size functions are used in conjunction
> with already-deprecated btf_ext__reloc_{func,line}_info functions. Since
> struct btf_ext is opaque to the user it was necessary to expose rec_size
> getters in the past.
> 
> btf_ext__reloc_{func,line}_info were deprecated in commit 8505e8709b5ee
> ("libbpf: Implement generalized .BTF.ext func/line info adjustment")
> as they're not compatible with support for multiple programs per
> section. It was decided[0] that users of these APIs should implement their
> own .btf.ext parsing to access this data, in which case the rec_size
> getters are unnecessary. So deprecate them from libbpf 0.7.0 onwards.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: deprecate btf_ext rec_size APIs
    https://git.kernel.org/bpf/bpf-next/c/5ee32ea24ce7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


