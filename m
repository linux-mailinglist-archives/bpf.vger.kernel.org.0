Return-Path: <bpf+bounces-69260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B16B92896
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB21905818
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108E3164A9;
	Mon, 22 Sep 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM7qZzJz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A292FFFAF;
	Mon, 22 Sep 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564194; cv=none; b=gSaZyCTetfaNGHfZLIg/YsjQgfTCM7OBKC32BtnBScoMJdh0zAp4OrQDbtjXHJHeh7wXFGLTK6ECY673mpd17rQJhTUhqxYVQ9QCA9ia2hKWcC/Jdh8vhb7sFus5wGbW8TzCxmq46m+36DNjHfEpkK8uoSH/r63R+gyIxqLV1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564194; c=relaxed/simple;
	bh=+avfVH9e3rLSc6xfzVhLeYD48mUr8Du4W9R9f1QNq1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhjC+SFFthGn1OjjH4A4y3XqXHNGuZFpSfGMM3c13sJqhmsiX8V/yOdsCtZCCzuiZGuFN7eYgqHHevq33HoF8rXTyvRDwyHR6oxsJEJXqZxKVG1SBqhvjfKsZ7PRaOZ15PDffpiCNRTimxzEDqnCDm7JBaPko7LWFlSos7memDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM7qZzJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DFFC4CEF0;
	Mon, 22 Sep 2025 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564193;
	bh=+avfVH9e3rLSc6xfzVhLeYD48mUr8Du4W9R9f1QNq1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SM7qZzJzODpEhAymCbaDdxwMO7MJSLJE5GzzoLx1TEqyvyuP9VRrJVMGbBXUQoj8P
	 uVS+CwBf2kG9qZ/3Sv/jupeQEa2cJAl/GRkoKCvrWJtVTTo/CRxVsqzjNgTaYvbnJ4
	 SCNDWopMDxoB/gprDC93Jz4uu7b577dRb930B8PxGNLe/5CR+SDIXs87q7ZXkDlDS8
	 ThfAdBZsdtLHD4Z2GCCHth29qE9pUp/gyXycvTnqwLJwX1BQOKgo/QUo7+6u5Lq1dA
	 PIEingMktCwuSLf0tqNLQ87rr5KYnuXPYaeI36G53OLnEqzvSn3Lqv2ppxOhpvuQ7c
	 nt8OEXSAnDnMg==
Date: Mon, 22 Sep 2025 11:03:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, martin.lau@kernel.org,
 noren@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com,
 kernel-team@meta.com
Subject: Re: [PATCH net v2 0/2] Fix generating skb from non-linear xdp_buff
 for mlx5
Message-ID: <20250922110312.7397151b@kernel.org>
In-Reply-To: <0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
References: <20250915225857.3024997-1-ameryhung@gmail.com>
	<b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
	<0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 14:24:53 +0300 Tariq Toukan wrote:
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

To be clear - you have to take these via your tree now.

