Return-Path: <bpf+bounces-52141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25908A3EAE0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 03:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B619C5C6B
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DE1D63F8;
	Fri, 21 Feb 2025 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfS5MFWV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403B33EA
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106207; cv=none; b=tRpo8eogmAsDyHgDGwHkxGYyYhSHcEqQD4eB7S4jHdV50fxFUJYKH0gsG9Jdqan4k60/rQNrivgDT4Lkw1jX44zEqqtcKfblRO0K4OX5+jz8AC7o7TX/JWCYbo04cDxqu/npuL3zMvnfsFrZ+L7c8PNRRRE/fFgcKwolG/Duyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106207; c=relaxed/simple;
	bh=5xDWGSjI8L9ww2xuIjXMfomrzceovMD9lNeFpvyfWJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJ6YGgGrVRgBFVQOzeY6tz5hbNe5Rr5U6zgLjmWnjIUex74FAeiVPn3yOhG04w4k8McRluJ20pxJm1SXf+xdI8Kli9TmdlKGnKTfPcEuSwR1XF++rNdsprs87abxoyOxU3tQ4MgHMy+Mi61qHP1JPd8VNI3eQruP8Mt/BKT/e/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfS5MFWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA6C4CED1;
	Fri, 21 Feb 2025 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740106207;
	bh=5xDWGSjI8L9ww2xuIjXMfomrzceovMD9lNeFpvyfWJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DfS5MFWVh3vE+MyttL/f+HI8C0r6lNDf5kDCCoKg9G8tRNPTQWR18kC/qvUUAFQ78
	 cPu5LkinEer+UW+yI2TksAKCqTKA8YE5yIW/qMEPfmzdrQGFeGqszNDANEn1nx4lI6
	 3yrve5QfkX7meMPXZpIwBayziowQ2eFLcxet3YDC9vTWoU5yYNTki1V+9m/WvdGt5W
	 Pe+e1yjsctOSxoUam2WH2p3YLZvYE0QlkI8xg8TMpc9ZU0h4wwHUVVEi6JOk9QJTqT
	 /wbqiMS/QZQa72jixjIVkRqhC+kCHOkO4YlhGEQr54kBgH3hUILmy4DmNN4LxMLxcF
	 3h7Ui0rXGR1Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB93806641;
	Fri, 21 Feb 2025 02:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Use preempt_count() directly in
 bpf_send_signal_common()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010623849.1561130.980006383041741395.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:50:38 +0000
References: <20250220042259.1583319-1-houtao@huaweicloud.com>
In-Reply-To: <20250220042259.1583319-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 puranjay@kernel.org, houtao1@huawei.com, xukuohai@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 20 Feb 2025 12:22:59 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> bpf_send_signal_common() uses preemptible() to check whether or not the
> current context is preemptible. If it is preemptible, it will use
> irq_work to send the signal asynchronously instead of trying to hold a
> spin-lock, because spin-lock is sleepable under PREEMPT_RT.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Use preempt_count() directly in bpf_send_signal_common()
    https://git.kernel.org/bpf/bpf-next/c/b4a8b5bba712

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



