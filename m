Return-Path: <bpf+bounces-69529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED324B993E6
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE52E1657
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6272DA749;
	Wed, 24 Sep 2025 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS4lC3KL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFCB1E491B;
	Wed, 24 Sep 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707418; cv=none; b=kndbSPq/uowaI5z3U72NuXseoQxfA9HQWyO3iNWIvPVrtmRJHpAglKhC1Viahfh6m1kdCgw+GNM53x0N4C8MJC6DGPzZAXB7mC2rVi/tMTZfBC/KRRtMp6+3cEuAZvkPq2001AF3H9qO9SV+a7c7VFCLxlnmGjKx0r3QJ1OPsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707418; c=relaxed/simple;
	bh=rikK/2Q+vtedsrdohY/F8uHem+mKe99sLEtISR2ek/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gtHsWyDYtTqJOcmVUVeg6vhG7OT+QUBm57nNEgWEkyqPa12Skifd6uIQncsjK9IMQYg7vUGebJdQ9V4B9cOpMghbog7SG/hhGssUk7pH+v5/gNAHbf54aB1LCF4Mw404+Z6wBWeKXe9wMokXOk++aKxFlgBPqzQhcjF9bdsXJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS4lC3KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2023CC113CF;
	Wed, 24 Sep 2025 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758707418;
	bh=rikK/2Q+vtedsrdohY/F8uHem+mKe99sLEtISR2ek/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HS4lC3KLrHG8viwuch5nn+dNZOG3cK8VDHS6izNTBmhghpV+v8nnyZVWo8++ELGsh
	 DGsycHbQ/7Tk7mHmvpnH5NL5g/ZbJggX/MQrdrodNiqDNnpzMsLty/PwTbRaKJcrLT
	 L0XhTU27rAMOVDt4TndKiqW649vHaLaaxIdAg3rW5hX+9kzsR+byoj0SoJ34+2H+SY
	 WoTO9u5u/aUrFZRSzDLRbSN4txDDfzu73rw1ad0etZsXKKHY9TZ25wSfx4Yo3sUNNT
	 eclOIiJY3BufspRF8mUna0xOteO09KDo3nGHSx9+bqUbKYAM6SvLq6ehY3rUf+DHL7
	 7MHGMWLJqwKWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAC39D0C20;
	Wed, 24 Sep 2025 09:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf-next 0/6] uprobe,bpf: Allow to change app registers
 from
 uprobe registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175870741477.2114834.11872828252359824573.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 09:50:14 +0000
References: <20250916215301.664963-1-jolsa@kernel.org>
In-Reply-To: <20250916215301.664963-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: oleg@redhat.com, mhiramat@kernel.org, peterz@infradead.org,
 andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, haoluo@google.com, rostedt@goodmis.org,
 mingo@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 16 Sep 2025 23:52:55 +0200 you wrote:
> hi,
> we recently had several requests for tetragon to be able to change
> user application function return value or divert its execution through
> instruction pointer change.
> 
> This patchset adds support for uprobe program to change app's registers
> including instruction pointer.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf-next,1/6] bpf: Allow uprobe program to change context registers
    https://git.kernel.org/bpf/bpf-next/c/7384893d970e
  - [PATCHv4,bpf-next,2/6] uprobe: Do not emulate/sstep original instruction when ip is changed
    https://git.kernel.org/bpf/bpf-next/c/4363264111e1
  - [PATCHv4,bpf-next,3/6] selftests/bpf: Add uprobe context registers changes test
    https://git.kernel.org/bpf/bpf-next/c/7f8a05c5d388
  - [PATCHv4,bpf-next,4/6] selftests/bpf: Add uprobe context ip register change test
    https://git.kernel.org/bpf/bpf-next/c/6a4ea0d1cb44
  - [PATCHv4,bpf-next,5/6] selftests/bpf: Add kprobe write ctx attach test
    https://git.kernel.org/bpf/bpf-next/c/1b881ee294b2
  - [PATCHv4,bpf-next,6/6] selftests/bpf: Add kprobe multi write ctx attach test
    https://git.kernel.org/bpf/bpf-next/c/3d237467a444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



