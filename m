Return-Path: <bpf+bounces-57380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE57AA9E2C
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6062C16E022
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F1C27467A;
	Mon,  5 May 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbNP2go3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C927465A;
	Mon,  5 May 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480592; cv=none; b=sIDzEofbWft5kazTpciXrAKs05NfL1KBf3JBzPRprUdycQfaJvh2xgWT3BIhOozFyA5f2n63SNEt2l8b2ISypvsjkKDYB3qjQaIDhYU8wq4TWhA13/CcNBVN53kqkuP2hLDrhvZj5U7s8uTC24DxbuBIjVw9VfkNGiExS5vbJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480592; c=relaxed/simple;
	bh=/Ain24s739aGvnZz4WCmIN8M9wK3tBJPtL2EuL9Rocw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LWVis9zaq6hGzkGbQbqUmZhyYi9+H+wuos0zi2CLOs7n3W4dSFIBfbHaH8EDVE906QfuwjkNxpFQ1FbTjxciDDA8hzFpVb9EOu5JzsxoFo1orQ5T8gVwd6K2TmYqdcB6VamzpKsbya1IIyznSdlDWaZ5flg7uzO6O7nxbWWmg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbNP2go3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AB3C4CEE4;
	Mon,  5 May 2025 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746480592;
	bh=/Ain24s739aGvnZz4WCmIN8M9wK3tBJPtL2EuL9Rocw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YbNP2go344+igjigYBmVrFFPb/jaH7sau9r8GCvfvkYfFTXIlZOZ+/UWLNk9V/2R7
	 4acG4be9+eLtEIEIiYVXeYCoYRluR5Oy7J/pukSrCNNJrXNwtV2B3B2VVOmeLZVuvS
	 W7cSXpYyumrLGCnDpf9y+lQha7U2NQ2lEptsAtRgwyuxrsEe/aU9b4ZgaTc1fP6VB7
	 3B6Tghh4Pdhg3sQqKXEV/c+N4ZkyTEC1HfCcIZzmgz5YzPt60iegFFccyRZfHhYEiY
	 OddBE0lMpXxhDCSoc70ay7DnJCQjENJnSx1k6VZhDUO6XX5/CA7ubD3r5eKfRV5v8S
	 8999h0yG6vpBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDA39D60BC;
	Mon,  5 May 2025 21:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Replace offsetof() with struct_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648063174.894801.9510082135983077383.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 21:30:31 +0000
References: <20250503151513.343931-2-thorsten.blum@linux.dev>
In-Reply-To: <20250503151513.343931-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  3 May 2025 17:15:13 +0200 you wrote:
> Compared to offsetof(), struct_size() provides additional compile-time
> checks for structs with flexible arrays (e.g., __must_be_array()).
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Replace offsetof() with struct_size()
    https://git.kernel.org/bpf/bpf-next/c/41948afcf503

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



