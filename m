Return-Path: <bpf+bounces-54555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7314A6C483
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 21:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DC148305A
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B5230BD6;
	Fri, 21 Mar 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy20kFXo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC21E9B32;
	Fri, 21 Mar 2025 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590196; cv=none; b=gQNGkCCGgLCkxpBU+s3bw3B9QVD7SbvxuPvnsxKaNp2ylu9s+C9nQZq0AudIf120bWSsVAjXqVTXjiDeDM6Vc3Xx6SucM0jElpPkJ0wWuz+rHZWRuGZxvEwimE8lvjr83vs5iwabkBp/vtz88SPhNzShFTXvBhTo9YqoKnt8CRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590196; c=relaxed/simple;
	bh=4pTVcbAbpPt3GwfUz4JicXA/rZSw6JoJnRcoWn9i0os=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZeTCKhqLgxnXYDa/tgTECZ/WpDiZQJHMl7s5kG1JVXeXRuO/JkI0GTQ2Srnz5ZVGMVQUGyZFIiKTI7WTqYMeR+ObR3xqv2q+7i6Wv+06KbatMKUUeT1B1tEGGoUEF/gWP4OqkP+Fq7AAkTsYLhWS6RdaWJhgoxZ5W+yYRLmycsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy20kFXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726D3C4CEE3;
	Fri, 21 Mar 2025 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590195;
	bh=4pTVcbAbpPt3GwfUz4JicXA/rZSw6JoJnRcoWn9i0os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uy20kFXo1yxMM3AN+yHjY/rVmZOYlZB7th/emYhts80bkws7B9d4eeI3hRnuMeks1
	 ZUh2zPF5DuE0TS5lWaxqhNbJIMeuJ8CzwpiBUWWYO8MMa34uicX3ZfWvqg03tlkfjH
	 giikA0O3UfuS6CvBmVkXs6TI9m1F7g7i2q6yVAX+STXbxVhzVBlzyX7LhlrNQkhU8w
	 gTXGbX1iope8ZPXOZbWinj/E6fPjHK9mhdtFM2Ac3qKkS4kZ+70cuTXdx43LhDFICj
	 3COrXTmyL7wFjpDMutnucbDeFHaYsbKPgHlsnYOKwd1gsmDgjOmv2+3BXDUO4vaev1
	 8JOgWRQ6Fm4Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE603806659;
	Fri, 21 Mar 2025 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: Add namespace for errstr making it libbpf_errstr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174259023153.2618986.486989246746713342.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 20:50:31 +0000
References: <20250320222439.1350187-1-irogers@google.com>
In-Reply-To: <20250320222439.1350187-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, yatsenko@meta.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 20 Mar 2025 15:24:39 -0700 you wrote:
> When statically linking symbols can be replaced with those from other
> statically linked libraries depending on the link order and the hoped
> for "multiple definition" error may not appear. To avoid conflicts it
> is good practice to namespace symbols, this change renames errstr to
> libbpf_errstr. To avoid churn a #define is used to turn use of
> errstr(err) to libbpf_errstr(err).
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: Add namespace for errstr making it libbpf_errstr
    https://git.kernel.org/bpf/bpf-next/c/307ef667e945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



