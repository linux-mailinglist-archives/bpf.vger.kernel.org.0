Return-Path: <bpf+bounces-44813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E59C7E1B
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 23:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B584AB23196
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887618BC29;
	Wed, 13 Nov 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goYZeEUj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132418BC0A
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535820; cv=none; b=e6ORRvjaklhsrKUOJstA5t2/8UtqDa1DeqWJ9rYH3K2k0m/9go03ZPkCCzjyMHbbS8YZ7JfpAoJ/iLsGkJ2CzDk9eLtp8mMors0U16xPis2XPoiOlhwKsnualJCIijw/yXLUm+n0cN9QICp29pqv/f9fZxXieA6hh+SgWCTH+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535820; c=relaxed/simple;
	bh=rCaaVXQ2ZW6hS2Zexv0+zr1TJBSnp3TwpNGBcPSQ8lQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZjpebiZ5rBeTHIQ2jWyCKzZvRgIN6yAqwWjsd+VM2tqVdThDkuIMBqrDFiTy4g+H5qRkMwWgBcKTDI4SWY/7PFhm0vjZJIjF3+ukfVtZbSnj8g4Te72C/ClyWPHOPsK2GANlJrSUmwaFh0o0CcA3u6jvBmJThkZdWjRI6ZIy75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goYZeEUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9F3C4CEC3;
	Wed, 13 Nov 2024 22:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731535820;
	bh=rCaaVXQ2ZW6hS2Zexv0+zr1TJBSnp3TwpNGBcPSQ8lQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=goYZeEUjYVX7xqSRM8ejaXFY2VDv1E77bfyx8YcQQAKbIZ+5fyePWCKaNUyacCC2u
	 QpyVJWjPHH5zd0MBEyfh3avy0g7wh8dcAS6tBDpacylTKcnkNV/HjFPvysayci9RTg
	 1Y7yOhJ9zgin+UuVJNWJpfXr5DveFRWzT2RsMyln4kHbc+lPiYrzIQvFntRdGXIr5K
	 iCdtQbYuOhbM0aLSjcJY9PwoBLrFrER0CkTTq/qkFIs04rkoScpFewGzs8YQSF5/r5
	 jzJ1DPblN5WjD5pVqEJhbnma6xpJ1pIxvks/PmRZbT0lOCW9uXwjX/hxOzNcSo3hIq
	 mmLm8lUzb7LBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE523809A80;
	Wed, 13 Nov 2024 22:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: range_tree for bpf arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173153583051.1401626.15655930364697861908.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 22:10:30 +0000
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 djwong@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Nov 2024 18:56:14 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce range_tree (internval tree plus rbtree) to track
> unallocated ranges in bpf arena and replace maple_tree with it.
> This is a step towards making bpf_arena|free_alloc_pages non-sleepable.
> The previous approach to reuse drm_mm to replace maple_tree reached
> dead end, since sizeof(struct drm_mm_node) = 168 and
> sizeof(struct maple_node) = 256 while
> sizeof(struct range_node) = 64 introduced in this patch.
> Not only it's smaller, but the algorithm splits and merges
> adjacent ranges. Ultimate performance doesn't matter.
> The main objective of range_tree is to work in context
> where kmalloc/kfree are not safe. It achieves that via bpf_mem_alloc.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Introduce range_tree data structure and use it in bpf arena
    https://git.kernel.org/bpf/bpf-next/c/b795379757eb
  - [bpf-next,2/2] selftests/bpf: Add a test for arena range tree algorithm
    https://git.kernel.org/bpf/bpf-next/c/e58358afa84e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



