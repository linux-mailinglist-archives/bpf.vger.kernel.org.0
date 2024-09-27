Return-Path: <bpf+bounces-40432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A32988B59
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A723D1F20F71
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166181C2DB2;
	Fri, 27 Sep 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpM0Va7t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF3381B1;
	Fri, 27 Sep 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469628; cv=none; b=QRqzZQSSbU35nW7YelnXNFo2pd+5Vva/n6lzdfw/wtte+o2spAWlpVLa8Ib0BK/Vi9WokMrhic6hphwy/wlj/0N/d4GMk3ZPlwG+86KF7keFPNv87+O+M78KyXVh5AVL6Bl2yJ8f0/URyLuvWRnuphNlw1pniknRpbtP/+tTJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469628; c=relaxed/simple;
	bh=3mCX7ui67Z5+JH8T/lQuFK4+Zm9TpnQ1PDbS8lWu17U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AIdhBlOP32vs3KCcRqI/3O9k7AXG8E8RGr1j+2i9RWd+HUhmgshnyDGETJV26mU69cZ7rkdf49BJgr/CHChrepU38kZtXsu5ExoEUaP22lnU0O1qiCSlHU3zFxWN9bYp0dEUh1veZ9VmoGJb/OE9DPwhILP4ouj+jPK52wSJrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpM0Va7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C81DC4CEC4;
	Fri, 27 Sep 2024 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727469628;
	bh=3mCX7ui67Z5+JH8T/lQuFK4+Zm9TpnQ1PDbS8lWu17U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JpM0Va7tlFB9Mk9PZp5aQcE7v1rpoJ35d9b0VHMAwEW+W9UtbyDUhTWdxrcqH7TPy
	 2jDFW/L/YYWziccIWsxiRTl6uHlH/uizbxcAKuj6Yw8b9v2Ljzz5I6cmNYrAGWAM/+
	 wUinWlNYTxYk+VtQjSQ4Fe3WAFi1YLQlijg5br2lIFprWQU5on18L9K/RMQsZiHLSB
	 ZpnrISvemoRO6IIdL3eeazcVE2skPqWr5F0HjV/82nhn/UrQKKzA7Zkx4VmPnsEVa/
	 SyU/FB9AdYqyVxPE1VgCwL3ovZ8heLDpZnP1Dd/81u4I4svt4HBz+0jzXkAWwsZXCN
	 7xxmQ28CScNKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB32E3809A80;
	Fri, 27 Sep 2024 20:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] libbpf: Fix expected_attach_type set when kernel
 not support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172746963079.2077014.1104287797507537674.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 20:40:30 +0000
References: <20240925153012.212866-1-chen.dylane@gmail.com>
In-Reply-To: <20240925153012.212866-1-chen.dylane@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 25 Sep 2024 23:30:12 +0800 you wrote:
> The commit "5902da6d8a52" set expected_attach_type again with
> field of bpf_program after libbpf_prepare_prog_load, which makes
> expected_attach_type = 0 no sense when kernel not support the
> attach_type feature, so fix it.
> 
> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] libbpf: Fix expected_attach_type set when kernel not support
    https://git.kernel.org/bpf/bpf-next/c/c51003e23373

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



