Return-Path: <bpf+bounces-73916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC26C3E032
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 01:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DC188BDD5
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 00:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDDA2EBB86;
	Fri,  7 Nov 2025 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeDfNrlZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A362EB846;
	Fri,  7 Nov 2025 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476431; cv=none; b=K71iQdZjYjS1nhvIRKkJe4HG5/9LgqTuq8OgROl09WPwVdlq9AS6lYS8wIVD90Wbj6Y/b2hsgC1w3tVCLNHerlEmX5ilKtvNEmtebqwNZeQ17i8OQpz20wscAd6dO3pqSPMXYQtJ6SbnjGNKtCXdNHrcdSls+RVFkg1wKrLyoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476431; c=relaxed/simple;
	bh=2Sv5tj7Zi23wG7VRNqpLdbbZouQLzxRGxKJ2OpfMsIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry4J+ffYDrDJl9cdHMalLeuFR7asK8HZh0/bxU/WNH1I2wNxKnphg+AGz4eXB1hKGvetRaPHcWdyCw9q8r2EiS64Fv3H60g4hY0twro4216aIvxOgw4j1LQrcmKqakokcoPcoZOLs9r/er2q7JfE9KtPRKqevsqXdAbeTiNeWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeDfNrlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E6CC4CEFB;
	Fri,  7 Nov 2025 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762476430;
	bh=2Sv5tj7Zi23wG7VRNqpLdbbZouQLzxRGxKJ2OpfMsIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeDfNrlZ7RiFWX/T+qP/DLjFldwFEfdM3sREdKkRzVTj3NxBobzZmqQFWIGR1HqPt
	 tkqLKFAmXcEDdtprYKy2ybgi1AmnPk6mjqheqioYANcI9xfSM/hm42joiE2M/QRLYR
	 k0NPRfNgSRaTIaZRdXE6enqgpxGTyLdj1UBxBTeOvKksreTaEUrs9q3m09wAqNCN2C
	 vluTRx3Fn97/OPBs9cKfb5LXh0J4+R7ycKzd9IBdYU6TiWlsYjOUWZZgNvpPkWlRSE
	 x+FKLOk1/qnTCmL2Q0yAuP1++pIYazwF9bzEn1i1cB0CZxnkZRUWc8KqoJVZbgleCC
	 9HoMj6BTMe/+A==
Date: Thu, 6 Nov 2025 16:47:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring
 zero-copy and AF_XDP
Message-ID: <20251106164708.29fb47e1@kernel.org>
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 22:20:49 +0100 Daniel Borkmann wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.

I'm gonna pick out the unrelated patches, don't celebrate just yet.. :)

