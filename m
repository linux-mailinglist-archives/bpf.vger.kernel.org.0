Return-Path: <bpf+bounces-49695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E227A1BC40
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195E4168635
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4F20E004;
	Fri, 24 Jan 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA+wycU7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1621C17B
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744011; cv=none; b=iFoGEwP+eUyKE0QRER0GmYjyg9NImrvqRmn6c4NbvnRn2PdsBSyi0UPXKj9rIL0sZ+c9Xl20PiPddpDkywlxwgwxzVKbNfZzqTCoUTgWOs9Qy5FpERXx1qYMLbNkO1ubUDiexiv6LzPIfudI2qXU2O7TDmLUlbiigmufWCayZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744011; c=relaxed/simple;
	bh=ZIbLzggLSCdPIdMrk3WaumnekbdYUTacY+zQH1a8LYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+vt2SI6tuAo+A1B5imedDXGz6/VNnpTYjhFofgR9y2JKUaIO7AxiLGfFGW7ZJpjes5ZrSaXjzsVs83HR0j3bJC8wxP9W34se7Sap+dX5Q+u4oOtuthYJf5o/z2ruj/f3wMekEMBsXBl9EdbHA5po1Xa2AdwFN92nS4Kw7mrIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA+wycU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A57C4CEDD;
	Fri, 24 Jan 2025 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737744009;
	bh=ZIbLzggLSCdPIdMrk3WaumnekbdYUTacY+zQH1a8LYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LA+wycU7o+AuUfk5Iefx+E25iJzKFXcL8XUqoIDtp6O10bLc0S1d4pQpEOBS4U2xD
	 ed+/mykcQYk2g3NA5wDHHp/vnW+H2uwK8C2cxM7JztqQK52I7Un1xWTaWOA+k6Y54A
	 kkNpPQgwqTj2PfuYga//1kx1GJzUlgg1Z8t99N3+fzb3+LqN2MHNBHrqp2LPxMUV+9
	 4FUK1snL/a1zHoVm8/mVU2vJjv1HujVMRs/3Sg+EEE8nl9D3FJsDQ2vCpyEFxsr6pM
	 S9M6eU8CPfsHlu0SyavwxqRBEBB14//gMVYkGHi+uDlLXclfVWG8/glX6nEe5aXR//
	 OIbYrOTPK0n2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB237380AA79;
	Fri, 24 Jan 2025 18:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix freplace_link segfault in tailcalls
 prog test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173774403476.2131600.9540447324487186303.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jan 2025 18:40:34 +0000
References: <20250122022838.1079157-1-wutengda@huaweicloud.com>
In-Reply-To: <20250122022838.1079157-1-wutengda@huaweicloud.com>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 hffilwlqm@gmail.com, leon.hwang@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 22 Jan 2025 10:28:38 +0800 you wrote:
> There are two bpf_link__destroy(freplace_link) calls in
> test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
> is called, if the following bpf_map_{update,delete}_elem() throws an
> exception, it will jump to the "out" label and call bpf_link__destroy()
> again, causing double free and eventually leading to a segfault.
> 
> Fix it by directly resetting freplace_link to NULL after the first
> bpf_link__destroy() call.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Fix freplace_link segfault in tailcalls prog test
    https://git.kernel.org/bpf/bpf-next/c/b420b5756549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



