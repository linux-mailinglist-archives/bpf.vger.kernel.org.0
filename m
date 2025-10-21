Return-Path: <bpf+bounces-71595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363B0BF7D43
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9034546CCD
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9F348899;
	Tue, 21 Oct 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOJXBTEY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB5339710;
	Tue, 21 Oct 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066625; cv=none; b=YmEF741TRdBEAlLsrpUBPMDoRMiquX/YjLas4msgUDsJs6ZSDhaKPmwb0FvkRTrFFIJapHWBnefpWxPeJZaRDRfrJ6yfld6khvm9YaTVqsKukO1nFdW54q2WsZi7ljPGHnuYzzFCgacZs5X9s9TpsS9viWyn2KvlIM2Hyvl5B+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066625; c=relaxed/simple;
	bh=rSjJKdQB3KKSZZPvG0Kerperdmp5F1v3jL6/KaDh4Yk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GZf9bKWilpxX+3wB063wqj0jVX01ZYTwlfu22gfaWhqKu3wD+daJLTH+j/hVp00Fv4fnDoGyUlA2z5/A37jpqjTmZp0G0evFVErInQ0H6Nnx8nBZPW+d2zRTMC8rsx9SgcrvbWwrJjwT8WCBFREw8J89YVtkMnMtNh5KsiRSclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOJXBTEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E6C4CEF1;
	Tue, 21 Oct 2025 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761066624;
	bh=rSjJKdQB3KKSZZPvG0Kerperdmp5F1v3jL6/KaDh4Yk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jOJXBTEYbNITZmmyyezZSSzl7AvCQkNpnZoEmjxp1BHqG4HNdTSjRL9lO2uptthUV
	 srUvdO4wnXrS8J0zrrVR5bPS17VqUgxwcpFLj4e+6eaLBN95pfo4HHsLvEh4xqKo2A
	 Fv5KAYslVBEBqInhKgYNQNvgjKECS61t/fOHR6M9aG/xKPAcfS2awBxH07TBMX69Wk
	 RoT+YypJQfRFs4FMIG1PbN4NVOpUICycOYeRTHjCfH7c0oA4ZgDvTKv3rnCDIu4bkU
	 4Sms9bejKiAbjG2mJGGTA+5r8nBs6XIWIhwaFBkmpe/zn52dOYNJKzkClzk6yVLSsT
	 hjrc0yIUctTEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37E8F3A55F96;
	Tue, 21 Oct 2025 17:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: sync pending IRQ work before freeing ring buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176106660601.1163561.6885193392074712225.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 17:10:06 +0000
References: <20251020180301.103366-1-nooraineqbal@gmail.com>
In-Reply-To: <20251020180301.103366-1-nooraineqbal@gmail.com>
To: Noorain Eqbal <nooraineqbal@gmail.com>
Cc: andrii.nakryiko@gmail.com, alexei.starovoitov@gmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 david.hunter@linuxfoundation.org, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, skhan@linuxfoundation.org,
 song@kernel.org, syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Oct 2025 23:33:01 +0530 you wrote:
> Fix a race where irq_work can be queued in bpf_ringbuf_commit()
> but the ring buffer is freed before the work executes.
> In the syzbot reproducer, a BPF program attached to sched_switch
> triggers bpf_ringbuf_commit(), queuing an irq_work. If the ring buffer
> is freed before this work executes, the irq_work thread may accesses
> freed memory.
> Calling `irq_work_sync(&rb->work)` ensures that all pending irq_work
> complete before freeing the buffer
> 
> [...]

Here is the summary with links:
  - [v2] bpf: sync pending IRQ work before freeing ring buffer
    https://git.kernel.org/bpf/bpf/c/4e9077638301

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



