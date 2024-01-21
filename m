Return-Path: <bpf+bounces-19973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A92F8354B7
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 07:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB291F237AA
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F836137;
	Sun, 21 Jan 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EmXikj+q"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25832EB19
	for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705818286; cv=none; b=HkN7BBR3ZDfPf4eG3U5fls8vm1zt4mpVgS4R3oZ3G6Q64mRRYTbKncuCqBPfRgE4vhGy9WfjCcgnMxoCpokvn6y8sE0z2vPPoRb4U0tJLcolq5EiYBs89LOsLnooarrTlzW9RREWNMBsMDw9yl6DWAxbslpObNhgcPq0qlP2Rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705818286; c=relaxed/simple;
	bh=+tMdzBe0Utis3WDB5XfpHdGsAriSU2N3LM2K+Q5XeKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoYoB+IACePGCJ5NjTlsM4m43zLbIiDhDUIyhGo+MFaFQzynzBtLlvKaMWoeQSy//HYrTJo7TZ1zT2ub4HU2AGg6EHBidUkpgKCWSosZ08I03B+2Acg2J6X8N0J2szDtt0XL4HbwTA+0W+XZQXK6b+7DP5eLtD32BZS+UlaG0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EmXikj+q; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82363db5-7a78-4dc6-b0aa-4bc44152d77b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705818281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tMdzBe0Utis3WDB5XfpHdGsAriSU2N3LM2K+Q5XeKQ=;
	b=EmXikj+qb/FKBVAvD2r/8pH6ZM8MNuIxjnuDCrO8GL13I+uvnGOmT+Q9i7PdXZ6E20id6V
	yVNCCKVlSeiruFPA++MYJ3buhNmce90xTkGgYZqOgvSvY6wWsqn5qIKyPzZMz1ysPIDE5F
	VVdaoqK04pDpi2tbqxuSiey+Ix74+K0=
Date: Sat, 20 Jan 2024 22:24:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: call dup2() syscall directly
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240119210201.1295511-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240119210201.1295511-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/19/24 1:02 PM, Andrii Nakryiko wrote:
> We've ran into issues with using dup2() API in production setting, where
> libbpf is linked into large production environment and ends up calling
> uninteded custom implementations of dup2(). These custom implementations
> don't provide atomic FD replacement guarantees of dup2() syscall,
> leading to subtle and hard to debug issues.
>
> To prevent this in the future and guarantee that no libc implementation
> will do their own custom non-atomic dup2() implementation, call dup2()
> syscall directly with syscall(SYS_dup2).
>
> Note that some architectures don't seem to provide dup2 and have dup3
> instead. Try to detect and pick best syscall.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


