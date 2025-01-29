Return-Path: <bpf+bounces-50074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A1A226C5
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8DB16354A
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32561E32D3;
	Wed, 29 Jan 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/ZbAR/H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF81D6DC5
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192509; cv=none; b=lkeoHQYwNxTkBrQDuZC5TqTORQQbWrd3dRPITwZnRp7ZCqyjCacZrOqNIGpRj/qH5biuAVjfzUbMLuaPLT4fdpWBCIE0JJXEavQc9w8cO0Mrf8SOUDnGcu9kjrV1nxDMcR59XQAX65sKo9TlNKx5JsXbj8cqJCeRlBc9raoOn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192509; c=relaxed/simple;
	bh=cBJ8PxMcIwEKwl7X0NV5hUIWYkaTtpL/IAwWeTn1h54=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hVeB4bfvjsJq+b+OTY02dh1l3X5pRMuXhCNBODixG32Zs1i935dNjlUb46q1JfXjSc+klMwC6+JilIVxo8QuQKm67ARQcPaMhGAakaUP0fQmjuVx2KRsW+G2iOt4250pScMRmxBqwGrH8O3QxxVKIp4OedyINFA9bMdzgnPDOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/ZbAR/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BC0C4CED1;
	Wed, 29 Jan 2025 23:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192508;
	bh=cBJ8PxMcIwEKwl7X0NV5hUIWYkaTtpL/IAwWeTn1h54=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=X/ZbAR/HwUkyDurvsXxlvMlBOUDb532X6pT2O8cPZ2ZUForRN2YP5E3HDCR1lUBRP
	 xTihA5H0wTa1s8g2gVXhfUQ3zw9Ulp+4TCkzspa6XgWjwDqxhPbKTZ7R9XJaThOnMj
	 ry+v5TyEcXqNbtvIS5ch/86vEXQ0hDnDS0GtRjcJxwykukRVzr2caxjvniTVOu4aeJ
	 Q9iMQa/zsqThpyrMJcKmXk5iCQ3Vmbr4lwj6EIuGbyz+XT1++0onLS1HEe5cV3uxpp
	 44/3OMVA7N0lH2DpZS+4Sk5Ki0GRVFKGzmHnhN41MGkotq1F8QGYCtlg0gb9LwyVFM
	 GOS9AZvSWSeNw==
Message-ID: <cc1b1c21-94c2-4f3b-a51b-93c5dcdcde87@kernel.org>
Date: Wed, 29 Jan 2025 23:15:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next] bpftool: Fix readlink usage in get_fd_type
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250129071857.75182-1-vmalik@redhat.com>
Content-Language: en-GB
In-Reply-To: <20250129071857.75182-1-vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-01-29 08:18 UTC+0100 ~ Viktor Malik <vmalik@redhat.com>
> The `readlink(path, buf, sizeof(buf))` call reads at most sizeof(buf)
> bytes and *does not* append null-terminator to buf. With respect to
> that, fix two pieces in get_fd_type:
> 
> 1. Change the truncation check to contain sizeof(buf) rather than
>    sizeof(path).
> 2. Append null-terminator to buf.
> 
> Reported by Coverity.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

Nice, thank you!

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Reviewed-by: Quentin Monnet <qmo@kernel.org>

