Return-Path: <bpf+bounces-41175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBB993D7C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74D7B22B6B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4613B1AC;
	Tue,  8 Oct 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDg7saFI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BB224CC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358224; cv=none; b=QgFv8T8OYkPOdCeFc7mV/uvfSXZqMr+Tzjk+LPO9+2Dn+CSCkuIk9aUJJ4IHRcl4l7rjQkte4vn/AsGHS5aFtL8DFccL6VpLzXhrOGZbQ6ZSuGsuS1wXSatqqtdezykjLHzSXmfyP1OIUUj25MceKeUWo6zxZ4mQncivxch6iR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358224; c=relaxed/simple;
	bh=6c7u9LG5xuz0iIlJ3yE4oFEbosC+FjaaVuH97GIBwpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cC2tzWFjw4x/PD9RCbvKGU7Ss3DjFLfbiAI8Sd8StPcDfKVCRBUYUBrtxECPwl/mnHCwIafFrlsv2BB+EcLc8LCaKVid+Z8RIPq17UCzFMtYSgpJSWbUL4oG1dS0BQBO2VSQeg/EjEf7DYvE1IcO5inuJ4t2Qmuuq9JaSQwxUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDg7saFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F80C4CEC6;
	Tue,  8 Oct 2024 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728358223;
	bh=6c7u9LG5xuz0iIlJ3yE4oFEbosC+FjaaVuH97GIBwpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qDg7saFIU65zP37oINjq8LjgCYxOViHfK5uj7cYZZEWfg/xDzz1y6UU2KjbkAD/aF
	 rOCBmENjWUriyUssb9BQ8cQyNd5Yah32fWrq7fdIaycZIS+Rc1Q/+2NmfIuA72b14Q
	 S5uMj/JjUglsBIWJac6/uvA9pxWkP4c4+oiqr79g1qAejx5eHI7M90b3EdvrzTaY3G
	 7EX69axh/E/RmP1lMtaaKeNpFFEjNP482IqIIrCQqwT/MUK26H/sWT9AWvhD3/vFvs
	 O8XIPWh9OGkKJvvWGkjolpL8RUuVBt0l6nuHLg0sMInye8UEFcGoeatcSVget9e9xp
	 02OyJCTCw1M1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF253803262;
	Tue,  8 Oct 2024 03:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix memory leak in bpf_core_apply
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835822751.66789.10421461733550414199.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 03:30:27 +0000
References: <20241007160958.607434-1-jolsa@kernel.org>
In-Reply-To: <20241007160958.607434-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org, sdf@fomichev.me,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  7 Oct 2024 18:09:58 +0200 you wrote:
> We need to free specs properly.
> 
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 3d2786d65aaa ("bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf] bpf: Fix memory leak in bpf_core_apply
    https://git.kernel.org/bpf/bpf/c/45126b155e3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



