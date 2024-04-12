Return-Path: <bpf+bounces-26631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864168A33E6
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C92C1F2297D
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C91272AC;
	Fri, 12 Apr 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4bCriT7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7D148FEE
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939430; cv=none; b=SWMZbYU33I8sZKDZ42es7MTOT8aYi/wrYXRulFtlsl7m36nA2xsKD+1lFhY5dU4ilU1hmtOnyEWWnBaACdz0fEo27VTel7DtrWKNwVsSY55qKbURKXQyrjKPu0/VLjm0Saa40V2ONGgrk1ArwYCq69L9aRfPK6WgTkzfLr6u14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939430; c=relaxed/simple;
	bh=GBqDykzsXh8LWqcjx851NUcmQEAJ4tw2l2CLsC7bo6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hQfvb1K+xZJxtMCm5uYiQZDuMjaP+4FpxVo1VWjPkmsE1O/UQojnr1lSbvSUhSj0CckxO7WOybsjLc2ABXxeq8KJqjRNpcib0M3+toKcy96lljl0LhfvY6856ohPQ1yPJYpmvLY5mGfG6DCL2OtioD6Qzxcnxi6oSYUi4bdDw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4bCriT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 847A6C3277B;
	Fri, 12 Apr 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712939429;
	bh=GBqDykzsXh8LWqcjx851NUcmQEAJ4tw2l2CLsC7bo6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W4bCriT7CvNNlZMa1Go4v05LyRyZ8sKYHhNjDVbWqE/N2laUFYRMleJz+KI1bFk/Q
	 iO/ZNGNoBZq9M2eoCI/pTGT+X5DOMx42AS5T7K9GxtUkPjHmJY/jEsHndJNoYYXtnb
	 cF+WtxzrKMw1e2OQNZxSzoX+X1Bx8wKMlHUR+MlPK+Bq1fK8xT/NjEKek1D2KX3zG2
	 pdNR2aEtVLpVKY+T0jfgAu042W+/Zn+5P2FUUSoQZHITFnZT3lhFfcmYpBoCVgNZHS
	 HuoEZzSy5mT5pwwSs/2fv8oyvI4TB2vsnqP+nMdBmafVzC40F58eXBZ6fxIVxWv3Ev
	 K0Nlv9hRh23/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69FE4DF7858;
	Fri, 12 Apr 2024 16:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Add read_trace_pipe_iter function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171293942943.17408.3914468039382649967.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 16:30:29 +0000
References: <20240410140952.292261-1-jolsa@kernel.org>
In-Reply-To: <20240410140952.292261-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 10 Apr 2024 16:09:52 +0200 you wrote:
> We have two printk tests reading trace_pipe in non blocking way,
> with the very same code. Moving that in new read_trace_pipe_iter
> function.
> 
> Current read_trace_pipe is used from sampless/bpf and needs to
> do blocking read and printf of the trace_pipe data, using new
> read_trace_pipe_iter to implement that.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] selftests/bpf: Add read_trace_pipe_iter function
    https://git.kernel.org/bpf/bpf-next/c/4d4992ff5876

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



