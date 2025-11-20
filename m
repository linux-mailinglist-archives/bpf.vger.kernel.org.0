Return-Path: <bpf+bounces-75196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD518C76761
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79C20357A79
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4F3570A6;
	Thu, 20 Nov 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6xBLrry"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA8182B7;
	Thu, 20 Nov 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763676645; cv=none; b=pELb6ClG7m4A1Go9EbTm0yZno8OlQSz5PANyMyS4LWtl80DUnVVCkB0LNW59BapqDdZfuzJMZ1IUhnffJuHBf1JtmwejUdTwjb2zEw5HXffwm2e4X9XgvsLtFkl6QmKXviMNHrSIQaIBXhw3XlKkoKw36OlUFso6jwSsHe8VILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763676645; c=relaxed/simple;
	bh=UV6LiF/stAtDrBM8bsyoVwy+mKAbgHEkZVcax6OJDbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PNlZqj9d1ZVhg6E4r7clSfabBRbVWXZ289lj/uuPCAMX7Nf8Jd9hykx4RqfEFfQblH6ubc+5GcMqkMEQ5iQWyysu4Dj8E7s/nCD328VZLf0FVN8TDq2RBBJ3ofMnIF4+KJrmAPLL9LY7AIweQhc1H2+GCP+QJUW601lnSYz77JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6xBLrry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2846C4CEF1;
	Thu, 20 Nov 2025 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763676644;
	bh=UV6LiF/stAtDrBM8bsyoVwy+mKAbgHEkZVcax6OJDbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F6xBLrryqf9Ccz4b20/oU0JGedxYsEo9c5Sb01t/2XMZFck+onLTCmvIhWgGRhA7w
	 0tApO+VDHGUhPyyS46xMI9M6Yilc2oaj7X4a+bNa8ndjW1BOzIb4+8byFFsxXMKe2P
	 Rd9wYkrvmRGmN4tvzUpDuxxEw53tw0H7a7GRD35RZliNmX+I/Mrx9uJaUZTeQIg9fA
	 lmNtYmtNe9IQPvYWjD8dj9LXY4UvLP3U6ySTetEE1whFV8qcl+/XyUFMFzUg3jjd9k
	 bPNoyY5ER6Yx5/O8/eItHtAmojmbtyVJcXqZwCEE7KzBwm0zozLifqgP4cUaToJxQt
	 +nCPpOlM3Oysw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4F3A40FFE;
	Thu, 20 Nov 2025 22:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Document cfi_stubs and owner fields in struct
 bpf_struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176367660986.1804570.2226125940401582306.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 22:10:09 +0000
References: <20251120204620.59571-2-nirbhay.lkd@gmail.com>
In-Reply-To: <20251120204620.59571-2-nirbhay.lkd@gmail.com>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 21 Nov 2025 02:16:21 +0530 you wrote:
> Add missing kernel-doc documentation for the cfi_stubs and owner
> fields in struct bpf_struct_ops to fix the following warnings:
> 
>   Warning: include/linux/bpf.h:1931 struct member 'cfi_stubs' not
>   described in 'bpf_struct_ops'
>   Warning: include/linux/bpf.h:1931 struct member 'owner' not
>   described in 'bpf_struct_ops'
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Document cfi_stubs and owner fields in struct bpf_struct_ops
    https://git.kernel.org/bpf/bpf-next/c/e0940c672ab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



