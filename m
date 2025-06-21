Return-Path: <bpf+bounces-61230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91547AE2929
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09887ABE4E
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B6213E78;
	Sat, 21 Jun 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Surd9VUY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C961F09B3;
	Sat, 21 Jun 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750512585; cv=none; b=j9vb9t4KEDE1cPvPu2XhCvpRfghmPsGw72aA8Y9rqpbWfKMt6tcjcnON6h9IoGU4ceydLrAO1Avdm9LCnsAuoTSuJTkFCGvcVetO89Kwxwna8E8aN8vBiCHaTyyyLKmjTDzkQjRC47pdW1qToMASEyhNnV9LLErFBSWElTgbebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750512585; c=relaxed/simple;
	bh=4KIouuDzMIi1N93un7VQrPFp3Ee2u13/JkQGdbfDUy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SonqoWfAeGR7EX73Wa/eRWj4rqT+IpoIFrPqE/XtYwWAVKvVaPkRSIKxu50v1Wu279oK2KfIkNr9Vqj/huewaomr6uETdxbDK0EAIPSfkDVllz/pxZ34jK5k7xfRhpHKXTlNKi5sC+iH9av4q5rBtKiPbGTzG6kEQrL3TFG8sYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Surd9VUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573E2C4CEE7;
	Sat, 21 Jun 2025 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750512584;
	bh=4KIouuDzMIi1N93un7VQrPFp3Ee2u13/JkQGdbfDUy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Surd9VUY1sU7gKRYkPfdkSSXkx7jxjJoJnI1hogLhDQKmvMPG/9BIy27ND+Kte8S2
	 3U2BurGZRiN1qvLZ8VWkB+zfSNI676Gr3qkUi3mIzMpTzC3qFi7N0gUtW8F1wuZf+c
	 R/e1BWpHSKWbW85cOhOmYJikVrixi/ex670AxMUFxfjMpG50K8Zty8xFupG2jIAQTW
	 Z1YRcP+MZRD5o0OmXnxbpQJvV+4Y6E/5o6plqM/0kiNIEWbFo5v6KoPqTPUHMnWwxz
	 AVHpJUqXzg896Aid8BaauXWUJ9VyF5FDQF6YhyAlXFD8xokkc9nsxrB9WlzDyYKnLu
	 y2V9g52mtavQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA638111DD;
	Sat, 21 Jun 2025 13:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] gve: XDP TX and redirect support for DQ RDA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051261200.1863352.2816536185194869650.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 13:30:12 +0000
References: <20250618205613.1432007-1-hramamurthy@google.com>
In-Reply-To: <20250618205613.1432007-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com,
 ziweixiao@google.com, pkaligineedi@google.com, joshwash@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 Jun 2025 20:56:10 +0000 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> A previous patch series[1] introduced the ability to process XDP buffers
> to the DQ RDA queue format. This is a follow-up patch series to
> introduce XDP_TX and XDP_REDIRECT support and expose XDP support to the
> kernel.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] gve: rename gve_xdp_xmit to gve_xdp_xmit_gqi
    https://git.kernel.org/netdev/net-next/c/d05ebf7cc3c5
  - [net-next,2/3] gve: refactor DQO TX methods to be more generic for XDP
    https://git.kernel.org/netdev/net-next/c/cb711b3d197a
  - [net-next,3/3] gve: add XDP_TX and XDP_REDIRECT support for DQ RDA
    https://git.kernel.org/netdev/net-next/c/d8a8ca14c937

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



