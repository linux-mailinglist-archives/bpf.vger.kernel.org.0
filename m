Return-Path: <bpf+bounces-19915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B783304A
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CB32864EC
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F05789B;
	Fri, 19 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScgvC17l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03B1DFCB
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699828; cv=none; b=ivAzkVfnaL+uFmL/LsCWc25EyFiebkj6gYKy/QVbIu9VP09B7kUllTfAn8CC4h0uvB0zB/kVWWwJX6gyJ3j7jZq+9OK5knKNr7KX7KQIUjypiuWps3nbEeXId0C39E918KQVOEg9zWZIykCf146ts+vtPOLQ9LqlKarTTHhLi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699828; c=relaxed/simple;
	bh=S84juUtYF9jxV7yGY5zfhygbYFJwJDw42tabM00zU3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h40W5c6mHJ3JXsIU+sulb83B+E8I0rzU7pJiittBS7MMgIHyPklWzXFizraM0pq0d1Pr8hWIY9eMfL+9b4Pb6k5FKxSGn4ZNDa9286wUs9mKiKMaCoCW+YaE9gk6RWzEtJNbSCsBbrXerItBU2G0fEUi3r6K5EJylIXBI9hgcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScgvC17l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37CDDC43390;
	Fri, 19 Jan 2024 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699827;
	bh=S84juUtYF9jxV7yGY5zfhygbYFJwJDw42tabM00zU3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ScgvC17lpJjeAVG17fUreqVcVwfrF7QHA9o3X4NLwFsLzf1sJk5QSiXpoHScb3rce
	 quSP964lT4L4jFjRArqq2Rb4OL7WiPdcpOpJ36IllVVOMR0HORL5Jp5IsilUcVEeK/
	 t7aSmBn+XIhHRzul48yYTRC9v4pffC838xZpN4LlDr3CswCBONl8zosCNxwtAx0H1B
	 MQ5MLTIySMEXmft+IHzdGvphZJ2nmwZHrFpxniuRxR9+zkcREBLmHaTc586FuP2evs
	 /pt7tnXKwAGcz7yTp/+UaQv0pLP0Gs87qBQhO7FA/+sjZI350EC0m2kcooDmVdjWsj
	 ekBfw3JUiIyGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17D0DD8C985;
	Fri, 19 Jan 2024 21:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 1/2] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170569982709.24319.16024123262665382181.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jan 2024 21:30:27 +0000
References: <20240117130619.9403-1-conquistador@yandex-team.ru>
In-Reply-To: <20240117130619.9403-1-conquistador@yandex-team.ru>
To: Andrey Grafin <conquistador@yandex-team.ru>
Cc: bpf@vger.kernel.org, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 17 Jan 2024 16:06:18 +0300 you wrote:
> This patch allows to auto create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY
> by bpf_object__load().
> 
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/2] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
    https://git.kernel.org/bpf/bpf-next/c/683ed8edd0c7
  - [bpf,v5,2/2] selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY values
    https://git.kernel.org/bpf/bpf-next/c/9d1a26e7e43c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



