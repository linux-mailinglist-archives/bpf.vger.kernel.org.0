Return-Path: <bpf+bounces-69315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7DB93EC3
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B118A4A6C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098726CE25;
	Tue, 23 Sep 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEccxrNh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217F946C;
	Tue, 23 Sep 2025 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592750; cv=none; b=C62kXGnSBqAtUC8gzDLejPNQHi7Cemx83bxe2x2ox4nnOAZimAC0LbfoPKy9khb+lL2ZHc0D5zIMCn7xi1dTTvgRaaXzft1VMTdIN3qs/cVTX/YbfbCln5o/ja8WsbeWF3EBNnSLMtKXvhVV5S+g/0OSp2GAa3tCFWjSghffNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592750; c=relaxed/simple;
	bh=w0Hb5cF5iLtr3oPKYi/w1XIZm+99kosiGCqKTaApEkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6QxY87WEJIrUqx4INkENNe/3EKwiTVVzTiTpLFungZRQt/CJLQS3Rd6reOvBCgxgOOEEZ3mTQBnZAecJCmbL3XcSIT8YpMbkke4CH2P0tTOsYmBv+3GWCv/Wn9YaiEYROLybrnWUGm5W6vKVrGt3HRi36kc/Pndg4GTO7rnFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEccxrNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E223BC4CEF0;
	Tue, 23 Sep 2025 01:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758592749;
	bh=w0Hb5cF5iLtr3oPKYi/w1XIZm+99kosiGCqKTaApEkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEccxrNhCJWNHWj4DFVf+HbT9AqYN+fmGnieUbDzC3MVcyskqYAg39jeIHGOi9P0G
	 uS2Ehwg1rYXh7oBjREtnOB6T8j6zHlc4MuxsEtwUIdOS0HFWq82xgqPmAH2hHc9EGH
	 8oTMNiEVLalYtRKPpXj4ocZIR526Vl++Lt+noXUPjsMCgCxYpfFb4AzcoMuWAqVriz
	 2UN2yFImaZujUtfvJ+mkpPHiH0S5fmBgEVC718iKrw8+82OwG+lX+exfrZ0xPVt/nb
	 Rd6e38Az7EXYeVgz4il0DfOchvvL93Ub2eb4Uk8Ilhs+6kSTwfjp4NTXA9dbf5rfUf
	 NbXGnu/mwnVvw==
Date: Mon, 22 Sep 2025 18:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
Subject: Re: [PATCH net-next 00/20] netkit: Support for io_uring zero-copy
 and AF_XDP
Message-ID: <20250922185908.3305137e@kernel.org>
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 23:31:33 +0200 Daniel Borkmann wrote:
> We have implemented support for this concept in netkit and tested the
> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> (bnxt_en) 100G NICs. For more details see the individual patches.

at high level

 - not sure how instance locking is going to work here
 - integration with other queue related APIs is missing (stats and
   upcoming config API)
 - the model of "allocating a queue" needs careful thought, the model
   of bumping the real num rx on the remote is fine here but it will
   not work for real HW queue alloc
 - I'd have expected more of the code to live in the core vs so much
   handling in netkit
 - we need selftests (while the sample is unnecessary)
 - last but not least - I recommend
   https://lore.kernel.org/all/20250912095730.1efaac16@kernel.org/
   ;)

