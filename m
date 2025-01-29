Return-Path: <bpf+bounces-50048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF4A2239D
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1394163CC8
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634E8F4A;
	Wed, 29 Jan 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfh+eC6O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BE18F2DD
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174203; cv=none; b=Mr17WuxOh84j5ZkclW6GH24tKIjHLJizMKH/jwNkQlRrIODcQBWartBWgC9+m5v+B7SRKJJrH9sae3tJVGr8Gh9Jr6j5eFFYKwTAU1wP+iuOeXIjIXegwmAmjJoF4M9Wa4z7ltZZfb+iDP/dyRs7eTjGL7Qk774erdVW0Ag9eu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174203; c=relaxed/simple;
	bh=02Kj2FlqL4VTFsNwI/04oPFVjcZCvO+4VkAY5puEYCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DI9jpq5+afKZfbW9ZmOy6nSnEDYk7gZTwejpqyxQZD/ARF9cPOv3btkOACO43BrhlBmMGAW3ytB9b6TGG4owLFiMXlRggXKUfhCa5OFtgIoz90SEXoGWDoP7yJnp9Ee3ZTD4DxUopPbfOI0AfK7+Ohzv3IJ7t0wbep7xFzjDvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfh+eC6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7476CC4CED1;
	Wed, 29 Jan 2025 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738174203;
	bh=02Kj2FlqL4VTFsNwI/04oPFVjcZCvO+4VkAY5puEYCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jfh+eC6OF1zeWd8fheWZb+Aj9afd6h/Q+7vPv0V/bqgwx38fNAiE+V33iiDGCwxeJ
	 EzvqoKDLWruLmw1atpNFTnsHFhLUXZ9/szZapCjVTyTMcDw5eKYZ3baJN4CT2hktM0
	 4z4zZlIoc8UlLlsXXDnzW9tX9ZpLgOM4nvf80vmEYhxQ8ZNLCaomVS8cKu0wlp3nqv
	 9g5U2qvNSzwgqRJPJDZEREf20MGT5rZWrNQnoUlYc8t/nYnCMDIeZzgnhDsSmy+ies
	 B/OhgUkaLzQ+OkEzZGG5n6Cl7HR8hVtq+lDeOwFUrlJLaxF+I5ha3KpNyXyjXfziev
	 HCb1ovTFl/IAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF104380AA66;
	Wed, 29 Jan 2025 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF
 map mmaping logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173817422952.385685.8778173092573220959.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 18:10:29 +0000
References: <20250129012246.1515826-1-andrii@kernel.org>
In-Reply-To: <20250129012246.1515826-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, jannh@google.com,
 surenb@google.com, shakeel.butt@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 28 Jan 2025 17:22:45 -0800 you wrote:
> For all BPF maps we ensure that VM_MAYWRITE is cleared when
> memory-mapping BPF map contents as initially read-only VMA. This is
> because in some cases BPF verifier relies on the underlying data to not
> be modified afterwards by user space, so once something is mapped
> read-only, it shouldn't be re-mmap'ed as read-write.
> 
> As such, it's not necessary to check VM_MAYWRITE in bpf_map_mmap() and
> map->ops->map_mmap() callbacks: VM_WRITE should be consistently set for
> read-write mappings, and if VM_WRITE is not set, there is no way for
> user space to upgrade read-only mapping to read-write one.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF map mmaping logic
    https://git.kernel.org/bpf/bpf/c/98671a0fd1f1
  - [v2,bpf-next,2/2] bpf: avoid holding freeze_mutex during mmap operation
    https://git.kernel.org/bpf/bpf/c/bc27c52eea18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



