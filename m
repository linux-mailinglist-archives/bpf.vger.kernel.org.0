Return-Path: <bpf+bounces-10816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220547AE245
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6A0732816A9
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0E262B3;
	Mon, 25 Sep 2023 23:30:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2526299
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEDD6C433C9;
	Mon, 25 Sep 2023 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695684628;
	bh=+QJWGa9Yn+lDg+pObrpr3qFK2DExYCClxMjLKpdpnEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SrKOp+0bkYl9q5pOkdW8uJ/o0qCReq/vdMXK+jmQgRvaU23iP1MwrDzoeygd+Wg3o
	 Hx226bxkDfA9hKGDrrasrKgctvhv32bk2YPBYgHmxVR53zXU9wDq9Gq70ax46/SEZb
	 3oHfwBXlUwUDacqyYObELYhgOEoBYPhyhCABfq6HaXXxfejJFU3TBicqE3PvuelBHm
	 SNS9UPemF05tO5tduUpbLK8WTLwR2so9GDxUGGgOcUo1gADNDfyCSr7Ch+hUgxg4Og
	 +ZVnmsNpuQnFXaAJNuNB9HdXKfmIvwr7/K+pW3cdZQUTIKet3T6LCUluzK2Mw1LV9k
	 3CJXSbj1s5o2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6AF6E29B00;
	Mon, 25 Sep 2023 23:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/14] add libbpf getters for individual
 ringbuffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169568462787.27399.12209367509036463797.git-patchwork-notify@kernel.org>
Date: Mon, 25 Sep 2023 23:30:27 +0000
References: <20230925215045.2375758-1-martin.kelly@crowdstrike.com>
In-Reply-To: <20230925215045.2375758-1-martin.kelly@crowdstrike.com>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 25 Sep 2023 14:50:31 -0700 you wrote:
> This patch series adds a new ring__ API to libbpf exposing getters for
> accessing the individual ringbuffers inside a struct ring_buffer. This is
> useful for polling individually, getting available data, or similar use
> cases. The API looks like this, and was roughly proposed by Andrii Nakryiko
> in another thread:
> 
> Getting a ring struct:
> struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx);
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/14] libbpf: refactor cleanup in ring_buffer__add
    https://git.kernel.org/bpf/bpf-next/c/4448f64c549c
  - [bpf-next,v2,02/14] libbpf: switch rings to array of pointers
    https://git.kernel.org/bpf/bpf-next/c/ef3b82003e6c
  - [bpf-next,v2,03/14] libbpf: add ring_buffer__ring
    https://git.kernel.org/bpf/bpf-next/c/1c97f6afd739
  - [bpf-next,v2,04/14] selftests/bpf: add tests for ring_buffer__ring
    https://git.kernel.org/bpf/bpf-next/c/c1ad2e47f97c
  - [bpf-next,v2,05/14] libbpf: add ring__producer_pos, ring__consumer_pos
    https://git.kernel.org/bpf/bpf-next/c/059a8c0c5acd
  - [bpf-next,v2,06/14] selftests/bpf: add tests for ring__*_pos
    https://git.kernel.org/bpf/bpf-next/c/b18db8712ecf
  - [bpf-next,v2,07/14] libbpf: add ring__avail_data_size
    https://git.kernel.org/bpf/bpf-next/c/3b34d2972612
  - [bpf-next,v2,08/14] selftests/bpf: add tests for ring__avail_data_size
    https://git.kernel.org/bpf/bpf-next/c/f3a01d385fbb
  - [bpf-next,v2,09/14] libbpf: add ring__size
    https://git.kernel.org/bpf/bpf-next/c/e79abf717fce
  - [bpf-next,v2,10/14] selftests/bpf: add tests for ring__size
    https://git.kernel.org/bpf/bpf-next/c/bb32dd2c8fec
  - [bpf-next,v2,11/14] libbpf: add ring__map_fd
    https://git.kernel.org/bpf/bpf-next/c/ae769390377a
  - [bpf-next,v2,12/14] selftests/bpf: add tests for ring__map_fd
    https://git.kernel.org/bpf/bpf-next/c/6e38ba5291f9
  - [bpf-next,v2,13/14] libbpf: add ring__consume
    https://git.kernel.org/bpf/bpf-next/c/16058ff28b7e
  - [bpf-next,v2,14/14] selftests/bpf: add tests for ring__consume
    https://git.kernel.org/bpf/bpf-next/c/cb3d7dd2d0db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



