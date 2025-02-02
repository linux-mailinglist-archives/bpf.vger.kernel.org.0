Return-Path: <bpf+bounces-50280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9A8A24C83
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 03:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61401164578
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A71A17993;
	Sun,  2 Feb 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbqo4lXM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9917E0;
	Sun,  2 Feb 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738462807; cv=none; b=JBjxOngfJEqYg1Qzc9WSOO5slsxnlhjsSTFFyqxtBIeJjtQxmaeWTmS6r++QZGsk66fMdl4eKUTxytCK/6QQTcjVxlR1X8rXN2O6DB5BjsXhJ7ZAqZZC9cB8DUOM7/SOIboSeqebJPZhFe+KsCyljw1bvX6Vpesl8Ek7qRrEHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738462807; c=relaxed/simple;
	bh=/XZB3GzWPO3Mth0ikFax3tbAEyjt/6dk/1vABQ1tKro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i6OpIdBp8OcUVhe+pBDphtl5lZhNmo4DdNVtiYZuZ4tntPLt7a+ifahSnQp6F+Iu/APlnzcuCP/ZtsjQvuYFJ8TxouoOIVLpCAImIwi5g64FugLbC7aPVOaQuJhcTGD3oG7SDQEhvxlhWa+cty2rZNxHBsJyQpRuJSR4CRL9c2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbqo4lXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F47EC4CED3;
	Sun,  2 Feb 2025 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738462807;
	bh=/XZB3GzWPO3Mth0ikFax3tbAEyjt/6dk/1vABQ1tKro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kbqo4lXMkv8U1hiD4jPneFA7IIjsxG2Z8HNS2AvPcmBggplBa9POEObsvsZsl7hir
	 O72cM+NDVxRlstusr4O3ZeSVJ21OnWSwZFcx/ddiCKD8zR7Sf12cUAwG0ki4YZIy0H
	 ddn/ee963tsW1W8AjXfEL76c5/K9PoE9KELg5FnH7NEbLVNlRRyeR4yoU9W3VEfvHC
	 YCciDpxAe1aTycioV4p6pWwCOj+ITtrE1eISIVDpS1osToBFgUb6ljI9y5OgxH65Yj
	 JKZyptg8J3mzEbbtpAoi6yRjaTAtrvE8kMzdYFAequvmVor7TQCA4GJEnN9TlaZ5Qk
	 mSfO0ln1vtcPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3413F380AA68;
	Sun,  2 Feb 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] vmxnet3: Fix tx queue race condition with XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173846283402.2039246.14501879360913154651.git-patchwork-notify@kernel.org>
Date: Sun, 02 Feb 2025 02:20:34 +0000
References: <20250131042340.156547-1-sankararaman.jayaraman@broadcom.com>
In-Reply-To: <20250131042340.156547-1-sankararaman.jayaraman@broadcom.com>
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexanderduyck@fb.com,
 alexandr.lobakin@intel.com, andrew+netdev@lunn.ch, ast@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 hawk@kernel.org, john.fastabend@gmail.com, pabeni@redhat.com,
 ronak.doshi@broadcom.com, u9012063@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jan 2025 09:53:41 +0530 you wrote:
> If XDP traffic runs on a CPU which is greater than or equal to
> the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
> always picks up queue 0 for transmission as it uses reciprocal scale
> instead of simple modulo operation.
> 
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
> returned queue without any locking which can lead to race conditions
> when multiple XDP xmits run in parallel on different CPU's.
> 
> [...]

Here is the summary with links:
  - [net,v3] vmxnet3: Fix tx queue race condition with XDP
    https://git.kernel.org/netdev/net/c/3f1baa91a1fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



