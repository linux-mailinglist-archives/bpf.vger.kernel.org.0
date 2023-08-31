Return-Path: <bpf+bounces-9048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B921078ECAE
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA36C1C20AC9
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69769111BF;
	Thu, 31 Aug 2023 12:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9F111BB;
	Thu, 31 Aug 2023 12:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B193EC433C7;
	Thu, 31 Aug 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693483223;
	bh=fQuCc+pT8AFDqLlZJ9XoMzF8snrZ0LhmySkKQUntOls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OMOGH7e7firZvdmnxf6Qxbb152CYEpdg7uMNtuLnyeNYzxI4R1HSW3N/0kIMrKK2K
	 NpEjpkPERWaQOn+nChQYn6o8S/7ciJaBsSlBkt0OzuhXYuSg4uIw5hpvgWsEefTyu2
	 Qohz+q4/MHZG3+/j6nrEfaNUBMhXNeLttmCspzSTLv8N7e76y6drDHc09OS++zAEtf
	 761k02erJppcGisbozdJtT434J98ELlb6pKPc5B0IhvCslYBgAVbhCVp5fLejIC9rm
	 OYaRJCyBGESW0tmGjgIEUOYuZ2YO1838flrptqqh3Qmh5595H5EvMe2QpPIDFZuB/1
	 csNNXzwMQGkcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92FDAC595D2;
	Thu, 31 Aug 2023 12:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Fix invalid escape sequence warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169348322359.7795.11591685845254219512.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 12:00:23 +0000
References: <20230829074931.2511204-1-vishalc@linux.ibm.com>
In-Reply-To: <20230829074931.2511204-1-vishalc@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 quentin@isovalent.com, sachinp@linux.ibm.com, sdf@google.com,
 song@kernel.org, srikar@linux.vnet.ibm.com, yhs@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 29 Aug 2023 13:19:31 +0530 you wrote:
> The script bpf_doc.py generates multiple SyntaxWarnings related to invalid
> escape sequences when executed with Python 3.12. These warnings do not appear in
> Python 3.10 and 3.11 and do not affect the kernel build, which completes
> successfully.
> 
> This patch resolves these SyntaxWarnings by converting the relevant string
> literals to raw strings or by escaping backslashes. This ensures that
> backslashes are interpreted as literal characters, eliminating the warnings.
> 
> [...]

Here is the summary with links:
  - [v2] Fix invalid escape sequence warnings
    https://git.kernel.org/bpf/bpf/c/121fd33bf2d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



