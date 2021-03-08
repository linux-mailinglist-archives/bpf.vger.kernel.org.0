Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DA330EE5
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCHNKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 08:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCHNKH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 08:10:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C8A966518F;
        Mon,  8 Mar 2021 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615209006;
        bh=X6dboDfGc3Kwhg681NdLNUwjrwtCVBfB5c1R2LALe6U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=frdGiA++ZviU0y7xtjp9eRbgPxZmX4Kuo2p2NyR1btSdlerTLhJd6GvQE7r2wVgeK
         S/r7y3Zsy1m/s3Y19GJMsCitInvzl/VZKvVWQ2aDyDWNbUelT8rYpppWfRZfEG8sUi
         GhbtO8uEPqb6wRn6dzCLn+00eE0JymO/NFvk6fgw01WBkJXECQcnYnqtdQ5S0z/kJ7
         6YolMSRc5xmZ3GwH2oMTu5w8KjhD8435y66h/s7awU9BaeMBYm95b7uPDlGx4MScl3
         LA2RL2hOkjSZDoF2f6vWQINwVvjejH1zf9RbO8E2bcet2zdEbpjNKOvRmFMT14LCJd
         tXRyeRCfIwxGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BBF6A609DB;
        Mon,  8 Mar 2021 13:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Dont allow vmlinux BTF to be used in map_create and
 prog_load.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161520900676.23977.17829281573568193224.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Mar 2021 13:10:06 +0000
References: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Sun,  7 Mar 2021 14:52:48 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The syzbot got FD of vmlinux BTF and passed it into map_create which caused
> crash in btf_type_id_size() when it tried to access resolved_ids. The vmlinux
> BTF doesn't have 'resolved_ids' and 'resolved_sizes' initialized to save
> memory. To avoid such issues disallow using vmlinux BTF in prog_load and
> map_create commands.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Dont allow vmlinux BTF to be used in map_create and prog_load.
    https://git.kernel.org/bpf/bpf/c/350a5c4dd245

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


