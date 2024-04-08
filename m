Return-Path: <bpf+bounces-26199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEFE89C917
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1537428738F
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED131428FD;
	Mon,  8 Apr 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lt0cw3ly"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54021422C6
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591750; cv=none; b=pX/sJ019Ktwu5rd9DHgLiRe+VwwsE1vuM6VBeExm7RzxEfF+BMJubjnvZs/xFZrQtYIt140AUvT+UawdWUbG0cEIxGbNSRfsDpadRcD3OigO1X0fQNpfkCJJz0pSlm2CcpCExfTxTdHHLSRKeWcBsbSspEAsFLbWnhHa3EwADLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591750; c=relaxed/simple;
	bh=zqADHLr4EY/EAx3DE/mqSZnQVLiRxCcE2lbCRkeKNvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF9MMHgezYBG7/VZHcZfZjKL70Fn1drZmmkFPfJpTYSf5S3V2TNMdb7G7Vx3ox9eFZh/1aKxHwrj4FC24vsyuHF2q+5qPbM46JSjBkF58GB410kYYFjXjuSm6TCwZkCOYH/OMYVtJ4VdSFcI1fqXhh2ZhPXAIiEInKOBPEMZ9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lt0cw3ly; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53d74f8b-6c3b-4486-9ebd-8d934d05def1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712591746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1frtsh0j0ZkvlwOfgeUPcyDzLBEBc8llklyMJfKmSCw=;
	b=lt0cw3lyx0R1w74upPNzJTGGLysim/E5zVACi2m+sam8kofOHtdrPQ7iN+iQ/uMszKV6M1
	1fH/qWEEoPXvEuns7th/OMGsNdqcPoNmcCFGsv3xGsE0z+kP1/zeM5MGwaJiMbOUM7TKB6
	Di8LGCFcZvvP2fTXyllPXqelL7y34oE=
Date: Mon, 8 Apr 2024 08:55:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Fix umount cgroup2 error
 in test_sockmap
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev
References: <cover.1712539403.git.tanggeliang@kylinos.cn>
 <5dcde0bcff8d37a5ffe61dbd51848385ddaf2951.1712539403.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5dcde0bcff8d37a5ffe61dbd51848385ddaf2951.1712539403.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/7/24 6:36 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch fixes the following "umount cgroup2" error in test_sockmap.c:
>
>   (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
>
> Cgroup fd cg_fd should be closed before cleanup_cgroup_environment().
>
> Fixes: 13a5f3ffd202 ("bpf: Selftests, sockmap test prog run without setting cgroup")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


