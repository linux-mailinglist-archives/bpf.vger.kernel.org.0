Return-Path: <bpf+bounces-57063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE8AA5137
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972CA1BC5403
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1D261362;
	Wed, 30 Apr 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLqSWI6S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D007405A
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029390; cv=none; b=Jzmr+aWOhnzm8/6ja1TQPvUL2auJ3GSWr+UM4DXhLmyL3LyuVMlu42CVdL6ZWJ32OocRcU1WvBSRghIdNTpf03VlNax+OpFbA6CvNlvoGcOZ5+RZW3B06aBx4EdueXZvKhXXV1yVYwa1wrMGb1ahcCdhMlJI0XHRULJErL7sYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029390; c=relaxed/simple;
	bh=tYNUtwxN5fQIIYZq3wyzl6dkUxVehWiKsHOP9GcEkA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kS9rEqTDG5PWZ05YwoEzcDGgUOP5aE/C2tMwuLD6WTsuf4BNzcz9QNU6HcxPTN9JM5uD95fWb2ujdyqBeE5S3Cuhm/L8bQIzRNMX4GI1PV7oflU6uXth4wRNGwYMPsp3VQWUtgq/B5C3unmusP5cTT33814Nl9BOqMXYiNwffi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLqSWI6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F740C4CEE7;
	Wed, 30 Apr 2025 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746029389;
	bh=tYNUtwxN5fQIIYZq3wyzl6dkUxVehWiKsHOP9GcEkA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oLqSWI6SgE8f2mhpjhfLM3jQa/q7ilK3wjKRD7ezQj0ESpvZ2X3J6mRS5XovvkAAk
	 9fSuxYm9tH9PfU6FIfLVaVIbWUoaQu1Y4WLZvcb6CIC8kgl4tU7XYH9dPt86ETEyyP
	 8deSTdw1oSDfsfUJodHmGXsUayspbrLzJh8GTMLWiHKr+ZuxJW3JKpwofpAwu44jJ2
	 iZIf3DrvaE6gn6s0rv+Q8v4bKLIy+WCeRKUNdzzWyrS43n/BFz2yrWNozIE+W/DX4L
	 dbDbDsrC+o9Hhgfr7hM0Cy/s8qKwXzpQWVSbR/sfiURJGtNaGJJ8Tjdstsiw5VeZHk
	 mTTx7zInFZDAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4A39D60B9;
	Wed, 30 Apr 2025 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf] libbpf: use proper errno value in linker
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174602942850.2409708.4282627918282442847.git-patchwork-notify@kernel.org>
Date: Wed, 30 Apr 2025 16:10:28 +0000
References: <20250430120820.2262053-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250430120820.2262053-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 30 Apr 2025 12:08:20 +0000 you wrote:
> Return values of the linker_append_sec_data() and the
> linker_append_elf_relos() functions are propagated all the
> way up to users of libbpf API. In some error cases these
> functions return -1 which will be seen as -EPERM from user's
> point of view. Instead, return a more reasonable -EINVAL.
> 
> Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v1,bpf] libbpf: use proper errno value in linker
    https://git.kernel.org/bpf/bpf-next/c/358b1c0f56eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



