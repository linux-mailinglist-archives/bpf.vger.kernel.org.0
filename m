Return-Path: <bpf+bounces-42084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E099F516
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4481F23EB5
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E920822B;
	Tue, 15 Oct 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiG/3AHH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AC1FC7E2
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016426; cv=none; b=KmIEiu1pY1MW5PW2eNvH4NoKB6XtLzRjit9t5Rc2eJE2QKGrGFesMtyW/XPExIHmOLZ2AFUDpLi63PMiUjhjyIde5wfCoJAaPH7QL1HQeV8sZukRcJICmqOMwOQYyPkGoYMxiFCfXDuJZAKJdJ+rc/pUV+B70BacfwWFg28u3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016426; c=relaxed/simple;
	bh=cbLJDsHTI5Ezabo6edZ4BVr+BvDxwqZAxHDrqfTSQBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OjBXPRMXbbTD7zHrucGEYPybD7qH9U2JW8oSzMloNcDD7R+DsnlH2RdyTef5ahR/OB88dKYwu9bEhF4fvuoVRTViAv+yKq/bQfB0XsU0TvG77m31LRzTI7X+0twbHh9Rl+w6NyGKOaemaRdmEmXHJ8EPS0SkHAB7OLJK6JbQBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiG/3AHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAF0C4CEC6;
	Tue, 15 Oct 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729016426;
	bh=cbLJDsHTI5Ezabo6edZ4BVr+BvDxwqZAxHDrqfTSQBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LiG/3AHHHQSjzpyKk/j84GZTv60KBapxY8Dwzg+vSpbpUU3CdnHUAZSJ3jSTbgSAr
	 7iPBcta1Y0FTfY2h9545NOR6PrN1kDz9Kz+5t7JvXUj8osFVya7XSNZOIpa4oXaeXW
	 cctfmzh/uQ4z7beWQF4o6qfMAld12W3BoM6NLv1XedAtUszE099SOEMNGOTXJdw+6s
	 WK7emgnJYZJPe6FziUfFVWKWWAijaQak/l6sDJyno3dGq82JkIYbFmTfvo2Zm/ZSXs
	 sJ1P9mjeq/PILWry4gEwlt3Lq8m053KhZESkereOGelTozJur6PskYctBWODvt3hxB
	 mzYv+3Md+EHVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712D13809A8A;
	Tue, 15 Oct 2024 18:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Fix truncation bug in coerce_reg_to_size_sx and extend
 selftests.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901643126.1249541.11136986610048236488.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:20:31 +0000
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
In-Reply-To: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 14 Oct 2024 15:11:52 +0300 you wrote:
> This patch series addresses a truncation bug in the eBPF verifier function
> coerce_reg_to_size_sx(). The issue was caused by the incorrect ordering
> of assignments between 32-bit and 64-bit min/max values, leading to
> improper truncation when updating the register state. This issue has been
> reported previously by Zac Ecob[1] , but was not followed up on.
> 
> The first patch fixes the assignment order in coerce_reg_to_size_sx()
> to ensure correct truncation. The subsequent patches add selftests for
> coerce_{reg,subreg}_to_size_sx.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] bpf: Fix truncation bug in coerce_reg_to_size_sx()
    https://git.kernel.org/bpf/bpf/c/ae67b9fb8c4e
  - [v2,2/3] selftests/bpf: Add test for truncation after sign extension in coerce_reg_to_size_sx()
    https://git.kernel.org/bpf/bpf/c/61f506eacc77
  - [v2,3/3] selftests/bpf: Add test for sign extension in coerce_subreg_to_size_sx()
    https://git.kernel.org/bpf/bpf/c/35ccd576a23c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



