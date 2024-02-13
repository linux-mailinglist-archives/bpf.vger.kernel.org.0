Return-Path: <bpf+bounces-21876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB3853AC3
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BD928C51A
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323255812E;
	Tue, 13 Feb 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJt7xUmD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07EA1E49E
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852027; cv=none; b=qhtf5aEwo47NDZ8WoVaAQTTOeK5Q+inbzpW2P9OgMWuPtX/YLVFN0RnKwsw1S4nWf8GaYvJPQObRczM7xISBruZys1GqHyJcBxTsRpnQpoKShTN5EnJlvpkjw6IYaAAD23/H+X1PNiJHIOgzZLNcjgKp0LTXL6LIAk8jniQDgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852027; c=relaxed/simple;
	bh=XrZ94hEVO1rXznR8XLhbcmrQybdXg0CuNo210NnrycE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DKQMx9R/V44MgbRAET2xzbo9CF3px/IZsisIbd5ZCWv4SkdSHXxq6+cP1cpEXGmxdVMkeFPKT867szZhF3PX7qZqvkXukf/SkHquqvVduCoadc13+H3ktToF+4iHZnbdkKnmutFdd4r3Ytu1t5x981pKVe0EioAj5Kh2+WtLA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJt7xUmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44E72C43394;
	Tue, 13 Feb 2024 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852027;
	bh=XrZ94hEVO1rXznR8XLhbcmrQybdXg0CuNo210NnrycE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rJt7xUmDaAb1ieZ5+2UKBeU1uWIRdmLj/9IWXUxrFYt1gBeLax5M5Khi7GdnM3Fvf
	 +m5QGLk8yowQTOtp5POMaZRUGu0S+fEnwbEQcF32w4NWVCgjMI4T56QCOeFz2wc7tq
	 gFB2ZUuulhVwUpWbe8wP6LRYoKOrTnvQ1PP0sftoUvf+zCfXKWGYtpgOfHtS+hUfVn
	 JHY+S0aOYOdnhwYo1SZX1Lf/8FJzFS/2iyHkmaB10KTNEuWWKmzFyCxQ7hiXxp8kcd
	 TCEV1vbJIxJXhhj0Dw2LhUMbSet12ibH1YVQNcDycdMx8/8eLSSxEOl63SEsYCMEUV
	 dxX5Q6wBHerwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3344DD84BC6;
	Tue, 13 Feb 2024 19:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Mark bpf_spin_{lock,unlock}() helpers with
 notrace correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170785202720.2905.2685198088994571510.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 19:20:27 +0000
References: <20240207070102.335167-1-yonghong.song@linux.dev>
In-Reply-To: <20240207070102.335167-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 sidchintamaneni@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  6 Feb 2024 23:01:02 -0800 you wrote:
> Currently tracing is supposed not to allow for bpf_spin_{lock,unlock}()
> helper calls. This is to prevent deadlock for the following cases:
>   - there is a prog (prog-A) calling bpf_spin_{lock,unlock}().
>   - there is a tracing program (prog-B), e.g., fentry, attached
>     to bpf_spin_lock() and/or bpf_spin_unlock().
>   - prog-B calls bpf_spin_{lock,unlock}().
> For such a case, when prog-A calls bpf_spin_{lock,unlock}(),
> a deadlock will happen.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly
    https://git.kernel.org/bpf/bpf-next/c/178c54666f9c
  - [bpf-next,2/2] selftests/bpf: Ensure fentry prog cannot attach to bpf_spin_{lock,unlcok}()
    https://git.kernel.org/bpf/bpf-next/c/fc1c9e40da37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



