Return-Path: <bpf+bounces-9575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47687992E2
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E3281CB3
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A64747B;
	Fri,  8 Sep 2023 23:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74031FBF
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68152C433C9;
	Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694216423;
	bh=7x+zgJcMuRS5ceYgLeya9fl6w+RvP4GvAReh/ywu2fI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rkwBZsE1M+/dQs8+X4agh8822ozMIg4EBGE4283es0cfbBei6RTAnDdVCG4dvLv6K
	 D4QXumR+7umt5D1yh7wJdjoM1Uxyhhdp/MU+8usCGWH5OTtf3yYLcCsuoQFAiMN6XG
	 +ef1xASDLTcmf6muCkj2HlolKzEzBoDg1o4i3EbDtio3N/XLaxXuipvS56ihhcwJeX
	 kK/SW8AWj2JPapUidE2gOEULpCQmkWRUMWbTogLXy+jxcAkZxDk73a4KSoztwlBnky
	 4o3v8T6IkMP8aDpETHaRLa/OaAlLbVawMVqk1iu3kKdhrWw5WZBElClNsdj6fn0kAj
	 CCKl9kzLRDCCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51C95E53807;
	Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool: fix -Wcast-qual warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169421642333.339.16003950712941590631.git-patchwork-notify@kernel.org>
Date: Fri, 08 Sep 2023 23:40:23 +0000
References: <20230907090210.968612-1-dzagorui@cisco.com>
In-Reply-To: <20230907090210.968612-1-dzagorui@cisco.com>
To: Denys Zagorui <dzagorui@cisco.com>
Cc: alastorze@fb.com, quentin@isovalent.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Sep 2023 02:02:10 -0700 you wrote:
> This cast was made by purpose for older libbpf where the
> bpf_object_skeleton field is void * instead of const void *
> to eliminate a warning (as i understand
> -Wincompatible-pointer-types-discards-qualifiers) but this
> cast introduces another warning (-Wcast-qual) for libbpf
> where data field is const void *
> 
> [...]

Here is the summary with links:
  - [v2] bpftool: fix -Wcast-qual warning
    https://git.kernel.org/bpf/bpf-next/c/52f8e1648394

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



