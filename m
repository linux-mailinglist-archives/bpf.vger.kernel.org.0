Return-Path: <bpf+bounces-70767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B419BCE2A0
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B693B2FED
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44E231A30;
	Fri, 10 Oct 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBSXuPhH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C33265632
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118625; cv=none; b=TR3KMLpPDH52Rwn0+5k/hS48FJhaWsf6IlgIdyzTrBBb9vy6FA+UGUqMUgkt4ZYShux+WlgrBCye3QMJbKAX3YAjJxLMeRA4gNXo1isFx9GN0EIGFiZ8bXdGpS+FR4vtJl6A2qTfW1w5deJ0ZWt/e5QHy8KOwPZTpNPYfeKXUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118625; c=relaxed/simple;
	bh=oLEkuwZqL/ugTk0rnBE9FYg7Y1vfskn/qz9VvSzaMvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GP5MY4ipQ2s0luQtPVT7xbYpcV7Cr3YGqsPKqnpEI66sb6FaYsiJPzZRCHis1S4MCI4WVAYX35tMhCi91x1ryx6Wx4SaEAWxiojdhoUv8TEL+h+MUwRhpKqtoD3+cCiaub/6cidSiayy3zpexFAMBOa/FrqFJSJJV5uEu+2dbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBSXuPhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629BDC4CEF1;
	Fri, 10 Oct 2025 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760118625;
	bh=oLEkuwZqL/ugTk0rnBE9FYg7Y1vfskn/qz9VvSzaMvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PBSXuPhHuG98XlmRInoT8KHKnpi+/71Neg58TFJBoLymYYU97t46o/uKXqeo6WXml
	 h3xO1b01L0d4pAvSkAmZSaZsujjtYXmcqUWXfNJexomDbnd/ul6SdLQKpt1bDg7edn
	 mnXhAXQ26CkrRlnP79d1ByYDw8uS9bz7N/7m2nHmIx7H2WdOu4pU/EYpan7E2GldIF
	 6/FLyUw8+Ctg7LR9zCO2wJZWcPzxs6JqK/IdHItBPPDnQfWO4GMxmRdeeQGsPloW7Q
	 +MQcIE9dl1UUg87dgProLnKQ49ac6wzjwscHcKnrtd4C5RadFXV8QxEF9VUnPbvW2p
	 q7qKTgLKgSjbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A73809A00;
	Fri, 10 Oct 2025 17:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/5] Support non-linear skbs for
 BPF_PROG_TEST_RUN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176011861275.1062703.7765679746633470143.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 17:50:12 +0000
References: <cover.1760037899.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1760037899.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, ameryhung@gmail.com,
 martin.lau@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 9 Oct 2025 22:10:17 +0200 you wrote:
> This patchset adds support for non-linear skbs when running tc programs
> with BPF_PROG_TEST_RUN.
> 
> We've had multiple bugs in the past few years in Cilium caused by
> missing calls to bpf_skb_pull_data(). Daniel suggested this new
> BPF_PROG_TEST_RUN flag as a way to uncover these bugs in our BPF tests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/5] bpf: Refactor cleanup of bpf_prog_test_run_skb
    https://git.kernel.org/bpf/bpf-next/c/d8accf661fcf
  - [bpf-next,v8,2/5] bpf: Reorder bpf_prog_test_run_skb initialization
    https://git.kernel.org/bpf/bpf-next/c/57bb2f671793
  - [bpf-next,v8,3/5] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
    https://git.kernel.org/bpf/bpf-next/c/838baa351cee
  - [bpf-next,v8,4/5] selftests/bpf: Support non-linear flag in test loader
    https://git.kernel.org/bpf/bpf-next/c/8d45d0398d10
  - [bpf-next,v8,5/5] selftests/bpf: Test direct packet access on non-linear skbs
    https://git.kernel.org/bpf/bpf-next/c/bc3eeb42597a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



