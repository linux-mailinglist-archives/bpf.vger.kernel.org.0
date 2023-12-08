Return-Path: <bpf+bounces-17207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB6680AAFB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1912F1C20853
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04EE3B2BF;
	Fri,  8 Dec 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl+aUEkG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440FC39ACC
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 17:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B00FEC433C9;
	Fri,  8 Dec 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702057223;
	bh=QWhvnecDQHsSaXh1TXP016NGyva6puMd5hngwy14e1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gl+aUEkGPwTZV9V8E7sXAPFMgVXZdNBzTUASVKUbdAwvD1NO8NBvvjRYx2fAUxjN9
	 exjo+hOzkBII5sUkYzXgvQLFBs+Yp1u5TznvFoyRe381Z8y7jxmfP8de0OLsq61usY
	 Us5t/vAq6TubNMrtkY7yd94vO/q81fbVGCVxojvD2G3RHS+uY02eMupLaglp+gkWhE
	 en0sX2G4QTvNoqaqSTNrYkwEpVNLX83c/XOcajTPrIkdWIwyfCNuV9TGJHK3Q2T9oy
	 Nzk4a9O9ZWof9u1qELuyV8MNRIWVGzkM8nwYJgHEolwYcxhB3cCZUOeNFRNqtiLVVG
	 sWH4O7T4JKf2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96EC6C04E24;
	Fri,  8 Dec 2023 17:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Load vmlinux btf for any struct_ops map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170205722361.30055.15108519957098973880.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 17:40:23 +0000
References: <20231208061704.400463-1-void@manifault.com>
In-Reply-To: <20231208061704.400463-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  8 Dec 2023 00:17:03 -0600 you wrote:
> In libbpf, when determining whether we need to load vmlinux btf, we're
> currently (among other things) checking whether there is any struct_ops
> program present in the object. This works for most realistic struct_ops
> maps, as a struct_ops map is of course typically composed of one or more
> struct_ops programs. However, that technically need not be the case. A
> struct_ops interface could be defined which allows a map to be specified
> which one or more non-prog fields, and which provides default behavior
> if no struct_ops progs is actually provided otherwise. For sched_ext,
> for example, you technically only need to specify the name of the
> scheduler in the struct_ops map, with the core scheduler logic providing
> default behavior if no prog is actually specified.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Load vmlinux btf for any struct_ops map
    https://git.kernel.org/bpf/bpf-next/c/8b7b0e5fe47d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



