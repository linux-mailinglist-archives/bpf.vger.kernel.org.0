Return-Path: <bpf+bounces-38211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292EE961938
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FC8285189
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BA1D3638;
	Tue, 27 Aug 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1yb9wiL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489B155327;
	Tue, 27 Aug 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794231; cv=none; b=tXxlxlWQjQxx76Df00YzD0RdEVd54rn1QefE/VMPhFLfl7BMl7TkkTciEFckhmgoAGqeX3rW3Fj9R4Df8R09hSnA6TsVbAc2IwypUIMylKJ5vhf3Vq1nEhh9UU++VKedjUqP4IgYYbQGKsHqx/zAD82u+XAx4MHchGRs+CPbHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794231; c=relaxed/simple;
	bh=pbdDCQZ3c4mWtxZF+uZDZEXyC0e0EtwYuO/5WUr+Avs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TXWYlIDKtm7If+A0EjaTN1O/4qmEiB+R0NkLVoeBt0tm6UYAPyY1xuvS7W338P6H4MfflDRnAJvgiw1eS8SdscpfR7NeCTgWNWQU1SBKneMWzFyXSe14twJbEUbluz4Iit+cD9/p3zDVqSP93InCU5mOSslnpLBptuZ+CJCQ4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1yb9wiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B476C4AF11;
	Tue, 27 Aug 2024 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724794231;
	bh=pbdDCQZ3c4mWtxZF+uZDZEXyC0e0EtwYuO/5WUr+Avs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d1yb9wiLWfHprw+iZmr9zoWZxkDcY+VcGzwrtMCGHoEA6N2a4GL8PlPyp4fqlVHRg
	 i9lPudfXmgnGYc5JY371ROXZVrrzHtw0yv22Iy8kifSuIeO2PFNfLt00PtTMXR7Oaq
	 CZvfBRFQRMV+vmtWZb49T5aMAm7yyIBDHFhGniD2zUDWXaddke5zdO5g5MJ1NuJm+f
	 qu8DqCoGjdK73EEnB16hwF3QS1nd13oF3FVw5qj8oy4Xn2/pjPn3XLLdZvVccDZXCn
	 PpOD7O/6AGQYOCE/FTubBEglXdEcL4fttaLio4ZLzOnkfHY8gXO6l+Zqk3EeYaB+HX
	 bRKNqYFQmANNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712C23822D6D;
	Tue, 27 Aug 2024 21:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v3] tcp: fix forever orphan socket caused by tcp_abort
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479423125.767553.13899166301990812537.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:30:31 +0000
References: <20240826102327.1461482-1-kuro@kuroa.me>
In-Reply-To: <20240826102327.1461482-1-kuro@kuroa.me>
To: Xueming Feng <kuro@kuroa.me>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 lorenzo@google.com, kerneljasonxing@gmail.com, pabeni@redhat.com,
 kuba@kernel.org, ncardwell@google.com, ycheng@google.com, soheil@google.com,
 dsahern@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 18:23:27 +0800 you wrote:
> We have some problem closing zero-window fin-wait-1 tcp sockets in our
> environment. This patch come from the investigation.
> 
> Previously tcp_abort only sends out reset and calls tcp_done when the
> socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
> purging the write queue, but not close the socket and left it to the
> timer.
> 
> [...]

Here is the summary with links:
  - [net,v3] tcp: fix forever orphan socket caused by tcp_abort
    https://git.kernel.org/netdev/net/c/bac76cf89816

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



