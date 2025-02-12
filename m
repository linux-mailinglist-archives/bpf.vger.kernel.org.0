Return-Path: <bpf+bounces-51238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60CA32425
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F11C167635
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6121F4299;
	Wed, 12 Feb 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXbD4JaU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6351FBCAE;
	Wed, 12 Feb 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358039; cv=none; b=Doc2jVrncPurznRgC+D/8+WkZNnoihIoTOGMgGXkCzhVI9gYccAIQUNmDNwkYSoHcriUE3KbXpqqwHjHXR/Np14eddEHwj9g9gCXo+ro6eBOsHo6jbfpwJq7pYB0tFEqa76xt8kxSmV1TorT1u5KuCrq16nTGgcXKDZWcOOFAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358039; c=relaxed/simple;
	bh=E804ZwOiCTNhddYYVX+ou/FxeDAYreu1N4qFP54OhB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZhdhIOsnlBa81tAXeVyFVmt7juMAuX2+nc3spGHfXMbq2Jl/3WEV0Yt54aRNwas4BlLvXjVLb2zx3QMVyDetxdT92BsZJ+Py8kxDmGqcQP8t16O37/og08vqxV5XVfNiPxHdMqg041HmVhys74X3g7vOTaLMYNxVIZ8hZ5lvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXbD4JaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBC8C4CEDF;
	Wed, 12 Feb 2025 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739358038;
	bh=E804ZwOiCTNhddYYVX+ou/FxeDAYreu1N4qFP54OhB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZXbD4JaUtuLUGXRJYWJ7d6a9x3V5nV6A2Q82MMjQG8tC0agfnDCKw8w1TJfw5naDB
	 6mpPssTUBo25aOeunMqtZR2ygUDv+aH3XkbOY2N2e788mwfvL8asQD2kc0QJbfqRjw
	 8R8Dpvj6ncLzxCaned8JhTIXX3SQFCye+hIAYQv8+HLxbWE39EbQd6ZPlxZ90rITJ0
	 dGcXnnwo4PVyQM4CugO0b7rX7q5nFIIPZnAdtoXGQG0LorbzipY/Ti37CKHzfTlcXN
	 qY4lJt3jbHvWqpmFvmsGu0itHZdNhYe7/8qMTtZBSiuMsqZqSZsCAHY+AwKmcdf2Bj
	 gc4ZLrPT95wJw==
Message-ID: <97fd1bbb-1261-4af5-9321-27353547dbf7@kernel.org>
Date: Wed, 12 Feb 2025 11:00:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: bash-completion: Add nopasswd sudo
 prefix for bpftool
To: Rong Tao <rtoax@foxmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: rongtao@cest.ccn, Rong Tao <rongtao@cestc.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Tao Chen <chen.dylane@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>, Daniel Xu <dxu@dxuuu.xyz>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_515567355C0AA854BDA68C3A219A18040B0A@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_515567355C0AA854BDA68C3A219A18040B0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-12 18:14 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
> From: Rong Tao <rongtao@cestc.cn>
> 
> In the bpftool script of bash-completion, many bpftool commands require
> superuser privileges to execute. Otherwise, Operation not permission will
> be displayed. Here, we check whether ordinary users are exempt from
> entering the sudo password. If so, we need to add the sudo prefix to the
> bpftool command to be executed. In this way, we can obtain the correct
> command completion content instead of the wrong one.
> 
> For example, when updating array_of_maps, the wrong 'hex' is completed:
> 
>     $ sudo bpftool map update name arr_maps key 0 0 0 0 value [tab]
>     $ sudo bpftool map update name arr_maps key 0 0 0 0 value hex
> 
> However, what we need is "id name pinned". Similarly, there is the same
> problem in getting the map 'name' and 'id':
> 
>     $ sudo bpftool map show name [tab] < get nothing
>     $ sudo bpftool map show id [tab]   < get nothing
> 
> This commit fixes the issue.
> 
>     $ sudo bpftool map update name arr_maps key 0 0 0 0 value [tab]
>     id      name    pinned
> 
>     $ sudo bpftool map show name
>     arr_maps         cgroup_hash      inner_arr1       inner_arr2
> 
>     $ sudo bpftool map show id
>     11    1383  4091  4096
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Hi, thanks for the patch.

I agree it's annoying to have a partially-working completion for
non-root users, however, I don't feel very comfortable introducing calls
to "sudo" in bash completion, without the user noticing. For what it's
worth, I searched other bash completion files (from
https://github.com/scop/bash-completion/) and I can't find any of them
running sudo to help complete commands, so it doesn't seem to be
something usual in completion. I think I'd rather keep the current state
(or fix the first example to have the right keywords displayed but
without running sudo).

Quentin

