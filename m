Return-Path: <bpf+bounces-26349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46689E7EB
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 03:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A19DB21CBA
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386D4C6B;
	Wed, 10 Apr 2024 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/78VjWd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D015A4;
	Wed, 10 Apr 2024 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713587; cv=none; b=HtDsmNuBJIvdW0Y+Lhencar1OsY8m3YP3kaZ5lp0CL2h3iwXaFwpfCaZQvEOlVAuPohPlOp6UTohO4YMdp9/z/32EKhpKoo/nQYtEHzW5LHQ6toedp/R7qXvMW8LLvPXGx2LQwWC4z8U3Ws3aS7WbZkhtQIfJ6hbQj2To5MhGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713587; c=relaxed/simple;
	bh=1YgFdUcBOKesTaua31ZEyD1c9Gpgvfr0heHVZed0Enk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAbalXxZN1JpQBl13Anor0GjbmosIr42lIDoS9VaMG0iSzT1sbkVaG200g0tsj46N23w30h4d5CL3x1JkQnQuL5sEgobJUpGgTwwLQiuAeOHENnm9CMhT1khM2awZR8rmrtuiMlThjZsxqd7bucw32IVMah3cQ+irbzd8p46Apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/78VjWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D42C433F1;
	Wed, 10 Apr 2024 01:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712713587;
	bh=1YgFdUcBOKesTaua31ZEyD1c9Gpgvfr0heHVZed0Enk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/78VjWdo/c0F0Ap07gI5asrS7PrsOu2M02J+DbxVjLWDvzFOCQj0or2QN13AWozE
	 I69cMnaM1ljMIhs/0Lp84+zGGrKjGK+/CXANY3BLrmNxLBhq4kaduZjuEReLaCWWCM
	 rte8M4SlHEUagzJtAXFK0rggGoLFQZvYFbNsor1v1NzuoQK/a4YRotlvV3NLP6fos1
	 5WsKk0K30sTsNVRZti9VcJ00BcNP1yTZV7kxZYXi4/yHOzNi43F1A9xC8vq4CFQg0l
	 rwcAwaw4bJhCi9poeYvELIrMuEt8FcP5FKz1pc4TBZxdLGNQelNbfUOj7E91vbTg6q
	 dEzc8Cp+Z0Vvg==
Date: Tue, 9 Apr 2024 18:46:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, elder@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, taras.chornyi@plvision.eu, ath11k@lists.infradead.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 geomatsi@gmail.com, kvalo@kernel.org, quic_jjohnson@quicinc.com,
 leon@kernel.org, dennis.dalessandro@cornelisnetworks.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next v4 1/9] net: free_netdev: exit earlier if dummy
Message-ID: <20240409184625.301e4bc0@kernel.org>
In-Reply-To: <20240409125738.1824983-2-leitao@debian.org>
References: <20240409125738.1824983-1-leitao@debian.org>
	<20240409125738.1824983-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 05:57:15 -0700 Breno Leitao wrote:
> For dummy devices, exit earlier at free_netdev() instead of executing
> the whole function. This is necessary, because dummy devices are
> special, and shouldn't have the second part of the function executed.
> 
> Otherwise reg_state, which is NETREG_DUMMY for dummy devices, will be
> overwritten and there will be no way to identify that this is a dummy
> device. Also, this device do not need the final put_device(), since
> dummy devices are not registered (through register_netdevice()), where
> the device reference is increased (at netdev_register_kobject() ->
> device_add()).

There's a small fuzz when applying due to the phy topo changes
landing, please rebase, the CI didn't ingest it right.
-- 
pw-bot: cr

