Return-Path: <bpf+bounces-46246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FE9E67A9
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 08:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14C7165B14
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF21E1C2B;
	Fri,  6 Dec 2024 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj2XmeJA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310E1E0E0F;
	Fri,  6 Dec 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469020; cv=none; b=AUNAyXSlfnarfKf9hdOOugwZpNeNwYG4VqmWj3+UtHkPdLyZSirY9dat2qXNpfkQ0r9KR03eyZI1q+5zs9mq2fvZUgf5TLUTxZy3GVK2Mq8msJ2vqtMAiHMn0Ikq3hPv0R3U0DGZ6q5TEW3IT4/BQ3Jt2Y0RO5aio8NSpHPIj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469020; c=relaxed/simple;
	bh=bgYMmbUmeeNFZfAe6nC7/pJrE+frUhtE8/TYuk75xHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YYVx2Ow5EqrLGq8D6SJzi4FpimnCCrhTnuoXVPA90J7rMyAYPmC2tXOMCUNNN+qdodXkrz0piqwDLShPiEusHv+jBYpemJCk1kJ+0IAs4M7IFU1zJZsnAsl1cGZUJinJcdCMWn1o6cBB5tTfGAtJVBOkSdZ1fdAg88DAKuPNqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj2XmeJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3366FC4CED1;
	Fri,  6 Dec 2024 07:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469019;
	bh=bgYMmbUmeeNFZfAe6nC7/pJrE+frUhtE8/TYuk75xHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tj2XmeJA/2K+rMzFSiQYGA+zs1Scs+61ar6kzGq8vhjjCnwugHWBcCGRV5CQj0O0K
	 j0zmkSK9tgMIrMi3CtWerU+mMHg8+IASnxb96itjjrM2gLm/2xlpHUtCjMWy8rCrvP
	 arrCvzpqIqu/LyHAwj9WtVl7YdxvE4rZ8rt7/K018y/l9CVkedHn7+x5pCq1gZXeIK
	 vQjxMuHYWqHCq7J8CoamcWsWc+ioJPdffWq17eLBwHs4k9VBq3Ht1ToQf4k1GpVdiY
	 2VHXS0QHXecO5EwRu/Dxe/7H3Qux9Kqy2cabHhYUUTM4hlphD7S6d2kqZdhoFxGi7H
	 eXZFbF6y2c9xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344FE380A954;
	Fri,  6 Dec 2024 07:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 00/10] xdp: a fistful of generic changes pt. I
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173346903398.2224618.4233882857033611315.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 07:10:33 +0000
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
In-Reply-To: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, toke@redhat.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, magnus.karlsson@intel.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Dec 2024 18:37:23 +0100 you wrote:
> XDP for idpf is currently 6 chapters:
> * convert Rx to libeth;
> * convert Tx and stats to libeth;
> * generic XDP and XSk code changes (you are here);
> * generic XDP and XSk code additions;
> * actual XDP for idpf via new libeth_xdp;
> * XSk for idpf (via ^).
> 
> [...]

Here is the summary with links:
  - [net-next,v6,01/10] xsk: align &xdp_buff_xsk harder
    https://git.kernel.org/netdev/net-next/c/ca5c94949fac
  - [net-next,v6,02/10] bpf, xdp: constify some bpf_prog * function arguments
    https://git.kernel.org/netdev/net-next/c/7cd1107f48e2
  - [net-next,v6,03/10] xdp, xsk: constify read-only arguments of some static inline helpers
    https://git.kernel.org/netdev/net-next/c/dcf3827cde86
  - [net-next,v6,04/10] xdp: allow attaching already registered memory model to xdp_rxq_info
    https://git.kernel.org/netdev/net-next/c/f65966fe0178
  - [net-next,v6,05/10] xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
    https://git.kernel.org/netdev/net-next/c/9e25dd9d65d2
  - [net-next,v6,06/10] xdp: register system page pool as an XDP memory model
    https://git.kernel.org/netdev/net-next/c/e77d9aee9513
  - [net-next,v6,07/10] netmem: add a couple of page helper wrappers
    https://git.kernel.org/netdev/net-next/c/9bd9f72a7434
  - [net-next,v6,08/10] page_pool: make page_pool_put_page_bulk() handle array of netmems
    https://git.kernel.org/netdev/net-next/c/024bfd2e9d80
  - [net-next,v6,09/10] page_pool: allow mixing PPs within one bulk
    (no matching commit)
  - [net-next,v6,10/10] xdp: get rid of xdp_frame::mem.id
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



