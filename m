Return-Path: <bpf+bounces-30980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9644B8D5592
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 00:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542B6285C97
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7F1182D07;
	Thu, 30 May 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miwX9CLn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D64D8CF
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108834; cv=none; b=e/0/ArwzUw37QCX6CSK+INYn5MslZceU1WWny0tP/7PYfa3/mK4LT9dtZckIuY1JSPvG0+ZCQqBz/6rxbtsHAnV/iETmaB2PmxLVC6G3wPXD0MHFDMeLfwSnIQkcud+xXO/NswCEQ7cap+B1YXDI3vr3/XTHuCRGuWkJpk0h/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108834; c=relaxed/simple;
	bh=VKYj0SrUVfgjI4Fs0WTWSHA6VKCmeVagb0yd6MgjWd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s5IhLuAibuzWxaltalT04FG6wcrFl8caTGWqy6LTq6F1EOd0GOq7erFwklw1VRW4DurQi0RM/u5DwshcLG7Yo17D6ZKQLWsJhPkFpkYP2RxUUiK5IKLwt5uwZA8YxZ1OCDtLyBEAsiSP+IUl+RrfgUJhw4sx736twv9HoC4+Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miwX9CLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AB68C32789;
	Thu, 30 May 2024 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717108833;
	bh=VKYj0SrUVfgjI4Fs0WTWSHA6VKCmeVagb0yd6MgjWd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=miwX9CLnZ9qEoUI3qPqUxBqKtMy3IhDb2jwILh1kaByxFZD82+7SuDiUqIBrouAuz
	 +Uvhz+fmSu1sFnod4jcEhi+KG+JBZzJxKcVaMayNq9XZ1sO1rEl2eeEdTJGZB3KsAF
	 lzOk7jgR2/IYyarDJh2BnexG8m2xcKb1qwjC8u7p2ljv3Pn0xfaBl3hi2TEJUS9JwF
	 E5wZL3rlXgLmnVi15cpEv617kKXB9s47hyLgLk/QbJ7QQZP6jweDHUdsA484uirYUh
	 jjyWZ4hrF3CjdLNkUHB/4AqjucbsRy3QhGXyLyhuA192wai+5mZK4KDN7t3/0lymHa
	 WYKx9+iX7AheQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F881CF21F3;
	Thu, 30 May 2024 22:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/8] Notify user space when a struct_ops object is
 detached/unregistered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171710883332.22324.8286442445839775054.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 22:40:33 +0000
References: <20240530065946.979330-1-thinker.li@gmail.com>
In-Reply-To: <20240530065946.979330-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 29 May 2024 23:59:38 -0700 you wrote:
> From: Kui-Feng Lee <kuifeng@meta.com>
> 
> The subsystems managing struct_ops objects may need to detach a
> struct_ops object due to errors or other reasons. It would be useful
> to notify user space programs so that error recovery or logging can be
> carried out.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/8] bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
    https://git.kernel.org/bpf/bpf-next/c/73287fe22872
  - [bpf-next,v7,2/8] bpf: enable detaching links of struct_ops objects.
    https://git.kernel.org/bpf/bpf-next/c/6fb2544ea149
  - [bpf-next,v7,3/8] bpf: support epoll from bpf struct_ops links.
    https://git.kernel.org/bpf/bpf-next/c/1adddc97aa44
  - [bpf-next,v7,4/8] bpf: export bpf_link_inc_not_zero.
    https://git.kernel.org/bpf/bpf-next/c/67c3e8353f45
  - [bpf-next,v7,5/8] selftests/bpf: test struct_ops with epoll
    https://git.kernel.org/bpf/bpf-next/c/1a4b858b6a04
  - [bpf-next,v7,6/8] selftests/bpf: detach a struct_ops link from the subsystem managing it.
    (no matching commit)
  - [bpf-next,v7,7/8] selftests/bpf: make sure bpf_testmod handling racing link destroying well.
    (no matching commit)
  - [bpf-next,v7,8/8] bpftool: Change pid_iter.bpf.c to comply with the change of bpf_link_fops.
    https://git.kernel.org/bpf/bpf-next/c/d14c1fac0c97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



