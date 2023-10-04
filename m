Return-Path: <bpf+bounces-11376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7BC7B8128
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 40D472819C0
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7415493;
	Wed,  4 Oct 2023 13:40:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218914A83;
	Wed,  4 Oct 2023 13:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A48EC433C9;
	Wed,  4 Oct 2023 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696426830;
	bh=aee1fouYF045WW8GU3jBWsO3ZVY5Tty+PUGRLhypRsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HbKyjWaaOcsGP1qt7aXiYld1nlhw73l0+b+8XqT3jXkvF4OKEYDHBcRQM3dHBNe50
	 gqqQIzv/g9YBE2k56KMsVxUAUEoB7RrAebIe874Hl+1blhcJqnAcOKLlee1tHsFotP
	 WEi4M6hnfzE3aANOgAfbxTAReQdMqV39UQUXjV9or21kLskuI7bN29DpS1oR5Iw0K/
	 UxaP4Zdl7/lExVy/9aHkQONgIBvLgFVMk1RWD0qYMe1N0cBbGT/siWIWMigN/Dgi6I
	 JvUwrvz4KrFK7FsIhVi0e8gjGRXkUp2ypM0YXESP6DSCEB8euFbArQrOPwoNTt7f/H
	 Q0hhMGFJ70L+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35F03E632D8;
	Wed,  4 Oct 2023 13:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/8] Add a test for SHARED_UMEM feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169642683021.23579.808775840588074841.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 13:40:30 +0000
References: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
In-Reply-To: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 27 Sep 2023 19:22:33 +0530 you wrote:
> Implement a test for the SHARED_UMEM feature in this patch set and make
> necessary changes/improvements. Ensure that the framework now supports
> different streams for different sockets.
> 
> v2->v3
> - Set the sock_num at the end of the while loop.
> - Declare xsk at the top of the while loop.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/8] selftests/xsk: move pkt_stream to the xsk_socket_info
    https://git.kernel.org/bpf/bpf-next/c/8367eb954e24
  - [bpf-next,v3,2/8] selftests/xsk: rename xsk_xdp_metadata.h to xsk_xdp_common.h
    https://git.kernel.org/bpf/bpf-next/c/93ba11247907
  - [bpf-next,v3,3/8] selftests/xsk: move src_mac and dst_mac to the xsk_socket_info
    https://git.kernel.org/bpf/bpf-next/c/985fd2145a29
  - [bpf-next,v3,4/8] selftests/xsk: iterate over all the sockets in the receive pkts function
    https://git.kernel.org/bpf/bpf-next/c/8913e653e9b8
  - [bpf-next,v3,5/8] selftests/xsk: remove unnecessary parameter from pkt_set() function call
    https://git.kernel.org/bpf/bpf-next/c/46e43786cc60
  - [bpf-next,v3,6/8] selftests/xsk: iterate over all the sockets in the send pkts function
    https://git.kernel.org/bpf/bpf-next/c/fd0815ae9b8a
  - [bpf-next,v3,7/8] selftests/xsk: modify xsk_update_xskmap() to accept the index as an argument
    https://git.kernel.org/bpf/bpf-next/c/fc2cb86495da
  - [bpf-next,v3,8/8] selftests/xsk: add a test for shared umem feature
    https://git.kernel.org/bpf/bpf-next/c/6d198a89c004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



