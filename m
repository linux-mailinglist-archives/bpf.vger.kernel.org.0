Return-Path: <bpf+bounces-21901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53516853E80
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66721F28003
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5AA62162;
	Tue, 13 Feb 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S225Gyqw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679562152
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862827; cv=none; b=Ax4rBHoWYIEnNP4q+9HFuxa634eh4Zspf7ioHWq95jgrF8vALmaYvbsX5ViuxVPXeYnmvH+VpQPLbcvuW87zu2HlBLgzSKccnn1pjUqRS07AZu8xbQwE8rnlt1yJQ0Z8cYAD2o6GetA6C3clhjzhH4/kMgLyw/7Z3jaDOweyCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862827; c=relaxed/simple;
	bh=6ci0kmGZqH81vsIC57CPJ9mddLi/rjSlPqroFiudt5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hQLZR/CHRQDEtH9rYJffYdjmkuNkGv1dzeNY7B58mxl0ju88gFjcjXqExSUzipEIUfeH5AFgxvQxOUNfMiaJlsz9jMdeR1nqkHs7atqFhjgZHBFAcOjREXmOj2EkM7eX0WUSlMDsnnCxx/NB5mMt5CgI/TMBjIHPltCgiuD4Jbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S225Gyqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D01E1C43330;
	Tue, 13 Feb 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707862826;
	bh=6ci0kmGZqH81vsIC57CPJ9mddLi/rjSlPqroFiudt5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S225GyqwIekW/+TFYgQIlvT0XU/ubisOuc26XSEmZbXyuRYk9ivf5W3dbLEefr7ao
	 wJVEdl8LQXfHNoLauViYpsDNgUAorSzX9AyhZSMtewWGdP4dMmZ/akPvadJ+BKpJxS
	 nbcCgnR2LrhCu9Wy1UCtIcIEgfrLbzn02GPBQ/eIWiNaEOC6Kw1jZl1yj0qQRiFlUZ
	 c3eF2W7cMUS7ZRKaNQ7wDW35CtognzW+BidbFC/K4rbZ748uZMzXGjFbffbaa+cESC
	 hGrA5SzUqbNibMYlcXI0k/MM6jOKxJf4HbHlFBI0QpfGXasTpa2/PUZKTE3QeouEPz
	 rpwraVvOCXuqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC19AD84BC6;
	Tue, 13 Feb 2024 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Update ISA document title
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170786282676.9415.12501865701562959218.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 22:20:26 +0000
References: <20240208221449.12274-1-dthaler1968@gmail.com>
In-Reply-To: <20240208221449.12274-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  8 Feb 2024 14:14:49 -0800 you wrote:
> * Use "Instruction Set Architecture (ISA)" instead of "Instruction Set
>   Specification"
> * Remove version number
> 
> As previously discussed on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/SEpn3OL9TabNRn-4rDX9A6XVbjM/
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Update ISA document title
    https://git.kernel.org/bpf/bpf-next/c/dc8543b597c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



